local function DER(player, isDown, currentMinigame, substate, lifes)
    if love.keyboard.isDown("a", "left") then
        if not isDown then
            if currentMinigame.tipo.diagram > 1 then
                currentMinigame.tipo.diagram = currentMinigame.tipo.diagram - 1
            end
            isDown = true
        end
    elseif love.keyboard.isDown("d", "right") then
        if not isDown then
            if currentMinigame.tipo.diagram < #currentMinigame.tipo.img then
                currentMinigame.tipo.diagram = currentMinigame.tipo.diagram + 1
            end
            isDown = true
        end
    elseif love.keyboard.isDown("h") then
        if not isDown then
            
            isDown = true
        end
    elseif love.keyboard.isDown("return") then
        if not isDown then
            if currentMinigame.tipo.diagram == currentMinigame.tipo.answer then
                player.flags = 1
                substate = "Play"
            else
                if lifes > 1 then
                    lifes = lifes - 1
                else
                    love.event.quit()
                end
            end
        end
            isDown = true
    else
        isDown = false
    end

    return player, isDown, substate, lifes

end

local function DTB(player, isDown, currentMinigame, substate, lifes, text, seeDER)
    if love.keyboard.isDown("tab") then
        if not isDown then
            if seeDER[1] == false then
                seeDER[1] = true
            else
                seeDER[1] = false
            end
            isDown = true
        end
    elseif love.keyboard.isDown("h") then
        if not isDown then
            
            isDown = true
        end
    elseif love.keyboard.isDown("return") then
        if not isDown then
            local flag = false
            for index, answer in ipairs(currentMinigame.tipo.answers) do
                if string.upper(answer) == string.upper(string.gsub(text, "^%s*(.-)%s*$", "%1")) then
                    currentMinigame.tipo.correctAnswers[index] = true
                    flag = true
                    text = ""
                end
            end

            if flag == false then
                if lifes > 1 then
                    lifes = lifes - 1
                else
                    love.event.quit()
                end
            else
                flag = true

                for _, answers in ipairs(currentMinigame.tipo.correctAnswers) do
                    if answers == false then
                        flag = false
                    end
                end

                if flag == true then
                    player.flags = player.flags + 1
                    text = ""
                    substate = "Play"
                end
            end
        end
            isDown = true
    else
        isDown = false
    end

    return player, isDown, substate, lifes, text, seeDER
end

return {
    DER = DER,
    DTB = DTB
}