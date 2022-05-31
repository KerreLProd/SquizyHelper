-----------------------------------------------------------------------------------------------------------------------------------
									script_name("Anti-Rvanka") script_author("KERREL") script_version("3.74 FIX")
							 function msg(text) sampAddChatMessage("{559CFF}[Анти-Рванка]{FFFFFF} "..text, -1) end
			local Events_exist, ev = pcall(require, "lib.samp.events") local IniCFG_exist, inicfg = pcall(require, "inicfg")
-----------------------------------------------------------------------------------------------------------------------------------
if Events_exist == false then msg("Для продолжения работы скрипта отсутствует библиотека - EVENTS!") return thisScript():unload() end
if IniCFG_exist == false then msg("Для продолжения работы скрипта отсутствует библиотека - INICFG!") return thisScript():unload() end
-----------------------------------------------------------------------------------------------------------------------------------
local config, name = inicfg.load({settings = {activate = true, log = true, message = true, typemsg = 1, autorep = false}, param = {ONFOOT_SPEED_LIMIT = 0.7, INCAR_SPEED_LIMIT = 0.745, UNOC_SPEED_LIMIT = 0.614, ONFOOT_DIST_LIMIT = 5, INCAR_DIST_LIMIT = 7, UNOC_DIST_LIMIT = 160, MSG_COOLDOWN = 2}}, "KERREL SCRIPTS\\AntiRvanka.ini"), "KERREL SCRIPTS\\AntiRvanka.ini" local settings, param, warn, MSG_ERROR, typeMSG, SendReport = config.settings, config.param, {}, "Ошибка! Обратитесь к автору в тг - {559CFF}@kerrel_scripter", 0, false
local caption, button1, button2 = "{559CFF}<< Анти-Рванка |{FFFFFF}| ", "Принять", "Закрыть"
-----------------------------------------------------------------------------------------------------------------------------------
function Config(arg)
	if arg == "save" then
		inicfg.save(config, name)
	elseif arg == "reset" then
		settings.activate = true
		settings.log = true
		settings.message = true
		settings.typemsg = 1
		settings.autorep = false
		param.ONFOOT_DIST_LIMIT = 5
		param.INCAR_DIST_LIMIT = 7
		param.UNOC_DIST_LIMIT = 160
		param.ONFOOT_SPEED_LIMIT = 0.7
		param.INCAR_SPEED_LIMIT = 0.745
		param.UNOC_SPEED_LIMIT = 0.614
		param.MSG_COOLDOWN = 2
		inicfg.save(config, name) msg("Настройки по-умолчанию установлены!")
	else
		msg(MSG_ERROR)
		return
	end
end
-----------------------------------------------------------------------------------------------------------------------------------
function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(0) end msg("Успешно загружена! Активация - {559CFF}/antirv")
	sampRegisterChatCommand("antirv", OpenMenu)

	while true do wait(0)
		if settings.typemsg == 1 then typeMSG = "{559CFF}в чате" end
		if settings.typemsg == 2 then typeMSG = "{559CFF}на экране" end
		if settings.typemsg == 3 then typeMSG = "{559CFF}везде" end
		--=============================================================================================================================
		local result, button, list, input = sampHasDialogRespond(10)
		if result then
			if button == 1 then
				if list == 0 then settings.activate = not settings.activate Config("save") OpenMenu() end
				if list == 1 then settings.log = not settings.log Config("save") OpenMenu() end
				if list == 2 then settings.message = not settings.message Config("save") OpenMenu() end
				if list == 3 then settings.autorep = not settings.autorep Config("save") OpenMenu() end
				if list == 4 then OpenMenu() end
				if list == 5 then OpenSettings() end
				if list == 6 then LoggMenu() end
				if list == 7 then
					os.remove(getWorkingDirectory().."\\config\\KERREL SCRIPTS\\CheatLogger.txt")
					OpenMenu() msg("Логи успешно очищены!")
				end
			end
		end
		--=============================================================================================================================
		local result1, button1, list1, input1 = sampHasDialogRespond(11)
		if result1 then
			if button1 == 1 then
				if list1 == 0 then SetSetting("ONFOOT_DIST") end
				if list1 == 1 then SetSetting("INCAR_DIST") end
				if list1 == 2 then SetSetting("UNOC_DIST") end
				if list1 == 3 then SetSetting("ONFOOT_LIMIT") end
				if list1 == 4 then SetSetting("INCAR_LIMIT") end
				if list1 == 5 then SetSetting("UNOC_LIMIT") end
				if list1 == 6 then SetSetting("MSG_CD") end
				if list1 == 7 then
					local st = true
					for i = settings.typemsg, 4 do
						if st == true then
							if settings.typemsg == 1 then
								typeMSG = "{559CFF}в чате"
								settings.typemsg = i+1 st = false
								OpenSettings() Config("save") end
							if settings.typemsg == 2 then
								typeMSG = "{559CFF}на экране"
								settings.typemsg = i+1 st = false
								OpenSettings() Config("save") end
							if settings.typemsg == 3 then
								typeMSG = "{559CFF}везде"
								settings.typemsg = i+1 st = false
								OpenSettings() Config("save") end
							if settings.typemsg == 4 then
								typeMSG = "{559CFF}в чате"
								settings.typemsg = 1 st = false
								OpenSettings() Config("save")
							end
						end
					end
				end
				if list1 == 8 then OpenSettings() end
				if list1 == 9 then Config("reset") OpenMenu() end
			else OpenMenu() end
		end
		--=============================================================================================================================
		local result2, button2, list2, input2 = sampHasDialogRespond(12)
		if result2 then
			if button2 == 1 then
				if type(tonumber(input2)) ~= "number" then SetSetting("ONFOOT_DIST") return msg("Проверьте правильность ввода! {559CFF}(только цифры)") end
				param.ONFOOT_DIST_LIMIT = tonumber(input2) Config("save") OpenSettings()
			else OpenSettings() end
		end
		local result3, button3, list3, input3 = sampHasDialogRespond(13)
		if result3 then
			if button3 == 1 then
				if type(tonumber(input3)) ~= "number" then SetSetting("INCAR_DIST") return msg("Проверьте правильность ввода! {559CFF}(только цифры)") end
				param.INCAR_DIST_LIMIT = tonumber(input3) Config("save") OpenSettings()
			else OpenSettings() end
		end
		local result4, button4, list4, input4 = sampHasDialogRespond(14)
		if result4 then
			if button4 == 1 then
				if type(tonumber(input4)) ~= "number" then SetSetting("UNOC_DIST") return msg("Проверьте правильность ввода! {559CFF}(только цифры)") end
				param.UNOC_DIST_LIMIT = tonumber(input4) Config("save") OpenSettings()
			else OpenSettings() end
		end
		local result5, button5, list5, input5 = sampHasDialogRespond(15)
		if result5 then
			if button5 == 1 then
				if type(tonumber(input5)) ~= "number" then SetSetting("ONFOOT_LIMIT") return msg("Проверьте правильность ввода! {559CFF}(только цифры)") end
				param.ONFOOT_SPEED_LIMIT = tonumber(input5) Config("save") OpenSettings()
			else OpenSettings() end
		end
		local result6, button6, list6, input6 = sampHasDialogRespond(16)
		if result6 then
			if button6 == 1 then
				if type(tonumber(input6)) ~= "number" then SetSetting("INCAR_LIMIT") return msg("Проверьте правильность ввода! {559CFF}(только цифры)") end
				param.INCAR_SPEED_LIMIT = tonumber(input6) Config("save") OpenSettings()
			else OpenSettings() end
		end
		local result7, button7, list7, input7 = sampHasDialogRespond(17)
		if result7 then
			if button7 == 1 then
				if type(tonumber(input7)) ~= "number" then SetSetting("UNOC_LIMIT") return msg("Проверьте правильность ввода! {559CFF}(только цифры)") end
				param.UNOC_SPEED_LIMIT = tonumber(input7) Config("save") OpenSettings()
			else OpenSettings() end
		end
		local result8, button8, list8, input8 = sampHasDialogRespond(18)
		if result8 then
			if button8 == 1 then
				if type(tonumber(input8)) ~= "number" then SetSetting("MSG_CD") return msg("Проверьте правильность ввода! {559CFF}(только цифры)") end
				param.MSG_COOLDOWN = tonumber(input8) Config("save") OpenSettings()
			else OpenSettings() end
		end
		--=============================================================================================================================
		local result9, button9, list9, input9 = sampHasDialogRespond(19)
		if result9 then
			if button9 == 1 then
				OpenMenu()
			else
				OpenMenu()
			end
		end
		--=============================================================================================================================
	end
end
-----------------------------------------------------------------------------------------------------------------------------------
function OpenMenu()
	local first = "{559CFF}[1]{FFFFFF} Состояние работы  --  "..(settings.activate and "{00AA00}Включено" or "{AA0000}Выключено").."\n"
	local two = "{559CFF}[2]{FFFFFF} Логирование игроков  --  "..(settings.log and "{00AA00}Включено" or "{AA0000}Выключено").."\n"
	local three = "{559CFF}[3]{FFFFFF} Уведомление о рванке  --  "..(settings.message and "{00AA00}Включено" or "{AA0000}Выключено").."\n"
	local four = "{559CFF}[4]{FFFFFF} Авто-репорт на рванку  --  "..(settings.autorep and "{00AA00}Включено" or "{AA0000}Выключено").."\n"
	local five = "{559CFF}<<{FFFFFF} Изменить настройки Анти-Рванки {559CFF}>>{FFFFFF}\n"
	local six = "{559CFF}<<{FFFFFF} Посмотреть логи Анти-Рванки {559CFF}>>{FFFFFF}\n"
	local seven = "{559CFF}<<{FFFFFF} Очистить логи Анти-Рванки {559CFF}>>{FFFFFF}\n"
	sampShowDialog(10, caption.."Основое меню >>", first..two..three..four.." \n"..five..six..seven, button1, button2, 4)
end
function OpenSettings()
	local first = "{559CFF}[1]{FFFFFF} Радиус действия ONFOOT\t{559CFF}"..param.ONFOOT_DIST_LIMIT.."\n"
	local two = "{559CFF}[2]{FFFFFF} Радиус действия INCAR\t{559CFF}"..param.INCAR_DIST_LIMIT.."\n"
	local three = "{559CFF}[3]{FFFFFF} Радиус действия UNOCCUPIED\t{559CFF}"..param.UNOC_DIST_LIMIT.."\n"
	local four = "{559CFF}[4]{FFFFFF} Максимальная скорость ONFOOT\t{559CFF}"..param.ONFOOT_SPEED_LIMIT.."\n"
	local five = "{559CFF}[5]{FFFFFF} Максимальная скорость INCAR\t{559CFF}"..param.INCAR_SPEED_LIMIT.."\n"
	local six = "{559CFF}[6]{FFFFFF} Максимальная скорость UNOCCUPIED\t{559CFF}"..param.UNOC_SPEED_LIMIT.."\n"
	local seven = "{559CFF}[7]{FFFFFF} Повтор уведомления о рванке\t{559CFF}"..param.MSG_COOLDOWN.."\n"
	local eight = "{559CFF}[8]{FFFFFF} Отображение уведомлений {559CFF}"..typeMSG.."\n \n"
	local nine = "{559CFF}<<{FFFFFF} Восстановить настройки по-умолчанию {559CFF}>>{FFFFFF}\n"
	sampShowDialog(11, caption.."Настройки >>", first..two..three..four..five..six..seven..eight..nine, button1, "Назад", 4)
end
function SetSetting(selected)
	if selected == "ONFOOT_DIST" then
		local text = "{FFFFFF}Настройка радиуса действия Анти-ONFOOT рванки.\nТекущий параметр: {559CFF}"..param.ONFOOT_DIST_LIMIT
		local button1, button2 = "Сохранить", "Назад"
		sampShowDialog(12, caption.."ONFOOT >>", text, button1, button2, 1)
	elseif selected == "INCAR_DIST" then
		local text = "{FFFFFF}Настройка радиуса действия Анти-INCAR рванки.\nТекущий параметр: {559CFF}"..param.INCAR_DIST_LIMIT
		local button1, button2 = "Сохранить", "Назад"
		sampShowDialog(13, caption.."INCAR >>", text, button1, button2, 1)
	elseif selected == "UNOC_DIST" then
		local text = "{FFFFFF}Настройка радиуса действия Анти-UNOCCUPIED рванки.\nТекущий параметр: {559CFF}"..param.UNOC_DIST_LIMIT
		local button1, button2 = "Сохранить", "Назад"
		sampShowDialog(14, caption.."UNOCCUPIED >>", text, button1, button2, 1)
	elseif selected == "ONFOOT_LIMIT" then
		local text = "{FFFFFF}Настройка скорости Анти-ONFOOT рванки.\nТекущий параметр: {559CFF}"..param.ONFOOT_SPEED_LIMIT
		local button1, button2 = "Сохранить", "Назад"
		sampShowDialog(15, caption.."ONFOOT >>", text, button1, button2, 1)
	elseif selected == "INCAR_LIMIT" then
		local text = "{FFFFFF}Настройка скорости Анти-INCAR рванки.\nТекущий параметр: {559CFF}"..param.INCAR_SPEED_LIMIT
		local button1, button2 = "Сохранить", "Назад"
		sampShowDialog(16, caption.."INCAR >>", text, button1, button2, 1)
	elseif selected == "UNOC_LIMIT" then
		local text = "{FFFFFF}Настройка скорости Анти-UNOCCUPIED рванки.\nТекущий параметр: {559CFF}"..param.UNOC_SPEED_LIMIT
		local button1, button2 = "Сохранить", "Назад"
		sampShowDialog(17, caption.."UNOCCUPIED >>", text, button1, button2, 1)
	elseif selected == "MSG_CD" then
		local text = "{FFFFFF}Настройка времени повторения уведомлений.\nТекущий параметр: {559CFF}"..param.MSG_COOLDOWN
		local button1, button2 = "Сохранить", "Назад"
		sampShowDialog(18, caption.."Уведомления >>", text, button1, button2, 1)
	else
		msg(MSG_ERROR)
		OpenSettings()
	end
end
function LoggMenu()
	local file = getWorkingDirectory().."\\config\\KERREL SCRIPTS\\CheatLogger.txt"
	local fileLog = io.open(file, "a") fileLog:close() -- создание файла с логами
	local fileLog = io.open(file, "r") -- читаем файл с логами
	sampShowDialog(19, caption.."Система логирования >>", "        Дата | Время\t        Информация об игроке\tТип рванки\n"..fileLog:read("*a"), "Назад", nil, 5) fileLog:close()
end
-----------------------------------------------------------------------------------------------------------------------------------
function getSpeedFromVector3D(vec) return math.sqrt(vec.x^2 + vec.y^2 + vec.z^2) end
function getDistanceFrom(vec) local x, y, z = getCharCoordinates(PLAYER_PED) return math.sqrt((vec.x-x)^2 + (vec.y-y)^2 + (vec.z-z)^2) end
function ev.onPlayerSync(id, data)
	if settings.activate == true and getSpeedFromVector3D(data.moveSpeed) >= tonumber(param.ONFOOT_SPEED_LIMIT) and getDistanceFrom(data.position) <= tonumber(param.ONFOOT_DIST_LIMIT) then
		sendWarning(id, "ONFOOT") return false
	end
end
function ev.onVehicleSync(id, veh, data)
	if settings.activate == true and getSpeedFromVector3D(data.moveSpeed) >= tonumber(param.INCAR_SPEED_LIMIT) and getDistanceFrom(data.position) <= tonumber(param.INCAR_DIST_LIMIT) then
		local result, VEHICLE_HANDLE = sampGetCarHandleBySampVehicleId(veh)
		if not isCharInCar(PLAYER_PED, VEHICLE_HANDLE) then
			sendWarning(id, "INCAR") return false
		end
	end
end
function ev.onUnoccupiedSync(id, data)
	if settings.activate == true then
		if getDistanceFrom(data.position) <= tonumber(param.UNOC_DIST_LIMIT) then
			if data.turnSpeed.x > 0.19 or data.turnSpeed.y > 0.19 or data.turnSpeed.z > 0.19 then
				sendWarning(id, "UNOCCUPIED (Volent Project)") return false
			end
			if getSpeedFromVector3D(data.moveSpeed) >= tonumber(param.UNOC_SPEED_LIMIT) then
				sendWarning(id, "UNOCCUPIED") return false
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------
function sendWarning(id, rtype)
	if warn[id] and os.clock() - warn[id] < tonumber(param.MSG_COOLDOWN) then return end
	warn[id] = os.clock()
	local pNick = sampIsPlayerConnected(id) and sampGetPlayerNickname(id)
	local pLvl = sampIsPlayerConnected(id) and sampGetPlayerScore(id)
	local pPing = sampIsPlayerConnected(id) and sampGetPlayerPing(id)
	if settings.message == true then
		if settings.typemsg == 1 then
			msg(string.format("%s [ID: %d | LVL: %d | PING: %d] Возможно использует: %s рванка!", pNick, id, pLvl, pPing, rtype))
		elseif settings.typemsg == 2 then
			printStringNow(string.format("~b~[ANTI-RVANKA]~w~ %s [ID: %d, LVL: %d, PING: %d] MAYBE USE: ~r~%s RVANKA", pNick, id, pLvl, pPing, rtype), 1200)
		elseif settings.typemsg == 3 then
			msg(string.format("%s [ID: %d | LVL: %d | PING: %d] Возможно использует: %s рванка!", pNick, id, pLvl, pPing, rtype))
			printStringNow(string.format("~b~[ANTI-RVANKA]~w~ %s [ID: %d, LVL: %d, PING: %d] MAYBE USE: ~r~%s RVANKA", pNick, id, pLvl, pPing, rtype), 1200)
		end
	end
	if settings.log == true then
		local file = io.open(getWorkingDirectory().."\\config\\KERREL SCRIPTS\\CheatLogger.txt", "a")
		file:write(string.format("["..os.date("%d.%m.%y | %H:%M:%S").."]\t%s [ID: %d | LVL: %d | PING: %d]\t%s\n", pNick, id, pLvl, pPing, rtype)) file:close()
	end
	lua_thread.create(function()
		if settings.autorep == true then
			SendReport = true
			if settings.typemsg == 1 then
				msg("Нажмите - {559CFF}F2{FFFFFF}, чтобы отправить репорт!")
			elseif settings.typemsg == 2 then
				printString("~b~[ANTI-RVANKA]~w~ PRESS ~b~F2~w~, TO SEND REPORT!", 1000)
			elseif settings.typemsg == 3 then
				msg("Нажмите - {559CFF}F2{FFFFFF}, чтобы отправить репорт!")
				printString("~b~[ANTI-RVANKA]~w~ PRESS ~b~F2~w~, TO SEND REPORT!", 1000)
			end
			while true do wait(0)
				if isKeyJustPressed(0x71) and SendReport and not sampIsCursorActive() then
					local message = id.." РВАНКА!!! ПОМОГИИТЕЕЕЕ"
					sampSendChat("/report") wait(200)
					sampSetCurrentDialogEditboxText(message) wait(200) sampCloseCurrentDialogWithButton(1)
				end
			end
			wait(5000) SendReport = false
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------
