// #define TAGS
#include "scripts\gargoyle.as"

void InitModule() {
  InitGargoyle();

  monsterId = '701';

  // Overrides
  hierarchy      = "char\\demon_petit_gargoyle.cug";
  boss_hierarchy = hierarchy;

  death_fx = "effects\\monst_gargoyle_small_death.cug";

  star_scale = 0.7f;

  flying_speed         = 4.0f;
  flying_speed_on_move = flying_speed + 1.0f;

  flying_noise_speed         = 6.0f;
  flying_noise_strenght      = 4.0f;
  flying_noise_strenght_move = flying_noise_strenght * 2;

  winged_flap_speed         = fly_wing_coefficient / flying_speed;
  winged_flap_speed_on_move = fly_wing_coefficient / flying_speed_on_move;
  winged_fade_time          = 0.0f;

  sound_option_pitch = 1.5f;

  InitSounds();
  InitHierarchy();
}

class Monster : Gargoyle {}
