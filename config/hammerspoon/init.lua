local windowModifiers = {"ctrl", "option", "cmd"}
local wideWindowModifiers = {"cmd", "option"}

hs.window.animationDuration = 0.05

local function setFrame(onFrame)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  onFrame(f, max)
  win:setFrame(f)
end

hs.hotkey.bind(windowModifiers, "l", function()
  hs.caffeinate.startScreensaver()
end)


-- Example opening webview.
hs.hotkey.bind(windowModifiers, "z", function()
  local win = hs.window.focusedWindow()
  local screen = win:screen()
  local max = screen:frame()
  hs.webview.new(max):url("https://www.google.com"):transparent(true):show()
  hs.application.get("Hammerspoon"):activate()
end)

hs.hotkey.bind(windowModifiers, "Left", function()
  setFrame(function (f, max)
    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
  end);
end)

hs.hotkey.bind(windowModifiers, "Right", function()
  setFrame(function (f, max)
    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
  end);
end)

hs.hotkey.bind(windowModifiers, "Up", function()
  setFrame(function (f, max)
    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h / 2
  end);
end)

hs.hotkey.bind(windowModifiers, "Down", function()
  setFrame(function (f, max)
    f.x = max.x
    f.y = max.y + (max.h / 2)
    f.w = max.w
    f.h = max.h / 2
  end);
end)

hs.hotkey.bind(windowModifiers, "m", function()
  setFrame(function (f, max)
    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h
  end);
end)

-- 49 inch screen -> wide screen 3 way split.

hs.hotkey.bind(wideWindowModifiers, "Left", function()
  setFrame(function (f, max)
    f.x = max.x
    f.y = max.y
    f.w = max.w / 3
    f.h = max.h
  end);
end)

hs.hotkey.bind(wideWindowModifiers, "Down", function()
  setFrame(function (f, max)
    f.x = max.x + (max.w / 3)
    f.y = max.y
    f.w = max.w / 3
    f.h = max.h
  end);
end)

hs.hotkey.bind(wideWindowModifiers, "Right", function()
  setFrame(function (f, max)
    f.x = max.x + (max.w / 3) + (max.w / 3)
    f.y = max.y
    f.w = max.w / 3
    f.h = max.h
  end);
end)

-- Auto Clicker
hs.loadSpoon("AutoClick")
spoon.AutoClick.clicksPerSecond = 10

--- Start/Stop Autoclick
spoon.AutoClick:bindHotkeys({ triggerAutoClick = {windowModifiers, "C"} })