
local Version = "1.0"
local AutoUpdate = false

if myHero.charName ~="Teemo" then return end
 
 function ScriptMsg(msg)
  print("<font color=\"#daa520\"><b>Team Y Teemo:</b></font> <font color=\"#FFFFFF\">"..msg.."</font>")
end

-- update

 require 'VPrediction'
 require 'SourceLib'
 local Q = { Range = 680, IsReady = function() return myHero:CanUseSpell(_Q) == READY end,}
 local W = { Range = 0, IsReady = function() return myHero:CanUseSpell(_W) == READY end,}
 local E = { Range = defaultRange, IsReady = function() return myHero:CanUseSpell(_E) == READY end,}
 local R = { Range = 200, IsReady = function() return myHero:CanUseSpell(_R) == READY end,}
 local I = { Range = 570, IsReady = function() return myHero:CanUseSpell(Ignite) == READY end,}
 local MyminBBox = GetDistance(myHero.minBBox)/2
local AArance = myHero.range+MyminBBox
local STS
local KTS = TargetSelector(TARGET_LOW_HP, 730, DAMAGE_MAGIC, false) KTarget=nil STarget=nil
local Player = GetMyHero()
local EnemyHeroes = GetEnemyHeroes()
local health_potion_time=0 mana_potion_time=0 flask_potion_time=0 boostbuffname=0 boostbufftype=0 boostbufftime=0 debufftime=0 QuicksilverSash_menu=false morebufftype=0 morebufftime=0 Muramana_time=0


local bestshroom =
 {
	{x = 10406, y = 50.08506, z = 3050},
	{x = 10202, y = -71.2406, z = 4884},
	{x = 11222, y = -2.569444, z = 5592},
	{x = 10032, y = 49.70721, z = 6610},
	{x = 8580, y = -50.36785, z = 5560},
	{x = 11960, y = 52.09994, z = 7400},
	{x = 4804, y = 40.283, z = 8334},
	{x = 6264, y = -62.41959, z = 9332},
	{x = 4724, y = -71.2406, z = 10024},
	{x = 3636, y = -8.188844, z = 9348},
	{x = 4425, y = 56.8484, z = 11810},
	{x = 2848, y = 51.84816, z = 7362}
 }
 
 -- orbwalk

 
 function OrbwalkCanMove()
  if RebornLoaded then
    return _G.AutoCarry.Orbwalker:CanMove()
  elseif MMALoaded then
    return _G.MMA_AbleToMove
  elseif SxOrbLoaded then
    return SxOrb:CanMove()
  elseif SOWLoaded then
    return SOWVP:CanMove()
    --return SOW:CanMove()
  end
  
end

function Orbwalk()

  if _G.AutoCarry then
  
    if _G.Reborn_Initialised then
      RebornLoaded = true
      ScriptMsg("Found SAC: Reborn.")
    else
      RevampedLoaded = true
      ScriptMsg("Found SAC: Revamped.")
    end
    
  elseif _G.Reborn_Loaded then
    DelayAction(Orbwalk, 1)
  elseif _G.MMA_Loaded then
    MMALoaded = true
    ScriptMsg("Found MMA.")
  elseif FileExist(LIB_PATH .. "SxOrbWalk.lua") then
  
    require 'SxOrbWalk'
    
    ConfigYT:addSubMenu("OrbWalk", "OrbWalk")
    
    SxOrb = SxOrbWalk()
    SxOrb:LoadToMenu(ConfigYT.OrbWalk)
    
    SxOrbLoaded = true
    ScriptMsg("Found SxOrb.")
  elseif FileExist(LIB_PATH .. "SOW.lua") then
  
    require 'SOW'
    
    SOWVP = SOW(VP)
    
    ConfigYT:addSubMenu("Orbwalk Settings (SOW)", "Orbwalk")
      ConfigYT.Orbwalk:addParam("Info", "SOW settings", SCRIPT_PARAM_INFO, "")
      ConfigYT.Orbwalk:addParam("Blank", "", SCRIPT_PARAM_INFO, "")
      SOWVP:LoadToMenu(ConfigYT.Orbwalk)
      
    SOWLoaded = true
    ScriptMsg("Found SOW.")
  else
    ScriptMsg("Orbwalk not founded.")
  end
  
end

-- menu

 function OnLoad()
	
ScriptMsg("Thanks use Team Y Teemo")



    ConfigYT = scriptConfig("Team Y Teemo", "yourteamTeemo")
	
		ConfigYT:addSubMenu("Language", "Language")
			ConfigYT.Language:addParam("Language", "Language", SCRIPT_PARAM_LIST, 1, { "�ѱ���", "English"})
		if ConfigYT.Language.Language==1 then
			ScriptMsg("Reloading is required when setting the language")
			else
			ScriptMsg("������ ��ε尡 �ʿ��մϴ�")
		end
		if ConfigYT.Language.Language==1 then
			ConfigYT:addSubMenu("�޺�","combo")
				ConfigYT.combo:addParam("combo","�޺�Ű", SCRIPT_PARAM_ONKEYDOWN, false, 32)
				ConfigYT.combo:addParam("castq", "Q���", SCRIPT_PARAM_ONOFF, true)
				--ConfigYT.combo:addParam("qandaa", "AA after Q", SCRIPT_PARAM_ONOFF, true)
				ConfigYT.combo:addParam("castw", "W���", SCRIPT_PARAM_ONOFF, true)
				ConfigYT.combo:addParam("castr", "R���", SCRIPT_PARAM_ONOFF, true)
		else
			ConfigYT:addSubMenu("combo","combo")
				ConfigYT.combo:addParam("combo","Combo Hot Key", SCRIPT_PARAM_ONKEYDOWN, false, 32)
				ConfigYT.combo:addParam("castq", "Cast Q", SCRIPT_PARAM_ONOFF, true)
				--ConfigYT.combo:addParam("qandaa", "AA after Q", SCRIPT_PARAM_ONOFF, true)
				ConfigYT.combo:addParam("castw", "Cast W", SCRIPT_PARAM_ONOFF, true)
				ConfigYT.combo:addParam("castr", "Cast R", SCRIPT_PARAM_ONOFF, true)
			
		end
	
		if ConfigYT.Language.Language==1 then
			ConfigYT:addSubMenu("ų��ƿ", "killsteal")
				ConfigYT.killsteal:addParam("killstealQ", "�ڵ�Q", SCRIPT_PARAM_ONOFF, true)
				--ConfigYT.killsteal:addParam("flashQ", "�÷���Q", SCRIPT_PARAM_ONOFF, true)
		else
			ConfigYT:addSubMenu("killsteal", "killsteal")
				ConfigYT.killsteal:addParam("killstealQ", "killsteal Auto Q", SCRIPT_PARAM_ONOFF, true)
				--ConfigYT.killsteal:addParam("flashQ", "FlashQ", SCRIPT_PARAM_ONOFF, true)
		
		end
		
		if ConfigYT.Language.Language==1 then
			ConfigYT:addSubMenu("��������", "harass")
				ConfigYT.harass:addParam("harasshotkey","��������Ű", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
				ConfigYT.harass:addParam("harassQ","Q���", SCRIPT_PARAM_ONOFF, true)
		else
			ConfigYT:addSubMenu("harass", "harass")
				ConfigYT.harass:addParam("harasshotkey","harass Hot Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
				ConfigYT.harass:addParam("harassQ","harass", SCRIPT_PARAM_ONOFF, true)
		
		end
		
		if ConfigYT.Language.Language==1 then
			ConfigYT:addSubMenu("�����Ÿ�", "draw")
				ConfigYT.draw:addParam("aadraw", "��Ÿ��Ÿ�", SCRIPT_PARAM_ONOFF, true)
				ConfigYT.draw:addParam("qdraw", "Q��Ÿ�", SCRIPT_PARAM_ONOFF, true)
				ConfigYT.draw:addParam("bshroom", "������ġ", SCRIPT_PARAM_ONOFF, true)
				ConfigYT.draw:addParam("targetdraw", "Ÿ������", SCRIPT_PARAM_ONOFF, false)
		else
			ConfigYT:addSubMenu("draw", "draw")
				ConfigYT.draw:addParam("aadraw", "Draw AA rance", SCRIPT_PARAM_ONOFF, true)
				ConfigYT.draw:addParam("qdraw", "Draw Q rance", SCRIPT_PARAM_ONOFF, true)
				ConfigYT.draw:addParam("bshroom", "Best shroom Draw", SCRIPT_PARAM_ONOFF, true)
				ConfigYT.draw:addParam("targetdraw", "Target Draw", SCRIPT_PARAM_ONOFF, false)
			
		end
		
		if ConfigYT.Language.Language==1 then
			ConfigYT:addSubMenu("����", "potion")
			ConfigYT.potion:addParam("autouse", "�ڵ����", SCRIPT_PARAM_ONOFF, true)
			ConfigYT.potion:addParam("health", "ü��%����", SCRIPT_PARAM_SLICE, 50, 0, 100)
			ConfigYT.potion:addParam("mana", "����%����" , SCRIPT_PARAM_SLICE, 50, 0, 100)
		else
			ConfigYT:addSubMenu("potion", "potion")
			ConfigYT.potion:addParam("autouse", "autouse", SCRIPT_PARAM_ONOFF, true)
			ConfigYT.potion:addParam("health", "Health % Below", SCRIPT_PARAM_SLICE, 50, 0, 100)
			ConfigYT.potion:addParam("mana", "Mana % Below", SCRIPT_PARAM_SLICE, 50, 0, 100)
		end
			
 -- summonerdot

 	if myHero:GetSpellData(SUMMONER_1).name:find("summonerdot") or myHero:GetSpellData(SUMMONER_2).name:find("summonerdot") then 
		if ConfigYT.Language.Language==1 then
			ConfigYT:addSubMenu("��ȭ", "ignite")
				ConfigYT.ignite:addParam("autouse", "?�ڵ����", SCRIPT_PARAM_ONOFF, true)
		else
			ConfigYT:addSubMenu("ignite", "ignite")
				ConfigYT.ignite:addParam("autouse", "Auto Use", SCRIPT_PARAM_ONOFF, true)
		end
			ConfigYT:addSubMenu("By fizssy and Yours", "By fizssy and Yours")
	end	
	
	STS = SimpleTS(STS_LESS_CAST_MAGIC)
	Orbwalk()
	VP = VPrediction()
	ScriptMsg("Use VPrediction")
	dot()
	end
 -- kill
 
 function OnTick()
 
	if flask_potion and ConfigYT.potion.autouse and (myHero.health/myHero.maxHealth*100 <=ConfigYT.potion.health or myHero.mana/myHero.maxMana*100 <=ConfigYT.potion.mana) and flask_potion_time+12 < os.clock() then
		CastSpell(flask_potion)
		flask_potion_time = os.clock()
	end
	
	if health_potion and ConfigYT.potion.autouse and myHero.health/myHero.maxHealth*100 <=ConfigYT.potion.health and health_potion_time+15 < os.clock() then
		CastSpell(health_potion)
		health_potion_time = os.clock()
	end

	if mana_potion and ConfigYT.potion.autouse and myHero.mana/myHero.maxMana*100 <=ConfigYT.potion.mana and mana_potion_time+15 < os.clock() then
		CastSpell(mana_potion)
		mana_potion_time = os.clock()
	end

		if myHero.dead then return end
 
	killsteal()
	COMBO()
	harass()
	killsteal()
	Check()
	
	
	end

function harass()
		if ConfigYT.harass.harasshotkey then
			local target = STS:GetTarget(680)
			if ConfigYT.harass.harassQ and Q.IsReady() and GetDistance(myHero, target) < 680 then
				CastSpell(_Q,target)
		end
	end 
end   

function COMBO()
	if ConfigYT.combo.combo then
		local target = STS:GetTarget(680)
	    if target ~= nil then
			if ConfigYT.combo.castq and Q.IsReady() then
				CastSpell(_Q, target)
			end
			if ConfigYT.combo.castw and W.IsReady() then
				CastSpell(_W)
			end
			if R.IsReady() and ConfigYT.combo.castr and GetDistance(myHero, target) <= 200 then
				CastSpell(_R, myHero.x, myHero.z)
				end
			end
		end
end

-- dot

function dot()

if myHero:GetSpellData(SUMMONER_1).name:find("summonerdot") then
    Ignite = SUMMONER_1
  elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerdot") then
    Ignite = SUMMONER_2
		end
	end

-- killsteal


function killsteal()
	local i, Champion
   for i, Champion in pairs(EnemyHeroes) do
   		local ITargetDmg = GetDmg("IGNITE", Champion)
		 if I.IsReady() and ConfigYT.ignite.autouse and ITargetDmg >= Champion.health and ValidTarget(Champion) and GetDistance(Champion, Player) <= 400  then
			  CastSpell(Ignite, Champion)
			end

      if ValidTarget(Champion) then
         if GetDistance(Champion, Player) <= 680 and Q.IsReady() and getDmg("Q", Champion, Player) > Champion.health and ConfigYT.killsteal.killstealQ then
            CastSpell(_Q, Champion)
         end
      end
   end
 end
 
 --item
 
function Check()
	item_data = {
		[1] = myHero:GetSpellData(ITEM_1),
		[2] = myHero:GetSpellData(ITEM_2),
		[3] = myHero:GetSpellData(ITEM_3),
		[4] = myHero:GetSpellData(ITEM_4),
		[5] = myHero:GetSpellData(ITEM_5),
		[6] = myHero:GetSpellData(ITEM_6),
		[7] = myHero:GetSpellData(ITEM_7)
	}
	for i=1, 7, 1 do
		if item_data[i] then
			--print("slot "..i.." : "..item_data[i].name)
			if item_data[i].name == "RegenerationPotion" or item_data[i].name == "ItemMiniRegenPotion" then health_potion = itemnum(i) 
				elseif item_data[i].name == "FlaskOfCrystalWater" then mana_potion = itemnum(i) 
				elseif item_data[i].name == "ItemCrystalFlask" then flask_potion = itemnum(i) 
				elseif item_data[i].name == "QuicksilverSash" or item_data[i].name:find("mMerc") then QuicksilverSash = itemnum(i)
				elseif item_data[i].name == "ItemMorellosBane" then ItemMorellosBane = itemnum(i)
				elseif item_data[i].name == "Muramana" then Muramana = itemnum(i)
				elseif item_data[i].name == "ItemSeraphsEmbrace" then ItemSeraphsEmbrace = itemnum(i)
			end
		end
	end
	item_name = {
		["RegenerationPotion"]={time=15},
		["FlaskOfCrystalWater"]={time=15},
		["ItemCrystalFlask"]={time=12}
	}

	--myHero:CanUseSpell(QuicksilverSash)==READY
 end

 --itemnum
 
 function itemnum(i)
	if i==1 then return ITEM_1 end
	if i==2 then return ITEM_2 end
	if i==3 then return ITEM_3 end
	if i==4 then return ITEM_4 end
	if i==5 then return ITEM_5 end
	if i==6 then return ITEM_6 end
	if i==7 then return ITEM_7 end
	end
	
	
 --getDmg
 
function GetDmg(spell, enemy)

  if enemy == nil then
    return
  end
  
  local ADDmg = 0
  local APDmg = 0
  
  local Level = myHero.level
  local TotalDmg = myHero.totalDamage
  local AddDmg = myHero.addDamage
  local AP = myHero.ap
  local ArmorPen = myHero.armorPen
  local ArmorPenPercent = myHero.armorPenPercent
  local MagicPen = myHero.magicPen
  local MagicPenPercent = myHero.magicPenPercent
  
  local Armor = math.max(0, enemy.armor*ArmorPenPercent-ArmorPen)
  local ArmorPercent = Armor/(100+Armor)
  local MagicArmor = math.max(0, enemy.magicArmor*MagicPenPercent-MagicPen)
  local MagicArmorPercent = MagicArmor/(100+MagicArmor)
  
  if spell == "IGNITE" then
  
    local TrueDmg = 50+20*Level
    
    return TrueDmg
  elseif spell == "SMITE" then
  
    if Level <= 4 then
    
      local TrueDmg = 370+20*Level
      
      return TrueDmg
    elseif Level <= 9 then
    
      local TrueDmg = 330+30*Level
      
      return TrueDmg
    elseif Level <= 14 then
    
      local TrueDmg = 240+40*Level
      
      return TrueDmg
    else
    
      local TrueDmg = 100+50*Level
      
      return TrueDmg
    end
    
  elseif spell == "STALKER" then
  
    local TrueDmg = 20+8*Level
    
    return TrueDmg
  elseif spell == "BC" then
    APDmg = 100
  elseif spell == "BRK" then
    ADDmg = math.max(100, .1*enemy.maxHealth)
  elseif spell == "AA" then
    ADDmg = TotalDmg
  elseif spell == "Q" then
    ADDmg = 20*Q.level+15+1.1*TotalDmg+.4*AP    
  elseif spell == "W" then
    APDmg = 45*W.level+25+.8*AP
  elseif spell == "E" then
    APDmg = 50*E.level+25+.75*AP
  elseif spell == "R" then
    APDmg = 200*R.level+150+AddDmg+.9*AP
  end
  
  local TrueDmg = ADDmg*(1-ArmorPercent)+APDmg*(1-MagicArmorPercent)
  
  return TrueDmg
	end

-- draw

function OnDraw()

	if ConfigYT.draw.aadraw then
		DrawCircle(myHero.x, myHero.y, myHero.z, AArance, 0xFFFFCC)
	end
    if ConfigYT.draw.qdraw then
        DrawCircle(myHero.x, myHero.y, myHero.z, Q.Range, 0xFFFF0000)
    end
	--if ConfigYT.draw.targetdraw then
	--	ts:update()
	--	if ts.target ~= nil then
	--		DrawCircle(ts.target.x,ts.target.y, ts.target.z, 100, 0xFFFFFFff)
	--	end
	--end
	if ConfigYT.draw.bshroom then
		for _, v in ipairs(bestshroom) do
			DrawCircle(v.x, v.y, v.z, 100, 0x33FFFF)
		end
	end
end