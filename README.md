#### Requirements
- fish shell
- `XDG_CONFIG_HOME` env variable set

#### Instruction
Clone this repository and run:

```sh
./install.fish
```

#### Formatting lua files
> Requires [`lua-format`](https://github.com/Koihik/LuaFormatter)

```sh
lua-format -i -c ./lua-format.config ./config/**/*.lua
```
