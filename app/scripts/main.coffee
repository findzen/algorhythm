require.config
  paths:
    jquery: '../bower_components/jquery/jquery'
    createjs: '../bower_components/createjs-2013.05.14.min/index'
  shim:
    createjs:
      exports: 'createjs'

require [
  'app'
  'jquery'
], (App, $) ->
  'use strict'


  console.log '===>', window.app = new App
  console.log 'Running jQuery %s', $().jquery


