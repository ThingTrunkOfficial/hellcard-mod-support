class Influence
{
    void OnCharacterDamage(BCCGDungeon@ dung, BCCGCharacterObj@ character, BodDungObj@ from, int absorbed, int blocked, BCCGInfluenceInstanceBase@ influence)
    {
        if(character.GetId() != influence.GetLinkedCharacterId())
            return;

        influence.TriggerOwnerEffects(dung);
        influence.TriggerUsedEffect();
        TriggerInfluenceEffectOnTarget(influence, dung, character);

        if(!character.IsOwnedByLocalPlayer())
            return;

        BCCGCharacterHPController@ ctrl = BCCGCharacterHPController();
        ctrl.Init(absorbed, true);
        ctrl.SetActionBegin(character.GetControllerQueueEndTimestamp());
        ctrl.SetPlayedById(GetId(character));
        character.PushController(ctrl);

        influence.SetCounter(influence.GetCounter() - 1);

        if(influence.GetCounter() <= 0)
            influence.ForceRemove();
    }

    int ProcessEvent(Event@ evt, BCCGInfluenceInstanceBase@ influence)
    {
        EventType@ type = evt.GetEventType();

        if(type == @BCCG_BATTLE_SOMEONE_PLAYED_CARD)
        {
            BCCGBattleSomeonePlayedCardEvent@ card_evt = cast<BCCGBattleSomeonePlayedCardEvent>(evt);
            BCCGCardContext@ cont = card_evt.GetContext();

            BCCGCharacterObj@ character = cont.m_pCharInst;

            if(character.GetId() != influence.GetLinkedCharacterId() 
               || !character.IsOwnedByLocalPlayer())
                return 1;

            if(cont.m_pClass.GetName() == exception)
            {
                int newCounter = influence.GetCounter();
                BCCGInfluenceInstanceBase@ poison = FindPushedInfluenceByTag(poisonBaseTag, influence.GetLinkedCharacterId());

                if(poison != null)
                {
                    newCounter += poison.GetCounter();
                }

                influence.SetCounter(newCounter);
            }
        }

        return 1;
    }

    bool IsGlobal() {return false;}
    bool ShouldDisplayCounter() {return true;}

    string poisonBaseTag = "poison_base";

    string exception = "car_guardiansshield_hex";
}

Influence@ CreateInfluence()
{
    return Influence();
}