local M = {}

-- Function to run a command in a terminal
local function run_in_terminal(cmd)
  -- Check if terminal is already open
  if vim.fn.bufexists("MyLazyVimTerminal") == 1 then
    vim.cmd('exec "normal! \\<C-\\>\\<C-n>\\<C-w>k"')
    vim.fn.chansend(vim.fn.bufnr("MyLazyVimTerminal"), cmd .. "\n")
  else
    -- Open a new terminal window
    vim.cmd("split term://pwsh")  -- Replace with 'bash' if not using PowerShell
    vim.cmd("resize 10")
    vim.cmd("setlocal nobuflisted bufhidden=wipe buftype=terminal")
    vim.cmd("file MyLazyVimTerminal")
    vim.fn.chansend(vim.fn.bufnr("MyLazyVimTerminal"), cmd .. "\n")
  end
end

-- Function to compile and run C++ code
function M.run_cpp()
  --local filetype = vim.bo.filetype
  local filename = vim.fn.expand("%")
  local basename = vim.fn.expand("%:r")
  
  local cmd = "g++ " .. filename .. " -o ".. basename "&& ./" .. basename
  run_in_terminal(cmd)
end

-- Function to compile and run Java code
function M.run_java()
  --local filetype = vim.bo.filetype
  local filename = vim.fn.expand("%")
  local basename = vim.fn.expand("%:r")
  
  -- local file = vim.fn.expand("%:t:r")
  local cmd = "javac " .. filename ..  "&& java " .. basename
  run_in_terminal(cmd)
end

-- Function to compile and run Go code
function M.run_go()
  --local filetype = vim.bo.filetype
  local filename = vim.fn.expand("%")
  --local basename = vim.fn.expand("%:r")
  
  -- local file = vim.fn.expand("%:p")
  local cmd = "go run " .. filename
  run_in_terminal(cmd)
end

-- Keybinds
vim.api.nvim_set_keymap('n', '<leader><f5>', ':lua require("compile_and_run").run_cpp()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rJ', ':lua require("compile_and_run").run_java()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rG', ':lua require("compile_and_run").run_go()<CR>', { noremap = true, silent = true })

return M
