//
//  DataModel.swift
//  rekrut
//
//  Created by Mikołaj Linczewski on 24/04/2021.
//

import Foundation

struct DataModel: Codable {
    let description: String
    let image_url: URL
    let modificationDate: String
    let orderId: Int
    let title: String
}
