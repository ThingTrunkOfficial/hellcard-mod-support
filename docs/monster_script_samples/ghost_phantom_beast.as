// #define TAG
#include "scripts\ghost.as"

void InitModule() {
  InitGhost();

  monsterId = '308';

  hierarchy      = "char\\ghost_phantom_beast.cug";
  boss_hierarchy = hierarchy;

  ghost_wobble_speed = 1.0f;
  ghost_wobble_power = 10.0f;
  attack_jump_length = 25.0f;

  InitSounds();
  InitHierarchy();
}

class Monster : Ghost, Ranged {}
