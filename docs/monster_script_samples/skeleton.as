#define SKELETON
#include "scripts\monster_base.as"

string boss_pre_exp_fx = "effects\\monst_boss_load_skeleton.cug";

void InitSkeleton() {
  InitMonsterBase();

  idle_mover_multiplier = 0.5f;

  appear_fx        = "effects\\monst_skel_appear.cug";
  death_fx         = "effects\\monst_skel_death.cug";
  disappear_preset = HGEP_SKELETON_DISAPPEAR;

  boss_death_fx = "effects\\monst_boss_exp_skeleton.cug";

  boss_death_fx_shrapnel_effect       = "effects\\monst_boss_trail_skeleton.cug";
  boss_death_fx_shrapnel_amount       = 15;
  boss_death_fx_shrapnel_sprite_range = array <u32> = { 280, 289 };
  boss_death_fx_shrapnel_use_true_dt  = false;

  footstep_sound_preset = BDST_FOOTSTEP_SKELETON;

  sound_death      = array <string> = { "sound_bod\\skel\\skl_v1_d1", "sound_bod\\skel\\skl_v1_d2" };
  sound_appear     = array <string> = { "sound_bod\\skel\\skl_appear" };
  sound_attack     = array <string> = { "sound_bod\\skel\\skl_v1_att1", "sound_bod\\skel\\skl_v1_att2" };
  sound_damage     = array <string> = { "sound_bod\\skel\\skl_v1_dmg1", "sound_bod\\skel\\skl_v1_dmg2" };
  sound_trigger    = array <string> = { "sound_bod\\skel\\skl_v1_trig" };
  sound_add_death  = array <string> = { "sound_bod\\skel\\skl_d1", "sound_bod\\skel\\skl_d2" };
  sound_scare_jump = array <string> = { "sound_bod\\skel\\skl_v1_scared" };

  sound_death_boss      = array <string> = { "sound_bod\\skel\\skl_boss_d" };
  sound_attack_boss     = array <string> = { "sound_bod\\skel\\skl_v3_att1", "sound_bod\\skel\\skl_v3_att2" };
  sound_damage_boss     = array <string> = { "sound_bod\\skel\\skl_v3_dmg1", "sound_bod\\skel\\skl_v3_dmg2" };
  sound_trigger_boss    = array <string> = { "sound_bod\\skel\\skl_v3_boss_trig" };
  sound_crit_jump_boss  = array <string> = { "sound_bod\\skel\\skl_v3_jump" };
  sound_scare_jump_boss = array <string> = { "sound_bod\\skel\\skl_v3_scared" };
  sound_cast_start_boss = array <string> = { "sound_bod\\skel\\skl_v3_incant" };
}

class Skeleton : MonsterBase {
  bool OnEnterState(BodMonsterObj @monst, BodMonsterState prev_state, BodMonsterState new_state, int param) {
    if (monst.IsBoss()) {
      if (new_state == DMS_DEAD_PRE_EXP) {
        BCCGDungeon::Get().AddFxToObj(boss_pre_exp_fx, monst, true, true).SetEmitterOffset(effect_offset);
      }
    }
    return MonsterBase::OnEnterState(monst, prev_state, new_state, param);
  }
}
