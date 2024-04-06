fx_version "adamant"
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'fuzzy'
lua54 'yes'
description 'A degradation script for itens'
version "1.0"

server_scripts {
    'server/*.lua',
    'version.lua'
}

shared_script {
    'config.lua',
}

client_scripts {
    'client/client.lua',
}

dependency {
    'vorp_core',
    'vorp_inventory'
}