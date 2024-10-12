local M = {}

function M.format()
  local clang_format_config = [[
{
    Language: Proto,
    BasedOnStyle: Google,
    AlignConsecutiveAssignments: true,
    AllowShortFunctionsOnASingleLine: None
}
]]

  local path = vim.fn.tempname() .. ".clang-format"
  vim.fn.writefile(vim.split(clang_format_config, "\n"), path)

  vim.api.nvim_command("silent %!clang-format --style=" .. path)
  vim.fn.delete(path)
end

return M
