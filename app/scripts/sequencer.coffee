define [
  'lodash'
  'createjs'
], (_, createjs) ->
  'use strict'

  class Sequencer extends createjs.EventDispatcher
    options:
      steps: 16
      voices: 8

    sequence: []

    currentStep: 0

    constructor: (options) ->
      @options = _.defaults options, @options
      @sequence = []
      @sequence.push @createStep() for i in [1..@options.steps]
      @currentStep = @options.steps - 1

    steps: (steps) ->
      @options.steps = steps

    next: ->
      if @currentStep < @options.steps - 1
        @currentStep++
      else
        @currentStep = 0
        @dispatchEvent 'start'

      @dispatchEvent
        type: 'step'
        index: @currentStep
        step: @sequence[@currentStep]

    set: (step, voice, note) ->
      @sequence[step][voice] = note

    createStep: ->
      null for i in [1..@options.voices]
