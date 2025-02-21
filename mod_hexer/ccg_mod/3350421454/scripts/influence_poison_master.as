class Influence
{
    bool IsGlobal(){return false;}
    bool ShouldDisplayCounter(){return false;}
    bool HasWidget(){return false;}

    int ProcessEvent(Event@ evt, BCCGInfluenceInstanceBase@ influence)
    {
        EventType@ type = evt.GetEventType();

        if(type is @BCCG_BATTLE_SOMEONE_PLAYED_CARD)
        {
            BCCGBattleSomeonePlayedCardEvent@ card_evt = cast<BCCGBattleSomeonePlayedCardEvent>(evt);
            BCCGCardContext@ cont = card_evt.GetContext();

            BCCGCharacterObj@ character = cont.m_pCharInst;

            if(character.GetId() != influence.GetLinkedCharacterId() 
               || !character.IsOwnedByLocalPlayer())
                return 1;

            if(CardHasTag(cont.m_pClass, poisonCardTag))
                influence.SetCounter(counter + cont.m_pParams.GetParam(PoisonParam));
        }

        return 1;
    }
    
    void SetCounter(int val, BCCGInfluenceInstanceBase@ influence)
    {
        BCCGCharacterObj@ character = cast<BCCGCharacterObj>(GetObjById(influence.GetLinkedCharacterId()));
        if(character == null)
            return;

        int previous_counter = counter;
        counter = val;

        if(previous_counter<counter)
        {
            influence.TriggerOwnerEffects(GetDungeon());
            influence.TriggerUsedEffect();
            TriggerInfluenceEffectOnTarget(influence, GetDungeon(), character);
        }

        if(!character.IsOwnedByLocalPlayer())
            return;

        if(previous_counter < counter)
        {
            int amount = counter - previous_counter;

            BCCGCharacterObj@ character = cast<BCCGCharacterObj>(GetObjById(influence.GetLinkedCharacterId()));

            for(int i = 0; i < amount; i++)
            {
                AddCardToPile(character, poisonIncreaseCard, BCCGCardPile::DrawPile);
            }
        }

        BCCGInfluenceInstanceBase@ poisonInfluence = FindPushedInfluenceByTag(poisonBaseTag, influence.GetLinkedCharacterId());

        if(counter > 0 && poisonInfluence == null)
        {
            BCCGInfluenceClass@ addedInfluence = FindInfluence(poisonInfluenceName);
            BCCGInfluenceInstanceBase@ newInfluence = CreateInfluenceInstance(addedInfluence, influence.GetLinkedCharacterId());
                
            newInfluence.SetCounter(counter);

            PushInfluence(GetDungeon(), newInfluence, cast<BCCGCharacterObj>(GetObjById(influence.GetLinkedCharacterId())));

            Release(newInfluence);
            return;
        }

        if (counter <= 0 && poisonInfluence != null)
        {
            poisonInfluence.ForceRemove();
            return;
        }

        if(counter <=0 && poisonInfluence == null)
            return;

        poisonInfluence.SetCounter(counter);

    }

    int GetCounter()
    {
        return counter;
    }

    BCCGCardParam PoisonParam = BCCGCardParam::CachedNum1;

    string poisonCardTag = "poison";
    string poisonBaseTag = "poison_base";
    string poisonInfluenceName = "poison_influence";

    string poisonIncreaseCard = "car_toxin_hex";

    int counter = 0;
    bool firstExecution = true;
}

Influence@ CreateInfluence()
{
    return Influence();
}