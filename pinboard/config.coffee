fs = require 'fs'
path = require 'path'

config = module.exports = {}

config.seajs = './modules/seajs/1.1.0/sea-debug.js'
config.basepath = './modules'
config.alias = 
	jquery	: 	'jquery/1.7.2/jquery'
	mootools	:	'mootools/1.4.5/mootools-core-1.4.5'
	
config.preload = [
	'plugin-text'
]

pkgmain = (pkgpath) ->
	"index.js" # return default index.js or what package.json says

packages = # node-based package to stitch
	"spine" : # stitch to "#spine.js"
		index: pkgmain "libs/spine"
		stitch: [ # every require to those file will result in require "#libs/spine.js"
			"index.js"
			"./lib/ajax.js"
			"./lib/list.js"
			"./lib/local.js"
			"./lib/manager.js"
			"./lib/relation.js"
			"./lib/route.js"
			"./lib/spine.js"
		],
		pkgname: "spine" # require("spine") (alias to)-> require("spine/index.js")

