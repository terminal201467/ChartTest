//
//  LiveGraphViewController.swift
//  ChartTest
//
//  Created by Jhen Mu on 2022/1/22.
//

import UIKit
import Charts

class LiveGraphViewController: UIViewController{
    
    let lineData = LineChartDataSet(entries: [ChartDataEntry(x: Double(0), y: Double(0))], label: "Data")
    
    let liveGraphView = LiveGraphView()
    
    //MARK:-LifeCycle
    override func loadView() {
        super.loadView()
        view = liveGraphView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setChartViewDelegate()
        setChartViewData()
    }
    
    //MARK:-Methods
    private func setChartViewDelegate(){
        liveGraphView.chartView.delegate = self
    }
    
    //MARK:-ChartViewDate
    private func setChartViewData(){
        lineData.drawCirclesEnabled = false
        lineData.drawFilledEnabled = true
        lineData.drawValuesEnabled = false
        lineData.fillColor = .red
        lineData.setColor(.black)
        lineData.mode = .horizontalBezier
        liveGraphView.chartView.data = LineChartData(dataSet:lineData)
        Timer.scheduledTimer(timeInterval: 0.15, target:self,
                                             selector: #selector(updateCounter),
                                             userInfo: nil, repeats: true)
    }

    var i = 0
    @objc func updateCounter() {
        var x = i
        var y = Int.random(in: -9...14)
        liveGraphView.chartView.data?.addEntry(ChartDataEntry(x:Double(x), y:Double(y)), dataSetIndex: 0)
        liveGraphView.chartView.setVisibleXRange(minXRange: Double(1), maxXRange: Double(8))
        liveGraphView.chartView.notifyDataSetChanged()
        liveGraphView.chartView.moveViewToX(Double(x))
        i = i + 1
    }
}


extension LiveGraphViewController:ChartViewDelegate {
        
}
