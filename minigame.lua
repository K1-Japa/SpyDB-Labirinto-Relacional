local function DER(isDown, currentMinigame, substate, lifes)
    if love.keyboard.isDown("a", "left") then
        if not isDown then
            if currentMinigame.tipo.diagram > 1 then
                currentMinigame.tipo.diagram = currentMinigame.tipo.diagram - 1
            end
            isDown = true
        end
    elseif love.keyboard.isDown("d", "right") then
        if not isDown then
            if currentMinigame.tipo.diagram < 4 then
                currentMinigame.tipo.diagram = currentMinigame.tipo.diagram + 1
            end
            isDown = true
        end
    elseif love.keyboard.isDown("return") then
        if not isDown then
            if currentMinigame.tipo.diagram == currentMinigame.tipo.answer then
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

    return isDown, substate, lifes

end

local function DTB(isDown, currentMinigame, substate, lifes, text)
    if love.keyboard.isDown("tab") then
        if not isDown then
            if currentMinigame.tipo.diagram > 1 then
                currentMinigame.tipo.diagram = currentMinigame.tipo.diagram - 1
            end
            isDown = true
        end
    elseif love.keyboard.isDown("return") then
        if not isDown then
            local flag = false
            for index, answer in ipairs(currentMinigame.tipo.answers) do
                if string.upper(answer) == string.upper(string.gsub(text, "^%s*(.-)%s*$", "%1")) then
                    print(index)
                    flag = true
                end
            end

            if flag == false then
                if lifes > 1 then
                    lifes = lifes - 1
                else
                    love.event.quit()
                end
            else
                text = ""
                substate = "Play"
            end
        end
            isDown = true
    else
        isDown = false
    end

    return isDown, substate, lifes, text
end

return {
    DER = DER,
    DTB = DTB
}