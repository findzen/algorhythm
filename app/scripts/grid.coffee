define [
  'lodash'
  'createjs'
  'cell'
], (_, createjs, Cell) ->
  'use strict'

  class Grid extends createjs.Container
    options:
      rows: 4
      cols: 4
      cellWidth: 10
      cellHeight: 10
      cellPadding: 2
      change: (col, row, value, active) ->

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

      options =
        change: (col, row, value, active) =>
          @options.change col, row, value, active

      spacing = @options.cellPadding + props.width

      for row in [0..@options.rows - 1]
        for col in [0..@options.cols - 1]
          props.position = [col, row]
          props.x = spacing * col
          props.y = spacing * row

          cell = new Cell null, props, options
          @addChild cell

          @cells[col] ?= []
          @cells[col].push cell

    getChildAtCoord: (col, row) ->
      @cells[col]?[row]

    update: ->
      for cell in @children
        for i, neighbor of @getCellNeighbors.apply @, cell.position
          if neighbor and !!Math.round cell.matrix[i]
            neighbor.toggle()
            neighbor.matrix = cell.matrix
            cell.createMatrix()

    getCellNeighbors: (col, row) ->
      up = @getChildAtCoord(col, row - 1)
      down = @getChildAtCoord(col, row + 1)
      left = @getChildAtCoord(col - 1, row)
      right = @getChildAtCoord(col + 1, row)

      [up, down, left, right]



