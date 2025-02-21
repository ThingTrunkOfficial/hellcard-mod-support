#include "scripts\spider.as"

void InitModule() {
  InitSpider();

  monsterId = '509';

  hierarchy      = "char\\spider_arachnoleton.cug";
  boss_hierarchy = hierarchy;
  star_scale     = 1.0f;

  InitSounds();
  InitHierarchy();
}

class Monster : Spider {
  bool InitMonster(BodMonsterObj @monst, BodMonsterState state, u8 dir) {
    Spider::InitMonster(monst, state, dir);
    return false;
  }
}
