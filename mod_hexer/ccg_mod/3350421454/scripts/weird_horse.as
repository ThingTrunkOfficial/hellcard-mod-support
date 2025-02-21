class Influence
{
    void BeginExecute(BCCGInfluenceExecuteContext@ context, BCCGInfluenceInstanceBase@ influence)
    {
        if(context.m_Turn != BCCGInfluenceTurn::BeginRound)
            return;

        BCCGDungeon@ dung = context.m_pController.GetDungeon();
        BCCGMonsterObj@ random_monster = GetRandomMonster(dung);
        if(random_monster == null)
            return;
        
        targetId = random_monster.GetId();
        currentDamage = GetRandomInt(MinDamage, MaxDamage);
        GetRandomSector(dung, random_monster, moveToSliceId, movetoDistance, true);
        ExecuteLogic(dung, influence.GetLinkedCharacterId(), influence);
    }

    void EncodeRemoteExecute(File@ f, BCCGInfluenceExecuteContext@ context, BCCGInfluenceInstanceBase@ influence)
    {
        if(context.m_Turn != BCCGInfluenceTurn::BeginRound)
            return;
        
        WriteInt(f, targetId);
        WriteInt(f, currentDamage);
        WriteInt(f, moveToSliceId);
        WriteInt(f, int(movetoDistance));
    }

    void DecodeRemoteExecute(File@ f, BCCGInfluenceExecuteContext@ context, BCCGInfluenceInstanceBase@ influence)
    {
        if(context.m_Turn != BCCGInfluenceTurn::BeginRound)
            return;

        targetId = ReadInt(f);
        currentDamage = ReadInt(f);
        moveToSliceId = ReadInt(f);
        movetoDistance = BCCGPartitionDistance(ReadInt(f));
        
        ExecuteLogic(context.m_pController.GetDungeon(), influence.GetLinkedCharacterId(), influence);
    }

    bool IsGlobal() {return false;}
    bool ShouldDisplayCounter() {return false;}

    void ExecuteLogic(BCCGDungeon@ dung, int influenceOwnerId, BCCGInfluenceInstanceBase@ influence)
    {
        BCCGMonsterObj@ monster = cast<BCCGMonsterObj>(GetObjById(targetId));
        if(monster == null)
            return;

        if(monster.IsDead() || monster.IsDying())
            return;

        influence.TriggerOwnerEffects(dung);
        influence.TriggerUsedEffect();
        TriggerInfluenceEffectOnTarget(influence, dung, monster);

        if (!monster.IsOwnedByLocalPlayer())
            return;

        MoveMonster(dung, monster, moveToSliceId, movetoDistance, BCCGMonsterMoveStyle::Walk, 8.0f);

        BCCGMonsterHitController@ hitController = BCCGMonsterHitController();
        InitMonsterHitController(hitController, currentDamage, influenceOwnerId, BCCGSwistLook::SWIST_LOOK_MISSILE);
        hitController.SetActionBegin(monster.GetControllerQueueEndTimestamp());
        hitController.SetPlayedById(influenceOwnerId);

        monster.PushController(hitController, false);
    }

    int targetId;
    int currentDamage;
    int moveToSliceId;
    BCCGPartitionDistance movetoDistance;

    int MaxDamage = 10;
    int MinDamage = 1;
} 

Influence@ CreateInfluence()
{
    return Influence();
}