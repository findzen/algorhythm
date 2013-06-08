define [
  'createjs'
], (createjs) ->
  'use strict'

  r = null
  k = null
  a = 1
  mod = 50
  modA = 0.1
  modK = 0.1
  baseCirc = 10
  modCirc = -0.1
  circ = null

  class App
    constructor: ->
      @stage = new createjs.Stage 'testCanvas'
      @sprites = []

      for i in [1..200]
        sprite = new createjs.Shape
        sprite.graphics.beginFill('#ccc').drawCircle 0, 0, baseCirc
        @sprites.push sprite
        @stage.addChild sprite

      createjs.Ticker.addEventListener 'tick', @draw

    draw: =>
      a = 1
      k = 0
      circ = baseCirc
      context = @stage.canvas.getContext('2d')
      context.save()
      context.translate @stage.canvas.width/2, @stage.canvas.height/2

      for sprite in @sprites
        x = r * Math.cos k
        y = r * Math.sin k

        a += modA
        r = @mono(a, k)
        k += modK
        circ += modCirc

        sprite.x = x
        sprite.y = y
        # console.log sprite.x, sprite,y

      context.restore()
      @stage.update()

    mono: (a, k) ->
      mod * (k / Math.sqrt(a))

