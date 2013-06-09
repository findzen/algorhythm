define [
  'createjs'
], (createjs) ->
  'use strict'

  class Pad extends createjs.Shape
    defaults:
      alpha: 100

      x: 0
      y: 0

    height: 10
    width: 10

    constructor: (options = {}) ->
      # override default properties with provided options
      # for key, val of @defaults
      #   @[key] = options[key] or val

      super

      @draw()
      @aura = [0..9]

    draw: ->
      @graphics.beginFill('#666').drawRect 0, 0, @width, @height

