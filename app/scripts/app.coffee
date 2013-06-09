define [
  'createjs'
  'node'
], (createjs, Node) ->
  'use strict'

  class App
    constructor: ->
      @stage = new createjs.Stage 'testCanvas'
      @nodes = []

      for i in [1..200]
        node = new Node
        @nodes.push node
        @stage.addChild node

      createjs.Ticker.addEventListener 'tick', @draw

    draw: =>


      @stage.update()
