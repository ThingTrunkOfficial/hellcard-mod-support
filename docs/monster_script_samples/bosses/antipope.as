#define ANTIPOPE
#include "scripts\monster_base.as"
#include "scripts\zombie.as"

int last_taunt_id = 0;
int last_cast_id = -1;

array <string> sound_cast_start_add_boss;
array <Sound @> sound_taunt_arr;

enum antipope_element { NO_ELEMENT, FIRE, ICE, POISON };
enum antipope_delayed_action { SPIN, FLOAT, POISON_DEATH, FIRE_DEATH, ICE_DEATH };

int current_element = NO_ELEMENT;

array <string> sound_taunt;

array <string>          hier(4);
array <string>          enter_fx(4);
array <string>          shrapnel(4);
array <int>             shrapnel_sprite(4);
array <BodDecalPreset>  shrapnel_decal(4);
array <string>          shrapnel_trail(4);
array <string>          cast_f(4);
array <string>          cast_b(4);
// array <array <string>> sound_taunt(4);

array<uint16> fire_states = {
  10102, 11402, 11607, 11502,
  11507, 11602, 11607
};

array<uint16> ice_states = {
  10103, 10105, 11403, 11405,
  11503, 11505, 11508, 11603,
  11605, 11608, 11610
};

array<uint16> poison_states = {
  10104, 10106, 11404, 11406,
  11504, 11506, 11604, 11606,
  11609, 11611
};

// Death sequence animation speed
f32 time_step = 0.8f;

void InitModule() {
  InitZombie();

  monsterId = "Antipope";

  boss_hierarchy = "char\\antipope.cug";
  hierarchy = boss_hierarchy;

  boss_scale = 1.0f;

  appear_fx = "effects\\monst_skel_mage_appear.cug";

  caster_fx_back  = "effects\\monst_antipope_cast_boss_b.cug";
  caster_fx_front = "effects\\monst_antipope_cast_boss_f.cug";
  caster_fx_floor = "effects\\monst_cast_floor.cug";

  hier[NO_ELEMENT]             = boss_hierarchy;
  enter_fx[NO_ELEMENT]         = "";
  shrapnel[NO_ELEMENT]         = "";
  shrapnel_sprite[NO_ELEMENT]  = 0;
  shrapnel_decal[NO_ELEMENT]   = DECAL_CRATER;
  shrapnel_trail[NO_ELEMENT]   = "";
  cast_f[NO_ELEMENT]           = caster_fx_front;
  cast_b[NO_ELEMENT]           = caster_fx_back;
  // sound_taunt[NO_ELEMENT]  = array <string> = {};

  hier[FIRE]             = "char\\antipope_f.cug";
  enter_fx[FIRE]         = "effects\\monst_antipope_fire_enter.cug";
  shrapnel[FIRE]         = "effects\\missile_fire_bolt.cug";
  shrapnel_sprite[FIRE]  = 425;
  shrapnel_decal[FIRE]   = DECAL_CRATER;
  shrapnel_trail[FIRE]   = "effects\\missile_fire_bolt2.cug";
  cast_f[FIRE]           = "effects\\monst_antipope_cast_fire_f.cug";
  cast_b[FIRE]           = "effects\\monst_antipope_cast_fire_b.cug";
  // sound_taunt[FIRE]  = array <string> = { 
  //   "voices\\antipope_taunt_fire0",
  //   "voices\\antipope_taunt_fire1",
  //   "voices\\antipope_taunt_fire2"
  // };

  hier[ICE]             = "char\\antipope_i.cug";
  enter_fx[ICE]         = "effects\\monst_antipope_ice_enter.cug";
  shrapnel[ICE]         = "effects\\missile_ice_bolt.cug";
  shrapnel_sprite[ICE]  = 223;
  shrapnel_decal[ICE]   = DECAL_ICE;
  shrapnel_trail[ICE]   = "effects\\missile_ice_bolt2.cug";
  cast_f[ICE]           = "effects\\monst_antipope_cast_ice_f.cug";
  cast_b[ICE]           = "effects\\monst_antipope_cast_ice_b.cug";
  // sound_taunt[ICE]  = array <string> = {
  //   "voices\\antipope_taunt_freeze0",
  //   "voices\\antipope_taunt_freeze1",
  //   "voices\\antipope_taunt_freeze2"
  // };

  hier[POISON]             = "char\\antipope_p.cug";
  enter_fx[POISON]         = "effects\\monst_antipope_poison_enter.cug";
  shrapnel[POISON]         = "effects\\missile_poison_bolt.cug";
  shrapnel_sprite[POISON]  = 330;
  shrapnel_decal[POISON]   = DECAL_POISON;
  shrapnel_trail[POISON]   = "effects\\missile_poison_bolt.cug";
  cast_f[POISON]           = "effects\\monst_antipope_cast_poison_f.cug";
  cast_b[POISON]           = "effects\\monst_antipope_cast_poison_b.cug";
  // sound_taunt[POISON]  = array <string> = {
  //   "voices\\antipope_taunt_poison0",
  //   "voices\\antipope_taunt_poison1",
  //   "voices\\antipope_taunt_poison2"
  // };


  // Overrides
  idle_mover_multiplier = 0.3f;
  attack_jump_length    = 25.0f;

  effect_offset = Point2D_f32(0.f, -50.f);

  appear_preset_speed_mult = 3.0f;

  // fire_death_fx = "effects\\monst_fire_death.cug";
  // ice_death_fx  = "effects\\monst_ice_death.cug";
  // death_fx      = fire_death_fx;

  appear_fx = "effects\\monst_skel_mage_appear.cug";

  // appear_preset = HGEP_DEFAULT_APPEAR;
  // appear_preset_easeX = EASE_BACK;
  // appear_preset_easeY = EASE_SCURVE;

  disappear_preset_CrashMaxY = 0;
  disappear_preset_CrashMinY = -2;

  boss_disappear_preset = HGEP_FIRE_DISAPPEAR;

  // BOSS DEFAULTS

  // boss_death_fx_shrapnel_decal  = DECAL_BLOOD;
  // boss_death_fx_shrapnel_effect = "effects\\monst_cook_trail.cug";

  boss_death_fx_shrapnel_radius = 600.0f;
  boss_death_fx_shrapnel_scale  = 0.05f;
  boss_death_fx_shrapnel_amount = 16;

  // boss_death_fx_shrapnel_sprite_range[0] = 389;
  // boss_death_fx_shrapnel_sprite_range[1] = 389;

  boss_death_fx_shrapnel_delay_range[0] = 0.0f;
  boss_death_fx_shrapnel_delay_range[1] = 0.0f;

  boss_death_fx_shrapnel_height_range[0] = 40.0f;
  boss_death_fx_shrapnel_height_range[1] = 60.0f;

  boss_death_fx_shrapnel_use_true_dt = true;

  boss_death_fx = "effects\\monst_antipope_n_death.cug";

  sound_attack = array <string> = { "voices\\antipope_att1", "voices\\antipope_att2" };
  sound_damage_boss = array <string> = { "sound_bod\\boss\\antipope_hit0", "sound_bod\\boss\\antipope_hit1", "sound_bod\\boss\\antipope_hit2", "sound_bod\\boss\\antipope_hit3" };
  sound_death_boss = array <string> = { "voices\\antipope_death" };
  sound_cast_start_add_boss = array <string> = {
    "voices\\antipope_cast0", 
    "voices\\antipope_cast1",
    "voices\\antipope_cast2",
    "voices\\antipope_cast3"
  };

  // TODO: name sound files and string table lines by state name {boss}_state_{stateId}
  sound_taunt = {
    "", // zero state doesn't use script, adding this so I dont have to correct the index in enterState
    "voices\\antipope_taunt_fire0",
    "voices\\antipope_taunt_freeze0",
    "voices\\antipope_taunt_poison0",
    "voices\\antipope_taunt_freeze1",
    "voices\\antipope_taunt_poison1",
    "voices\\antipope_taunt_fire1",
    "voices\\antipope_taunt_freeze2",
    "voices\\antipope_taunt_poison2",
    "voices\\antipope_taunt_freeze0",
    "voices\\antipope_taunt_poison0",
    "voices\\antipope_taunt_fire2" // unused
  };

    sound_taunt_arr = SetSounds(array <string> = { 
     "voices\\antipope_taunt_fire0",
    "voices\\antipope_taunt_freeze0",
    "voices\\antipope_taunt_poison0",
    "voices\\antipope_taunt_freeze1",
    "voices\\antipope_taunt_poison1",
    "voices\\antipope_taunt_fire1",
    "voices\\antipope_taunt_freeze2",
    "voices\\antipope_taunt_poison2",
    "voices\\antipope_taunt_freeze0",
    "voices\\antipope_taunt_poison0",
	});

  InitSounds();
  InitHierarchy();
}

class Monster : Zombie, Caster {
  bool InitMonster(BodMonsterObj @monst, BodMonsterState state, u8 dir) {
    MonsterBase::InitMonster(monst, state, dir);
    AddIdleMover(monst);
    return true;
  }

  void appearFx(BodMonsterObj @monst, GenericEffectParams p) {
    Zombie::appearFx(monst, p);
    this.Caster_appearFx(monst);
  }

  bool OnEnterState(BodMonsterObj @monst, BodMonsterState prev_state, BodMonsterState new_state, int param) {
    //int element = GetCurAntipopeElement(monst);

    if (new_state == DMS_DEAD_PRE_EXP) {
      monst.ScheduleTimerCall(0.1f, FLOAT);
      BCCGDungeon::Get().AddFxToObj("effects\\monst_antipope_load.cug", monst, true, true).SetEmitterOffset(Point2D_f32(0.f, -70.f));
    }

    return MonsterBase::OnEnterState(monst, prev_state, new_state, param);
  }

  void OnTimer(BodMonsterObj @monst, int id) {
    switch (id) {
    case FLOAT:
      RemoveMover(monst, walk_mover_id);
      // Float up 70
      SetMover(monst, CreateCastMover(70.0f), walk_mover_id);
      monst.ScheduleTimerCall(0.1f, SPIN);
      monst.ScheduleTimerCall(time_step, POISON_DEATH);
      break;

    case SPIN:
      RemoveMover(monst, idle_mover_id);
      // // Rotate Mover: 255 spin angle, clockwise, in 4 sec time
      SetMover(monst, CreateRotateMover(255, true, 4.0f), idle_mover_id);
      monst.ScheduleTimerCall(4.0f, SPIN);
      break;

    case POISON_DEATH:
      this.setElement(POISON, monst);
      this.shrapnelFx(monst);
      if (time_step > 0.1f) {
        monst.ScheduleTimerCall(time_step, FIRE_DEATH);
      }
      time_step = time_step * 0.9;
      break;

    case FIRE_DEATH:
      this.setElement(FIRE, monst);
      this.shrapnelFx(monst);
      if (time_step > 0.1f) {
        monst.ScheduleTimerCall(time_step, ICE_DEATH);
      }
      time_step = time_step * 0.9;
      break;

    case ICE_DEATH:
      this.setElement(ICE, monst);
      this.shrapnelFx(monst);
      if (time_step > 0.1f) {
        monst.ScheduleTimerCall(time_step, POISON_DEATH);
      }
      time_step = time_step * 0.9;
      break;

    default:
      break;
    }
  }

  void deathFx(BodMonsterObj @monst, GenericEffectParams p) {
    monst.GenericEffect(this.bossDeathFx(monst, p));
  }

  void setElement(int element, BodMonsterObj @monst) {
    if (element != 0) {
      BCCGDungeon::Get().AddFxToObj(enter_fx[element], monst, true, true).SetEmitterOffset(effect_offset);
      PlaySound(GetSound("sound_bod\\bomb_exp"), monst.GetPos());
    }

    hierarchy            = hier[element];
    caster_fx_boss_back  = cast_b[element];
    caster_fx_boss_front = cast_f[element];

    boss_death_fx_shrapnel_sprite_range[0] = shrapnel_sprite[element];
    boss_death_fx_shrapnel_sprite_range[1] = shrapnel_sprite[element];
    boss_death_fx_shrapnel_decal           = shrapnel_decal[element];
    boss_death_fx_shrapnel_effect          = shrapnel_trail[element];
  }

  int GetCurAntipopeElement(BodMonsterObj @monst) {
    return NO_ELEMENT;
  }
}
