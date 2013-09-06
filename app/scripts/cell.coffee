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
      @dispatchEvent
        type: 'change'
        position: @position
        value: @value
        active: @active

    highlight: (apply = true) ->
      if apply
        matrix = new ColorMatrix().adjustHue(180).adjustSaturation(100)
        @filters = [new ColorMatrixFilter matrix]
      else
        @filters = []
      @cache 0, 0, @width, @height

    reset: ->
      @active = false
      @value = 0
      @alpha = 1
      @filters = []
      @cache -50, -50, 100, 100
