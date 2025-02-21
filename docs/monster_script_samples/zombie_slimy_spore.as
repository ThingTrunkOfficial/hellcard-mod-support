// #define TAGS
#include "scripts\zombie.as"

void InitModule() {
  InitZombie();

  monsterId = '609';

  // Overrides
  hierarchy      = "char\\zombie_slimy_spore.cug";
  boss_hierarchy = hierarchy;

  disappear_preset_CrashScaleMax = 0.6f;
  disappear_preset_CrashScaleMin = 0.3f;

  // Sounds
  sound_appear     = array <string> = { "sound_bod\\zombie\\slimy_land" };
  sound_death      = array <string> = { "sound_bod\\zombie\\slimy_hatch" };
  sound_land       = sound_appear;
  sound_damage     = array <string> = {  }; // mute
  sound_trigger    = array <string> = {  }; // mute
  sound_add_death  = array <string> = {  }; // mute

  sound_death_boss      = sound_death;
  // sound_attack_boss     = sound_attack;
  // sound_damage_boss     = sound_damage;
  // sound_trigger_boss    = sound_trigger;
  // sound_crit_jump_boss  = sound_crit_jump;
  // sound_scare_jump_boss = sound_scare_jump;
  // sound_cast_start_boss = sound_cast_start;

  InitSounds();
  InitHierarchy();
}

class Monster : Zombie, Stationary {

  bool InitMonster(BodMonsterObj @monst, BodMonsterState state, u8 dir) {
    Zombie::InitMonster(monst, state, dir);
    return true;
  }
};
