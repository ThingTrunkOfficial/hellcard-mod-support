#include "scripts\goat.as"

void InitModule() {
  InitGoat();

  monsterId = '201';

  hierarchy      = "char\\goat_goatman.cug";
  boss_hierarchy = hierarchy;

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

class Monster : Goat {}
