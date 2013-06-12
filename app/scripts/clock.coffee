define [
  'lodash'
], (_) ->
  'use strict'

  class Clock
    options:
      tick: (value) ->

    audioContext: null
    isPlaying: false      # Are we currently playing?
    startTime: null          # The start time of the entire sequence.
    current16thNote: 0        # What note is currently last scheduled?
    tempo: 120.0          # tempo (in beats per minute)
    lookahead: 25.0       # How frequently to call scheduling function
                                #(in milliseconds)
    scheduleAheadTime: 0.1    # How far ahead to schedule audio (sec)
                                # This is calculated from lookahead, and overlaps
                                # with next interval (in case the timer is late)
    nextNoteTime: 0.0     # when the next note is due.
    noteResolution: 1     # 0 == 16th, 1 == 8th, 2 == quarter note
    noteLength: 0.05      # length of "beep" (in seconds)
    timerID: 0            # setInterval identifier.

    notesInQueue: []      # the notes that have been put into the web audio,
                                # and may or may not have played yet. {note, time}

    constructor: (options) ->
      @options = _.defaults options, @options
      @init()

    init: ->
      @audioContext = new webkitAudioContext()

    setTempo: (bpm) ->
      @tempo = bpm

    resolution: (res) ->
      @noteResolution = res

    nextNote: ->
      # Advance current note and time by a 16th note...
      secondsPerBeat = 60.0 / @tempo # Notice this picks up the CURRENT
      # tempo value to calculate beat length.
      @nextNoteTime += 0.25 * secondsPerBeat # Add beat length to last beat time
      @current16thNote++ # Advance the beat number, wrap to zero
      @current16thNote = 0  if @current16thNote is 16
      # console.log 'nextNote', @current16thNote
      @options.tick @current16thNote

    scheduleNote: (beatNumber, time) ->
      # push the note on the queue, even if we're not playing.
      @notesInQueue.push
        note: beatNumber
        time: time

      return if (@noteResolution is 1) and (beatNumber % 2) # we're not playing non-8th 16th notes
      return if (@noteResolution is 2) and (beatNumber % 4) # we're not playing non-quarter 8th notes

      # create an oscillator
      osc = @audioContext.createOscillator()
      osc.connect @audioContext.destination

      # if beatNumber % 16 is 0 # beat 0 == low pitch
      #   osc.frequency.value = 220.0
      # else if beatNumber % 4 # quarter notes = medium pitch
      #   osc.frequency.value = 440.0
      # # other 16th notes = high pitch
      # else
      #   osc.frequency.value = 880.0

      # TODO: Once start()/stop() deploys on Safari and iOS, these should be changed.
      # osc.noteOn time
      # osc.noteOff time + @noteLength

    scheduler: =>
      # while there are notes that will need to play before the next interval,
      # schedule them and advance the pointer.
      while @nextNoteTime < @audioContext.currentTime + @scheduleAheadTime
        @scheduleNote @current16thNote, @nextNoteTime
        @nextNote()

      @timerID = window.setTimeout @scheduler, @lookahead

    play: =>
      console.log 'play'
      @isPlaying = !@isPlaying

      if @isPlaying # start playing
        @current16thNote = 0
        @nextNoteTime = @audioContext.currentTime
        @scheduler() # kick off scheduling
        "stop"
      else
        window.clearTimeout @timerID
        "play"

  # Clock.RESOLUTIONS =
  #   '1/16': 0
  #   '1/16': 0
  #   '1/16': 0

