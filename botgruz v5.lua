local bot = false
local skins = false
local hook = require 'samp.events'

function main()
    repeat wait(0) until isSampAvailable()
    msg("Бот Грузчик загружен.")
    sampRegisterChatCommand('gbot', function(arg)
        if arg == '' or arg == nil then
            local skin = getCharModel(playerPed)
            if skin == 50 or skin == 131 then
                bot = not bot
                msg(bot and 'Бот Грузчик активирован' or 'Бот Грузчик деактивирован', -1)
            else
                msg("Вам нужно переодеться для начала работы бота(/gbot skin)")
                bot = false
            end
        elseif arg == 'skin' then
            local skin = getCharModel(playerPed)
            if skin ~= 50 and skin ~= 131 then
                if not bot then
                    freezeCharPosition(PLAYER_PED, true)
                    lua_thread.create(function()
                        skins = true
                        tpto(1980.1879, -1971.04345, 13)
                        wait(600)
                        altenter()
                        wait(900)
                        tpto(1980.0465, -1968.4412, 13)
                        wait(900)
                        altenter()
                        wait(600)
                        skins = false
                        bot = true
                    end)
                else msg("Выключите бота для того чтобы переодеться")
                end
            else
                if not bot then
                    lua_thread.create(function()
                        skins = true
                        tpto(1980.0465, -1968.4412, 13)
                        wait(900)
                        altenter()
                        skins = false
                    end)
                else msg("Выключите бота для того чтобы переодеться")
                end
            end
        else
            msg("Неправильный аргумент команды(/gbot или /gbot skin)")
        end
    end)
    while true do
        wait(0)
        if skins and not bot then
            freezeCharPosition(PLAYER_PED, true)
        elseif not skins and not bot then
            freezeCharPosition(PLAYER_PED, false)
        end
        if bot and not skins then
            freezeCharPosition(PLAYER_PED, true)
            tpto(2015.6168, -1958.5763, 12.3989)
            wait(500)
            sampSendClickTextdraw(633 or 634 or 635)
            wait(200)
            tpto(2015.6168, -1958.5763, 15.3989)
            wait(3800)
            if bot then
                tpto(2012.3759, -1989.1005, 13.5469)
                wait(500)
            end
        end
    end
end

function msg(msg)
    sampAddChatMessage('{ffffff}[{1d7530}GruzBot{ffffff}]: '..msg, -1)
end

function tpto(x, y, z)
    setCharCoordinates(PLAYER_PED, x, y, z)
end

function altenter()
    setVirtualKeyDown(164, true)
    wait(10)
    setVirtualKeyDown(164, false)
    wait(400)
    setVirtualKeyDown(13, true)
    wait(10)
    setVirtualKeyDown(13, false)
end

function hook.onServerMessage(color, text)
    if bot and text:find('Вы уронили груз!') then msg("Вы уронили груз, бот выключен") bot = false return false end
end

function hook.onSendPlayerSync(data)
    if bot or skins then
        data.moveSpeed = {0.2, 0.2, 0.2} --Поставил минусовую скорость, т.е. в землю, так менее палевно
        return data
    else return
    end
end