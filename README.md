# Roblox default
 Default roblox project for stuff


## Setup

Rojo vscode extension
Stylua and ~~selene~~(selene clashes with luau lsp) vscode extensions

Modules in rokit.toml, run
``` aftman install ```

`wally install`
`rojo sourcemap default.project.json --output sourcemap.json`
`wally-package-types --sourcemap sourcemap.json Packages/`

Tools managed with [Rokit](https://github.com/rojo-rbx/rokit)
` Rokit install`
Packages managed with [Pesde](https://docs.pesde.dev/installation/)

### Extensions
- Roblox LSP https://marketplace.visualstudio.com/items?itemName=Nightrains.robloxlsp
- Luau Language Server https://marketplace.visualstudio.com/items?itemName=JohnnyMorganz.luau-lsp
Luau Language Server offers more modern features like !strict and the like.
Wouldn't recommend for existing projects as the linter is way more strict and can turn into a pain

### useful
https://github.com/JohnnyMorganz/wally-package-types