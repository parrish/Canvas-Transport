parent.postMessage JSON.stringify(message: 'ready'), '*'

insertEl = (type, id) ->
  el = document.createElement type
  el.id = id
  document.body.appendChild el

receiveMessage = (message) ->
  path = JSON.parse(message.data).path
  image = insertEl 'img', "image-#{ path }"
  canvas = insertEl 'canvas', "canvas-#{ path }"
  context = canvas.getContext '2d'
  
  image.onload = ->
    canvas.width = image.width
    canvas.height = image.height
    context.drawImage image, 0, 0
    data = canvas.toDataURL 'image/png'
    parent.postMessage JSON.stringify(path: path, data: data), message.origin
    image.remove()
    canvas.remove()
  
  image.src = path

window.addEventListener 'message', receiveMessage, false