// #define TAG
#include "scripts\ghost.as"

void InitModule() {
  InitGhost();

  monsterId = '306';

  hierarchy      = "char\\ghost_mirage_mage.cug";
  boss_hierarchy = hierarchy;

  ghost_wobble_speed = 1.0f;
  ghost_wobble_power = 12.0f;

  InitSounds();
  InitHierarchy();
}

class Monster : Ghost, Caster, Ranged {
  void appearFx(BodMonsterObj @monst, GenericEffectParams p) {
    Ghost::appearFx(monst, p);
    this.Caster_appearFx(monst);
  }

  void deathFx(BodMonsterObj @monst, GenericEffectParams p) {
    Ghost::deathFx(monst, p);
    this.Caster_deathFx(monst);
  }
}
