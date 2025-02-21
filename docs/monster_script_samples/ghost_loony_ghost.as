// #define TAG
#include "scripts\ghost.as"

void InitModule() {
  InitGhost();

  monsterId = '301';

  hierarchy      = "char\\ghost_loony_ghost.cug";
  boss_hierarchy = hierarchy;

  fire_death_fx = "effects\\monst_g_fire_death.cug";

  caster_nonmagic = true;

  sound_death      = array <string> = { "sound_bod\\ghost\\ghost_v1_d1", "sound_bod\\ghost\\ghost_v1_d2" };
  sound_attack     = array <string> = { "sound_bod\\ghost\\ghost_v1_att1", "sound_bod\\ghost\\ghost_v1_att2" };
  sound_damage     = array <string> = { "sound_bod\\ghost\\ghost_v1_dmg1", "sound_bod\\ghost\\ghost_v1_dmg2" };
  sound_trigger    = array <string> = { "sound_bod\\ghost\\ghost_v1_trig" };
  sound_scare_jump = array <string> = { "sound_bod\\ghost\\ghost_v1_scared" };

  sound_death_boss      = sound_death;
  sound_attack_boss     = sound_attack;
  sound_damage_boss     = sound_damage;
  sound_trigger_boss    = sound_trigger;
  sound_scare_jump_boss = sound_scare_jump;

InitSounds();
InitHierarchy();
}

class Monster : Ghost {}
