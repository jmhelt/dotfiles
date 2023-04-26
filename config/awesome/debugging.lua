local M = {}

-- time to load with a start and end time ms
M.start_time = os.clock()

M.load_time = function(line)
  local diff = os.clock() - M.start_time
  local msg = string.format("%s: Loaded in %.2f seconds", line, diff)
  M.start_time = os.clock()
  return msg
end

return M
