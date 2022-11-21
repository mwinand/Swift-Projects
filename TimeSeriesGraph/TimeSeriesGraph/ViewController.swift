//
//  ViewController.swift

//

import Cocoa
import Tin


class ViewController: TController {

    var scene: Scene!
    
    override func viewWillAppear() {
        super.viewWillAppear()
        view.window?.title = "Time Series Data Graph"
        makeView(width: 1200.0, height: 800.0)
        scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}   // end of ViewController class


enum DataSeriesType {
    case milk
    case tea
    case coffee
}


class Scene: TScene {
    var font = TFont(fontName: "Times New Roman", ofSize: 16.0)
    var headfont = TFont(fontName: "Times New Roman", ofSize: 38.0)
    var datafont = TFont(fontName: "Times New Roman", ofSize: 16.0)
    var series = DataSeries(contentsOfFile: "milk-tea-coffee.csv")
    let margins = 150.0
    var graphX = 0.0
    var graphY = 0.0
    var graphWidth = 0.0
    var graphHeight = 0.0
    var graphX2 = 0.0
    var graphY2 = 0.0

    
    override func setup() {
        
        // one time setup here
        font.horizontalAlignment = .left
        graphX = margins
        graphY = margins
        graphWidth = tin.width - (margins * 2.0)
        graphHeight = tin.height - (margins * 2.0)
        graphX2 = graphX + graphWidth
        graphY2 = graphY + graphHeight
    }   // end of the setup function
    
    
    override func update() {
        background(gray: 0.85)
        
        // drawing goes here
        strokeColor(gray: 0)
        fillColor(gray: 0.9)
        rect(x: graphX, y: graphY, width: graphWidth - 52.5, height: graphHeight - 32.5)
        
        xValueLabels()
        yValueLabels()
        
        strokeColor(red: 1, green: 0.5529, blue: 0.0471, alpha: 1.0)
        drawLine(valueType: .milk)
        
        strokeColor(red: 0.0314, green: 0.6392, blue: 0.1294, alpha: 1.0)
        drawLine(valueType: .tea)
        
        strokeColor(red: 0.0353, green: 0.1373, blue: 0.7765, alpha: 1.0)
        drawLine(valueType: .coffee)
        
        drawTitle()
        
    }   // end of the update function
    
    func drawLine(valueType: DataSeriesType) {
        var px = graphX
        var py = graphY
        var index = 0.0
        
        lineWidth(1)
        
        for point in series.data {
            let x = remap(value: Double(index), start1: 0, stop1: 100, start2: graphX + 5.0, stop2: graphX2 - 5.0)
            var y: Double
            fillDisable()
            //let y1: Double
            //let y2: Double
            //let y3: Double
            
            switch valueType {
            case .milk:
                y = remap(value: Double(point.milk), start1: 5.0, stop1: 50.0, start2: graphY, stop2: graphY2)
                ellipse(centerX: x, centerY: y, width: 5.0, height: 5.0)
            case .tea:
                y = remap(value: Double(point.tea), start1: 5.0, stop1: 50.0, start2: graphY, stop2: graphY2)
                ellipse(centerX: x, centerY: y, width: 5.0, height: 5.0)
            case .coffee:
                y = remap(value: Double(point.coffee), start1: 5.0, stop1: 50.0, start2: graphY, stop2: graphY2)
                rect(x: x, y: y, width: 5.0, height: 5.0)
            }
            
            if index > 0 {
                line(x1: px, y1: py, x2: x, y2: y)
            }
            
            // ** I tried replicate your example graph, but couldn't figure out how to
            // ** draw different shapes since inserting the fucntion in each case didn't work.
            // ** because I couldn't figure out how to use line before the other shapes to
            // ** avoid overlaping. Thank you, this was fun. I've been doing this assignment
            // ** for hours and enjoyed every minute.
            
            px = x
            py = y
            index += 1
        }
    }
    
    func xValueLabels() {
        lineWidth(1)
        font.horizontalAlignment = .center
        font.verticalAlignment = .top
        for vx in stride(from: 0, to: 100, by: 10) {
            
            strokeColor(gray: 0.75)
            let x = remap(value: Double(vx), start1: 0, stop1: 100, start2: graphX + 5.0, stop2: graphX2 - 5.0)
            line(x1: x, y1: graphY, x2: x, y2: graphY2 - 30.0)
            
            fillColor(gray: 0.01)
            strokeDisable()
            
            let printyear = series.data[vx]
            text(message: "\(printyear.year)", font: font, x: x, y: graphY - 5.0)
            
        }
        
    }
    
    //function that draws the vertical lines of the graph
    func yValueLabels() {
        lineWidth(1)
        font.horizontalAlignment = .right
        font.verticalAlignment = .center
        for vy in stride(from: 5, to: 50, by: 5) {
            
            strokeColor(gray: 0.75)
            let y = remap(value: Double(vy), start1: 5.0, stop1: 50.0, start2: graphY + 5.0, stop2: graphY2 - 5.0)
            line(x1: graphX, y1: y, x2: graphX2 - 55.0, y2: y)
            
            fillColor(gray: 0.01)
            strokeDisable()
            text(message: "\(vy)", font: font, x: graphX - 5.0, y: y)
            
        }
        
    }
    
    func drawTitle() {
        fillColor(gray: 0.01)
        
        headfont.horizontalAlignment = .center
        text(message: "Milk / Tea / Coffee", font: headfont, x: tin.midX - 50.0, y: tin.height - 100.0)
        datafont.horizontalAlignment = .center
        text(message: "Year", font: datafont, x: tin.midX, y: tin.height - 700.0)
        datafont.horizontalAlignment = .left
        text(message: "Gallons", font: datafont, x: tin.width - 1146, y: tin.height - 355.0)
        text(message: "consumed", font: datafont, x: tin.width - 1150, y: tin.height - 375.0)
        text(message: "per capita", font: datafont, x: tin.width - 1148, y: tin.height - 395.0)
        
        fillColor(red: 1, green: 0.5529, blue: 0.0471, alpha: 1.0)
        text(message: "Milk", font: datafont, x: tin.midX - 500.0, y: tin.height - 750.0)
        line(x1: tin.midX - 465.0, y1: tin.height - 747.5, x2: tin.midX - 430.0, y2: tin.height - 747.5)
        fillColor(gray: 0.85)
        strokeColor(red: 1, green: 0.5529, blue: 0.0471, alpha: 1.0)
        ellipse(centerX: tin.midX - 447.5, centerY: tin.height - 747.5, width: 5.0, height: 5.0)
        
        fillColor(red: 0.0314, green: 0.6392, blue: 0.1294, alpha: 1.0)
        text(message: "Tea", font: datafont, x: tin.midX - 400.0, y: tin.height - 750.0)
        line(x1: tin.midX - 365.0, y1: tin.height - 747.5, x2: tin.midX - 330.0, y2: tin.height - 747.5)
        fillColor(gray: 0.85)
        strokeColor(red: 0.0314, green: 0.6392, blue: 0.1294, alpha: 1.0)
        ellipse(centerX: tin.midX - 347.5, centerY: tin.height - 747.5, width: 5.0, height: 5.0)
        
        fillColor(red: 0.0353, green: 0.1373, blue: 0.7765, alpha: 1.0)
        text(message: "Coffee", font: datafont, x: tin.midX - 300.0, y: tin.height - 750.0)
        line(x1: tin.midX - 245.0, y1: tin.height - 747.5, x2: tin.midX - 210.0, y2: tin.height - 747.5)
        fillColor(gray: 0.85)
        strokeColor(red: 0.0353, green: 0.1373, blue: 0.7765, alpha: 1.0)
        ellipse(centerX: tin.midX - 227.5, centerY: tin.height - 747.5, width: 5.0, height: 5.0)
    }
}   // end of Scene class
