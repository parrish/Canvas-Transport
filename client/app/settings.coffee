Settings =
  development:
    frameHost: 'http://localhost:9296'
    framePath: 'index.html'
  
  production:
    frameHost: 'http://zooniverse-demo.s3-website-us-east-1.amazonaws.com'
    framePath: 'canvas_transport_frame/index.html'

env = if window.location.port > 1024
  'development'
else
  'production'

module.exports = Settings[env]
