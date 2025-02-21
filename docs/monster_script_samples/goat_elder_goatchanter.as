#include "scripts\goat.as"

void InitModule() {
  InitGoat();

  monsterId = '210';

  hierarchy      = "char\\goat_elder_goatchanter.cug";
  boss_hierarchy = hierarchy;

  appear_fx = "effects\\monst_goat_mage_appear.cug";

  boss_death_fx_shrapnel_effect = "effects\\monst_boss_trail_magic.cug";

  boss_death_fx_shrapnel_scale  = 1.0f;
  boss_death_fx_shrapnel_amount = 30;

  boss_death_fx_shrapnel_sprite_range = array <u32> = { 318, 326 };

  boss_death_fx = "effects\\monst_boss_exp_magic.cug";

  sound_appear     = array <string> = {}; // mute appear
  
  sound_death      = array <string> = { "sound_bod\\goat\\goat_v_alt_d" };
  sound_cast_start = array <string> = { "sound_bod\\goat\\goat_v_incant" };

  sound_death_boss      = sound_death;
  // sound_attack_boss     = sound_attack;
  // sound_damage_boss     = sound_damage;
  // sound_trigger_boss    = sound_trigger;
  // sound_crit_jump_boss  = sound_crit_jump;
  // sound_scare_jump_boss = sound_scare_jump;
  sound_cast_start_boss = sound_cast_start;

  InitSounds();
  InitHierarchy();
}

class Monster : Goat, Caster, Ranged {
  void appearFx(BodMonsterObj @monst, GenericEffectParams p) {
    monst.AppearFromGround("effects\\monst_goat_mage_appear.cug", 2.0f);
    monst.GetHierInst().InsertMover(CreateRotateMover(16, (monst.Rand(0, 1) == 0), 0.75f));
    BCCGDungeon::Get().AddFxToObj(appear_fx, monst, true, true);
    this.Caster_appearFx(monst);
    PlayEventSound(APPEAR, monst);
  }

  void deathFx(BodMonsterObj @monst, GenericEffectParams p) {
    this.Caster_deathFx(monst);
    Goat::deathFx(monst, p);
  }

  bool OnEnterState(BodMonsterObj @monst, BodMonsterState prev_state, BodMonsterState new_state, int param) {
    if (prev_state == DMS_DEAD) {
      monst.GetHierInst().SetState("dead", 0.1f);
    }

    return Goat::OnEnterState(monst, prev_state, new_state, param);
  }
}
