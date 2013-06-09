require.config
  paths:
    jquery: '../bower_components/jquery/jquery'
    createjs: '../bower_components/createjs-2013.05.14.min/index'
    midijs: '../bower_components/MIDI.js/build/MIDI'
  shim:
    createjs:
      exports: 'createjs'
    midijs:
      exports: 'MIDI'

require [
  'app'
  'jquery'
], (App, $) ->
  'use strict'

  console.log '===>', window.app = new App
