local resize = {}

local function isIterm(win)
  return (win:application():title() == 'iTerm2')
end

local function frameForUnit(baseframe, unit)
  return {
    x = baseframe.x + (unit.x * baseframe.w),
    y = baseframe.y + (unit.y * baseframe.h),
    w = unit.w * baseframe.w,
    h = unit.h * baseframe.h,
  }
end

local function setUnit(unit)
  local win = hs.window.focusedWindow()
  if win == nil then return end
  if isIterm(win) and not win:isStandard() then return end

  local screenframe = win:screen():frame()
  local expected = frameForUnit(screenframe, unit)
  win:setFrame(expected, 0)
  local updated = win:frame()

  local justified = win:frame()

  if expected.w ~= updated.w then
    justified.x = expected.x + (expected.w - updated.w) / 2
  end
  if expected.h ~= updated.h then
    justified.y = expected.y + (expected.h - updated.h) / 2
    if justified.y + justified.h > screenframe.h then
      justified.y = screenframe.h + screenframe.y - justified.h
    end
  end

  if justified.x ~= updated.x or justified.h ~= updated.h then
    win:setFrame(justified, 0)
  end
end

local units = {
  -- Quadrants
  topleft       = { x=0,   y=0,    w=0.5, h=0.5 },
  topright      = { x=0.5, y=0,    w=0.5, h=0.5 },
  bottomleft    = { x=0,   y=0.5,  w=0.5, h=0.5 },
  bottomright   = { x=0.5, y=0.5,  w=0.5, h=0.5 },
  -- Halves
  right         = { x=0.5, y=0,    w=0.5, h=1   },
  left          = { x=0,   y=0,    w=0.5, h=1   },
  top           = { x=0,   y=0,    w=1,   h=0.5 },
  bottom        = { x=0,   y=0.5,  w=1,   h=0.5 },
  -- Fullscreen
  full          = { x=0,   y=0,    w=1,   h=1   },
  -- Fit
  fitVertical   = { x=0,   y=0.25, w=1,   h=0.6 },
  fitHorizontal = { x=0.2, y=0,    w=0.6, h=1   }
}
for name,unit in pairs(units) do
  resize[name] = function() setUnit(unit) end
end

function resize.touch(direction)
  local win = hs.window.focusedWindow()
  if win == nil then return end
  local f = win:frame()
  if     direction == 'left' then
    f.x = f.x - 1
  elseif direction == 'right' then
    f.x = f.x + 1
  elseif direction == 'up' then
    f.y = f.y - 1
  elseif direction == 'down' then
    f.y = f.y + 1
  end
  win:setFrame(f, 0)
end

function resize.center()
  local win = hs.window.focusedWindow()
  if win == nil then return end
  local baseframe = win:screen():fullFrame()
  local f = win:frame()
  f.x = baseframe.x + ((baseframe.w / 2) - (f.w / 2))
  f.y = baseframe.y + ((baseframe.h / 2) - (f.h / 2))
  win:setFrame(f, 0)
end

function resize.changeScreen()
  local win = hs.window.focusedWindow()
  if win == nil then return end
  local current = win:screen()
  if current == nil then return end
  local next = current:next()
  if current:id() == next:id() then return end

  local win = hs.window.focusedWindow()
  if isIterm(win) and not win:isStandard() then
    win:toggleFullScreen()
  end

  local win = hs.window.focusedWindow()
  win:setFrame(next:fullFrame(), 0)

  local win = hs.window.focusedWindow()
  if isIterm(win) and win:isStandard() then
    win:toggleFullScreen()
  else
    resize.center()
  end
end

return resize
