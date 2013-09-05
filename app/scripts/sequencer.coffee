define [
  'lodash'
], (_) ->
  'use strict'

  class Sequencer
    options:
      step: (notes) -> console.log notes
      steps: 16
      voices: 8

    sequence: []

    currentStep: 0

    constructor: (options) ->
      @options = _.defaults options, @options
      @sequence = []
      @sequence.push @createStep() for i in [1..@options.steps]

    steps: (steps) ->
      @options.steps = steps
      @

    next: ->
      if @currentStep < @options.steps - 1
        @currentStep++
      else
        @currentStep = 0

      @options.step @sequence[@currentStep]
      @

    set: (step, voice, note) ->
      @sequence[step][voice] = note

    createStep: ->
      null for i in [1..@options.voices]
