// #define TAGS
#include "scripts\zombie.as"

void InitModule() {
  InitZombie();

  monsterId = '610';

  // Overrides
  hierarchy      = "char\\zombie_elemental_corpse.cug";
  boss_hierarchy = hierarchy;

  appear_fx = "effects\\monst_elemental_zombie_appear.cug";

  poison_death_fx = "effects\\monst_zombie_big_exp.cug";
  ice_death_fx    = "effects\\monst_big_ice_death.cug";
  fire_death_fx   = "effects\\monst_big_fire_death.cug";

  disappear_preset_CrashScaleMax = 1.3f;
  disappear_preset_CrashScaleMin = 1.0f;

  walk_mover_multiplier = 1.0f;

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

class Monster : Zombie {};
