// #define TAG
#include "scripts\demon.as"

void InitModule() {
  InitDemon();
  monsterId = '101';

  hierarchy      = "char\\demon_fallen_pimp.cug";
  boss_hierarchy = hierarchy;

  flying_speed         = 2.0f;
  flying_speed_on_move = flying_speed + 1.0f;

  flying_noise_speed         = 6.0f;
  flying_noise_strenght      = 4.0f;
  flying_noise_strenght_move = flying_noise_strenght * 2;

  winged_flap_speed         = fly_wing_coefficient / flying_speed;
  winged_flap_speed_on_move = fly_wing_coefficient / flying_speed_on_move;
  winged_fade_time          = 0.0f;

  winged_fade_time = 0.0f;

  star_scale = 0.7f;

  sound_death      = array <string> = { "sound_bod\\demon\\dmn_v1_d1", "sound_bod\\demon\\dmn_v1_d2" };
  sound_attack     = array <string> = { "sound_bod\\demon\\dmn_v1_att1", "sound_bod\\demon\\dmn_v1_att2" };
  sound_damage     = array <string> = { "sound_bod\\demon\\dmn_v1_dmg1", "sound_bod\\demon\\dmn_v1_dmg2" };
  sound_trigger    = array <string> = { "sound_bod\\demon\\dmn_v1_trig" };
  sound_scare_jump = array <string> = { "sound_bod\\demon\\dmn_v1_scared" };

  sound_death_boss      = sound_death;
  sound_attack_boss     = sound_attack;
  sound_damage_boss     = sound_damage;
  sound_trigger_boss    = sound_trigger;
  // sound_crit_jump_boss  = sound_crit_jump;
  sound_scare_jump_boss = sound_scare_jump;
  // sound_cast_start_boss = sound_cast_start;

  InitSounds();
  InitHierarchy();
}

class Monster : Demon, Flying { // Always Winged
  bool InitMonster(BodMonsterObj @monst, BodMonsterState state, u8 dir) {
    MonsterBase::InitMonster(monst, state, dir);

    this.AddFlyMover(monst);
    this.Winged_StartWingsAmination(monst);

    /**
     * Monster has a 50% chance to weld a sprear
     */
    if (monst.RandFloat(0, 1) > 0.5) {
      monst.GetHierInst().SetState("spear", 0.1f);
    }

    return true;
  }

  bool OnEnterState(BodMonsterObj @monst, BodMonsterState prev_state, BodMonsterState new_state, int param) {
    this.Flying_OnEnterState(monst, prev_state, new_state);
    return Demon::OnEnterState(monst, prev_state, new_state, param);
  }
}
