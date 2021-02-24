#!/bin/sh

script_root=$(dirname $(realpath $0))
project_root="$script_root/.."

butler push --if-changed "$project_root/build/BodeEspirratorio_web.zip"      gilzoide/sneezing-goat:web
butler push --if-changed "$project_root/build/BodeEspirratorio_windows.zip"  gilzoide/sneezing-goat:win32
butler push --if-changed "$project_root/build/BodeEspirratorio_linux32.zip"  gilzoide/sneezing-goat:linux32
butler push --if-changed "$project_root/build/BodeEspirratorio_linux64.zip"  gilzoide/sneezing-goat:linux64
butler push --if-changed "$project_root/build/BodeEspirratorio_osx.zip"      gilzoide/sneezing-goat:osx
butler push --if-changed "$project_root/build/BodeEspirratorio_android.apk"  gilzoide/sneezing-goat:android

