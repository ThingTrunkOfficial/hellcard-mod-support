// #define TAGS
#include "scripts\zombie.as"

void InitModule() {
  InitZombie();

  monsterId = '604';

  hierarchy      = "char\\zombie_corrupted_priest.cug";
  boss_hierarchy = hierarchy;

  boss_scale = 1.3f;

  sound_attack     = array <string> = { "sound_bod\\zombie\\zomb_v1_att1", "sound_bod\\zombie\\zomb_v1_att2" };
  sound_damage     = array <string> = { "sound_bod\\zombie\\zomb_v1_dmg1", "sound_bod\\zombie\\zomb_v1_dmg2" };
  sound_trigger    = array <string> = { "sound_bod\\zombie\\zomb_v1_trig" };
  sound_crit_jump  = array <string> = { "sound_bod\\zombie\\zomb_v1_jump" };
  sound_scare_jump = array <string> = { "sound_bod\\zombie\\zomb_v1_scared" };
  sound_cast_start = array <string> = { "sound_bod\\zombie\\zomb_v1_incant" };

  // sound_death_boss      = sound_death;
  sound_attack_boss     = sound_attack;
  sound_damage_boss     = sound_damage;
  sound_trigger_boss    = sound_trigger;
  sound_crit_jump_boss  = sound_crit_jump;
  sound_scare_jump_boss = sound_scare_jump;
  // sound_cast_start_boss = sound_cast_start;
  
  InitSounds();
  InitHierarchy();
}

class Monster : Zombie, Caster, Ranged {
  void appearFx(BodMonsterObj @monst, GenericEffectParams p) {
    Zombie::appearFx(monst, p);
    this.Caster_appearFx(monst);
  }

  void deathFx(BodMonsterObj @monst, GenericEffectParams p) {
    Zombie::deathFx(monst, p);
    this.Caster_deathFx(monst);
  }
};
