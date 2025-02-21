#include "scripts\common.as"
void InitModule() {
  PreLoadHierarchy("char\\surprise.cug");
}

// analogicznie jak init, ale wywoływana kiedy moduł jest czyszczony albo niszczony
void CloseModule() {
  ReleaseHierarchy("char\\surprise.cug");
}

class Monster {
  // konstruktor - wywoła się zawsze, niezależnie czy potwór jest tworzony (jako nowy), czy wczytywnay
  // nie musi go być (wtedy kompilator stworzy domyślny, pusty)
  Monster() {
    // LOG("Potwor stworzony!");
  }

  // potwór jest tworzony (jako nowy)
  // state - gwarantowane że będzie DMS_IDLE, DMS_HIDDEN albo DMS_APPEAR
  // zwrócenie false jest jednoznaczne z nie zaimplementowaniem tej funkcji (wykona się domyślna logika)
  // hierarchię trzeba ustawić przed wywoałniem jakichkolwiek funkcji z nią związanych (np.  AppearFromGround)
  // jeżeli hierarchii się nie ustawi to zostanie ustawiona na domyślną (po wyjściu z tej funkcji)
  bool InitMonster(BodMonsterObj @monst, BodMonsterState state, u8 dir) {
    monst.SetHierarchy("char\\surprise.cug", dir);

    return true;
  }

  // zwrócenie false wywoła domyślną logikę (setup domyślnego efektu appear / disappear / death)
  bool OnEnterState(BodMonsterObj @monst, BodMonsterState prev_state, BodMonsterState new_state, int param) {
    if (new_state == DMS_DEAD) {
      GenericEffectParams p;
      p.m_ScaleEndVal = 0.01f;
      p.m_SpanMin     = 0.05f;
      p.m_SpanMax     = 0.1f;
      BodDungeon::Get().AddFxToObj("effects\\dung_barrel_exp_fx.cug", monst, true, true);
      // monst.GenericEffect(p);
      return true;
    }
    return false;
  }

  // zwrócenie false spowoduje dodawanie standartowego hit movera
  bool OnDamage(BodMonsterObj @monst, BodMonsterDmgResult result, u16 damage, bool fire, bool ic, bool shield_crush) {
    return false;
  }

  // zwracana wartość to długosć wyskoku jaki potwór robi w kierunku celu
  f32 OnAttack(BodMonsterObj @monst, BodDungObj @attacked, BodMonsterAttMode attack_mode) {
    PlaySound(RndFrom(monst_att), monst.GetPos());
    return 25.0f;
  }

  // zwaracana wartosć obecnie nic nie robi
  // obsługuje trigger (true) i detrigger (false)
  bool OnTrigger(BodMonsterObj @monst, BodDungObj @who, bool triggered) {
    // LOG("Monster triggered = " + triggered);
    return true;
  }

  // zwracana wartosć obecnie nic nie robi
  bool OnUnpack(BodMonsterObj @monst) {
    // LOG("Unpack!");
    return true;
  }

  // zwracana wartosć obecnie nic nie robi
  bool OnCollideWithWall(BodMonsterObj @monst) {
    // LOG("wall!");
    return true;
  }

  // zwracana wartosć obecnie nic nie robi
  bool OnCollideWithObj(BodMonsterObj @monst, BodDungObj @collider) {
    // LOG("object!");
    return true;
  }
}
