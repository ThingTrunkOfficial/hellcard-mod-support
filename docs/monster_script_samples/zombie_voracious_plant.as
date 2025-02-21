// #define TAGS
#include "scripts\zombie.as"

void InitModule() {
  InitZombie();

  monsterId = '612';

  hierarchy      = "char\\zombie_voracious_plant.cug";
  boss_hierarchy = hierarchy;

  appear_fx       = "effects\\monst_scorpion_appear.cug";
  poison_death_fx = "effects\\monst_zombie_big_exp.cug";
  ice_death_fx    = "effects\\monst_big_ice_death.cug";
  fire_death_fx   = "effects\\monst_big_fire_death.cug";

  disappear_preset_CrashScaleMax = 1.2f;
  disappear_preset_CrashScaleMin = 0.8f;

  caster_nonmagic = true;

  // Sounds
  sound_add_appear = array <string> = { "sound_bod\\spider\\crawler_appear" };
  sound_unhide     = sound_appear;
  sound_disappear  = sound_appear;

  sound_death      = array <string> = { "sound_bod\\zombie\\zomb_v3_d1", "sound_bod\\zombie\\zomb_v3_d2" };
  sound_attack     = array <string> = { "sound_bod\\zombie\\zomb_v3_att1", "sound_bod\\zombie\\zomb_v3_att2" };
  sound_damage     = array <string> = { "sound_bod\\zombie\\zomb_v3_dmg1", "sound_bod\\zombie\\zomb_v3_dmg2" };
  sound_trigger    = array <string> = { "sound_bod\\zombie\\zomb_v3_trig" };
  sound_crit_jump  = array <string> = { "sound_bod\\zombie\\zomb_v3_jump" };
  sound_scare_jump = array <string> = { "sound_bod\\zombie\\zomb_v3_scared" };

  sound_land = array <string> = { "sound_bod\\monst_misc\\land_big" };

  sound_death_boss      = sound_death;
  sound_attack_boss     = sound_attack;
  sound_damage_boss     = sound_damage;
  sound_trigger_boss    = sound_trigger;
  sound_crit_jump_boss  = sound_crit_jump;
  sound_scare_jump_boss = sound_scare_jump;
  // sound_cast_start_boss = sound_cast_start;

  InitSounds();
  InitHierarchy();
}

class Monster : Zombie, Ranged, Stationary {
  void OnTimer(BodMonsterObj @monst, int id) {
    if (id == 3) {
      // Obrot counter clockwise
      monst.GetHierInst().InsertMover(CreateRotateMover(1, false, 0.1f)); // obrót clockwise o 1
      if (monst.GetState() == DMS_APPEAR) {
        monst.ScheduleTimerCall(0.1f, 4);       // schedule obrotu c-clockwise
      }
    }
    if (id == 4) {
      // Obrot counter clockwise
      monst.GetHierInst().InsertMover(CreateRotateMover(1, true, 0.1f)); // obrót clockwise o 1
      if (monst.GetState() == DMS_APPEAR) {
        monst.ScheduleTimerCall(0.1f, 3);      // schedule obrotu clockwise
      }
    }
  }

  void appearFx(BodMonsterObj @monst, GenericEffectParams p) {
    monst.AppearCustom(CreateFadeMover(true, 0.7f), 0.7f);
    monst.GetHierInst().InsertMover(CreateFloorAppearMover(100.0f));
    monst.GetHierInst().InsertMover(CreateRotateMover(1, true, 0.1f));
    monst.ScheduleTimerCall(0.1f, 3);

    PlayEventSound(APPEAR, monst);
    PlaySound(RndFrom(sound_add_appear_arr), monst.GetPos()); // non standard so no PlayEventSound

    BCCGDungeon::Get().AddFxToObj(appear_fx, monst, true, true);
  }

  void unhideFx(BodMonsterObj @monst) {
    GenericEffectParams p;

    this.appearFx(monst, p);
  }
};
