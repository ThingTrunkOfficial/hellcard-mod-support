class Influence{

    int GetModifiedDamage_Additive(BCCGCardContext@ context, BCCGMultiplayerObj@ target, int original_damage, BCCGInfluenceInstanceBase@ influence)
    {
        if(context.m_pCharInst.GetId() != influence.GetLinkedCharacterId())
            return original_damage;

        BCCGInfluenceInstanceBase@ poison = FindPushedInfluenceByTag(poisonBaseTag, influence.GetLinkedCharacterId());

        int damage = original_damage;

        BCCGMonsterObj@ monster = cast<BCCGMonsterObj>(target);
        if(monster == null)
            return damage;

        if(poison != null)
        {
            damage += poison.GetCounter();
        }

        return damage;
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

    void BeginExecute(BCCGInfluenceExecuteContext@ context, BCCGInfluenceInstanceBase@ influence)
    {
        if(context.m_Turn != BCCGInfluenceTurn::BeginRound)
            return;

        if(context.m_pController.GetRound() <= 1)
            return;

        if(context.m_OwnerId != influence.GetLinkedCharacterId())
            return;

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

    bool IsGlobal() {return false;}
    bool ShouldDisplayCounter() {return true;}

    string poisonBaseTag = "poison_base";
    string masterInfluenceTag = "poison_master";

    string exception = "car_ragepotion_hex";

    int accumulatedPoison = 0;
} 

Influence@ CreateInfluence()
{
    return Influence();
}