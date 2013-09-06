define [
  'jquery'
  'gui'
  'audiolib'
  'createjs'
  'clock'
  'ui/grid'
  'sequencer'
  'scale'
  'output'
], ($, GUI, audioLib, createjs, Clock, Grid, Sequencer, Scale, Output) ->
  'use strict'

  class App
    constructor: ->
      @stage = new createjs.Stage 'canvas'
      @scale = new Scale 'Dorian'

      # grid
      @grid = new Grid
        rows: 8
        cols: 8
        cellWidth: 50
        cellHeight: 50
      @grid.addEventListener 'change', (e) =>
        [col, row] = e.position
        note = @scale.at Math.abs(row - @grid.options.rows) if e.active
        console.log 'grid change:', col, row, e.value, e.active
        console.log 'note:', note
        @seq.set col, row, note + 20
      @stage.addChild @grid

      createjs.Ticker.addEventListener 'tick', @draw

      @output = new Output

      # sequencer
      steps = 8
      @seq = new Sequencer steps: steps
      @seq.addEventListener 'start', => @grid.update()
      @seq.addEventListener 'step', (e) =>
        prev = if e.index then e.index - 1 else steps - 1
        @grid.highlightCol prev, false
        @grid.highlightCol e.index

        for note in e.step
          @output.play note if note

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
