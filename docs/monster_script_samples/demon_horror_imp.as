// #define TAG
#include "scripts\demon.as"

void InitModule() {
  InitDemon();
  monsterId = '102';

  hierarchy      = "char\\demon_horror_imp.cug";
  boss_hierarchy = hierarchy;

  flying_speed         = 1.0f;
  flying_speed_on_move = flying_speed + 1.0f;

  flying_noise_speed         = 3.0f;
  flying_noise_strenght      = 1.0f;
  flying_noise_strenght_move = flying_noise_strenght + 1;

  winged_flap_speed         = fly_wing_coefficient / flying_speed;
  winged_flap_speed_on_move = fly_wing_coefficient / flying_speed_on_move;

  winged_fade_time = 0.0f;
  star_scale       = 0.7f;

  fire_death_fx = "effects\\fire_boom_s.cug";
  death_fx      = fire_death_fx;

  winged_flap_speed         = fly_wing_coefficient / flying_speed;
  winged_flap_speed_on_move = fly_wing_coefficient / flying_speed_on_move;

  sound_death      = array <string> = { "sound_bod\\demon\\dmn_v1_d1", "sound_bod\\demon\\dmn_v1_d2" };
  sound_attack     = array <string> = { "sound_bod\\demon\\dmn_v1_att1", "sound_bod\\demon\\dmn_v1_att2" };
  sound_damage     = array <string> = { "sound_bod\\demon\\dmn_v1_dmg1", "sound_bod\\demon\\dmn_v1_dmg2" };
  sound_trigger    = array <string> = { "sound_bod\\demon\\dmn_v1_trig" };
  sound_scare_jump = array <string> = { "sound_bod\\demon\\dmn_v1_scared" };

  sound_death_boss      = sound_death;
  sound_attack_boss     = sound_attack;
  sound_damage_boss     = sound_damage;
  sound_trigger_boss    = sound_trigger;
  sound_scare_jump_boss = sound_scare_jump;

  InitSounds();
  InitHierarchy();
}

class Monster : Demon, Flying, Fire {
  ~Monster() {
    this.Fire_RemoveFlameEffects();
  }

  bool InitMonster(BodMonsterObj @monst, BodMonsterState state, u8 dir) {
    MonsterBase::InitMonster(monst, state, dir);
    this.Winged_StartWingsAmination(monst);
    this.AddFlyMover(monst);
    return true;
  }

  bool OnEnterState(BodMonsterObj @monst, BodMonsterState prev_state, BodMonsterState new_state, int param) {
    if (new_state == DMS_APPEAR) {
	Color flash_color = orange;

	// fire pimp rain: spawn
	f32 fall_time   = 2.f;
	f32 bounce_time = 0.3f;
	f32 len         = fall_time + bounce_time;

	HierMover @mov = CreateSmoothFallMover(600.f, fall_time, 30.f, bounce_time);
	PlaySound(sound_land_arr[0], monst.GetPos(), fall_time);

	mov.SetUserID(5);
	monst.GetHierInst().InsertMover(mov);
	monst.GetHierInst().SetState("rain_on", 0.1f);

	flash_color = lighten(flash_color, 25);
	flash_color = transparentify(flash_color, 120);
	BCCGDungeon::Get().AddLightFxToObj(monst, 0.3f * len, 0.6f * len, 0.2f * len, 1.0f, flash_color);
	monst.ScheduleTimerCall(fall_time, 7);

      return true;
    }

    this.Fire_OnEnterState(monst, new_state);
    this.Flying_OnEnterState(monst, prev_state, new_state);

    return Demon::OnEnterState(monst, prev_state, new_state, param);
  }

  void OnTimer(BodMonsterObj @monst, int id) {
    Demon::OnTimer(monst, id);
  }
}
