// #define TAG
#include "scripts\ghost.as"

void InitModule() {
  InitGhost();

  monsterId = '304';

  hierarchy      = "char\\ghost_mirage_lancer.cug";
  boss_hierarchy = hierarchy;

  attack_jump_length = 25.0f;

  InitSounds();
  InitHierarchy();
}

class Monster : Ghost, Ranged {}
