gulp = require("gulp")
# browserify = require("gulp-browserify")
browserify = require("browserify")
gulpUtil = require("gulp-util")
watchify = require("watchify")
source = require("vinyl-source-stream")
# coffeeify = require "coffeeify"
reactify = require "reactify"
rename = require 'gulp-rename'
sourceFiles = ["./public/coffee/**/*.{coffee,cjsx}"]
sourceFile = ["./public/coffee/app.cjsx"]
destFolder = "./public/js/"
destFile = "bundle.js"

gulp.task "browserify", ->
  # gulp.src(sourceFile, { read: false })
  bundler = watchify browserify sourceFile, 
    extensions: ['.coffee', '.cjsx']
    cache: {}  # required for watchify
    packageCache: {} # required for watchify
    fullPaths: yes  # required for watchify
    # TODO: Why can't I put these in as options?
    # transform: ['coffee-reactify']
    # entries: [sourceFile]

  bundler
    # .add sourceFile
    .transform 'coffee-reactify'

  rebundle = ->
    gulpUtil.log 'Rebundling...'
    bundler
      .bundle().on('error', gulpUtil.log.bind(gulpUtil, 'Browserify Error'))
      .pipe source destFile
      .pipe gulp.dest destFolder

  logBundleCreationTime = (time)->
    gulpUtil.log "Finished bundling in #{time/1000} seconds"

  bundler.on 'update', rebundle
  bundler.on 'time', logBundleCreationTime

  rebundle()

gulp.task "default", [
  "browserify"
]

