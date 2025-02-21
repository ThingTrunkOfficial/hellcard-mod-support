#include "scripts\skeleton.as"

void InitModule() {
  InitSkeleton();

  monsterId = '406';

  hierarchy      = "char\\skeleton_cool_skeleton.cug";
  boss_hierarchy = hierarchy;

  caster_nonmagic = true;

  boss_scale = 1.35f;

  footstep_sound_preset = BDST_FOOTSTEP_ARMORED;

  sound_add_death = array <string> = { "sound_bod\\skel\\skl_arm_d1", "sound_bod\\skel\\skl_arm_d2" };

  InitSounds();
  InitHierarchy();
}

class Monster : Skeleton {}
