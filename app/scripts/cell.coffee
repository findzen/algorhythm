define [
  'createjs'
  'filter'
  'color_matrix'
  'color_matrix_filter'
], (createjs, Filter, ColorMatrix, ColorMatrixFilter) ->
  'use strict'

  MATRIX_SIZE = 4

  class Cell extends createjs.Shape
    matrix: null

    # position: [row, col]
    # value: float 0-1
    value: 0

    modifier: 1

    fill: 'darkred'

    filters: []

    width: 10

    height: 10

    on: false

    index: -1

    constructor: (options) ->
      super

      @set options


      @graphics.beginFill(@fill)
        .drawRect 0, 0, @width, @height

      @createMatrix @modifier

      @addEventListener 'click', (e) =>
        @toggle()


    change: (col, row, val) ->
      # noop

    createMatrix: (modifier) ->
      @matrix = []

      for i in [1..MATRIX_SIZE]
        @matrix.push Math.round(Math.random())

    toggle: ->
      @on = !@on
      @value = Number(@on)
      @alpha = Number(!@on) + 0.5
      @change @position[0], @position[1], @value

    mod: (options) ->
      matrix = new ColorMatrix().adjustHue(180).adjustSaturation(100)
      @filters.push new ColorMatrixFilter matrix
      @cache -50, -50, 100, 100
