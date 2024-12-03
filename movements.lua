local function keyboardInput(player, totems, isDown, substate, currentTotem, lifes)
    if substate == "Play" then
        if love.keyboard.isDown("w", "up") then
            if not isDown then
                player.vely = -1
                isDown = true
            end
        elseif love.keyboard.isDown("s", "down") then
            if not isDown then
                player.vely = 1
                isDown = true
            end
        elseif love.keyboard.isDown("a", "left") then
            if not isDown then
                player.velx = -1
                isDown = true
            end
        elseif love.keyboard.isDown("d", "right") then
            if not isDown then
                player.velx = 1
                isDown = true
            end
        elseif love.keyboard.isDown("space") then
            if not isDown then
                for _, totem in ipairs(totems) do
                    if player.position[1] == totem.position[1] and player.position[2] == totem.position[2] then
                        lifes = 3
                        substate = totem.tipo.typeName
                        currentTotem = totem
                    end
                end
            end
        else
            isDown = false
        end
    else
        if love.keyboard.isDown("escape") then
            if not isDown then
                substate = "Play"
                isDown = true
                currentTotem = nil
            end
        else
            isDown = false
        end
    end

    return isDown, substate, currentTotem, lifes
end

local function playerNewPosition(player)
    player.position[1] = player.position[1] + player.velx
    player.position[2] = player.position[2] + player.vely
end

local function enemyMovement(contador, tempoAcumulado, enemys, constructors, map)
    if tempoAcumulado >= 3 then
        contador = contador + 1
        tempoAcumulado = tempoAcumulado - 3

        for _, enemy in ipairs(enemys) do
            local direcoes = {}

            if map[(enemy.position[2]-1)][enemy.position[1]] == 2 then
                table.insert(direcoes, constructors.newEnemy(enemy.position[1], (enemy.position[2]-1), 0, 0, "up"))
            end

            if map[(enemy.position[2]+1)][enemy.position[1]] == 2 then
                table.insert(direcoes, constructors.newEnemy(enemy.position[1], (enemy.position[2]+1), 0, 0, "down"))
            end

            if map[(enemy.position[2])][enemy.position[1]-1] == 2 then
                table.insert(direcoes, constructors.newEnemy((enemy.position[1]-1), enemy.position[2], 0, 0, "left"))
            end

            if map[(enemy.position[2])][enemy.position[1]+1] == 2 then
                table.insert(direcoes, constructors.newEnemy((enemy.position[1]+1), enemy.position[2], 0, 0, "right"))
            end

            if #direcoes > 0 then
                local enemyRand = math.random(1, #direcoes)
                local newStatus = direcoes[enemyRand]

                if map[newStatus.position[2]][newStatus.position[1]] == 2 then
                    enemy.position[1] = newStatus.position[1]
                    enemy.position[2] = newStatus.position[2]
                    enemy.look = newStatus.look
                end
            end
        end
    end
    return contador, tempoAcumulado
end

return {
    keyboardInput = keyboardInput,
    playerNewPosition = playerNewPosition,
    enemyMovement = enemyMovement
}