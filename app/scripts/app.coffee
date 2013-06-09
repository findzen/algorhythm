define [
  'createjs'
  'midijs'
  'layouts/layout'
  'pad'
], (createjs, MIDI, Layout, Pad) ->
  'use strict'

  class App
    constructor: ->
      @stage = new createjs.Stage 'canvas'
      @layout = new Layout
        width: @stage.canvas.width
        height: @stage.canvas.height
      @stage.addChild @layout
      createjs.Ticker.addEventListener 'tick', @draw

    draw: =>
      @stage.update()
