# right-mode.nvim

# The Problem :(

When coding during the day, I don't want to crank up the brightness of my screen and drain my battery just to see the code I am writing so I use a light colorscheme. During the night, however, a light theme is too bright so I use a dark theme, but manually switching is annoying!

# The Solution :)

right-mode.nvim is the best of light mode and night mode, switching your colorscheme for you based on the time of day! As a bonus, since there are so many beautiful colorschemes, it will randomize the colorscheme for day and night based on the list you give it so you don't have to choose just one theme to use!

# Installation

<details>
    <summary>lazy.nvim</summary>

```lua
{
    "rohitpoduval1/right-mode.nvim",
    config = function()
        require("right-mode").setup({
            light_themes = { },
            dark_themes = { },
            day_start = 8, -- Light theme starting from 8 AM
            night_start = 20, -- Dark theme starting from 8 PM
        })
    end,
}
```

</details>

<details>
    <summary>packer.nvim</summary>

```lua
use {
  'rohitpoduval1/right-mode',
  config = function()
    require("right-mode").setup({
        light_themes = { },
        dark_themes = { },
        day_start = 8, -- Light theme starting from 8 AM
        night_start = 20, -- Dark theme starting from 8 PM
    })
}
```

</details>

<details>
    <summary>Pathogen</summary>

```
git clone --depth=1 https://github.com/rohitpoduval1/right-mode.git ~/.vim/bundle/
```

</details>

# Setup

It is highly recommended to call `right-mode.setup()` for the best experience, although the plugin will still work without it.

**Default Configuration**

```lua
require("right-mode").setup({
    light_themes = { }, -- Your desired colorschemes as strings separated by commas
    dark_themes = { },
    day_start = 8, -- Light theme starting from 8 AM
    night_start = 20, -- Dark theme starting from 8 PM
})
```

**Example Configuration**

```lua
require("right-mode").setup({
    light_themes = {"kanagawa-lotus", "catppuccin-latte" },
    dark_themes = { "kanagawa-dragon" },
    day_start = 8, -- Light theme starting from 8 AM
    night_start = 20, -- Dark theme starting from 8 PM
})
```

- right-mode will randomize from the given list of installed colorschemes starting light mode from `day_start` and starting night mode from `night_start`, both of which are in a 24 hour time format.
- If the arguments for `light_themes` and `dark_themes` are empty, right-mode will randomize from the list of installed colorschemes. (It is possible to have just 1 colorscheme in `light_themes` or `dark_themes` if you prefer)
