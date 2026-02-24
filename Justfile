set dotenv-load := true

crate := "zellij-workspaces"
wasm_target := "wasm32-wasip1"

default:
  @just --list

# Build the plugin (debug wasm)
build:
  cargo build --target {{wasm_target}}

# Build the plugin (release wasm)
build-release:
  cargo build --release --target {{wasm_target}}

# Reload plugin into current Zellij session
reload: build
  zellij action start-or-reload-plugin file:target/{{wasm_target}}/debug/{{crate}}.wasm

# Reload release build into current Zellij session
reload-release: build-release
  zellij action start-or-reload-plugin file:target/{{wasm_target}}/release/{{crate}}.wasm

# Watch sources, rebuild+reload on change
watch:
  watchexec -r -e rs,toml,kdl -- just reload

check:
  cargo check --target {{wasm_target}}

fmt:
  cargo fmt

clippy:
  cargo clippy --target {{wasm_target}}

clean:
  cargo clean

layout:
  zellij -l zellij.kdl
