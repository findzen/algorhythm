define [
  'jquery'
  'gui'
  'audiolib'
  'createjs'
  'clock'
  'grid'
  'sequencer'
  'scale'
  'output'
], ($, GUI, audioLib, createjs, Clock, Grid, Sequencer, Scale, Output) ->
  'use strict'

  class App
    constructor: ->
      @stage = new createjs.Stage 'canvas'
      @scale = new Scale 'Dorian'
      @grid = new Grid
        rows: 8
        cols: 8
        cellWidth: 50
        cellHeight: 50
        change: (col, row, value, active) =>
          note = @scale.at Math.abs(row - @grid.options.rows) if active
          console.log 'grid change:', col, row, value, active
          console.log 'note:', note
          @seq.set col, row, note + 20

      @stage.addChild @grid
      createjs.Ticker.addEventListener 'tick', @draw

      @output = new Output

      # sequencer
      @seq = new Sequencer steps: 8
      @seq.addEventListener 'start', => @grid.update()
      @seq.addEventListener 'step', (e) =>
        for note in e.step
          @output.play note, 500 if note

      # master clock
      @clock = new Clock new webkitAudioContext
      @clock.addEventListener 'tick', => @seq.next()

      @setupControls()

    setupControls: ->
      $(document).on 'keyup', (e) =>
        switch e.keyCode
          # space
          when 32
            @clock.play()

      # dat.gui controls
      defaults =
        tempo: 120
        play: => @clock.play()
        resolution: '1/8'

      @gui = new GUI
      @gui.add(defaults, 'tempo')
        .min(40)
        .max(200)
        .step(1)
        .onChange (bpm) => @clock.setTempo bpm
      @gui.add(defaults, 'play')

      values = ['1/16', '1/8', '1/4']
      @gui.add(defaults, 'resolution', values)
        .onChange (val) => @clock.resolution values.indexOf(val)

    draw: =>
      @stage.update()
