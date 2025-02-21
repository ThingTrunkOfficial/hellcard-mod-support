// #define TAG
#include "scripts\demon.as"

string damage_fx = "effects\\spark_release_s.cug";
Point2D_f32 damage_fx_offset = Point2D_f32(0.f, -80.f);

void InitModule() {
  InitDemon();

  monsterId = '110';

  hierarchy      = "char\\demon_incubus.cug";
  boss_hierarchy = "char\\demon_incubus_elite.cug";

  attack_jump_length = 35.0f;
  star_scale         = 0.85f;

  appear_fx     = "effects\\monst_demon_appear_coal_big.cug";
  death_fx      = "effects\\monst_big_fire_death.cug";
  fire_death_fx = death_fx;

  demon_appear_speed_multiplier = 0.6f;

  winged_flap_speed = 0.4f;
  winged_fade_time  = 0.1f;

  footstep_sound_preset = BDST_FOOTSTEP_ARMORED;

  sound_land = array <string> = { "sound_bod\\monst_misc\\land_big" };

  // sound_death_boss      = sound_death;
  // sound_attack_boss     = sound_attack;
  // sound_damage_boss     = sound_damage;
  // sound_trigger_boss    = sound_trigger;
  // sound_crit_jump_boss  = sound_crit_jump;
  // sound_scare_jump_boss = sound_scare_jump;
  // sound_cast_start_boss = sound_cast_start;

  InitSounds();
  InitHierarchy();
}

class Monster : Demon {

  void appearFx(BodMonsterObj @monst, GenericEffectParams p) {
    MonsterBase::appearFx(monst, p);
    monst.AppearFromGround("effects\\monst_demon_appear.cug", demon_appear_speed_multiplier, true);
    landFx(monst, 1 / demon_appear_speed_multiplier);
    PlaySound(GetSound("sound_bod\\boulder_fall"), monst.GetPos(), 1 / demon_appear_speed_multiplier, sound_option_pitch, sound_option_vol);
    monst.GetHierInst().InsertMover(CreateJumpFlexMover(0.4f, 0.6f, false, 0.3f));
    monst.GetHierInst().InsertMover(CreateJumpFlexMover(-0.2f, 0.8f, false, 1.5f));
  }
}
