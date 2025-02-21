#define GARGOYLE
#include "scripts\monster_base.as"

array<Sound @> sound_gargoyle_wake_arr;
array<string> sound_gargoyle_wake;
array<Sound @> sound_gargoyle_stone_arr;
array<string> sound_gargoyle_stone;

void InitGargoyle() {
  InitMonsterBase();

  star_scale = 0.85f;

  fire_death_fx = "effects\\monst_fire_death.cug";
  ice_death_fx  = "effects\\monst_ice_death.cug";
  death_fx      = "effects\\monst_gargoyle_big_death.cug";

  appear_fx = "effects\\monst_gargoyle_appear_2.cug";

  flying_speed         = 2.0f;
  flying_speed_on_move = flying_speed + 1.0f;

  winged_fade_time = 0.08f;

  boss_scale        = 1.1f;

  boss_death_fx_shrapnel_radius = 300.0f;
  boss_death_fx_shrapnel_scale  = 0.8f;
  boss_death_fx_shrapnel_amount = 35;

  boss_death_fx = "effects\\monst_gargoyle_big_death.cug";

  sound_death          = array <string> = { "sound_bod\\garg\\garg_v_d1", "sound_bod\\garg\\garg_v_d2" };
  sound_appear         = array <string> = { "sound_bod\\garg\\garg_sm_wake" };
  sound_attack         = array <string> = { "sound_bod\\garg\\garg_v_att1", "sound_bod\\garg\\garg_v_att2" };
  sound_damage         = array <string> = { "sound_bod\\garg\\garg_v_dmg1", "sound_bod\\garg\\garg_v_dmg2" };
  sound_trigger        = array <string> = { "sound_bod\\garg\\garg_v_trig" };
  sound_crit_jump      = array <string> = { "sound_bod\\garg\\garg_v_jump" };
  sound_scare_jump     = array <string> = { "sound_bod\\garg\\garg_v_scared" };
  sound_add_death      = array <string> = { "sound_bod\\garg\\garg_sm_d1", "sound_bod\\garg\\garg_sm_d2" };
  sound_gargoyle_stone = array <string> = { "sound_bod\\garg\\garg_sm_stone" };

  sound_gargoyle_wake = sound_appear;

  sound_death_boss      = array <string> = { "sound_bod\\garg\\garg_v_boss_d" };
  sound_attack_boss     = sound_attack;
  sound_damage_boss     = sound_damage;
  sound_trigger_boss    = array <string> = { "sound_bod\\garg\\garg_v_boss_trig" };
  sound_crit_jump_boss  = sound_crit_jump;
  sound_scare_jump_boss = sound_scare_jump;

  sound_gargoyle_wake_arr  = SetSounds(sound_gargoyle_wake);
  sound_gargoyle_stone_arr = SetSounds(sound_gargoyle_stone);
}

class Gargoyle : MonsterBase, Flying, Winged { // Stoneskin
  bool InitMonster(BodMonsterObj @monst, BodMonsterState state, u8 dir) {
    MonsterBase::InitMonster(monst, state, dir);

    if (state == DMS_STONESKIN) {
      // monst.GetHierInst().SetState("gargoyle", 0.0f);
      monst.GetHierInst().SetState("gargoyle", 0.0f);
    } else {
      this.AddFlyMover(monst);                // run this...
      this.Winged_StartWingsAmination(monst); //...before this if you want to take advantage of automatic wing animation timing; see winged.as
    }

    // LOG('/gargoyle:' + state);
    return true;
  }

  bool OnEnterState(BodMonsterObj @monst, BodMonsterState prev_state, BodMonsterState new_state, int param) {
    this.Winged_OnEnterState(monst, prev_state, new_state);
    this.Flying_OnEnterState(monst, prev_state, new_state);

    if (prev_state == DMS_STONESKIN) {
      this.Stoneskin_Exit(monst);
    }

    if (new_state == DMS_STONESKIN) {
      this.Stoneskin_Enter(monst);
    }

    return MonsterBase::OnEnterState(monst, prev_state, new_state, param);
  }

  void OnTimer(BodMonsterObj @monst, int id) {
    this.Winged_OnTimer(monst, id);
  }

  void appearFx(BodMonsterObj @monst, GenericEffectParams p) {
    monst.AppearFromGround("effects\\monst_gargoyle_appear.cug", 1.2f);
    PlaySound(RndFrom(sound_add_appear_arr), monst.GetPos()); // non standard so no PlayEventSound
    PlayEventSound(APPEAR, monst);

    BCCGDungeon::Get().AddFxToObj(appear_fx, monst, true, true);
  }

  GenericEffectParams fireDeathFx(BodMonsterObj @monst, GenericEffectParams p) {
    BCCGDungeon::Get().AddFxToObj(death_fx, monst, true, true).SetEmitterOffset(Point2D_f32(0.f, -50.f));
    p.Preset(disappear_preset);
    return p;
  }

  void Stoneskin_Enter(BodMonsterObj @monst) {
    this.RemoveFlyMover(monst);
    PlaySound(RndFrom(sound_gargoyle_stone_arr), monst.GetPos()); // non standard so no PlayEventSound
    monst.GetHierInst().SetState("gargoyle", 0.0f);
  }

  void Stoneskin_Exit(BodMonsterObj @monst) {
    this.AddFlyMover(monst);                // run this...
    this.Winged_StartWingsAmination(monst); //...before this if you want to take advantage of automatic wing animation timing; see winged.as

    PlaySound(RndFrom(sound_gargoyle_wake_arr), monst.GetPos());  // non standard so no PlayEventSound
    monst.GetHierInst().SetState("default", 0.1f);
    BCCGDungeon::Get().AddFxToObj("effects\\monst_gargoyle_launch.cug", monst, false, true);
  }
}
