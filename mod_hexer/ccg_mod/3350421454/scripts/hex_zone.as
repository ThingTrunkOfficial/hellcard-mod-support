class Influence
{
    void MonsterDamageWhenInNear(BCCGMonsterObj@ mon) {
        if(mon == null)
            return;
    
        if(mon.IsDead() || mon.IsDying())
            return;
    
        if(GetDistance(mon) == targetDistance)
        {
            BCCGMonsterHitController@ damage = BCCGMonsterHitController();
            InitMonsterHitController(damage, 1, influenceOwnerId, BCCGSwistLook::SWIST_LOOK_MISSILE);
            damage.SetActionBegin(mon.GetControllerQueueEndTimestamp());
            damage.SetPlayedById(influenceOwnerId);
    
            mon.PushController(damage, false);
        }
    }

    void BeginExecute(BCCGInfluenceExecuteContext@ context, BCCGInfluenceInstanceBase@ influence)
    {
        if(context.m_Turn != BCCGInfluenceTurn::BeginRound)
            return;

        influence.TriggerOwnerEffects(context.m_pController.GetDungeon());
        influence.TriggerUsedEffect();
            
        influenceOwnerId = influence.GetLinkedCharacterId();
        if(context.m_pController.ShouldExecuteServerLogic())
            ForEachMonster(forEachMethod);

        influence.SetCounter(influence.GetCounter() - 1);

        if(influence.GetCounter() <= 0)
        {
            influence.ForceRemove();
        }
    }

    void DecodeRemoteExecute(File@ f, BCCGInfluenceExecuteContext@ context, BCCGInfluenceInstanceBase@ influence)
    {
        if(context.m_Turn != BCCGInfluenceTurn::BeginRound)
        return;

        influence.TriggerOwnerEffects(context.m_pController.GetDungeon());
        influence.TriggerUsedEffect();

        influenceOwnerId = influence.GetLinkedCharacterId();
        if(context.m_pController.ShouldExecuteServerLogic())
            ForEachMonster(forEachMethod);
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

    string exception = "car_hexzone_hex";

    MonsterFunc@ forEachMethod = MonsterFunc(MonsterDamageWhenInNear);

    BCCGPartitionDistance targetDistance = BCCGPartitionDistance::Near;
    int influenceOwnerId = 0;
}

Influence@ CreateInfluence()
{
    return Influence();
}