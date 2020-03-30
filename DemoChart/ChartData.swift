//
//  ChartData.swift
//  ChartsTutorial
//
//  Created by Israrul on 3/30/20.
//  Copyright © 2020 iOSTemplates. All rights reserved.
//

import Foundation

struct ContentService {
    func getItemData() -> [Player] {
        let path = Bundle.main.path(forResource: "Chart", ofType: "json")!
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)

        do {
                let decoder = JSONDecoder()
            return try decoder.decode([Player].self, from: data)
            } catch {
                fatalError("Couldn't parse")
            }
    }
}
