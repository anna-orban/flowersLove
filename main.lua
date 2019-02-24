function love.load()
    images = {}
    for imageIndex, images in ipairs({
        1, 2, 3, 4, 5, 6, 7, 8,'uncovered', 'covered_highlighted', 'covered', 'flower', 'flag', 'question',
    }) do
        images[image] = love.graphics.newImage('images/'..image..'.png')
    end
end

function love.update()

end

function love.draw()

end