#include "scripts\goat.as"

string      damage_fx        = "effects\\spark_release_s.cug";
Point2D_f32 damage_fx_offset = Point2D_f32(0.f, -80.f);

void InitModule() {
  InitGoat();

  monsterId = '209';

  hierarchy      = "char\\goat_battering_flamegoat.cug";
  boss_hierarchy = hierarchy;

  caster_fx_front = "effects\\monst_cast_n_fire_f.cug";
  caster_fx_back  = "effects\\monst_cast_n_fire_b.cug";

  death_fx = "effects\\spark_release.cug";

  walk_mover_multiplier = 1.5f;
  idle_mover_multiplier = 0.8f;

  sound_cast_start = array <string> = { "sound_bod\\goat\\goat_charge_cast" };

  // sound_death_boss      = sound_death;
  // sound_attack_boss     = sound_attack;
  // sound_damage_boss     = sound_damage;
  sound_trigger_boss = array <string> = { "sound_bod\\goat\\goat_boss_deathmetal" };
  // sound_crit_jump_boss  = sound_crit_jump;
  // sound_scare_jump_boss = sound_scare_jump;
  sound_cast_start_boss = sound_cast_start;

  InitSounds();
  InitHierarchy();
}

class Monster : Goat {
}
