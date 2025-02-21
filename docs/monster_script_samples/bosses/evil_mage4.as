#include "scripts\evil.as"

array <string> sound_taunt;

int last_taunt_id = 0;

void InitModule() {
  InitEvil();
  monsterId = 'Evil Mage';

  idle_mover_multiplier = 0.1f;

  // Overrides
  hierarchy      = "char\\evil_mage4.cug";
  boss_hierarchy = hierarchy;

  sound_attack     = array <string> = { "sound_bod\\missile_magic" };

  sound_damage = array <string> = {
    "voices\\mage_ghost_hit0",
    "voices\\mage_ghost_hit1",
    "voices\\mage_ghost_hit2"
  };
  
  sound_death = array <string> = {
    "voices\\mage_ghost_death"
  };

  sound_trigger_boss = array <string> = {
    "voices\\mage_ghost_trigger"
  };

  sound_death_boss      = sound_death;
  sound_attack_boss     = sound_attack;
  sound_damage_boss     = sound_damage;

  sound_taunt = array <string> = {
    "", // zero state doesn't use script, adding this so I dont have to correct the index in enterState
    "voices\\mage_ghost_cast0",
    "voices\\mage_ghost_cast1",
    "voices\\mage_ghost_cast2",
    "voices\\mage_ghost_cast3",
    "voices\\mage_ghost_cast4"
  };

  InitSounds();
  InitHierarchy();
}

class Monster : Evil {

  bool OnEnterState(BodMonsterObj @monst, BodMonsterState prev_state, BodMonsterState new_state, int param) {
    return MonsterBase::OnEnterState(monst, prev_state, new_state, param);
  }

  bool OnTrigger(BodMonsterObj @monst, BodDungObj @who, bool triggered) {
    return true;
  }

  void deathFx(BodMonsterObj @monst, GenericEffectParams p) {
    Evil::deathFx(monst, p);
  }

}
