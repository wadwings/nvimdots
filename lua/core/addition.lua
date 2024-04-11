local vue_language_server_path = "/usr/local/lib/@vue/typescript-plugin@2.0.12"

local lspconfig = require("lspconfig")
local bind = require("keymap.bind")
local map_callback = bind.map_callback

lspconfig["tsserver"].setup({
	on_attach = function(_client, buffer)
		local function goto_source_definition()
			local position_params = vim.lsp.util.make_position_params()
			vim.lsp.buf.execute_command({
				command = "_typescript.goToSourceDefinition",
				arguments = { vim.api.nvim_buf_get_name(0), position_params.position },
			})
		end
		local opts = { buffer = buffer }
		vim.keymap.set("n", "<leader>ds", goto_source_definition, opts)
	end,
	handlers = {
		["workspace/executeCommand"] = function(_err, result, ctx, _config)
			if ctx.params.command ~= "_typescript.goToSourceDefinition" then
				return
			end
			if result == nil or #result == 0 then
				return
			end
			vim.lsp.util.jump_to_location(result[1], "utf-8")
		end,
	},
})

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
	on_attach = function(_client, buffer)
		local function goto_source_definition()
			local position_params = vim.lsp.util.make_position_params()
			vim.lsp.buf.execute_command({
				command = "_typescript.goToSourceDefinition",
				arguments = { vim.api.nvim_buf_get_name(0), position_params.position },
			})
		end
		local opts = { buffer = buffer, desc = "tsserver: Goto SourceDefinition" }
		vim.keymap.set("n", "<leader>ds", goto_source_definition, opts)
	end,
	handlers = {
		["workspace/executeCommand"] = function(_err, result, ctx, _config)
			if ctx.params.command ~= "_typescript.goToSourceDefinition" then
				return
			end
			if result == nil or #result == 0 then
				return
			end
			vim.lsp.util.jump_to_location(result[1], "utf-8")
		end,
	},
})

-- No need to set `hybridMode` to `true` as it's the default value
lspconfig.volar.setup({})
