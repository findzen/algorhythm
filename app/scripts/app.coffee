define [
  'jquery'
  'gui'
  'audiolib'
  'createjs'
  'clock'
  'sequencer'
  'scale'
  'ui/grid'
  'instruments/synth_lead'
  'instruments/drumkit_808'
], ($, GUI, audioLib, createjs, Clock, Sequencer, Scale, Grid, SynthLead, Drumkit808) ->
  'use strict'

  class App
    constructor: ->
      @stage = new createjs.Stage 'canvas'

      # sequencer
      @seq = new Sequencer steps: 8
      @seq.addEventListener 'end', => @grid.update()
      @seq.addEventListener 'step', (e) =>
        prev = if e.index then e.index - 1 else 7

        @grid.highlightCol prev, false
        @grid.highlightCol e.index

        for note in e.step
          @synth.play note if note

      @scale = new Scale 'Dorian'

      # grid
      @grid = new Grid
        rows: 16
        cols: 8
        cellWidth: 50
        cellHeight: 50
      @grid.addEventListener 'change', (e) =>
        console.log @, 'change', e
        [col, row] = e.position
        note = @scale.at Math.abs(row - @grid.options.rows) if e.on
        @seq.set col, row, note
      @stage.addChild @grid

      # master clock
      @clock = new Clock
      @clock.addEventListener 'tick', => @seq.next()

      # instruments
      @synth = new SynthLead
      @drums = new Drumkit808

      @setupControls()
      createjs.Ticker.addEventListener 'tick', @draw

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

      @gui = new GUI
      @gui.add(defaults, 'tempo')
        .min(40)
        .max(200)
        .step(1)
        .onChange (bpm) => @clock.setTempo bpm
      @gui.add(defaults, 'play')

    draw: =>
      @stage.update()
