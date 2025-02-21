#define ARCHDEMON
#include "scripts\demon.as"

enum death_sequence { BLOODBATH_2, BLOODBATH_3, BLOODBATH_4, BLOODBATH_5 };

array <string> sound_taunt;
array <Sound @> sound_cast_start_add_boss_arr;
array <Sound @> sound_laugh_boss_arr;
array <Sound @> sound_taunt_arr;

int last_taunt_id = 0;

void InitModule() {
  InitDemon();

  monsterId = "Archdemon";

  idle_mover_multiplier = 0.3f;
  attack_jump_length    = 35.0f;

  winged_flap_speed = 0.2f;
  winged_fade_time  = 0.0f;

  boss_hierarchy = "char\\archdemon.cug";
  hierarchy = boss_hierarchy;

  disappear_preset_CrashMaxY = 0;
  disappear_preset_CrashMinY = -2;

  boss_disappear_preset = HGEP_FIRE_DISAPPEAR;

  boss_scale = 1.0f;

  appear_fx     = "effects\\monst_demon_appear_coal_big.cug";
  boss_death_fx = "effects\\monst_archdemon_death.cug";
  demon_appear_speed_multiplier = 0.6f;
  
  effect_offset = Point2D_f32(0.f, -50.f);

  caster_fx_back  = "effects\\monst_cast_arch_f.cug";
  caster_fx_front = "effects\\monst_cast_arch_b.cug";
  caster_fx_floor = "effects\\monst_cast_arch_floor.cug";

  sound_damage_boss = array <string> = { "sound_bod\\boss\\archdemon_hit0", "sound_bod\\boss\\archdemon_hit1", "sound_bod\\boss\\archdemon_hit2" };
  sound_attack_boss = array <string> = { "voices\\archdemon_att1", "voices\\archdemon_att2" };
  sound_crit_jump_boss = array <string> = { "voices\\archdemon_crit" };
  sound_scare_jump_boss = array <string> = { "voices\\archdemon_jump" };
  sound_land_boss = array <string> = { "sound_bod\\monst_misc\\land_big" };

  sound_cast_start_add_boss_arr = SetSounds(array <string> = { "voices\\archdemon_cast0" });
  sound_laugh_boss_arr = SetSounds(array <string> = { "voices\\archdemon_laugh" });

    // TODO: name sound files and string table lines by state name {boss}_state_{stateId}
  sound_taunt = array <string> = {
    "", // zero state doesn't use script, adding this so I dont have to correct the index in enterState
    "voices\\archdemon_taunt_0",
    "voices\\archdemon_taunt_1",
    "voices\\archdemon_taunt_2",
    "voices\\archdemon_taunt_3",
    "voices\\archdemon_taunt_4",
    "voices\\archdemon_taunt_5",
    "voices\\archdemon_taunt_6",
    "voices\\archdemon_taunt_7",
    "voices\\archdemon_taunt_8",
    "voices\\archdemon_taunt_9",
    "voices\\archdemon_taunt_10",
    "voices\\archdemon_taunt_11"
  };
  
  sound_taunt_arr = SetSounds(array <string> = {  "voices\\archdemon_taunt_0",
    "voices\\archdemon_taunt_1",
    "voices\\archdemon_taunt_2",
    "voices\\archdemon_taunt_3",
    "voices\\archdemon_taunt_4",
    "voices\\archdemon_taunt_5",
    "voices\\archdemon_taunt_6",
    "voices\\archdemon_taunt_7",
    "voices\\archdemon_taunt_8",
    "voices\\archdemon_taunt_9",
    "voices\\archdemon_taunt_10",
    "voices\\archdemon_taunt_11" 
	});


  InitSounds();
  InitHierarchy();
}

class Monster : Demon {

  bool InitMonster(BodMonsterObj @monst, BodMonsterState state, u8 dir) {
    MonsterBase::InitMonster(monst, state, dir);
    AddIdleMover(monst);
    return true;
  }

  bool OnEnterState(BodMonsterObj @monst, BodMonsterState prev_state, BodMonsterState new_state, int param) {
    //this.Winged_OnEnterState(monst, prev_state, new_state);

    if (new_state == DMS_DEAD_PRE_EXP) {
      BCCGDungeon::Get().AddShrapnelsOnPos(monst.GetPos(), 700.0f, 0.6f, 290, 296, DECAL_BLOOD, "effects\\monst_cook_trail.cug", 3.5f, 5.45f, 120, 60.f, 80.f, true, 0.f, 20.f);
      BCCGDungeon::Get().AddShrapnelsOnPos(monst.GetPos(), 700.0f, 0.6f, 290, 296, DECAL_BLOOD, "effects\\monst_cook_trail.cug", 6.25f, 8.15f, 120, 60.f, 80.f, true, 0.f, 20.f);
      BCCGDungeon::Get().AddShrapnelsOnPos(monst.GetPos(), 700.0f, 0.6f, 290, 296, DECAL_BLOOD, "effects\\monst_cook_trail.cug", 8.7f, 10.f, 120, 60.f, 80.f, true, 0.f, 20.f);
      BCCGDungeon::Get().AddShrapnelsOnPos(monst.GetPos(), 700.0f, 0.6f, 290, 296, DECAL_BLOOD, "effects\\monst_cook_trail.cug", 11.3f, 13.8f, 120, 60.f, 80.f, true, 0.f, 20.f);
    }

    if (new_state == DMS_JUMP && monst.RandFloat(0, 1) < .3f) {
      PlaySound(RndFrom(sound_laugh_boss_arr), monst.GetPos(), monst.RandFloat(0, 0.5f));
    }

    return MonsterBase::OnEnterState(monst, prev_state, new_state, param);
  }

    void appearFx(BodMonsterObj @monst, GenericEffectParams p) {
    MonsterBase::appearFx(monst, p);

    monst.AppearFromGround("effects\\monst_demon_appear.cug", demon_appear_speed_multiplier, true, Point2D_f32(600.f, 1000.f));
    landFx(monst, 1 / demon_appear_speed_multiplier);
    PlaySound(GetSound("sound_bod\\boulder_fall"), monst.GetPos(), 1 / demon_appear_speed_multiplier, sound_option_pitch, sound_option_vol);
    monst.GetHierInst().InsertMover(CreateJumpFlexMover(0.4f, 0.6f, false, 0.3f));
    monst.GetHierInst().InsertMover(CreateJumpFlexMover(-0.2f, 0.8f, false, 1.5f));
  }

  void OnTimer(BodMonsterObj @monst, int id) {
    this.Winged_OnTimer(monst, id);
  }

  void OnEvent(BodMonsterObj @monst, BodMonsterEvent evt) {
    MonsterBase::OnEvent(monst, evt);
  }

  bool OnDamage(BodMonsterObj @monst, BodMonsterDmgResult result, u16 damage, bool fire, bool ice, bool shield_crush) {
    if (result == BMDR_NORMAL || result == BMDR_DEATH) {
      monst.GetHierInst().InsertMover(CreateHitMover(10.0f, 3.0f));
      if (!monst.IsFrozen()) {
        if (monst.RandFloat(0, 1) < 0.33) {
          PlayEventSound(DAMAGE, monst, 0.f, 1.f);
        }
      }
    }

    return true;
  }

}
