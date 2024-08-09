local M = {}

function M.compile_and_run()
  local filetype = vim.bo.filetype
  local filename = vim.fn.expand("%")
  local basename = vim.fn.expand("%:r")

  if filetype == "cpp" then
    vim.cmd("w")
    vim.cmd(
      "vsp term://g++ -std=c++20 -Wshadow -Wall"
        .. filename
        .. " -o "
        .. basename
        .. "-O2 -Wno-unused-result && ./"
        .. basename
    )
  elseif filetype == "java" then
    vim.cmd("w")
    vim.cmd("vsp term://javac " .. filename .. " && java " .. basename)
  elseif filetype == "go" then
    vim.cmd("w")
    vim.cmd("vsp term://go run " .. filename)
  else
    print("Unsupported filetype: " .. filetype)
  end
end

return M
