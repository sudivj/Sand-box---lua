require("src/rules")
require("src/world")

ticks = 0

function love.load()
    mouse = {}
    mouse.x = 0
    mouse.y = 0
    canvas = sand()
    canvas_id = 1
    play = true
    quit = false

    print("\n> Initializing world...")
    init_world()
    print("- Running...")
end

function love.update(dt)
    ticks = ticks + 0.1
    mouse.x = love.mouse.getX()
    cursor.x = math.floor(mouse.x / cursor.width) * cursor.width
    cursor.index_x = cursor.x / cursor.width
    mouse.y = love.mouse.getY() 
    cursor.y = math.floor(mouse.y / cursor.height) * cursor.height
    cursor.index_y = cursor.y / cursor.height
    if love.mouse.isDown(1) then
        ticks = 0
        set_canvas()
        world[cursor.index_x + 2][SCREENHEIGHT - cursor.index_y - 1] = canvas
    end
end

function love.draw()
    if play then
        check_world()
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(mouse.x, 0)
        love.graphics.print(mouse.y, 50)
        love.graphics.print(cursor.x, 0, 10)
        love.graphics.print(cursor.y, 50, 10)
        love.graphics.print(cursor.index_x, 0, 20)
        love.graphics.print(cursor.index_y, 50, 20)
        love.graphics.print("elements - "..dots, 0, 40)
        love.graphics.rectangle("line", cursor.x, cursor.y, cursor.width, cursor.height)
        love.graphics.setColor(0, 1, 0)
        love.graphics.print("s - sand\nw - water\nr - rock\nc - clear\na - clear world\nq - quit", SCREEN_X - 100, 0)
    else
        if quit then
            draw_world()
            love.graphics.setColor(1, 1, 1)
            love.graphics.print("You sure you want to quit?", (SCREEN_X / 2) - 100, (SCREEN_Y / 2) - 100)
            love.graphics.setColor(0, 1, 0)
            love.graphics.print("Yes - y", (SCREEN_X / 2) - 100, (SCREEN_Y / 2) - 80)
            if love.keyboard.isDown("y") then
                print("< Exiting game.")
                love.event.quit()
            elseif love.keyboard.isDown("n") then
                quit = false
                play = true
            end
            love.graphics.setColor(1, 0, 0)
            love.graphics.print("No - n", (SCREEN_X / 2) - 100, (SCREEN_Y / 2) - 60)
        else
            draw_world()
            love.graphics.setColor(1, 1, 1)
            love.graphics.print("You sure you want to clear world?", (SCREEN_X / 2) - 100, (SCREEN_Y / 2) - 100)
            love.graphics.setColor(0, 1, 0)
            love.graphics.print("Yes - y", (SCREEN_X / 2) - 100, (SCREEN_Y / 2) - 80)
            if love.keyboard.isDown("y") then
                init_world()
                play = true
            elseif love.keyboard.isDown("n") then
                play = true
            end
            love.graphics.setColor(1, 0, 0)
            love.graphics.print("No - n", (SCREEN_X / 2) - 100, (SCREEN_Y / 2) - 60)
        end
    end
end

function set_canvas()
    if canvas_id == 0 then
        canvas = air()
    end
    if canvas_id == 1 then
        canvas = sand()
    end
    if canvas_id == 2 then
        canvas = water()
    end
    if canvas_id == 3 then
        canvas = stone()
    end
end

function love.keypressed(key, scancode, isrepeat)
    if key == "c" then
        canvas_id = 0
    end
    if key == "s" then
        canvas_id = 1
    end
    if key == "w" then
        canvas_id = 2
    end
    if key == "r" then
        canvas_id = 3
    end
    if key == "a" then
        play = false
    end
    if key == "q" then
        quit = true
        play = false
    end
end