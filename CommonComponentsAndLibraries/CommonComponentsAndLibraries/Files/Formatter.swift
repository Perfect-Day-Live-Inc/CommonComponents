//
//  Formatter.swift
//  
//
//  Created by MacBook Retina on 10/25/17.
//  Copyright © 2017 Appiskey. All rights reserved.
//

import Foundation
import Swift

//MARK: Time Cases
///This enum is use to check or convert time format from 12hrs to 24hrs or 24hrs to 12hrs
enum timeFormat : String{
    case Hrs12 = "en_US"
    case Hrs24 = "en_GB"
}

///this class contains time formats which are use in whole application
class Formatter{
    
    enum DateFormatsForApp : String{
        case dateFormattor = "d MMM yyyy"
        case fullDateComaAndTime = "d MMM yyyy, hh:mm a"
        case dateFormattorWithComma = "d MMM, yyyy"
        case onlyDateFormattor = "yyyy-MM-dd"
        case utcDateTimeFormattor = "yyyy-MM-dd HH:mm:ss"
        case onlyTimeWithSecond = "HH:mm:ss"
        case TimeFormattor12Hrs = "hh:mm a"
        case TimeFormattor24Hrs = "HH:mm"
        case dateTimeFormatterWithoutDay = "d MMM, HH:mm"
        case dateTimeFormatterWithDay = "EEEE, MMM d, yyyy"
        case monthThenDayThenYear = "MMM d, yyyy"
        case onlyYearAndMonthFirstYear = "yyyy-MM"
        case onlyYearAndMonthFirstMonth = "MMMM yyyy"
    }
    private var appTimeFormat : timeFormat = .Hrs24

    private init() {}
    static let getInstance = Formatter()

    ///this function change the whole app time format as 24 hrs or 12 hrs
    func changeAppTimeFormat(format : timeFormat){
        appTimeFormat = format
    }

    ///this function can get the whole app time format as 24 hrs or 12 hrs
    func getAppTimeFormat() -> timeFormat{
        return appTimeFormat
    }
    
    ///this function returns time format for only seconds
    func getOnlyTimeWithSecond() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatsForApp.onlyTimeWithSecond.rawValue
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    ///this function returns time format for only seconds
    func getfullDateComaAndTime() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatsForApp.fullDateComaAndTime.rawValue
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    ///this function returns time format for only month and year utc
    func onlyYearAndMonthFirstYear() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatsForApp.onlyYearAndMonthFirstYear.rawValue
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    ///this function returns time format for only month and year
    func onlyYearAndMonthFirstMonth() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatsForApp.onlyYearAndMonthFirstMonth.rawValue
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    ///this function returns time format in utc
    func getUTCDateTimeFormattor() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatsForApp.utcDateTimeFormattor.rawValue
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }
    
    ///this function returns time format for only date in utc
    func getOnlyDateFormattor() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatsForApp.onlyDateFormattor.rawValue
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    ///this function returns time format for upcoming ride style date
    func monthThenDayThenYear() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatsForApp.monthThenDayThenYear.rawValue
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    ///this function returns time format for only month and year utc
    func dateTimeFormatterWithDay() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatsForApp.dateTimeFormatterWithDay.rawValue
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    ///this function returns time format in only 12hrs format
    func get12HrsTimeFormattor() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatsForApp.TimeFormattor12Hrs.rawValue
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    ///this function returns time format in only 24hrs format
    func get24HrsTimeFormattor() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatsForApp.TimeFormattor24Hrs.rawValue
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    ///this function returns time format in app date format style
    func getAppDateFormattor() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatsForApp.dateFormattor.rawValue
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    ///this function returns Date Format with comma style e.g: 22, Jan, 2018
    func getAppDateFormattorWithComma() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatsForApp.dateFormattorWithComma.rawValue
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    ///this function returns time format with ride style
    func dateTimeFormatterWithoutDay() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatsForApp.dateTimeFormatterWithoutDay.rawValue
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    ///this function convert date to time
    func convertDateToTime(date: Date) -> String{
        if self.appTimeFormat == .Hrs12{
            let time = get12HrsTimeFormattor().string(from: date)
            return time
        }else{
            let time = get24HrsTimeFormattor().string(from: date)
            return time
        }
    }
    
    static func convertDateToString(format: DateFormatsForApp, dateToConvert: Date, isUTC: Bool=false) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        if isUTC{
            formatter.timeZone = TimeZone(abbreviation: "UTC")
        }else{
            formatter.timeZone = TimeZone.current
        }
        return formatter.string(from: dateToConvert)
    }
    
    static func convertStringToDate(format: DateFormatsForApp, stringToConvert: String, isUTC: Bool=false) -> Date?{
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        if isUTC{
            formatter.timeZone = TimeZone(abbreviation: "UTC")
        }else{
            formatter.timeZone = TimeZone.current
        }
        if let date = formatter.date(from: stringToConvert){
            return date
        }else{
            return nil
        }
    }
    
    static func convertStringToViewableString(format: DateFormatsForApp, formatToShow: DateFormatsForApp, stringToConvert: String, isUTC: Bool=false) -> String?{
        if let date = Formatter.convertStringToDate(format: format, stringToConvert: stringToConvert, isUTC: isUTC){
            let formatter = DateFormatter()
            formatter.dateFormat = formatToShow.rawValue
            formatter.timeZone = TimeZone.current
            let strDate = formatter.string(from: date)
            return strDate
        }else{
            return nil
        }
    }
    
    static func getDateToShowableFormatWithTimeAgo(string: String, showableFormat: DateFormatsForApp) -> String?{
        
        if let date = Formatter.convertStringToDate(format: Formatter.DateFormatsForApp.utcDateTimeFormattor,
                                                    stringToConvert: string, isUTC: true){
            let dateToShow = Formatter.convertStringToViewableString(format: Formatter.DateFormatsForApp.utcDateTimeFormattor,
                                                                     formatToShow: showableFormat,
                                                                     stringToConvert: string) ?? ""
            let timeAgo = Formatter.timeAgoSinceDate(date: date,
                                                     currentDate: Date(), numericDates: false)
            return dateToShow + ", " + timeAgo
        }
        return nil
    }
    
    ///this function return timesAgo from date
    static func timeAgoSinceDate(date:Date,currentDate:Date, numericDates:Bool) -> String {
        let calendar = Calendar.current
        let now = currentDate
        let earliest = (now as NSDate).earlierDate(date)
        let latest = (earliest == now) ? date : now
        var components:DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute , NSCalendar.Unit.hour , NSCalendar.Unit.day , NSCalendar.Unit.weekOfYear , NSCalendar.Unit.month , NSCalendar.Unit.year , NSCalendar.Unit.second], from: earliest, to: latest, options: NSCalendar.Options())
        if (components.year! >= 2) {
            return "\(components.year!) years ago"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1 year ago"
            } else {
                return "Last year"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!) months ago"
        } else if (components.month! >= 1){
            if (numericDates){
                return "1 month ago"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) weeks ago"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1 week ago"
            } else {
                return "Last week"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) days ago"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) hours ago"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!) minutes ago"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1 minute ago"
            } else {
                return "A minute ago"
            }
        } else if (components.second! >= 3) {
            return "\(components.second!) seconds ago"
        } else {
            return "Just now"
        }
        
    }

}

///Contains custom variable to get startOfDay
extension Date{
    
    ///it will contain start of day of Date
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
}
