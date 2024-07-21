local element_colors = {
    ["sand"] = {
        {226, 216, 168}, {226, 223, 190}, {199, 190, 141}, {214, 207, 152}
    },
    ["water"] = {
        {135, 196, 255}, {57, 167, 255}
    },
    ["stone"] = {
        {105, 105, 105}, {129, 133, 137}, {137, 148, 153}
    }
}

function sand()
    local colors = #element_colors["sand"]
    return {
        ["id"] = 1,
        ["type"] = "movable",
        ["isFreeFalling"] = true,
        ["color"] = element_colors["sand"][math.random(colors)]
    }
end

function water()
    local colors = #element_colors["water"]
    local ran = math.random(2)
    local dir
    if ran == 1 then
        dir = "right"
    elseif ran == 2 then
        dir = "left"
    end
    return {
        ["id"] = 2,
        ["type"] = "fluid",
        ["isFreeFalling"] = true,
        ["flowdir"] = dir,
        ["color"] = element_colors["water"][math.random(colors)]
    }
end

function air() 
    return {
        ["type"] = "gas",
        ["id"] = 0
    } 
end

function stone()
    local colors = #element_colors["stone"]
    return {
        ["id"] = 3,
        ["type"] = "stationary",
        ["color"] = element_colors["stone"][math.random(colors)]}
end
