#define GHOST
#include "scripts\monster_base.as"

f32 ghost_wobble_speed;
f32 ghost_wobble_power;

void InitGhost() {
  InitMonsterBase();

  ghost_wobble_speed = 1.0f;
  ghost_wobble_power = 7.0f;

  attack_jump_length = 45.0f;
  star_scale         = 0.7f;

  death_fx      = "effects\\monst_ghost_dissapear.cug";
  fire_death_fx = "effects\\monst_ghost_f_dissapear.cug";

  appear_fx = "effects\\monst_ghost_appear.cug";

  effect_offset = Point2D_f32(0.0f, 30.0f);

  disappear_preset = HGEP_FROZEN_DISAPPEAR;

  flying_speed         = 0.7f;
  flying_speed_on_move = 1.0f;

  flying_noise_strenght      = 3.0f;
  flying_noise_strenght_move = 2.0f;

  flying_noise_speed = 0.5f;

  boss_death_fx_shrapnel_decal  = DECAL_ICE;
  boss_death_fx_shrapnel_effect = "effects\\monst_boss_trail_ice.cug";
  boss_death_fx_shrapnel_amount = 15;

  boss_death_fx_shrapnel_sprite_range = array <u32> = { 297, 303 };
  boss_death_fx_shrapnel_use_true_dt  = false;

  boss_disappear_preset = HGEP_ZOMBIE_DISAPPEAR;

  boss_death_fx = "effects\\monst_boss_exp_ice.cug";

  sound_hide       = array <string> = { "sound_bod\\ghost\\ghost_hide" };
  sound_death      = array <string> = { "sound_bod\\ghost\\ghost_v2_d1", "sound_bod\\ghost\\ghost_v2_d2" };
  sound_appear     = array <string> = { "sound_bod\\ghost\\ghost_appear1" };
  sound_unhide     = array <string> = { "sound_bod\\ghost\\ghost_unhide" };
  sound_attack     = array <string> = { "sound_bod\\ghost\\ghost_v2_att1", "sound_bod\\ghost\\ghost_v2_att2" };
  sound_damage     = array <string> = { "sound_bod\\ghost\\ghost_v2_dmg1", "sound_bod\\ghost\\ghost_v2_dmg2" };
  sound_trigger    = array <string> = { "sound_bod\\ghost\\ghost_v2_trig" };
  sound_disappear  = array <string> = { "sound_bod\\ghost\\ghost_hide" };
  sound_add_death  = array <string> = { "sound_bod\\ghost\\ghost_d1", "sound_bod\\ghost\\ghost_d2" };
  sound_cast_start = array <string> = { "sound_bod\\ghost\\ghost_v2_incant" };
  sound_scare_jump = array <string> = { "sound_bod\\ghost\\ghost_v2_scared" };

  sound_death_boss      = array <string> = { "sound_bod\\ghost\\ghost_v2_boss_d" };
  sound_attack_boss     = sound_attack;
  sound_damage_boss     = sound_damage;
  sound_trigger_boss    = array <string> = { "sound_bod\\ghost\\ghost_v2_boss_trig" };
  sound_crit_jump_boss  = sound_crit_jump;
  sound_scare_jump_boss = sound_scare_jump;
  sound_cast_start_boss = sound_cast_start;
}

class Ghost : MonsterBase, Flying {
  void OnEvent(BodMonsterObj @monst, BodMonsterEvent evt) {
    switch (evt) {
    case BME_GHOST_HIDE:
      PlaySound(sound_hide_arr[0], monst.GetPos());
      break;

    case BME_GHOST_UNHIDE:
      PlaySound(sound_unhide_arr[0], monst.GetPos());
      break;
    }

    MonsterBase::OnEvent(monst, evt);
  }

  bool InitMonster(BodMonsterObj @monst, BodMonsterState state, u8 dir) {
    // LOG('SCRIPT: Ghost Init');
    MonsterBase::InitMonster(monst, state, dir);

    this.AddFlyMover(monst);

    monst.GetHierInst().SetWobbleEnabled(true);
    monst.GetHierInst().SetWobbleSpeed(ghost_wobble_speed);
    monst.GetHierInst().SetWobblePower(ghost_wobble_power);

    return true;
  }

  bool OnEnterState(BodMonsterObj @monst, BodMonsterState prev_state, BodMonsterState new_state, int param) {
    this.Flying_OnEnterState(monst, prev_state, new_state);
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

    PlayEventSound(DEATH, monst);

    if (monst.IsBoss()) {
      p = this.bossDeathFx(monst, p);

      this.shrapnelFx(monst);
    } else {
      PlaySound(RndFrom(sound_add_death_arr), monst.GetPos()); // non standard so no PlayEventSound

      if (PointInFire(monst.GetPos())) {
        death_fx = fire_death_fx;
      }
      p = this.defaultDeathFx(monst, p);
    }
  }

  GenericEffectParams defaultDeathFx(BodMonsterObj @monst, GenericEffectParams p) {
    // Special Ghost Death Pirouette
    f32         effect_time = 0.7f;
    Point2D_f32 accel       = Point2D_f32(0.f, -500.f);
    bool        cw          = (monst.Rand(0, 1) == 0);
    u8          rot         = 48;

    monst.InsertAccelMover(accel, effect_time); // this works...
    // SetMover(monst, CreateAccelMover(accel, effect_time), 333); // ...this doesnt
    SetMover(monst, CreateRotateMover(rot, cw, effect_time), 334);
    SetMover(monst, CreateFadeMover(false, effect_time), 335);

    BCCGDungeon::Get().AddFxToObj(death_fx, monst, true, true).SetEmitterOffset(effect_offset);

    return p;
  }

  // Ghost special death fx happens for every death type other than boss
  // Fire death has its own particle effect // TODO: refactor MonsterBase::*DeathFx methods to be more interchangable
  GenericEffectParams fireDeathFx(BodMonsterObj @monst, GenericEffectParams p) {
    death_fx = fire_death_fx;
    return this.defaultDeathFx(monst, p);
  }

  // Ghost special death fx happens for every death type other than boss
  GenericEffectParams poisonDeathFx(BodMonsterObj @monst, GenericEffectParams p) {
    return this.defaultDeathFx(monst, p);
  }

  // Ghost special death fx happens for every death type other than boss
  GenericEffectParams iceDeathFx(BodMonsterObj @monst, GenericEffectParams p) {
    return this.defaultDeathFx(monst, p);
  }
}
