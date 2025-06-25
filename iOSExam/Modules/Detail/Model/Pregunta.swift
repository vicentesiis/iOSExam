//
//  Pregunta.swift
//  iOSExam
//
//  Created by Vicente Cantu on 24/06/25.
//

struct PreguntasResponse: Decodable {
  let data: [Pregunta]
}

struct Pregunta: Decodable {
  let pregunta: String
  let values: [Value]
}

struct Value: Decodable {
  let label: String
  let value: Int
}
