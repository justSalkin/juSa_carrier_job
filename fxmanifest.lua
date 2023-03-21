game 'rdr3'
fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'justSalkin'
description 'Carrier (docker) job script'
version '1.1'


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
    'vorp_animations',
    'vorp_progressbar'
}

-- LAST EDIT by just_Salkin 22.03.2023 | WHITE-SANDS-RP german RP server