-- Name: announce
-- Description: Displays customized text on the center of the screen on command
-- Version: 1.2
-- Author: Dr_Dinnerbone

-- Define the mod namespace
local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

-- Default options
local defaultColor = "FFFFFF"
local defaultFont = "default"
local defaultSize = 14
local defaultDuration = 5

-- Function to display customized text on the center of the screen
local function displayCustomText(name, param)
    -- Extract color, font, size, duration, and text information from the parameters
    local color, font, size, duration, text = param:match("#([A-Fa-f0-9]+):(.-):(.-):(.-):(.-)$")
    
    -- Use default values if not specified
    color = color or defaultColor
    font = font or defaultFont
    size = tonumber(size) or defaultSize
    duration = tonumber(duration) or defaultDuration
    text = text or param
    
    -- Display the customized text on the center of the screen with fading
    minetest.display_chat_message({
        message = text,
        name = "",
        color = tonumber(color, 16), -- Convert hex color to decimal
        time = duration,
        font = { name = font, size = size },
    })
end

-- Register the new chat commands
minetest.register_chatcommand("announce", {
    params = "<text>",
    description = "Display customized text on the center of the screen",
    func = function(name, param)
        displayCustomText(name, "#" .. defaultColor .. ":" .. defaultFont .. ":" .. defaultSize .. ":" .. defaultDuration .. ":" .. param)
    end,
})

minetest.register_chatcommand("announce_colour", {
    params = "<colour>",
    description = "Set the color for the .announce command (hex format)",
    func = function(name, param)
        defaultColor = param
        minetest.chat_send_player(name, "Color set to #" .. defaultColor)
    end,
})

minetest.register_chatcommand("announce_duration", {
    params = "<duration>",
    description = "Set the default display duration for the .announce command",
    func = function(name, param)
        defaultDuration = tonumber(param) or defaultDuration
        minetest.chat_send_player(name, "Duration set to " .. defaultDuration .. " seconds")
    end,
})

minetest.register_chatcommand("announce_size", {
    params = "<size>",
    description = "Set the default font size for the .announce command",
    func = function(name, param)
        defaultSize = tonumber(param) or defaultSize
        minetest.chat_send_player(name, "Font size set to " .. defaultSize)
    end,
})

minetest.register_chatcommand("announce_font", {
    params = "<filepath/to/font>",
    description = "Set the default font file for the .announce command",
    func = function(name, param)
        defaultFont = param
        minetest.chat_send_player(name, "Font set to " .. defaultFont)
    end,
})
