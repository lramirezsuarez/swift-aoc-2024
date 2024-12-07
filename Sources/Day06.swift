//
//  Day06.swift
//  AdventOfCode
//
//  Created by Luis Alejandro Ramirez Suarez on 7/12/24.
//

import Algorithms

struct Day06: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String
  
  // Splits input data into its component parts and convert from string.
  var entities: [[Int]] {
    data.split(separator: "\n\n").map {
      $0.split(separator: "\n").compactMap { Int($0) }
    }
  }
  
  func part1() async throws -> Int {
    var guardPosition = (-1, -1)
    var positions: Set<Int> = []
    var direction: Direction = .up
    let matrix = data.split(separator: "\n").reduce(into: [[Character]]()) { matrix, row in
      matrix.append(row.reduce(into: [Character]()) { row, character in
        if character == Direction.up.rawValue {
          guardPosition = (matrix.count ,row.count)
        }
        row.append(character)
      })
    }
    
    var insideTable = true
    while insideTable {
      let escalarPosition = (guardPosition.0 * matrix.count) + guardPosition.1
      positions.insert(escalarPosition) // saving duplicate positions
      switch direction {
      case .up:
        let nextPosition = (guardPosition.0 - 1,guardPosition.1)
        if nextPosition.0 < 0 {
          insideTable = false
        } else if matrix[nextPosition.0][nextPosition.1] == "#" {
          direction = .right
        } else {
          guardPosition = nextPosition
        }
      case .down:
        let nextPosition = (guardPosition.0 + 1,guardPosition.1)
        if nextPosition.0 >= matrix.count {
          insideTable = false
        } else if matrix[nextPosition.0][nextPosition.1] == "#" {
          direction = .left
        } else {
          guardPosition = nextPosition
        }
      case .left:
        let nextPosition = (guardPosition.0, guardPosition.1 - 1)
        if nextPosition.1 < 0 {
          insideTable = false
        } else if matrix[nextPosition.0][nextPosition.1] == "#" {
          direction = .up
        } else {
          guardPosition = nextPosition
        }
      case .right:
        let nextPosition = (guardPosition.0, guardPosition.1 + 1)
        if nextPosition.1 >= matrix.count {
          insideTable = false
        } else if matrix[nextPosition.0][nextPosition.1] == "#" {
          direction = .down
        } else {
          guardPosition = nextPosition
        }
      }
    }
    return positions.count
  }
  
  
  enum Direction: Character {
    case up = "^"
    case down = "v"
    case left = "<"
    case right = ">"
  }
  

}
