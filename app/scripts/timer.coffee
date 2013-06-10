define [

], () ->
  'use strict'

  class Timer

    audioContext: null
    isPlaying: false      # Are we currently playing?
    startTime: null          # The start time of the entire sequence.
    current16thNote: null        # What note is currently last scheduled?
    tempo: 120.0          # tempo (in beats per minute)
    lookahead: 25.0       # How frequently to call scheduling function
                                #(in milliseconds)
    scheduleAheadTime: 0.1    # How far ahead to schedule audio (sec)
                                # This is calculated from lookahead, and overlaps
                                # with next interval (in case the timer is late)
    nextNoteTime: 0.0     # when the next note is due.
    noteResolution: 0     # 0 == 16th, 1 == 8th, 2 == quarter note
    noteLength: 0.05      # length of "beep" (in seconds)
    timerID: 0            # setInterval identifier.

    canvas: null              # the canvas element
    canvasContext: null          # canvasContext is the canvas' context 2D
    last16thNoteDrawn: -1 # the last "box" we drew on the screen
    notesInQueue: []      # the notes that have been put into the web audio,
                                # and may or may not have played yet. {note, time}

    constructor: (args) ->
      # ...

    init: ->
      container = document.createElement("div")
      container.className = "container"
      @canvas = document.createElement("canvas")
      @canvasContext = @canvas.getContext("2d")
      @canvas.width = window.innerWidth
      @canvas.height = window.innerHeight
      document.body.appendChild container
      container.appendChild @canvas
      @canvasContext.strokeStyle = "#ffffff"
      @canvasContext.lineWidth = 2
      @audioContext = new webkitAudioContext()

      # if we wanted to load audio files, etc., this is where we should do it.
      window.onorientationchange = @resetCanvas
      window.onresize = @resetCanvas
      window.requestAnimationFrame @draw # start the drawing loop.

    setTempo: (tempo) ->
      @tempo = tempo

    nextNote: ->
      console.log 'nextNote'
      # Advance current note and time by a 16th note...
      secondsPerBeat = 60.0 / @tempo # Notice this picks up the CURRENT
      # tempo value to calculate beat length.
      @nextNoteTime += 0.25 * secondsPerBeat # Add beat length to last beat time
      @current16thNote++ # Advance the beat number, wrap to zero
      @current16thNote = 0  if @current16thNote is 16

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

      if beatNumber % 16 is 0 # beat 0 == low pitch
        osc.frequency.value = 220.0
      else if beatNumber % 4 # quarter notes = medium pitch
        osc.frequency.value = 440.0
      # other 16th notes = high pitch
      else
        osc.frequency.value = 880.0

      # TODO: Once start()/stop() deploys on Safari and iOS, these should be changed.
      osc.noteOn time
      osc.noteOff time + @noteLength

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

    resetCanvas: (e) =>
      console.log 'resetCanvas', @
      # resize the canvas - but remember - this clears the canvas too.
      @canvas.width = window.innerWidth
      @canvas.height = window.innerHeight

      #make sure we scroll to the top left.
      window.scrollTo 0, 0

    draw: =>
      currentNote = @last16thNoteDrawn
      currentTime = @audioContext.currentTime

      while @notesInQueue.length and @notesInQueue[0].time < currentTime
        currentNote = @notesInQueue[0].note
        @notesInQueue.splice 0, 1 # remove note from queue

      # We only need to draw if the note has moved.
      unless @last16thNoteDrawn is currentNote
        x = Math.floor(@canvas.width / 18)
        @canvasContext.clearRect 0, 0, @canvas.width, @canvas.height
        i = 0

        while i < 16
          @canvasContext.fillStyle = (if (currentNote is i) then ((if (currentNote % 4 is 0) then "red" else "blue")) else "black")
          @canvasContext.fillRect x * (i + 1), x, x / 2, x / 2
          i++
        @last16thNoteDrawn = currentNote

      # set up to draw again
      window.requestAnimationFrame @draw



