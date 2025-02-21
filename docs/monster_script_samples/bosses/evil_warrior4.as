#include "scripts\evil.as"

array <string> sound_taunt;

int last_taunt_id = 0;

void InitModule() {
  InitEvil();
  monsterId = 'Evil Warrior';
  // Overrides
  hierarchy      = "char\\evil_warrior4.cug";
  boss_hierarchy = hierarchy;

  sound_attack     = array <string> = { "sound_bod\\garg\\garg_att1", "sound_bod\\garg\\garg_att2" };
  sound_damage     = array <string> = { "voices\\war_ghost_hit0", "voices\\war_ghost_hit1", "voices\\war_ghost_hit2" };
  sound_death      = array <string> = { "voices\\war_ghost_death" };
 
  sound_death_boss      = sound_death;
  sound_attack_boss     = sound_attack;
  sound_damage_boss     = sound_damage;
  sound_trigger_boss = array <string> = { "voices\\war_ghost_trigger" };
 
  caster_nonmagic = true;

  sound_taunt = array <string> = {
    "", // zero state doesn't use script, adding this so I dont have to correct the index in enterState
    "voices\\war_ghost_cast0",
    "voices\\war_ghost_cast1",
    "voices\\war_ghost_cast2",
    "voices\\war_ghost_cast3",
    "voices\\war_ghost_cast4"
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
