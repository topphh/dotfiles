return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup()

        vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
        vim.keymap.set("n", "<leader>glb", ":Gitsigns toggle_current_line_blame<CR>", {})
        vim.keymap.set("n", "<leader>ga", ":Gitsigns stage_hunk<CR>", {})
        vim.keymap.set("n", "<leader>gu", ":Gitsigns reset_hunk<CR>", {})
    end
}
