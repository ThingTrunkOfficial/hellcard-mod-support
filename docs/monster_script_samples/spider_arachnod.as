#include "scripts\spider.as"

void InitModule() {
  InitSpider();

  monsterId = '503';

  hierarchy      = "char\\spider_arachnod.cug";
  boss_hierarchy = hierarchy;

  InitSounds();
  InitHierarchy();
}

class Monster : Spider {}
