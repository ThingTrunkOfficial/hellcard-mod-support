#include "scripts\skeleton.as"

void InitModule() {
  InitSkeleton();

  monsterId = '405';

  hierarchy      = "char\\skeleton_cool_archer.cug";
  boss_hierarchy = hierarchy;

  caster_nonmagic = true;

  InitSounds();
  InitHierarchy();
}

class Monster : Skeleton, Ranged {}
