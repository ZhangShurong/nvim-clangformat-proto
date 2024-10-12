local M = {}

function M.format()
	print("Starting the formatting process...")

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

	print("Configuration file created at: " .. path)
	print("Executing clang-format...")

	vim.api.nvim_command("silent %!clang-format --style=" .. path)

	if vim.v.shell_error ~= 0 then
		print("Error during formatting.")
	else
		print("Formatting completed successfully.")
	end

	vim.fn.delete(path)
	print("Temporary files cleaned up.")
end

return M
