#define ZOMBIE
#include "scripts\monster_base.as"

void InitZombie() {
  InitMonsterBase();

  idle_mover_multiplier = 0.5f;

  fire_death_fx = "effects\\monst_z_fire_death.cug";
  ice_death_fx  = "effects\\monst_ice_death.cug";

  death_fx = "effects\\toxic_boom.cug";

  appear_fx = "effects\\monst_zombie_appear.cug";

  attack_jump_length = 25.0f;

  disappear_preset = HGEP_ZOMBIE_DISAPPEAR;

  boss_scale        = 1.1f;

  boss_death_fx_shrapnel_decal  = DECAL_POISON;
  boss_death_fx_shrapnel_effect = "effects\\monst_boss_trail_zombie.cug";

  boss_death_fx_shrapnel_amount = 15;

  boss_death_fx_shrapnel_sprite_range = array <u32> = { 311, 317 };

  boss_death_fx_shrapnel_use_true_dt = false;

  boss_disappear_preset = HGEP_ZOMBIE_DISAPPEAR;
  boss_death_fx         = "effects\\monst_boss_exp_zombie.cug";

  footstep_sound_preset = BDST_FOOTSTEP_ZOMBIE;

  sound_death      = array <string> = { "sound_bod\\zombie\\zomb_v2_d1", "sound_bod\\zombie\\zomb_v2_d2" };
  sound_appear     = array <string> = { "sound_bod\\zombie\\zomb_appear" };
  sound_attack     = array <string> = { "sound_bod\\zombie\\zomb_v2_att1", "sound_bod\\zombie\\zomb_v2_att2" };
  sound_damage     = array <string> = { "sound_bod\\zombie\\zomb_v2_dmg1", "sound_bod\\zombie\\zomb_v2_dmg2" };
  sound_trigger    = array <string> = { "sound_bod\\zombie\\zomb_v2_trig" };
  sound_add_death  = array <string> = { "sound_bod\\zombie\\zomb_d1", "sound_bod\\zombie\\zomb_d2" };
  sound_crit_jump  = array <string> = { "sound_bod\\zombie\\zomb_v2_jump" };
  sound_scare_jump = array <string> = { "sound_bod\\zombie\\zomb_v2_scared" };
  sound_cast_start = array <string> = { "sound_bod\\zombie\\zomb_v1_incant" };

  sound_death_boss      = array <string> = { "sound_bod\\zombie\\zomb_v2_boss_d" };
  sound_attack_boss     = sound_attack;
  sound_damage_boss     = sound_damage;
  sound_trigger_boss    = array <string> = { "sound_bod\\zombie\\zomb_v2_boss_trig" };
  sound_crit_jump_boss  = sound_crit_jump;
  sound_scare_jump_boss = sound_scare_jump;
  sound_cast_start_boss = sound_cast_start;
}

class Zombie : MonsterBase {}
