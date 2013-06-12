define [
  'createjs'
  'cell'
], (createjs, Cell) ->
  'use strict'

  class Grid extends createjs.Container
    rows: 4
    cols: 4
    width: 100
    height: 100
    cellWidth: 10
    cellHeight: 10
    cellPadding: 2
    cells:[]

    constructor: (options = {}) ->
      @set options
      super

      props =
        x: 0
        y: 0
        width: @cellWidth
        height: @cellHeight

      # @rows = Math.floor @height / (props.height + @cellPadding)
      # @cols = Math.floor @width / (props.width + @cellPadding)

      spacing = @cellPadding + props.width

      for row in [0..@rows - 1]
        for col in [0..@cols - 1]
          props.position = [col, row]
          props.x = spacing * col
          props.y = spacing * row

          cell = new Cell props
          cell.change = (col, row, val) =>
            @change col, row, val
          # cell.addEventListener 'click', (e) =>
          #   e.target.toggle()
          #   position = e.target.position
          #   value = e.target.value
          #   @change.call @, position[0], position[1], value

          @addChild cell

          @cells[col] ?= []
          @cells[col].push cell

    change: (col, row, val) ->
      # noop

    getChildAtCoord: (col, row) ->
      @cells[col]?[row]

    update: ->
      console.log 'update'

      for cell in @children
        for i, neighbor of @getCellNeighbors.apply @, cell.position
          if neighbor and !!Math.round cell.matrix[i]
            neighbor.toggle()
            neighbor.createMatrix(cell.matrix)
            cell.createMatrix()
        # for i, val of cell.matrix
        #   if neighbor = @children[i]
        #     neighbor.toggle() if !!Math.round(val)

    getCellNeighbors: (col, row) ->
      up = @getChildAtCoord(col, row - 1)
      down = @getChildAtCoord(col, row + 1)
      left = @getChildAtCoord(col - 1, row)
      right = @getChildAtCoord(col + 1, row)

      [up, down, left, right]



