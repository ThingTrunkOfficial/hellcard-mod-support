#include "scripts\skeleton.as"

void InitModule() {
  InitSkeleton();

  monsterId = '404';

  hierarchy      = "char\\skeleton_skelserker.cug";
  boss_hierarchy = hierarchy;

  appear_preset_speed_mult = 3.0f;

  appear_fx = "effects\\monst_big_skel_appear.cug";

  caster_nonmagic = true;
  
  sound_crit_jump  = array <string> = { "sound_bod\\skel\\skl_v1_jump" };

  sound_add_appear = array <string> = { "sound_bod\\skel\\skl_axes" };
  sound_unhide     = array <string> = { "sound_bod\\player_enter" };

  sound_option_pitch = 0.7f;

  sound_land = array <string> = { "sound_bod\\monst_misc\\land_big" };

  sound_crit_jump_boss  = sound_crit_jump;

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
