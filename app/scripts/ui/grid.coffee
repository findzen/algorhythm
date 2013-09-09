define [
  'lodash'
  'createjs'
  'ui/cell'
], (_, createjs, Cell) ->
  'use strict'

  class Grid extends createjs.Container
    options:
      rows: 4
      cols: 4
      cellWidth: 10
      cellHeight: 10
      cellPadding: 2
      mono: false

    cells: []

    constructor: (options = {}) ->
      @options = _.defaults options, @options
      super
      @build()

    build: ->
      props =
        x: 0
        y: 0
        width: @options.cellWidth
        height: @options.cellHeight

      spacingX = @options.cellPadding + props.width
      spacingY = @options.cellPadding + props.height

      for row in [0..@options.rows - 1]
        for col in [0..@options.cols - 1]
          props.position = [col, row]
          props.x = spacingX * col
          props.y = spacingY * row

          cell = new Cell null, props

          # manually bubble event since createjs doesn't support this yet
          cell.addEventListener 'change', (e) => @dispatchEvent e
          cell.addEventListener 'click', (e) =>
            # only allow one cell per column to be on if mono is true
            if @options.mono and !e.target.isOn
              for cell in @getCol e.target.position[0]
                cell.toggle() if cell.isOn
            e.target.toggle()

          @addChild cell

          @cells[col] ?= []
          @cells[col].push cell

    getChildAtCoord: (col, row, wrap = true) ->
      if wrap
        if col >= @options.cols then col = 0
        if row >= @options.rows then row = 0
        if col < 0 then col = @options.cols - 1
        if row < 0 then row = @options.rows - 1

      @cells[col]?[row]

    getCol: (index) -> @cells[index]

    getRow: (index) ->
      row = []

      for col in @cells
        row.push col[index]

      row

    highlightCol: (index, apply = true) ->
      cell.highlight apply for cell in @getCol index

    getNeighbors: (col, row) ->
      n   = @getChildAtCoord col, row - 1
      ne  = @getChildAtCoord col + 1, row - 1
      e   = @getChildAtCoord col + 1, row
      se  = @getChildAtCoord col + 1, row + 1
      s   = @getChildAtCoord col, row + 1
      sw  = @getChildAtCoord col - 1, row + 1
      w   = @getChildAtCoord col - 1, row
      nw  = @getChildAtCoord col - 1, row - 1

      [n, ne, e, se, s, sw, w, nw]

    setMatrix: (matrix) ->
      for i, bool of matrix
        if bool then @children[i].on() else @children[i].off()

    getMatrix: ->
      @children.map (cell) -> Number(cell.isOn)

    randomize: ->
      @setMatrix([1..@children.length].map -> Math.random() * 2 | 0)

    reverse: ->
      @setMatrix @getMatrix().map (val) -> Math.abs val - 1

    inverse: ->
      @setMatrix @getMatrix().reverse()

    update: ->
      live = []
      die = []

      for cell in @children
        onNeighbors = @getNeighbors.apply(@, cell.position).filter (cell) ->
          cell?.isOn
        onCount = onNeighbors.length

        if cell.isOn and (onCount <= 1 or onCount >= 4)
          die.push cell
        else if !cell.isOn and onCount is 3
          live.push cell

      cell.off() for cell in die
      cell.on() for cell in live
