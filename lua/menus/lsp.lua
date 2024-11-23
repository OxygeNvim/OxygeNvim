return {
  {
    name = 'Goto definition',
    cmd = vim.lsp.buf.definition,
    rtxt = 'gd',
  },

  {
    name = 'Goto declaration',
    cmd = vim.lsp.buf.declaration,
    rtxt = 'gD',
  },

  {
    name = 'Goto implementation',
    cmd = vim.lsp.buf.implementation,
    rtxt = 'gi',
  },

  { name = 'separator' },

  {
    name = 'Signature help',
    cmd = vim.lsp.buf.signature_help,
    rtxt = '<leader>gh',
  },

  { name = 'separator' },

  {
    name = 'Add workspace folder',
    cmd = vim.lsp.buf.add_workspace_folder,
    rtxt = '<leader>wa',
  },

  {
    name = 'Remove workspace folder',
    cmd = vim.lsp.buf.remove_workspace_folder,
    rtxt = '<leader>wr',
  },

  {
    name = 'Show References',
    cmd = vim.lsp.buf.references,
    rtxt = 'gr',
  },
}
