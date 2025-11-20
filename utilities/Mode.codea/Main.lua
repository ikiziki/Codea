-- Modern

function setup()
end


function draw()
  -- 2.0 = dark mode
  -- 1.0 = light mode
  mode = objc.viewer.view.window.screen.traitCollection.userInterfaceStyle
  print(mode)
end

