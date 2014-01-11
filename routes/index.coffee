request = require "#{global.root}/lib/api_request"

exports.index = (req, res, next) ->
    request.get "#{global.config.apiUrl}/api.json", (err, apiData) ->
        apiData = JSON.parse apiData
        res.render 'index', { title: 'templates', themes: apiData.themes }
