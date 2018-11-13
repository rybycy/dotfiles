local hyper = {"ctrl", "cmd", "shift", "alt"}

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

