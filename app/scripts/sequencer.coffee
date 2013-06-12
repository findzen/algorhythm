define [
  'lodash'
  'clock'
], (_, Clock) ->
  'use strict'

  class Sequencer
    options:
      steps: 16

    sequence: []
    step: 0

    constructor: (options) ->
      @options = _.defaults options, @options
      @steps @options.steps

      MIDI.loadPlugin
        soundfontUrl: "assets/"
        instrument: "acoustic_grand_piano"
        callback: ->
          # delay = 0 # play one note every quarter second
          # note = 50 # the MIDI note
          # velocity = 127 # how hard the note hits
          # # play the note
          # MIDI.setVolume 0, 127
          # MIDI.noteOn 0, note, velocity, delay
          # MIDI.noteOff 0, note, delay + 0.75

      @clock = new Clock
        tempo: @options.tempo
      @clock.tick = (index) =>
        console.log index
        delay = 0 # play one note every quarter second
        note = 50 + index # the MIDI note
        velocity = 127 # how hard the note hits
        # play the note
        # MIDI.setVolume 0, 127
        MIDI.noteOn 0, note, velocity, delay
        MIDI.noteOff 0, note, delay + 0.75

      @sequence = []
      @sequence.push null for i in [1..@options.steps]
      console.log @sequence, @sequence.steps


    play: ->
      @clock.play()
      @

    pause: ->
      @

    stop: ->
      @

    steps: (steps) ->
      @options.steps = steps
      @

    tempo: (bpm) ->
      @clock.setTempo bpm
      @

    resolution: (val) ->
      @clock.resolution val
      @

    next: ->

      @
