deferred = $.Deferred
{ frameHost, framePath } = require './settings'

class Transporter
  constructor: ->
    @setupFrame()
    @bind()
    @requests = { }
  
  setupFrame: ->
    @el = $('#canvas-transport-frame')[0]
    
    unless @el
      @el = $ """
        <iframe id="canvas-transport-frame" src="#{ frameHost }/#{ framePath }" style="width: 0px; height: 0px; visibility: hidden;"></iframe>
      """
      @el.appendTo document.body
      @el = @el[0]
  
  bind: ->
    $(window).on 'message', ({ originalEvent: e }) =>
      result = JSON.parse e.data
      
      if result.message is 'ready'
        @ready = true
        @processRequests()
      else
        @resolve result
  
  request: (path) =>
    @requests[path] = d = deferred()
    @send path
    d.promise()
  
  send: (path) =>
    return unless @ready
    @el.contentWindow.postMessage JSON.stringify(path: path), frameHost
  
  processRequests: =>
    @send(path) for path, promise of @requests
  
  resolve: (result) =>
    path = result.path
    d = @requests[path]
    d.resolve result.data
    delete @requests[path]
  
  load: (path) ->
    @request(path).then (data) ->
      image = new Image
      image.src = data
      image

module.exports = Transporter
