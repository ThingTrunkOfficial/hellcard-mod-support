[⯇ Back to README](../README.md)

# Textures

- [Opening Texture Manager](#opening-texture-manager)
- [Creating a new Texture](#creating-a-new-texture)
- [Hotspot](#hotspot)
- [Hierarchy tip](#hierarchy-tip)
- [Help](#help)
- [Save](#save)

## Opening Texture Manager

First of all, launch the modding tools. In the editor select the Texture Manager from the object tree:  

![](./content/texture_manager_1.png)  

You will notice that the preview area now displays thumbnails of all the textures currently loaded. Above the thumbnails are three buttons:  

![](./content/texture_manager_2.png)  

You can use them to load textures currently not loaded or create a new one. 

## Creating a new Texture

Click Create New. The editor will prompt you to select a subdirectory for the new texture and a name. PNG is preferred but jpg is also possible.  

![](./content/texture_manager_3.png)  

New Sprite Editor object should now be added to the root object of the object tree. This is the sprite editor. It can be used to manage source assets, sizes of sprites and build an atlas out of all sprites. 

The preview area is divided into two parts with a vertical line. On the left you can work on current source asset and on the right you can see the resulting texture. Now, however, both are blank. Let's add a source asset so we could see something. 

Right click the editor in the Object Tree and select "Add Multiple":  

![](./content/texture_manager_4.png)  

This will open a dialog where you will be able to select one or more source assets to be loaded and added to the editor. I have added a texture with Book of Demons logo on transparent background. Now I can select this source asset in the object tree and see this:  

![](./content/texture_manager_5.png)  

It's obvious, that the final texture will be too small for any of the logos, but we will try creating a sprite with the red dot. By default, there is always one sprite on every new source asset and it encompasses whole asset.  

![](./content/texture_manager_6.png)  

Let's reuse it. You can either select it in the object tree and modify its properties by hand to move it so it encompassed the red dot or select it on the preview (clicking on the sprite area will toggle between all sprites that area belongs to) and resizing it with arrow keys while holding ctrl (moves upper left corner) or alt (bottom right subjectively to upper left). 

You can also place the mouse cursor over the sprite and press A. This will try to automatically snap the currently selected sprite around the shape. 

Either way, the final result should look like this:  

![](./content/texture_manager_7.png)  

Now it's time to try and fit that new sprite on the final texture. Press B to start the packing algorithm, which will try and fit the sprite onto the final result.  

![](./content/texture_manager_8.png)  

Great success! If we tried to add one of the big ones though (by hovering the cursor over it and pressing P, which adds a new sprite and tries to snap it over the selected shape) and building the texture with B, we would get an error stating that 

> 17:57:04.4     - W. 1 Sprites did not fit on texture 

You can enlarge the final texture by changing parameters of the SpriteEditor object  

![](./content/texture_manager_9.png)  

Just make sure you stick to the power of two - older video cards like these sizes for memory optimization reasons. 

## Hotspot
You can move the hotspot of the sprite by holding H key and using arrow keys or pressing the RMB. Hotspot is an equivalent of a pivot in a 3d object. It determines the location where the sprite is rendered and serves as a center of rotation and scale.

## Help
You can display help menu in the Texture Manager by pressing F1. I will show you the following shortcuts:

CTRL + Arrows - moves sprite around

X [mod] - preserve absolute hot-spot

S + LMB - position asset separator (can also drag)

X + LMB or RMB (with H held down) moves sprite corners while preserving abs. hot-spot position

B - build texture

F - reset workspace offsets, texture scale and separator position to defaults

G - toggle sample visible

O - when pressed sprites in result tex will show extra pixel sides with blue lines

H - when held down enables hot-spot operations

r - click - place hot-spot

cursor arrows - move spr hot-spot

ctrl [mod] - move whole sprite with hot-spot

alt [mod] - change sprite width and height

shift [mod] - translate by 10 instead of one

Z [mod] - any operation on hot-spot is propagated to assets in sequence (anim00012.png, etc.)

K [mod] - any operation on hot-spot is propagated to all assets 

C - center hot-spot

A - auto-crop sprite from mouse position using alpha

 ctrl [mod] - preserve absolute hot-spot pos

Q - auto-crop sprite from mouse position using color

 ctrl [mod] - preserve absolute hot-spot pos

M - auto-crop sprite from texture sides

P - create new sprite auto-cropped over mouse pos

+/- - move to next / prev sprite

ctrl + M - convert to multi sprite

E - expand sprite by 1 px

 ctrl [Mod] - shrink sprite by 1px

Ctrl+T - if no texture is loaded switches to texture manager

Ctrl+N - if no texture is loaded creates new texture

Ctrl+Z - undo last action

Ctrl+Y - redo last action

## hierarchy-tip
When creating textures for [Hierarchies](./docs/CreatingNewHierarchy.md), it is very useful to auto-crop all the sprites while preserving their hotspot. You can do it after adding all the files (Add multiple) by Right clicking the editor in the Object Tree and selecting Autocrop all. 

## Save

Once you are happy with the results, press CTRL+S or pick Save all children from the context menu. This saves the texture and metafiles (like the .tex file, which should be loaded from the code and scripts instead of .png). 