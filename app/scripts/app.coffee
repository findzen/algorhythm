define [
  'pixi'
], (PIXI) ->
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
      @renderer = PIXI.autoDetectRenderer 800, 600
      document.body.appendChild @renderer.view

      @sprites = []
      texture = PIXI.Texture.fromImage 'images/bunny.png'
      # @bunny = new PIXI.Sprite texture
      # @bunny.position.x = 400
      # @bunny.position.y = 300
      # @bunny.scale.x = 2
      # @bunny.scale.y = 2

      @stage = new PIXI.Stage
      # @stage.addChild @bunny

      for i in [1..200]
        sprite = new PIXI.Sprite texture
        sprite.position.x = 400
        sprite.position.y = 300
        @stage.addChild sprite
        @sprites.push sprite

      window.requestAnimationFrame @draw

    draw: =>
      a = 1
      k = 0
      circ = baseCirc

      for sprite in @sprites
        x = r * Math.cos k
        y = r * Math.sin k

        a += modA
        r = @mono(a, k)
        k += modK
        circ += modCirc

        sprite.x = x + @renderer.width/2
        sprite.y = y + @renderer.height/2


      # @bunny.rotation += 0.01
      @renderer.render @stage

      window.requestAnimationFrame @draw

    mono: (a, k) ->
      mod * (k / Math.sqrt(a))
