define [
  'midi_utils'
  'gibberish'
  'instruments/instrument'
], (MIDIUtils, Gibberish, Instrument) ->
  'use strict'

  class SynthLead extends Instrument
    constructor: ->
      @synth = new Gibberish.PolySynth2
        attack: 200
        decay: 8200
        maxVoices: 10
      @synth.waveform = 'Square'
      @synth.connect()

    play: (note) ->
      @synth.note MIDIUtils.noteNumberToFrequency(note), 10
