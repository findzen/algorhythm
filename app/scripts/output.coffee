define [
  'midi_utils'
], (MIDIUtils) ->
  'use strict'

  class Output
    constructor: ->
      @context = new webkitAudioContext

    play: (note, duration) ->
      osc = @context.createOscillator()
      osc.frequency.value = MIDIUtils.noteNumberToFrequency note
      osc.connect @context.destination
      osc.start 0

      callback = -> osc.stop 0
      window.setTimeout callback, duration
