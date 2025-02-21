[⯇ Back to README](../README.md)

# Getting started

- [Getting access to the Editor](#getting-access-to-the-editor)
- [Creating a mod](#creating-a-mod)
- [Publishing a mod](#publishing-a-mod)

## Getting access to the Editor

To get access to the Editor you have to own [Hellcard](https://store.steampowered.com/app/1201540/HELLCARD/) on Steam. The Editor is available [here](https://store.steampowered.com/app/3039290) as a free DLC which adds second executable to the application on Steam. The overview of the Editor can be found in [Basic Modding Tools features](./BasicModdingToolsFeatures.md) documentation.

## Creating a mod

1. Create ccg_mod directory in your Hellcard game folder
1. To be able to modify resources of given type (e.g. artifacts) you need to have a directory for this type of content in your ccg_mod directory (e.g. ccg_mod/artifacts) before launching game dev app
    - **List of directories**
        - artifacts
        - card_icons
        - cards
        - characters
        - companions
        - emoticons
        - endless
        - influences
        - locations
        - monsters
        - octopus voicelines
        - outfits
        - torments
        - voicelines
        - tutorials
    - **These types of assets are not allowed to be modified**
        - DLC
        - Sprites Info (not yet at least)
        - Mod (obviously)
1. Then, beside base manager for this asset category, you will have additional manager called Mod (e.g. Hellcard Game/Managers/Artifacts/Mod)
1. After making changes in said manager you should save your work: RMB on Mod manager and choose Save All
1. To have assets immediately available in the game, you can RMB on Asset Category (e.g. Artifacts) and choose Refresh Cache (although app restart is advised)
    - Also Reload All, but careful - will reload from the disk and you will lose anything not saved
1. To replace an asset, create one in Mod manager named the same as its counterpart in Original manager
1. To remove existing assets from the game, create a file named blacklist.txt in the chosen asset folder (like ccg_mod/artifacts) and edit it to contain the names of assets you wish to remove from the game (one per line). Be aware that some other assets might depend on them and should also be blacklisted.
1. Dependencies (textures, sounds, etc.) are store in a subdirectory named after the mod's identifier (obtained after first upload)
1. Language files are stored in a subdirectory named languages. Every translation file is named \<lang abbr\>.utf8 (e.g. en.utf8, de.utf8)


## Publishing a mod

This is a suggested way.  
More info: <https://partner.steamgames.com/doc/features/workshop/implementation>

1. Download steamcmd app (<https://developer.valvesoftware.com/wiki/SteamCMD>)
1. Register a mod
    - Edit upload-mod.bat script and workshop-item.vdf to contain correct paths and run the script.
    - If upload was successful, the item config file (workshop-item.vdf) will be updated with filled publishedfileid. You will use this id to update the mod. Also you should use it as a name of a subdirectory containing dependencies (textures, sounds, particle effects) used by resources being part of the mod. It is necessary to avoid shadowing dependencies added by one mod with ones added by another one.
1. Prepare a mod and copy its content to the *ccg_mod* directory (or change the path in your workshop-item.vdf to point whatever directory you're using)
1. Run the script again to update the mod content
1. Go to your newly created workshop item's website to edit its properties and access rights
1. Remember to remove ccg_mod/ from the game directory before using published version of the mod




