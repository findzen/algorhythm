define [
  'lodash'
  'clock'
], (_, Clock) ->
  'use strict'

  class Sequencer
    options:
      steps: 16
      voices: 8

    sequence: []

    currentStep: 0

    constructor: (options) ->
      @options = _.defaults options, @options

      MIDI.loadPlugin
        soundfontUrl: "assets/"
        instrument: "acoustic_grand_piano"
        callback: ->

      @sequence = []
      @sequence.push @newSequence() for i in [1..@options.steps]

      @clock = new Clock
        tempo: @options.tempo
        tick: (value) =>
          delay = 0 # play one note every quarter second
          # note = 50 # the MIDI note
          velocity = 127 # how hard the note hits
          # play the note
          # MIDI.setVolume 0, 127

          @next()

          for note in @sequence[@currentStep]
            if note
              MIDI.noteOn 0, note + 50, velocity, delay
              MIDI.noteOff 0, note + 50, delay + 0.75

    play: ->
      @clock.play()
      @

    pause: ->
      @

    stop: ->
      @

    steps: (steps) ->
      @options.steps = steps
      # if steps > @sequence.length
      @

    tempo: (bpm) ->
      @clock.setTempo bpm
      @

    resolution: (val) ->
      @clock.resolution val
      @

    next: ->
      if @currentStep < @options.steps - 1
        @currentStep++
      else
        @currentStep = 0
      @

    set: (step, voice, note) ->
      console.log 'set', step, voice, note
      @sequence[step][voice] = note

    # todo: Sequence class
    newSequence: ->
      null for i in [1..@options.voices]

