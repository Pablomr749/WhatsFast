Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
if (-not (Get-Command cargo -ErrorAction SilentlyContinue)) { throw 'Rust/Cargo no está instalado. Instala Rust con rustup.' }
cargo tauri build
