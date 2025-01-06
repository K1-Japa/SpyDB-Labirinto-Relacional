local function playerColision(player, enemys, map)
    local nextX = player.position[1] + player.velx
    local nextY = player.position[2] + player.vely
    if nextX < 1 or nextX > #map[1] or nextY < 1 or nextY > #map then
        player.velx = 0
        player.vely = 0
    elseif map[nextY][nextX] == 0 or map[nextY][nextX] == 1 then
        player.velx = 0
        player.vely = 0
    end

    for _, enemy in ipairs(enemys) do
        if enemy.position[1] == nextX and enemy.position[2] == nextY then
            player.velx = 0
            player.vely = 0
        end
    end
end

local function enemyLook(player, enemys, lifes, state, playerStart, enemysStart, lvl)
    for _, enemy in ipairs(enemys) do
        if enemy.position[1] == player.position[1] and enemy.position[2] == player.position[2] then
                if lifes > 1 then
                    lifes = lifes - 1

                    player.position[1] = playerStart[1]
                    player.position[2] = playerStart[2]

                    for index, _ in ipairs(enemys) do
                        enemys[index].position[1] = enemysStart[index].position[1]
                        enemys[index].position[2] = enemysStart[index].position[2]
                        enemys[index].look = enemysStart[index].look
                        enemys[index].lastPosition = enemysStart[index].lastPosition
                    end
                else
                    state = "GameOver"
                end
        elseif enemy.look == "up" then
            if enemy.position[1] == player.position[1] and (enemy.position[2] - 1) == player.position[2] then
                if lifes > 1 then
                    lifes = lifes - 1

                    player.position[1] = playerStart[1]
                    player.position[2] = playerStart[2]

                    for index, _ in ipairs(enemys) do
                        enemys[index].position[1] = enemysStart[index].position[1]
                        enemys[index].position[2] = enemysStart[index].position[2]
                        enemys[index].look = enemysStart[index].look
                        enemys[index].lastPosition = enemysStart[index].lastPosition
                    end
                else
                    state = "GameOver"
                end
            end
        elseif enemy.look == "down" then
            if enemy.position[1] == player.position[1] and (enemy.position[2] + 1) == player.position[2] then
                if lifes > 1 then
                    lifes = lifes - 1

                    player.position[1] = playerStart[1]
                    player.position[2] = playerStart[2]

                    for index, _ in ipairs(enemys) do

                        enemys[index].position[1] = enemysStart[index].position[1]
                        enemys[index].position[2] = enemysStart[index].position[2]
                        enemys[index].look = enemysStart[index].look
                        enemys[index].lastPosition = enemysStart[index].lastPosition
                    end
                else
                    state = "GameOver"
                end
            end
        elseif enemy.look == "left" then
            if (enemy.position[1] - 1) == player.position[1] and enemy.position[2] == player.position[2] then
                if lifes > 1 then
                    lifes = lifes - 1

                    player.position[1] = playerStart[1]
                    player.position[2] = playerStart[2]

                    for index, _ in ipairs(enemys) do
                        enemys[index].position[1] = enemysStart[index].position[1]
                        enemys[index].position[2] = enemysStart[index].position[2]
                        enemys[index].look = enemysStart[index].look
                        enemys[index].lastPosition = enemysStart[index].lastPosition
                    end
                else
                    state = "GameOver"
                end
            end
        elseif enemy.look == "right" then
            if (enemy.position[1] + 1) == player.position[1] and enemy.position[2] == player.position[2] then
                if lifes > 1 then
                    lifes = lifes - 1

                    player.position[1] = playerStart[1]
                    player.position[2] = playerStart[2]

                    for index, _ in ipairs(enemys) do
                        enemys[index].position[1] = enemysStart[index].position[1]
                        enemys[index].position[2] = enemysStart[index].position[2]
                        enemys[index].look = enemysStart[index].look
                        enemys[index].lastPosition = enemysStart[index].lastPosition
                    end
                else
                    state = "GameOver"
                end
            end
        end
    end

    return lifes, state, player, enemys, lvl

end



return {
    playerColision = playerColision,
    enemyLook = enemyLook
}