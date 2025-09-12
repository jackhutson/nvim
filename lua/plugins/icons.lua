return {
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = function()
      local catppuccin = require("catppuccin.palettes").get_palette("mocha")
      return {
        color_icons = true,
        default = true,
        override = {
          lua = {
            icon = "",
            color = catppuccin.blue,
            name = "Lua",
          },
          js = {
            icon = "",
            color = catppuccin.yellow,
            name = "JavaScript",
          },
          ts = {
            icon = "",
            color = catppuccin.blue,
            name = "TypeScript",
          },
          tsx = {
            icon = "",
            color = catppuccin.blue,
            name = "TypeScriptReact",
          },
          jsx = {
            icon = "",
            color = catppuccin.sky,
            name = "JavaScriptReact",
          },
          html = {
            icon = "",
            color = catppuccin.peach,
            name = "Html",
          },
          css = {
            icon = "",
            color = catppuccin.blue,
            name = "Css",
          },
          json = {
            icon = "",
            color = catppuccin.yellow,
            name = "Json",
          },
          md = {
            icon = "",
            color = catppuccin.blue,
            name = "Markdown",
          },
          py = {
            icon = "",
            color = catppuccin.yellow,
            name = "Python",
          },
          toml = {
            icon = "",
            color = catppuccin.blue,
            name = "Toml",
          },
          yaml = {
            icon = "",
            color = catppuccin.mauve,
            name = "Yaml",
          },
          yml = {
            icon = "",
            color = catppuccin.mauve,
            name = "Yaml",
          },
          rs = {
            icon = "",
            color = catppuccin.peach,
            name = "Rust",
          },
          go = {
            icon = "",
            color = catppuccin.sapphire,
            name = "Go",
          },
          vim = {
            icon = "",
            color = catppuccin.green,
            name = "Vim",
          },
          sh = {
            icon = "",
            color = catppuccin.green,
            name = "Shell",
          },
          bash = {
            icon = "",
            color = catppuccin.green,
            name = "Bash",
          },
          zsh = {
            icon = "",
            color = catppuccin.green,
            name = "Zsh",
          },
          git = {
            icon = "",
            color = catppuccin.peach,
            name = "Git",
          },
          [".gitignore"] = {
            icon = "",
            color = catppuccin.overlay0,
            name = "GitIgnore",
          },
          package = {
            icon = "",
            color = catppuccin.green,
            name = "Package",
          },
          ["package.json"] = {
            icon = "",
            color = catppuccin.green,
            name = "PackageJson",
          },
          ["package-lock.json"] = {
            icon = "",
            color = catppuccin.red,
            name = "PackageLockJson",
          },
          Dockerfile = {
            icon = "",
            color = catppuccin.blue,
            name = "Dockerfile",
          },
          [".dockerignore"] = {
            icon = "",
            color = catppuccin.overlay0,
            name = "DockerIgnore",
          },
          [".env"] = {
            icon = "",
            color = catppuccin.yellow,
            name = "Env",
          },
          LICENSE = {
            icon = "",
            color = catppuccin.yellow,
            name = "License",
          },
          README = {
            icon = "",
            color = catppuccin.blue,
            name = "Readme",
          },
          ["README.md"] = {
            icon = "",
            color = catppuccin.blue,
            name = "Readme",
          },
        },
        override_by_extension = {
          ["log"] = {
            icon = "",
            color = catppuccin.overlay0,
            name = "Log",
          },
          ["txt"] = {
            icon = "",
            color = catppuccin.text,
            name = "Text",
          },
          ["png"] = {
            icon = "",
            color = catppuccin.mauve,
            name = "Png",
          },
          ["jpg"] = {
            icon = "",
            color = catppuccin.mauve,
            name = "Jpg",
          },
          ["jpeg"] = {
            icon = "",
            color = catppuccin.mauve,
            name = "Jpeg",
          },
          ["svg"] = {
            icon = "",
            color = catppuccin.peach,
            name = "Svg",
          },
        },
      }
    end,
  },
}