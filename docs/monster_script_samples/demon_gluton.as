// #define TAG
#include "scripts\demon.as"

void InitModule() {
  InitDemon();

  monsterId = '108';

  hierarchy      = "char\\demon_gluton.cug";
  boss_hierarchy = hierarchy;

  attack_jump_length    = 35.0f;
  star_scale            = 0.85f;
  idle_mover_multiplier = 0.5f;

  appear_fx     = "effects\\monst_demon_appear_coal_big.cug";
  death_fx      = "effects\\monst_big_fire_death.cug";
  fire_death_fx = death_fx;

  demon_appear_speed_multiplier = 0.8f;

  winged_flap_speed = 0.4f;
  winged_fade_time  = 0.1f;

  caster_nonmagic = true;

  footstep_sound_preset = BDST_FOOTSTEP_HOOF;

  sound_land = array <string> = { "sound_bod\\monst_misc\\land_big" };

  // sound_death_boss      = sound_death;
  // sound_attack_boss     = sound_attack;
  // sound_damage_boss     = sound_damage;
  // sound_trigger_boss    = sound_trigger;
  // sound_crit_jump_boss  = sound_crit_jump;
  // sound_scare_jump_boss = sound_scare_jump;
  // sound_cast_start_boss = sound_cast_start;

  InitSounds();
  InitHierarchy();
}

class Monster : Demon {
}
