local M = {}

function M.compile_and_run()
  local filetype = vim.bo.filetype
  local filename = vim.fn.expand("%")
  local basename = vim.fn.expand("%:r")

  if filetype == "cpp" then
    vim.cmd("w")
    vim.cmd('vsp term://pwsh -c "g++ ' .. filename .. " -o " .. basename .. " && ./" .. basename .. '"')
  elseif filetype == "java" then
    vim.cmd("w")
    vim.cmd('vsp term://pwsh -c "javac ' .. filename .. " && java " .. basename .. '"')
  elseif filetype == "go" then
    vim.cmd("w")
    vim.cmd('vsp term://pwsh -c "go run ' .. filename .. '"')
  else
    print("Unsupported filetype: " .. filetype)
  end
end

return M
