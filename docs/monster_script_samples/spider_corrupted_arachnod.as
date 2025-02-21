#include "scripts\spider.as"

void InitModule() {
  InitSpider();
  monsterId = '507';

  hierarchy      = "char\\spider_corrupted_arachnod.cug";
  boss_hierarchy = hierarchy;

  sound_appear = array <string> = { "sound_bod\\spider\\spider_break_thread" };

  InitSounds();
  InitHierarchy();
}

class Monster : Spider, Ranged {
  /**
   * monst's appear effects are govered by game code, return false here
   * to let the code do its thing.
   */
  bool InitMonster(BodMonsterObj @monst, BodMonsterState state, u8 dir) {
    MonsterBase::InitMonster(monst, state, dir);
    return false;
  }

  void appearFx(BodMonsterObj @monst, GenericEffectParams p) {
    monst.ScheduleTimerCall(0.3f, LAND_BOUNCE);
    monst.ScheduleTimerCall(0.7f, LAND_BOUNCE);
    Spider::unhideFx(monst);
    Spider::appearFx(monst, p);
    PlayEventSound(APPEAR, monst);
  }
}
