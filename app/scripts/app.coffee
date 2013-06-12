define [
  'jquery'
  'gui'
  'audiolib'
  'createjs'
  'clock'
  'grid'
  'sequencer'
], ($, GUI, audioLib, createjs, Clock, Grid, Sequencer) ->
  'use strict'



  class App
    constructor: ->
      @stage = new createjs.Stage 'canvas'
      @grid = new Grid
        rows: 8
        cols: 8
        cellWidth: 50
        cellHeight: 50

      @grid.change = (col, row, value) =>
        # console.log col, row
        @seq.set col, row, value

      @stage.addChild @grid



      createjs.Ticker.addEventListener 'tick', @draw

      # sequencer
      @seq = new Sequencer
        steps: 8

      @setupControls()

    setupControls: ->
      $(document).on 'keyup', (e) =>
        switch e.keyCode
          # space
          when 32
            @seq.play()

      # dat.gui controls
      defaults =
        tempo: 100
        play: => @seq.play()
        resolution: '1/8'

      @gui = new GUI
      @gui.add(defaults, 'tempo')
        .min(40)
        .max(200)
        .step(1)
        .onChange (bpm) =>
          @seq.tempo bpm
      @gui.add(defaults, 'play')

      values = ['1/16', '1/8', '1/4']
      @gui.add(defaults, 'resolution', ['1/16', '1/8', '1/4'])
        .onChange (val) =>
          @seq.resolution values.indexOf(val)

    draw: =>
      @stage.update()



