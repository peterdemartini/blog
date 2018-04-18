gulp = require 'gulp'
webserver = require 'gulp-webserver'
Builder = require './build.coffee'

gulp.task 'build', (callback) =>
  builder = new Builder
  builder.run callback

gulp.task 'start', ['build'], =>
  gulp.src './build'
    .pipe webserver({
      livereload: false
      directoryListing: false
      open: false
      port: 3333
      host: '0.0.0.0'
      fallback: 'index.html'
    })
