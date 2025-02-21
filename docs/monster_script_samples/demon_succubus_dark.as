// #define TAG
#include "scripts\demon.as"

Color c_multiply = Color(255, 90, 180, 255);
Color c_additive = Color(0, 0, 0, 0);

string damage_fx = "effects\\spark_release_s.cug";
Point2D_f32 damage_fx_offset = Point2D_f32(0.f, -80.f);

void InitModule() {
  InitDemon();

  monsterId = '112';

  // Overrides
  hierarchy      = "char\\demon_succubus_dark.cug";
  boss_hierarchy = hierarchy;

  attack_jump_length    = 15.0f;
  idle_mover_multiplier = 0.f;

  // appear_fx = "effects\\monst_skel_mage_appear.cug";
  appear_fx     = "effects\\monst_demon_appear_coal_big.cug";
  death_fx = "effects\\monst_demon_succubus_death.cug";
  // death_fx      = "effects\\monst_big_fire_death.cug";
  fire_death_fx = death_fx;

  /**
   * Set mixin suplied properties to default values. This has to be done before
   * constructor of each class that includes mixins, otherwise the default
   * values are used.
   */
  winged_flap_speed = 0.3f;
  winged_fade_time  = 0.1f;

  flying_speed               = 2.0f;
  flying_noise_speed         = 0.5f;
  flying_speed_on_move       = 3.5f;
  flying_noise_strenght      = 10.0f;
  flying_noise_strenght_move = 20.5f;

  boss_death_fx_shrapnel_effect = "effects\\monst_boss_trail_magic.cug";

  boss_death_fx_shrapnel_sprite_range[0] = 320;
  boss_death_fx_shrapnel_sprite_range[1] = 323;

  boss_death_fx_shrapnel_use_true_dt = false;

  boss_death_fx = "effects\\monst_boss_exp_magic.cug";

  caster_death_fx       = "effects\\monst_caster_death_alt.cug";
  caster_death_fx_floor = "effects\\monst_caster_death_alt_floor.cug";

  sound_damage     = array <string> = { "sound_bod\\demon\\dmn_suc_dmg1", "sound_bod\\demon\\dmn_suc_dmg2" };
  sound_death      = array <string> = { "sound_bod\\demon\\dmn_suc_d1", "sound_bod\\demon\\dmn_suc_d2" };
  sound_add_death  = array <string> = { "sound_bod\\monst_misc\\fire_death" };
  sound_cast_start = array <string> = { "sound_bod\\demon\\dmn_suc_incant" };
  sound_scare_jump = array <string> = { "sound_bod\\demon\\dmn_suc_scared" };
  sound_land = array <string> = { "sound_bod\\monst_misc\\land_big" };

  sound_damage_boss     = sound_damage;
  sound_death_boss      = sound_death;
  sound_cast_start_boss = sound_cast_start;
  sound_scare_jump_boss = sound_scare_jump;
  sound_land_boss       = sound_land;
  sound_trigger_boss = array <string> = { "sound_bod\\demon\\dmn_suc_boss_trig" };

  InitSounds();
  InitHierarchy();
}

class Monster : Demon, Flying, Caster, Ranged {
  bool InitMonster(BodMonsterObj @monst, BodMonsterState state, u8 dir) {
    Demon::InitMonster(monst, state, dir);
    monst.GetHierInst().InsertMover(CreateColorizeMover(c_multiply, c_additive, -1.f, 0, 0));
    this.AddFlyMover(monst);

    monst.SetScale(1.25f);

    //Wobble
    monst.GetHierInst().SetWobbleEnabled(true);
    monst.GetHierInst().SetWobbleSpeed(1.0f);
    monst.GetHierInst().SetWobblePower(4.0f);

    return true;
  }

  bool OnDamage(BodMonsterObj @monst, BodMonsterDmgResult result, u16 damage, bool fire, bool ice, bool shield_crush) {
    BCCGDungeon::Get().AddFxToObj(damage_fx, monst, true, true, 0.0f, false).SetEmitterOffset(damage_fx_offset);
    return Demon::OnDamage(monst, result, damage, fire, ice, bool shield_crush);
  }

  void appearFx(BodMonsterObj @monst, GenericEffectParams p) {
    Demon::appearFx(monst, p);
    this.Caster_appearFx(monst);
  }

  void deathFx(BodMonsterObj @monst, GenericEffectParams p) {
    this.Caster_deathFx(monst);
    Demon::deathFx(monst, p);
  }
}
