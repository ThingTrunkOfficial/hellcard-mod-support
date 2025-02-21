#define COOK
#include "scripts\demon.as"

array <string> sound_taunt;
array <string> sound_taunt_q3;

array <Sound @> sound_cast_start_add_boss_arr;
array <Sound @> sound_taunt_arr;

int last_taunt_id = 0;

array <uint16> carrot_states = {
  10001, 10003, 10005, 10006, 10007, 10008,
  10009, 11101, 11103, 11105, 11106, 11201,
  11203, 11205, 11206, 11208, 11301, 11303,
  11305, 11307, 11309, 11311
};

void InitModule() {
  InitDemon();

  monsterId = "Cook";

  // Overrides
  star_scale            = 1.4f;
  idle_mover_multiplier = 0.5f;
  attack_jump_length    = 45.0f;

  boss_hierarchy = "char\\cook.cug";
  hierarchy = boss_hierarchy;

  caster_fx_back  = "effects\\monst_cook_cast_b.cug";
  caster_fx_front = "effects\\monst_cook_cast_f.cug";

  disappear_preset = HGEP_FROZEN_DISAPPEAR;
  
  appear_fx     = "effects\\monst_demon_appear_coal_big.cug";
  demon_appear_speed_multiplier = 0.8f;

  // BOSS DEFAULTS

  boss_death_fx_shrapnel_decal  = DECAL_BLOOD;
  boss_death_fx_shrapnel_effect = "effects\\monst_cook_trail.cug";

  boss_death_fx_shrapnel_radius = 700.0f;
  boss_death_fx_shrapnel_scale  = 0.6f;
  boss_death_fx_shrapnel_amount = 169;

  boss_death_fx_shrapnel_sprite_range[0] = 389;
  boss_death_fx_shrapnel_sprite_range[1] = 389;

  boss_death_fx_shrapnel_delay_range[0] = 0.0f;
  boss_death_fx_shrapnel_delay_range[1] = 1.1f;

  boss_death_fx_shrapnel_height_range[0] = 0.0f;
  boss_death_fx_shrapnel_height_range[1] = 45.f;

  boss_death_fx_shrapnel_use_true_dt = true;

  boss_death_fx = "effects\\monst_cook_exp.cug";

  // Sounds
  sound_damage_boss = array <string> = { "voices\\cook_hit0", "voices\\cook_hit1", "voices\\cook_hit2" };
  sound_crit_jump_boss = array <string> = { "voices\\cook_crit" };
  sound_scare_jump_boss = array <string> = { "voices\\cook_jump" };
  sound_crit_jump_boss = array <string> = { "voices\\cook_crit" };
  sound_attack_boss = array <string> = { "voices\\cook_att1", "voices\\cook_att2" };

  sound_cast_start_add_boss_arr = SetSounds(array <string> = { "voices\\cook_cast0", "voices\\cook_cast1" });

  sound_taunt = array <string> = {
    "", // zero state doesn't use script, adding this so I dont have to correct the index in enterState
    "voices\\cook_state1",
    "voices\\cook_pot1",
    "voices\\cook_state2",
    "voices\\cook_pot2",
    "voices\\cook_pot3",
    "voices\\cook_state0",
    "voices\\cook_pot4",
    "voices\\cook_pot2"
  };

  // 3lvl mastering has a different set of states
  sound_taunt_q3 = array <string> = {
    "", // zero state doesn't use script, adding this so I dont have to correct the index in enterState
    "voices\\cook_state1",
    "voices\\cook_pot1",
    "voices\\cook_state2",
    "voices\\cook_pot2",
    "voices\\cook_state0",
    "voices\\cook_pot3",
    "voices\\cook_state1",
    "voices\\cook_pot4",
    "voices\\cook_state2",
    "voices\\cook_pot2"
  };
  
    sound_taunt_arr = SetSounds(array <string> = { 
    "voices\\cook_state1",
    "voices\\cook_pot1",
    "voices\\cook_state2",
    "voices\\cook_pot2",
    "voices\\cook_state0",
    "voices\\cook_pot3",
    "voices\\cook_state1",
    "voices\\cook_pot4",
    "voices\\cook_state2",
    "voices\\cook_pot2"
	});


  InitSounds();
  InitHierarchy();
}

class Monster : Demon, Caster {
  bool InitMonster(BodMonsterObj @monst, BodMonsterState state, u8 dir) {
    MonsterBase::InitMonster(monst, state, dir);
    AddIdleMover(monst);

    return true;
  }

  bool OnEnterState(BodMonsterObj @monst, BodMonsterState prev_state, BodMonsterState new_state, int param) {
    if (new_state == DMS_DEAD_PRE_EXP) {
      BCCGDungeon::Get().AddShrapnelsOnPos(monst.GetPos(), 700.0f, 0.6f, 389, 389, DECAL_BLOOD, "effects\\monst_cook_trail.cug", 3.5f, 5.45f, 120, 60.f, 80.f, true, 0.f, 20.f);
      BCCGDungeon::Get().AddShrapnelsOnPos(monst.GetPos(), 700.0f, 0.6f, 389, 389, DECAL_BLOOD, "effects\\monst_cook_trail.cug", 6.25f, 8.15f, 120, 60.f, 80.f, true, 0.f, 20.f);
    }

    return MonsterBase::OnEnterState(monst, prev_state, new_state, param);
  }

  void bossCast(BodMonsterObj @monst) {
    @caster_current_fx_back  = BCCGDungeon::Get().AddFxToObj(caster_fx_boss_back, monst, false, false, 0.f, false);
    @caster_current_fx_front = BCCGDungeon::Get().AddFxToObj(caster_fx_boss_front, monst, false, true, 0.f, false);
  }
  void appearFx(BodMonsterObj @monst, GenericEffectParams p) {
    Demon::appearFx(monst, p);
    this.Caster_appearFx(monst);
    monst.AppearFromGround("effects\\monst_demon_appear.cug", 0.8f, true, Point2D_f32(600.f, 1000.f));
	PlaySound(RndFrom(sound_taunt_arr), monst.GetPos(), monst.RandFloat(0, 0.5f));
  }

  void castSpellEffects(BodMonsterObj @monst) {
    // sound effects are managed in onEnterState
    this.bossCast(monst);
  }

}
