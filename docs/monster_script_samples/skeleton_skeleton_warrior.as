#include "scripts\skeleton.as"

void InitModule() {
  InitSkeleton();

  monsterId = '401';

  hierarchy      = "char\\skeleton_skeleton_warrior.cug";
  boss_hierarchy = hierarchy;

  star_scale = 0.85f;

  InitSounds();
  InitHierarchy();
}

class Monster : Skeleton {
  bool InitMonster(BodMonsterObj @monst, BodMonsterState state, u8 dir) {
    if (monst.IsBoss()) {
      LOG_WRN('WARNING: Skeleton Warrior Boss is flying so it needs a custom script ./bosses/skeleton_skeleton_warrior.as. Regular script was loaded - check the XLS.');
    }

    Skeleton::InitMonster(monst, state, dir);

    // Losowanie wyglądów dla niebossowego szkieleta
    if (monst.RandFloat(0, 1) < 0.2) {
      monst.GetHierInst().SetState("bone", 0.0f);
    }
    if (monst.RandFloat(0, 1) < 0.05) {
      monst.GetHierInst().SetState("no_head", 0.0f);
    }
    if (monst.RandFloat(0, 1) < 0.1) {
      monst.GetHierInst().SetState("no_arm_left", 0.0f);
    }

    return true;
  }
}
