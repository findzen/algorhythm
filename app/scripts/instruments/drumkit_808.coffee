define [
  'midi_utils'
  'gibberish'
  'instruments/instrument'
], (MIDIUtils, Gibberish, Instrument) ->
  'use strict'

  class Drumkit808 extends Instrument
    constructor: ->
      @kick = new Gibberish.Kick({ decay:.2 }).connect()
      @hat = new Gibberish.Hat({ amp: 1.5 }).connect()
      # @conga = new Gibberish.Conga({ amp:0.5, pitch:200 })
      # new Gibberish.Reverb({ input:@conga, wet:0.2 }).connect()

    play: (note) ->
      # console.log note

      switch note
        when 0 then @kick.note(60)
        when 1 then @hat.note(5000)
        when 2 then @hat.note(15000)
        # when 3 then @conga.note(200)
        # when 4 then @conga.note(230)
        # when 5 then @conga.note(260)


# g = new Gibberish.Conga({ amp:.5, pitch:200 })
# i = new Gibberish.Reverb({ input:g, wet:.2 }).connect()

# var pitches = [200,230,260]
# var chosenDur = 0;
# var durations = [ beats(.25), beats(.5), beats(.5), beats(1), beats(2)];
# var sixteenth = beats(.25)()

# l = new Gibberish.Sequencer({
#   values:[ function() {
#     g.note( pitches[ Gibberish.rndi(0,2) ], Gibberish.rndf(.25,.6) )
#   }],
#   durations:[ function() {
#     if(chosenDur === sixteenth ) {
#       chosenDur = sixteenth + 1
#     }else{
#       chosenDur = durations[ Gibberish.rndi(0,4) ]();
#     }
#     return chosenDur;
#   } ],
# }).start()

# m = new Gibberish.Cowbell({ amp:.5 })
# n = new Gibberish.Delay({ input: m, feedback:.9, time:beats(.25) })
# nn = new Gibberish.Filter24({ input:n, isLowPass:false }).connect()
# nn.cutoff = Add(.4, new Gibberish.Sine(.2, .125))

# o = new Gibberish.Sequencer({
#   target:m, key:'note',
#   durations:[beats(16)],
# }).start()
