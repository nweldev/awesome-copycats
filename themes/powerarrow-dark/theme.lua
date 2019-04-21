--[[

     Powerarrow Dark Awesome WM theme
     github.com/lcpz

--]]
local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme = {}
theme.dir = os.getenv("HOME") .. "/.config/awesome/copycats/themes/powerarrow-dark"
theme.wallpaper = theme.dir .. "/spitzer-dr21-midIR.jpg"
theme.font = "Fira Code 9"
theme.fg_normal = "#DDDDFF"
theme.fg_focus = "#f44336"
theme.fg_urgent = "#FF0000"
theme.bg_normal = "#1A1A1A"
theme.bg_focus = "#313131"
theme.bg_urgent = "#1A1A1A"
theme.border_width = dpi(1)
theme.border_normal = "#3F3F3F"
theme.border_focus = "#7F7F7F"
theme.border_marked = "#CC9393"
theme.tasklist_bg_focus = "#1A1A1A"
theme.titlebar_bg_focus = theme.bg_focus
theme.titlebar_bg_normal = theme.bg_normal
theme.titlebar_fg_focus = theme.fg_focus
theme.menu_height = dpi(16)
theme.menu_width = dpi(140)
theme.menu_submenu_icon = theme.dir .. "/icons/submenu.png"
theme.taglist_squares_sel = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile = theme.dir .. "/icons/tile.png"
theme.layout_tileleft = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv = theme.dir .. "/icons/fairv.png"
theme.layout_fairh = theme.dir .. "/icons/fairh.png"
theme.layout_spiral = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle = theme.dir .. "/icons/dwindle.png"
theme.layout_max = theme.dir .. "/icons/max.png"
theme.layout_fullscreen = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier = theme.dir .. "/icons/magnifier.png"
theme.layout_floating = theme.dir .. "/icons/floating.png"
theme.widget_ac = theme.dir .. "/icons/ac.png"
theme.widget_battery = theme.dir .. "/icons/battery.png"
theme.widget_battery_low = theme.dir .. "/icons/battery_low.png"
theme.widget_battery_empty = theme.dir .. "/icons/battery_empty.png"
theme.widget_mem = theme.dir .. "/icons/mem.png"
theme.widget_cpu = theme.dir .. "/icons/cpu.png"
theme.widget_temp = theme.dir .. "/icons/temp.png"
theme.widget_net = theme.dir .. "/icons/net.png"
theme.widget_net0 = theme.dir .. "/icons/net_0.png"
theme.widget_net1 = theme.dir .. "/icons/net_1.png"
theme.widget_net2 = theme.dir .. "/icons/net_2.png"
theme.widget_net3 = theme.dir .. "/icons/net_3.png"
theme.widget_net4 = theme.dir .. "/icons/net_4.png"
theme.widget_hdd = theme.dir .. "/icons/hdd.png"
theme.widget_music = theme.dir .. "/icons/note.png"
theme.widget_music_on = theme.dir .. "/icons/note_on.png"
theme.widget_vol = theme.dir .. "/icons/vol.png"
theme.widget_vol_low = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute = theme.dir .. "/icons/vol_mute.png"
theme.widget_mail = theme.dir .. "/icons/mail.png"
theme.widget_mail_on = theme.dir .. "/icons/mail_on.png"
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon = true
theme.useless_gap = dpi(0)
theme.titlebar_close_button_focus = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

local markup = lain.util.markup
local separators = lain.util.separators

local keyboardlayout = awful.widget.keyboardlayout:new()

-- Textclock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local clock =
  awful.widget.watch(
  "date +'%a %d %b %R'",
  60,
  function(widget, stdout)
    widget:set_markup(" " .. markup.font(theme.font, stdout))
  end
)

-- Calendar
theme.cal =
  lain.widget.cal(
  {
    attach_to = {clock},
    notification_preset = {
      font = "Fira Code 9",
      fg = theme.fg_normal,
      bg = theme.bg_normal
    }
  }
)

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_battery)
local bat =
  lain.widget.bat(
  {
    settings = function()
      if bat_now.status and bat_now.status ~= "N/A" then
        if bat_now.ac_status == 1 then
          baticon:set_image(theme.widget_ac)
        elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
          baticon:set_image(theme.widget_battery_empty)
        elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
          baticon:set_image(theme.widget_battery_low)
        else
          baticon:set_image(theme.widget_battery)
        end
        widget:set_markup(markup.font(theme.font, " " .. bat_now.perc .. "% "))
      else
        widget:set_markup(markup.font(theme.font, " AC "))
        baticon:set_image(theme.widget_ac)
      end
    end
  }
)

-- ALSA volume
local volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume =
  lain.widget.alsa(
  {
    settings = function()
      if volume_now.status == "off" then
        volicon:set_image(theme.widget_vol_mute)
      elseif tonumber(volume_now.level) == 0 then
        volicon:set_image(theme.widget_vol_no)
      elseif tonumber(volume_now.level) <= 50 then
        volicon:set_image(theme.widget_vol_low)
      else
        volicon:set_image(theme.widget_vol)
      end

      widget:set_markup(markup.font(theme.font, " " .. volume_now.level .. "% "))
    end
  }
)

-- Net
-- local neticon = wibox.widget.imagebox(theme.widget_net)
--[[ local net = lain.widget.net({
    settings = function()
        widget:set_markup(markup.font(theme.font,
                          markup("#7AC82E", " " .. string.format("%06.1f", net_now.received))
                          .. " " ..
                          markup("#46A8C3", " " .. string.format("%06.1f", net_now.sent) .. " ")))
    end
}) ]]
local wifi_icon = wibox.widget.imagebox(theme.widget_net)
-- local eth_icon = wibox.widget.imagebox()
local net =
  lain.widget.net {
  notify = "on",
  wifi_state = "on",
  eth_state = "off",
  settings = function()
    --[[         local eth0 = net_now.devices.eth0
        if eth0 then
            if eth0.ethernet then
                eth_icon:set_image(ethernet_icon_filename)
            else
                eth_icon:set_image()
            end
        end ]]
    local wlan0 = net_now.devices.wlp2s0
    if wlan0 then
      if wlan0.wifi then
        local signal = wlan0.signal
        if signal < -83 then
          wifi_icon:set_image(theme.widget_net0)
        elseif signal < -70 then
          wifi_icon:set_image(theme.widget_net1)
        elseif signal < -53 then
          wifi_icon:set_image(theme.widget_net2)
        elseif signal >= -53 then
          wifi_icon:set_image(theme.widget_net3)
        end
      else
        wifi_icon:set_image()
      end
    end
  end
}

-- Separators
local spr = wibox.widget.textbox(" ")
local arrl_dl = separators.arrow_left(theme.bg_focus, "alpha")
local arrl_ld = separators.arrow_left("alpha", theme.bg_focus)

function theme.at_screen_connect(s)
  -- Quake application
  s.quake = lain.util.quake({app = awful.util.terminal})

  -- If wallpaper is a function, call it with the screen
  local wallpaper = theme.wallpaper
  if type(wallpaper) == "function" then
    wallpaper = wallpaper(s)
  end
  gears.wallpaper.centered(wallpaper)

  -- Tags
  awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contains an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(
    my_table.join(
      awful.button(
        {},
        1,
        function()
          awful.layout.inc(1)
        end
      ),
      awful.button(
        {},
        2,
        function()
          awful.layout.set(awful.layout.layouts[1])
        end
      ),
      awful.button(
        {},
        3,
        function()
          awful.layout.inc(-1)
        end
      ),
      awful.button(
        {},
        4,
        function()
          awful.layout.inc(1)
        end
      ),
      awful.button(
        {},
        5,
        function()
          awful.layout.inc(-1)
        end
      )
    )
  )
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

  -- Create the wibox
  s.mywibox = awful.wibar({position = "top", screen = s, height = dpi(18), bg = theme.bg_normal, fg = theme.fg_normal})

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    {
      -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      --spr,
      s.mytaglist,
      s.mypromptbox,
      spr
    },
    s.mytasklist, -- Middle widget
    {
      -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      wibox.widget.systray(),
      keyboardlayout,
      spr,
      arrl_ld,
      -- wibox.container.background(mpdicon, theme.bg_focus),
      -- wibox.container.background(theme.mpd.widget, theme.bg_focus),
      -- arrl_dl,
      wibox.container.background(volicon, theme.bg_focus),
      wibox.container.background(theme.volume.widget, theme.bg_focus),
      -- arrl_ld,
      -- wibox.container.background(mailicon, theme.bg_focus),
      --wibox.container.background(theme.mail.widget, theme.bg_focus),
      -- arrl_dl,
      -- memicon,
      -- mem.widget,
      -- arrl_ld,
      -- wibox.container.background(cpuicon, theme.bg_focus),
      -- wibox.container.background(cpu.widget, theme.bg_focus),
      -- arrl_dl,
      -- tempicon,
      -- temp.widget,
      -- arrl_ld,
      -- wibox.container.background(fsicon, theme.bg_focus),
      --wibox.container.background(theme.fs.widget, theme.bg_focus),
      arrl_dl,
      wifi_icon,
      net.widget,
      arrl_ld,
      wibox.container.background(baticon, theme.bg_focus),
      wibox.container.background(bat.widget, theme.bg_focus),
      arrl_dl,
      clock,
      spr,
      arrl_ld,
      wibox.container.background(s.mylayoutbox, theme.bg_focus)
    }
  }
end

return theme
