//
//  TitleModel.swift
//  project
//
//  Created by Alisher Djuraev on 09/01/23.
//

import Foundation

struct TitleModel {
    let titleName: String
    let descriptionName: String
}

struct TitleViewModel {
    let model: TitleModel
    var canCopy: Bool = false
}
