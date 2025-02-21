#include "scripts\spider.as"

enum rotation { CRAWLER_ROTATE_LEFT, CRAWLER_ROTATE_RIGHT }

int appear_loop_count = 8;
f32 appear_loop_step  = 0.1f;

void InitModule() {
  InitSpider();

  monsterId = '510';

  hierarchy      = "char\\spider_hot_crawler.cug";
  boss_hierarchy = "char\\spider_hot_crawler_elite.cug";

  attack_jump_length = 25.0f;

  death_fx     = "effects\\monst_fire_death.cug";
  appear_fx    = "effects\\monst_scorpion_appear.cug";
  disappear_fx = appear_fx;

  disappear_preset = HGEP_FIRE_DISAPPEAR;

  caster_nonmagic = true;
  caster_fx_front = "effects\\monst_cast_n_fire_f.cug";
  caster_fx_back  = "effects\\monst_cast_n_fire_b.cug";

  boss_death_fx_shrapnel_decal  = DECAL_CRATER;
  boss_death_fx_shrapnel_effect = "effects\\monst_boss_trail_fire.cug";

  boss_death_fx_shrapnel_amount = 15;

  boss_death_fx_shrapnel_sprite_range = array <u32> = { 290, 296 };

  boss_death_fx = "effects\\monst_big_fire_death.cug";

  sound_appear     = array <string> = { "sound_bod\\spider\\crawler_appear" };
  sound_unhide     = sound_appear;
  sound_disappear  = sound_appear;

  sound_attack     = array <string> = { "sound_bod\\spider\\crawler_att1", "sound_bod\\spider\\crawler_att2" };
  sound_damage     = array <string> = { "sound_bod\\spider\\spider_v2_dmg1", "sound_bod\\spider\\spider_v2_dmg2" };
  sound_scare_jump = array <string> = { "sound_bod\\spider\\spider_v2_scared" };

  sound_add_death = sound_explode;

  sound_land = array <string> = { "sound_bod\\monst_misc\\land_big" };

  // sound_death_boss      = sound_death;
  sound_attack_boss     = sound_attack;
  sound_damage_boss     = sound_damage;
  // sound_trigger_boss    = sound_trigger;
  // sound_crit_jump_boss  = sound_crit_jump;
  sound_scare_jump_boss = sound_scare_jump;
  // sound_cast_start_boss = sound_cast_start;

  InitSounds();
  InitHierarchy();
}

class Monster : Spider {
  void appearFx(BodMonsterObj @monst, GenericEffectParams p) {
    PlaySound(sound_appear_arr[0], monst.GetPos());
    BCCGDungeon::Get().AddFxToObj(appear_fx, monst, true, true, 0.0f, false).SetEmitterOffset(effect_offset);

    monst.AppearCustom(CreateFadeMover(true, 0.7f), 0.7f);
    monst.GetHierInst().InsertMover(CreateFloorAppearMover(100.0f));

    for (int i = 1; i <= appear_loop_count; i++) {
      (i % 2 == 1) ?
      monst.ScheduleTimerCall(i * appear_loop_step, CRAWLER_ROTATE_RIGHT) :
      monst.ScheduleTimerCall(i * appear_loop_step, CRAWLER_ROTATE_LEFT);
    }
  }

  void idleFx(BodMonsterObj @monst) {
    if (monst.Rand(0, 100) < 3) {
      monst.GetHierInst().InsertMover(CreateStompMover(2, 6, 3.0f, 1.0f));
    }
    Spider::idleFx(monst);
  }

  void disappearFx(BodMonsterObj @monst) {
    monst.GetHierInst().InsertMover(CreateStompMover(2, 6, 3.0f, 1.0f));
    monst.GetHierInst().InsertMover(CreateRotateMover(1, true, 0.1f)); // obr�t clockwise o 1
    monst.DisappearCustom(CreateFadeMover(false, 0.7f), 0.7f);
    monst.ScheduleTimerCall(0.1f, 3);        // schedule obrotu w lewo
    BCCGDungeon::Get().AddFxToObj(disappear_fx, monst, true, true);
    Spider::disappearFx(monst);
  }

  void OnTimer(BodMonsterObj @monst, int id) {
    int state = monst.GetState();

    //DebugLog('OnTimer: ' + parseStateCode(state) + ' ' + id);

    switch (id) {
    case CRAWLER_ROTATE_RIGHT:
      monst.GetHierInst().InsertMover(CreateRotateMover(1, true, appear_loop_step / 2));
      break;

    case CRAWLER_ROTATE_LEFT:
      monst.GetHierInst().InsertMover(CreateRotateMover(1, false, appear_loop_step / 2));
      break;
    }
  }
}
