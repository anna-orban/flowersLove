function love.load()
    images = {}
    for imageIndex, image in ipairs({
        1, 2, 3, 4, 5, 6, 7, 8,'uncovered', 'covered_highlighted', 'covered', 'flower', 'flag', 'question',
    }) do
        images[image] = love.graphics.newImage('images/'..image..'.png')
    end
    cellSize = 18
    gridX, gridY = love.graphics.getWidth() / cellSize, love.graphics.getHeight() / cellSize

end

function love.update()

end

function love.draw()
    for y = 1, gridY do
        for x = 1, gridX do
            love.graphics.draw(images.covered, (x - 1) * cellSize, (y - 1) * cellSize)
        end
    end   
end