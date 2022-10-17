-- Defualt Moscow skin (with coat of arms of Moscow)

-- Инструкции на русском не будет :)
--
-- if you want to create your own skin, you need to download crowbar, decomlpile original model, change paths to your custom textures ($cdmaterials) and model name ($model), change texture name in .smd files, compile
--
-- models directory   - "models/metrostroi_train/81-74x/*type*/custom_81-74x_*your_name*.mdl"
-- textures directory - "materials/models/metrostroi_train/81-74x/*type*/"
--
-- choose a name wisely to avoid conflict. For example, fixinit_01_sofia_3m.vtf, custom_01_aqua.vtf
--
-- Texture list:
--
--  texture name - texture content                                     |       model uses        |
--
--  01 -         81-740 body                                           | body |       |          |
--  02 -         81-740 cabin                                          |      | cabin | interior |
--  03 -         81-740 interior                                       |      |       | interior |
--  05 -         81-741 interior                                       |      |       | interior |
--  07 -         81-741 body                                           | body |       |          |
--  08 -         cabin panel                                           |      | cabin |          |
--  09 -         passenger door                                        | body |       |          |
--  cab_left  -  left cabin door                                       | body |       |          |
--  cab_right -  right cabin door                                      | body |       |          |
--  paneltex -   back panel with switches                              |      |       | interior?|
--
-- Attention! You need to rename path to $basetexture vtf in EVERY vmt file!
--
-- In fact, there are no exact instructions for skins, it's better to experiment
-- You can dm me (Anton Borisovich#8400) if you are in trouble

local name = "Defualt (Moscow)"  --skin name in spawner

local model_740 = "models/metrostroi_train/81-740/body/81-740_4_defualt_mos.mdl"
local cabin_door_left = "models/metrostroi_train/81-740/cabine/cabin_left.mdl" 
local cabin_door_right = "models/metrostroi_train/81-740/cabine/cabin_right.mdl" 
local passenger_door_1 = "models/metrostroi_train/81-740/body/81-740_leftdoor1.mdl"
local passenger_door_2 = "models/metrostroi_train/81-740/body/81-740_leftdoor2.mdl" 
local model_741 = "models/metrostroi_train/81-741/body/81-741_4_defualt_mos.mdl" 
local door_741_end = "models/metrostroi_train/81-741/body/door_br.mdl"
-- enter "none" to keep defualt model

local skin = 0
-- set the skin that you want to display (if there are several skins in the single model)
-- or enter "none" or "0" instead

local type = "body"
-- body - the above model will change the appearance of the train (from outside)
-- cabin - the above model will change the appearance of the panel (inside cabin)
-- interior - the above model will change the appearance of the interior (from inside)

Metrostroi740SkinAdd(name, type, skin, model_740, model_741, cabin_door_right, cabin_door_left, passenger_door_1, passenger_door_2, door_741_end)

local model_740 = "models/metrostroi_train/81-740/cabine/pult/pult.mdl" 
local skin = 0
local type = "cabin"
Metrostroi740SkinAdd(name, type, skin, model_740)

local model_740 = "models/metrostroi_train/81-740/salon/salon.mdl"
local model_741 = "models/metrostroi_train/81-741/salon/salon.mdl"
local handrails_740 = "models/metrostroi_train/81-740/salon/handrails/handrails.mdl"
local handrails_741 = "models/metrostroi_train/81-741/salon/handrails/handrails.mdl"
--handrails are broken
local skin = 0
local type = "interior"
Metrostroi740SkinAdd(name, type, skin, model_740, model_741, handrails_740, handrails_741)
