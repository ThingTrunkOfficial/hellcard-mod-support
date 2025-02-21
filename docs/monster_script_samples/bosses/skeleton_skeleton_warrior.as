#include "scripts\skeleton.as"
f32 boss_wobble_speed;
f32 boss_wobble_power;

void InitModule() {
  InitSkeleton();

  monsterId = '401';

  hierarchy      = "char\\skeleton_skeleton_warrior.cug";
  boss_hierarchy = hierarchy;

  star_scale      = 0.85f;
  caster_nonmagic = true;

  boss_scale = 1.2f;

  boss_wobble_speed = 1.0f;
  boss_wobble_power = 7.0f;

  flying_speed               = 0.7f;
  flying_speed_on_move       = 1.0f;
  flying_noise_speed         = 0.5f;
  flying_noise_strenght      = 3.0f;
  flying_noise_strenght_move = 2.0f;

  sound_option_pitch = 0.7f;

  InitSounds();
  InitHierarchy();
}

class Monster : Skeleton, Flying {
  bool InitMonster(BodMonsterObj @monst, BodMonsterState state, u8 dir) {
    Skeleton::InitMonster(monst, state, dir);

    this.AddFlyMover(monst);
    monst.GetHierInst().SetWobbleEnabled(true);
    monst.GetHierInst().SetWobbleSpeed(boss_wobble_speed);
    monst.GetHierInst().SetWobblePower(boss_wobble_power);
    monst.GetHierInst().SetState("ice_sword", 0.1f);

    return true;
  }

  bool OnEnterState(BodMonsterObj @monst, BodMonsterState prev_state, BodMonsterState new_state, int param) {
    this.Flying_OnEnterState(monst, prev_state, new_state);
    return MonsterBase::OnEnterState(monst, prev_state, new_state, param);
  }
}
