define [
  'createjs'
  'filter'
  'color_matrix'
  'color_matrix_filter'
], (createjs, Filter, ColorMatrix, ColorMatrixFilter) ->
  'use strict'

  AURA_ZONE_COUNT = 8

  class Pad extends createjs.Shape
    aura: []

    modifier: 1

    fill: 'darkred'

    filters: []

    width: 10

    height: 10


    constructor: (options) ->
      super

      @set options

      @graphics.beginFill(@fill)
        .drawRect 0, 0, @width, @height

      @generateAura @modifier

    generateAura: (modifier) ->
      for [1..AURA_ZONE_COUNT]
        @aura.push Math.random() * modifier

    mod: (options) ->
      matrix = new ColorMatrix().adjustHue(180).adjustSaturation(100)
      @filters.push new ColorMatrixFilter matrix
      @cache -50, -50, 100, 100
