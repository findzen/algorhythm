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

      for i in [0..@pads]
        pad = new Pad props
        pad.addEventListener 'click', (e) -> e.target.mod()

        @addChild pad

        if props.x is @width - props.width
          props.x = 0
          props.y += props.height
        else
          props.x += props.width
