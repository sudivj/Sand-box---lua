require("src/elements")

SCREEN_X = 1000
SCREEN_Y = 800

world = {}

cursor = {}

cursor.x = 0
cursor.index_x = 0
cursor.index_y = 0
cursor.width = 10
cursor.height = 10

SCREENWIDTH = (SCREEN_X / cursor.width) + 2
SCREENHEIGHT = (SCREEN_Y / cursor.height) + 2

dots = 0

function init_world()
    for i = 1, SCREENWIDTH do
        world[i] = {}
        for j = 1, SCREENHEIGHT do
            if i == 1 or i == SCREENWIDTH or j == 1 or j == SCREENHEIGHT then
                world[i][j] = stone()
            else
                world[i][j] = air()
            end
        end
    end
    return true
end

function draw_world()
    dots = 0
    for i = 1, SCREENWIDTH do
        for j = 1, SCREENHEIGHT do
            --love.graphics.rectangle("fill", (i - 2) * cursor.width, (SCREENHEIGHT - (j + 1)) * cursor.height, cursor.width, cursor.height)
            if world[i][j].id ~= 0 then
                local cell = world[i][j]
                local color = cell.color
                love.graphics.setColor(love.math.colorFromBytes(color[1], color[2], color[3]))
                love.graphics.rectangle("fill", (i - 2) * cursor.width, (SCREENHEIGHT - (j + 1)) * cursor.height, cursor.width, cursor.height)
                love.graphics.setColor(1, 1, 1)
                if not (i == 1 or i == SCREENWIDTH or j == 1 or j == SCREENHEIGHT) then
                    dots = dots + 1
                end
            end
            --love.graphics.rectangle("fill", (i - 2) * cursor.width, (SCREENHEIGHT - (j + 1)) * cursor.height, cursor.width, cursor.height)
        end
    end
    --love.graphics.rectangle("fill", (SCREEN_X / 2) - 20, 0, 20, 20)
    love.graphics.print(love.timer.getFPS(), (SCREEN_X / 2) - 20, 0)
end
