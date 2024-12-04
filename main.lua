require("conf")
local constructors = require("constructors")
local movement = require("movements")
local colision = require("colision")
local screen = require("screen")
local draw = require("draw")
local utf8 = require("utf8")
local minigame = require("minigame")
local lvl01 = require("lvl01")
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

local propW = 7
local propH = 7

local tamW = WIDTH / propW
local tamH = HEIGHT / propH

local function loadImage (path)
	local info = love.filesystem.getInfo( path )
	if info then
		return love.graphics.newImage( path )
	end
end

function love.load()
    love.window.setMode(WIDTH, HEIGHT)

    -- enable key repeat so backspace can be held down to trigger love.keypressed multiple times.
    love.keyboard.setKeyRepeat(true)

end

local playerImg = loadImage("imgs/player.png")
local enemyImg = loadImage("imgs/enemy.png")
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

local map, player, enemys, totems = lvl01.Game()

local tela = screen.set(player, propW, propH)

local isDown = false
local minigameIsDown = false

local contador = 0
local tempoAcumulado = 0

local state = "Menu"
local substate = "Play"
local currentTotem = nil
local lifes = nil

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

        isDown, substate, currentTotem, lifes, text = movement.keyboardInput(player, totems, isDown, substate, currentTotem, lifes, text)

        colision.enemyLook(player, enemys)

        contador, tempoAcumulado = movement.enemyMovement(contador, tempoAcumulado, enemys, constructors, map)

        colision.playerColision(player, enemys, map)

        movement.playerNewPosition(player)

        if substate == minigameType.DER then
            minigameIsDown, substate, lifes = minigame.DER(minigameIsDown, currentTotem, substate, lifes)
        elseif substate == minigameType.DTB then
            minigameIsDown, substate, lifes, text = minigame.DTB(minigameIsDown, currentTotem, substate, lifes, text)
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
            draw.drawDTB(WIDTH, HEIGHT, propW, propH, text)

        elseif substate == minigameType.DER then
            draw.drawDER(WIDTH, HEIGHT, propW, propH)

        elseif substate == minigameType.AR then
            draw.drawAR(WIDTH, HEIGHT, propW, propH)
        end
    end
end