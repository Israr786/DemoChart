//
//  PieChartHelper.swift
//  DemoChart
//
//  Created by Israrul on 3/30/20.
//  Copyright © 2020 iOSTemplates. All rights reserved.
//

import Foundation
import Charts

protocol PieChartProtocol: class {
    func updateValueForPieChart(players: [String], goals: [Int])
}

class PieChartHelper {
    let pieChart: PieChartView
    let players: [String]
    let goals: [Int]
    weak var delegate: PieChartProtocol?
    
    init(piechart: PieChartView, players: [String], goals: [Int]) {
        self.pieChart = piechart
        self.players = players
        self.goals = goals
    }
    
    public func customizeBarChart(dataPoints: [String], values: [Double]) {
       
       var dataEntries: [ChartDataEntry] = []
       for i in 0..<dataPoints.count {
         let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data:  dataPoints[i] as AnyObject)
         dataEntries.append(dataEntry)
       }
       
       let pieChartDataSet = PieChartDataSet(values: dataEntries, label: nil)
       pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
       
       let pieChartData = PieChartData(dataSet: pieChartDataSet)
       let format = NumberFormatter()
       format.numberStyle = .none
       let formatter = DefaultValueFormatter(formatter: format)
       pieChartData.setValueFormatter(formatter)
       
       pieChart.data = pieChartData
     }
    
    func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
       var colors: [UIColor] = []
       for _ in 0..<numbersOfColor {
         let red = Double(arc4random_uniform(256))
         let green = Double(arc4random_uniform(256))
         let blue = Double(arc4random_uniform(256))
         let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
         colors.append(color)
       }
       return colors
     }
}
