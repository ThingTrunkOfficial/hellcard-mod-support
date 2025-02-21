class Influence
{
    bool IsGlobal(){return false;}
    bool ShouldDisplayCounter(){return true;}
    bool HasWidget(){return true;}
}

Influence@ CreateInfluence()
{
    return Influence();
}