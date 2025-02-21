// #define TAGS
#include "scripts\gargoyle.as"

void InitModule() {
  InitGargoyle();

  monsterId = '703';

  // Overrides
  hierarchy      = "char\\demon_hammer_gargoyle.cug";
  boss_hierarchy = hierarchy;

  star_scale = 0.95f;

  flying_speed         = 1.5f;
  flying_speed_on_move = flying_speed + 1.0f;

  flying_noise_speed         = 3.0f;
  flying_noise_strenght      = 1.0f;
  flying_noise_strenght_move = flying_noise_strenght + 1;

  winged_flap_speed         = fly_wing_coefficient / flying_speed;
  winged_flap_speed_on_move = fly_wing_coefficient / flying_speed_on_move;

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
