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
                love.graphics.setColor(0.4118, 0.4118, 0.4118)
            elseif map[j][i] == 2 then
                love.graphics.setColor(0.4196, 0.2588, 0.149)
            else
                love.graphics.setColor(0,0,0)
            end
            love.graphics.rectangle("fill", (posx - 1) * tamW, (posy - 1) * tamH, tamW, tamH)
            -- love.graphics.setColor(0,0,0)
            -- love.graphics.print(("(y: " .. j .. ", x: " .. i .. ")"), (posx - 1) * tamW, (posy - 1) * tamH)
            posy = posy + 1
        end
        posx = posx + 1
    end
end

local function drawTotems(totems, tela, propW, propH, tamW, tamH)
    for _, totems in ipairs(totems) do
        love.graphics.setColor(0, 0, 255)
        if totems.tipo.typeName == "Diagrama Entidade Relacionamento" then
            love.graphics.rectangle("fill",
            ((totems.position[1] - tela.x + math.floor(propW / 2)) * tamW) + (tamW / 6), 
            ((totems.position[2] - tela.y + math.floor(propH / 2)) * tamH) + (tamH / 6), 
            tamW / 1.5,
            tamH / 1.5
            )
        elseif totems.tipo.typeName == "Decodificar Tabelas" then
            love.graphics.polygon("fill",
            ((totems.position[1] - tela.x + math.floor(propW / 2)) * tamW) + (tamW / 3),
            ((totems.position[2] - tela.y + math.floor(propH / 2)) * tamH) + (tamH / 7),

            ((totems.position[1] - tela.x + math.floor(propW / 2)) * tamW) - (tamW / 2) * math.cos(math.pi/3)+(tamW / 3),
            ((totems.position[2] - tela.y + math.floor(propH / 2)) * tamH) + (tamW / 2) * math.sin(math.pi/3)+(tamH / 9),

            ((totems.position[1] - tela.x + math.floor(propW / 2)) * tamW) + (tamW / 2) * math.cos(math.pi/3)+(tamW / 3),
            ((totems.position[2] - tela.y + math.floor(propH / 2)) * tamH) + (tamW / 2) * math.sin(math.pi/3)+(tamH / 9)
        )
        elseif totems.tipo.typeName == "Exit" then
            love.graphics.setColor(0, 255, 0)
            love.graphics.circle("fill",
            (totems.position[1] - tela.x + math.floor(propW / 2)) * tamW + (tamW / 3),
            (totems.position[2] - tela.y + math.floor(propH / 2)) * tamH + (tamH / 2),
            math.min(tamW, tamH) / 3
        )
        end
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

local function drawDTB(WIDTH, HEIGHT, propW, propH, text, currentTotem, seeDER)
    local somaW = currentTotem.tipo.imgs.Titulo:getPixelWidth()

    local somaH = currentTotem.tipo.imgs.Titulo:getPixelHeight() + currentTotem.tipo.imgs.Codificado[1]:getPixelHeight()

    local tW = 1
    local tH = 1

    if somaW > (WIDTH-(WIDTH/propW)) then
        tW = ((WIDTH-(WIDTH/propW)) / somaW)/1.5
    end

    if somaH > (HEIGHT-(HEIGHT/propH)) then
        tH = ((HEIGHT-(HEIGHT/propH)) / somaH)/1.5
    end

    if tH > tW then
        tH = tW
    else
        tW = tH
    end

    love.graphics.setColor(0,0,255)

    love.graphics.rectangle("fill", ((WIDTH/propW)/2), ((HEIGHT/propH)/2), (WIDTH-(WIDTH/propW)), (HEIGHT-(HEIGHT/propH)))

    love.graphics.setColor(255,255,255)

    if seeDER[1] == false then

        love.graphics.draw(currentTotem.tipo.imgs.Titulo, ((WIDTH/propW)/2) + ((WIDTH-(WIDTH/propW))-(somaW*tW))/2, ((HEIGHT/propH)/2)+ ((HEIGHT-(HEIGHT/propH))-(somaH*tH))/2, 0, tW, tH)

        for index, coluna in ipairs(currentTotem.tipo.imgs.Codificado) do
            if currentTotem.tipo.correctAnswers[index] == false then
                love.graphics.draw(coluna, (((WIDTH/propW)/2) + ((WIDTH-(WIDTH/propW))-(somaW*tW))/2)+((index-1)*coluna:getPixelWidth()*tW), ((HEIGHT/propH)/2)+ (((HEIGHT-(HEIGHT/propH))-(somaH*tH))/2) + currentTotem.tipo.imgs.Titulo:getPixelHeight()*tH, 0, tW, tH)
            end
        end

        for index, coluna in ipairs(currentTotem.tipo.imgs.Decodificado) do
            if currentTotem.tipo.correctAnswers[index] == true then
                love.graphics.draw(coluna, (((WIDTH/propW)/2) + ((WIDTH-(WIDTH/propW))-(somaW*tW))/2)+((index-1)*coluna:getPixelWidth()*tW), ((HEIGHT/propH)/2)+ (((HEIGHT-(HEIGHT/propH))-(somaH*tH))/2) + currentTotem.tipo.imgs.Titulo:getPixelHeight()*tH, 0, tW, tH)
            end
        end
    else
        love.graphics.draw(seeDER[2], ((WIDTH/propW)/2)+(((WIDTH-(WIDTH/propW))-seeDER[2]:getPixelWidth())/2), ((HEIGHT/propH)/2)+(((HEIGHT-(HEIGHT/propH))-seeDER[2]:getPixelHeight())/2))

    end

    if currentTotem.tipo.completed == true then
        love.graphics.setColor(0,255,0)
        love.graphics.printf("Concluído!", (WIDTH/propW), (HEIGHT-(HEIGHT/propH)), (WIDTH-(WIDTH/propW)*2))
    else
        love.graphics.setColor(0,255,0)
        love.graphics.printf(text, (WIDTH/propW), (HEIGHT-(HEIGHT/propH)), (WIDTH-(WIDTH/propW)*2))
    end
end

local function drawDER(WIDTH, HEIGHT, propW, propH, currentTotem, setas)
    love.graphics.setColor(0,0,255)

    love.graphics.rectangle("fill", ((WIDTH/propW)/2), ((HEIGHT/propH)/2), (WIDTH-(WIDTH/propW)), (HEIGHT-(HEIGHT/propH)))

    love.graphics.setColor(255,255,255)

    love.graphics.draw(currentTotem.tipo.img[currentTotem.tipo.diagram], ((WIDTH/propW)/2)+(((WIDTH-(WIDTH/propW))-currentTotem.tipo.img[currentTotem.tipo.diagram]:getPixelWidth())/2), ((HEIGHT/propH)/2)+(((HEIGHT-(HEIGHT/propH))-currentTotem.tipo.img[currentTotem.tipo.diagram]:getPixelHeight())/2))

    love.graphics.draw(setas.setaA, ((WIDTH/propW)/2)+20, ((HEIGHT/propH)/2)+(((HEIGHT-(HEIGHT/propH))/2))-setas.setaA:getPixelHeight()/2)
    love.graphics.draw(setas.setaD, (((WIDTH/propW)/2)+(WIDTH-(WIDTH/propW)))-setas.setaD:getPixelWidth()-20,  ((HEIGHT/propH)/2)+(((HEIGHT-(HEIGHT/propH))/2))-setas.setaD:getPixelHeight()/2)

    if currentTotem.tipo.completed == true then
        love.graphics.setColor(0,255,0)
        love.graphics.printf("Concluído!", (WIDTH/propW), (HEIGHT-(HEIGHT/propH)), (WIDTH-(WIDTH/propW)*2))
    end
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