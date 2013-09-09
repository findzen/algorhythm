define [
  'createjs'
  'gibberish'
], (createjs, Gibberish) ->
  'use strict'

  class Clock extends createjs.EventDispatcher
    isPlaying: false

    constructor: ->
      Gibberish.init()
      @seq = new Gibberish.Sequencer
        durations:[Gibberish.Time.beats(0.25)]
        values: [@tick]

    tick: => @dispatchEvent 'tick'

    setTempo: (bpm) -> Gibberish.Time.bpm = bpm

    play: ->
      @isPlaying = !@isPlaying
      if @isPlaying then @seq.start() else @seq.stop()
