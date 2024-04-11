local vue_language_server_path = "/usr/local/lib/@vue/typescript-plugin@2.0.12"

local lspconfig = require("lspconfig")

lspconfig.tsserver.setup({
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = vue_language_server_path,
				languages = { "vue" },
			},
		},
	},
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})

-- No need to set `hybridMode` to `true` as it's the default value
lspconfig.volar.setup({})
