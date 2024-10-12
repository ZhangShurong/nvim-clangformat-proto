local M = {}
local log = vim.log.levels

function M.debug_info(message)
	vim.api.nvim_echo({ { message, "Info" } }, true, {})
end
function M.format()
	M.debug_info("Starting the formatting process...")

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

	M.debug_info("Configuration file created at: " .. path)
	M.debug_info("Executing clang-format...")

	--vim.api.nvim_command("silent %!clang-format --style=" .. path)
	vim.api.nvim_command('silent %!clang-format --style="' .. path .. '"')

	if vim.v.shell_error ~= 0 then
		M.debug_info("Error during formatting.")
	else
		M.debug_info("Formatting completed successfully.")
	end

	vim.fn.delete(path)
	M.debug_info("Temporary files cleaned up.")
end

return M
