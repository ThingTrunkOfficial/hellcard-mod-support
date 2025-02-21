#include "scripts\monster_base.as"


void InitModule() {
  InitMonsterBase();
  hierarchy      = "3350421454\\hierarchy\\skeleton_captain_hierarchy.cug";
  boss_hierarchy = hierarchy;

  sound_attack     = array <string> = { "sound_bod\\skel\\skl_v2_trig" }; 
  sound_damage     = array <string> = { "sound_bod\\skel\\skl_hit1", "sound_bod\\skel\\skl_hit2" }; 
  sound_appear     = array <string> = { "sound_bod\\skel\\skl_axes" };


  InitSounds();
  InitHierarchy();
}


class Monster: MonsterBase {};