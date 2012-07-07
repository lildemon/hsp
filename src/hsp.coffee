path		= require('path')
fs		= require('fs')
optimist	= require('optimist')
strata	= require('strata')
util		= require('util')

argv		= optimist.usage([
	'usage: hsp [options] <hsp directory>'
].join("\n"))
.demand(1)
.options 'a',
	alias: 'action',
	default: 'server',
	describe: '<server> or <build>'
.argv

help = ->
	optimist.showHelp()
	process.exit()
	
class Hsp
	options:
		public		: './public',
		build		: './__build',
		bootstrap	: '/bootstrap.js' # Loader and its configuations
		prefix		: ''
		port:		1988
	
	constructor: (options = {}) ->
		@options[key] = value for key, value of options
		@app = path.resolve(argv._[0])
		if not path.existsSync(@app)
			console.log "\nThe app directory was not found!\n"
			help()
		
	server: ->
		strata.use(strata.contentLength)
		strata.use(strata.contentType)
		
		publicPath = path.join(@app, @options.public)
		if path.existsSync(publicPath)
			strata.use(strata.file, publicPath, ['index.html', 'index.htm'])
		else
			console.log "no public path were found :("
			
		strata.run (env, callback) ->
			req = strata.Request(env)
			req.params (err, params) ->
				callback(200, {}, util.inspect(env));
		, port: @options.port
		
	exec: (command = argv.action) ->
		return help() unless @[command]
		@[command]()
		switch command
			when 'server' then console.log 'Serving files'
			
	# Private
	
	# please respect to prefix settings
	package: ->
		# return package object. which have function to be middleware or build to file
		
	css: ->
		# build css file or be as middlewear
		
	bootstrap: ->
		# the bootstrap.js
		
module.exports = Hsp