require.config
  paths:
    jquery: '../bower_components/jquery/jquery'
    pixi: '../bower_components/pixi/bin/pixi.dev'
  shim:
    pixi:
      exports: 'PIXI'

require [
  'app'
  'jquery'
], (App, $) ->
  'use strict'


  console.log '____---->aaa', window.app = new App
  console.log 'Running jQuery %s', $().jquery


