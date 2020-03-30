//
//  BarChartHelper.swift
//  DemoChart
//
//  Created by Israrul on 3/30/20.
//  Copyright © 2020 iOSTemplates. All rights reserved.
//

import Foundation
import Charts

protocol BarChartProtocol: class {
    func updateValueForBarChart(players: [String], goals: [Int])
}

class BarChartHelper {
    let barChart: BarChartView
    let players: [String]
    let goals: [Int]
    weak var delegate: BarChartProtocol?
    
    init(barchart: BarChartView, players: [String], goals: [Int]) {
        self.barChart = barchart
        self.players = players
        self.goals = goals
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
          var dataEntries: [BarChartDataEntry] = []
          
          for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
            dataEntries.append(dataEntry)
          }
          
          let chartDataSet = BarChartDataSet(values: dataEntries, label: "Bar Chart View")
          let chartData = BarChartData(dataSet: chartDataSet)
          barChart.data = chartData
          
        }
       
    public func setDataForBarChart() {
           barChart.animate(yAxisDuration: 2.0)
           barChart.pinchZoomEnabled = false
           barChart.drawBarShadowEnabled = false
           barChart.drawBordersEnabled = false
           barChart.doubleTapToZoomEnabled = false
           barChart.drawGridBackgroundEnabled = true
           barChart.chartDescription?.text = "Bar Chart View"
           delegate?.updateValueForBarChart(players: players, goals: goals)
       }
    
}


