require.config
  paths:
    jquery: '../bower_components/jquery/jquery'
    lodash: '../bower_components/lodash/lodash'
    gui: '../bower_components/dat.gui/index'
    createjs: '../bower_components/EaselJS/lib/easeljs-0.6.1.min'
    musicjs: '../bower_components/music.js/music'
    filter: '../bower_components/EaselJS/src/easeljs/filters/Filter'
    color_matrix: '../bower_components/EaselJS/src/easeljs/filters/ColorMatrix'
    color_matrix_filter: '../bower_components/EaselJS/src/easeljs/filters/ColorMatrixFilter'
    audiolib: '../bower_components/audiolib.js.0.6.4/audiolib'
    midi_utils: '../bower_components/MIDIUtils/src/MIDIUtils'
    gibberish: '../bower_components/Gibberish/scripts/build/gibberish_2.0'

  shim:
    gui:
      exports: 'dat.GUI'
    audiolib:
      exports: 'audioLib'
    musicjs:
      exports: 'MUSIC'
    createjs:
      exports: 'createjs'
    filter:
      exports: 'createjs.Filter'
    color_matrix:
      exports: 'createjs.ColorMatrix'
    color_matrix_filter:
      exports: 'createjs.ColorMatrixFilter'
    midi_utils:
      exports: 'MIDIUtils'
    gibberish:
      exports: 'Gibberish'

require [
  'app'
  'jquery'
], (App, $) ->
  'use strict'

  window.app = new App
