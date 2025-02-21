// #define TAGS
#include "scripts\zombie.as"

void InitModule() {
  InitZombie();

  monsterId = '611';

  hierarchy          = "char\\zombie_voracious_corpse.cug";
  boss_hierarchy     = hierarchy;
  attack_jump_length = 45.0f;

  poison_death_fx = "effects\\monst_zombie_big_exp.cug";
  ice_death_fx    = "effects\\monst_big_ice_death.cug";
  fire_death_fx   = "effects\\monst_big_fire_death.cug";

  appear_preset_speed_mult = 3.5f;

  disappear_preset_CrashScaleMax = 1.2f;
  disappear_preset_CrashScaleMin = 0.5f;

  walk_mover_multiplier = 0.7f;


  sound_land = array <string> = { "sound_bod\\monst_misc\\land_big" };

  sound_trigger_boss = array <string> = { "sound_bod\\zombie\\zomb_v3_boss_trig" };

  InitSounds();
  InitHierarchy();
}

class Monster : Zombie {}
