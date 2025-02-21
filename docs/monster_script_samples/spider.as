#define SPIDER
#include "scripts\monster_base.as"

enum spider_timer { LAND_BOUNCE, ORIENT_TO_PLAYER_AND_BOUNCE, LAND_FX };

void InitSpider() {
  InitMonsterBase();

  star_scale            = 0.7f;
  attack_jump_length    = 45.0f;
  idle_mover_multiplier = 0.5f;

  fire_death_fx = "effects\\monst_fire_death.cug";
  ice_death_fx  = "effects\\monst_ice_death.cug";
  death_fx      = "effects\\monst_spider_death.cug";

  boss_scale        = 1.1f;

  boss_death_fx_shrapnel_decal  = DECAL_MUD_SMALL;
  boss_death_fx_shrapnel_effect = "effects\\monst_boss_trail_gray.cug";

  boss_death_fx_shrapnel_amount = 35;

  boss_death_fx_shrapnel_sprite_range = array <u32> = { 304, 310 };

  boss_death_fx_shrapnel_use_true_dt = false;

  boss_death_fx = "effects\\monst_boss_exp_gray.cug";

  footstep_sound_preset = BDST_FOOTSTEP_SPIDER;

  sound_death      = array <string> = { "sound_bod\\spider\\spider_v1_d1", "sound_bod\\spider\\spider_v1_d2" };
  sound_attack     = array <string> = { "sound_bod\\spider\\spider_v1_att1", "sound_bod\\spider\\spider_v1_att2" };
  sound_damage     = array <string> = { "sound_bod\\spider\\spider_v1_dmg1", "sound_bod\\spider\\spider_v1_dmg2" };
  sound_appear     = array <string> = { "sound_bod\\spider\\spider_descent" };
  sound_hide       = array <string> = { "sound_bod\\spider\\spider_stomp" };
  sound_unhide     = array <string> = { "sound_bod\\spider\\spider_land" };
  sound_idle       = array <string> = { "sound_bod\\spider\\spider_stomp" };
  sound_trigger    = array <string> = { "sound_bod\\spider\\spider_v1_trig" };
  sound_crit_jump  = array <string> = { "sound_bod\\spider\\spider_v1_jump" };
  sound_scare_jump = array <string> = { "sound_bod\\spider\\spider_v1_scared" };

  sound_death_boss      = array <string> = { "sound_bod\\spider\\spider_v2_boss_d" };
  sound_attack_boss     = array <string> = { "sound_bod\\spider\\spider_v2_att1", "sound_bod\\spider\\spider_v2_att2" };
  sound_damage_boss     = array <string> = { "sound_bod\\spider\\spider_v2_dmg1", "sound_bod\\spider\\spider_v2_dmg2" };
  sound_trigger_boss    = array <string> = { "sound_bod\\spider\\spider_v2_boss_trig" };
  sound_crit_jump_boss  = array <string> = { "sound_bod\\spider\\spider_v2_jump" };
  sound_scare_jump_boss = array <string> = { "sound_bod\\spider\\spider_v2_scared" };
}

class Spider : MonsterBase {
  void OnTimer(BodMonsterObj @monst, int id) {
    switch (id) {

    case ORIENT_TO_PLAYER_AND_BOUNCE: {
      int direction = DeltaToDir(BCCGDungeon::Get().GetCamPos().m_X - monst.GetPos().m_X, BCCGDungeon::Get().GetCamPos().m_Y - monst.GetPos().m_Y);
      monst.GetHierInst().SetCurrentDir(direction);
    }
    case LAND_BOUNCE:
      monst.GetHierInst().InsertMover(CreateStompMover(1, 8, 3.0f, 1.0f));
      break;
    case LAND_FX:
      landFx(monst);
      break;
    }
  }

  void deathFx(BodMonsterObj @monst, GenericEffectParams p) {
    p.m_SpanMin = 2.f; // min/max time to live of each part. All times described as 'normalized in effect time' are multiplies by this
    p.m_SpanMax = 2.3f;
    MonsterBase::deathFx(monst, p);
  }

  void appearFx(BodMonsterObj @monst, GenericEffectParams p) {
    monst.GetHierInst().InsertMover(CreateBounceAppearMover(100.0f, 0.8f));
    monst.GetHierInst().InsertMover(CreateJumpFlexMover(-0.9f, 0.6f, false));
    // MonsterBase::appearFx(monst, p);
  }

  void disappearFx(BodMonsterObj @monst) {
    monst.GetHierInst().InsertMover(CreateDisappearSpiderStyleMover(200.0f, 1.0f));
    monst.GetHierInst().InsertMover(CreateStompMover(2, 8, 3.0f, 1.0f));
    MonsterBase::disappearFx(monst);
  }

  void unhideFx(BodMonsterObj @monst) {
    PlayEventSound(UNHIDE, monst);
    MonsterBase::unhideFx(monst);
  }

  GenericEffectParams defaultDeathFx(BodMonsterObj @monst, GenericEffectParams p) {
    BCCGDungeon::Get().AddDecalOnPos(monst.GetPos(), DECAL_MUD_SMALL, 5.f, 0.3f);
    return MonsterBase::defaultDeathFx(monst, p);
  }

  // void appearFx(BodMonsterObj @monst, GenericEffectParams p) {
  //
  //   MonsterBase::appearFx(monst, p);
  // }
}
