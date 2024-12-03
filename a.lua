local HEIGHT = 600
local WIDTH = 600

local player = {
    position = {500, 250},
    tamanho = 50,
    velocidade = 10
}

function love.load()
    love.window.setMode(HEIGHT, WIDTH)
end

function love.update(dt)
    if(love.keyboard.isDown("down")) then
        if(verificaMove("down")) then
            player.position[2] = player.position[2] + player.velocidade
        end
    end

    if(love.keyboard.isDown("up")) then
        if(verificaMove("up")) then
            player.position[2] = player.position[2] - player.velocidade
        end
    end

    if(love.keyboard.isDown("left")) then
        if(verificaMove("left")) then
            player.position[1] = player.position[1] - player.velocidade
        end
    end

    if(love.keyboard.isDown("right")) then
        if(verificaMove("right")) then
            player.position[1] = player.position[1] + player.velocidade
        end
    end
    
    print(player.position[1] .. " " .. player.position[2])
    
end

function love.draw()
    love.graphics.polygon("fill", player.position[1], player.position[2], (player.position[1]+player.tamanho), player.position[2], (player.position[1]+(player.tamanho/2)), (player.position[2]-(player.tamanho/2)))
end

function verificaMove(move)
    if(move == "down") then
        if(player.position[2] + player.velocidade > HEIGHT) then
            return false
        else
            return true
        end
    end

    if(move == "up") then
        if(player.position[2] - player.velocidade < (0+(player.tamanho)/2)) then
            return false
        else
            return true
        end
    end

    if(move == "left") then
        if(player.position[1] - player.velocidade < 0) then
            return false
        else
            return true
        end
    end

    if(move == "right") then
        if(player.position[1] + player.velocidade > (WIDTH-player.tamanho)) then
            return false
        else
            return true
        end
    end
end