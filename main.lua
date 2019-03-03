function love.load()
    images = {}
    for imageIndex, image in ipairs({
        1, 2, 3, 4, 5, 6, 7, 8,'uncovered', 'covered_highlighted', 'covered', 'flower', 'flag', 'question',
    }) do
        images[image] = love.graphics.newImage('images/'..image..'.png')
    end
    cellSize = 18
    gridX, gridY = math.floor(love.graphics.getWidth() / cellSize), math.floor(love.graphics.getHeight() / cellSize)

    grid = {}

    for y = 1, gridY do
        grid[y] = {}
        for x = 1, gridX do 
            grid[y][x] = {
                flower = false,
                state = 'covered' -- 'covered', 'uncovered', 'flag', 'question'
            }
        end
    end

    possibleFlowrPositions = {}

    for y = 1, gridY do
        for x = 1, gridX do
            table.insert(possibleFlowrPositions, {x = x, y = y})
        end
    end

    for flowerIndex = 1, 60 do
        local position = table.remove(possibleFlowrPositions, love.math.random(#possibleFlowrPositions))
        grid[position.y][position.x].flower = true
    end

    gameOver = false
end

function love.update()
    selectedX = math.floor(love.mouse.getX() / cellSize) + 1
    selectedY = math.floor(love.mouse.getY() / cellSize) + 1

    if selectedX > gridX then
        selectedX = gridX
    end
    if selectedY > gridY then
        electedY = gridY
    end

end

function love.draw()
    for y = 1, gridY do
        for x = 1, gridX do
            if grid[y][x].state == 'uncovered' then
                drawCell(images.uncovered, x, y)
            else 
                if x == selectedX and y == selectedY then
                    if love.mouse.isDown(1) then
                        if grid[y][x].state == 'flag' then
                            drawCell(images.covered, x, y)
                        else
                            drawCell(images.uncovered, x, y)
                        end
                    else
                        drawCell(images.covered_highlighted, x, y)
                    end
                else
                    drawCell(images.covered, x, y)
                end
            end

            if grid[y][x].flower then
                drawCell(images.flower, x, y)
            elseif getSurroundingFlowerCount(x, y) > 0 then
                drawCell(images[getSurroundingFlowerCount(x, y)], x, y)
            end

            if grid[y][x].state == 'flag' then
                drawCell(images.flag, x, y)
            elseif grid[y][x].state == 'question' then
                drawCell(images.question, x, y)
            end
        end
    end   

    --temp
    love.graphics.setColor(0, 0, 0)
    love.graphics.print('selected x: '..selectedX..' selected y: '..selectedY)
    love.graphics.setColor(1, 1, 1)
end

--temp
function love.mousereleased(mouseX, mouseY, button)
    if not gameOver then
        if button == 1  and grid[selectedY][selectedX].state ~= 'flag' then
            if grid[selectedY][selectedX].flower and grid[selectedY][selectedX].state == 'uncovered' then
                gameOver = true
            else    
                local stack = {
                    {
                        x = selectedX,
                        y = selectedY,
                    }
                }

                while #stack > 0 do
                    local current = table.remove(stack)
                    local x = current.x
                    local y = current.y

                    grid[y][x].state = 'uncovered'
                    if getSurroundingFlowerCount(x, y) == 0 then
                        for dy = -1, 1 do
                            for dx = -1, 1 do
                                if not (dx == 0 and dy == 0) and grid[y + dy] and grid[y + dy][x + dx] and 
                                (grid[y + dy][x + dx].state == 'covered' or grid[y + dy][x + dx].state == 'question') then
                                    table.insert(
                                        stack, {
                                            x = x + dx,
                                            y = y + dy,
                                        }
                                    )
                                end
                            end
                        end
                    end
                end

                local complete = true
                for y = 1, gridYCount do
                    for x = 1, gridXCount do
                    if grid[y][x].state ~= 'uncovered' and not grid[y][x].flower then
                        complete = false
                    end
                end

                if complete then
                    gameOver = true
                end
            end
        end

        if button == 2 then
            if grid[selectedY][selectedX].state == 'covered' then
                grid[selectedY][selectedX].state = 'flag'
            elseif grid[selectedY][selectedX].state == 'flag' then
                grid[selectedY][selectedX].state = 'question'
            elseif grid[selectedY][selectedX].state == 'question' then
                grid[selectedY][selectedX].state = 'covered'
            end
        end
    end
end

--temp
function love.keypressed()
    love.load()
end

function drawCell(image, x, y)
    love.graphics.draw(image, (x-1) * cellSize, (y-1)  * cellSize)
end

function getSurroundingFlowerCount(x, y)
    local surroundingFlowerCount = 0
    for dy = -1, 1 do
        for dx = -1, 1 do
            if grid[y + dy] and grid[y + dy][x + dx] and grid[y + dy][x + dx].flower then
                surroundingFlowerCount = surroundingFlowerCount + 1
            end
        end
    end
    return surroundingFlowerCount
end