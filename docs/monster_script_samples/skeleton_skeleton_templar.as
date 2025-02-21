#include "scripts\skeleton.as"

void InitModule() {
  InitSkeleton();

  monsterId = '407';

  hierarchy      = "char\\skeleton_skeleton_templar.cug";
  boss_hierarchy = hierarchy;

  appear_preset_speed_mult = 3.0f;

  appear_fx = "effects\\monst_big_skel_appear.cug";

  caster_nonmagic = true;

  boss_scale = 1.35f;

  footstep_sound_preset = BDST_FOOTSTEP_ARMORED;

  sound_death      = array <string> = { "sound_bod\\skel\\skl_v2_d1", "sound_bod\\skel\\skl_v2_d2" };
  sound_attack     = array <string> = { "sound_bod\\skel\\skl_v2_att1", "sound_bod\\skel\\skl_v2_att2" };
  sound_damage     = array <string> = { "sound_bod\\skel\\skl_v2_dmg1", "sound_bod\\skel\\skl_v2_dmg2" };
  sound_trigger    = array <string> = { "sound_bod\\skel\\skl_v2_trig" };
  sound_scare_jump = array <string> = { "sound_bod\\skel\\skl_v2_scared" };

  sound_add_death  = array <string> = { "sound_bod\\skel\\skl_arm_d1", "sound_bod\\skel\\skl_arm_d2" };

  sound_land = array <string> = { "sound_bod\\monst_misc\\land_big" };

  sound_attack_boss     = sound_attack;
  sound_damage_boss     = sound_damage;
  sound_scare_jump_boss = sound_scare_jump;

  InitSounds();
  InitHierarchy();
}

class Monster : Skeleton {}

