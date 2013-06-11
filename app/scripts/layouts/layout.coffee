define [
  'createjs'
  'pad'
], (createjs, Pad) ->
  'use strict'

  class Layout extends createjs.Container
    width: 100
    height: 100
    cellPadding: 2

    constructor: (options = {}) ->
      @set options
      super

      props =
        x: 0
        y: 0
        width: 50
        height: 50

      @rows = Math.floor @height / (props.height + @cellPadding)
      @cols = Math.floor @width / (props.width + @cellPadding)

      for row in [0..@rows - 1]
        for col in [0..@cols - 1]
          props.x = (@cellPadding + props.width) * col
          props.y = (@cellPadding + props.height) * row
          cell = new Pad props
          cell.addEventListener 'click', (e) -> e.target.mod()
          @addChild cell


    at: (index) ->
      @cells[index]
