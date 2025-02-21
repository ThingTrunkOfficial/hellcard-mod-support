class Influence{

    bool IsGlobal() {return false;}
    bool ShouldDisplayCounter() {return true;}

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
                int newCounter = cont.m_pParams.GetParam(BCCGCardParam::Block);
                
                influence.SetCounter(influence.GetCounter() + newCounter);
                accumulatedPoison += 2;
                return 1;
            }

            BCCGCardInstance@ card = BCCGCardInstance("Card");
            BCCGCharacterInstanceBase@ charInstance = character.AccessCharacterInstance();
            card.Init(FindCard(cont.m_pClass.GetName()), charInstance.GetNewCardId());
            card.GetParams().SetParam(BCCGCardParam::Cost, 0);

            AddCardToPile(character, card, BCCGCardPile::Hand);

            influence.SetCounter(influence.GetCounter() - 1);

            if(influence.GetCounter() <= 0)
            {       
                BCCGInfluenceInstanceBase@ masterInfluence = FindPushedInfluenceByTag(masterInfluenceTag, influence.GetLinkedCharacterId());
                
                if(masterInfluence != null)
                {
                    masterInfluence.SetCounter(masterInfluence.GetCounter() - accumulatedPoison);
                }
    
                influence.ForceRemove();
            }
        }

        return 1;
    }

    string exception = "car_replicationpotion_hex";
    string masterInfluenceTag = "poison_master";

    int accumulatedPoison = 0;
} 

Influence@ CreateInfluence()
{
    return Influence();
}