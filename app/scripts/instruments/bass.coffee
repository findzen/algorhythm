define [
  'midi_utils'
  'gibberish'
  'scale'
  'instruments/instrument'
], (MIDIUtils, Gibberish, Scale, Instrument) ->
  'use strict'

  class SynthLead extends Instrument
    constructor: ->
      @scale = new Scale 'Dorian'

      @synth = new Gibberish.MonoSynth
        attack: 20
        resonance: 4
        cutoff: 0.2
      @synth.waveform = 'Square'
      @synth.connect()

    play: (note) ->
      # console.log note
      note = @scale.at Math.abs(note)
      # console.log note
      @synth.note MIDIUtils.noteNumberToFrequency(note), 0.2
