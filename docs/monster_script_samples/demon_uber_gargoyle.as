// #define TAGS
#include "scripts\gargoyle.as"

void InitModule() {
  InitGargoyle();

  monsterId = '704';

  hierarchy      = "char\\demon_uber_gargoyle.cug";
  boss_hierarchy = hierarchy;

  death_fx      = "effects\\monst_gargoyle_fire_death.cug";
  boss_death_fx = death_fx;

  star_scale = 0.7f;
  boss_scale = 1.3f;

  flying_speed         = 1.0f;
  flying_speed_on_move = flying_speed + 1.0f;

  flying_noise_speed         = 3.0f;
  flying_noise_strenght      = 1.0f;
  flying_noise_strenght_move = flying_noise_strenght + 1;

  // must be set after flying speeds TODO: move to Winged
  winged_flap_speed         = fly_wing_coefficient / flying_speed;
  winged_flap_speed_on_move = fly_wing_coefficient / flying_speed_on_move;

  sound_option_pitch = 0.7f;

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

class Monster : Gargoyle {}
