// #define TAG
#include "scripts\demon.as"

void InitModule() {
  InitDemon();

  monsterId = '111';

  hierarchy      = "char\\demon_diabolist.cug";
  boss_hierarchy = "char\\demon_diabolist_elite.cug";

  attack_jump_length = 35.0f;
  star_scale         = 0.85f;

  winged_flap_speed = 0.4f;
  winged_fade_time  = 0.1f;

  footstep_sound_preset = BDST_FOOTSTEP_HOOF;

  sound_add_death = array <string> = { "sound_bod\\exp_mid" };

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

class Monster : Demon, Caster, Ranged {
  void appearFx(BodMonsterObj @monst, GenericEffectParams p) {
    Demon::appearFx(monst, p);
    this.Caster_appearFx(monst);
    monst.AppearFromGround("effects\\monst_demon_appear.cug", 0.8f);
  }

  void deathFx(BodMonsterObj @monst, GenericEffectParams p) {
    Demon::deathFx(monst, p);
    this.Caster_deathFx(monst);
  }

  bool OnEnterState(BodMonsterObj @monst, BodMonsterState prev_state, BodMonsterState new_state, int param) {
    return Demon::OnEnterState(monst, prev_state, new_state, param);
  }
}
