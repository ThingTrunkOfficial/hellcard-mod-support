#include "scripts\spider.as"

void InitModule() {
  InitSpider();

  monsterId = '506';

  hierarchy      = "char\\spider_corrupted_arachnod_h.cug";
  boss_hierarchy = hierarchy;

  attack_jump_length = 0.0f;

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
    monst.ElasticAppear();
    BCCGDungeon::Get().AddSpiderThreadToObj(monst, Point2D_f32(10.0f, -150.f));
    PlaySound(RndFrom(sound_add_appear_arr), monst.GetPos()); // non standard so no PlayEventSound
  }
}
