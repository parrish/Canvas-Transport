parent.postMessage JSON.stringify(message: 'ready'), '*'

requests = { }

insertEl = (type, id) ->
  el = document.createElement type
  el.id = id
  document.body.appendChild el

receiveMessage = (message) ->
  path = JSON.parse(message.data).path
  image = insertEl 'img', "image-#{ path }"
  canvas = insertEl 'canvas', "canvas-#{ path }"
  requests[image.id] = { image, canvas }
  
  image.onload = ->
    { image, canvas } = requests[@id]
    canvas.width = image.width
    canvas.height = image.height
    context = canvas.getContext '2d'
    context.drawImage image, 0, 0
    data = canvas.toDataURL 'image/png'
    parent.postMessage JSON.stringify(path: path, data: data), message.origin
    delete requests[@id]
    document.body.removeChild image
    document.body.removeChild canvas
  
  image.src = path

window.addEventListener 'message', receiveMessage, false