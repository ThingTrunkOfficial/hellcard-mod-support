// #define TAG
#include "scripts\demon.as"

string damage_fx = "effects\\spark_release_s.cug";
Point2D_f32 damage_fx_offset = Point2D_f32(0.f, -0.f);

void InitModule() {
  InitDemon();

  monsterId = '801';

  hierarchy      = "char\\archduck.cug";
  boss_hierarchy = hierarchy;

  attack_jump_length    = 35.0f;
  star_scale            = 0.85f;
  idle_mover_multiplier = 0.5f;

  appear_fx     = "effects\\monst_demon_appear_coal_big.cug";
  death_fx      = "effects\\monst_big_fire_death.cug";
  fire_death_fx = death_fx;

  demon_appear_speed_multiplier = 0.8f;

  caster_nonmagic = true;

  footstep_sound_preset = BDST_FOOTSTEP_HOOF;
  
  InitSounds();
  InitHierarchy();
}

class Monster : Demon {
  bool OnDamage(BodMonsterObj @monst, BodMonsterDmgResult result, u16 damage, bool fire, bool ic, bool shield_crushe) {
    BCCGDungeon::Get().AddFxToObj(damage_fx, monst, true, true, 0.0f, false).SetEmitterOffset(damage_fx_offset);
    return Demon::OnDamage(monst, result, damage, fire, ic, bool shield_crush);
  }
}
