#include "scripts\skeleton.as"

void InitModule() {
  InitSkeleton();

  monsterId = '410';

  hierarchy      = "char\\skeleton_hyper_skelserker.cug";
  boss_hierarchy = hierarchy;

  appear_preset_speed_mult = 3.0f;

  appear_fx = "effects\\monst_big_skel_appear.cug";

  caster_nonmagic = true;

  sound_add_appear = array <string> = { "sound_bod\\skel\\skl_axes" };
  sound_unhide     = array <string> = { "sound_bod\\player_enter" };
  
  sound_crit_jump  = array <string> = { "sound_bod\\skel\\skl_v1_jump" };

  sound_land = array <string> = { "sound_bod\\monst_misc\\land_big" };

  // sound_death_boss      = sound_death; // skeleton bosses have special sound, no need to override
  // sound_attack_boss     = sound_attack;
  // sound_damage_boss     = sound_damage;
  // sound_trigger_boss    = sound_trigger; // skeleton bosses have special sound, no need to override
  sound_crit_jump_boss  = sound_crit_jump;
  // sound_scare_jump_boss = sound_scare_jump;
  // sound_cast_start_boss = sound_cast_start;

  InitSounds();
  InitHierarchy();
}

class Monster : Skeleton {
  
  void unhideFx(BodMonsterObj @monst) {
    PlaySound(RndFrom(sound_add_appear_arr), monst.GetPos()); // non standard so no PlayEventSound
    Skeleton::unhideFx(monst);
  }

  void appearFx(BodMonsterObj @monst, GenericEffectParams p) {
    monst.GetHierInst().InsertMover(CreateBounceAppearMover(100.0f, 0.8f));
    monst.GetHierInst().InsertMover(CreateJumpFlexMover(-0.4f, 0.6f, false));
    landFx(monst, 0.2f);
  }
  
}
