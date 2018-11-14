local hyper = {"ctrl", "cmd", "shift", "alt"}
local frameCache = {}

launch = function(appname)
  hs.application.launchOrFocus(appname)
end

-- Single keybinding for app launch
singleapps = {
  {'q', 'Microsoft Outlook'},
  {'d', 'iTerm'},
  {'space', 'Sublime Text'},
  {'e', 'Google Chrome'},
  {'c', 'IntelliJ IDEA CE'},
  {'s', 'Skype for Business'}
}

for i, app in ipairs(singleapps) do
  hs.hotkey.bind(hyper, app[1], function() launch(app[2]); end)  
end

-- Window maximization
function toggleMaximized()
   local win = hs.window.focusedWindow()
   if (win == nil) or (win:id() == nil) then
      return
   end
   if frameCache[win:id()] then
      win:setFrame(frameCache[win:id()])
      frameCache[win:id()] = nil
   else
      frameCache[win:id()] = win:frame()
      win:maximize()
   end
end

-- Move current window to a different screen
function moveCurrentWindowToScreen(how)
   local win = hs.window.focusedWindow()
   local fullScreen = win:isFullScreen()
   if win == nil then
      return
   end
   if(fullScreen) then
     win:toggleFullScreen()
     hs.timer.doAfter(0.7, function() moveWindowToScreen(how,win) end)
     hs.timer.doAfter(1.0,function() win:toggleFullScreen() end)
   else
     moveWindowToScreen(how,win)
   end

end

function oneScreenLeft()
   moveCurrentWindowToScreen("left")
end

function oneScreenRight()
   moveCurrentWindowToScreen("right")
end

function moveWindowToScreen(how,win)
  hs.window.setFrameCorrectness = true
  if how == "left" then
     win:moveOneScreenWest()
  elseif how == "right" then
     win:moveOneScreenEast()
  end
  hs.window.setFrameCorrectness = false
end

hs.hotkey.bind(hyper, '-', function() oneScreenLeft(); end)
hs.hotkey.bind(hyper, '=', function() oneScreenRight(); end)
hs.hotkey.bind(hyper, '0', function() toggleMaximized(); end)
