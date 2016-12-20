-- Extensions =============================================

local fnutils = require 'hs.fnutils'
local appfinder = require 'hs.appfinder'
local application = require 'hs.application'
local applescript = require 'hs.applescript'

-- Setup ==================================================

hs.window.animationDuration = 0;

-- Aliases ================================================

hyper = { 'cmd', 'alt', 'ctrl' }
keyMap = { activateAudirvanaPlus = 'A', resizeWindowBottomLeft = 'B', activateSafari = 'C',
           activateCalendar = 'D', caffeinate = 'E', activateFinder = 'F', toggleWindowFullscreen = 'G',
           resizeWindowLeft = 'H', activateSpotify = 'I', resizeWindowBottom = 'J', resizeWindowTop = 'K',
           resizeWindowRight = 'L', activateMail = 'M', activateMessages = 'N', activateOmniFocus = 'O',
           resizeWindowTopRight = 'P', activatePreview = 'R', activateSublimeText = 'S', activateiTerm = 'T',
           resizeWindowMaximize = 'U', activateChrome = 'V', activateTower = 'W', lockScreen = 'X',
           resizeWindowTopLeft = 'Y', activateFranz = 'Z', resizeWindowBottomRight = '.' }

-- Helpers ================================================

function maxScreenFrame(screen)
  local max = screen:frame()

  if max.x == 4 then
    max.x = 0
    max.w = max.w + 4
  end

  --local menuBarHeight = 23
  --if hs.screen.mainScreen():fullFrame().h - menuBarHeight - max.h == 4 then
    --max.h = max.h + 4
  --end

  return max
end

function isWindowAlmostMaximized(window)
  local windowFrame = window:frame()
  local screenFrame = maxScreenFrame(window:screen())

  local isWidthAlmostMaximized  = screenFrame.w - windowFrame.w <= 80
  local isHeightAlmostMaximized = screenFrame.h - windowFrame.h <= 40

  return {isWidthAlmostMaximized, isHeightAlmostMaximized}
end

function setWindowFrame(window, windowFramer)
  if window == nil then return end

  local screenFrame = maxScreenFrame(window:screen())
  local windowFrame = windowFramer(screenFrame, window:frame())

  window:setFrame(windowFrame)
end

function maximizeWindow(window, maximizeWidth, maximizeHeight)
  setWindowFrame(window, function(screenFrame, windowFrame)
    return hs.geometry.rect(maximizeWidth  and screenFrame.x or windowFrame.x,
                            maximizeHeight and screenFrame.y or windowFrame.y,
                            maximizeWidth  and screenFrame.w or windowFrame.w,
                            maximizeHeight and screenFrame.h or windowFrame.h)
  end)
end

-- Shortcuts ==============================================

-- Shortcuts for resizing =======================

-- Maximize window
hs.hotkey.bind(hyper, keyMap['resizeWindowMaximize'], function()
  maximizeWindow(hs.window.focusedWindow(), true, true)
end)

-- Resize window to left half of screen
hs.hotkey.bind(hyper, keyMap['resizeWindowLeft'], function()
  setWindowFrame(hs.window.focusedWindow(), function(screenFrame)
    return hs.geometry.rect(screenFrame.x, screenFrame.y, screenFrame.w / 2, screenFrame.h)
  end)
end)

-- Resize window to bottom half of screen
hs.hotkey.bind(hyper, keyMap['resizeWindowBottom'], function()
  setWindowFrame(hs.window.focusedWindow(), function(screenFrame)
    return hs.geometry.rect(screenFrame.x, screenFrame.y + screenFrame.h / 2, screenFrame.w, screenFrame.h / 2)
  end)
end)

-- Resize window to top half of screen
hs.hotkey.bind(hyper, keyMap['resizeWindowTop'], function()
  setWindowFrame(hs.window.focusedWindow(), function(screenFrame)
    return hs.geometry.rect(screenFrame.x, screenFrame.y, screenFrame.w, screenFrame.h / 2)
  end)
end)

-- Resize window to right half of screen
hs.hotkey.bind(hyper, keyMap['resizeWindowRight'], function()
  setWindowFrame(hs.window.focusedWindow(), function(screenFrame)
    return hs.geometry.rect(screenFrame.x + screenFrame.w / 2, screenFrame.y, screenFrame.w / 2, screenFrame.h)
  end)
end)

-- Resize window to top left quadrant of screen
hs.hotkey.bind(hyper, keyMap['resizeWindowTopLeft'], function()
  setWindowFrame(hs.window.focusedWindow(), function(screenFrame)
    return hs.geometry.rect(screenFrame.x, screenFrame.y, screenFrame.w / 2, screenFrame.h / 2)
  end)
end)

-- Resize window to top right quadrant of screen
hs.hotkey.bind(hyper, keyMap['resizeWindowTopRight'], function()
  setWindowFrame(hs.window.focusedWindow(), function(screenFrame)
    return hs.geometry.rect(screenFrame.x + screenFrame.w / 2, screenFrame.y, screenFrame.w / 2, screenFrame.h / 2)
  end)
end)

-- Resize window to bottom right quadrant of screen
hs.hotkey.bind(hyper, keyMap['resizeWindowBottomRight'], function()
  setWindowFrame(hs.window.focusedWindow(), function(screenFrame)
    return hs.geometry.rect(screenFrame.x + screenFrame.w / 2, screenFrame.y + screenFrame.h / 2, screenFrame.w / 2,
                            screenFrame.h / 2)
  end)
end)

-- Resize window to bottom left quadrant of screen
hs.hotkey.bind(hyper, keyMap['resizeWindowBottomLeft'], function()
  setWindowFrame(hs.window.focusedWindow(), function(screenFrame)
    return hs.geometry.rect(screenFrame.x, screenFrame.y + screenFrame.h / 2, screenFrame.w / 2, screenFrame.h / 2)
  end)
end)

-- Toggle window fullscreen
hs.hotkey.bind(hyper, keyMap['toggleWindowFullscreen'], function()
  hs.window.focusedWindow():toggleFullscreen()
end)

-- Resize window to alert position
--hs.hotkey.bind(hyper, keyMap['resizeWindowAlert'], function()
--  setWindowFrame(hs.window.focusedWindow(), function(screenFrame)
--    width = screenFrame.w * 0.91
--    height = screenFrame.h * 0.91
--    return hs.geometry.rect(screenFrame.w / 2 - width / 2, screenFrame.h / 2 - height / 2 + 22 - 14, width, height)
--  end)
--end)

-- Launch and focus applications ================

fnutils.each({
  { key = keyMap['activateFinder'], app = 'Finder' },
  { key = keyMap['activateSafari'], app = 'Safari' },
  { key = keyMap['activateSublimeText'], app = 'Sublime Text' },
  { key = keyMap['activateiTerm'], app = 'iTerm' },
  { key = keyMap['activateMail'], app = 'Mail' },
  { key = keyMap['activateFranz'], app = 'Franz' },
  { key = keyMap['activateOmniFocus'], app = 'OmniFocus' },
  { key = keyMap['activateAudirvanaPlus'], app = 'Audirvana Plus'},
  { key = keyMap['activateTower'], app = 'Tower' },
  { key = keyMap['activateMessages'], app = 'Messages' },
  { key = keyMap['activateCalendar'], app = 'Calendar' },
  { key = keyMap['activateSpotify'], app = 'Spotify' },
  { key = keyMap['activatePreview'], app = 'Preview' },
  { key = keyMap['activateChrome'], app = 'Google Chrome' }
}, function(object)
  hs.hotkey.bind(hyper, object.key, function()
    hs.application.launchOrFocus(object.app)
  end)
end)

-- Lock screen ==================================

hs.hotkey.bind(hyper, keyMap['lockScreen'], function()
  hs.caffeinate.lockScreen()
end)

-- Caffeinate ===================================

hs.hotkey.bind(hyper, keyMap['caffeinate'], nil, function()
  if hs.caffeinate.toggle("displayIdle") then
        hs.alert.show('Caffeinate enabled')
    else
        hs.alert.show('Caffeinate disabled')
    end
end)

-- Watchers ===============================================

-- hs.uielement.watcher.windowCreated

application.watcher.new(function(app, event, appObject)
  local window = appObject:focusedWindow()
  if window == nil then return end

  local almostMaximized = isWindowAlmostMaximized(window)
  maximizeWindow(window, almostMaximized[1], almostMaximized[2])
end):start()
