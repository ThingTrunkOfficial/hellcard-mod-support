#include "scripts\env.as"

#include "scripts\colors.as"
#include "scripts\mixins.as"

// #include "scripts\useful_scripts.as"

#include "scripts\module_globals.as"

void LoadEffects(array <string> effects_ar_tmp = effects_ar) {
}

void ReleaseEffects(array <string> effects_ar_tmp = effects_ar) {
}

/**
 * Called at the top of class declaration. Suplies topmost default values.
 */
void InitMonsterBase() {
  sound_option_vol   = 1.0f;
  sound_option_pitch = 1.0f;
  sound_option_delay = 0.0f;

  sound_option_vol_boss   = 1.2f;
  sound_option_pitch_boss = 0.8f;

  attack_jump_length = 25.0f;
  db_att_delay       = 0.2f;

  walk_mover_multiplier = 1.0f;
  idle_mover_multiplier = 1.0f;

  star_scale = 1.0f;

  hierarchy      = "char\\surprise.cug";
  boss_hierarchy = "char\\surprise.cug";

  walk_mover_id = 11;
  fly_mover_id  = 22;
  idle_mover_id = 33;

  flying_speed         = 1.0f;
  flying_speed_on_move = 2.0f;

  flying_noise_strenght      = 1.0f;
  flying_noise_strenght_move = 2.0f;

  flying_noise_speed = 1.0f;

  winged_flap_speed         = 0.2f;
  winged_flap_speed_on_move = 0.3f;
  winged_fade_time          = 0.1f;

  death_fx = "effects\\monst_skel_death.cug";

  caster_appear_fx      = "effects\\monst_skel_mage_appear.cug";
  caster_death_fx       = "effects\\monst_caster_death.cug";
  caster_death_fx_floor = "";

  fire_death_fx   = "effects\\monst_fire_death.cug";
  ice_death_fx    = "effects\\monst_ice_death.cug";
  poison_death_fx = "effects\\monst_zombie_exp.cug";
  appear_fx       = "effects\\monst_skel_appear.cug";

  land_fx_f = "effects\\stomp_b.cug";
  land_fx_b = "effects\\stomp_f.cug";

  footstep_sound_preset = BDST_FOOTSTEP_SILENT;

  effect_offset      = Point2D_f32(0.0f, 0.0f);
  boss_effect_offset = Point2D_f32(0.0f, 0.0f);

  boss_scale   = 1.1f;

  // Death Shrapnel

  /**
   * Boss on death explosion effect.
   */

  boss_death_fx_shrapnel_decal  = DECAL_CRATER;
  boss_death_fx_shrapnel_effect = "effects\\monst_boss_trail_stone.cug";

  boss_death_fx_shrapnel_radius = 500.0f;
  boss_death_fx_shrapnel_scale  = 1.0f;
  boss_death_fx_shrapnel_amount = 30;

  boss_death_fx_shrapnel_sprite_range = array <u32> = { 425, 425 };
  boss_death_fx_shrapnel_delay_range  = array <f32> = { 0.0f, 0.0f };
  boss_death_fx_shrapnel_height_range = array <f32> = { 40.0f, 60.0f };

  boss_death_fx_shrapnel_use_true_dt = true;

  // Caster
  caster_fx_back           = "effects\\monst_cast_b.cug";
  caster_fx_front          = "effects\\monst_cast_floor.cug";
  caster_fx_floor          = "effects\\monst_cast_f.cug";
  caster_fx_nonmagic_back  = "effects\\monst_cast_n_b.cug";
  caster_fx_nonmagic_front = "effects\\monst_cast_n_f.cug";
  caster_fx_boss_back      = "effects\\monst_cast_boss_b.cug";
  caster_fx_boss_front     = "effects\\monst_cast_boss_f.cug";
  caster_nonmagic          = false;

  appear_preset            = HGEP_DEFAULT_APPEAR;
  appear_preset_easeX      = EASE_BACK;
  appear_preset_easeY      = EASE_SCURVE;
  appear_preset_speed_mult = 4.0f;

  disappear_preset                 = HGEP_DEFAULT_DISAPPEAR;
  disappear_preset_easeX           = EASE_BACK;
  disappear_preset_easeY           = EASE_SCURVE;
  disappear_preset_CrashColorEnd   = noColor;
  disappear_preset_CrashColorStart = white;
  disappear_preset_CrashScaleMax   = 1.0f;
  disappear_preset_CrashScaleMin   = 1.0f;
  disappear_preset_CrashMaxY       = 0;
  disappear_preset_CrashMinY       = 0;

  dissapear_preset_FadeToVal = 0.0f;
  dissapear_preset_FadeStart = 0.0f;
  dissapear_preset_FadeEnd   = 0.0f;
  dissapear_preset_SpeedMult = 0.0f;

  boss_disappear_preset       = HGEP_DEFAULT_DISAPPEAR;
  boss_disappear_preset_easeY = EASE_SCURVE;
  boss_disappear_preset_easeX = EASE_BACK;

  boss_death_fx = "effects\\monst_boss_exp_evil.cug";

  /**
   * This is how an array literal looks like in angel script. This lets me
   * overwrite an array if it was initilized earlier in the
   * inheritance chain.
   * I use arrays of strings here and resolve them in InitMonster so overwriting
   * a set of sounds looks like this:
   *    sound_death = array <string> = { "sound_bod\\skel\\skl_v2_d1", "sound_bod\\skel\\skl_v2_d2" }
   * instead of:
   *    sound_death = SetSounds(array <string> = { "sound_bod\\skel\\skl_v2_d1", "sound_bod\\skel\\skl_v2_d2" });
   * or worse:
   *    this.sound_death.removeRange(0, this.sound_death.length() - 1);
   *    this.sound_death.insertLast(SoundManager::GetSound("sound_bod\\skel\\skl_v2_d1"));
   *    this.sound_death.insertLast(SoundManager::GetSound("sound_bod\\skel\\skl_v2_d2"));
   */

  sound_burn        = array <string> = { "sound_bod\\monst_misc\\fire_death" };
  sound_land        = array <string> = { "sound_bod\\monst_misc\\land_small" };
  sound_freeze      = array <string> = { "sound_bod\\monst_misc\\freeze" };
  sound_explode     = array <string> = { "sound_bod\\exp_mid" };
  sound_add_appear  = array <string> = {  };
  sound_wing_flap   = array <string> = { "sound_bod\\garg\\garg_wings_1", "sound_bod\\garg\\garg_wings_2", "sound_bod\\garg\\garg_wings_3" };
  sound_mage_appear = array <string> = { "sound_bod\\monst_misc\\mon_appear" };
  sound_mage_death  = array <string> = { "sound_bod\\monst\\mage_death" };  
  sound_damage_absorb = array <string> = { "sound_bod\\hit_armor1", "sound_bod\\hit_armor2", "sound_bod\\hit_armor3" };
  sound_shield_crush = array<string> = { "sound_bod\\shield_destroy" };
}

void InitSounds() {
  //  = SetSounds();
  sound_idle_arr        = SetSounds(sound_idle);
  sound_hide_arr        = SetSounds(sound_hide);
  sound_burn_arr        = SetSounds(sound_burn);
  sound_land_arr        = SetSounds(sound_land);
  sound_death_arr       = SetSounds(sound_death);
  sound_unhide_arr      = SetSounds(sound_unhide);
  sound_appear_arr      = SetSounds(sound_appear);
  sound_attack_arr      = SetSounds(sound_attack);
  sound_damage_arr      = SetSounds(sound_damage);
  sound_damage_absorb_arr = SetSounds(sound_damage_absorb);
  sound_shield_crush_arr = SetSounds(sound_shield_crush);
  sound_unpack_arr      = SetSounds(sound_unpack);
  sound_freeze_arr      = SetSounds(sound_freeze);
  sound_explode_arr     = SetSounds(sound_explode);
  sound_trigger_arr     = SetSounds(sound_trigger);
  sound_wing_flap_arr   = SetSounds(sound_wing_flap);
  sound_disappear_arr   = SetSounds(sound_disappear);
  sound_crit_jump_arr   = SetSounds(sound_crit_jump);
  sound_add_death_arr   = SetSounds(sound_add_death);
  sound_cast_start_arr  = SetSounds(sound_cast_start);
  sound_add_appear_arr  = SetSounds(sound_add_appear);
  sound_mage_appear_arr = SetSounds(sound_mage_appear);
  sound_mage_death_arr  = SetSounds(sound_mage_death);
  sound_scare_jump_arr  = SetSounds(sound_scare_jump);

  sound_land_boss_arr       = SetSounds(sound_land_boss);
  sound_death_boss_arr      = SetSounds(sound_death_boss);
  sound_attack_boss_arr     = SetSounds(sound_attack_boss);
  sound_damage_boss_arr     = SetSounds(sound_damage_boss);
  sound_crit_jump_boss_arr  = SetSounds(sound_crit_jump_boss);
  sound_scare_jump_boss_arr = SetSounds(sound_scare_jump_boss);
  sound_cast_start_boss_arr = SetSounds(sound_cast_start_boss);
  sound_trigger_boss_arr    = SetSounds(sound_trigger_boss);

}

void InitHierarchy() {
  PreLoadHierarchy(hierarchy);
  PreLoadHierarchy(boss_hierarchy);
}

void ReleaseSounds() {
  ReleaseSounds(sound_idle_arr);
  ReleaseSounds(sound_hide_arr);
  ReleaseSounds(sound_burn_arr);
  ReleaseSounds(sound_land_arr);
  ReleaseSounds(sound_death_arr);
  ReleaseSounds(sound_unhide_arr);
  ReleaseSounds(sound_appear_arr);
  ReleaseSounds(sound_attack_arr);
  ReleaseSounds(sound_damage_arr);
  ReleaseSounds(sound_damage_absorb_arr);
  ReleaseSounds(sound_shield_crush_arr);
  ReleaseSounds(sound_unpack_arr);
  ReleaseSounds(sound_freeze_arr);
  ReleaseSounds(sound_explode_arr);
  ReleaseSounds(sound_trigger_arr);
  ReleaseSounds(sound_wing_flap_arr);
  ReleaseSounds(sound_disappear_arr);
  ReleaseSounds(sound_crit_jump_arr);
  ReleaseSounds(sound_add_death_arr);
  ReleaseSounds(sound_cast_start_arr);
  ReleaseSounds(sound_add_appear_arr);
  ReleaseSounds(sound_mage_death_arr);
  ReleaseSounds(sound_scare_jump_arr);

  ReleaseSounds(sound_land_boss_arr);
  ReleaseSounds(sound_death_boss_arr);
  ReleaseSounds(sound_attack_boss_arr);
  ReleaseSounds(sound_damage_boss_arr);
  ReleaseSounds(sound_crit_jump_boss_arr);
  ReleaseSounds(sound_scare_jump_boss_arr);
  ReleaseSounds(sound_cast_start_boss_arr);
  ReleaseSounds(sound_trigger_boss_arr);
}

class MonsterBase {

  // Store current casting effects for easy removal
  BodPartFXObj @caster_current_fx_back;
  BodPartFXObj @caster_current_fx_front;
  BodPartFXObj @caster_current_fx_floor;

  MonsterBase() {

  }

  // ~MonsterBase() {
    // //DebugLog('DESTRUCTOR TEST');
  // }

  bool InitMonster(BodMonsterObj @monst, BodMonsterState state, u8 dir) {

    if (monst.IsBoss()) {
      monst.SetScale(boss_scale);
      monst.SetHierarchy(boss_hierarchy, dir);
    } else {
      monst.SetHierarchy(hierarchy, dir);
    }

    // This checks if monster was summoned with custom appear. eg Imp Rain
    if (state == DMS_APPEAR) {
      GenericEffectParams p;
      appearFx(monst, p);
    }

    idle_mover_multiplier = idle_mover_multiplier * monst.RandFloat(.8f, 1.2f);
    AddIdleMover(monst);

    return true;
  }

  // zwrócenie false wywoła domyślną logikę (setup domyślnego efektu appear / disappear / death)
  bool OnEnterState(BodMonsterObj @monst, BodMonsterState prev_state, BodMonsterState new_state, int param) {
    
    /**
     * returning false will apply additional effects from code, it should be
     * done by default for every state other than appear and death
     *
     * TODO: consider refatoring state handling functions to return booleans
     * this way each family and monster could decide if state should be prcessed
     * further; at the moment of writing no such functionality is requred
     */
    bool ready = false;

    // State exit logic
    switch (prev_state) {
    case DMS_APPEAR:
      break;

    case DMS_JUMP:
      landFx(monst);
      break;

    case DMS_CASTING:
      this.killSpellEffects();
      monst.GetHierInst().InsertMover(CreateJumpFlexMover(-0.2f, 0.6f, false));
      landFx(monst, 0.2f);
      break;

    case DMS_HIDDEN:
      this.unhideFx(monst);
      break;
    }

    // State enter logic
    switch (new_state) {
    case DMS_JUMP:
      PlayEventSound(CRIT_JUMP, monst);
      break;

    case DMS_IDLE:
      this.idleFx(monst);
      break;

    /**
     * DMS_APPEAR fires here on state CHANGE. If monster just spawned
     * this code won't be invoked.
     */
    case DMS_APPEAR:
      if (param == TRANS_GENERIC) {
        GenericEffectParams p;
        this.appearFx(monst, p);
        ready = true;
      }
      break;

    case DMS_CASTING:
      this.castSpellEffects(monst);
      break;

    case DMS_DISAPPEAR:
      this.disappearFx(monst);
      break;

    case DMS_HIDDEN:
     this.hideFx(monst);
     break;

    case DMS_DEAD:
    {
      GenericEffectParams p;
      this.deathFx(monst, p);
      ready = true;
    }
    break;
    }

    if (new_state != prev_state) {

      if (new_state == DMS_MOVE_TO_DEST) {
        AddWalkMover(monst);
      } else if (prev_state == DMS_MOVE_TO_DEST) {
        RemoveWalkMover(monst);
      }

      if (new_state == DMS_IDLE) {
        AddIdleMover(monst);
      } else if (prev_state == DMS_IDLE) {
        RemoveIdleMover(monst);
      }

    }

    return ready;
  }

  bool OnDamage(BodMonsterObj @monst, BodMonsterDmgResult result, u16 damage, bool fire, bool ice, bool shield_crush) {
    if (result == BMDR_NORMAL || result == BMDR_DEATH) {
      monst.GetHierInst().InsertMover(CreateHitMover(10.0f, 3.0f));
      if (!monst.IsFrozen()) {
      {
        f32 delay = shield_crush ? 0.2f : 0.f;
        PlayEventSound(DAMAGE, monst, delay, 1.f);
      }
      }
    }
    else if (!shield_crush)
    {
      PlayEventSound(DAMAGE_ABSORB, monst, 0.f, 1.f);
    }

    if (shield_crush)
      PlayEventSound(SHIELD_CRUSH, monst, 0.f, 1.f);

    return true;
  }

  bool OnScare(BodMonsterObj @monst) {
    PlayEventSound(SCARE_JUMP, monst);
    return true;
  }

  void deathFx(BodMonsterObj @monst, GenericEffectParams p) {

    if (monst.IsBoss()) {
      p = this.bossDeathFx(monst, p);

      PlayEventSound(EXPLODE, monst);
      this.shrapnelFx(monst);
    } else {

      if (monst.IsFrozen()) {
        p = this.iceDeathFx(monst, p);
      } else if (PointInFire(monst.GetPos())) {
        p = this.fireDeathFx(monst, p);
      } else {
        p = this.defaultDeathFx(monst, p);
      }

      if (monst.IsPoison()) {
        /**
         * NOTE: this checks if monsters hearts are of POISON type not if it is
         *  POISONED. I use this to check if monster should explode.
         */
        p = this.poisonDeathFx(monst, p);
      }
    }

    PlaySound(RndFrom(sound_add_death_arr), monst.GetPos()); // non standard so no PlayEventSound
    PlayEventSound(DEATH, monst);

    monst.GenericEffect(p);
  }

  void appearFx(BodMonsterObj @monst, GenericEffectParams p) {

    p.Preset(appear_preset);

    p.m_SpeedMult = appear_preset_speed_mult;
    p.m_EaseX     = appear_preset_easeX;
    p.m_EaseY     = appear_preset_easeY;

    PlaySound(RndFrom(sound_add_appear_arr), monst.GetPos()); // non standard so no PlayEventSound
    PlayEventSound(APPEAR, monst);

    BCCGDungeon::Get().AddFxToObj(appear_fx, monst, true, true, 0.0f, false).SetEmitterOffset(effect_offset);

    monst.GenericEffect(p);
  }

  void disappearFx(BodMonsterObj @monst) {
    PlayEventSound(DISAPPEAR, monst);
  }

  void landFx(BodMonsterObj @monst, f32 delay = 0.0f) {
    
    BCCGDungeon::Get().AddFxToObj(land_fx_f, monst, false, true, delay, false);
    BCCGDungeon::Get().AddFxToObj(land_fx_b, monst, true, true, delay, false);

    PlayEventSound(LAND, monst);
  }

  void idleFx(BodMonsterObj @monst) {
    if (monst.Rand(0, 1000) < 3) {
      PlayEventSound(IDLE, monst);
    }
  }

  BodPartFXObj @addFx(BodMonsterObj @monst, string fx, bool follow, bool addToFront) {
    return BCCGDungeon::Get().AddFxToObj(fx, monst, follow, addToFront);
  }

  void unhideFx(BodMonsterObj @monst) {
    PlayEventSound(UNHIDE, monst);
  }

  void hideFx(BodMonsterObj @monst) {
    PlayEventSound(HIDE, monst);
  }

  /**
   * An explosion effect with particles flying from the explosion centre and on
   * ground decals.
   */
  void shrapnelFx(BodMonsterObj @monst) {
    BCCGDungeon::Get().AddShrapnelsOnPos(
      monst.GetPos(),
      boss_death_fx_shrapnel_radius,
      boss_death_fx_shrapnel_scale,
      boss_death_fx_shrapnel_sprite_range[0],
      boss_death_fx_shrapnel_sprite_range[1],
      boss_death_fx_shrapnel_decal,
      boss_death_fx_shrapnel_effect,
      boss_death_fx_shrapnel_delay_range[0],
      boss_death_fx_shrapnel_delay_range[1],
      boss_death_fx_shrapnel_amount,
      boss_death_fx_shrapnel_height_range[0],
      boss_death_fx_shrapnel_height_range[1],
      boss_death_fx_shrapnel_use_true_dt
      );
  }

  GenericEffectParams iceDeathFx(BodMonsterObj @monst, GenericEffectParams p) {
    BCCGDungeon::Get().AddFxToObj(ice_death_fx, monst, true, true).SetEmitterOffset(effect_offset);
    BCCGDungeon::Get().AddDecalOnPos(monst.GetPos(), DECAL_ICE, 5.0f, 0.3f);
    p.Preset(HGEP_FROZEN_DISAPPEAR);
    return p;
  }

  GenericEffectParams fireDeathFx(BodMonsterObj @monst, GenericEffectParams p) {
    BCCGDungeon::Get().AddFxToObj(fire_death_fx, monst, true, true).SetEmitterOffset(effect_offset);
    BCCGDungeon::Get().AddDecalOnPos(monst.GetPos(), DECAL_CRATER, 5.0f, 0.3f);
    PlayEventSound(BURN, monst);
    p.Preset(HGEP_FIRE_DISAPPEAR);
    return p;
  }

  GenericEffectParams poisonDeathFx(BodMonsterObj @monst, GenericEffectParams p) {
    BCCGDungeon::Get().AddFxToObj(poison_death_fx, monst, false, false).SetEmitterOffset(effect_offset);
    PlayEventSound(EXPLODE, monst);
    // p.Preset(HGEP_ZOMBIE_DISAPPEAR); // Monsters have their own poison deaths eg. green flames
    return p;
  }

  GenericEffectParams bossDeathFx(BodMonsterObj @monst, GenericEffectParams p) {
    p.Preset(boss_disappear_preset);
    p.m_EaseX = boss_disappear_preset_easeX;
    p.m_EaseY = boss_disappear_preset_easeY;
    BCCGDungeon::Get().AddFxToObj(boss_death_fx, monst, true, true).SetEmitterOffset(boss_effect_offset);
    return p;
  }

  GenericEffectParams defaultDeathFx(BodMonsterObj @monst, GenericEffectParams p) {
    p.Preset(disappear_preset);
    p.m_EaseX = disappear_preset_easeX;
    p.m_EaseY = disappear_preset_easeY;

    if (dissapear_preset_FadeToVal != 0.0f) {
      p.m_FadeToVal = dissapear_preset_FadeToVal;
    }
    if (dissapear_preset_FadeStart != 0.0f) {
      p.m_FadeStart = dissapear_preset_FadeStart;
    }
    if (dissapear_preset_FadeEnd != 0.0f) {
      p.m_FadeEnd = dissapear_preset_FadeEnd;
    }
    if (dissapear_preset_SpeedMult != 0.0f) {
      p.m_SpeedMult = dissapear_preset_SpeedMult;
    }
    if (disappear_preset_CrashScaleMax != 0.0f) {
      p.f32CrashScaleMax = disappear_preset_CrashScaleMax;
    }
    if (disappear_preset_CrashScaleMin != 0.0f) {
      p.f32CrashScaleMin = disappear_preset_CrashScaleMin;
    }
    if (disappear_preset_CrashMaxY != 0.0f) {
      p.m_CrashMaxY = disappear_preset_CrashMaxY;
    }
    if (disappear_preset_CrashMinY != 0.0f) {
      p.m_CrashMinY = disappear_preset_CrashMinY;
    }

    p.m_CrashColorEnd   = disappear_preset_CrashColorEnd;
    p.m_CrashColorStart = disappear_preset_CrashColorStart;
    BCCGDungeon::Get().AddFxToObj(death_fx, monst, true, true).SetEmitterOffset(effect_offset);
    return p;
  }

  /**
   * On attack hook.
   * param  monst       atakujący Monster
   * param  attacked    obiekt w dungeonie który został zaatakowany
   * param  attack_mode see \code\\source\\demons\\Bod_MonsterTypeData.h:99
   * return             zwracana wartość to długosć wyskoku jaki potwór robi w kierunku celu
   */
   f32 OnAttack(BodMonsterObj @monst, BodDungObj @attacked, BodMonsterAttMode attack_mode) {
     switch (attack_mode) {
   
     case BMAM_CRIT:
      PlayEventSound(CRIT_JUMP, monst);
      break;

     case BMAM_DOUBLE:
      PlayEventSound(ATTACK, monst);
      PlayEventSound(ATTACK, monst, db_att_delay);
      break;

     default:
       PlayEventSound(ATTACK, monst);
       break;
     }

     return attack_jump_length;
   }

  // zwracana wartosć obecnie nic nie robi
  bool OnCollideWithWall(BodMonsterObj @monst) {
    // LOG("wall!");
    return true;
  }

  // zwracana wartosć obecnie nic nie robi
  bool OnCollideWithObj(BodMonsterObj @monst, BodDungObj @collider) {
    // LOG("object!");
    return true;
  }

  s32 GetId(BodMonsterObj @monst) {
	return parseInt(monsterId);
  }

  void OnEvent(BodMonsterObj @monst, BodMonsterEvent evt) {
    //switch (evt) {
    //case BME_COWARD:
    //  PlayEventSound(SCARE_JUMP, monst);
    //  break;
    //}
  }

  // Override this method to change monster's walk style
  void AddWalkMover(BodMonsterObj @monst) {
    f32 multiplier = (walk_mover_multiplier == 0.0f) ? monst.GetMoveSpeed() / monst.GetHierInst().GetReferenceSpeed() : walk_mover_multiplier;
    HierMover @mover = CreateWalkMover(multiplier, monst.IsBoss() ? BDST_FOOTSTEP_BOSS : footstep_sound_preset, monst);

    SetWalkMover(monst, mover);
  }

  void AddIdleMover(BodMonsterObj @monst) {
    // DebugLog('idle_mover_multiplier: ' + idle_mover_multiplier);
    if (idle_mover_multiplier != 0) {
      SetIdleMover(monst, CreateIdleMover(idle_mover_multiplier));
      // DebugLog('Adding Idle Mover');
    }
  }

  // Override this method to change monster's walk style
  // void KillWalkMover(BodMonsterObj @monst) { // NOTE: This is an alias // TODO: Refactor other calls to use Remove?
  //   RemoveWalkMover(monst);
  //   // HierMover @mover = GetMover(monst, walk_mover_id);
  //   //
  //   // if (@mover != null) {
  //   //   mover.SetUserID(0);
  //   //   mover.Kill();
  //   // }
  // }

  void SetFlyMover(BodMonsterObj @monst, HierMover @mover) {
    SetMover(monst, mover, fly_mover_id);
  }

  void SetWalkMover(BodMonsterObj @monst, HierMover @mover) {
    SetMover(monst, mover, walk_mover_id);
  }

  void SetIdleMover(BodMonsterObj @monst, HierMover @mover) {
    //LOG("Set Idle Mover logic");
    SetMover(monst, mover, idle_mover_id);
  }

  void RemoveFlyMover(BodMonsterObj @monst) {
    RemoveMover(monst, fly_mover_id);
  }

  void RemoveWalkMover(BodMonsterObj @monst) {
    RemoveMover(monst, walk_mover_id);
  }

  void RemoveIdleMover(BodMonsterObj @monst) {
    RemoveMover(monst, idle_mover_id);
  }

  // Override this method to change monster's footstep sound
  // moved to a property, left for compatibility
  BodDungSoundType GetFootstepSound() {
    return footstep_sound_preset;
  }

  f32 GetStarsScale() {
    return star_scale;
  }

  // Shared Caster logic
  void castSpellEffects(BodMonsterObj @monst) {
    if (caster_nonmagic) {
      this.skillCast(monst);
    } else {
      PlayEventSound(CAST_START, monst);
      this.spellCast(monst);
    }
  }

  void spellCast(BodMonsterObj @monst) {
    @caster_current_fx_back  = BCCGDungeon::Get().AddFxToObj(caster_fx_back, monst, false, false, 0.f, false);
    @caster_current_fx_front = BCCGDungeon::Get().AddFxToObj(caster_fx_front, monst, false, true, 0.f, false);
    @caster_current_fx_floor = BCCGDungeon::Get().AddFxToObj(caster_fx_floor, monst, false, false, 0.f, true);
  }

  void skillCast(BodMonsterObj @monst) {
    @caster_current_fx_back  = BCCGDungeon::Get().AddFxToObj(caster_fx_nonmagic_back, monst, false, false, 0.f, false);
    @caster_current_fx_front = BCCGDungeon::Get().AddFxToObj(caster_fx_nonmagic_front, monst, false, true, 0.f, false);
  }

  void killSpellEffects() {
    if (@caster_current_fx_back != null) {
      caster_current_fx_back.Kill();
    }
    if (@caster_current_fx_front != null) {
      caster_current_fx_front.Kill();
    }
    if (@caster_current_fx_floor != null) {
      caster_current_fx_floor.Kill();
    }

    @caster_current_fx_back  = null;
    @caster_current_fx_front = null;
    @caster_current_fx_floor = null;
  }

  // This plays the passed sound
  void PlaySound(Sound@ sound, Point2D_f32 pos, f32 delay = 0.0f, f32 pitch = 1.0f, f32 vol = 1.0f, bool force_normal_pitch_volume = false) {
    if (@sound == null) {
      return;
    }
    
    f32 rand_amount = 0.10f;

    if (force_normal_pitch_volume) {
      pitch = 1.f;
      vol = 1.f;
    }
    pitch = RandFloat(pitch, pitch + rand_amount);
    vol = RandFloat(vol, vol + rand_amount);

    BCCGDungeon::Get().PlayDungSound(sound, pos, vol, pitch, delay);
  }

  void PlaySoundLowPriority(Sound@ sound, Point2D_f32 pos, f32 delay = 0.0f, f32 pitch = 1.0f, f32 vol = 1.0f) {
    if (@sound == null) {
      return;
   	}
		
    pitch = RandFloat(pitch, pitch + 0.1f);
    BCCGDungeon::Get().PlayDungSound(sound, pos, vol, pitch, delay, BDSP_LOW);
  }

  void PlayEventSound(int event, BodMonsterObj @monst, f32 delay = 0.0f, f32 pitch_mod = 1.0f) {
    
    bool isBoss = monst.IsBoss();
    Point2D_f32 pos = monst.GetPos();
    f32 pitch = (isBoss) ? sound_option_pitch_boss : sound_option_pitch;
    pitch *= pitch_mod;

    f32 volume = (isBoss) ? sound_option_vol_boss : sound_option_vol;
    
    array<Sound @> sound_arr;

    switch (event) {
      case IDLE:
        sound_arr = sound_idle_arr;
        break;
      case HIDE:
        sound_arr = sound_hide_arr;
        break;
      case BURN:
        sound_arr = sound_burn_arr;
        break;
      case LAND:
        sound_arr = (isBoss) ? sound_land_boss_arr : sound_land_arr;
        break;
      case DEATH:
        break;
      case UNHIDE:
        sound_arr = sound_unhide_arr;
        break;
      case APPEAR:
        sound_arr = sound_appear_arr;
        break;
      case ATTACK:
        sound_arr = (isBoss) ? sound_attack_boss_arr : sound_attack_arr;
        break;
      case DAMAGE:
        sound_arr = (isBoss) ? sound_damage_boss_arr : sound_damage_arr;
        break;
      case DAMAGE_ABSORB:
        sound_arr = sound_damage_absorb_arr;
        break;
      case SHIELD_CRUSH:
        sound_arr = sound_shield_crush_arr;
        break;
      case UNPACK:
        sound_arr = sound_unpack_arr;
        break;
      case FREEZE:
        sound_arr = sound_freeze_arr;
        break;
      case EXPLODE:
        sound_arr = sound_explode_arr;
        break;
      case DISAPPEAR:
        sound_arr = sound_disappear_arr;
        break;
      case CRIT_JUMP:
        sound_arr = (isBoss) ? sound_crit_jump_boss_arr : sound_crit_jump_arr;
        break;
      case CAST_START:
        sound_arr = (isBoss) ? sound_cast_start_boss_arr : sound_cast_start_arr;
        break;
      case MAGE_APPEAR:
        sound_arr = sound_mage_appear_arr;
        break;
      case MAGE_DEATH:
        sound_arr = sound_mage_death_arr;
        break;
    }

    PlaySound(RndFrom(sound_arr), pos, delay, pitch, volume);
  };

  void DebugLog(string str) {
    #ifdef SCRIPT_DEBUG
    LOG('SCRIPT: ' + monsterId + ': ' + str);
    #endif
    return;
  }
}

void DebugLog(string str) {
  #ifdef SCRIPT_DEBUG
  LOG('SCRIPT: ' + str);
  #endif
  return;
}

/**
 * Check if monster is boss and has dedicated sound in passed array
 */
 /*
bool bossHasDedicatedSounds(BodMonsterObj @monst, array <string> boss_sound_overrides) {
  return (monst.IsBoss() && boss_sound_overrides.length != 0) ? true : false;
}
*/

/**
 * Use set and get mover to standardize mover management.
 * @param monst
 * @param mover
 * @param id    default ids are stored in MonsterBase
 */
void SetMover(BodMonsterObj @monst, HierMover @mover, int id) {
  if (!HasMover(monst, id)) {
    mover.SetUserID(id);
    monst.GetHierInst().InsertMover(mover);
    //DebugLog('Mover ' + id + ' added');
  } else {
    //DebugLog('Mover ' + id + ' not added. It would override existing mover of the same ID!!!');
  }
};

/**
 * Use set and get mover to standardize mover management.
 * @param monst
 * @param id    default ids are stored in MonsterBase
 * @return       retrieved mover
 */
HierMover@ GetMover(BodMonsterObj @monst, int id) {
  HierMover@ mover = monst.GetHierInst().FindMover(id, null);

  return mover;
};

/**
 * Use set and get mover to standardize mover management.
 * @param monst
 * @param id    default ids are stored in MonsterBase
 */
void RemoveMover(BodMonsterObj @monst, int id) {
  if (HasMover(monst, id)) {
    HierMover @mover = GetMover(monst, id);
    mover.SetUserID(0);
    // monst.GetHierInst().RemoveMover(mover);
    mover.Kill();
  }
};

bool HasMover(BodMonsterObj @monst, int id) {
  return @GetMover(monst, id) != null;
}

/**
 * Used with monst.GetPos() to determine if monster stands in flames.
 * @param  point
 * @return       boolean
 */
bool PointInFire(Point2D_f32 point) {
  return BCCGDungeon::Get().IsPointInFire(point);
}

/*
Sound@ GetSound(string path, string file) {
  string soundPath = (path.length() == 0) ? "sound_bod\\" + file + ".ogg" : "sound_bod\\" + path + "\\" + file + ".ogg";

  return SoundManager::GetSound(soundPath);
}
*/

Sound@ GetSound(string uri) {
  return SoundManager::GetSound(uri + ".ogg");
}

Sound@ RndFrom(array <Sound@> @arr) {
  int s = arr.size();
  if (s != 0) {
    return arr[Rand(0, s - 1)];
  }
  return null;
}

/**
 * Sound arays handling
 * I need a sane way to handle arrays of sounds that can only be created and
 * updated with push_back method
 */
/**
 * Set up an array of sound handles. Clear the array if it already has elements.
 * Use this to set parent sound arrays and override them in child classes.
 *
 */
array<Sound @> SetSounds(array<string> sounds_uris) {
  array <Sound @> sound_array;
  for (uint i = 0; i < sounds_uris.length(); i++) {
    sound_array.insertLast(GetSound(sounds_uris[i]));
  }
  return sound_array;
}

void ReleaseSounds(array<Sound @> sound_array) {
  for (uint i = 0; i < sound_array.length(); i++) {
    // sound_array[i].Release();
    @sound_array[i] = null;
  }
}

void CloseModule() {
  ReleaseHierarchy(hierarchy);
  ReleaseHierarchy(boss_hierarchy);
  ReleaseSounds();
}


string filenameFromPath(string path) {
  return path.substr(path.findLast('\\') + 1);
}
