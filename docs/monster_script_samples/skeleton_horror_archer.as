#include "scripts\skeleton.as"

void InitModule() {
  InitSkeleton();

  monsterId = '413';

  hierarchy      = "char\\skeleton_horror_archer.cug";
  boss_hierarchy = hierarchy;

  caster_nonmagic = true;

  sound_death      = array <string> = { "sound_bod\\skel\\skl_v1_d1", "sound_bod\\skel\\skl_v1_d2" };
  sound_damage     = array <string> = { "sound_bod\\skel\\skl_v1_dmg1", "sound_bod\\skel\\skl_v1_dmg2" };
  sound_trigger    = array <string> = { "sound_bod\\skel\\skl_v1_trig" };
  sound_add_death  = array <string> = { "sound_bod\\skel\\skl_d1", "sound_bod\\skel\\skl_d2" };
  sound_scare_jump = array <string> = { "sound_bod\\skel\\skl_v1_scared" };

  sound_damage_boss     = sound_damage;
  sound_scare_jump_boss = sound_scare_jump;

  InitSounds();
  InitHierarchy();
}

class Monster : Skeleton, Ranged {}
