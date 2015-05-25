gulp = require 'gulp'
webserver = require 'gulp-webserver'
Builder = require './build'

gulp.task 'build', =>
  builder = new Builder
  builder.run()

gulp.task 'server', =>
  gulp.src './build'
    .pipe webserver({
      livereload: false
      directoryListing: false
      open: false
      port: 3333
      host: '0.0.0.0'
      fallback: 'index.html'
    })

gulp.task 'watch', ['build', 'server'], =>
  gulp.watch ['./src/**/*', './templates/**/*'], ['build']
