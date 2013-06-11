require.config
  paths:
    jquery: '../bower_components/jquery/jquery'
    gui: '../bower_components/dat.gui/index'
    createjs: '../bower_components/createjs-2013.05.14.min/index'
    filter: '../bower_components/EaselJS/src/easeljs/filters/Filter'
    color_matrix: '../bower_components/EaselJS/src/easeljs/filters/ColorMatrix'
    color_matrix_filter: '../bower_components/EaselJS/src/easeljs/filters/ColorMatrixFilter'
    midijs: '../bower_components/MIDI.js/build/MIDI'
    audiolib: '../bower_components/audiolib.js.0.6.4/audiolib'

  shim:
    gui:
      exports: 'dat.GUI'
    audiolib:
      exports: 'audioLib'
    createjs:
      exports: 'createjs'
    filter:
      exports: 'createjs.Filter'
    color_matrix:
      exports: 'createjs.ColorMatrix'
    color_matrix_filter:
      exports: 'createjs.ColorMatrixFilter'
    midijs:
      exports: 'MIDI'

require [
  'app'
  'jquery'
], (App, $) ->
  'use strict'

  window.app = new App
