//
//  CreditProgressDetailViewController.swift
//  Mirror Lender
//
//  Created by Waheguru on 05/09/18.
//  Copyright © 2018 Pollysys. All rights reserved.
//

import Foundation
import UIKit
import SwiftCharts


class CreditProgressDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
   
    @IBOutlet var viewList: UIView!
    @IBOutlet var viewGraph: UIView!
    @IBOutlet var scCredit: UISegmentedControl!
    @IBOutlet var viewDiagramatic: UIView!
    
    fileprivate var chart: Chart? // arc

    
    override func viewDidLoad()
    {
        self.title = "Credit Progress"
        
        let btnBack = UIButton()
        btnBack.setImage(UIImage(named: "Back"), for: .normal)
        
        btnBack.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        btnBack.addTarget(self, action: #selector(CreditProgressDetailViewController.moveBack), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = btnBack
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        
        let chartPoints = [(2, 2), (4, 4), (5, 6), (8, 10)].map{ChartPoint(x: ChartAxisValueInt($0.0), y: ChartAxisValueInt(Int($0.1)))}
        
        let chartPoints2 = [(2, 3), (4, 5), (6, 7), (8, 2)].map{ChartPoint(x: ChartAxisValueInt(Int($0.0)), y: ChartAxisValueInt(Int($0.1)))}
        
        let xValues = ChartAxisValuesStaticGenerator.generateXAxisValuesWithChartPoints(chartPoints, minSegmentCount: 7, maxSegmentCount: 7, multiple: 1, axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: labelSettings)}, addPaddingSegmentIfEdge: false)
        let yValues = ChartAxisValuesStaticGenerator.generateYAxisValuesWithChartPoints(chartPoints, minSegmentCount: 5, maxSegmentCount: 10, multiple: 1, axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: labelSettings)}, addPaddingSegmentIfEdge: true)

        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Loan Amount", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Loan Duration", settings: labelSettings.defaultVertical()))
        
  
        
        let chartFrame = ExamplesDefaults.chartFrame(viewGraph.bounds)
        
        var chartSettings = ExamplesDefaults.chartSettings // for now no zooming and panning here until ChartShowCoordsLinesLayer is improved to not scale the lines during zooming.
        chartSettings.top = 0
        chartSettings.trailing = 0
        chartSettings.labelsToAxisSpacingX = 15
        chartSettings.labelsToAxisSpacingY = 15
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        
        let labelWidth: CGFloat = 70
        let labelHeight: CGFloat = 30
        
        let showCoordsTextViewsGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in
            let (chartPoint, screenLoc) = (chartPointModel.chartPoint, chartPointModel.screenLoc)
            let text = chartPoint.description
            let font = ExamplesDefaults.labelFont
            let x = min(screenLoc.x + 5, chart.bounds.width - text.width(font) - 5)
            let view = UIView(frame: CGRect(x: x, y: screenLoc.y - labelHeight, width: labelWidth, height: labelHeight))
            let label = UILabel(frame: self.viewGraph.bounds)
            label.text = text
            label.font = ExamplesDefaults.labelFont
            view.addSubview(label)
            view.alpha = 0
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                view.alpha = 1
            }, completion: nil)
            
            return view
        }
        
        let showCoordsLinesLayer = ChartShowCoordsLinesLayer<ChartPoint>(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: chartPoints)
        
        let showCoordsTextLayer = ChartPointsSingleViewLayer<ChartPoint, UIView>(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, innerFrame: innerFrame, chartPoints: chartPoints, viewGenerator: showCoordsTextViewsGenerator, mode: .custom, keepOnFront: true)
        // To preserve the offset of the notification views from the chart point they represent, during transforms, we need to pass mode: .custom along with this custom transformer.
        showCoordsTextLayer.customTransformer = {(model, view, layer) -> Void in
            guard let chart = layer.chart else {return}
            
            let text = model.chartPoint.description
            
            let screenLoc = layer.modelLocToScreenLoc(x: model.chartPoint.x.scalar, y: model.chartPoint.y.scalar)
            let x = min(screenLoc.x + 5, chart.bounds.width - text.width(ExamplesDefaults.labelFont) - 5)
            
            view.frame.origin = CGPoint(x: x, y: screenLoc.y - labelHeight)
        }
        
        let touchViewsGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in
            let (chartPoint, screenLoc) = (chartPointModel.chartPoint, chartPointModel.screenLoc)
            let s: CGFloat = 30
            let view = HandlingView(frame: CGRect(x: screenLoc.x - s/2, y: screenLoc.y - s/2, width: s, height: s))
            view.touchHandler = {[weak showCoordsLinesLayer, weak showCoordsTextLayer, weak chartPoint, weak chart] in
                guard let chartPoint = chartPoint, let chart = chart else {return}
                showCoordsLinesLayer?.showChartPointLines(chartPoint, chart: chart)
                showCoordsTextLayer?.showView(chartPoint: chartPoint, chart: chart)
            }
            return view
        }
        
       
        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: UIColor(red: 148.0/255.0, green: 148.0/255.0, blue: 148.0/255.0, alpha: 1.0), lineWidth: 2, animDuration: 0.7, animDelay: 0)
        
        let lineModel2 = ChartLineModel(chartPoints: chartPoints2, lineColor: UIColor.lightGray, lineWidth: 2, animDuration: 0.7, animDelay: 0)
        
        let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lineModels: [lineModel, lineModel2])
        
        let circleViewGenerator = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in
            let circleView = ChartPointEllipseView(center: chartPointModel.screenLoc, diameter: 18)
            circleView.animDuration = 1.5
            circleView.fillColor = UIColor(red: 25.0/255.0, green: 25.0/255.0, blue: 112.0/255.0, alpha: 1.0)
            circleView.borderWidth = 5
            circleView.borderColor = UIColor(red: 25.0/255.0, green: 25.0/255.0, blue: 112.0/255.0, alpha: 1.0)
            return circleView
        }
        
        let circleViewGenerator2 = {(chartPointModel: ChartPointLayerModel, layer: ChartPointsLayer, chart: Chart) -> UIView? in
            let circleView = ChartPointEllipseView(center: chartPointModel.screenLoc, diameter: 18)
            circleView.animDuration = 1.5
            circleView.fillColor = UIColor(red: 60.0/255.0, green: 203.0/255.0, blue: 62.0/255.0, alpha: 1.0)
            circleView.borderWidth = 5
            circleView.borderColor = UIColor(red: 60.0/255.0, green: 203.0/255.0, blue: 62.0/255.0, alpha: 1.0)
            return circleView
        }
        
        let chartPointsCircleLayer = ChartPointsViewsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: chartPoints, viewGenerator: circleViewGenerator, displayDelay: 0, delayBetweenItems: 0.05, mode: .translate)
        
        let chartPointsCircleLayer2 = ChartPointsViewsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: chartPoints2, viewGenerator: circleViewGenerator2, displayDelay: 0, delayBetweenItems: 0.05, mode: .translate)
        
        let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.black, linesWidth: ExamplesDefaults.guidelinesWidth)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: settings)
        
        
        let chart = Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: [
                xAxisLayer,
                yAxisLayer,
                guidelinesLayer,
                showCoordsLinesLayer,
                chartPointsLineLayer,
                chartPointsCircleLayer,
                chartPointsCircleLayer2,
                //                showCoordsTextLayer,
                //                touchLayer,
                
            ]
        )
        
        viewGraph.addSubview(chart.view)
        self.chart = chart
    }
    
    @objc func moveBack()
    {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changeSelectionTab(_ sender: Any)
    {
        switch scCredit.selectedSegmentIndex {
        case 0:
           viewList.isHidden = true
            viewDiagramatic.isHidden = false
        case 1:
            viewList.isHidden = false
            viewDiagramatic.isHidden = true
        default:
            break;
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pastHistory") as! PaymentHistoryTableViewCell
        cell.selectionStyle = .none  
        
        return cell
    }
    
  
}
