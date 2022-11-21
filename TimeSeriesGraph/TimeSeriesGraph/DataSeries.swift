//
//  WeatherData.swift
//  DataGraph
//
//

import Foundation


// DataSeries is a class that can be used to represent the data in a
// csv file, such as the milk-tea-coffee.csv data file.
class DataSeries {
    
    var data: [SeriesDataPoint]
    
    
    init(contentsOfFile csvName: String) {
        data = []
        if let pathName = Bundle.main.path(forResource: csvName, ofType: "") {
            do {
                let contents = try String(contentsOfFile: pathName)
                let rows = contents.components(separatedBy: "\n")
                print("There are \(rows.count) lines in the file.")
                for index in 1 ..< rows.count {
                    let dataPoint = SeriesDataPoint(line: rows[index])
                    data.append(dataPoint)
                }
            }
            catch {
                print("Error reading \(pathName): \(error.localizedDescription)")
            }
        }
        else {
            print("Unable to locate the file \(csvName)")
        }
    }
    
}

let separators = CharacterSet([",","\r","\n"])

// SeriesDataPoint is an object to represent one line of data values that
// are stored in the milk-tea-coffee.csv data file.
struct SeriesDataPoint {
    var year: Int
    var milk: Double
    var tea: Double
    var coffee: Double
    
    
    init(line: String) {
        year = 0
        milk = 0.0
        tea = 0.0
        coffee = 0.0
        
        let fields = line.components(separatedBy: separators)
        if fields.count >= 4 {
            if let value = Int(fields[0]) {
                year = value
            }
            if let value = Double(fields[1]) {
                milk = value
            }
            if let value = Double(fields[2]) {
                tea = value
            }
            if let value = Double(fields[3]) {
                coffee = value
            }
            //print("\(year), \(milk), \(tea), \(coffee)")
        }
    }
}
