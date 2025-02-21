// #define TAGS
#include "scripts\zombie.as"

array<Sound @> sound_hopping_jump_arr;
array<string> sound_hopping_jump;
array<Sound @> sound_hopping_land_arr;
array<string> sound_hopping_land;

void InitModule() {
  InitZombie();

  monsterId = '606';

  hierarchy      = "char\\zombie_hopping_corpse.cug";
  boss_hierarchy = hierarchy;

  footstep_sound_preset = BDST_FOOTSTEP_SILENT;

  sound_death      = array <string> = { "sound_bod\\zombie\\zomb_v3_d1", "sound_bod\\zombie\\zomb_v3_d2" };
  sound_attack     = array <string> = { "sound_bod\\zombie\\zomb_v3_att1", "sound_bod\\zombie\\zomb_v3_att2" };
  sound_damage     = array <string> = { "sound_bod\\zombie\\zomb_v3_dmg1", "sound_bod\\zombie\\zomb_v3_dmg2" };
  sound_trigger    = array <string> = { "sound_bod\\zombie\\zomb_v3_trig" };
  sound_crit_jump  = array <string> = { "sound_bod\\zombie\\zomb_v3_jump" };
  sound_scare_jump = array <string> = { "sound_bod\\zombie\\zomb_v3_scared" };

  sound_hopping_jump = array <string> = { "sound_bod\\zombie\\hopping_jump1", "sound_bod\\zombie\\hopping_jump2" };

  sound_hopping_jump_arr = SetSounds(sound_hopping_jump);
  sound_hopping_land_arr = SetSounds(sound_hopping_land);

  sound_death_boss      = sound_death;
  sound_attack_boss     = sound_attack;
  sound_damage_boss     = sound_damage;
  sound_trigger_boss    = sound_trigger;
  sound_crit_jump_boss  = sound_crit_jump;
  sound_scare_jump_boss = sound_scare_jump;
  // sound_cast_start_boss = sound_cast_start;

  InitSounds();
  InitHierarchy();
}

class Monster : Zombie {
  bool InitMonster(BodMonsterObj @monst, BodMonsterState state, u8 dir) {
    Zombie::InitMonster(monst, state, dir);
    if (monst.RandFloat(0, 1) > 0.5) {
      monst.GetHierInst().SetState("head_b", 0.0f);
    }
    return true;
  }

  bool OnEnterState(BodMonsterObj @monst, BodMonsterState prev_state, BodMonsterState new_state, int param) {
    if ((new_state == DMS_IDLE || new_state == DMS_ATTACK) && prev_state == DMS_MOVE_TO_DEST) {
      PlaySound(RndFrom(sound_hopping_land_arr), monst.GetPos()); // non standard so no PlayEventSound
    }

    return Zombie::OnEnterState(monst, prev_state, new_state, param);
  }

  void OnEvent(BodMonsterObj @monst, BodMonsterEvent evt) {
    if (evt == BME_KANGAROO_HOP) {
      PlaySound(RndFrom(sound_hopping_jump_arr), monst.GetPos()); // non standard so no PlayEventSound
    }
    Zombie::OnEvent(monst, evt);
  }

  void AddWalkMover(BodMonsterObj @monst) {
  }
};
