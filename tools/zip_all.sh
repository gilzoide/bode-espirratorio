#!/bin/sh

script_root=$(dirname $(realpath $0))
project_root="$script_root/.."
pushd "$project_root/build"

# zip BodeEspirratorio_windows -j BodeEspirratorio_windows.{exe,pck}
# zip BodeEspirratorio_linux_x86 -j BodeEspirratorio_linux.{x86,pck}
# zip BodeEspirratorio_linux_x86_64 -j BodeEspirratoriolinux.{x86_64,pck}
zip BodeEspirratorio_web -j web/*

popd
