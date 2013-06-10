define [
  'createjs'
  'timer'
  'midijs'
  'layouts/layout'
  'pad'
], (createjs, Timer, MIDI, Layout, Pad) ->
  'use strict'

  class App
    constructor: ->
      @timer = new Timer

      window.init = @timer.init
      window.noteResolution = @timer.noteResolution
      window.tempo = @timer.tempo
      window.play = @timer.play

      @timer.init()
      # @timer.play()
      # @stage = new createjs.Stage 'canvas'
      # @layout = new Layout
      #   width: @stage.canvas.width
      #   height: @stage.canvas.height
      # @stage.addChild @layout
      # createjs.Ticker.addEventListener 'tick', @draw

    draw: =>
      @stage.update()



