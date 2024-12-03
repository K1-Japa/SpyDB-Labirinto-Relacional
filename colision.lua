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

local function enemyLook(player, enemys)
    for _, enemy in ipairs(enemys) do
        if enemy.position[1] == player.position[1] and enemy.position[2] == player.position[2] then
            love.event.quit()
        elseif enemy.look == "up" then
            if enemy.position[1] == player.position[1] and (enemy.position[2] - 1) == player.position[2] then
                love.event.quit()
            end
        elseif enemy.look == "down" then
            if enemy.position[1] == player.position[1] and (enemy.position[2] + 1) == player.position[2] then
                love.event.quit()
            end
        elseif enemy.look == "left" then
            if (enemy.position[1] - 1) == player.position[1] and enemy.position[2] == player.position[2] then
                love.event.quit()
            end
        elseif enemy.look == "right" then
            if (enemy.position[1] + 1) == player.position[1] and enemy.position[2] == player.position[2] then
                love.event.quit()
            end
        end
    end
end



return {
    playerColision = playerColision,
    enemyLook = enemyLook
}