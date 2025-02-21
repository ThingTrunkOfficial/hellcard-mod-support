#define EVIL
#include "scripts\monster_base.as"

Color c_multiply;
Color c_additive;

f32 evil_wobble_speed;
f32 evil_wobble_power;

void InitEvil() {
  InitMonsterBase();

  c_multiply = Color(255, 180, 200, 190); // rgba(64, 64, 64, 196)
  c_additive = Color(64, 64, 255, 255);

  evil_wobble_speed = 1.0f;
  evil_wobble_power = 7.0f;

  appear_fx = "effects\\monst_demon_appear_coal.cug";
  disappear_preset = HGEP_FROZEN_DISAPPEAR;

  // BOSS DEFAULTS
  boss_scale        = 1.0f;

  boss_death_fx_shrapnel_decal  = DECAL_ICE;
  boss_death_fx_shrapnel_effect = "effects\\monst_boss_trail_ice.cug";
  boss_death_fx_shrapnel_amount = 15;

  boss_death_fx_shrapnel_sprite_range = array <u32> = { 297, 303 };
  boss_death_fx_shrapnel_use_true_dt  = false;

  death_fx = "effects\\monst_boss_exp_ice.cug";

  boss_disappear_preset = HGEP_ZOMBIE_DISAPPEAR;
  
  sound_death      = array <string> = { "sound_bod\\demon\\dmn_v3_d1", "sound_bod\\demon\\dmn_v3_d2" };
  sound_appear     = array <string> = { "sound_bod\\demon\\dmn_appear" };
  sound_attack     = array <string> = { "sound_bod\\demon\\dmn_v3_att1", "sound_bod\\demon\\dmn_v3_att2" };
  sound_damage     = array <string> = { "sound_bod\\demon\\dmn_v3_dmg1", "sound_bod\\demon\\dmn_v3_dmg2" };
  sound_trigger    = array <string> = { "sound_bod\\demon\\dmn_v3_trig" };
  sound_crit_jump  = array <string> = { "sound_bod\\demon\\dmn_v3_jump" };
  sound_add_death  = array <string> = { "sound_bod\\monst_misc\\fire_death" };
  sound_scare_jump = array <string> = { "sound_bod\\demon\\dmn_v3_scared" };
  sound_cast_start = array <string> = { "sound_bod\\demon\\dmn_v3_incant" };

  sound_unhide = sound_appear;

  sound_death_boss      = array <string> = { "sound_bod\\demon\\dmn_v3_boss_d" };
  sound_attack_boss     = sound_attack;
  sound_damage_boss     = sound_damage;
  sound_trigger_boss    = array <string> = { "sound_bod\\demon\\dmn_v3_boss_trig" };
  sound_crit_jump_boss  = sound_crit_jump;
  sound_scare_jump_boss = sound_scare_jump;
  sound_cast_start_boss = sound_cast_start;

  boss_death_fx         = "effects\\monst_big_fire_death.cug";
}

class Evil : MonsterBase, Caster {
	Evil(){
	}
  
  bool InitMonster(BodMonsterObj @monst, BodMonsterState state, u8 dir) {
    MonsterBase::InitMonster(monst, state, dir);

    monst.GetHierInst().InsertMover(CreateColorizeMover(c_multiply, c_additive, -1.f, 0, 0));

    monst.GetHierInst().SetWobbleEnabled(true);
    monst.GetHierInst().SetWobbleSpeed(evil_wobble_speed);
    monst.GetHierInst().SetWobblePower(evil_wobble_power);

    return true;
  }

  bool OnEnterState(BodMonsterObj @monst, BodMonsterState prev_state, BodMonsterState new_state, int param) {
    if (new_state == DMS_DEAD_PRE_EXP) {
      monst.GetHierInst().InsertMover(CreateColorizeMover(c_multiply, c_additive, -1.f, 0, 0));
    }
    return MonsterBase::OnEnterState(monst, prev_state, new_state, param);
  }

  void appearFx(BodMonsterObj @monst, GenericEffectParams p) {
    p.Preset(appear_preset);
    p.m_EaseX = appear_preset_easeX;
    p.m_EaseY = appear_preset_easeY;

    PlayEventSound(APPEAR, monst);
    monst.AppearFromGround(appear_fx, 1.2f);
  }

  void deathFx(BodMonsterObj @monst, GenericEffectParams p) {

    p = this.bossDeathFx(monst, p);

    PlayEventSound(EXPLODE, monst);
    
    this.shrapnelFx(monst);
    BCCGDungeon::Get().AddFxToObj(death_fx, monst, true, true).SetEmitterOffset(effect_offset);
    this.Caster_deathFx(monst);
  }

  GenericEffectParams bossDeathFx(BodMonsterObj @monst, GenericEffectParams p) {
    
    f32         effect_time = 0.7f;
    Point2D_f32 accel       = Point2D_f32(0.f, -500.f);
    bool        cw          = (monst.Rand(0, 1) == 0);
    u8          rot         = 45;

    monst.InsertAccelMover(accel, effect_time); // this works...
    // SetMover(monst, CreateAccelMover(accel, effect_time), 333); // ...this doesnt
    SetMover(monst, CreateRotateMover(rot, cw, effect_time), 334);
    SetMover(monst, CreateFadeMover(false, effect_time), 335);

    // p.Preset(boss_disappear_preset);
    // p.m_EaseX = boss_disappear_preset_easeX;
    // p.m_EaseY = boss_disappear_preset_easeY;

    return p;
  }
}
