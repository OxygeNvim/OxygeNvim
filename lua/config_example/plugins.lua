return {
  -- add a plugin
  -- {
  --   'foo/bar'
  -- },

  -- disable a plugin
  -- {
  --   'foo/bar',
  --   enabled = false
  -- },

  { import = 'oxygen.packs.ai.copilot' },

  { import = 'oxygen.packs.formatters.black' },
  { import = 'oxygen.packs.formatters.blade_formatter' },
  { import = 'oxygen.packs.formatters.clang_format' },
  { import = 'oxygen.packs.formatters.phpcsfixer' },
  { import = 'oxygen.packs.formatters.pint' },
  { import = 'oxygen.packs.formatters.prettier' },
  { import = 'oxygen.packs.formatters.shfmt' },
  { import = 'oxygen.packs.formatters.stylua' },

  { import = 'oxygen.packs.frameworks.laravel' },
  { import = 'oxygen.packs.frameworks.tailwind' },

  { import = 'oxygen.packs.languages.astro' },
  { import = 'oxygen.packs.languages.bash' },
  { import = 'oxygen.packs.languages.c' },
  { import = 'oxygen.packs.languages.cmake' },
  { import = 'oxygen.packs.languages.csharp' },
  { import = 'oxygen.packs.languages.css' },
  { import = 'oxygen.packs.languages.dart' },
  { import = 'oxygen.packs.languages.docker' },
  { import = 'oxygen.packs.languages.fish' },
  { import = 'oxygen.packs.languages.fish' },
  { import = 'oxygen.packs.languages.git' },
  { import = 'oxygen.packs.languages.go' },
  { import = 'oxygen.packs.languages.html' },
  { import = 'oxygen.packs.languages.http' },
  { import = 'oxygen.packs.languages.java' },
  { import = 'oxygen.packs.languages.javascript' },
  { import = 'oxygen.packs.languages.json' },
  { import = 'oxygen.packs.languages.kotlin' },
  { import = 'oxygen.packs.languages.lua' },
  { import = 'oxygen.packs.languages.make' },
  { import = 'oxygen.packs.languages.markdown' },
  { import = 'oxygen.packs.languages.php' },
  { import = 'oxygen.packs.languages.prisma' },
  { import = 'oxygen.packs.languages.python' },
  { import = 'oxygen.packs.languages.rust' },
  { import = 'oxygen.packs.languages.scala' },
  { import = 'oxygen.packs.languages.sql' },
  { import = 'oxygen.packs.languages.svelte' },
  { import = 'oxygen.packs.languages.toml' },
  { import = 'oxygen.packs.languages.vue' },
  { import = 'oxygen.packs.languages.xml' },
  { import = 'oxygen.packs.languages.yaml' },
  { import = 'oxygen.packs.languages.zig' },

  { import = 'oxygen.packs.linters.eslint' },
  { import = 'oxygen.packs.linters.hadolint' },
  { import = 'oxygen.packs.linters.ktlint' },
  { import = 'oxygen.packs.linters.selene' },

  { import = 'oxygen.packs.other.discord' },

  { import = 'oxygen.packs.tools.biome' },

  { import = 'oxygen.packs.ui.rest' },
}
