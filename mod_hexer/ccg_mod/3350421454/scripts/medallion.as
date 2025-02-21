class Influence
{ 
    void BeginExecute(BCCGInfluenceExecuteContext@ context, BCCGInfluenceInstanceBase@ influence)
    {
        if(context.m_Turn != BCCGInfluenceTurn::BeginRound)
            return;

        if(influence.GetLinkedCharacterId() != context.m_OwnerId)
            return;

        BCCGCharacterObj@ character = cast<BCCGCharacterObj>(GetObjById(influence.GetLinkedCharacterId()));

        if(character == null || !character.IsOwnedByLocalPlayer())
            return;
        
        numberOfMonstersInSlice = 0;
        linkedCharacterSliceId = GetSliceId(character);
        ForEachMonster(forMonsterCallback);

        BCCGCharacterBlockController@ ctrl = BCCGCharacterBlockController();
        InitCharacterBlockController(ctrl, numberOfMonstersInSlice);
        ctrl.SetActionBegin(character.GetControllerQueueEndTimestamp());
        ctrl.SetPlayedById(GetId(character));
        character.PushController(ctrl);
    }

    void CountMonsterIfInSlice(BCCGMonsterObj@ mon) 
    {
        if(mon == null)
            return;

        if(mon.IsDead() || mon.IsDying())
            return;

        if(GetSliceId(mon) == linkedCharacterSliceId)
            numberOfMonstersInSlice++;
    }

    bool IsGlobal() {return false;}
    bool ShouldDisplayCounter() {return false;}

    MonsterFunc @forMonsterCallback = MonsterFunc(CountMonsterIfInSlice);

    int linkedCharacterSliceId;
    int numberOfMonstersInSlice;
}


Influence@ CreateInfluence()
{
    return Influence();
}