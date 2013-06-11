define [
  'gui'
  'audiolib'
  'createjs'
  'timer'
  'midijs'
  'layouts/layout'
  'pad'
], (GUI, audioLib, createjs, Timer, MIDI, Layout, Pad) ->
  'use strict'

  class App
    constructor: ->
      @timer = new Timer
      @timer.tick = (index) =>
        console.log index
        # @layout.children[index].mod()


      @stage = new createjs.Stage 'canvas'
      @layout = new Layout
        width: @stage.canvas.width
        height: @stage.canvas.height
      @stage.addChild @layout
      createjs.Ticker.addEventListener 'tick', @draw

      # dat.gui controls
      defaults =
        tempo: 100
        play: => @timer.play()
        resolution: '1/8'

      @gui = new GUI
      @gui.add(defaults, 'tempo')
        .min(40)
        .max(200)
        .step(1)
        .onChange (val) =>
          @timer.setTempo val
      @gui.add(defaults, 'play')

      values = ['1/16', '1/8', '1/4']
      @gui.add(defaults, 'resolution', ['1/16', '1/8', '1/4'])
        .onChange (val) =>
          @timer.setResolution values.indexOf(val)



    draw: =>
      @stage.update()



