class Influence{

    void OnCharacterDamage(BCCGDungeon@ dung, BCCGCharacterObj@ character, BodDungObj@ from, int absorbed, int blocked, BCCGInfluenceInstanceBase@ influence)
    {
        if(character.GetId() != influence.GetLinkedCharacterId())
            return;

        BCCGMonsterObj@ monster = cast<BCCGMonsterObj>(from);

        if(monster == null)
            return;

        BCCGInfluenceInstanceBase@ poison = FindPushedInfluenceByTag(poisonBaseTag, influence.GetLinkedCharacterId());

        int poisonCounter = 0;
        if(poison != null)
        poisonCounter = poison.GetCounter();

        if(absorbed + blocked <= poisonCounter)
        {
            toStunIds.insertLast(monster.GetId());
        }
    }

    void BeginExecute(BCCGInfluenceExecuteContext@ context, BCCGInfluenceInstanceBase@ influence)
    {
        if(context.m_Turn != BCCGInfluenceTurn::BeginRound)
            return;

        if(context.m_pController.GetRound() <= 1)
            return;
            
        if(context.m_OwnerId != influence.GetLinkedCharacterId())
            return;

        for(int i = 0; i < toStunIds.length(); i++)
        {
            BCCGMonsterObj@ monster = cast<BCCGMonsterObj>(GetObjById(toStunIds[i]));

            if(monster == null || !monster.IsOwnedByLocalPlayer())
                continue;

            BCCGMonsterPushStunController@ stun = BCCGMonsterPushStunController();
            stun.SetActionBegin(monster.GetControllerQueueEndTimestamp());
            stun.SetDefaultEffect(true);
            monster.PushController(stun, false);
        }

        toStunIds.removeRange(0, toStunIds.length());

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

    void DecodeRemoteExecute(File@ f, BCCGInfluenceExecuteContext@ context, BCCGInfluenceInstanceBase@ influence)
    {
        if(context.m_Turn != BCCGInfluenceTurn::BeginRound)
            return;

        if(context.m_OwnerId != influence.GetLinkedCharacterId())
            return;

        for(int i = 0; i < toStunIds.length(); i++)
        {
            BCCGMonsterObj@ monster = cast<BCCGMonsterObj>(GetObjById(toStunIds[i]));

            if(monster == null || !monster.IsOwnedByLocalPlayer())
                continue;

            BCCGMonsterPushStunController@ stun = BCCGMonsterPushStunController();
            stun.SetActionBegin(monster.GetControllerQueueEndTimestamp());
            stun.SetDefaultEffect(true);
            monster.PushController(stun, false);
        }

        toStunIds.removeRange(0, toStunIds.length());
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
                accumulatedPoison += 2;
            }

            return 1;
        }

        return 1;
    }

    bool IsGlobal() {return false;}
    bool ShouldDisplayCounter() {return true;}

    array<int> toStunIds;
    string poisonBaseTag = "poison_base";
    string masterInfluenceTag = "poison_master";

    string exception = "car_retributionpotion_hex";

    int accumulatedPoison = 0;
} 

Influence@ CreateInfluence()
{
    return Influence();
}