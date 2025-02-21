// #define TAG
#include "scripts\demon.as"

void InitModule() {
  InitDemon();
  monsterId = '103';

  hierarchy             = "char\\demon_slithering_bowman.cug";
  boss_hierarchy        = hierarchy;
  attack_jump_length    = 35.0f;
  star_scale            = 0.85f;
  walk_mover_multiplier = 0.6f;

  death_fx      = "effects\\monst_big_fire_death.cug";
  fire_death_fx = death_fx;

  winged_flap_speed = 0.4f;
  winged_fade_time  = 0.1f;

  sound_add_death = array <string> = { "sound_bod\\monst_misc\\fire_death" };

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

  sound_land = array <string> = { "sound_bod\\monst_misc\\land_big" };

  InitSounds();
  InitHierarchy();
}

class Monster : Demon, Ranged {
  void appearFx(BodMonsterObj @monst, GenericEffectParams p) {
    BCCGDungeon::Get().AddFxToObj("effects\\monst_demon_appear_slithering_f.cug", monst, true, true);
    BCCGDungeon::Get().AddFxToObj("effects\\monst_demon_appear_slithering_b.cug", monst, true, false);

    Demon::appearFx(monst, p);
  }
}
