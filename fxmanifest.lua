game 'rdr3'
fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'justSalkin'
description 'Script for the carrier job'
version '1.2'


client_script {
    'client.lua', 
}

server_script {
    'server.lua', 
}

shared_scripts {
    'config.lua',
}

dependency 'vorp_core'
dependencies {
    'vorp_core',
    'vorp_inventory',
    'vorp_progressbar'
}