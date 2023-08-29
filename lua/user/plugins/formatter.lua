return {
	{
		"mhartington/formatter.nvim",
		config = function()
			require("user.config.formatter")
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			require("user.config.formatter.tool_installer") -- require your null-ls config here (example below)
		end,
	},
}
