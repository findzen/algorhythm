define [
  'lodash'
  'createjs'
  'filter'
  'color_matrix'
  'color_matrix_filter'
], (_, createjs, Filter, ColorMatrix, ColorMatrixFilter) ->
  'use strict'

  MATRIX_SIZE = 4

  class Cell extends createjs.Shape
    options:
      fill: 'darkred'

    matrix: null

    value: 0

    width: 10

    height: 10

    filters: []

    active: false

    index: -1

    constructor: (graphics, props, options = {}) ->
      @options = _.defaults options, @options
      super

      @set props

      @graphics.beginFill(@options.fill)
        .drawRect 0, 0, @width, @height

      @createMatrix()
      @addEventListener 'click', (e) => @toggle()

    createMatrix: (@matrix = []) ->
      for i in [1..MATRIX_SIZE]
        @matrix.push Math.round(Math.random())

    toggle: ->
      @active = !@active
      @value = Number(@active)
      @alpha = Number(!@active) + 0.5
      # @options.change @position[0], @position[1], @value, @active
      @dispatchEvent
        type: 'change'
        position: @position
        value: @value
        active: @active

    mod: (options) ->
      matrix = new ColorMatrix().adjustHue(180).adjustSaturation(100)
      @filters.push new ColorMatrixFilter matrix
      @cache -50, -50, 100, 100
