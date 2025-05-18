return {
	"nvim-cmp",
	dependencies = {
		{
			"github/copilot.vim",
		},
	},
	opts = function(_, opts)
		opts.sources = opts.sources or {}
		table.insert(opts.sources, 1, {
			name = "Copilot",
			group_index = 1,
			priority = 100,
		})
	end,
}
