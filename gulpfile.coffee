gulp = require("gulp")
browserify = require("gulp-browserify")
watchify = require("gulp-watchify")
source = require("vinyl-source-stream")
coffeeify = require "coffeeify"
reactify = require "reactify"
rename = require 'gulp-rename'
sourceFiles = ["./public/coffee/**/*.{coffee,cjsx}"]
sourceFile = ["./public/coffee/app.cjsx"]
destFolder = "./public/js/"
destFile = "bundle.js"

gulp.task "browserify", ->
  gulp.src(sourceFile, { read: false })
    .pipe(browserify({
      transform: [
        'coffee-reactify'
      ],
      extensions: [
        '.coffee'
        '.cjsx'
      ]
    }))
    .pipe(rename(destFile))
    .pipe gulp.dest(destFolder)

gulp.task 'watch', ->
  gulp.watch sourceFiles, ['browserify']

gulp.task "default", [
  "browserify"
  "watch"
]


# TODO: see if I can get watchify to work
# gulp.task "watch", ->
#   rebundle = ->
#     bundler.bundle()
#     .pipe(source(destFile))
#     .pipe gulp.dest(destFolder)
    
#   bundler = watchify(sourceFile)
#   bundler.on "update", rebundle
#   rebundle()
