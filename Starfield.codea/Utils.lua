-- helper utilities

-- globals to store background color (B) and style mode (S)
B = nil
S = nil

-- returns the current iOS interface style:
-- 1.0 = light mode, 2.0 = dark mode
function probeStyle()
  return objc.viewer.view.window.screen.traitCollection.userInterfaceStyle
end

-- sets background color B based on style S
function setBG()
  if S == 1.0 then
    -- light mode background
    B = color(235)
  elseif S == 2.0 then
    -- dark mode background
    B = color(35)
  end
end

-- detects interface style, stores it in S, updates background,
-- and forces the viewer into fullscreen mode
function setStyle()
  viewer.mode = FULLSCREEN
  S = probeStyle()
  setBG()
end