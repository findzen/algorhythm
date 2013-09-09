define [
  'jquery'
  'gui'
  'audiolib'
  'createjs'
  'clock'
  'sequencer'
  'ui/grid'
  'instruments/bass'
  'instruments/synth_lead'
  'instruments/drumkit_808'
], ($, GUI, audioLib, createjs, Clock, Sequencer, Grid, Bass, SynthLead, Drumkit808) ->
  'use strict'

  STEPS = 16
  ROWS = 18

  class App
    constructor: ->
      @stage = new createjs.Stage 'canvas'

      # sequencer
      @seq = new Sequencer steps: STEPS
      @seq.addEventListener 'end', => @grid.update()
      @seq.addEventListener 'step', (e) =>
        prev = if e.index then e.index - 1 else STEPS - 1

        @grid.highlightCol prev, false
        @grid.highlightCol e.index

        for note in e.step
          if note isnt undefined
            @synth.play note
            # @drums.play note
            if note < 3 then @drums.play note
            else if note < 10 then @bass.play note
            else @synth.play note

      # grid
      @grid = new Grid
        rows: ROWS
        cols: STEPS
        cellWidth: 50
        cellHeight: 50
      @grid.addEventListener 'change', (e) =>
        [col, row] = e.position
        note = row if e.on
        @seq.set col, row, note
      @stage.addChild @grid

      # master clock
      @clock = new Clock
      @clock.addEventListener 'tick', => @seq.next()

      # instruments
      @bass = new Bass
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
        randomize: => @grid.randomize()
        reverse: => @grid.reverse()
        inverse: => @grid.inverse()

      @gui = new GUI
      @gui.add(defaults, 'tempo')
        .min(40)
        .max(200)
        .step(1)
        .onChange (bpm) => @clock.setTempo bpm
      @gui.add(defaults, 'play')
      @gui.add(defaults, 'randomize')
      @gui.add(defaults, 'reverse')
      @gui.add(defaults, 'inverse')

    draw: =>
      @stage.update()
