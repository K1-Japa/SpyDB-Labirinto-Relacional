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
    answer = 1
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
    answers = {"id_contata", "cpf_proprietario", "cpf_corretor"},
    correctAnswers = {false, false, false}
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
    correctAnswers = {false, false, false, false}
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
    answer = 2
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
    answers = {"id", "nome", "cpf_funcionario"},
    correctAnswers = {false, false, false}
}

a = loadImage("imgs/tutorial/tutorialTabelaTitulo.png")
aux.imgs.Titulo = a

auxImg = {"imgs/tutorial/ctutorialTabelaColuna01.png", "imgs/tutorial/ctutorialTabelaColuna02.png", "imgs/tutorial/ctutorialTabelaColuna03.png"}

for _, x in ipairs(auxImg) do

    a = loadImage(x)
    table.insert(aux.imgs.Codificado, a)

end

auxImg = {"imgs/tutorial/dtutorialTabelaColuna01.png", "imgs/tutorial/dtutorialTabelaColuna02.png", "imgs/tutorial/dtutorialTabelaColuna03.png"}

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
local seeDER = {false, tutorial.totems[1].tipo.img[tutorial.totems[1].tipo.answer]}
local instrucao = loadImage("imgs/lvl01/lvl01Instrucao.png")

function love.update(dt)

    if state == "Menu" then

        function love.mousepressed(mx, my, mbutton)
            if mbutton == 1 and mx >= menuGraphics.start.x and mx < menuGraphics.start.x + menuGraphics.start.width and my >= menuGraphics.start.y and my < menuGraphics.start.y + menuGraphics.start.height then
                state = "inGame"
            end
    
            if mbutton == 1 and mx >= menuGraphics.quit.x and mx < menuGraphics.quit.x + menuGraphics.quit.width and my >= menuGraphics.quit.y and my < menuGraphics.quit.y + menuGraphics.quit.height then
                love.event.quit()
            end
        end

    elseif state == "inGame" then

        tempoAcumulado = tempoAcumulado + dt

        if lvl == "lvl01" then
            map = lvl01.map
            player = lvl01.player
            enemys = lvl01.enemys
            totems = lvl01.totems
            seeDER = {false, lvl01.totems[1].tipo.img[lvl01.totems[1].tipo.answer]}
            substate = "instrucao"
            lvl = "a"
        end

        isDown, substate, currentTotem, lifes, text, lvl = movement.keyboardInput(player, totems, isDown, substate, currentTotem, lifes, text, lvl)

        colision.enemyLook(player, enemys)

        contador, tempoAcumulado = movement.enemyMovement(contador, tempoAcumulado, enemys, constructors, map)

        colision.playerColision(player, enemys, map)

        movement.playerNewPosition(player)

        if substate == minigameType.DER then
            player, minigameIsDown, substate, lifes = minigame.DER(player, minigameIsDown, currentTotem, substate, lifes)
        elseif substate == minigameType.DTB then
            player, minigameIsDown, substate, lifes, text, seeDER = minigame.DTB(player, minigameIsDown, currentTotem, substate, lifes, text, seeDER)
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
            if lvl == "tutorial" then
                love.graphics.setColor(255,255,255)
                love.graphics.printf("Digite os atributos da tabela. [enter]", (WIDTH*4/(propW*2)), (HEIGHT-(HEIGHT/propH))+70, (WIDTH-(WIDTH/propW)*2))
                love.graphics.printf("(chaves estrangeiras estão na forma {atributo_entidade})", (WIDTH*2.5/(propW*2)), (HEIGHT-(HEIGHT/propH))+100, (WIDTH-(WIDTH/propW)*2))
            end

        elseif substate == minigameType.DER then
            draw.drawDER(WIDTH, HEIGHT, propW, propH, currentTotem, setas)
            if lvl == "tutorial" then
                love.graphics.setColor(255,255,255)
                love.graphics.printf("Selecione o DER correspondente a um departamento com muitos funcionários. [enter]", (WIDTH/propW), (HEIGHT-(HEIGHT/propH)), (WIDTH-(WIDTH/propW)*2))
            end

        elseif substate == minigameType.AR then
            draw.drawAR(WIDTH, HEIGHT, propW, propH)
        elseif substate == "instrucao" then
            love.graphics.draw(instrucao, (WIDTH*1.5/propW)+30, HEIGHT/(propH*2))
        else
            if lvl == "tutorial" then
                love.graphics.setColor(255,255,255)
                if player.flags == 0 then
                    love.graphics.printf("Ande até o quadrado para interagir com o 1° minigame. [space]", (WIDTH*1.5/propW), (HEIGHT-(HEIGHT/propH)), (WIDTH-(WIDTH/propW)*2))
                elseif player.flags == 1 then
                    love.graphics.printf("Ande até o triângulo para interagir com o 2° minigame.\n(Só é possível interagir com um minigame do tipo triângulo\n após interagir com um do tipo quadrado antes).", (WIDTH*1.5/propW), (HEIGHT-(HEIGHT/propH)), (WIDTH-(WIDTH/propW)*2))
                elseif player.flags == 2 then
                    love.graphics.printf("Ande até o círculo para avançar de fase.\n(Só é possível avançar de fase após concluir todos os minigames da fase atual).", (WIDTH*1.5/propW), (HEIGHT-(HEIGHT/propH)), (WIDTH-(WIDTH/propW)*2))
                end
            end
        end
        
    end
end