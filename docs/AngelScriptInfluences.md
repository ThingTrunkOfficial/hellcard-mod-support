[⯇ Back to README](../README.md)

# Creating new influence

- [How to start scripting](#how-to-start-scripting)
- [Tools](#tools)
- [Method override](#method-override)
- [Memory management](#memory-management)
- [Ownership](#ownership)
- [Event management](#event-management)
- [Examples](#examples)

## How to start scripting
Create an influence of type *BCCGAngelscriptInfluence*.
If you don't know how to do it, go to: [Creating influences](./CreatingNewInfluence.md).
Now, create an .as file somewhere in the mod content directory.
We will use it to create unique behaviours for our new influence.
The starting influence can be found here: [Starting influence](../mod_hexer/ccg_mod/3350421454/scripts/start_influence.as).
Copy its content to your file or copy it directly wherever you want in your mod content directory. 
In your newly created influence, in parameters, specify path to *.as* file and save it.
Now, you're ready to start scripting.

## Tools
To make development of *AngelScript* influences a little bit easier, we've prepared a file with all the exposed properties [Predefined](../mod_hexer/ccg_mod/3350421454/scripts/as.predefined). 
We also highly encourage to install [AngelScript Language Server](https://marketplace.visualstudio.com/items?itemName=sashi0034.angel-lsp) vs code extension, which offers syntax highlighting, autocompletion and many more.

## Method override
By implementing specified methods in *Influence* class, you will override influence original behaviour. Just copy these signatures if you want to use them and add body of each method to start using it. If you want to leave the default beahaviour, just don't implement method.
List of all influence methods:
- ```void Init(BCCGInfluenceInstanceBase@ influenceBase)```
    - can be used to initialize variables.
- ```bool ShouldDisplayCounter()```
    - return value defines if influence should display counter or not.
- ```bool IsGlobal()```
    - return value defines if influence is global or not. Global influences are not assigned to any character and they are displayed in the top part of the dungeon. 
- ```bool HasWidget()```
    - return value defines if influence is visible or not.
- ```void BeginExecute(BCCGInfluenceExecuteContext@ context, BCCGInfluenceInstanceBase@ influence)```
    - invoked on local player when turn has began, player turn has ended and turn has ended.
- ```void EncodeRemoteExecute(File@ f, BCCGInfluenceExecuteContext@ context, BCCGInfluenceInstanceBase@ influence)```
    - invoked on local player, can be used to send information to other players.
- ```void DecodeRemoteExecute(File@ f, BCCGInfluenceExecuteContext@ context, BCCGInfluenceInstanceBase@ influence)```
    - invoked on remote player, can be used to read information from other players.
- ```int GetCounter()```
    - custom behaviour on getting influence counter.
- ```void SetCounter(int val, BCCGInfluenceInstanceBase@ influence)```
    - custom behaviour on setting influence counter.
- ```int ProcessEvent(Event@ evt, BCCGInfluenceInstanceBase@ influence)```
    - used to handle events.

By implementing previously defined interface method in *Influence* class, you will override influence original behaviour.
List of all intreface methods:
- ```int ClampCalculatedCardDamage(BCCGCardContext@ context, BCCGMultiplayerObj@ target, int original_damage, int dmg_so_far, BCCGInfluenceInstanceBase@ influence)```
    - return clamped card damage.
- ```void OnMonsterKilled(BCCGDungeon@ dung, BCCGMonsterObj@ monster, BodDungObj@ killer, BCCGCardContext@ context, BCCGInfluenceInstanceBase@ influence)```
    - invoked when monster has been killed.
- ```void OnCharacterDamage(BCCGDungeon@ dung, BCCGCharacterObj@ character, BodDungObj@ from, int absorbed, int blocked, BCCGInfluenceInstanceBase@ influence)```
    - invoked when character has been damaged.
- ```int GetModifiedDamage_Additive(BCCGCardContext@ context, BCCGMultiplayerObj@ target, int original_damage, BCCGInfluenceInstanceBase@ influence)```
    - modifies character damage dealt by cards.
- ```int GetModifiedDamage_Multiplicative(BCCGCardContext@ context, BCCGMultiplayerObj@ target, int original_damage, BCCGInfluenceInstanceBase@ influence)```
    - modifies character damage dealt by cards.
- ```int GetModifiedDamage(BCCGMonsterObj@ damage_dealer, BCCGMultiplayerObj@ target, int original_damage, BCCGInfluenceInstanceBase@ influence)```
    - modifies monster damage.
- ```void ModifyIncomingDamage(BCCGDungeon@ dung, BCCGCharacterObj@ character, BCCGIncomingDamage@ current, BCCGInfluenceInstanceBase@ influence)```
    - implement when influence modifies incoming damage, by changing ```BCCGIncomingDamage@ current```
- ```bool CanCardBeAfforded(BCCGCardContext@ context)```
    - return value defines if card can be afforded or not.
- ```void OnMonsterAboutToBeKilled(BCCGDungeon@ dung, BCCGMonsterObj@ monster, BodDungObj@ killer, BCCGInfluenceInstanceBase@ influence)```
    - invoked when targeted monster's HP is less or equal to damage.
- ```s32 GetModifiedParamValue(BCCGCardContext@ context, ParamCardType param, BCCGMultiplayerObj@ target, s32 original_value, BCCGInfluenceInstanceBase@ influence)```
    - modifies param card block value for given param and target.
- ```s32 GetModifiedNumOfCardsToDraw(BCCGCharacterObj@ character, s32 original_num, BCCGInfluenceInstanceBase@ influence)```
    - modifies number of cards drawn at the beginning of the turn.
- ```bool CanCardBePlayed(BCCGCardContext@ context, BCCGInfluenceInstanceBase@ influence)```
    - returned value defines if card can be played.
- ```bool Multiplayer_CanCardBePlayed(BCCGCardContext@ context, BCCGInfluenceInstanceBase@ influence)```
    - returned value defines if card can be played.
- ```void OnVictory(BCCGDungeon@ dung, BCCGInfluenceInstanceBase@ influence)```
    - invokes when characters won floor.
- ```s32 GetModifiedMana(BCCGDungeon@ dung, BCCGCharacterObj@ character, s32 original_mana, BCCGInfluenceInstanceBase@ influence)```
    - returned value is used to modifie character's mana at the start of the players turn.
- ```bool KeepCards(BCCGCharacterObj@ character, BCCGInfluenceInstanceBase@ influence)```
    - returned value defines if character should keep it's unused cards in hand.
- ```void OnBeforeDiscardHand(BCCGDungeon@ dung, BCCGCharacterObj@ character, BCCGInfluenceInstanceBase@ influence)```
    - invoked before cards discard.
- ```void OnDiscardHand(BCCGDungeon@ dung, BCCGCharacterObj@ character, BCCGInfluenceInstanceBase@ influence)```
    - invokes when card has been discarded.
- ```void OnCharacterDeath(BCCGDungeon@ dung, BCCGCharacterObj@ character, BCCGInfluenceInstanceBase@ influence)```
    - invokes on character death.
- ```void OnMonsterDamage(BCCGDungeon@ dung, BCCGMonsterObj@ monster, BodDungObj@ from, s32 absorbed, s32 blocked, DmgDesc@ desc, BCCGInfluenceInstanceBase@ influence)```
    - invokes when monster has been damaged.
- ```void OnMonsterAboutToGetDamaged(BCCGDungeon@ dung, BCCGMonsterObj@ monster, BodDungObj@ from, s32 damage, BCCGInfluenceInstanceBase@ influence)```
    - invokes when monster is targeted and should get damage.
- ```bool KeepBlock(BCCGCharacterObj@ character, BCCGInfluenceInstanceBase@ influence)```
    - returned value defines if player should keep block at the end of the monsters turn.
- ```void Activate(BCCGCardContext@ context, BCCGInfluenceInstanceBase@ influence)```
    - can be activated by ActivateInfluenceCardBlock during card's execute phase.
- ```s16 ModifyHpCardCost(BCCGCardContext@ context, s16 original_cost, BCCGInfluenceInstanceBase@ influence)```
    - returned value defines modified HP card cost if HP is additional cost to play a card.
- ```bool ShouldBlock(BCCGInfluenceInstanceBase@ influence, BCCGInfluenceInstanceBase@ influence)```
    - allows to block specific influences from being pushed to the character.

## Memory management
Memory management is quite straight forward.
The only function you should worry about is ```BCCGInfluenceInstanceBase@ CreateInfluenceInstance(BCCGInfluenceClass@ infClass, int linked_id)```which returns a smart pointer.
Returned result from that function should be released via ```void Release(RefObj@ obj)```

## Ownership
Ownership is very important matter when it comes to multiplayer games. If you want to change any object in the game, push controller to do it. ***The only player who can push controllers to objects is their owner.*** 

Methods and functions invoked on server or client:
- ProcessEvent - client and server, exceptions:
    - BCCG_BATTLE_HIDE_CARD - only client.
    - BCCG_STUDY_COST_CHANGED - only client.
    - BCCG_BATTLE_REQUEST_CARD_MOVE - only client.
    - BCCG_CHAR_DUNG_COMPONENT_CARD_ADDED - only client.
    - BCCG_CHAR_DUNG_COMPONENT_CARD_MOVED - only client.
    - BCCG_BATTLE_SHOW_CARD - only client.
    - BCCG_CHAR_DUNG_COMPONENT_DISCARD_SHUFFLED - only client.
    - BCCG_PROCESS_CARD_MOVE_REQUESTS_EVT - only client.

- ClampCalculatedCardDamage - client and server.
- OnMonsterKilled - client and server.
- OnCharacterDamage - client and server.
- GetModifiedDamage_Additive - client and server.
- GetModifiedDamage_Multiplicative - client and server.
- GetModifiedDamage - client and server.
- ModifyIncomingDamage - client.
- CanCardBeAfforded - client.
- OnMonsterAboutToBeKilled - client.
- GetModifiedParamValue - client and server.
- GetModifiedNumOfCardsToDraw - client.
- CanCardBePlayed - client.
- Multiplayer_CanCardBePlayed - client and server.
- OnVictory - client and server.
- GetModifiedMana - client and server.
- KeepCards - client.
- OnBeforeDiscardHand - client.
- OnDiscardHand - client.
- OnCharacterDeath - client and server.
- OnMonsterDamage - client and server.
- OnMonsterAboutToGetDamaged - client.
- KeepBlock - client and server.
- Activate - client and server.
- ModifyHpCardCost - client.
- ShouldBlock - client and server.

The owner of specified object can be checked by:
1. For characters: ```BCCGCharacterObj.IsOwnedByLocalPlayer()```.
2. For monsters: ```BCCGMonsterObject.IsOwnedByLocalPlayer()```.
3. For server: ```BCCGBattleControllerBase.ShouldExecuteServerLogic()```.

## Event management
Via ```int ProcessEvent(Event@ evt, BCCGInfluenceInstanceBase@ influence)```implemented method you will be able to receive events from other objects in the game. Be aware that some events need to be casted to more precise type if you want to make more complicated behaviours. To see all available events go to the end of [Predefined](../mod_hexer/ccg_mod/3350421454/scripts/as.predefined) file.

## Examples
For more examples how influences can be made go to [Scripts directory](../mod_hexer/ccg_mod/3350421454/scripts/).
Where you can find multiple scripts used in hexer mod.