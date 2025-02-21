// #define TAG
#include "scripts\demon.as"

void InitModule() {
  InitDemon();
  monsterId = '104';

  hierarchy      = "char\\demon_slithering_magus.cug";
  boss_hierarchy = hierarchy;

  death_fx = "effects\\monst_z_fire_death.cug";

  walk_mover_multiplier = 0.6f;

  winged_flap_speed = 0.4f;
  winged_fade_time  = 0.1f;

  sound_add_death = array <string> = { "sound_bod\\exp_mid" };

  // Slithering subfamily
  appear_fx = "effects\\monst_demon_appear_slithering_f.cug";

  footstep_sound_preset = BDST_FOOTSTEP_SNAKE;

  sound_death      = array <string> = { "sound_bod\\demon\\dmn_v2_d1", "sound_bod\\demon\\dmn_v2_d2" };
  sound_damage     = array <string> = { "sound_bod\\demon\\dmn_v2_dmg1", "sound_bod\\demon\\dmn_v2_dmg2" };
  sound_attack     = array <string> = { "sound_bod\\demon\\dmn_v2_att1", "sound_bod\\demon\\dmn_v2_att2" };
  sound_trigger    = array <string> = { "sound_bod\\demon\\dmn_v2_trig" };
  sound_crit_jump  = array <string> = { "sound_bod\\demon\\dmn_v2_jump" };
  sound_scare_jump = array <string> = { "sound_bod\\demon\\dmn_v2_scared" };
  sound_cast_start = array <string> = { "sound_bod\\demon\\dmn_v2_incant" };

  sound_death_boss      = array <string> = { "sound_bod\\demon\\dmn_v2_boss_d" };
  sound_attack_boss     = sound_attack;
  sound_damage_boss     = sound_damage;
  sound_trigger_boss    = array <string> = { "sound_bod\\demon\\dmn_v2_boss_trig" };
  sound_crit_jump_boss  = sound_crit_jump;
  sound_scare_jump_boss = sound_scare_jump;
  sound_cast_start_boss = sound_cast_start;

  InitSounds();
  InitHierarchy();
}

class Monster : Demon, Caster, Ranged {
  void appearFx(BodMonsterObj @monst, GenericEffectParams p) {
    BCCGDungeon::Get().AddFxToObj("effects\\monst_demon_appear_slithering_f.cug", monst, true, true);
    BCCGDungeon::Get().AddFxToObj("effects\\monst_demon_appear_slithering_b.cug", monst, true, false);

    Demon::appearFx(monst, p);
  }

  void deathFx(BodMonsterObj @monst, GenericEffectParams p) {
    this.Caster_deathFx(monst);
    Demon::deathFx(monst, p);
  }
}
