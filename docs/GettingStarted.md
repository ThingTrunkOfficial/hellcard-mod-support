[⯇ Back to README](../README.md)

# Getting started

- [Getting started](#getting-started)
  - [Getting access to the Editor](#getting-access-to-the-editor)
  - [Creating a mod](#creating-a-mod)
  - [Publishing a mod or Uploading it for the first time](#publishing-a-mod-or-uploading-it-for-the-first-time)
  - [Updating a mod](#updating-a-mod)

## Getting access to the Editor

To get access to the Editor you have to own [Hellcard](https://store.steampowered.com/app/1201540/HELLCARD/) on Steam. The Editor is available [here](https://store.steampowered.com/app/3039290) as a free DLC which adds the second executable to the application on Steam along with launch option. The overview of the Editor can be found in [Basic Modding Tools features](./BasicModdingToolsFeatures.md) documentation.

## Creating a mod

1. Create ccg_mod directory in your Hellcard game folder.
1. To be able to modify resources of given type (e.g. artifacts) you need to have a directory for this type of content in your ccg_mod directory (e.g. ccg_mod/artifacts) before launching game dev app.
    - **List of directories**:
        - *artifacts*
        - *card_icons*
        - *cards*
        - *characters*
        - *companions*
        - *emoticons*
        - *endless*
        - *influences*
        - *locations*
        - *monsters*
        - *octopus voicelines*
        - *outfits*
        - *torments*
        - *voicelines*
        - *tutorials*
    - **These types of directories are not allowed to be modified**:
        - *DLC*
        - *Sprites Info*
        - *Mod*
1. Then, in hellcard mod tool beside base manager for this asset category, you will have additional manager called Mod (e.g. Hellcard Game->Managers->Artifacts->Mod).
1. After making changes in said manager you should save your work: RMB on Mod manager and choose Save All.
1. To have assets immediately available in the game, you can RMB on Asset Category (e.g. Artifacts) and choose Refresh Cache (although app restart is advised).
    - Also Reload All, but careful - will reload from the disk and you will lose anything not saved.
1. To replace an asset, create one in Mod manager named the same as its counterpart in Original manager.
1. To remove existing assets from the game, create a file named blacklist.txt in the chosen asset folder (like ccg_mod/artifacts) and edit it to contain the names of assets you wish to remove from the game (one per line). Be aware that some other assets might depend on them and should also be blacklisted.
1. Dependencies (textures, sounds, etc.) are store in a subdirectory named after the mod's identifier (obtained after first upload).
1. Language files are stored in a subdirectory named languages. Every translation file is named \<lang abbr\>.utf8 (e.g. en.utf8, de.utf8).

## Publishing a mod or Uploading it for the first time

This is a suggested way.  
More info: <https://partner.steamgames.com/doc/features/workshop/implementation>

1. Download the [SteamCMD app](https://developer.valvesoftware.com/wiki/SteamCMD). Its a zip file.
2. Place it in a new and empty folder. Unpack the .zip file and execute the .exe file to install steamcmd.
3. Before working with it you have to create a settings file called `workshop-item.vdf`. You can get it from [this repository](../mod_hexer/workshop-item.vdf) or copy it from here:

``` vdf
"workshopitem"
{
    "appid"              "1201540"
    "publishedfileid"    ""
    "contentfolder"      "C:\Users\YourName\Desktop\ccg_mod"
    "previewfile"        "C:\Users\YourName\Desktop\Hexer.jpg"
    "visibility"         "1"
    "title"              "Hexer mods"
    "description"        "New cool Hexer Mod yeah"
    "changenote"         "added new card"
}
```
- `appid`: Hellcard game ID - its 1201540, leave it as is
- `publishedfileid`: Your mod ID - leave it empty on the first upload, it will be placed automatically if your mod is successfully published
- `contentfolder`: Absolute path to your ccg_mod folder - can be anywhere you want, try not to use spaces in folder names, **everything in that folder will be uploaded** and can be seen by anyone who downloads the mod
- `previewfile`: Absolute path to an image that will become your preview image in the mod browser - can be changed later
- `visibility`: 0 = public, 1 = private, 2 = friends only - can be changed later
- `title`: Your mod title - can be changed later, will replace the existing title 
- `description`: Your mod description - can be changed later, will replace the existing description 
- `changenote`: Changelog

4. Now you can start **steamcmd.exe** again. You should be able to type in commands. 
    1. First, log in to your Steam account:
        ```
        login <username> <password>
        ```
        Follow the instructions. You may need to enter a steam guard code. If the login was successful, continue.
    2. Now you have to upload the mod using your `workshop-item.vdf` file:
        ```
        workshop_build_item <file_path>
        ```
        **file_path** should be absolute and something like this: `C:\mod_hexer\workshop-item.vdf`
    1. If it's not working, you've probably misspelled something.
    2. If everything is correct SteamCMD should tell you. Your workshop item should be created. Check your Steam Workshop if its there. Now you can start writing a description, making the mod public, etc.
    3. Remember to remove or rename the `ccg_mod/` folder from the game directory before using the published version of your mod.

## Updating a mod

1. To update the mod you have to repeat these steps. A new `workshop-item.vdf` file should have been created in your `ccg_mod` folder. It should have your `publishedfileid` added.
     - If you update the mod with the `workshop-item.vdf` file, the title and description will be replaced by those in the file. 
     - So make sure to remove these parameters from your file:
    ``` vdf
    "workshopitem"
    {
        "appid"              "1201540"
        "publishedfileid"    "0123456789"
        "contentfolder"      "C:\Users\YourName\Desktop\ccg_mod"
        "changenote"         "added new feature"
    }
    ```
2. If you don't want to upload everything manually, you can create a .bat file to automate these steps.
    ``` bat
    @echo off

    set steamcmd="C:\steamcmd\steamcmd.exe"
    set workshop_item_conf="C:\mod_hexer\workshop-item.vdf"

    set /p "login=Login Name: "

    %steamcmd% +login "%login%" +workshop_build_item %workshop_item_conf% +quit
    ```
   - replace `C:\steamcmd\steamcmd.exe` with the path to your `steamcmd.exe`
   - replace `C:\mod_hexer\workshop-item.vdf` with the path to your `workshop-item.vdf`
   - It only works if you have already identified your PC with your Steam Guard code.
   - Make sure to update `changenote` in your `workshop-item.vdf` to display what has changed.
