// #define TAG
#include "scripts\demon.as"

void InitModule() {
  InitDemon();

  monsterId      = '107';
  hierarchy      = "char\\demon_succubus.cug";
  boss_hierarchy = hierarchy;

  attack_jump_length    = 15.0f;
  idle_mover_multiplier = 0.f;

  appear_fx = caster_appear_fx;
  death_fx  = "effects\\monst_demon_succubus_death.cug";

  winged_fade_time = 0.1f;

  flying_speed         = 2.0f;
  flying_speed_on_move = flying_speed + 1.0f;

  flying_noise_speed         = 5.0f;
  flying_noise_strenght      = 5.0f;
  flying_noise_strenght_move = 2.0f;

  sound_death      = array <string> = { "sound_bod\\demon\\dmn_suc_d1", "sound_bod\\demon\\dmn_suc_d2" };
  sound_damage     = array <string> = { "sound_bod\\demon\\dmn_suc_dmg1", "sound_bod\\demon\\dmn_suc_dmg2" };
  sound_trigger    = array <string> = {};
  sound_cast_start = array <string> = { "sound_bod\\demon\\dmn_suc_incant" };
  sound_scare_jump = array <string> = { "sound_bod\\demon\\dmn_suc_scared" };
  sound_attack     = array <string> = { "sound_bod\\missile_magic"};

  sound_death_boss      = sound_death;
  sound_damage_boss     = sound_damage;
  sound_trigger_boss    = array <string> = { "sound_bod\\demon\\dmn_suc_boss_trig" };
  sound_cast_start_boss = sound_cast_start;
  sound_scare_jump_boss = sound_scare_jump;
  sound_attack_boss     = sound_attack;

  sound_option_vol_boss   = 1.0f;
  sound_option_pitch_boss = 0.6f;

  InitSounds();
  InitHierarchy();

}

class Monster : Demon, Flying, Ranged {
  bool InitMonster(BodMonsterObj @monst, BodMonsterState state, u8 dir) {
    Demon::InitMonster(monst, state, dir);
    this.AddFlyMover(monst);
    this.Winged_StartWingsAmination(monst);
    return true;
  }
    void appearFx(BodMonsterObj @monst, GenericEffectParams p) {
    Demon::appearFx(monst, p);
  }
    void deathFx(BodMonsterObj @monst, GenericEffectParams p) {
    Demon::deathFx(monst, p);
  }
}
