script_name('TreasureMAP')
script_version('3.0')
script_author("Cosmo")

ini = require 'inicfg'
cfg = ini.load({
    main = {
    	radius = 500,
    	color_s = 1,
    	color_f = 2,
    	react = 10,
    	markers = true,
    	fullmap = true
    }
}, "TreasureMAP")

local state = false
local exact_count = 0
local coords = {}
local pool = {}
local finded = {}
local markers = {}
local reaction = {-1, 3, 5, 10, 15}
local colors = {
	[1] = {0x00FF00FF, 	'Зелёный'},
	[2] = {0xFFFF00FF, 	'Жёлтый'},
	[3] = {0xFF0000FF, 	'Красный'},
	[4] = {0x6666FFFF, 	'Синий'},
	[5] = {0xFF5000FF, 	'Рыжий'},
	[6] = {0xFFFFFFFF, 	'Белый'},
	[7] = {0xFF00FFFF, 	'Розовый'},
	[8] = {0xAAAAAAFF, 	'Серый'},
	[9] = {0x00FFFFFF, 	'Голубой'},
	[10] = {0xFF6060FF, 'Малиновый'}
}

function main()
	while not isSampAvailable() do wait(100) end

	local result = false
	result, coords, exact_count = getCoordOnMap()
	if result == false then
		thisScript():unload()
	end
	sampRegisterChatCommand('trmap', show_menu)
	addEventHandler('onScriptTerminate', function(script, quit)
		if script == thisScript() then 
			ini.save(cfg, 'TreasureMAP.ini')
			remove_markers()
			remove_all() 
		end
	end)

	while true do
		remove_markers()
		if state then
			local A = { getCharCoordinates(PLAYER_PED) }
			
			for i, B in ipairs(coords) do
				local dist = getDistanceBetweenCoords3d(A[1], A[2], A[3], B[1], B[2], B[3])

				if not cfg.main.fullmap and B[4] == 0 then
    				if pool[i] ~= nil then
    					removeBlip(pool[i])
    					pool[i] = nil
    				end
					goto skip
				end

				if dist <= 20 and cfg.main.markers then 
					markers[i] = createUser3dMarker(B[1], B[2], B[3] + 1.5, 4)
				end
				if dist <= cfg.main.radius and pool[i] == nil then
					pool[i] = addBlipForCoord(B[1], B[2], B[3])
					changeBlipColour(pool[i], finded[i] and colors[cfg.main.color_f][1] or colors[cfg.main.color_s][1])
				elseif dist <= cfg.main.react and finded[i] == nil then
					finded[i] = true
					changeBlipColour(pool[i], colors[cfg.main.color_f][1])
				elseif dist > cfg.main.radius and pool[i] ~= nil then
					removeBlip(pool[i])
					pool[i] = nil
				end
				::skip::
			end
		end

		local result, button, list, _ = sampHasDialogRespond(101)
		if result and button == 1 then
			if list == 0 then
				state = not state
				if not state then remove_all() end
				show_menu()
			elseif list == 2 then
				cfg.main.fullmap = not cfg.main.fullmap
				show_menu()
			elseif list == 3 or list == 4 then
				cur_color = (list == 3 and 1 or 2)
				change_color()
			elseif list == 5 then
				for i = 1, #reaction do
					if cfg.main.react == reaction[i] then
						cfg.main.react = reaction[i + 1] or reaction[1]
						if cfg.main.react == -1 then finded = {}; remove_all(true) end
						show_menu()
						break
					end
				end 
			elseif list == 6 then
				cfg.main.markers = not cfg.main.markers
				show_menu()
			elseif list == 1 then
				local max = 1000
				for i = 100, max, 100 do
					if cfg.main.radius == i then
						cfg.main.radius = (i == max and 100 or i + 100)
						show_menu()
						break
					end
				end 
			else
				show_menu()
			end
		elseif result and button == 0 then
			ini.save(cfg, 'TreasureMAP.ini')
		end

		local result, button, _, input = sampHasDialogRespond(102)
		if result then
			input = tonumber(input)
			if input ~= nil and button == 1 then
				if input < 1 or input > #colors then
					change_color()
				else
					cfg.main[cur_color == 1 and 'color_s' or 'color_f'] = input
					remove_all(true)
					show_menu()
				end
			else
				show_menu()
			end
		end

		wait(0)
	end
end

function show_menu()
	sampShowDialog(101, '{FF6060}TreasureMAP {FFFFFF}| ' .. #coords .. plural(#coords, {' точка', ' точки', ' точек'}), 
string.format([[
Карта %s
Радиус: {FF6060}%s{FFFFFF} м.
Отображать: %s
Цвет обычных: %s
Цвет проверенных: %s
Радиус проверки: {FF6060}%s{FFFFFF}
3D маркеры: %s
 
Автор: {FF6060}Cosmo
]], 
	state and '{FF6060}работает' or '{777777}не работает', 
	cfg.main.radius,
	cfg.main.fullmap and ('{FF6060}Все (%d)'):format(#coords) or ('{FF6060}Только точные (%d)'):format(exact_count),
	('{%06X}%s'):format(rgba_to_rgb(colors[cfg.main.color_s][1]), colors[cfg.main.color_s][2]),
	('{%06X}%s'):format(rgba_to_rgb(colors[cfg.main.color_f][1]), colors[cfg.main.color_f][2]),
	cfg.main.react == -1 and 'Отключен' or cfg.main.react .. ' м.',
	cfg.main.markers and '{FF6060}Включены' or '{777777}Отключены'
	), 
'Выбрать', 'Закрыть', 2)
end

function change_color()
	local get_colors = function()
		local result = ''
		for i = 1, #colors do
			result = ('%s{FFFFFF}%s = {%06X}%s'):format(result .. (i % 2 == 0 and '\t\t' or '\n'), i, rgba_to_rgb(colors[i][1]), colors[i][2])
		end
		return result
	end
	sampShowDialog(102, '{FF6060}TreasureMAP {FFFFFF}| Выбор цвета', 
		string.format('%s\n\n{AAAAAA}Введите номер цвета:', get_colors()),
		'Выбрать', 'Назад', 1
	)
end

function remove_all(bool_update)
	for i = 1, #coords do
		if pool[i] ~= nil then
			if bool_update then
				changeBlipColour(pool[i], finded[i] and colors[cfg.main.color_f][1] or colors[cfg.main.color_s][1])
			else
				removeBlip(pool[i])
				pool[i] = nil
			end
		end
	end
end

function remove_markers()
	for i, marker in pairs(markers) do
    	removeUser3dMarker(marker)
    	markers[i] = nil
	end
end

function rgba_to_rgb(rgba)
	local r = bit.band(bit.rshift(rgba, 24), 0xFF)
	local g = bit.band(bit.rshift(rgba, 16), 0xFF)
	local b = bit.band(bit.rshift(rgba, 8), 0xFF)
	return bit.bor(bit.bor(b, bit.lshift(g, 8)), bit.lshift(r, 16))
end

function plural(n, forms)
	n = math.abs(n) % 100
	if n % 10 == 1 and n ~= 11 then
		return forms[1]
	elseif 2 <= n % 10 and n % 10 <= 4 and (n < 10 or n >= 20) then
		return forms[2]
	end
	return forms[3]
end

function getCoordOnMap() 
	local lib, requests = pcall(require, 'requests')
	if lib then
		local response = requests.get(
			'https://arzmap.fun/developer.php',
			{
				params = {['coord'] = 'true'},
				headers = {
					['user-agent'] = 'Mozilla/5.0'
				},
				timeout = 30
			}
		)
		local code = response.status_code
		if code == 200 then
			local result = decodeJson(response.text)
			if type(result) == 'table' then
				local exact = 0
				for i, v in ipairs(result) do
					if v[4] == 1 then exact = exact + 1 end
				end
				sampAddChatMessage(string.format(' >>{FFFFFF} TreasureMAP by Cosmo {FF7070}|{FFFFFF} Команда: {FF7070}/trmap | {FFFFFF}Точек: {FF7070}%d (%d не точных)', #result, #result - exact), 0xFF7070)
				return true, result, exact
			else
				sampAddChatMessage(' >> TreasureMAP: Не удалось конвертировать координаты! Попробуйте чуть позже!', 0xFF2020)
				return false
			end
		else
			sampAddChatMessage(' >> TreasureMAP: Не удалось загрузить координаты кладов! [Code ' .. code .. ']', 0xFF2020)
			return false
		end
	else
		sampAddChatMessage(' >> TreasureMAP: Отсутствует библиотека "requests"! Запуск невозможен!', 0xFF2020)
		sampAddChatMessage(" >> Скачать: {EEEEEE}https://www.blast.hk/attachments/11724/ {FF2020}(В папку moonloader/lib)", 0xFF2020)
		return false
	end
end