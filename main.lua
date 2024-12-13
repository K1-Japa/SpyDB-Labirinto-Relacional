require("conf")
local constructors = require("constructors")
local movement = require("movements")
local colision = require("colision")
local screen = require("screen")
local draw = require("draw")
local utf8 = require("utf8")
local minigame = require("minigame")
-- local lvl01 = require("lvl01")
local lvl02 = require("lvl02")

local text = ""

-- Fazer o jogador escolher o Diagrama certo (Tipo o diagrama com um relacionamento quaternário)

local minigameType = {
    DER = "Diagrama Entidade Relacionamento",
    AR = "Algebra Relacional",
    DTB = "Decodificar Tabelas"
}

function love.textinput(t)
    text = text .. t
end

function love.keypressed(key)
    if key == "backspace" then
        -- get the byte offset to the last UTF-8 character in the string.
        local byteoffset = utf8.offset(text, -1)

        if byteoffset then
            -- remove the last UTF-8 character.
            -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
            text = string.sub(text, 1, byteoffset - 1)
        end
    end
end

local WIDTH = 1366
local HEIGHT = 768

local propW = 5
local propH = 5

local tamW = WIDTH / propW
local tamH = HEIGHT / propH

local FONT = love.graphics.newFont("ChauPhilomeneOne-Regular.ttf", 30)
love.graphics.setFont(FONT)

local function loadImage (path)
	local info = love.filesystem.getInfo( path )
	if info then
		return love.graphics.newImage( path )
	end
end

local lvl01 = {
    map = {
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {0,1,1,1,1,1,1,2,2,2,2,2,2,2,2,1,0},
        {0,2,2,2,2,2,2,2,1,1,2,1,1,1,2,1,0},
        {0,1,2,1,1,2,1,2,1,1,2,1,1,1,2,1,0},
        {0,2,2,1,1,2,1,2,2,2,2,2,2,2,2,2,0},
        {0,1,2,2,2,2,1,1,1,2,1,1,2,1,1,1,0},
        {0,1,1,1,1,2,1,1,1,2,2,2,2,1,1,1,0},
        {0,1,1,1,1,2,2,2,2,2,1,1,2,1,1,1,0},
        {0,2,2,2,2,2,1,1,1,2,1,1,2,2,2,2,0},
        {0,1,2,1,2,2,2,2,2,2,2,2,2,1,1,1,0},
        {0,1,2,1,2,1,1,2,1,1,1,2,1,1,1,1,0},
        {0,1,1,1,2,1,1,2,1,1,1,2,1,1,1,1,0},
        {0,1,1,1,2,2,2,2,2,2,2,2,1,2,2,2,0},
        {0,1,1,1,2,1,1,1,2,1,1,2,1,2,1,1,0},
        {0,2,2,1,2,1,1,1,2,1,1,2,2,2,2,1,0},
        {0,1,2,2,2,1,1,2,2,1,1,2,1,2,1,1,0},
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
    },

    player = nil,

    enemys = {},

    totems = {},

    exit = {16, 13, false}

}

lvl01.player = constructors.newPlayer(2, 3, 0, 0)

table.insert(lvl01.enemys, constructors.newEnemy(10,2,0,0, "left"))
table.insert(lvl01.enemys, constructors.newEnemy(3,10,0,0, "down"))
table.insert(lvl01.enemys, constructors.newEnemy(15,9,0,0, "left"))

local auxImg = {"imgs/lvl01/lvl01R.png", "imgs/lvl01/lvl01Erro01.png", "imgs/lvl01/lvl01Erro02.png", "imgs/lvl01/lvl01Erro03.png"}

local aux = {
    typeName = minigameType.DER,
    img = {},
    diagram = 1,
    answer = 1,
    completed = false
}

local a = nil

for _, x in ipairs(auxImg) do

    a = loadImage(x)
    table.insert(aux.img, a)

end

table.insert(lvl01.totems, constructors.newTotem(2, 9, aux))

aux = {
    typeName = minigameType.DTB,
    imgs = {
        Titulo = nil,
        Codificado = {},
        Decodificado = {}
    },
    answers = {"id", "cpf_proprietario", "cpf_corretor"},
    correctAnswers = {false, false, false},
    completed = false
}

a = loadImage("imgs/lvl01/lvl01TabelaTitulo.png")
aux.imgs.Titulo = a

auxImg = {"imgs/lvl01/clvl01TabelaColuna01.png", "imgs/lvl01/clvl01TabelaColuna02.png", "imgs/lvl01/clvl01TabelaColuna03.png"}

for _, x in ipairs(auxImg) do

    a = loadImage(x)
    table.insert(aux.imgs.Codificado, a)

end

auxImg = {"imgs/lvl01/dlvl01TabelaColuna01.png", "imgs/lvl01/dlvl01TabelaColuna02.png", "imgs/lvl01/dlvl01TabelaColuna03.png"}

for _, x in ipairs(auxImg) do

    a = loadImage(x)
    table.insert(aux.imgs.Decodificado, a)

end

table.insert(lvl01.totems, constructors.newTotem(8, 16, aux))

--------------------------------------------------------------------

aux = {
    typeName = minigameType.DTB,
    imgs = {
        Titulo = nil,
        Codificado = {},
        Decodificado = {}
    },
    answers = {"cpf", "nome", "contato", "id_imovel"},
    correctAnswers = {false, false, false, false},
    completed = false
}

a = loadImage("imgs/lvl01/lvl01TabelaTitulo02.png")
aux.imgs.Titulo = a

auxImg = {"imgs/lvl01/clvl01TabelaColuna01_02.png", "imgs/lvl01/clvl01TabelaColuna02_02.png", "imgs/lvl01/clvl01TabelaColuna03_02.png", "imgs/lvl01/clvl01TabelaColuna04_02.png"}

for _, x in ipairs(auxImg) do

    a = loadImage(x)
    table.insert(aux.imgs.Codificado, a)

end

auxImg = {"imgs/lvl01/dlvl01TabelaColuna01_02.png", "imgs/lvl01/dlvl01TabelaColuna02_02.png", "imgs/lvl01/dlvl01TabelaColuna03_02.png", "imgs/lvl01/dlvl01TabelaColuna04_02.png"}

for _, x in ipairs(auxImg) do

    a = loadImage(x)
    table.insert(aux.imgs.Decodificado, a)

end

table.insert(lvl01.totems, constructors.newTotem(16, 5, aux))

aux = {
    typeName = "Exit"
}

table.insert(lvl01.totems, constructors.newTotem(16, 13, aux))

local tutorial = {
    map = {
        {0,0,0,0,0,0,0},
        {0,2,2,2,2,2,0},
        {0,1,1,1,1,2,0},
        {0,2,2,2,2,2,0},
        {0,2,1,1,1,1,0},
        {0,2,2,2,2,2,0},
        {0,0,0,0,0,0,0}
    },

    player = nil,

    enemys = {},

    totems = {},

    exit = {2, 3, false}

}

tutorial.player = constructors.newPlayer(2, 2, 0, 0)

auxImg = {"imgs/tutorial/tutorialErro01.png", "imgs/tutorial/tutorialR.png"}

aux = {
    typeName = minigameType.DER,
    img = {},
    diagram = 1,
    answer = 2,
    completed = false
}

a = nil

for _, x in ipairs(auxImg) do

    a = loadImage(x)
    table.insert(aux.img, a)

end

table.insert(tutorial.totems, constructors.newTotem(6, 2, aux))

aux = {
    typeName = minigameType.DTB,
    imgs = {
        Titulo = nil,
        Codificado = {},
        Decodificado = {}
    },
    answers = {"cpf", "nome", "salario", "id_departamento"},
    correctAnswers = {false, false, false, false},
    completed = false
}

a = loadImage("imgs/tutorial/tutorialTabelaTitulo.png")
aux.imgs.Titulo = a

auxImg = {"imgs/tutorial/ctutorialTabelaColuna01.png", "imgs/tutorial/ctutorialTabelaColuna02.png", "imgs/tutorial/ctutorialTabelaColuna03.png", "imgs/tutorial/ctutorialTabelaColuna04.png"}

for _, x in ipairs(auxImg) do

    a = loadImage(x)
    table.insert(aux.imgs.Codificado, a)

end

auxImg = {"imgs/tutorial/dtutorialTabelaColuna01.png", "imgs/tutorial/dtutorialTabelaColuna02.png", "imgs/tutorial/dtutorialTabelaColuna03.png", "imgs/tutorial/dtutorialTabelaColuna04.png"}

for _, x in ipairs(auxImg) do

    a = loadImage(x)
    table.insert(aux.imgs.Decodificado, a)

end

table.insert(tutorial.totems, constructors.newTotem(2, 4, aux))

aux = {
    typeName = "Exit"
}

table.insert(tutorial.totems, constructors.newTotem(6, 6, aux))


local map = tutorial.map
local player = tutorial.player
local enemys = tutorial.enemys
local totems = tutorial.totems

function love.load()
    love.window.setMode(WIDTH, HEIGHT)

    -- enable key repeat so backspace can be held down to trigger love.keypressed multiple times.
    love.keyboard.setKeyRepeat(true)

end

local playerImg = loadImage("imgs/player.png")
local enemyImg = loadImage("imgs/enemy.png")
local setas = {
    setaA = nil,
    setaD = nil
}

setas.setaA = loadImage("imgs/setaA.png")
setas.setaD = loadImage("imgs/setaD.png")

local menuGraphics = {
    capa = loadImage("imgs/capa.png"),
    start = {
        img = loadImage("imgs/start.png"),
        x = nil,
        y = nil,
        width = nil,
        height = nil
    },
    quit = {
        img = loadImage("imgs/quit.png"),
        x = nil,
        y = nil,
        width = nil,
        height = nil
    }
}

menuGraphics.start.x = (WIDTH/2)-(menuGraphics.start.img:getPixelWidth()/2)
menuGraphics.start.y = (HEIGHT/2)-(menuGraphics.start.img:getPixelHeight()/2)
menuGraphics.start.width = menuGraphics.start.img:getPixelWidth()
menuGraphics.start.height = menuGraphics.start.img:getPixelHeight()

menuGraphics.quit.x = (WIDTH/2)-(menuGraphics.quit.img:getPixelWidth()/2)
menuGraphics.quit.y = (HEIGHT/2)+(2*(menuGraphics.quit.img:getPixelHeight()/2))
menuGraphics.quit.width = menuGraphics.quit.img:getPixelWidth()
menuGraphics.quit.height = menuGraphics.quit.img:getPixelHeight()

local GameOver = {
    capa = loadImage("imgs/GameOver.png"),
    continuar = {
        img = loadImage("imgs/continuar.png"),
        x = nil,
        y = nil,
        width = nil,
        height = nil
    }
}

GameOver.continuar.x = (WIDTH/2)-(GameOver.continuar.img:getPixelWidth()/2)
GameOver.continuar.y = (HEIGHT/2)-(GameOver.continuar.img:getPixelHeight()/4)
GameOver.continuar.width = GameOver.continuar.img:getPixelWidth()
GameOver.continuar.height = GameOver.continuar.img:getPixelHeight()

local End = {
    capa = loadImage("imgs/end.png"),
    quit = {
        img = loadImage("imgs/endQuit.png"),
        x = nil,
        y = nil,
        width = nil,
        height = nil
    }
}

End.quit.x = (WIDTH/2)-(End.quit.img:getPixelWidth()/2)
End.quit.y = (HEIGHT/2)-(End.quit.img:getPixelHeight()/4)
End.quit.width = End.quit.img:getPixelWidth()
End.quit.height = End.quit.img:getPixelHeight()

local tela = screen.set(player, propW, propH)

local isDown = false
local minigameIsDown = false

local contador = 0
local tempoAcumulado = 0

local state = "Menu"
local substate = "Play"
local currentTotem = nil
local lifes = nil
local lvl = "tutorial"
local lifesTxt = ""
local seeDER = {false, tutorial.totems[1].tipo.img[tutorial.totems[1].tipo.answer]}
local instrucao = loadImage("imgs/tutorial/I1.png")
local playerStart = nil
local enemysStart = nil
local inst = loadImage("imgs/inst.png")
local flag = false

local function deepCopy(original)
    local copy
    if type(original) == 'table' then
        copy = {}
        for key, value in next, original, nil do
            copy[deepCopy(key)] = deepCopy(value)
        end
        setmetatable(copy, deepCopy(getmetatable(original)))
    else -- número, string, boolean, etc.
        copy = original
    end
    return copy
end

local function tutorialSet(map, tutorial, player, playerStart, enemys, enemysStart, totems, seeDER, substate, lvl)
    map = tutorial.map
    player = tutorial.player
    playerStart = {
        tutorial.player.position[1],
        tutorial.player.position[2]
    }
    enemys = tutorial.enemys
    enemysStart = {}

    for _, value in ipairs(tutorial.enemys) do
        table.insert(enemysStart, {
            position = {value.position[1], value.position[2]},
            look = value.look,
            lastPosition = {value.position[1], value.position[2], value.look}
        })
    end
    totems = tutorial.totems
    seeDER = {false, tutorial.totems[1].tipo.img[tutorial.totems[1].tipo.answer]}
    substate = "instrucao"
    lvl = "tutorialRun"

    return map, tutorial, player, playerStart, enemys, enemysStart, totems, seeDER, substate, lvl

end

local function lvl01Set(pmap, plvl01, pplayer, pplayerStart, penemys, penemysStart, ptotems, pseeDER, psubstate, plvl, pinstrucao)
    pmap = deepCopy(plvl01.map)
    pplayer.position = deepCopy(plvl01.player.position)
    pplayer.flags = deepCopy(plvl01.player.flags)
    pplayer = deepCopy(plvl01.player)
    pplayerStart = deepCopy(plvl01.player.position)
    penemys = deepCopy(plvl01.enemys)
    penemysStart = deepCopy(plvl01.enemys)
    ptotems = deepCopy(plvl01.totems)
    pseeDER = {false, deepCopy(plvl01.totems[1].tipo.img[plvl01.totems[1].tipo.answer])}
    psubstate = "instrucao"
    plvl = "lvl01Run"
    pinstrucao = loadImage("imgs/lvl01/IG.png")

    return pmap, plvl01, pplayer, pplayerStart, penemys, penemysStart, ptotems, pseeDER, psubstate, plvl, pinstrucao, flag
end

function love.update(dt)

    if state == "Menu" then

        function love.mousepressed(mx, my, mbutton)
            if mbutton == 1 and mx >= menuGraphics.start.x and mx < menuGraphics.start.x + menuGraphics.start.width and my >= menuGraphics.start.y and my < menuGraphics.start.y + menuGraphics.start.height then
                state = "inGame"
                lifes = 3
            end
    
            if mbutton == 1 and mx >= menuGraphics.quit.x and mx < menuGraphics.quit.x + menuGraphics.quit.width and my >= menuGraphics.quit.y and my < menuGraphics.quit.y + menuGraphics.quit.height then
                love.event.quit()
            end
        end

    elseif state == "End" then
        function love.mousepressed(mx, my, mbutton)
            if mbutton == 1 and mx >= End.quit.x and mx < End.quit.x + End.quit.width and my >= End.quit.y and my < End.quit.y + End.quit.height then
                love.event.quit()
            end
        end
    elseif state == "GameOver" then
        function love.mousepressed(mx, my, mbutton)
            if mbutton == 1 and mx >= GameOver.continuar.x and mx < GameOver.continuar.x + GameOver.continuar.width and my >= GameOver.continuar.y and my < GameOver.continuar.y + GameOver.continuar.height then
                state = "inGame"
                lvl = "lvl01"
            end
        end

    elseif state == "inGame" then

        tempoAcumulado = tempoAcumulado + dt

        if lvl == "tutorial" then
            map, tutorial, player, playerStart, enemys, enemysStart, totems, seeDER, substate, lvl = tutorialSet(map, tutorial, player, playerStart, enemys, enemysStart, totems, seeDER, substate, lvl)
        elseif lvl == "lvl01" then
            map, lvl01, player, playerStart, enemys, enemysStart, totems, seeDER, substate, lvl, instrucao, flag = lvl01Set(map, lvl01, player, playerStart, enemys, enemysStart, totems, seeDER, substate, lvl, instrucao)
        end

        if lvl == "tutorialRun" then
            if player.flags == 0 and substate == minigameType.DER then
                instrucao = loadImage("imgs/tutorial/I1_1.png")
            elseif player.flags == 1 then
                if substate == minigameType.DTB then
                    instrucao = loadImage("imgs/tutorial/I2_1.png")
                else
                    instrucao = loadImage("imgs/tutorial/I2.png")
                end
            elseif player.flags >= 1 then
                instrucao = loadImage("imgs/tutorial/I3.png")
            end
        else
            if flag == true then
                instrucao = loadImage("imgs/lvl01/lvl01Instrucao.png")
            end
        end
    
        if lifes ~= nil then
            lifesTxt = "Vidas restantes: " .. lifes
        end

        isDown, substate, currentTotem, text, lvl, flag, state = movement.keyboardInput(player, totems, isDown, substate, currentTotem, text, lvl, flag, state)

        lifes, state, player, enemys, lvl = colision.enemyLook(player, enemys, lifes, state, playerStart, enemysStart, lvl)

        contador, tempoAcumulado = movement.enemyMovement(contador, tempoAcumulado, enemys, constructors, map)

        colision.playerColision(player, enemys, map)

        movement.playerNewPosition(player)

        if substate == minigameType.DER then
            player, minigameIsDown, substate, lifes, lvl = minigame.DER(player, minigameIsDown, currentTotem, substate, lifes, lvl)
        elseif substate == minigameType.DTB then
            player, minigameIsDown, substate, lifes, text, seeDER, lvl = minigame.DTB(player, minigameIsDown, currentTotem, substate, lifes, text, seeDER, lvl)
        end

        local rangeX = {
            start = tela.x - math.floor(propW/2),
            fim = tela.x + math.floor(propW/2)
        }

        local rangeY = {
            start = tela.y - math.floor(propH/2),
            fim = tela.y + math.floor(propH/2)
        }

        if player.position[1] >= rangeX.fim then
            tela.x = tela.x + 1
        elseif player.position[1] <= rangeX.start then
            tela.x = tela.x - 1
        end

        if player.position[2] >= rangeY.fim then
            tela.y = tela.y + 1
        elseif player.position[2] <= rangeY.start then
            tela.y = tela.y - 1
        end

        player.velx = 0
        player.vely = 0

    end
end

function love.draw()

    if  state == "Menu" then
        draw.drawMenu(menuGraphics)

    elseif state == "inGame" then
        draw.drawMap(tela, propW, propH, map, tamW, tamH)

        draw.drawTotems(totems, tela, propW, propH, tamW, tamH)

        draw.drawEnemys(enemys, enemyImg, tela, propW, propH, tamW, tamH)

        draw.drawPlayer(player, playerImg, tela, propW, propH, tamW, tamH)

        if substate == minigameType.DTB then
            draw.drawDTB(WIDTH, HEIGHT, propW, propH, text, currentTotem, seeDER)
            if lvl == "tutorialRun" then
                love.graphics.setColor(255,255,255)
                love.graphics.draw(instrucao, 10, 10, 0, 0.5, 0.5)
            end

        elseif substate == minigameType.DER then
            draw.drawDER(WIDTH, HEIGHT, propW, propH, currentTotem, setas)
            if lvl == "tutorialRun" then
                love.graphics.setColor(255,255,255)
                love.graphics.draw(instrucao, 10, 10, 0, 0.5, 0.5)
            end

        elseif substate == minigameType.AR then
            draw.drawAR(WIDTH, HEIGHT, propW, propH)
        elseif substate == "instrucao" then
            love.graphics.draw(instrucao, (WIDTH*1.5/propW)+30, HEIGHT/(propH*2))
            love.graphics.setColor(255,255,255)
            love.graphics.draw(inst, ((WIDTH*1.5/propW)+30)+instrucao:getPixelWidth()-((inst:getPixelWidth()/2)*0.4), (HEIGHT/(propH*2))-((inst:getPixelHeight()/2)*0.4), 0, 0.4,0.4)
        else
            love.graphics.setColor(255,0,0)
            love.graphics.printf(lifesTxt, 8, 10, (WIDTH-(WIDTH/propW)*2))
        end

    elseif state == "End" then
        love.graphics.setColor(255,255,255)

        love.graphics.draw(End.capa, 0, 0)

        love.graphics.draw(End.quit.img, End.quit.x, End.quit.y)

    elseif state == "GameOver" then
        love.graphics.setColor(255,255,255)

        love.graphics.draw(GameOver.capa, 0, 0)

        love.graphics.draw(GameOver.continuar.img, GameOver.continuar.x, GameOver.continuar.y)
    end
end