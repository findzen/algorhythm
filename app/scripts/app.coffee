define [
  'createjs'
], (createjs) ->
  'use strict'
  console.log createjs
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
      #Create @stage object - our root level container
      @stage = new createjs.Stage 'testCanvas'

      #Create a load @queue to handle preloading assets
      @queue = new createjs.LoadQueue(false)
      @queue.installPlugin createjs.Sound
      @queue.addEventListener 'complete', @handleComplete
      @queue.loadManifest [
        id: 'daisy'
        src: 'images/blue.gif'
      ,
        id: 'sound'
        src: 'assets/audio.mp3'
      ]

    handleComplete: (event) =>
      #Create interactive object, using EaselJS Drawing API
      ball = new createjs.Shape()
      ball.addEventListener 'click', @handleClick
      ball.graphics.beginFill('#aaa').drawCircle 0, 0, 50
      ball.x = 50
      ball.y = 200

      #Creates animation of display object
      createjs.Tween.get(ball,
        loop: true
      ).to(
        x: 450
      , 3000).to
        x: 50
      , 3000

      #Listening for a tick event that will update the @stage
      createjs.Ticker.addEventListener 'tick', @tick
      @stage.addChild ball

    #Handle mouse interaction
    handleClick: (event) =>

      #Create a bitmap (daisy) and display a random position on @stage
      bmp = new createjs.Bitmap(@queue.getResult('daisy'))
      bmp.x = Math.random() * 500
      bmp.y = Math.random() * 500
      @stage.addChild bmp
      createjs.Sound.play 'sound'

    #Need when having animation.
    tick: (event) =>
      # draw the updates to stage:
      @stage.update event

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

        sprite.x = x + @renderer.width
        sprite.y = y + @renderer.height
        console.log sprite.x, sprite,y

      @renderer.render @@stage

      window.requestAnimationFrame @draw

    mono: (a, k) ->
      mod * (k / Math.sqrt(a))

