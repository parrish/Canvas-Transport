Transporter = require './transporter'
$ ->
  transporter = new Transporter
  
  loadCanvas = (image) ->
    image.onload = ->
      canvas = document.createElement 'canvas'
      canvas.width = image.width
      canvas.height = image.height
      context = canvas.getContext '2d'
      context.drawImage image, 0, 0
      document.body.appendChild canvas
      
      data = canvas.toDataURL 'image/png'
      console.log 'worked'
  
  transporter.load('images/1.png').then loadCanvas
  transporter.load('images/2.png').then loadCanvas
  transporter.load('images/3.png').then loadCanvas
  transporter.load('images/4.png').then loadCanvas
