#define GOAT
#include "scripts\monster_base.as"

enum goat_timer { PLAY_DEATH_ANIMATION, LAND_FX };

void InitGoat() {
  InitMonsterBase();

  idle_mover_multiplier = 0.5f;

  death_fx = "effects\\monst_goat_death.cug";

  disappear_preset = HGEP_GOAT_DISAPPEAR;

  boss_death_fx_shrapnel_scale       = 0.8f;
  boss_death_fx_shrapnel_amount      = 15;
  boss_death_fx_shrapnel_use_true_dt = false;

  footstep_sound_preset = BDST_FOOTSTEP_HOOF;

  sound_idle       = array <string> = { "sound_bod\\goat\\goat_v_bleat1", "sound_bod\\goat\\goat_v_bleat2" };
  sound_death      = array <string> = { "sound_bod\\goat\\goat_v_d1", "sound_bod\\goat\\goat_v_d2" };
  sound_attack     = array <string> = { "sound_bod\\goat\\goat_v_att1", "sound_bod\\goat\\goat_v_att2" };
  sound_appear     = array <string> = { "sound_bod\\goat\\goat_appear" };
  sound_unpack     = array <string> = { "sound_bod\\goat\\goat_unpack" };
  sound_damage     = array <string> = { "sound_bod\\goat\\goat_v_hit1", "sound_bod\\goat\\goat_v_hit2", "sound_bod\\goat\\goat_v_hit3" };
  sound_crit_jump  = array <string> = { "sound_bod\\goat\\goat_trig1", "sound_bod\\goat\\goat_trig2" };
  sound_add_death  = array <string> = { "sound_bod\\monst\\monst_fall1", "sound_bod\\monst\\monst_fall2" };
  sound_scare_jump = array <string> = { "sound_bod\\goat\\goat_v_scared" };

  sound_trigger = sound_crit_jump;

  sound_attack_boss     = sound_attack;
  sound_damage_boss     = sound_damage;
  sound_crit_jump_boss  = sound_crit_jump;
  sound_scare_jump_boss = sound_scare_jump;
  sound_cast_start_boss = sound_cast_start;

  sound_death_boss   = array <string> = { "sound_bod\\goat\\goat_v_boss_d" };
  sound_trigger_boss = array <string> = { "sound_bod\\goat\\goat_v_boss_trig" };
}

class Goat : MonsterBase {
  bool OnEnterState(BodMonsterObj @monst, BodMonsterState prev_state, BodMonsterState new_state, int param) {
    if (new_state == DMS_IDLE) {
      if (param == 666) {
        PlayEventSound(IDLE, monst); // BLEET
      }
    }
    return MonsterBase::OnEnterState(monst, prev_state, new_state, param);
  }

  void appearFx(BodMonsterObj @monst, GenericEffectParams p) {
    monst.AppearCustom(CreateBounceAppearMover(200.f));
    monst.GetHierInst().InsertMover(CreateRotateMover(16, (monst.Rand(0, 1) == 0), 0.75f));
    monst.ScheduleTimerCall(0.3f, LAND_FX);
    PlayEventSound(APPEAR, monst);
  }

  /**
   * This entire function is overwritten here to let generic death effect
   * play with a delay and let elemental death effects keep their default setups.
   */
  void deathFx(BodMonsterObj @monst, GenericEffectParams p) {
    bool defaultDeath = true; // assume default death effect

    PlayEventSound(DEATH, monst);

    if (monst.IsBoss()) {
      p = this.bossDeathFx(monst, p);

      this.shrapnelFx(monst);
      defaultDeath = false; // death wasn't default
    } else {

      if (monst.IsFrozen()) {
        p            = this.iceDeathFx(monst, p);
        defaultDeath = false; // death wasn't default
      } else if (PointInFire(monst.GetPos())) {
        p            = this.fireDeathFx(monst, p);
        defaultDeath = false;       // death wasn't default
      }
      if (monst.IsPoison()) {
        /**
         * NOTE: this checks if monsters hearts are of POISON type not if it is
         *  POISONED. I use this to check if monster should explode.
         */
        p.Preset(HGEP_ZOMBIE_DISAPPEAR);
        p            = this.poisonDeathFx(monst, p);
        defaultDeath = false; // death wasn't default
      }
    }

    /**
     * death wasn't default and Generic Effect Preset was set, GenericEffect
     * can be called safely
     * otherwise play special goat death effec with a delay
     */
    if (!defaultDeath) {
      monst.GenericEffect(p);
    } else {
      this.goat_defaultDeathFx(monst);
    }
  }

  void goat_defaultDeathFx(BodMonsterObj @monst) {
    float v_X         = monst.GetPos().m_X - BCCGDungeon::Get().GetCamPos().m_X;
    bool  right       = v_X > 0;
    bool  cw          = (monst.Rand(0, 1) == 0);
    u8    rot         = monst.Rand(20, 32);
    f32   effect_time = 0.75f * monst.RandFloat(0.9f, 1.1f);

    monst.InsertFallDownMover(120.f, right, effect_time);
    monst.GetHierInst().InsertMover(CreateRotateMover(rot, cw, effect_time));

    monst.ScheduleTimerCall(effect_time - 0.1f, PLAY_DEATH_ANIMATION);
  }

  void OnTimer(BodMonsterObj @monst, int id) {
    switch (id) {
    case PLAY_DEATH_ANIMATION:
    {
      Point2D_f32 offset = (id == 1) ? Point2D_f32(50.f, 25.f) : Point2D_f32(-50.f, 0.f);
      PlaySound(RndFrom(sound_add_death_arr), monst.GetPos()); // non standard so no PlayEventSound

      GenericEffectParams p;
      p.Preset(disappear_preset);
      p.m_Flags      |= HGEF_SCALING;
      p.m_SpanMin     = 1.0f;
      p.m_SpanMax     = 1.3f;
      p.m_ScaleStart  = 0.1f;
      p.m_ScaleEnd    = 1.0f;
      p.m_ScaleEndVal = 0.5f;

      BCCGDungeon::Get().AddFxToObj(death_fx, monst, true, true).SetEmitterOffset(offset);
      monst.GenericEffect(p);
    }
    break;

    case LAND_FX:
      landFx(monst);
      break;
    }
  }
}
