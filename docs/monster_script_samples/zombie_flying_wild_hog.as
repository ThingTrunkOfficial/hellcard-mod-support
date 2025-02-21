// #define TAGS
#include "scripts\zombie.as"

void InitModule() {
  InitZombie();

  monsterId = '602';

  hierarchy      = "char\\zombie_flying_wild_hog.cug";
  boss_hierarchy = hierarchy;

  boss_scale = 1.3f;

  flying_speed               = 0.3f;
  flying_speed_on_move       = 1.0f;
  flying_noise_speed         = 0.5f;
  flying_noise_strenght      = 3.0f;
  flying_noise_strenght_move = 2.0f;

  sound_death      = array <string> = { "sound_bod\\zombie\\zomb_pig_d1", "sound_bod\\zombie\\zomb_pig_d2" };
  sound_attack     = array <string> = { "sound_bod\\zombie\\zomb_pig_att" };
  sound_damage     = array <string> = { "sound_bod\\zombie\\zomb_pig_hit1", "sound_bod\\zombie\\zomb_pig_hit2" };
  sound_trigger    = array <string> = { "sound_bod\\zombie\\zomb_pig_trig" };
  sound_add_appear = array <string> = { "sound_bod\\zombie\\zomb_appear_hog" };
  sound_scare_jump = sound_trigger;

  sound_add_death = array <string> = { }; // mute additional death sounds

  // sound_death_boss      = sound_death;
  sound_attack_boss     = sound_attack;
  sound_damage_boss     = sound_damage;
  // sound_trigger_boss    = sound_trigger;
  sound_crit_jump_boss  = sound_crit_jump;
  sound_scare_jump_boss = sound_scare_jump;
  sound_cast_start_boss = sound_cast_start;

  InitSounds();
  InitHierarchy();
}

class Monster : Zombie, Flying {
  bool InitMonster(BodMonsterObj @monst, BodMonsterState state, u8 dir) {
    Zombie::InitMonster(monst, state, dir);
    this.AddFlyMover(monst);
    return true;
  }

  bool OnEnterState(BodMonsterObj @monst, BodMonsterState prev_state, BodMonsterState new_state, int param) {
    this.Flying_OnEnterState(monst, prev_state, new_state);
    return Zombie::OnEnterState(monst, prev_state, new_state, param);
  }
};
