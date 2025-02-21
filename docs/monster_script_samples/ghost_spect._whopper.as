// #define TAG
#include "scripts\ghost.as"

void InitModule() {
  InitGhost();

  monsterId = '305';

  hierarchy      = "char\\ghost_spect._whopper.cug";
  boss_hierarchy = hierarchy;

  ghost_wobble_speed = 1.0f;
  ghost_wobble_power = 12.0f;

  InitSounds();
  InitHierarchy();
}

class Monster : Ghost {}
