request = require 'request'

cache = {}

apiRequest = (uri, options, callback) ->
    process.nextTick ->
        request.call null, uri, options, (err, res, body) ->
            if err then return callback err
            callback null, body

initParams = (uri, options, callback) ->
    callback = options  if (typeof options is "function") and not callback
    if options and typeof options is "object"
        options.uri = uri
    else if typeof uri is "string"
        options = uri: uri
    else
        options = uri
        uri = options.uri
    uri: uri
    options: options
    callback: callback

module.exports = apiRequest

apiRequest.get = (uri, options, callback) ->
    params = initParams uri, options, callback
    params.method = "GET"
    apiRequest(params.uri || null, params.options, params.callback)

apiRequest.post = (uri, options, callback) ->
    params = initParams uri, options, callback
    params.method = "POST"
    apiRequest(params.uri || null, params.options, params.callback)
