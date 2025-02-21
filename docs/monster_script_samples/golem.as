#include "scripts\evil.as"


void InitModule() {
  InitEvil();
  monsterId = 'Golem';
  // Overrides
  hierarchy      = "char\\evil_golem.cug";
  boss_hierarchy = hierarchy;

  c_multiply = Color(255, 200, 200, 190);
  c_additive = Color(64, 0, 0, 128);
  boss_scale        = 0.8f;

  caster_nonmagic = true;

  fire_death_fx = "effects\\monst_fire_death.cug";
  ice_death_fx  = "effects\\monst_ice_death.cug";
  death_fx      = "effects\\monst_gargoyle_big_death.cug";

  appear_fx = "effects\\monst_gargoyle_appear_2.cug";

  sound_death          = array <string> = { "sound_bod\\golem_v_d" };
  sound_appear         = array <string> = { "sound_bod\\garg\\garg_sm_wake" };
  sound_attack         = array <string> = { "sound_bod\\golem_v_att1", "sound_bod\\golem_v_att2" };
  sound_damage         = array <string> = { "sound_bod\\golem_v_dmg1", "sound_bod\\golem_v_dmg2" };
  sound_trigger        = array <string> = { "sound_bod\\garg\\garg_v_trig" };
  sound_crit_jump      = array <string> = { "sound_bod\\garg\\garg_v_jump" };
  sound_scare_jump     = array <string> = { "sound_bod\\garg\\garg_v_scared" };
  sound_add_death      = array <string> = { "sound_bod\\garg\\garg_sm_d1", "sound_bod\\garg\\garg_sm_d2" };
	
  sound_death_boss      = array <string> = { "sound_bod\\garg\\garg_v_boss_d" };
  sound_attack_boss     = sound_attack;
  sound_damage_boss     = sound_damage;
  // sound_trigger_boss    = array <string> = { "sound_bod\\garg\\garg_v_boss_trig" };
  // sound_crit_jump_boss  = sound_crit_jump;
  // sound_scare_jump_boss = sound_scare_jump;
  footstep_sound_preset = BDST_FOOTSTEP_ARMORED;

  InitSounds();
  InitHierarchy();
}

class Monster : Evil {}
