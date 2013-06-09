define [
  'createjs'
  'midijs'
  'pad'
], (createjs, MIDI, Pad) ->
  'use strict'

  class App
    constructor: ->
      @stage = new createjs.Stage 'testCanvas'
      @pads = []

      options =
        x: 0
        y: 0
        width: 50
        height: 50

      for i in [0..199]
        pad = new Pad

        if i
          prev = @pads[i - 1]
          pad.x = prev.x + options.width
          pad.y = prev.y + options.height

        @pads.push pad
        @stage.addChild pad

      createjs.Ticker.addEventListener 'tick', @draw

    draw: =>


      @stage.update()
