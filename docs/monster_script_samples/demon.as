#define DEMON
#include "scripts\monster_base.as"

void InitDemon() {
  InitMonsterBase();

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

  demon_appear_speed_multiplier = 1.2f;

  // Overrides
  star_scale            = 0.85f;
  idle_mover_multiplier = 0.5f;

  winged_fade_time = 0.1f;

  fire_death_fx = "effects\\monst_fire_death.cug";
  ice_death_fx  = "effects\\monst_ice_death.cug";
  death_fx      = fire_death_fx;

  appear_fx = "effects\\monst_demon_appear_coal.cug";

  disappear_preset = HGEP_FIRE_DISAPPEAR;

  // BOSS DEFAULTS
  boss_scale        = 1.1f;

  boss_death_fx_shrapnel_effect = "effects\\monst_boss_trail_fire.cug";

  boss_death_fx_shrapnel_amount = 15;

  boss_death_fx_shrapnel_sprite_range = array <u32> = { 290, 296 };

  boss_death_fx_shrapnel_use_true_dt = true;

  boss_disappear_preset = HGEP_FIRE_DISAPPEAR;
  boss_death_fx         = "effects\\monst_big_fire_death.cug";
}

class Demon : MonsterBase, Winged {
  Demon() {
  }

  bool InitMonster(BodMonsterObj @monst, BodMonsterState state, u8 dir) {
    MonsterBase::InitMonster(monst, state, dir);
    return true;
  }

  bool OnEnterState(BodMonsterObj @monst, BodMonsterState prev_state, BodMonsterState new_state, int param) {
    this.Winged_OnEnterState(monst, prev_state, new_state);
    return MonsterBase::OnEnterState(monst, prev_state, new_state, param);
  }

  void appearFx(BodMonsterObj @monst, GenericEffectParams p) {
    MonsterBase::appearFx(monst, p);
    monst.AppearFromGround("effects\\monst_demon_appear.cug", demon_appear_speed_multiplier);
  }

  void OnTimer(BodMonsterObj @monst, int id) {
    this.Winged_OnTimer(monst, id);
  }
}
