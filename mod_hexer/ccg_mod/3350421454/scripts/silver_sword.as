class Influence
{

    int GetModifiedDamage_Additive(BCCGCardContext@ context, BCCGMultiplayerObj@ target, int original_damage, BCCGInfluenceInstanceBase@ influence)
    {
        if(context.m_pCharInst.GetId() != influence.GetLinkedCharacterId())
            return original_damage;

        if(!CardHasTag(context.m_pClass, swordTag))
            return original_damage;

        BCCGInfluenceInstanceBase@ poison = FindPushedInfluenceByTag(poisonTag, influence.GetLinkedCharacterId());

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

    bool IsGlobal() {return false;}
    bool ShouldDisplayCounter() {return false;}

    string swordTag = "sword";
    string poisonTag = "poison_base";
} 

Influence@ CreateInfluence()
{
    return Influence();
}