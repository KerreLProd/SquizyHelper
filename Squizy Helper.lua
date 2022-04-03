------------------------------------------------------------------------------------------------------------------------------------------------------
script_name("Squizy Helper") script_author("KerreL")
require("moonloader") START_UPDATE = false
script_version("1.04") script_properties("work-in-pause")
function msg(text) sampAddChatMessage("{5AA5FF}[Squizy Helper | v"..thisScript().version.."]{FFFFFF} "..text, -1) end
------------------------------------------------------------------------------------------------------------------------------------------------------
local dlstatus = require("moonloader").download_status
local ev = require("lib.samp.events")
local vkeys = require("vkeys")
local encoding = require("encoding")
local inicfg = require("inicfg")
local Matrix3X3 = require("matrix3x3")
local Vector3D = require("vector3d")
local ImGui, imgui = pcall(require, "imgui")
local fAwesome, fa = pcall(require, "fAwesome5")
local cffi, ffi = pcall(require, "ffi")
local cmem, mem = pcall(require, "memory")
local SAMemory, samem = pcall(require, "SAMemory") samem.require "CTrain"
------------------------------------------------------------------------------------------------------------------------------------------------------
bike = {[481] = true, [509] = true, [510] = true}
moto = {[448] = true, [461] = true, [462] = true, [463] = true, [468] = true, [471] = true, [521] = true, [522] = true, [523] = true, [581] = true, [586] = true}
local AntiRenameByKerrel = getWorkingDirectory().."\\Squizy Helper.luac"
local FolderPath = getWorkingDirectory().."\\config\\Squizy Helper\\"
local ConfigPath = "Squizy Helper\\config.ini"
local ConfigFile = inicfg.load({
	main = {GM = false, BP = false, FP = false, EP = false, CP = false, MP = false, AntiBH = false, AntiGS = false, AntiCS = false, AntiMask = false, ClickWarp = false, InfRun = false, Sbiv = false, AutoMBR = false, AntiLomka = false, NoBike = false}, cars = {GM = false, BP = false, FP = false, EP = false, CP = false, MP = false, BTT = false, ColBlade = false, InstBlade = false, TuneCol = false, CarHelper = false, StepBoost = 1.100, SpeedHack = false, sMult = 1.05, sTime = 0.10, sLimit = 1.30}, helper = {MVDHelper = {Activate = false}}, settings = {Password = "", PinCode = "", AutoPass = false, AutoPin = false, AutoUpdate = true, Theme = 0}}, ConfigPath)

local mainc = ConfigFile.main
local carsc = ConfigFile.cars
local MVDHelperc = ConfigFile.helper.MVDHelper
local settingsc = ConfigFile.settings
local player_vehicle = samem.cast("CVehicle **", samem.player_vehicle)
local timer = {prev_time = 0}
local tableObjects = {}
keyToggle = VK_MBUTTON
keyApply = VK_LBUTTON
MAX_DISTANCE = 31.0

local MAIN_WINDOW = imgui.ImBool(false)
local TWO_WINDOW = imgui.ImBool(false)
local THREE_WINDOW = imgui.ImBool(false)
local FOUR_WINDOW = imgui.ImBool(false)
local FIVE_WINDOW = imgui.ImBool(false)

local GM = imgui.ImBool(mainc.GM)
local BP = imgui.ImBool(mainc.BP)
local FP = imgui.ImBool(mainc.FP)
local EP = imgui.ImBool(mainc.EP)
local CP = imgui.ImBool(mainc.CP)
local MP = imgui.ImBool(mainc.MP)
local AntiBH = imgui.ImBool(mainc.AntiBH)
local AntiGS = imgui.ImBool(mainc.AntiGS)
local AntiCS = imgui.ImBool(mainc.AntiCS)
local AntiMask = imgui.ImBool(mainc.AntiMask)
local ClickWarp = imgui.ImBool(mainc.ClickWarp)
local InfRun = imgui.ImBool(mainc.InfRun)
local Sbiv = imgui.ImBool(mainc.Sbiv)
local AutoMBR = imgui.ImBool(mainc.AutoMBR)
local AntiLomka = imgui.ImBool(mainc.AntiLomka)
local NoBike = imgui.ImBool(mainc.NoBike)

local GMc = imgui.ImBool(carsc.GM)
local BPc = imgui.ImBool(carsc.BP)
local FPc = imgui.ImBool(carsc.FP)
local EPc = imgui.ImBool(carsc.EP)
local CPc = imgui.ImBool(carsc.CP)
local MPc = imgui.ImBool(carsc.MP)
local BTT = imgui.ImBool(carsc.BTT)
local ColBlade = imgui.ImBool(carsc.ColBlade)
local InstBlade = imgui.ImBool(carsc.InstBlade)
local TuneCol = imgui.ImBool(carsc.TuneCol)
local CarHelper = imgui.ImBool(carsc.CarHelper)
local StepBoost = imgui.ImFloat(carsc.StepBoost)
local SpeedHack = imgui.ImBool(carsc.SpeedHack)
local sMult = imgui.ImFloat(carsc.sMult)
local sTime = imgui.ImFloat(carsc.sTime)
local sLimit = imgui.ImFloat(carsc.sLimit)

local AutoPass = imgui.ImBool(settingsc.AutoPass)
local AutoPin = imgui.ImBool(settingsc.AutoPin)
local AutoUpdate = imgui.ImBool(settingsc.AutoUpdate)
local Theme = imgui.ImInt(settingsc.Theme)
local Password = imgui.ImBuffer(tostring(settingsc.Password), 256)
local PinCode = imgui.ImBuffer(tostring(settingsc.PinCode), 256)
------------------------------------------------------------------------------------------------------------------------------------------------------
function ScriptLoaded()
	if ImGui == false then msg("У вас отсутствует - ImGui! Установите и перезагрузите скрипт. (Ctrl + R)") return thisScript():unload() end
	if fAwesome == false then msg("У вас отсутствует - fAwesome5! Установите и перезагрузите скрипт. (Ctrl + R)") return thisScript():unload() end
	if cffi == false then msg("У вас отсутствует - FFI! Установите и перезагрузите скрипт. (Ctrl + R)") return thisScript():unload() end
	if cmem == false then msg("У вас отсутствует - Memory! Установите и перезагрузите скрипт. (Ctrl + R)") return thisScript():unload() end
	if SAMemory == false then msg("У вас отсутствует - SA MemoryFFAAAA! Установите и перезагрузите скрипт. (Ctrl + R)") return thisScript():unload() end

	if ImGui == true and fAwesome == true and cffi == true and cmem == true and SAMemory == true then
		if AntiRenameByKerrel ~= thisScript().path then
			msg("Данный скрипт нельзя переименовать! {FF7A7A}(PROTECT BY KERREL)")
			msg("Скрипт был полностью уничтожен из этой сборки!") os.remove(thisScript().path)
			msg("В следущие разы может быть {FFAAAA}полностью удалён MoonLoader!")
			reloadScripts()
		else
			if not doesDirectoryExist(FolderPath) then createDirectory(FolderPath) end
			if not doesFileExist(ConfigPath) then inicfg.save(ConfigFile, ConfigPath) end

			msg("Успешно загружен! Активация: {FFAAAA}/shelp{FFFFFF}. Версия скрипта - {FFAAAA}v"..thisScript().version)
			msg("В скрипте присутствует авто-обновление! {FFAAAA}(по-умолчанию включено)")
			menu = "main"
		end
	end
end
------------------------------------------------------------------------------------------------------------------------------------------------------
function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(0) end ScriptLoaded() ScriptAutoUpdate() initializeRender()

	sampRegisterChatCommand("shelp", function() MAIN_WINDOW.v = not MAIN_WINDOW.v end)

	while true do CLICKWARP() wait(0)
		imgui.Process = MAIN_WINDOW.v or TWO_WINDOW.v or THREE_WINDOW.v or FOUR_WINDOW.v or FIVE_WINDOW.v
		imgui.ShowCursor = MAIN_WINDOW.v
		imgui.LockPlayer = MAIN_WINDOW.v
		OtherSettings() removePointMarker()
	end
end
------------------------------------------------------------------------------------------------------------------------------------------------------
function OtherSettings()
	if GM.v == true then
		setCharProofs(PLAYER_PED, BP.v, FP.v, EP.v, CP.v, MP.v)
	else
		setCharProofs(PLAYER_PED, false, false, false, false, false)
	end
	if GMc.v == true and isCharInAnyCar(PLAYER_PED) then
		setCarProofs(storeCarCharIsInNoSave(PLAYER_PED), BPc.v, FPc.v, EPc.v, CPc.v, MPc.v)
	elseif GMc.v == false and isCharInAnyCar(PLAYER_PED) then
		setCarProofs(storeCarCharIsInNoSave(PLAYER_PED), false, false, false, false, false)
	end
	if InfRun.v == true then
		mem.setint8(0xB7CEE4, 1)
	elseif InfRun.v == false then
		mem.setint8(0xB7CEE4, 0)
	end
	if Sbiv.v == true and isKeyJustPressed(VK_X) and not isCharInAnyCar(PLAYER_PED) and not isCharInAnyHeli(PLAYER_PED) and not isCharInAnyTrain(PLAYER_PED) and isKeyCheckAvailable() then
		freezeCharPosition(PLAYER_PED, true)
		freezeCharPosition(PLAYER_PED, false)
		setPlayerControl(PLAYER_HANDLE, true)
		clearCharTasksImmediately(PLAYER_PED)
	end
	if NoBike.v == true and isCharInAnyCar(PLAYER_PED) then
		setCharCanBeKnockedOffBike(PLAYER_PED, true)
	elseif NoBike.v == false and isCharInAnyCar(PLAYER_PED) then
		setCharCanBeKnockedOffBike(PLAYER_PED, false)
	end
	if AntiGS.v == true then
		registerIntStat(70, 1000.0)
    registerIntStat(71, 1000.0)
    registerIntStat(72, 1000.0)
    registerIntStat(76, 1000.0)
    registerIntStat(77, 1000.0)
    registerIntStat(78, 1000.0)
    registerIntStat(79, 1000.0)
	end
	if InstBlade.v == true and isCharInAnyHeli(PLAYER_PED) then
		setHeliBladesFullSpeed(storeCarCharIsInNoSave(PLAYER_PED))
	end
	if ColBlade.v == true then
		mem.fill(0x6C5107, 0x90, 59, true)
	elseif ColBlade.v == false then
		mem.hex2bin("8B5424088B4C24108B461452518B4C24686AFD508B44246C83EC0C8BD489028B842480000000894A048BCE894208E816DD01008A4E36C0E9033ACB", 0x6C5107, 59)
	end
	if AutoMBR.v then
		if isCharOnAnyBike(playerPed) and isKeyCheckAvailable() and isKeyDown(0xA0) then
			if bike[getCarModel(storeCarCharIsInNoSave(playerPed))] then
				setGameKeyState(16, 255)
				wait(10)
				setGameKeyState(16, 0)
			elseif moto[getCarModel(storeCarCharIsInNoSave(playerPed))] then
				setGameKeyState(1, -128)
				wait(10)
				setGameKeyState(1, 0)
			end
		end
		if isCharOnFoot(playerPed) and isKeyDown(0x31) and isKeyCheckAvailable() then
			setGameKeyState(16, 256)
			wait(10)
			setGameKeyState(16, 0)
		elseif isCharInWater(playerPed) and isKeyDown(0x31) and isKeyCheckAvailable() then
			setGameKeyState(16, 256)
			wait(10)
			setGameKeyState(16, 0)
		end
	end
	if CarHelper.v and isKeyCheckAvailable() then
		if isKeyJustPressed(VK_L) then sampSendChat("/lock") end
		if isKeyJustPressed(VK_K) then sampSendChat("/key") end
		if isKeyJustPressed(VK_O) then sampSendChat("/style") end
	end
	if TuneCol.v then
		local objects = getAllObjects()
		for _, object in pairs(objects) do
			if doesObjectExist(object) and isObjectAttached(object) then
				if not checkObject(object) then
					setObjectCollision(object, false)
					table.insert(tableObjects, object)
				end
			end
		end
	else
		if #tableObjects ~= 0 then
			for i = 1, #tableObjects do
				if doesObjectExist(tableObjects[1]) then
					setObjectCollision(tableObjects[1], true)
				end
				table.remove(tableObjects, 1)
			end
		end
	end
	if BTT.v and isCharInAnyCar(PLAYER_PED) and getDriverOfCar(storeCarCharIsInNoSave(PLAYER_PED)) == PLAYER_PED and not sampIsChatInputActive() and not sampIsDialogActive() then
		local vHandle = storeCarCharIsInNoSave(PLAYER_PED)
		if isKeyDown(83) and getCarSpeed(vHandle) > 5 then
			local data = samp_create_sync_data("vehicle")
			data.keysData = 160
			data.send()
		end
	end
end
function checkObject(object)
	for _, object2 in pairs(tableObjects) do
		if object2 == object then return true end
	end
	return false
end
function CLICKWARP()
	while isPauseMenuActive() do if cursorEnabled then showCursor(false) end wait(100) end
	if isKeyDown(keyToggle) and ClickWarp.v and not MAIN_WINDOW.v then cursorEnabled = not cursorEnabled showCursor(cursorEnabled) while isKeyDown(keyToggle) do wait(80) end end

	if cursorEnabled and ClickWarp.v and not MAIN_WINDOW.v then
		local mode = sampGetCursorMode()
		if mode == 0 then
			showCursor(true)
		end
		local sx, sy = getCursorPos()
		local sw, sh = getScreenResolution()
		if sx >= 0 and sy >= 0 and sx < sw and sy < sh then
			local posX, posY, posZ = convertScreenCoordsToWorld3D(sx, sy, 700.0)
			local camX, camY, camZ = getActiveCameraCoordinates()
			local result, colpoint = processLineOfSight(camX, camY, camZ, posX, posY, posZ, true, true, false, true, false, false, false)
			if result and colpoint.entity ~= 0 then
				local normal = colpoint.normal
				local pos = Vector3D(colpoint.pos[1], colpoint.pos[2], colpoint.pos[3]) - (Vector3D(normal[1], normal[2], normal[3]) * 0.1)
				local zOffset = 300
				if normal[3] >= 0.5 then zOffset = 1 end
				local result, colpoint2 = processLineOfSight(pos.x, pos.y, pos.z + zOffset, pos.x, pos.y, pos.z - 0.3,
					true, true, false, true, false, false, false)
				if result then
					pos = Vector3D(colpoint2.pos[1], colpoint2.pos[2], colpoint2.pos[3] + 1)
					local curX, curY, curZ  = getCharCoordinates(playerPed)
					local dist              = getDistanceBetweenCoords3d(curX, curY, curZ, pos.x, pos.y, pos.z)
					local hoffs             = renderGetFontDrawHeight(font)
					sy = sy - 2
					sx = sx - 2
					renderFontDrawText(font, string.format("%0.2fm", dist), sx, sy - hoffs, 0xEEEEEEEE)
					local tpIntoCar = nil
					if colpoint.entityType == 2 then
						local car = getVehiclePointerHandle(colpoint.entity)
						if doesVehicleExist(car) and (not isCharInAnyCar(playerPed) or storeCarCharIsInNoSave(playerPed) ~= car) then
							displayVehicleName(sx, sy - hoffs * 2, getNameOfVehicleModel(getCarModel(car)))
							local color = 0xAAFFFFFF
							if isKeyDown(VK_RBUTTON) then
								tpIntoCar = car
								color = 0xFFFFFFFF
								if isKeyDown(vkeys.VK_LMENU) then
									jumpIntoCar(car)
									showCursor(false)
									removePointMarker()
								end
							end
							renderFontDrawText(font2, "Hold right mouse button to teleport into the car", sx, sy - hoffs * 3, color)
						end
					end
					createPointMarker(pos.x, pos.y, pos.z)
					if isKeyDown(keyApply) then
						if dist <= MAX_DISTANCE then
							if tpIntoCar then
								if not jumpIntoCar(tpIntoCar) then
									teleportPlayer(pos.x, pos.y, pos.z)
								end
						else
							if isCharInAnyCar(playerPed) then
								local norm = Vector3D(colpoint.normal[1], colpoint.normal[2], 0)
								local norm2 = Vector3D(colpoint2.normal[1], colpoint2.normal[2], colpoint2.normal[3])
								rotateCarAroundUpAxis(storeCarCharIsInNoSave(playerPed), norm2)
								pos = pos - norm * 1.8
								pos.z = pos.z - 0.8
							end
							teleportPlayer(pos.x, pos.y, pos.z)
						end
						removePointMarker()
						while isKeyDown(keyApply) do wait(0) end showCursor(false) end
					end
				end
			end
		end
	end
end
function initializeRender()
  font = renderCreateFont("Tahoma", 10, FCR_BOLD + FCR_BORDER)
  font2 = renderCreateFont("Arial", 8, FCR_ITALICS + FCR_BORDER)
end
function removePointMarker()
  if pointMarker then
    removeUser3dMarker(pointMarker)
    pointMarker = nil
  end
end
function rotateCarAroundUpAxis(car, vec)
  local mat = Matrix3X3(getVehicleRotationMatrix(car))
  local rotAxis = Vector3D(mat.up:get())
  vec:normalize()
  rotAxis:normalize()
  local theta = math.acos(rotAxis:dotProduct(vec))
  if theta ~= 0 then
    rotAxis:crossProduct(vec)
    rotAxis:normalize()
    rotAxis:zeroNearZero()
    mat = mat:rotate(rotAxis, -theta)
  end
  setVehicleRotationMatrix(car, mat:get())
end
function readFloatArray(ptr, idx)
  return representIntAsFloat(readMemory(ptr + idx * 4, 4, false))
end
function writeFloatArray(ptr, idx, value)
  writeMemory(ptr + idx * 4, 4, representFloatAsInt(value), false)
end
function getVehicleRotationMatrix(car)
  local entityPtr = getCarPointer(car)
  if entityPtr ~= 0 then
    local mat = readMemory(entityPtr + 0x14, 4, false)
    if mat ~= 0 then
      local rx, ry, rz, fx, fy, fz, ux, uy, uz
      rx = readFloatArray(mat, 0)
      ry = readFloatArray(mat, 1)
      rz = readFloatArray(mat, 2)
      fx = readFloatArray(mat, 4)
      fy = readFloatArray(mat, 5)
      fz = readFloatArray(mat, 6)
      ux = readFloatArray(mat, 8)
      uy = readFloatArray(mat, 9)
      uz = readFloatArray(mat, 10)
      return rx, ry, rz, fx, fy, fz, ux, uy, uz
    end
  end
end
function setVehicleRotationMatrix(car, rx, ry, rz, fx, fy, fz, ux, uy, uz)
  local entityPtr = getCarPointer(car)
  if entityPtr ~= 0 then
    local mat = readMemory(entityPtr + 0x14, 4, false)
    if mat ~= 0 then
      writeFloatArray(mat, 0, rx)
      writeFloatArray(mat, 1, ry)
      writeFloatArray(mat, 2, rz)
      writeFloatArray(mat, 4, fx)
      writeFloatArray(mat, 5, fy)
      writeFloatArray(mat, 6, fz)
      writeFloatArray(mat, 8, ux)
      writeFloatArray(mat, 9, uy)
      writeFloatArray(mat, 10, uz)
    end
  end
end
function displayVehicleName(x, y, gxt)
  x, y = convertWindowScreenCoordsToGameScreenCoords(x, y)
  useRenderCommands(true)
  setTextWrapx(640.0)
  setTextProportional(true)
  setTextJustify(false)
  setTextScale(0.33, 0.8)
  setTextDropshadow(0, 0, 0, 0, 0)
  setTextColour(255, 255, 255, 230)
  setTextEdge(1, 0, 0, 0, 100)
  setTextFont(1)
  displayText(x, y, gxt)
end
function createPointMarker(x, y, z)
  pointMarker = createUser3dMarker(x, y, z + 0.3, 4)
end
function removePointMarker()
  if pointMarker then
    removeUser3dMarker(pointMarker)
    pointMarker = nil
  end
end
function getCarFreeSeat(car)
  if doesCharExist(getDriverOfCar(car)) then
    local maxPassengers = getMaximumNumberOfPassengers(car)
    for i = 0, maxPassengers do
      if isCarPassengerSeatFree(car, i) then
        return i
      end
	  i = i+1
    end
    return nil
  else
    return nil
  end
end

function jumpIntoCar(car)
  if not isKeyDown(vkeys.VK_LCONTROL) then
	for i=0,1999 do
		local _, c = sampGetCarHandleBySampVehicleId(i)
		if _ and car == c then
			thread_tp = lua_thread.create(function()
				sampSendEnterVehicle(i,false)
				wait(1000)
				if doesVehicleExist(car) then
					warpCharIntoCar(playerPed, car)
					thread_tp = nil
				end
			end)
			break
		end
	end
  else
  local seat = -1
  for i=0, getMaximumNumberOfPassengers(car) do
	if isCarPassengerSeatFree(car, i) then
		seat = i
	end
  end
	if seat == -1 then return false end
	for i=0,1999 do
		local _, c = sampGetCarHandleBySampVehicleId(i)
		if _ and car == c then
			thread_tp = lua_thread.create(function()
				sampSendEnterVehicle(i,true)
				wait(1000)
				if doesVehicleExist(car) then
					if seat ~= nil then
						warpCharIntoCarAsPassenger(playerPed, car, seat) -- passenger seat
						thread_tp = nil
					end
				end
			end)
			break
		end
	end
  end
  return true
end
function teleportPlayer(x, y, z)
  if isCharInAnyCar(playerPed) then
    setCharCoordinates(playerPed, x, y, z)
  end
  setCharCoordinatesDontResetAnim(playerPed, x, y, z)
end
function setCharCoordinatesDontResetAnim(char, x, y, z)
  if doesCharExist(char) then
    local ptr = getCharPointer(char)
    setEntityCoordinates(ptr, x, y, z)
  end
end
function setEntityCoordinates(entityPtr, x, y, z)
  if entityPtr ~= 0 then
    local matrixPtr = readMemory(entityPtr + 0x14, 4, false)
    if matrixPtr ~= 0 then
      local posPtr = matrixPtr + 0x30
      writeMemory(posPtr + 0, 4, representFloatAsInt(x), false) -- X
      writeMemory(posPtr + 4, 4, representFloatAsInt(y), false) -- Y
      writeMemory(posPtr + 8, 4, representFloatAsInt(z), false) -- Z
    end
  end
end
function showCursor(toggle)
  if toggle then
    sampSetCursorMode(CMODE_LOCKCAM)
  else
    sampToggleCursor(false)
  end
  cursorEnabled = toggle
end

function isKeyCheckAvailable()
  if not isSampfuncsLoaded() then return not isPauseMenuActive() end
  local result = not isSampfuncsConsoleActive() and not isPauseMenuActive()
	if isSampLoaded() and isSampAvailable() then
		result = result and not sampIsChatInputActive() and not sampIsDialogActive()
	end return result
end
------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------------
function samp_create_sync_data(sync_type, copy_from_player)
  local ffi = require "ffi"
  local sampfuncs = require "sampfuncs"
  local raknet = require "samp.raknet"
  copy_from_player = copy_from_player or true
  local sync_traits = {
      player = {"PlayerSyncData", raknet.PACKET.PLAYER_SYNC, sampStorePlayerOnfootData},
      vehicle = {"VehicleSyncData", raknet.PACKET.VEHICLE_SYNC, sampStorePlayerIncarData},
      passenger = {"PassengerSyncData", raknet.PACKET.PASSENGER_SYNC, sampStorePlayerPassengerData},
      aim = {"AimSyncData", raknet.PACKET.AIM_SYNC, sampStorePlayerAimData},
      trailer = {"TrailerSyncData", raknet.PACKET.TRAILER_SYNC, sampStorePlayerTrailerData},
      unoccupied = {"UnoccupiedSyncData", raknet.PACKET.UNOCCUPIED_SYNC, nil},
      bullet = {"BulletSyncData", raknet.PACKET.BULLET_SYNC, nil},
      spectator = {"SpectatorSyncData", raknet.PACKET.SPECTATOR_SYNC, nil}
  }
  local sync_info = sync_traits[sync_type]
  local data_type = "struct " .. sync_info[1]
  local data = ffi.new(data_type, {})
  local raw_data_ptr = tonumber(ffi.cast("uintptr_t", ffi.new(data_type .. "*", data)))
  if copy_from_player then
    local copy_func = sync_info[3]
    if copy_func then
      local _, player_id
      if copy_from_player == true then
        _, player_id = sampGetPlayerIdByCharHandle(PLAYER_PED)
      else
        player_id = tonumber(copy_from_player)
      end
      copy_func(player_id, raw_data_ptr)
    end
  end
  local func_send = function()
    local bs = raknetNewBitStream()
    raknetBitStreamWriteInt8(bs, sync_info[2])
    raknetBitStreamWriteBuffer(bs, raw_data_ptr, ffi.sizeof(data))
    raknetSendBitStreamEx(bs, sampfuncs.HIGH_PRIORITY, sampfuncs.UNRELIABLE_SEQUENCED, 1)
    raknetDeleteBitStream(bs)
  end
  local mt = {
		__index = function(t, index)
		return data[index] end,
    __newindex = function(t, index, value)
    data[index] = value
    end}
  return setmetatable({send = func_send}, mt)
end
function ev.onSendVehicleSync() end
function ev.onSetVehicleVelocity(turn, velocity)
	if BTT.v and isKeyDown(87) and getCarSpeed(storeCarCharIsInNoSave(PLAYER_PED)) < 101 then
    velocity.x = velocity.x*StepBoost.v
    velocity.y = velocity.y*StepBoost.v
    return {turn, velocity}
	end
end
function ev.onSetPlayerDrunk(drunkLevel)
	if AntiLomka.v then
		return {1}
	end
end
function ev.onSendPlayerSync(data)
	if AntiBH.v then
		if bit.band(data.keysData, 0x28) == 0x28 then
			data.keysData = bit.bxor(data.keysData, 0x20)
		end
	end
end
function ev.onPlayerStreamIn(id, team, model, position, rotation, color, fight)
	if AntiMask.v then
    local r, g, b, a = explode_rgba(color)
    if a >= 0 and a <= 4 then
      return {id, team, model, position, rotation, join_rgba(r, g, b, 0xAA), fight}
    end
	end
end
function onSendRpc(id, bs)
	if AntiCS.v and id == 106 then
		return false
	end
end
function setPlayerColor(id, color)
  local bs = raknetNewBitStream()
  raknetBitStreamWriteInt16(bs, id)
  raknetBitStreamWriteInt32(bs, color)
  raknetEmulRpcReceiveBitStream(72, bs)
  raknetDeleteBitStream(bs)
end
function ev.onSetPlayerColor(id, color)
  if active then
    local r, g, b, a = explode_rgba(color)
    if a >= 0 and a <= 4 then
      setPlayerColor(id, join_rgba(r, g, b, 0xAA))
      return false
    end
  end
end
function explode_rgba(rgba)
  local r = bit.band(bit.rshift(rgba, 24), 0xFF)
  local g = bit.band(bit.rshift(rgba, 16), 0xFF)
  local b = bit.band(bit.rshift(rgba, 8), 0xFF)
  local a = bit.band(rgba, 0xFF)
  return r, g, b, a
end
function join_rgba(r, g, b, a)
  local rgba = a
  rgba = bit.bor(rgba, bit.lshift(b, 8))
  rgba = bit.bor(rgba, bit.lshift(g, 16))
  rgba = bit.bor(rgba, bit.lshift(r, 24))
  return rgba
end
function ev.onClearPlayerAnimation(id)
	local _, id = sampGetPlayerIdByCharHandle(1)
	if _ and thread_tp then
		thread_tp:terminate()
		thread_tp = false
	end
end
------------------------------------------------------------------------------------------------------------------------------------------------------
function ConfigSave()
	mainc.GM = GM.v
	mainc.BP = BP.v
	mainc.FP = FP.v
	mainc.EP = EP.v
	mainc.CP = CP.v
	mainc.MP = MP.v
	mainc.AntiBH = AntiBH.v
	mainc.AntiGS = AntiGS.v
	mainc.AntiCS = AntiCS.v
	mainc.AntiMask = AntiMask.v
	mainc.ClickWarp = ClickWarp.v
	mainc.InfRun = InfRun.v
	mainc.Sbiv = Sbiv.v
	mainc.AutoMBR = AutoMBR.v
	mainc.AntiLomka = AntiLomka.v
	mainc.NoBike = NoBike.v
	carsc.GM = GMc.v
	carsc.BP = BPc.v
	carsc.FP = FPc.v
	carsc.EP = EPc.v
	carsc.CP = CPc.v
	carsc.MP = MPc.v
	carsc.BTT = BTT.v
	carsc.ColBlade = ColBlade.v
	carsc.InstBlade = InstBlade.v
	carsc.TuneCol = TuneCol.v
	carsc.CarHelper = CarHelper.v
	carsc.StepBoost = StepBoost.v
	carsc.SpeedHack = SpeedHack.v
	carsc.sMult = sMult.v
	carsc.sTime = sTime.v
	carsc.sLimit = sLimit.v
	settingsc.AutoPass = AutoPass.v
	settingsc.AutoPin = AutoPin.v
	settingsc.AutoUpdate = AutoUpdate.v
	settingsc.Password = Password.v
	settingsc.PinCode = PinCode.v

	inicfg.save(ConfigFile, ConfigPath)
end
------------------------------------------------------------------------------------------------------------------------------------------------------
encoding.default = "CP1251"
u8 = encoding.UTF8
local fa_font = nil
local fa_glyph_ranges = imgui.ImGlyphRanges({fa.min_range, fa.max_range})
function imgui.BeforeDrawFrame()
  if fa_font == nil then
    local font_config = imgui.ImFontConfig()
  	font_config.MergeMode = true
    fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF("moonloader/resource/fonts/fa-solid-900.ttf", 13.0, font_config, fa_glyph_ranges)
  end
end
ThemeList = {u8"Стандарт (by KerreL)", u8"BlastHack (by Chapo)", u8"Приятно-серая"}
function imgui.OnDrawFrame()
	if Theme.v == 0 then
		settingsc.Theme = Theme.v
		inicfg.save(ConfigFile, ConfigPath)
		SquizyTheme()
	elseif Theme.v == 1 then
		settingsc.Theme = Theme.v
		inicfg.save(ConfigFile, ConfigPath)
		BlastHackTheme()
	elseif Theme.v == 2 then
		settingsc.Theme = Theme.v
		inicfg.save(ConfigFile, ConfigPath)
		GrayTheme()
	end
	local sw, sh = getScreenResolution()
	if MAIN_WINDOW.v then
		imgui.SetNextWindowPos(imgui.ImVec2(sw/4, sh/3), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowSize(imgui.ImVec2(620, 265))
		imgui.Begin("Squizy Helper by KERREL | v"..thisScript().version, MAIN_WINDOW, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoMove)
		--====--====--====--====--====--====--====--====--====--====--====--====--====--====--====--====--====--====--
		imgui.BeginChild("SELECT", imgui.ImVec2(135, 229), false)
			imgui.SetCursorPos(imgui.ImVec2(7, 5))
				if imgui.ButtonActivated(menu=="main", fa.ICON_FA_USER_COG..u8" Основное ", imgui.ImVec2(120,40)) then menu="main" end
			imgui.SetCursorPos(imgui.ImVec2(7, 50))
				if imgui.ButtonActivated(menu=="buttons", fa.ICON_FA_LAYER_GROUP..u8" Кнопочки ", imgui.ImVec2(120,40)) then menu="buttons" end
			imgui.SetCursorPos(imgui.ImVec2(7, 50+45))
				if imgui.ButtonActivated(menu=="cars", fa.ICON_FA_CAR..u8" Транспорт ", imgui.ImVec2(120,40)) then menu="cars" end
			imgui.SetCursorPos(imgui.ImVec2(7, 95+45))
				if imgui.ButtonActivated(menu=="helpers", fa.ICON_FA_ROBOT.." Helpers ", imgui.ImVec2(120,40)) then menu="helpers" end
			imgui.SetCursorPos(imgui.ImVec2(7, 140+45))
				if imgui.ButtonActivated(menu=="settings", fa.ICON_FA_COG..u8" Настройки ", imgui.ImVec2(120,40)) then menu="settings" end
		imgui.EndChild() imgui.SameLine()

		if menu == "main" then
			imgui.BeginChild("MAIN", imgui.ImVec2(469, 229), false)
			imgui.CenterText(u8"Самые используемые функции в SAMP.")
			imgui.Separator()
			--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--
			imgui.SetCursorPos(imgui.ImVec2(5, 26+6))
			if imgui.Checkbox(u8" ГМ для игрока", GM) then ConfigSave() end
			imgui.SameLine() if imgui.Button(fa.ICON_FA_COG..u8" изменить ") then TWO_WINDOW.v = not TWO_WINDOW.v end
			imgui.SetCursorPos(imgui.ImVec2(5, 49+6))
			if imgui.Checkbox(u8" Анти-BunnyHop", AntiBH) then ConfigSave() end
			imgui.SetCursorPos(imgui.ImVec2(5, 73+6))
			if imgui.Checkbox(u8" Анти-GunSkill", AntiGS) then ConfigSave() end
			imgui.SetCursorPos(imgui.ImVec2(5, 97+6))
			if imgui.Checkbox(u8" Анти-CarSkill", AntiCS) then ConfigSave() end
			imgui.SetCursorPos(imgui.ImVec2(5, 121+6))
			if imgui.Checkbox(u8" [ARZ]Анти-Маска", AntiMask) then ConfigSave() end
			imgui.SetCursorPos(imgui.ImVec2(5, 145+6))
			if imgui.Checkbox(u8" [ARZ]Анти-ломка", AntiLomka) then ConfigSave() end
			imgui.SetCursorPos(imgui.ImVec2(5, 168+6))
			if imgui.Checkbox(u8" Бесконечный бег", InfRun) then ConfigSave() end
			imgui.SetCursorPos(imgui.ImVec2(5, 191+6))
			if imgui.Checkbox(u8" Сбив на X", Sbiv) then ConfigSave() end
			imgui.SetCursorPos(imgui.ImVec2(260, 26+6))
			if imgui.Checkbox(u8" AutoMotoBikeRun Speed", AutoMBR) then ConfigSave() end
			imgui.SetCursorPos(imgui.ImVec2(260, 49+6))
			if imgui.Checkbox(u8" ClickWarp", ClickWarp) then ConfigSave() end
			imgui.SetCursorPos(imgui.ImVec2(260, 73+6))
			if imgui.Checkbox(u8" NoBike", NoBike) then ConfigSave() end
			--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--
			imgui.EndChild()
		elseif menu == "buttons" then
			imgui.BeginChild("BUTTONS", imgui.ImVec2(469, 229), false)
			--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--
			imgui.SetCursorPos(imgui.ImVec2(15, 10))
			if imgui.Button(u8"Очистить чат", imgui.ImVec2(100, 60)) then
				mem.fill(sampGetChatInfoPtr() + 306, 0x0, 25200)
    		mem.write(sampGetChatInfoPtr() + 306, 25562, 4, 0x0)
    		mem.write(sampGetChatInfoPtr() + 0x63DA, 1, 1)
			end
			imgui.SetCursorPos(imgui.ImVec2(125, 10))
			if imgui.Button(u8"Отключиться\n  от сервера", imgui.ImVec2(100, 60)) then sampDisconnectWithReason(quit) end
			imgui.SetCursorPos(imgui.ImVec2(235, 10))
			if imgui.Button(u8"Подключиться\n   к серверу", imgui.ImVec2(100, 60)) then sampSetGamestate(1) end
			imgui.SetCursorPos(imgui.ImVec2(345, 10))
			if imgui.Button(u8"Подняться", imgui.ImVec2(100, 28)) then x, y, z = getCharCoordinates(PLAYER_PED); setCharCoordinates(PLAYER_PED, x, y, z+5) end
			imgui.SetCursorPos(imgui.ImVec2(345, 40))
			if imgui.Button(u8"Опуститься", imgui.ImVec2(100, 28)) then x, y, z = getCharCoordinates(PLAYER_PED); setCharCoordinates(PLAYER_PED, x, y, z-5) end
			--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--
			imgui.EndChild()
		elseif menu == "cars" then
			imgui.BeginChild("CARS", imgui.ImVec2(469, 229), false)
			imgui.CenterText(u8"Здесь собраны популярные функции для транспорта.")
			imgui.Separator()
			--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--
			imgui.SetCursorPos(imgui.ImVec2(5, 26+17))
			if imgui.Checkbox(u8" ГМ для транспорта", GMc) then ConfigSave() end
			imgui.SameLine() if imgui.Button(fa.ICON_FA_COG..u8" изменить ") then THREE_WINDOW.v = not THREE_WINDOW.v; FOUR_WINDOW.v = false; FIVE_WINDOW.v = false end
			imgui.SetCursorPos(imgui.ImVec2(5, 49+17))
			if imgui.Checkbox(u8" Быстрая раскрутка лопастей", InstBlade) then ConfigSave() end
			imgui.SetCursorPos(imgui.ImVec2(5, 73+17))
			if imgui.Checkbox(u8" Коллизия для лопастей", ColBlade) then ConfigSave() end
			imgui.SetCursorPos(imgui.ImVec2(5, 97+17))
			if imgui.Checkbox(u8" Speed Hack", SpeedHack) then msg("Функция SpeedHack временно недоступна."); SpeedHack.v = false end imgui.SameLine()
			--if imgui.Button(fa.ICON_FA_COG..u8" изменить##2 ") then FOUR_WINDOW.v = not FOUR_WINDOW.v; THREE_WINDOW.v = false; FIVE_WINDOW.v = false end
			imgui.SetCursorPos(imgui.ImVec2(5, 121+17))
			if imgui.Checkbox(u8" Коллизия на тюнинг", TuneCol) then ConfigSave() end
			imgui.SetCursorPos(imgui.ImVec2(5, 145+17))
			if imgui.Checkbox(u8" Усиление TwinTurbo", BTT) then ConfigSave() end imgui.SameLine()
			if imgui.Button(fa.ICON_FA_COG..u8" изменить##3 ") then FIVE_WINDOW.v = not FIVE_WINDOW.v; FOUR_WINDOW.v = false; THREE_WINDOW.v = false end
			imgui.SetCursorPos(imgui.ImVec2(5, 168+17))
			if imgui.Checkbox(u8" Car Helper", CarHelper) then ConfigSave() end
			--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--
			imgui.EndChild()
		elseif menu == "helpers" then
			imgui.SetCursorPos(imgui.ImVec2(145, 5))
			imgui.BeginChild("SELECT_HELPER", imgui.ImVec2(469, 69), false)
			--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--
			imgui.SetCursorPos(imgui.ImVec2(5, 26))
			imgui.CenterText(u8"В данной версии пока что их нету :/")
			--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--
			imgui.EndChild()
			imgui.SetCursorPos(imgui.ImVec2(145, 80))
			imgui.BeginChild("HELPER_MENU", imgui.ImVec2(469, 154), false)
			--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--
			if helper == nil then
				imgui.SetCursorPos(imgui.ImVec2(5, 65))
				imgui.CenterText(u8"Выберите необходимый хелпер в меню сверху.")
			end
			--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--
			imgui.EndChild()
		elseif menu == "settings" then
			imgui.BeginChild("SETTINGS", imgui.ImVec2(469, 229), false)
			imgui.CenterText(u8"Здесь собраны главные настройки скрипта.")
			imgui.Separator()
			--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--
			imgui.SetCursorPos(imgui.ImVec2(5, 30))
			if imgui.NewInputText("##YourPassword", Password, 200, u8"Введи ваш пароль от аккаунта", 2) then ConfigSave() end
			imgui.SetCursorPos(imgui.ImVec2(210, 30))
			if imgui.Checkbox(u8" Авто-логин", AutoPass) then ConfigSave() end
			imgui.SetCursorPos(imgui.ImVec2(5, 55))
			if imgui.NewInputText("##YourPinCode", PinCode, 200, u8"Введи ваш пин-код от карточки", 2) then ConfigSave() end
			imgui.SetCursorPos(imgui.ImVec2(210, 55))
			if imgui.Checkbox(u8" Авто-пин", AutoPin) then ConfigSave() end
			imgui.SetCursorPos(imgui.ImVec2(5, 95-7))
			if imgui.Checkbox(u8" Авто-обновление "..fa.ICON_FA_CLOUD_DOWNLOAD_ALT, AutoUpdate) then ConfigSave() end
			imgui.SameLine() imgui.TextQuestion(u8"Если функции активирована скрипт\nбудет автоматически обновляться\nдо последней версии.")
			imgui.SetCursorPos(imgui.ImVec2(5, 120-7))
			if imgui.Button(u8"Проверить обновления", imgui.ImVec2(160, 25)) then ScriptAutoUpdate() end
			imgui.SetCursorPos(imgui.ImVec2(5, 143))
			imgui.PushItemWidth(160)
    	imgui.Combo(u8" Изменить тему", Theme, ThemeList)
    	imgui.PopItemWidth()
			--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--8_8--
			imgui.EndChild()
		end
		--====--====--====--====--====--====--====--====--====--====--====--====--====--====--====--====--====--====--
		imgui.Separator()
		imgui.CenterText(u8"Вы используете Squizy Helper // Автор: KERREL // Версия: v"..thisScript().version..u8" (BETA) // telegram: @kerrel_scripter")
		imgui.End()
		if TWO_WINDOW.v and menu == "main" then
			imgui.SetNextWindowPos(imgui.ImVec2(sw/1.34, sh/2.55), imgui.Cond.FirstUseEver)
			imgui.SetNextWindowSize(imgui.ImVec2(170, 150))
			imgui.Begin("GM PED", TWO_WINDOW, imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize)
			imgui.CenterText(u8"Настройки неуязвимости") imgui.Separator()
			imgui.SetCursorPos(imgui.ImVec2(10, 35))
			if imgui.Checkbox(u8" Анти-пули", BP) then ConfigSave() end
			imgui.SetCursorPos(imgui.ImVec2(10, 57))
			if imgui.Checkbox(u8" Анти-огонь", FP) then ConfigSave() end
			imgui.SetCursorPos(imgui.ImVec2(10, 79))
			if imgui.Checkbox(u8" Анти-взрыв", EP) then ConfigSave() end
			imgui.SetCursorPos(imgui.ImVec2(10, 101))
			if imgui.Checkbox(u8" Анти-падение", CP) then ConfigSave() end
			imgui.SetCursorPos(imgui.ImVec2(10, 123))
			if imgui.Checkbox(u8" Анти-кулаки", MP) then ConfigSave() end
			imgui.End()
		end
		if THREE_WINDOW.v and menu == "cars" then
			imgui.SetNextWindowPos(imgui.ImVec2(sw/1.34, sh/2.55), imgui.Cond.FirstUseEver)
			imgui.SetNextWindowSize(imgui.ImVec2(170, 150))
			imgui.Begin("GM CAR", THREE_WINDOW, imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize)
			imgui.CenterText(u8"Настройки неуязвимости") imgui.Separator()
			imgui.SetCursorPos(imgui.ImVec2(10, 35))
			if imgui.Checkbox(u8" Анти-пули", BPc) then ConfigSave() end
			imgui.SetCursorPos(imgui.ImVec2(10, 57))
			if imgui.Checkbox(u8" Анти-огонь", FPc) then ConfigSave() end
			imgui.SetCursorPos(imgui.ImVec2(10, 79))
			if imgui.Checkbox(u8" Анти-взрыв", EPc) then ConfigSave() end
			imgui.SetCursorPos(imgui.ImVec2(10, 101))
			if imgui.Checkbox(u8" Анти-падение", CPc) then ConfigSave() end
			imgui.SetCursorPos(imgui.ImVec2(10, 123))
			if imgui.Checkbox(u8" Анти-кулаки", MPc) then ConfigSave() end
			imgui.End()
		end
		if FOUR_WINDOW.v and menu == "cars" then
			imgui.SetNextWindowPos(imgui.ImVec2(sw/1.34, sh/2.30), imgui.Cond.FirstUseEver)
			imgui.SetNextWindowSize(imgui.ImVec2(287, 110))
			imgui.Begin("GM CAR", FOUR_WINDOW, imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize)
			imgui.CenterText(u8"Настройки SpeedHack") imgui.Separator()
			imgui.PushItemWidth(120)
			imgui.SetCursorPos(imgui.ImVec2(10, 35))
			if imgui.SliderFloat(u8" Сила ускорения", sMult, 1.01, 10.00) then ConfigSave() end
			imgui.SetCursorPos(imgui.ImVec2(10, 57))
			if imgui.SliderFloat(u8" Скрость ускорения", sTime, 0.005, 1.00) then ConfigSave() end
			imgui.SetCursorPos(imgui.ImVec2(10, 79))
			if imgui.SliderFloat(u8" Максимальная скорость", sLimit, 1.00, 100.00) then ConfigSave() end
			imgui.PopItemWidth()
			imgui.End()
		end
		if FIVE_WINDOW.v and menu == "cars" then
			imgui.SetNextWindowPos(imgui.ImVec2(sw/1.34, sh/4.0), imgui.Cond.FirstUseEver)
			imgui.SetNextWindowSize(imgui.ImVec2(250, 65))
			imgui.Begin("GM CAR", FIVE_WINDOW, imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize)
			imgui.CenterText(u8"Настройки ускорения") imgui.Separator()
			imgui.PushItemWidth(120)
			imgui.SetCursorPos(imgui.ImVec2(10, 35))
			if imgui.SliderFloat(u8" Сила ускорения", StepBoost, 1.1, 10.0) then ConfigSave() end
			imgui.PopItemWidth()
			imgui.End()
		end
	end
	if MAIN_WINDOW.v == false then TWO_WINDOW.v = false; THREE_WINDOW.v = false; FOUR_WINDOW.v = false; FIVE_WINDOW.v = false end
end
------------------------------------------------------------------------------------------------------------------------------------------------------
function imgui.CenterText(text)
  local width = imgui.GetWindowWidth()
  local calc = imgui.CalcTextSize(text)
  imgui.SetCursorPosX( width / 2 - calc.x / 2 )
  imgui.Text(text)
end
function imgui.ButtonActivated(activated, ...)
  if activated then
    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.38, 0.38, 0.68, 1.00))
    imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.38, 0.38, 0.68, 1.00))
    imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.38, 0.38, 0.68, 1.00))
    imgui.Button(...)
    imgui.PopStyleColor()
    imgui.PopStyleColor()
    imgui.PopStyleColor()
  else
    return imgui.Button(...)
  end
end
function imgui.NewInputText(lable, val, width, hint, hintpos)
  local hint = hint and hint or ""
  local hintpos = tonumber(hintpos) and tonumber(hintpos) or 1
  local cPos = imgui.GetCursorPos()
  imgui.PushItemWidth(width)
  local result = imgui.InputText(lable, val)
  if #val.v == 0 then
    local hintSize = imgui.CalcTextSize(hint)
    if hintpos == 2 then imgui.SameLine(cPos.x + (width - hintSize.x) / 2)
    elseif hintpos == 3 then imgui.SameLine(cPos.x + (width - hintSize.x - 5))
    else imgui.SameLine(cPos.x + 5) end
    imgui.TextColored(imgui.ImVec4(1.00, 1.00, 1.00, 0.40), tostring(hint))
  end
  imgui.PopItemWidth()
  return result
end
function imgui.TextQuestion(description)
  imgui.TextDisabled("(?)")
  if imgui.IsItemHovered() then
		imgui.BeginTooltip()
    imgui.PushTextWrapPos(600)
    imgui.TextUnformatted(description)
    imgui.PopTextWrapPos()
  	imgui.EndTooltip()
  end
end

----====--====--====--====--====--====--====--====--====--====--====--====--====--====--====--====--====--====--====--====--====--====--====--====----
														--																[Theme for ImGui]																--
----====--====--====--====--====--====--====--====--====--====--====--====--====--====--====--====--====--====--====--====--====--====--====--====----
function SquizyTheme()
	--====--====--====--====--====--
	imgui.SwitchContext()
	local style = imgui.GetStyle()
  local colors = style.Colors
  local clr = imgui.Col
  local ImVec4 = imgui.ImVec4
  local ImVec2 = imgui.ImVec2
	--====--====--====--====--====--
	style.WindowPadding = ImVec2(5, 5)
  style.WindowRounding = 5.0
  style.ChildWindowRounding = 5.0
  style.FramePadding = ImVec2(5, 2)
  style.FrameRounding = 5.0
  style.ItemSpacing = ImVec2(5, 5)
  style.ItemInnerSpacing = ImVec2(1, 1)
  style.TouchExtraPadding = ImVec2(0, 0)
  style.IndentSpacing = 6.0
  style.ScrollbarSize = 12.0
  style.ScrollbarRounding = 5.0
  style.GrabMinSize = 20.0
  style.GrabRounding = 4.0
  style.WindowTitleAlign = ImVec2(0.5, 0.5)
	--====--====--====--====--====--
	colors[clr.Text] = ImVec4(1.00, 1.00, 1.00, 1.00)
	colors[clr.TextDisabled] = ImVec4(0.70, 0.70, 0.70, 1.00)
	colors[clr.WindowBg] = ImVec4(0.10, 0.10, 0.10, 1.00)
	colors[clr.ChildWindowBg] = ImVec4(0.15, 0.15, 0.15, 1.00)
	colors[clr.PopupBg] = ImVec4(0.30, 0.30, 0.30, 1.00)
	colors[clr.Border] = ImVec4(0.40, 0.18, 0.84, 1.00)
	colors[clr.BorderShadow] = ImVec4(0.40, 0.18, 0.84, 1.00)
	colors[clr.FrameBg] = ImVec4(0.30, 0.30, 0.30, 0.60)
	colors[clr.FrameBgHovered] = ImVec4(0.30, 0.30, 0.30, 0.80)
	colors[clr.FrameBgActive] = ImVec4(0.30, 0.30, 0.30, 1.00)
	colors[clr.TitleBg] = ImVec4(0.10, 0.10, 0.10, 1.00)
	colors[clr.TitleBgActive] = ImVec4(0.10, 0.10, 0.10, 1.00)
	colors[clr.TitleBgCollapsed] = ImVec4(0.10, 0.10, 0.10, 1.00)
	colors[clr.MenuBarBg] = ImVec4(0.40, 0.40, 0.40, 1.00)
	colors[clr.ScrollbarBg] = ImVec4(0.20, 0.25, 0.30, 0.60)
	colors[clr.ScrollbarGrab] = ImVec4(0.41, 0.55, 0.78, 0.70)
	colors[clr.ScrollbarGrabHovered] = ImVec4(0.49, 0.63, 0.86, 0.80)
	colors[clr.ScrollbarGrabActive] = ImVec4(0.49, 0.63, 0.86, 1.00)
	colors[clr.ComboBg] = ImVec4(0.20, 0.20, 0.20, 1.00)
	colors[clr.CheckMark] = ImVec4(0.70, 0.70, 0.85, 1.00)
	colors[clr.SliderGrab] = ImVec4(0.35, 0.20, 0.80, 0.60)
	colors[clr.SliderGrabActive] = ImVec4(0.35, 0.20, 0.80, 1.00)
	colors[clr.Button] = ImVec4(0.40, 0.40, 0.40, 1.00)
	colors[clr.ButtonHovered] = ImVec4(0.42, 0.42, 0.42, 1.00)
	colors[clr.ButtonActive] = ImVec4(0.45, 0.45, 0.45, 1.00)
	colors[clr.Header] = ImVec4(0.19, 0.22, 0.26, 1.00)
	colors[clr.HeaderHovered] = ImVec4(0.22, 0.24, 0.28, 1.00)
	colors[clr.HeaderActive] = ImVec4(0.22, 0.24, 0.28, 1.00)
	colors[clr.Separator] = ImVec4(0.38, 0.38, 0.68, 1.00)
	colors[clr.SeparatorHovered] = ImVec4(0.38, 0.38, 0.68, 1.00)
	colors[clr.SeparatorActive] = ImVec4(0.38, 0.38, 0.68, 1.00)
	colors[clr.ResizeGrip] = ImVec4(0.70, 0.70, 0.70, 0.50)
	colors[clr.ResizeGripHovered] = ImVec4(1.00, 1.00, 1.00, 0.50)
	colors[clr.ResizeGripActive] = ImVec4(1.00, 1.00, 1.00, 0.70)
	colors[clr.CloseButton] = ImVec4(0.15, 0.15, 0.15, 0.50)
	colors[clr.CloseButtonHovered] = ImVec4(0.20, 0.20, 0.20, 0.50)
	colors[clr.CloseButtonActive] = ImVec4(0.20, 0.20, 0.20, 0.70)
	colors[clr.PlotLines] = ImVec4(1.00, 1.00, 1.00, 1.00)
	colors[clr.PlotLinesHovered] = ImVec4(0.90, 0.70, 0.00, 1.00)
	colors[clr.PlotHistogram] = ImVec4(0.90, 0.70, 0.00, 1.00)
	colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
	colors[clr.TextSelectedBg] = ImVec4(0.41, 0.55, 0.78, 1.00)
	colors[clr.ModalWindowDarkening] = ImVec4(0.16, 0.18, 0.22, 0.76)
	--====--====--====--====--====--
end
function BlastHackTheme()
	--====--====--====--====--====--
  imgui.SwitchContext()
  local style = imgui.GetStyle()
  local colors = style.Colors
  local clr = imgui.Col
  local ImVec4 = imgui.ImVec4
  local ImVec2 = imgui.ImVec2
	--====--====--====--====--====--
	style.WindowPadding = ImVec2(5, 5)
  style.WindowRounding = 5.0
  style.ChildWindowRounding = 5.0
  style.FramePadding = ImVec2(5, 2)
  style.FrameRounding = 5.0
  style.ItemSpacing = ImVec2(5, 5)
  style.ItemInnerSpacing = ImVec2(1, 1)
  style.TouchExtraPadding = ImVec2(0, 0)
  style.IndentSpacing = 6.0
  style.ScrollbarSize = 12.0
  style.ScrollbarRounding = 5.0
  style.GrabMinSize = 20.0
  style.GrabRounding = 4.0
  style.WindowTitleAlign = ImVec2(0.5, 0.5)
	--====--====--====--====--====--
  colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
  colors[clr.TextDisabled]           = ImVec4(0.28, 0.30, 0.35, 1.00)
  colors[clr.WindowBg]               = ImVec4(0.16, 0.18, 0.22, 1.00)
  colors[clr.ChildWindowBg]          = ImVec4(0.19, 0.22, 0.26, 1.00)
  colors[clr.PopupBg]                = ImVec4(0.05, 0.05, 0.10, 0.90)
  colors[clr.Border]                 = ImVec4(0.19, 0.22, 0.26, 1.00)
  colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
  colors[clr.FrameBg]                = ImVec4(0.19+0.1, 0.22+0.1, 0.26+0.1, 1.00)
  colors[clr.FrameBgHovered]         = ImVec4(0.22+0.1, 0.25+0.1, 0.30+0.1, 1.00)
  colors[clr.FrameBgActive]          = ImVec4(0.22+0.1, 0.25+0.1, 0.29+0.1, 1.00)
  colors[clr.TitleBg]                = ImVec4(0.19, 0.22, 0.26, 1.00)
  colors[clr.TitleBgActive]          = ImVec4(0.19, 0.22, 0.26, 1.00)
  colors[clr.TitleBgCollapsed]       = ImVec4(0.19, 0.22, 0.26, 0.59)
  colors[clr.MenuBarBg]              = ImVec4(0.19, 0.22, 0.26, 1.00)
  colors[clr.ScrollbarBg]            = ImVec4(0.20, 0.25, 0.30, 0.60)
  colors[clr.ScrollbarGrab]          = ImVec4(0.41, 0.55, 0.78, 1.00)
  colors[clr.ScrollbarGrabHovered]   = ImVec4(0.49, 0.63, 0.86, 1.00)
  colors[clr.ScrollbarGrabActive]    = ImVec4(0.49, 0.63, 0.86, 1.00)
  colors[clr.ComboBg]                = ImVec4(0.20, 0.20, 0.20, 0.99)
  colors[clr.CheckMark]              = ImVec4(0.90, 0.90, 0.90, 0.50)
  colors[clr.SliderGrab]             = ImVec4(1.00, 1.00, 1.00, 0.30)
  colors[clr.SliderGrabActive]       = ImVec4(0.80, 0.50, 0.50, 1.00)
  colors[clr.Button]                 = ImVec4(0.41, 0.55, 0.78, 1.00)
  colors[clr.ButtonHovered]          = ImVec4(0.49, 0.62, 0.85, 1.00)
  colors[clr.ButtonActive]           = ImVec4(0.49, 0.62, 0.85, 1.00)
  colors[clr.Header]                 = ImVec4(0.19, 0.22, 0.26, 1.00)
  colors[clr.HeaderHovered]          = ImVec4(0.22, 0.24, 0.28, 1.00)
  colors[clr.HeaderActive]           = ImVec4(0.22, 0.24, 0.28, 1.00)
  colors[clr.Separator]              = ImVec4(0.41, 0.55, 0.78, 1.00)
  colors[clr.SeparatorHovered]       = ImVec4(0.41, 0.55, 0.78, 1.00)
  colors[clr.SeparatorActive]        = ImVec4(0.41, 0.55, 0.78, 1.00)
  colors[clr.ResizeGrip]             = ImVec4(0.41, 0.55, 0.78, 1.00)
  colors[clr.ResizeGripHovered]      = ImVec4(0.49, 0.61, 0.83, 1.00)
  colors[clr.ResizeGripActive]       = ImVec4(0.49, 0.62, 0.83, 1.00)
  colors[clr.CloseButton]            = ImVec4(0.41, 0.55, 0.78, 1.00)
  colors[clr.CloseButtonHovered]     = ImVec4(0.50, 0.63, 0.84, 1.00)
  colors[clr.CloseButtonActive]      = ImVec4(0.41, 0.55, 0.78, 1.00)
  colors[clr.PlotLines]              = ImVec4(1.00, 1.00, 1.00, 1.00)
  colors[clr.PlotLinesHovered]       = ImVec4(0.90, 0.70, 0.00, 1.00)
  colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
  colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
  colors[clr.TextSelectedBg]         = ImVec4(0.41, 0.55, 0.78, 1.00)
  colors[clr.ModalWindowDarkening]   = ImVec4(0.16, 0.18, 0.22, 0.76)
	--====--====--====--====--====--
end
function GrayTheme()
	--====--====--====--====--====--
  imgui.SwitchContext()
  local style = imgui.GetStyle()
  local colors = style.Colors
  local clr = imgui.Col
  local ImVec4 = imgui.ImVec4
  local ImVec2 = imgui.ImVec2
	--====--====--====--====--====--
	style.WindowPadding = ImVec2(5, 5)
  style.WindowRounding = 5.0
  style.ChildWindowRounding = 5.0
  style.FramePadding = ImVec2(5, 2)
  style.FrameRounding = 5.0
  style.ItemSpacing = ImVec2(5, 5)
  style.ItemInnerSpacing = ImVec2(1, 1)
  style.TouchExtraPadding = ImVec2(0, 0)
  style.IndentSpacing = 6.0
  style.ScrollbarSize = 12.0
  style.ScrollbarRounding = 5.0
  style.GrabMinSize = 20.0
  style.GrabRounding = 4.0
  style.WindowTitleAlign = ImVec2(0.5, 0.5)
	--====--====--====--====--====--
	colors[clr.Text] = ImVec4(0.95, 0.96, 0.98, 1.00)
	colors[clr.TextDisabled] = ImVec4(0.36, 0.42, 0.47, 1.00)
	colors[clr.WindowBg] = ImVec4(0.11, 0.15, 0.17, 1.00)
	colors[clr.ChildWindowBg] = ImVec4(0.15, 0.18, 0.22, 1.00)
	colors[clr.PopupBg] = ImVec4(0.08, 0.08, 0.08, 0.94)
	colors[clr.Border] = ImVec4(0.43, 0.43, 0.50, 0.50)
	colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.FrameBg] = ImVec4(0.20, 0.25, 0.29, 1.00)
	colors[clr.FrameBgHovered] = ImVec4(0.12, 0.20, 0.28, 1.00)
	colors[clr.FrameBgActive] = ImVec4(0.09, 0.12, 0.14, 1.00)
	colors[clr.TitleBg] = ImVec4(0.09, 0.12, 0.14, 0.65)
	colors[clr.TitleBgCollapsed] = ImVec4(0.00, 0.00, 0.00, 0.51)
	colors[clr.TitleBgActive] = ImVec4(0.08, 0.10, 0.12, 1.00)
	colors[clr.MenuBarBg] = ImVec4(0.15, 0.18, 0.22, 1.00)
	colors[clr.ScrollbarBg] = ImVec4(0.02, 0.02, 0.02, 0.39)
	colors[clr.ScrollbarGrab] = ImVec4(0.20, 0.25, 0.29, 1.00)
	colors[clr.ScrollbarGrabHovered] = ImVec4(0.18, 0.22, 0.25, 1.00)
	colors[clr.ScrollbarGrabActive] = ImVec4(0.09, 0.21, 0.31, 1.00)
	colors[clr.ComboBg] = ImVec4(0.20, 0.25, 0.29, 1.00)
	colors[clr.Separator] = ImVec4(1.00, 1.00, 1.00, 1.00)
	colors[clr.SeparatorHovered] = ImVec4(1.00, 1.00, 1.00, 1.00)
	colors[clr.SeparatorActive] = ImVec4(1.00, 0.38, 1.00, 1.00)
	colors[clr.CheckMark] = ImVec4(0.28, 0.56, 1.00, 1.00)
	colors[clr.SliderGrab] = ImVec4(0.28, 0.56, 1.00, 1.00)
	colors[clr.SliderGrabActive] = ImVec4(0.37, 0.61, 1.00, 1.00)
	colors[clr.Button] = ImVec4(0.20, 0.25, 0.29, 1.00)
	colors[clr.ButtonHovered] = ImVec4(0.28, 0.56, 1.00, 1.00)
	colors[clr.ButtonActive] = ImVec4(0.06, 0.53, 0.98, 1.00)
	colors[clr.Header] = ImVec4(0.20, 0.25, 0.29, 0.55)
	colors[clr.HeaderHovered] = ImVec4(0.26, 0.59, 0.98, 0.80)
	colors[clr.HeaderActive] = ImVec4(0.26, 0.59, 0.98, 1.00)
	colors[clr.ResizeGrip] = ImVec4(0.26, 0.59, 0.98, 0.25)
	colors[clr.ResizeGripHovered] = ImVec4(0.26, 0.59, 0.98, 0.67)
	colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
	colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
	colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
	colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
	colors[clr.PlotLines] = ImVec4(0.61, 0.61, 0.61, 1.00)
	colors[clr.PlotLinesHovered] = ImVec4(1.00, 0.43, 0.35, 1.00)
	colors[clr.PlotHistogram] = ImVec4(0.90, 0.70, 0.00, 1.00)
	colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
	colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
	colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
	--====--====--====--====--====--
end

function DownloadFile(URL, ScriptName)
	if URL == nil then msg("У вас не указана ссылка на файл! Загрузка отменена.") return false end
	if ScriptName == nil then msg("У вас не указан путь для файла! Загрузка отменена.") return false end

	local Path = getWorkingDirectory().."\\[SquizyDownloader] "..ScriptName
	lua_thread.create(function()
		downloadUrlToFile(URL, Path, function(id, status, p1, p2)
			if status == dlstatus.STATUS_ENDDOWNLOADDATA then
		 		script.load(Path)
				wait(1000)
				msg("Скрипт успешно скачался и был загружен в игру!")
			end
		end)
	end)
end
function ScriptAutoUpdate()
	if AutoUpdate.v == true then
		local URL_UPDATE = "https://github.com/KerreLProd/SquizyHelper/raw/main/update.ini"
		local PATH_UPDATE = FolderPath.."update.ini"
		local URL_SCRIPT = ""
		local PATH_SCRIPT = thisScript().path
		lua_thread.create(function()
			downloadUrlToFile(URL_UPDATE, PATH_UPDATE, function(id, status)
				if status == dlstatus.STATUS_ENDDOWNLOADDATA then
					update = inicfg.load(nil, PATH_UPDATE)
					if tonumber(update.info.version) > tonumber(thisScript().version) then
						msg("Доступно новое обновление! Версия: "..update.info.text_version)
						START_UPDATE = true
					elseif tonumber(update.info.version) == tonumber(thisScript().version) then
						msg("Обновлений не найдено! Вы используете самую последнюю версию.")
					end
				end
			end)
			if START_UPDATE == true then
				downloadUrlToFile(URL_SCRIPT, PATH_SCRIPT, function(id, status)
					if status == dlstatus.STATUS_ENDDOWNLOADDATA then
						msg("Скрипт был успешно обновлён!")
						thisScript():reload()
					end
				end)
			end
		end)
	end
end
