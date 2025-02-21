#include "scripts\skeleton.as"

void InitModule() {
  InitSkeleton();

  monsterId = '403';

  hierarchy      = "char\\skeleton_skeleton_archer.cug";
  boss_hierarchy = hierarchy;

  caster_nonmagic = true;

  // sound_death_boss      = sound_death; // skeleton bosses have special sound, no need to override
  // sound_attack_boss     = sound_attack;
  // sound_damage_boss     = sound_damage;
  // sound_trigger_boss    = sound_trigger; // skeleton bosses have special sound, no need to override
  // sound_crit_jump_boss  = sound_crit_jump;
  // sound_scare_jump_boss = sound_scare_jump;
  // sound_cast_start_boss = sound_cast_start;

  InitSounds();
  InitHierarchy();
}

class Monster : Skeleton, Ranged {
  bool InitMonster(BodMonsterObj @monst, BodMonsterState state, u8 dir) {
    Skeleton::InitMonster(monst, state, dir);
    if (monst.IsBoss()) {
      monst.GetHierInst().SetState("hat", 0.1f);
    }
    return true;
  }
}
