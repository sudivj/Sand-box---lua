require("src/world")

function check_world()
    for i = 1, SCREENWIDTH do
        for j = 1, SCREENHEIGHT do
            check_rules( i, j)
        end
    end
    draw_world()
end

function check_rules( x, y)
    if world[x][y].id == 1 then
        rules.sand( world[x][y], x, y)
    end
    if world[x][y].id == 2 then
        rules.water( world[x][y], x, y)
    end
end

rules = {}

function rules.sand(cell, x, y)
    if world[x][y - 1].type == "gas" then
        cell.isFreeFalling = true
        world[x][y] = cell
        swap_elements(x, y, x, y - 1)
        check_neighbours(x, y - 1)
    elseif cell.isFreeFalling then
        if world[x][y - 1].type == "fluid" then
            swap_elements(x, y, x, y - 1)
            check_neighbours(x, y - 1)
        elseif world[x - 1][y].type == "gas" and world[x - 1][y - 1].type == "gas" then
            swap_elements(x, y, x - 1, y)
            swap_elements(x - 1, y, x - 1, y - 1)
        elseif world[x + 1][y].type == "gas" and world[x + 1][y - 1].type == "gas" then
            swap_elements(x, y, x + 1, y)
            swap_elements(x + 1, y, x + 1, y - 1)
        else
            cell.isFreeFalling = false
            world[x][y] = cell
        end
    end
end

function rules.water(cell, x, y)
    if world[x][y - 1].type == "gas" then
        check_neighbours(x, y)
        swap_elements(x, y, x, y - 1)
    elseif cell.flowdir == "left" then
        if world[x - 1][y].type == "gas" then
            swap_elements(x, y, x - 1, y)
        elseif world[x - 1][y].type ~= "gas" then
            world[x][y].flowdir = "right"
        end
    elseif cell.flowdir == "right" then
        if world[x + 1][y].type == "gas" then
            swap_elements(x, y, x + 1, y)
        elseif world[x + 1][y].type ~= "gas" then
            world[x][y].flowdir = "left"
        end
    end
end

function check_neighbours(x, y)
    if world[x - 1][y].type == "movable" then
        world[x - 1][y].isFreeFalling = true
    end
    if world[x + 1][y].type == "movable" then
        world[x + 1][y].isFreeFalling = true
    end
    if world[x - 1][y - 1].type == "movable" then
        world[x - 1][y - 1].isFreeFalling = true
    end
    if world[x + 1][y - 1].type == "movable" then
        world[x + 1][y - 1].isFreeFalling = true
    end
    if world[x][y - 1].type == "movable" then
        world[x][y - 1].isFreeFalling = true
    end
    if world[x - 1][y + 1].type == "movable" then
        world[x - 1][y + 1].isFreeFalling = true
    end
    if world[x + 1][y + 1].type == "movable" then
        world[x + 1][y + 1].isFreeFalling = true
    end
    if world[x][y + 1].type == "movable" then
        world[x][y + 1].isFreeFalling = true
    end
end

function swap_elements(x, y, t_x, t_y)
    local e = world[x][y]
    local t_e = world[t_x][t_y]
    world[x][y] = t_e
    world[t_x][t_y] = e
end