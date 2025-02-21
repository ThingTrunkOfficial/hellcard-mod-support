#include "scripts\skeleton.as"

void InitModule() {
  InitSkeleton();

  monsterId = '402';

  hierarchy      = "char\\skeleton_shielded_skeleton.cug";
  boss_hierarchy = hierarchy;

  caster_nonmagic = true;

  boss_scale = 1.35f;

  footstep_sound_preset = BDST_FOOTSTEP_ARMORED;

  sound_add_death = array <string> = { "sound_bod\\skel\\skl_arm_d1", "sound_bod\\skel\\skl_arm_d2" };

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

class Monster : Skeleton {}
