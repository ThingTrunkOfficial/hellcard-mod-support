#include "scripts\spider.as"

void InitModule() {
  InitSpider();

  monsterId = '511';

  hierarchy      = "char\\spider_burning_arachnoleton.cug";
  boss_hierarchy = hierarchy;

  star_scale        = 1.0f;

  caster_nonmagic = true;

  InitSounds();
  InitHierarchy();
}

class Monster : Spider {
  bool InitMonster(BodMonsterObj @monst, BodMonsterState state, u8 dir) {
    Spider::InitMonster(monst, state, dir);
    return false;
  }
}
