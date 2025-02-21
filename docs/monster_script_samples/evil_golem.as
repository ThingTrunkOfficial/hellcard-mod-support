#include "scripts\evil.as"


void InitModule() {
  InitEvil();
  monsterId = 'Evil Golem';
  // Overrides
  hierarchy      = "char\\evil_golem.cug";
  boss_hierarchy = hierarchy;

  caster_nonmagic = true;

  fire_death_fx = "effects\\monst_fire_death.cug";
  ice_death_fx  = "effects\\monst_ice_death.cug";
  death_fx      = "effects\\monst_gargoyle_big_death.cug";

  appear_fx = "effects\\monst_gargoyle_appear_2.cug";

  sound_death          = array <string> = { "sound_bod\\garg\\garg_v_d1", "sound_bod\\garg\\garg_v_d2" };
  sound_appear         = array <string> = { "sound_bod\\garg\\garg_sm_wake" };
  sound_attack         = array <string> = { "sound_bod\\garg\\garg_v_att1", "sound_bod\\garg\\garg_v_att2" };
  sound_damage         = array <string> = { "sound_bod\\garg\\garg_v_dmg1", "sound_bod\\garg\\garg_v_dmg2" };
  sound_trigger        = array <string> = { "sound_bod\\garg\\garg_v_trig" };
  sound_crit_jump      = array <string> = { "sound_bod\\garg\\garg_v_jump" };
  sound_scare_jump     = array <string> = { "sound_bod\\garg\\garg_v_scared" };
  sound_add_death      = array <string> = { "sound_bod\\garg\\garg_sm_d1", "sound_bod\\garg\\garg_sm_d2" };

  InitSounds();
  InitHierarchy();
}

class Monster : Evil {}
