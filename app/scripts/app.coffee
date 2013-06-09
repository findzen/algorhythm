define [
  'createjs'
  'midijs'
  'layouts/layout'
  'pad'
], (createjs, MIDI, Layout, Pad) ->
  'use strict'

  class App
    constructor: ->
      @stage = new createjs.Stage 'testCanvas'

      @layout = new Layout
      @stage.addChild @layout

      props =
        x: 0
        y: 0
        width: 50
        height: 50

      for i in [0..1]
        if i
          prev = @layout.getChildAt i - 1
          props.x = prev.x + props.width
          props.y = prev.y + props.height

        pad = new Pad props

        @layout.addChild pad

      createjs.Ticker.addEventListener 'tick', @draw

    draw: =>
      @stage.update()
