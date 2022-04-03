--[[
           _                       
          | |                      
       ___| |__   __ _ _ __   ___  
      / __| '_ \ / _` | '_ \ / _ \ 
     | (__| | | | (_| | |_) | (_) |
      \___|_| |_|\__,_| .__/ \___/ 
                      | |          
                      |_|          
    https://www.blast.hk/members/112329/

]]

local imgui = require('imgui')
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8
local sampev = require 'lib.samp.events'

local window = imgui.ImBool(false)

local tag = '{698cc7}[VisualCarChanger]: {ffffff}'
local vehs = {
    {'[ARZ] picador', 600},
    {'[ARZ] swatvan', 601},
    {'[ARZ] alpha', 602},
    {'[ARZ] phoenix', 603},
    {'[ARZ] glenshit', 604},
    {'[ARZ] sadlshit', 605},
    {'[ARZ] bagboxa', 606},
    {'[ARZ] bagboxb', 607},
    {'[ARZ] tugstair', 608},
    {'[ARZ] boxburg', 609},
    {'[ARZ] farmtr1', 610},
    {'[ARZ] utiltr1', 611},
    {'[ARZ] gtsamg', 612},
    {'[ARZ] g63amg', 613},
    {'[ARZ] rs6', 614},
    {'[ARZ] bmwxfive', 662},
    {'[ARZ] chevcor', 663},
    {'[ARZ] checruz', 665},
    {'[ARZ] lexlx', 666},
    {'[ARZ] porche911', 667},
    {'[ARZ] pcayenne', 668},
    {'[ARZ] bentley', 699},
    {'[ARZ] bmwm8', 793},
    {'[ARZ] e63', 794},
    {'[ARZ] merss63', 909},
    {'[ARZ] tuareg', 965},
    {'[ARZ] urus', 1194},
    {'[ARZ] aqeight', 1195},
    {'[ARZ] dodgcha', 1196},
    {'[ARZ] acurnsx', 1197},
    {'[ARZ] volvov', 1198},
    {'[ARZ] rangrove', 1199},
    {'[ARZ] civtr', 1200},
    {'[ARZ] lexis', 1201},
    {'[ARZ] mustang', 1202},
    {'[ARZ] volvoxc', 1203},
    {'[ARZ] jagfp', 1204},
    {'[ARZ] optima', 1205},
    {'[ARZ] bmwzf', 3155},
    {'[ARZ] kaban', 3156},
    {'[ARZ] bmwxf', 3157},
    {'[ARZ] ngtr34', 3158},
    {'[ARZ] diavel', 3194},
    {'[ARZ] ducati', 3195},
    {'[ARZ] ducnaked', 3196},
    {'[ARZ] zx10rr', 3197},
    {'[ARZ] western', 3198},
    {'[ARZ] rr', 3199},
    {'[ARZ] beetle', 3200},
    {'[ARZ] bugdivo', 3201},
    {'[ARZ] chiron', 3202},
    {'[ARZ] fiat500', 3203},
    {'[ARZ] gls2020', 3204},
    {'[ARZ] huntold', 3205},
    {'[ARZ] lambsvj', 3206},
    {'[ARZ] landsva', 3207},
    {'[ARZ] bmw530i', 3208},
    {'[ARZ] mbw221', 3209},
    {'[ARZ] modelx', 3210},
    {'[ARZ] nisleaf', 3211},
    {'[ARZ] nssilvia', 3212},
    {'[ARZ] sbforest', 3213},
    {'[ARZ] sblegasy', 3215},
    {'[ARZ] sonata', 3216},
    {'[ARZ] bmwe38', 3217},
    {'[ARZ] mbe55', 3218},
    {'[ARZ] mbe500', 3219},
    {'[ARZ] jstorm', 3220},
    {'[ARZ] lighmcq', 3222},
    {'[ARZ] mater', 3223},
    {'[ARZ] buckingham', 3224},
    {'[ARZ] infinity', 3232},
    {'[ARZ] lexrx', 3233},
    {'[ARZ] sportage', 3234},
    {'[ARZ] vwgolf', 3235},
    {'[ARZ] audir8', 3236},
    {'[ARZ] camry', 3237},
    {'[ARZ] cumry', 3238},
    {'[ARZ] m5e60', 3239},
    {'[ARZ] m5f90', 3240},
    {'[ARZ] maybach', 3245},
    {'[ARZ] mbamggt', 3247},
    {'[ARZ] panamera', 3248},
    {'[ARZ] passat', 3251},
    {'[ARZ] corvett1980', 3254},
    {'[ARZ] dodgesrt', 3266},
    {'[ARZ] gt500', 3348},
    {'[ARZ] amdb5', 3974},
    {'[ARZ] m3gtr', 4542},
    {'[ARZ] camaros', 4543},
    {'[ARZ] mrx7', 4544},
    {'[ARZ] mrx8', 4545},
    {'[ARZ] eclipse', 4546},
    {'[ARZ] mustold', 4547},
    {'[ARZ] n350z', 4548},
    {'[ARZ] 760li', 4774},
    {'[ARZ] one77', 4775},
    {'[ARZ] bacalars', 4776},
    {'[ARZ] bentayga', 4777},
    {'[ARZ] m4comp', 4778},
    {'[ARZ] bmwi8', 4779},
    {'[ARZ] gg90', 4780},
    {'[ARZ] intergenh', 4781},
    {'[ARZ] m3g20', 4782},
    {'[ARZ] s500w223', 4783},
    {'[ARZ] rptr', 4784},
    {'[ARZ] frj50', 4785},
    {'[ARZ] slr', 4786},
    {'[ARZ] subbrzz', 4787},
    {'[ARZ] swcross', 4788},
    {'[ARZ] taycan', 4789},
    {'[ARZ] twfer', 4790},
    {'[ARZ] uazpatriot', 4791},
    {'[ARZ] volga', 4792},
    {'[ARZ] xclass', 4793},
    {'[ARZ] xfrr2012', 4794},
    {'[ARZ] rcshutle', 4795},
    {'[ARZ] doddcar', 4796},
    {'[ARZ] crtsrt', 4797},
    {'[ARZ] fordexp', 4798},
    {'[ARZ] frd150', 4799},
    {'[ARZ] dltplan', 4800},
    {'[ARZ] seashark', 4801},
    {'[ARZ] copavent', 4802},
    {'[ARZ] ferff', 4803},
    {'[ARZ] audia6', 6604},
    {'[ARZ] audiq7', 6605},
    {'[ARZ] bmwm6', 6606},
    {'[ARZ] bnwm6', 6607},
    {'[ARZ] cla46', 6608},
    {'[ARZ] cls', 6609},
    {'[ARZ] haval', 6610},
    {'[ARZ] lc200', 6611},
    {'[ARZ] lincol', 6612},
    {'[ARZ] macan', 6613},
    {'[ARZ] matiz', 6614},
    {'[ARZ] mb6x6', 6615},
    {'[ARZ] mbe63', 6616},
    {'[ARZ] monster1', 6617},
    {'[ARZ] monster2', 6618},
    {'[ARZ] monster3', 6619},
    {'[ARZ] monster4', 6620},
    {'[ARZ] prado', 6621},
    {'[ARZ] rav4', 6622},
    {'[ARZ] supa90', 6623},
    {'[ARZ] uazold', 6624},
    {'[ARZ] xc90', 6625},
    {'ALPHA', 602},{'HUSTLER', 545},{'BLISTAC', 496},{'MAJESTC', 517},{'BRAVURA', 401},{'MANANA', 410},{'BUCCANE', 518},{'PICADOR', 600},{'CADRONA', 527},{'PREVION', 436},{'CLUB', 589},{'STAFFRD', 580},{'ESPERAN', 419},{'STALION', 439},{'FELTZER', 533},{'TAMPA', 549},{'FORTUNE', 526},{'VIRGO', 491},{'HERMES', 474},{'ADMIRAL', 445},{'OCEANIC', 467},{'GLENSHI', 604},{'PREMIER', 426},{'ELEGANT', 507},{'PRIMO', 547},{'EMPEROR', 585},{'SENTINL', 405},{'EUROS', 587},{'STRETCH', 409},{'GLENDAL', 466},{'SUNRISE', 550},{'GREENWO', 492},{'TAHOMA', 566},{'INTRUDR', 546},{'VINCENT', 540},{'MERIT', 551},{'WASHING', 421},{'NEBULA', 516},{'WILLARD', 529},{'ANDROM', 592},{'NEVADA', 553},{'AT400', 577},{'SANMAV', 488},{'BEAGLE', 511},{'POLMAV', 497},{'CARGOBB', 548},{'RAINDNC', 563},{'CROPDST', 512},{'RUSTLER', 476},{'DODO', 593},{'SEASPAR', 447},{'HUNTER', 425},{'SHAMAL', 519},{'HYDRA', 520},{'SKIMMER', 460},{'LEVIATH', 417},{'SPARROW', 469},{'MAVERIC', 487},{'STUNT', 513},{'BF400', 581},{'MTBIKE', 510},{'BIKE', 509},{'NRG500', 522},{'BMX', 481},{'PCJ600', 461},{'FAGGIO', 462},{'PIZZABO', 448},{'FCR900', 521},{'SANCHEZ', 468},{'FREEWAY', 463},{'WAYFARE', 586},{'COASTG', 472},{'DINGHY', 473},{'JETMAX', 493},{'LAUNCH', 595},{'MARQUIS', 484},{'PREDATR', 430},{'REEFER', 453},{'SPEEDER', 452},{'SQUALO', 446},{'TROPIC', 454},{'BAGGAGE', 485},{'UTILITY', 552},{'BUS', 431},{'CABBIE', 438},{'COACH', 437},{'SWEEPER', 574},{'TAXI', 420},{'TOWTRUK', 525},{'TRASHM', 408},{'AMBULAN', 416},{'POLICAR', 596},{'BARRCKS', 433},{'POLICAR', 597},{'ENFORCR', 427},{'RANGER', 599},{'FBIRANC', 490},{'RHINO', 432},{'FBITRUK', 528},{'SWATVAN', 601},{'FIRETRK', 407},{'SECURI', 428},{'FIRELA', 544},{'HPV1000', 523},{'PATRIOT', 470},{'POLICAR', 598},{'BENSON', 499},{'HOTDOG', 588},{'BOXBURG', 609},{'LINERUN', 403},{'BOXVILL', 498},{'PETROL', 514},{'CEMENT', 524},{'WHOOPEE', 423},{'COMBINE', 532},{'MULE', 414},{'DFT30', 578},{'PACKER', 443},{'DOZER', 486},{'RDTRAIN', 515},{'DUMPER', 406},{'TRACTOR', 531},{'DUNE', 573},{'YANKEE', 456},{'FLATBED', 455},{'TOPFUN', 459},{'SADLER', 543},{'BOBCAT', 422},{'TUG', 583},{'BURRITO', 482},{'WALTON', 478},{'SADLSHI', 605},{'YOSEMIT', 554},{'FORKLFT', 530},{'MOONBM', 418},{'MOWER', 572},{'NEWSVAN', 582},{'PONY', 413},{'RUMPO', 440},{'BLADE', 536},{'BROADWY', 575},{'REMING', 534},{'SAVANNA', 567},{'SLAMVAN', 535},{'TORNADO', 576},{'VOODOO', 412},{'BUFFALO', 402},{'CLOVER', 542},{'PHOENIX', 603},{'SABRE', 475},{'TRAM', 449},{'FREIGHT', 537},{'STREAK', 538},{'STREAKC', 570},{'RCBANDT', 441},{'RCBARON', 464},{'RCGOBLI', 501},{'RCRAIDE', 465},{'RCTIGER', 564},{'BANDITO', 568},{'MONSTB', 557},{'BFINJC', 424},{'QUAD', 471},{'BLOODRA', 504},{'SANDKIN', 495},{'CADDY', 457},{'VORTEX', 539},{'CAMPER', 483},{'JOURNEY', 508},{'KART', 571},{'MESAA', 500},{'MONSTER', 444},{'MONSTA', 556},{'BANSHEE', 429},{'INFERNU', 411},{'BULLET', 541},{'JESTER', 559},{'CHEETAH', 415},{'STRATUM', 561},{'COMET', 480},{'SULTAN', 560},{'ELEGY', 562},{'SUPERGT', 506},{'FLASH', 565},{'TURISMO', 451},{'HOTKNIF', 434},{'URANUS', 558},{'HOTRING', 494},{'WINDSOR', 555},{'HOTRINA', 502},{'ZR350', 477},{'HOTRINB', 503},{'HUNTLEY', 579},{'LANDSTK', 400},{'PEREN', 404},{'RANCHER', 489},{'RANCHER', 505},{'REGINA', 479},{'ROMERO', 442},{'SOLAIR', 458},{'BAGBOXA', 606},{'BAGBOXB', 607},{'FARMTR1', 610},{'FRBOX', 590},{'FRFLAT', 569},{'UTILTR1', 611},{'PETROTR', 584},{'TUGSTAI', 608},{'ARTICT1', 435},{'ARTICT2', 450},{'ARTICT3', 591},{'RCCAM', 594},
}

--==[JSON]==--
local list_file = getWorkingDirectory()..'\\config\\VisualCarChangerByChapo__newcars.json'
function jsonSave(t)
    local jsonFilePath = list_file
    file = io.open(jsonFilePath, "w")
    file:write(encodeJson(t))
    file:flush()
    file:close()
end

function jsonRead()
    local jsonFilePath = list_file
    local file = io.open(jsonFilePath, "r+")
    local jsonInString = file:read("*a")
    file:close()
    local jsonTable = decodeJson(jsonInString)
    return jsonTable
end

local cars = {}
local newcars = {}


local skipCars = true

--==[TEXTDRAW CAR PREVIEW]==--
local td_Id = 1931
local winPos = {x = 1000, y = 1000}
local winSize = {x = 500, y = 200}

--==[ARIZONA]==--
function arizonaGetServerNumber()
    send = 999
    local ip, port = sampGetCurrentServerAddress()
    local servers = {
        {'Phoenix', 	'185.169.134.3'},
	    {'Tucson', 		'185.169.134.4'},
	    {'Scottdale',	'185.169.134.43'},
	    {'Chandler', 	'185.169.134.44'}, 
	    {'Brainburg', 	'185.169.134.45'},
	    {'Saint Rose', 	'185.169.134.5'},
	    {'Mesa', 		'185.169.134.59'},
	    {'Red Rock', 	'185.169.134.61'},
	    {'Yuma', 		'185.169.134.107'},
	    {'Surprise', 	'185.169.134.109'},
	    {'Prescott', 	'185.169.134.166'},
	    {'Glendale', 	'185.169.134.171'},
	    {'Kingman', 	'185.169.134.172'},
	    {'Winslow', 	'185.169.134.173'},
	    {'Payson', 		'185.169.134.174'},
	    {'Gilbert',		'80.66.82.191'},
        {'Show Low',    '80.66.82.190'},
        {'Casa Grande', '80.66.82.188'},
    }
    for i = 1, #servers do
        if servers[i][2]:find(ip) then
            send = i
            break
        end
    end
    return send
end

function isArizonaLauncher()
    if doesFileExist(getGameDirectory()..'\\_CoreGame.asi') or doesFileExist(getGameDirectory()..'\\_ci.asi') then
        return true
    else
        return false
    end
end 

function isArizonaCar(modelId)
    local arzcars = {612,613,614,662,663,665,666,667,668,699,793,794,909,965,1194,1195,1196,1197,1198,1199,1200,1201,1202,1203,1204,1205,3155,3156,3157,3158,3194,3195,3196,3197,3198,3199,3200,3201,3202,3203,3204,3205,3206,3207,3208,3209,3210,3211,3212,3213,3215,3216,3217,3218,3219,3220,3222,3223,3224,3232,3233,3234,3235,3236,3237,3238,3239,3240,3245,3247,3248,3251,3254,3266,3348,3974,4542,4543,4544,4545,4546,4547,4548,4774,4775,4776,4777,4778,4779,4780,4781,4782,4783,4784,4785,4786,4787,4788,4789,4790,4791,4792,4793,4794,4795,4796,4797,4798,4799,4800,4801,4802,4803}
    for i = 1, #arzcars do
        if tonumber(modelId) == arzcars[i] then
            return true
        end
    end
    return false
end

function main()
    while not isSampAvailable() do wait(200) end
    sampAddChatMessage(tag..'загружен! Автор: {698cc7}chapo{ffffff}. Активация: {698cc7}/vcar', -1)
    while not isCharOnFoot(PLAYER_PED) do wait(0) end
    if arizonaGetServerNumber() == 999 then 
        sampAddChatMessage(tag..'скрипт предназначен только для Arizona RP! Если это ошибка - сообщите автору скрипта: {698cc7}vk.com/amid24', -1)
        thisScript():unload()
    end
    sampTextdrawCreate(td_Id, _, 1000, 1000)
    sampTextdrawSetStyle(td_Id, 5)
    sampTextdrawSetBoxColorAndSize(td_Id, 0, 0xFFff004d, 100, 100)
    sampTextdrawSetModelRotationZoomVehColor(td_Id, 411, 340, 0, 340, 1, 1, 1)
    sampTextdrawSetShadow(td_Id, _, 0x00)

    if not doesFileExist(list_file) then 
        local t = {
            --{'infernus', 411},
        }
        file = io.open(list_file, "w")
        file:write(encodeJson(t))
        file:flush()
        file:close()
    end
    newcars = jsonRead()
    sampRegisterChatCommand('vcar', function()
        window.v = not window.v
    end)
    --wait(1000)
    sampSendChat('/cars')
    imgui.Process = false
    window.v = false  --show window

    while true do
        wait(0)
        imgui.Process = window.v
        if window.v then
            local tx, ty = convertWindowScreenCoordsToGameScreenCoords(winPos.x + winSize.x - 50, winPos.y - 20)
            sampTextdrawSetPos(td_Id, tx, ty)
        else
            sampTextdrawSetPos(td_Id, 1000, 1000)
        end
    end
end

local selected = 0
local new_selected = 0
local search = imgui.ImBuffer(256)

function imgui.OnDrawFrame()
    if window.v then
        local resX, resY = getScreenResolution()
        local sizeX, sizeY = 500, 200
        imgui.SetNextWindowPos(imgui.ImVec2(resX / 2 - sizeX / 2, resY / 2 - sizeY / 2), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowSize(imgui.ImVec2(sizeX, sizeY), imgui.Cond.FirstUseEver)
        imgui.Begin('Visual Car Changer by chapo', window)

        local winPoss = imgui.GetWindowPos()
        winPos.x = winPoss.x
        winPos.y = winPoss.y 

        local winSizee = imgui.GetWindowSize()
        winSize.x, winSize.y = winSizee.x, winSizee.y
        imgui.SetCursorPosY(25)
        imgui.BeginChild('cars', imgui.ImVec2(300, winSize.y - 55), true)
            for i = 1, #cars do
                if cars[i][1] then
                    if newcars[i] ~= nil then
                        if imgui.Selectable(u8(cars[i][1]..' >> '..newcars[i][1]..'##'..tostring(i)), selected == i, imgui.ImVec2(100, 100)) then selected = i end
                    else
                        --imgui.Text('NIL')
                        if imgui.Selectable(u8(cars[i][1]..' >> нет замены##'..tostring(i)), selected == i, imgui.ImVec2(100, 100)) then selected = i end
                    end
                end
            end
            
        imgui.EndChild()
        if imgui.Button(u8'Сохранить', imgui.ImVec2(300, 20)) then jsonSave(newcars) end
        imgui.SameLine()
        imgui.SetCursorPosY(25)
        imgui.BeginChild('changeto', imgui.ImVec2(winSize.x - 325, winSize.y - 30), true)
        if selected == 0 then
            imgui.Text(u8'Выбери машину!\nЕсли список пуст\nпропишите /cars')
        else
            imgui.Text(u8'Поиск: ')
            imgui.SameLine()
            imgui.InputText('##search', search)
            imgui.Separator()
            if search.v == '' then
                for i = 1, #vehs do
                    if imgui.Selectable(u8(vehs[i][1]), new_selected == i) then 
                        if newcars[selected] == nil then newcars[selected] = {} end
                        new_selected = i 
                        newcars[selected][1], newcars[selected][2] = vehs[new_selected][1], vehs[new_selected][2]
                        --sampAddChatMessage('newcars[selected][1] = '..newcars[selected][1], -1)
                        --sampAddChatMessage('newcars[selected][2] = '..newcars[selected][2], -1)
                        --sampAddChatMessage('vehs[selected][1] = '..vehs[new_selected][1], -1)
                        --sampAddChatMessage('vehs[selected][2] = '..vehs[new_selected][2], -1)
                        jsonSave(newcars)
                    end
                    if new_selected > 0 and new_selected <= #vehs then
                        if imgui.IsItemHovered() then
                            model, rotX, rotY, rotZ, zoom, clr1, clr2 = sampTextdrawGetModelRotationZoomVehColor(td_Id)
                            if model ~= vehs[new_selected][2] then sampTextdrawSetModelRotationZoomVehColor(td_Id, vehs[new_selected][2], 340, 0, 340, 1, 1, 1) end
                        end
                    end
                end
            else
                for i = 1, #vehs do
                    if vehs[i][1]:lower():find(search.v:lower()) then
                        if imgui.Selectable(u8(vehs[i][1]), new_selected == i) then 
                            new_selected = i
                            newcars[selected][1], newcars[selected][2] = vehs[new_selected][1], vehs[new_selected][2]
                            jsonSave(newcars)
                        end
                    end
                    if new_selected > 0 and new_selected <= #vehs then
                        if imgui.IsItemHovered() then
                            model, rotX, rotY, rotZ, zoom, clr1, clr2 = sampTextdrawGetModelRotationZoomVehColor(td_Id)
                            if model ~= vehs[new_selected][2] then sampTextdrawSetModelRotationZoomVehColor(td_Id, vehs[new_selected][2], 340, 0, 340, 1, 1, 1) end
                        end
                    end
                end
            end
        end
        imgui.EndChild()
        imgui.End()
    end
end

--function updateVehModelPreview(modelId)
--    if not isArizonaLauncher() and isArizonaCar(vehs[modelId][2]) then 
--        sampAddChatMessage(tag..'модель машины '..vehs[modelId][2]..' недоступна! (модель доступна только с лаунчера Arizona RP)', -1)
--    else
--        
--    end
--end

function sampev.onVehicleStreamIn(vehId, data)
    for i = 1, #cars do
        if newcars[i] then
            if vehId == cars[i][2] then
                if not isArizonaLauncher() and isArizonaCar(newcars[i][2]) then 
                    sampAddChatMessage(tag..'модель машины не была заменена! (модель доступна только с лаунчера Arizona RP)', -1)
                else
                    data.type = newcars[i][2]
                    return {vehId, data}
                end
            end
        end
    end
end

function sampev.onShowDialog(id, style, title, button1, button2, text)
    if title:find('Мой транспорт') then
       -- print(text)
        cars = {}
        --sampAddChatMessage('/cars dialog shown', -1)
        local line = -1
        for v in string.gmatch(text, '[^\n]+') do
            
            if v:find('{FFD848}%[Twin Turbo%]{FFFFFF} (.+)%((%d+)%)') then
                name, id = v:match('{FFD848}%[Twin Turbo%]{FFFFFF} (.+)%((%d+)%)')
                --sampAddChatMessage('TT CAR: NAME = '..name..' id = '..id, -1)
                table.insert(cars, {name, tonumber(id)})
            elseif v:find('  (.+)%((%d+)%)') then
                name, id = v:match('  (.+)%((%d+)%)')
                --sampAddChatMessage('NOT TT CAR: NAME = '..name..' id = '..id, -1)
                table.insert(cars, {name, tonumber(id)})
            elseif v:find('{FF6347}%[Не припарковано%]{FFFFFF} (.+)%((%d+)%)') then
                name, id = v:match('{FF6347}%[Не припарковано%]{FFFFFF} (.+)%((%d+)%)')
                --sampAddChatMessage('NOT TT CAR: NAME = '..name..' id = '..id, -1)
                table.insert(cars, {name, tonumber(id)})
            end
        end
        if skipCars then
            skipCars = false
            sampCloseCurrentDialogWithButton(0)
            return false
        end
    end
end



--[[

  Maverick(959)	{cccccc}- загружается при входе
{FFD848}[Twin Turbo]{FFFFFF} Mercedes GT63s AMG(1339)	{cccccc}- загружается при входе

]]

function BH_theme()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2
  
    style.WindowPadding = ImVec2(6, 4)
    style.WindowRounding = 5.0
    style.ChildWindowRounding = 5.0
    style.FramePadding = ImVec2(5, 2)
    style.FrameRounding = 5.0
    style.ItemSpacing = ImVec2(7, 5)
    style.ItemInnerSpacing = ImVec2(1, 1)
    style.TouchExtraPadding = ImVec2(0, 0)
    style.IndentSpacing = 6.0
    style.ScrollbarSize = 12.0
    style.ScrollbarRounding = 5.0
    style.GrabMinSize = 20.0
    style.GrabRounding = 2.0
    style.WindowTitleAlign = ImVec2(0.5, 0.5)

    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.28, 0.30, 0.35, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.16, 0.18, 0.22, 1.00)
    colors[clr.ChildWindowBg]          = ImVec4(0.19, 0.22, 0.26, 1)
    colors[clr.PopupBg]                = ImVec4(0.05, 0.05, 0.10, 0.90)
    colors[clr.Border]                 = ImVec4(0.19, 0.22, 0.26, 1.00)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.FrameBg]                = ImVec4(0.16, 0.18, 0.22, 1.00)
    colors[clr.FrameBgHovered]         = ImVec4(0.22, 0.25, 0.30, 1.00)
    colors[clr.FrameBgActive]          = ImVec4(0.22, 0.25, 0.29, 1.00)
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
    colors[clr.Header]                 = ImVec4(0.41, 0.55, 0.78, 1.00)
    colors[clr.HeaderHovered]          = ImVec4(0.43, 0.57, 0.80, 1.00)
    colors[clr.HeaderActive]           = ImVec4(0.43, 0.57, 0.80, 1.00)
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
    
    
end
BH_theme()

function onScriptTerminate(s, q)
    if s == thisScript() then
        if sampTextdrawIsExists(td_Id) then
            sampTextdrawDelete(td_Id)
        end
    end
end