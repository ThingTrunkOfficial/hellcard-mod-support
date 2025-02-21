#include "scripts\skeleton.as"

void InitModule() {
  InitSkeleton();

  monsterId = '409';

  hierarchy      = "char\\skeleton_whopper.cug";
  boss_hierarchy = hierarchy;

  appear_fx = "effects\\monst_big_skel_appear.cug";
  death_fx  = "effects\\monst_big_skel_death.cug";

  appear_preset_speed_mult = 3.0f;

  boss_scale = 1.2f;

  disappear_preset_CrashScaleMax = 1.3f;
  disappear_preset_CrashScaleMin = 1.0f;

  sound_death      = array <string> = { "sound_bod\\skel\\skl_v2_d1", "sound_bod\\skel\\skl_v2_d2" };
  sound_attack     = array <string> = { "sound_bod\\skel\\skl_v2_att1", "sound_bod\\skel\\skl_v2_att2" };
  sound_damage     = array <string> = { "sound_bod\\skel\\skl_v2_dmg1", "sound_bod\\skel\\skl_v2_dmg2" };
  sound_trigger    = array <string> = { "sound_bod\\skel\\skl_v2_trig" };
  sound_crit_jump  = array <string> = { "sound_bod\\skel\\skl_v2_jump" };
  sound_scare_jump = array <string> = { "sound_bod\\skel\\skl_v2_scared" };

  sound_option_pitch = 0.7f;

  sound_land = array <string> = { "sound_bod\\monst_misc\\land_big" };

  sound_attack_boss     = sound_attack;
  sound_damage_boss     = sound_damage;
  sound_crit_jump_boss  = sound_crit_jump;
  sound_scare_jump_boss = sound_scare_jump;

  InitSounds();
  InitHierarchy();
}

class Monster : Skeleton {}
