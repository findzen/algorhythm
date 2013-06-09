define [
  'createjs'
  'pad'
], (createjs, Pad) ->
  'use strict'

  class Layout extends createjs.Container
    width: 100

    height: 100

    pads: 100

    constructor: (options = {}) ->
      @set options
      super

      props =
        x: 0
        y: 0
        width: 50
        height: 50

      count:
        row: @width / props.height
        column: @height / props.width

      for i in [0..@pads]
        if i
          prev = @getChildAt i - 1
          props.x = prev.x + props.width
          props.y = prev.y + props.height

        pad = new Pad props
        pad.addEventListener 'click', (e) -> e.target.mod()
        @addChild pad
