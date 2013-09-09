define [
  'lodash'
  'createjs'
  'filter'
  'color_matrix'
  'color_matrix_filter'
], (_, createjs, Filter, ColorMatrix, ColorMatrixFilter) ->
  'use strict'

  class Cell extends createjs.Shape
    options:
      fill: 'darkred'

    width: 10

    height: 10

    isOn: false

    index: -1

    constructor: (graphics, props, options = {}) ->
      @options = _.defaults options, @options
      super
      @set props
      @graphics.beginFill(@options.fill)
        .drawRect 0, 0, @width, @height

    toggle: ->
      if @isOn then @off() else @on()

    on: ->
      @isOn = true
      @alpha = 0.5
      @onChange()

    off: ->
      @isOn = false
      @alpha = 1
      @onChange()

    onChange: ->
      @dispatchEvent
        type: 'change'
        position: @position
        on: @isOn

    highlight: (apply = true) ->
      if apply
        matrix = new ColorMatrix().adjustHue(180).adjustSaturation(100)
        @filters = [new ColorMatrixFilter matrix]
      else
        @filters = []
      @cache 0, 0, @width, @height

    reset: ->
      @isOn = false
      @value = 0
      @alpha = 1
      @filters = []
      @cache -50, -50, 100, 100
