local M = {}

local installed_themes = {}

-- User preferences
M.preferences = {
	light_themes = {}, -- Light themes to choose from during the day
	dark_themes = {}, -- Dark themes to choose from during the night
	day_start = 8, -- Default start time for light theme (8 AM)
	night_start = 20, -- Default start time for dark theme (8 PM)
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

	installed_themes = vim.fn.getcompletion("", "color")

	-- If light_themes or dark_themes is empty, choose a random colorscheme to apply for that mode
	if vim.tbl_isempty(M.preferences.light_themes) then
		vim.notify("right-mode: No light themes provided, using installed themes instead.")
		M.preferences.light_themes = installed_themes
	end
	if vim.tbl_isempty(M.preferences.dark_themes) then
		vim.notify("right-mode: No dark themes provided, using installed themes instead.")
		M.preferences.dark_themes = installed_themes
	end

	-- Set the autocmd here
	vim.cmd([[autocmd VimEnter * ++nested lua require('right-mode').apply_theme()]])
end

-- Return a random theme from a given list of valid themes
local function select_random_theme(themes)
	return themes[math.random(#themes)]
end

-- Check if the theme is installed
local function theme_installed(theme)
	return vim.tbl_contains(vim.fn.getcompletion("", "color"), theme)
end

-- Apply the correct theme based on the time
M.apply_theme = function()
	math.randomseed(os.time())
	local hour = tonumber(os.date("%H"))

	-- Determine whether to use light or dark themes based on the time
	local theme_choices = M.preferences.light_themes
	if hour >= M.preferences.night_start or hour < M.preferences.day_start then
		theme_choices = M.preferences.dark_themes
	end

	local selected_theme = select_random_theme(theme_choices)

	if theme_installed(selected_theme) then
		vim.cmd("colorscheme " .. selected_theme)
		vim.cmd("doautocmd ColorScheme") -- Ensure highlights are reapplied
		vim.cmd("redraw") -- Force UI redraw
		vim.notify("right-mode: Applied " .. selected_theme)
	else
		vim.notify("right-mode: Error: Theme " .. selected_theme .. " is not installed.")
	end
end

return M
