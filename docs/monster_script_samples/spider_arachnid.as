#include "scripts\spider.as"

void InitModule() {
  InitSpider();

  monsterId = '501';

  hierarchy      = "char\\spider_arachnid.cug";
  boss_hierarchy = hierarchy;
  star_scale     = 0.6f;

  fire_death_fx = "effects\\monst_fire_death_small.cug";
  death_fx      = "effects\\monst_spider_small_death.cug";

  InitSounds();
  InitHierarchy();
}

class Monster : Spider {}
