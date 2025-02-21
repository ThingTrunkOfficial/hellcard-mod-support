class Influence{ 

    void BeginExecute(BCCGInfluenceExecuteContext@ context, BCCGInfluenceInstanceBase@ influence)
    {
        if(context.m_Turn != BCCGInfluenceTurn::BeginRound)
            return;

        if(context.m_pController.GetRound() <= 1)
            return;
            
        if(influence.GetLinkedCharacterId() != context.m_OwnerId)
            return;

        BCCGInfluenceInstanceBase@ poison = FindPushedInfluenceByTag(poisonBaseTag, influence.GetLinkedCharacterId());

        if(poison != null)
        {
            BCCGCharacterObj@ character = cast<BCCGCharacterObj>(GetObjById(influence.GetLinkedCharacterId()));

            if(character == null || !character.IsOwnedByLocalPlayer())
                return;

            BCCGCharacterBlockController@ ctrl = BCCGCharacterBlockController();
            InitCharacterBlockController(ctrl, poison.GetCounter());
            ctrl.SetActionBegin(character.GetControllerQueueEndTimestamp());
            ctrl.SetPlayedById(GetId(character));
            character.PushController(ctrl);
        }

        influence.SetCounter(influence.GetCounter() - 1);

        if(influence.GetCounter() <= 0)
        {
            BCCGMultiplayerObj@ owner = GetObjById(influence.GetLinkedCharacterId());
            
            if(!owner.IsOwnedByLocalPlayer())
                return;
                
            BCCGInfluenceInstanceBase@ masterInfluence = FindPushedInfluenceByTag(masterInfluenceTag, influence.GetLinkedCharacterId());
            
            if(masterInfluence != null)
            {
                masterInfluence.SetCounter(masterInfluence.GetCounter() - accumulatedPoison);
            }

            influence.ForceRemove();
        }
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
                accumulatedPoison += 1;
            }

            return 1;
        }

        return 1;
    }

    bool IsGlobal() {return false;}
    bool ShouldDisplayCounter() {return true;}

    string poisonBaseTag = "poison_base";
    string masterInfluenceTag = "poison_master";

    string exception = "car_guardpotion_hex";

    int accumulatedPoison = 0;
} 

Influence@ CreateInfluence()
{
    return Influence();
}