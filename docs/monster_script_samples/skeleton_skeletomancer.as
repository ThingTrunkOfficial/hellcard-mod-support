#include "scripts\skeleton.as"

void InitModule() {
  InitSkeleton();
  monsterId = '408';
  // Overrides
  hierarchy      = "char\\skeleton_skeletomancer.cug";
  boss_hierarchy = hierarchy;

  appear_fx = "effects\\monst_skel_appear.cug";
  death_fx  = "effects\\monst_skel_death.cug";

  caster_death_fx       = "effects\\monst_caster_death_alt.cug";
  caster_death_fx_floor = "effects\\monst_caster_death_alt_floor.cug";

  effect_offset = Point2D_f32(0.f, 0.f);

  flying_speed = 1.0f;

  flying_noise_speed         = 3.0f;
  flying_noise_strenght      = 5.0f;
  flying_noise_strenght_move = flying_noise_strenght * 2;

  boss_scale = 1.2f;

  sound_death      = array <string> = { "sound_bod\\skel\\skl_v3_d1", "sound_bod\\skel\\skl_v3_d2" };
  sound_damage     = array <string> = { "sound_bod\\skel\\skl_v3_dmg1", "sound_bod\\skel\\skl_v3_dmg2" };
  sound_trigger    = array <string> = { "sound_bod\\skel\\skl_v3_trig" };
  sound_scare_jump = array <string> = { "sound_bod\\skel\\skl_v3_scared" };
  sound_cast_start = array <string> = { "sound_bod\\skel\\skl_v3_incant" };

  // sound_death_boss      = sound_death; // skeleton bosses have special sound, no need to override
  // sound_attack_boss     = sound_attack;
  sound_damage_boss     = sound_damage;
  // sound_trigger_boss    = sound_trigger; // skeleton bosses have special sound, no need to override
  // sound_crit_jump_boss  = sound_crit_jump;
  sound_scare_jump_boss = sound_scare_jump;
  sound_cast_start_boss = sound_cast_start;
  
  InitSounds();
  InitHierarchy();
}

class Monster : Skeleton, Caster, Ranged {
  void appearFx(BodMonsterObj @monst, GenericEffectParams p) {
    this.Caster_appearFx(monst);
    Skeleton::appearFx(monst, p);
  }

  void deathFx(BodMonsterObj @monst, GenericEffectParams p) {
    this.Caster_deathFx(monst);
    Skeleton::deathFx(monst, p);
  }
}
