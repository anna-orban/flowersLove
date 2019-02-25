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
                flower = false
            }
        end
    end

    -- Temporary
    grid[1][1].flower = true
    grid[1][2].flower = true

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
            if x == selectedX and y == selectedY then
                if love.mouse.isDown(1) then
                    drawCell(images.uncovered, x, y)
                else
                    drawCell(images.covered_highlighted, x, y)
                end
            else
                drawCell(images.covered, x, y)
            end

            if grid[y][x].flower then
                drawCell(images.flower, x, y)
            end
        end
    end   

    --temp
    love.graphics.setColor(0, 0, 0)
    love.graphics.print('selected x: '..selectedX..' selected y: '..selectedY)
    love.graphics.setColor(1, 1, 1)
end

function drawCell(image, x, y)
    love.graphics.draw(image, (x-1) * cellSize, (y-1)  * cellSize)
end