define [
  'midi_utils'
  'gibberish'
  'instruments/instrument'
], (MIDIUtils, Gibberish, Instrument) ->
  'use strict'

  class Drumkit808 extends Instrument
    constructor: ->
      @kick = new Gibberish.Kick({ decay:.2 }).connect()

    play: (note) ->
      console.log note

      # switch note
      #   when 0 then kick()

      @kick.note(60)
