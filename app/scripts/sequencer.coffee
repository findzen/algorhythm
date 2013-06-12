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

      @clock = new Clock
        tempo: @options.tempo
      @clock.tick = (index) =>
        console.log index

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
