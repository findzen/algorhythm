define [
  'createjs'
  'filter'
  'color_matrix'
  'color_matrix_filter'
], (createjs, Filter, ColorMatrix, ColorMatrixFilter) ->
  'use strict'

  AURA_ZONE_COUNT = 8

  class Cell extends createjs.Shape
    aura: []

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

      @generateAura @modifier

      # @addEventListener 'click', (e) -> e.target.toggle()

    generateAura: (modifier) ->
      for [1..AURA_ZONE_COUNT]
        @aura.push Math.random() * modifier

    toggle: ->
      @on = !@on
      @value = Number(@on)
      @alpha = Number(!@on) + 0.5

    mod: (options) ->
      matrix = new ColorMatrix().adjustHue(180).adjustSaturation(100)
      @filters.push new ColorMatrixFilter matrix
      @cache -50, -50, 100, 100
