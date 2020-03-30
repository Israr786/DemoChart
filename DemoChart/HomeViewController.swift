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
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var cameraImageView: UIImageView!
    var players = [String]()
    var goals = [Int]()
    var stepperValue = 0
    var imagePicker: UIImagePickerController!
    var barCHart: BarChartHelper?
    var pieCHart: PieChartHelper?
    var cameraHelper: CameraHelper?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupSetpper()
        barCHart = BarChartHelper(barchart: barChart, players: players, goals: goals)
        pieCHart = PieChartHelper(piechart: pieChart, players: players, goals: goals)
        cameraHelper = CameraHelper(imagePicker: imagePicker, cameraImageView: cameraImageView)
        barCHart?.setChart(dataPoints: players, values: goals.map { Double($0) })
        pieCHart?.customizeBarChart(dataPoints: players, values: goals.map{ Double($0) })
        barCHart?.delegate = self
        pieCHart?.delegate = self
        cameraHelper?.delegate = self
    }
    
    func setupSetpper() {
        stepper.wraps = true;
        stepper.autorepeat = true;
        stepper.minimumValue = 5;
        stepper.value = Double(players.count)
        slider.value = Float(players.count)
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
}

extension HomeViewController: UIImagePickerControllerDelegate {
    @IBAction func takePhoto(sender: Any) {
        cameraHelper?.delegate?.camera(navController: self)
    }
    
    @IBAction func cancelPhoto(sender: Any) {
        cameraImageView.image = UIImage(named: "placeHolder")
    }
}

extension HomeViewController {
    @IBAction func updatePlayer(_ sender: UIStepper) {
        updateDataOnValueChanged(chnagedValue: Int(sender.value))
        pieCHart?.delegate?.updateValueForPieChart(players: players, goals: goals)
    }
    
    @IBAction func updatePlayerForBarChart(_ sender: UISlider) {
        updateDataOnValueChanged(chnagedValue: Int(sender.value))
        barCHart?.delegate?.updateValueForBarChart(players: players, goals: goals)
    }
    
    private func updateDataOnValueChanged(chnagedValue: Int) {
        if Int(chnagedValue) >= players.count {
                   let customPlayerName = "Messi"
                   let goal = Int(arc4random())/100000000
                   players.append(customPlayerName)
                   goals.append(goal)
               } else if players.count == 0 {
                   fetchData()
               } else {
                   players.removeFirst()
                   goals.removeFirst()
               }
    }
}

extension HomeViewController: BarChartProtocol {
    func updateValueForBarChart(players: [String], goals: [Int]) {
        barCHart?.setChart(dataPoints: players, values: goals.map { Double($0) })
    }
}

extension HomeViewController: PieChartProtocol {
    func updateValueForPieChart(players: [String], goals: [Int]) {
        pieCHart?.customizeBarChart(dataPoints: players, values: goals.map { Double($0) })
    }
}

extension HomeViewController: CameraHelperProtocol {
    func camera(navController: UIViewController) {
        cameraHelper?.setupCamera(navController: navController)
    }
}
