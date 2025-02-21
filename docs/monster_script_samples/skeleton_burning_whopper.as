#include "scripts\skeleton.as"

void InitModule() {
  InitSkeleton();

  monsterId = '412';

  hierarchy      = "char\\skeleton_burning_whopper.cug";
  boss_hierarchy = hierarchy;

  appear_fx = "effects\\monst_big_skel_appear.cug";
  death_fx  = "effects\\monst_big_skel_death.cug";

  appear_preset_speed_mult = 3.0f;

  fire_death_fx   = "effects\\monst_big_fire_death.cug";
  ice_death_fx    = "effects\\monst_big_ice_death.cug";
  poison_death_fx = "effects\\monst_boss_exp_skeleton.cug";

  disappear_preset_CrashScaleMax = 1.3f;
  disappear_preset_CrashScaleMin = 1.0f;

  caster_fx_front = "effects\\monst_cast_n_fire_f.cug";
  caster_fx_back  = "effects\\monst_cast_n_fire_b.cug";

  sound_death      = array <string> = { "sound_bod\\skel\\skl_v2_d1", "sound_bod\\skel\\skl_v2_d2" };
  sound_attack     = array <string> = { "sound_bod\\skel\\skl_v2_att1", "sound_bod\\skel\\skl_v2_att2" };
  sound_damage     = array <string> = { "sound_bod\\skel\\skl_v2_dmg1", "sound_bod\\skel\\skl_v2_dmg2" };
  sound_trigger    = array <string> = { "sound_bod\\skel\\skl_v2_trig" };
  sound_crit_jump  = array <string> = { "sound_bod\\skel\\skl_v2_jump" };
  sound_add_death  = array <string> = { "sound_bod\\skel\\skl_arm_d1", "sound_bod\\skel\\skl_arm_d2" };
  sound_scare_jump = array <string> = { "sound_bod\\skel\\skl_v2_scared" };

  sound_land = array <string> = { "sound_bod\\monst_misc\\land_big" };

  sound_attack_boss     = sound_attack;
  sound_damage_boss     = sound_damage;
  sound_crit_jump_boss  = sound_crit_jump;
  sound_scare_jump_boss = sound_scare_jump;

  InitSounds();
  InitHierarchy();
}

class Monster : Skeleton {}
