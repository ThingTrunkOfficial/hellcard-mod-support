#include "scripts\goat.as"

void InitModule() {
  InitGoat();

  monsterId = '205';

  hierarchy      = "char\\goat_battering_goat.cug";
  boss_hierarchy = "char\\goat_battering_elite.cug";

  caster_nonmagic = true;

  walk_mover_multiplier = 1.5f;
  idle_mover_multiplier = 0.8f;

  sound_cast_start = array <string> = { "sound_bod\\goat\\goat_charge_cast" };

  // sound_death_boss      = sound_death;
  // sound_attack_boss     = sound_attack;
  // sound_damage_boss     = sound_damage;
  sound_trigger_boss = array <string> = { "sound_bod\\goat\\goat_boss_deathmetal" };
  // sound_crit_jump_boss  = sound_crit_jump;
  // sound_scare_jump_boss = sound_scare_jump;
  sound_cast_start_boss = sound_cast_start;
  
  InitSounds();
  InitHierarchy();
}

class Monster : Goat {}
