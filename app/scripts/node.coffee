define [
  'createjs'
], (createjs) ->
  'use strict'

  class Node extends createjs.Shape
    constructor: (args) ->
      super
      @graphics.beginFill('#ccc').drawRect 0, 0, 50, 50

    getValue: ->
      1
