function love.load()
    images = {}
    for imageIndex, image in ipairs({
        1, 2, 3, 4, 5, 6, 7, 8,'uncovered', 'covered_highlighted', 'covered', 'flower', 'flag', 'question',
    }) do
        images[image] = love.graphics.newImage('images/'..image..'.png')
    end
    cellSize = 18
    gridX, gridY = math.floor(love.graphics.getWidth() / cellSize), math.floor(love.graphics.getHeight() / cellSize)

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
            local image
            if x == selectedX and y == selectedY then
                image = images.covered_highlighted
            else
                image = images.covered
            end

            love.graphics.draw(image, (x - 1) * cellSize, (y - 1) * cellSize)
        end
    end   

    --temp
    love.graphics.setColor(0, 0, 0)
    love.graphics.print('selected x: '..selectedX..' selected y: '..selectedY)
    love.graphics.setColor(1, 1, 1)
end