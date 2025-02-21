#include "scripts\spider.as"

void InitModule() {
  InitSpider();

  monsterId = '504';

  hierarchy      = "char\\spider_wicked_longlegs.cug";
  boss_hierarchy = hierarchy;

  sound_death      = array <string> = { "sound_bod\\spider\\spider_v2_d1", "sound_bod\\spider\\spider_v2_d2" };
  sound_attack     = array <string> = { "sound_bod\\spider\\spider_v2_att1", "sound_bod\\spider\\spider_v2_att2" };
  sound_damage     = array <string> = { "sound_bod\\spider\\spider_v2_dmg1", "sound_bod\\spider\\spider_v2_dmg2" };
  sound_trigger    = array <string> = { "sound_bod\\spider\\spider_v2_trig" };
  sound_crit_jump  = array <string> = { "sound_bod\\spider\\spider_v2_jump" };
  sound_scare_jump = array <string> = { "sound_bod\\spider\\spider_v2_scared" };

  InitSounds();
  InitHierarchy();
}

class Monster : Spider, Ranged {
  bool InitMonster(BodMonsterObj @monst, BodMonsterState state, u8 dir) {
    Spider::InitMonster(monst, state, dir);
    if (state == DMS_APPEAR) {
      this.unhideFx(monst);
    }
    return true;
  }

  void unhideFx(BodMonsterObj @monst) {
    monst.ScheduleTimerCall(0.7f, ORIENT_TO_PLAYER_AND_BOUNCE);
    Spider::unhideFx(monst);
  }
}
