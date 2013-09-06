define [
  'midi_utils'
  'gibberish'
], (MIDIUtils, Gibberish) ->
  'use strict'

  class Output
    constructor: ->
      Gibberish.init()
      @synth = new Gibberish.PolySynth2({ attack:200, decay:8200, maxVoices:10 }).connect()
      @synth.waveform = 'Square'

    play: (note) ->
      @synth.note MIDIUtils.noteNumberToFrequency(note), 10

