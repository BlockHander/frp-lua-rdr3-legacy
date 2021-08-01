fx_version 'adamant'
games {'rdr3'}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

server_scripts {
	'@_core/lib/utils.lua',
	'server.lua'
}

client_scripts{
    '@_core/lib/utils.lua',
    'client.lua'
}

files {
	'html/index.html', 
    'html/style.css',
    'html/script.js',
    'html/assets/bgbig.png',
    'html/assets/crock.ttf',
}

ui_page 'html/index.html'