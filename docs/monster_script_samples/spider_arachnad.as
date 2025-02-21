#include "scripts\spider.as"

void InitModule() {
  InitSpider();
  monsterId = '502';

  hierarchy      = "char\\spider_arachnad.cug";
  boss_hierarchy = hierarchy;

  InitSounds();
  InitHierarchy();
}

class Monster : Spider {}
