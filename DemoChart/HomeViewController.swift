//
//  HomeViewController.swift
//  ChartsTutorial
//
//  Created by Israrul on 3/30/20.
//  Copyright © 2020 iOSTemplates. All rights reserved.
//

import UIKit
import Charts

class HomeViewController: UIViewController, UINavigationControllerDelegate {
    @IBOutlet weak var barChart: BarChartView!
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var cameraImageView: UIImageView!
    var players = [String]()
    var goals = [Int]()
    var stepperValue = 0
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupSetpper()
        customizeBarChart(dataPoints: players, values: goals.map{ Double($0) })
        setDataForBarChart()
    }
    
    func setupSetpper() {
        stepper.wraps = true;
        stepper.autorepeat = true;
        stepper.minimumValue = 5;
        stepper.value = Double(players.count)
        stepper.maximumValue = 10;
        stepper.stepValue = 1;
    }
    
    func fetchData() {
        let service = ContentService()
        let playerDataArray = service.getItemData()
        for item in playerDataArray {
            players.append(item.player)
            goals.append(item.goal)
        }
    }
    
    
    func customizeBarChart(dataPoints: [String], values: [Double]) {
       
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
    
     private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
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
    
    private func setChart(dataPoints: [String], values: [Double]) {
       
       var dataEntries: [BarChartDataEntry] = []
       
       for i in 0..<dataPoints.count {
         let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
         dataEntries.append(dataEntry)
       }
       
       let chartDataSet = BarChartDataSet(values: dataEntries, label: "Bar Chart View")
       let chartData = BarChartData(dataSet: chartDataSet)
       barChart.data = chartData
     }
    
    private func setDataForBarChart() {
        barChart.animate(yAxisDuration: 2.0)
        barChart.pinchZoomEnabled = false
        barChart.drawBarShadowEnabled = false
        barChart.drawBordersEnabled = false
        barChart.doubleTapToZoomEnabled = false
        barChart.drawGridBackgroundEnabled = true
        barChart.chartDescription?.text = "Bar Chart View"
        setChart(dataPoints: players, values: goals.map { Double($0) })
    }
}

extension HomeViewController: UIImagePickerControllerDelegate {
    @IBAction func takePhoto(sender: Any) {
       if UIImagePickerController.isSourceTypeAvailable(.camera) { 
            imagePicker =  UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var image : UIImage!

        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            image = img
        }
        else if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            image = img
        }
        imagePicker.dismiss(animated: true, completion: nil)
        cameraImageView.image = image
    }
}

extension HomeViewController{
    @IBAction func updatePlayer(_ sender: UIStepper) {
      
        if Int(sender.value) >= players.count {
            let customPlayerName = "Messi"
            let goal = 9
            players.append(customPlayerName)
            goals.append(goal)
            customizeBarChart(dataPoints: players, values: goals.map{ Double($0) })
            pieChart.setNeedsDisplay()
        } else  {
            players.removeFirst()
            goals.removeFirst()
            customizeBarChart(dataPoints: players, values: goals.map{ Double($0) })
            pieChart.setNeedsDisplay()
        }
    }
    
    @IBAction func updatePlayerForBarChart(_ sender: Any) {
     //To be Completed
    }
}
