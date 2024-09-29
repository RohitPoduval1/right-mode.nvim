-- right-mode plugin configuration
local M = {}

-- User preferences
M.preferences = {
    light_themes = {},  -- Light themes to choose from during the day
    dark_themes = {},   -- Dark themes to choose from during the night
    day_start = 8,      -- Default start time for light theme (8 AM)
    night_start = 20,   -- Default start time for dark theme (8 PM)
}

-- Function to set user preferences
M.setup = function(opts)
    if opts.light_themes then
        M.preferences.light_themes = opts.light_themes
    end
    if opts.dark_themes then
        M.preferences.dark_themes = opts.dark_themes
    end
    if opts.day_start then
        M.preferences.day_start = opts.day_start
    end
    if opts.night_start then
        M.preferences.night_start = opts.night_start
    end

    -- Run the command upon loading Neovim
    vim.cmd([[autocmd VimEnter * lua require('right-mode').apply_theme()]])
end


-- The list of themes is assumed to be valid
local function select_random_theme(themes)
    return themes[math.random(#themes)]
end


local function get_installed_colorschemes()
    return vim.fn.getcompletion('', 'color')
end


-- Check if the theme is installed
local function theme_installed(theme)
    local installed_themes = get_installed_colorschemes()
    return vim.tbl_contains(installed_themes, theme)
end


-- Apply the correct theme based on the time
M.apply_theme = function()
    math.randomseed(os.time())
    local hour = tonumber(os.date("%H"))

    -- Determine whether to use light or dark themes based on the time
    local themes = M.preferences.light_themes
    if hour >= M.preferences.night_start or hour < M.preferences.day_start then
        themes = M.preferences.dark_themes
    end

    local selected_theme = select_random_theme(themes)

    if theme_installed(selected_theme) then
        vim.cmd("colorscheme " .. selected_theme)      -- apply the theme
        vim.notify("Applied " .. selected_theme)
    else
        vim.notify("Error: Theme " .. selected_theme .. " is not installed.")
    end
end

return M
