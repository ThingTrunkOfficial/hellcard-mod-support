#include "scripts\spider.as"

void InitModule() {
  InitSpider();
  monsterId = '505';

  hierarchy      = "char\\spider_arachgod.cug";
  boss_hierarchy = "char\\spider_arachgod_elite.cug";

  star_scale = 1.0f;

  fire_death_fx = "effects\\monst_big_fire_death.cug";
  ice_death_fx  = "effects\\monst_big_ice_death.cug";

  caster_nonmagic = true;

  sound_death      = array <string> = { "sound_bod\\spider\\spider_v2_d1", "sound_bod\\spider\\spider_v2_d2" };
  sound_attack     = array <string> = { "sound_bod\\spider\\spider_v2_att1", "sound_bod\\spider\\spider_v2_att2" };
  sound_damage     = array <string> = { "sound_bod\\spider\\spider_v2_dmg1", "sound_bod\\spider\\spider_v2_dmg2" };
  sound_trigger    = array <string> = { "sound_bod\\spider\\spider_v2_trig" };
  sound_crit_jump  = array <string> = { "sound_bod\\spider\\spider_v2_jump" };
  sound_scare_jump = array <string> = { "sound_bod\\spider\\spider_v2_scared" };

  sound_land = array <string> = { "sound_bod\\monst_misc\\land_big" };

  InitSounds();
  InitHierarchy();
}

class Monster : Spider {
  void appearFx(BodMonsterObj @monst, GenericEffectParams p) {
    monst.GetHierInst().InsertMover(CreateBounceAppearMover(100.0f, 0.8f));
    monst.GetHierInst().InsertMover(CreateJumpFlexMover(-0.5f, 0.6f, false));
  }
}
