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

      @sequence = []
      @sequence.push @newSequence() for i in [1..@options.steps]
      console.log @sequence, @sequence.steps

      @clock = new Clock
        tempo: @options.tempo

      @clock.tick = (index) =>
        # console.log index
        delay = 0 # play one note every quarter second
        # note = 50 # the MIDI note
        velocity = 127 # how hard the note hits
        # play the note
        # MIDI.setVolume 0, 127

        @next().step(index)

        for note in @sequence[@currentStep]
          # console.log note
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

    step: ->
      # noop

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
      null for i in [0..7]

