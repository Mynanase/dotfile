local wez = require "wezterm"
local config = {}
local act = wez.action

if wez.config_builder then
   config = wez.config_builder()
end

-- Appearances

config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = false
-- config.hide_tab_bar_if_only_one_tab = true
config.color_scheme = "Catppuccin Frappe"
config.font = wez.font 'JetBrains Mono'
config.font_size = 10
config.initial_cols = 100
config.initial_rows = 32


-- keybindings

local mod = {}
mod.SUPER = 'ALT'
mod.SUPER_REV = 'ALT|CTRL'
config.disable_default_key_bindings = true
config.leader = { key = 'Space', mods = mod.SUPER_REV, timeout_milliseconds = 2000 }

config.keys = {

   { key = 'LeftArrow',  mods = mod.SUPER,     action = act.SendString '\x1bOH' },
   { key = 'RightArrow', mods = mod.SUPER,     action = act.SendString '\x1bOF' },
   { key = 'Backspace',  mods = mod.SUPER,     action = act.SendString '\x15' },

   { key = 'c',          mods = 'CTRL',        action = act.CopyTo('Clipboard') },
   { key = 'v',          mods = 'CTRL',        action = act.PasteFrom('Clipboard') },

   { key = 't',          mods = mod.SUPER,     action = act.SpawnTab('DefaultDomain') },
   { key = 't',          mods = mod.SUPER_REV, action = act.SpawnTab({ DomainName = 'WSL:NixOS' }) },
   { key = 'w',          mods = mod.SUPER_REV, action = act.CloseCurrentTab({ confirm = false }) },

   { key = '[',          mods = mod.SUPER,     action = act.ActivateTabRelative(-1) },
   { key = ']',          mods = mod.SUPER,     action = act.ActivateTabRelative(1) },
   { key = '[',          mods = mod.SUPER_REV, action = act.MoveTabRelative(-1) },
   { key = ']',          mods = mod.SUPER_REV, action = act.MoveTabRelative(1) },

   { key = 'n',          mods = mod.SUPER,     action = act.SpawnWindow },

   -- splits panes
   {
      key = [[\]],
      mods = mod.SUPER,
      action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
   },
   {
      key = [[\]],
      mods = mod.SUPER_REV,
      action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
   },

   -- panes: zoom+close pane
   { key = 'Enter', mods = mod.SUPER,     action = act.TogglePaneZoomState },
   { key = 'w',     mods = mod.SUPER,     action = act.CloseCurrentPane({ confirm = false }) },

   -- panes: navigation
   { key = 'k',     mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Up') },
   { key = 'j',     mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Down') },
   { key = 'h',     mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Left') },
   { key = 'l',     mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Right') },

   -- show pane numbers
   {
      key = ',',
      mods = mod.SUPER_REV,
      action = act.PaneSelect({ alphabet = '1234567890', mode = 'SwapWithActiveKeepFocus' }),
   },

   -- key tables
   {
      key = 'f',
      mods = 'LEADER',
      action = act.ActivateKeyTable({
         name = 'resize_font',
         one_shot = false,
         timemout_miliseconds = 1000,
      }),
   },
   {
      key = 'p',
      mods = 'LEADER',
      action = act.ActivateKeyTable({
         name = 'resize_pane',
         one_shot = false,
         timemout_miliseconds = 1000,
      }),
   },
}

-- key tables

config.key_tables = {
   resize_font = {
      { key = 'k',      action = act.IncreaseFontSize },
      { key = 'j',      action = act.DecreaseFontSize },
      { key = 'r',      action = act.ResetFontSize },
      { key = 'Escape', action = 'PopKeyTable' },
      { key = 'q',      action = 'PopKeyTable' },
   },
   resize_pane = {
      { key = 'k',      action = act.AdjustPaneSize({ 'Up', 1 }) },
      { key = 'j',      action = act.AdjustPaneSize({ 'Down', 1 }) },
      { key = 'h',      action = act.AdjustPaneSize({ 'Left', 1 }) },
      { key = 'l',      action = act.AdjustPaneSize({ 'Right', 1 }) },
      { key = 'Escape', action = 'PopKeyTable' },
      { key = 'q',      action = 'PopKeyTable' },
   },
}

-- Ctrl-click will open the link under the mouse cursor
config.mouse_bindings = {

   {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = act.OpenLinkAtMouseCursor,
   },
}


-- Domains

config.wsl_domains = {
   {
      name = "WSL:NixOS",
      distribution = "NixOS",
      username = "kosmos",
   },
   {
      name = "WSL:Arch",
      distribution = "Arch",
      username = "kosmos",
   }
}


-- Launch

config.default_prog = { 'nu' }
config.launch_menu = {
   { label = 'PowerShell Core',    args = { 'pwsh', '-NoLogo' } },
   { label = 'PowerShell Desktop', args = { 'powershell', '--NoLogo' } },
   { label = 'Command Prompt',     args = { 'cmd' } },
   { label = 'Nushell',            args = { 'nu' } },
}

--
config.front_end = "WebGpu"





return config
