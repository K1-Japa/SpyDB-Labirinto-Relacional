local function drawMap(tela, propW, propH, map, tamW, tamH)
    local rangeX = {
        start = tela.x - math.floor(propW/2),
        fim = tela.x + math.floor(propW/2)
    }

    local rangeY = {
        start = tela.y - math.floor(propH/2),
        fim = tela.y + math.floor(propH/2)
    }

    local posx = 1
    for i = rangeX.start, rangeX.fim do
        local posy = 1
        for j = rangeY.start, rangeY.fim do
            if map[j][i] == 1 then
                love.graphics.setColor(255, 255, 255)
            elseif map[j][i] == 2 then
                love.graphics.setColor(0, 255, 0)
            else
                love.graphics.setColor(0, 0, 0)
            end
            love.graphics.rectangle("fill", (posx - 1) * tamW, (posy - 1) * tamH, tamW, tamH)
            love.graphics.setColor(0,0,0)
            love.graphics.print(("(y: " .. j .. ", x: " .. i .. ")"), (posx - 1) * tamW, (posy - 1) * tamH)
            posy = posy + 1
        end
        posx = posx + 1
    end
end

local function drawTotems(totems, tela, propW, propH, tamW, tamH)
    for _, totems in ipairs(totems) do
        love.graphics.setColor(0, 0, 255)
        love.graphics.rectangle("fill",
            ((totems.position[1] - tela.x + math.floor(propW / 2)) * tamW) + (tamW / 6), 
            ((totems.position[2] - tela.y + math.floor(propH / 2)) * tamH) + (tamH / 6), 
            tamW / 1.5,
            tamH / 1.5
        )
    end
end

local function drawEnemys(enemys, enemyImg, tela, propW, propH, tamW, tamH)
    for _, enemy in ipairs(enemys) do
        love.graphics.setColor(255, 0, 0)

        local tW, tH

        if tamW/2 > enemyImg:getPixelWidth() then
            tW = 1
        else
            tW = ((tamW/2)/enemyImg:getPixelWidth())
        end

        if tamH/2 > enemyImg:getPixelHeight() then
            tH = 1
        else
            tH = ((tamH/2)/enemyImg:getPixelHeight())
        end

        if tW < tH then
            tH = tW
        else
            tW = tH
        end

        love.graphics.draw(enemyImg, ((enemy.position[1] - tela.x + math.floor(propW / 2)) * tamW) + (tamW / 4), ((enemy.position[2] - tela.y + math.floor(propH / 2)) * tamH) + (tamH / 4), 0, tW, tH)

        -- love.graphics.rectangle("fill",
        --     ((enemy.position[1] - tela.x + math.floor(propW / 2)) * tamW) + (tamW / 4),
        --     ((enemy.position[2] - tela.y + math.floor(propH / 2)) * tamH) + (tamH / 4),
        --     tamW / 2,
        --     tamH / 2
        -- )

        love.graphics.setColor(1, 0.2, 0.2)

        if enemy.look == "up" then
            love.graphics.rectangle("fill",
            ((enemy.position[1] - tela.x + math.floor(propW / 2)) * tamW),
            (((enemy.position[2]-1) - tela.y + math.floor(propH / 2)) * tamH),
            tamW,
            tamH
        )
        elseif enemy.look == "down" then
            love.graphics.rectangle("fill",
            ((enemy.position[1] - tela.x + math.floor(propW / 2)) * tamW),
            (((enemy.position[2]+1) - tela.y + math.floor(propH / 2)) * tamH),
            tamW,
            tamH
        )
        elseif enemy.look == "left" then
            love.graphics.rectangle("fill",
            (((enemy.position[1]-1) - tela.x + math.floor(propW / 2)) * tamW),
            ((enemy.position[2] - tela.y + math.floor(propH / 2)) * tamH),
            tamW,
            tamH
        )
        elseif enemy.look == "right" then
            love.graphics.rectangle("fill",
            (((enemy.position[1]+1) - tela.x + math.floor(propW / 2)) * tamW),
            ((enemy.position[2] - tela.y + math.floor(propH / 2)) * tamH),
            tamW,
            tamH
        )
        end
    end
end

local function drawPlayer(player, playerImg, tela, propW, propH, tamW, tamH)
    love.graphics.setColor(255, 255, 0)

    local tW, tH

    if tamW/2 > playerImg:getPixelWidth() then
        tW = 1
    else
        tW = ((tamW/2)/playerImg:getPixelWidth())
    end

    if tamH/2 > playerImg:getPixelHeight() then
        tH = 1
    else
        tH = ((tamH/2)/playerImg:getPixelHeight())
    end

    if tW < tH then
        tH = tW
    else
        tW = tH
    end

    love.graphics.draw(playerImg, ((player.position[1] - tela.x + math.floor(propW / 2)) * tamW) + (tamW / 4), ((player.position[2] - tela.y + math.floor(propH / 2)) * tamH) + (tamH / 4), 0, tW, tH)

    -- love.graphics.rectangle("fill", 
    --     ((player.position[1] - tela.x + math.floor(propW / 2)) * tamW) + (tamW / 4),
    --     ((player.position[2] - tela.y + math.floor(propH / 2)) * tamH) + (tamH / 4),
    --     tamW / 2,
    --     tamH / 2
    -- )
    
end

local function drawDTB(WIDTH, HEIGHT, propW, propH, text)
    love.graphics.setColor(0,0,255)

    love.graphics.rectangle("fill", ((WIDTH/propW)/2), ((HEIGHT/propH)/2), (WIDTH-(WIDTH/propW)), (HEIGHT-(HEIGHT/propH)))

    love.graphics.setColor(0,255,0)
    love.graphics.printf(text, (WIDTH/propW), (HEIGHT-(HEIGHT/propH)), (WIDTH-(WIDTH/propW)*2))
end

local function drawDER(WIDTH, HEIGHT, propW, propH)
    love.graphics.setColor(0,0,255)

    love.graphics.rectangle("fill", ((WIDTH/propW)/2), ((HEIGHT/propH)/2), (WIDTH-(WIDTH/propW)), (HEIGHT-(HEIGHT/propH)))
end

local function drawAR(WIDTH, HEIGHT, propW, propH)
    love.graphics.setColor(0,0,255)

    love.graphics.rectangle("fill", ((WIDTH/propW)/2), ((HEIGHT/propH)/2), (WIDTH-(WIDTH/propW)), (HEIGHT-(HEIGHT/propH)))
end

local function drawMenu(menu)
    love.graphics.draw(menu.capa, 0, 0)

    love.graphics.draw(menu.start.img, menu.start.x, menu.start.y)

    love.graphics.draw(menu.quit.img, menu.quit.x, menu.quit.y)
end

return {
    drawMenu = drawMenu,
    drawMap = drawMap,
    drawTotems = drawTotems,
    drawEnemys = drawEnemys,
    drawPlayer = drawPlayer,
    drawDTB = drawDTB,
    drawDER = drawDER,
    drawAR = drawAR
}