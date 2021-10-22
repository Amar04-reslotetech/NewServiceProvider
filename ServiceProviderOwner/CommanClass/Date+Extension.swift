import Foundation

extension Date {
    func toShortTimeString() -> String
    {
        //Get Short Time String
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let timeString = formatter.string(from: self)
        
        //Return Short Time String
        return timeString
    }
    
    func yearsFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.year, from: date, to: self, options: []).year!
    }
    
    func monthsFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.month, from: date, to: self, options: []).month!
    }
    
    func weeksFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.weekOfYear, from: date, to: self, options: []).weekOfYear!
    }
    
    func daysFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.day, from: date, to: self, options: []).day!
    }
    
    func hoursFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.hour, from: date, to: self, options: []).hour!
    }
    
    func minutesFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.minute, from: date, to: self, options: []).minute!
    }
    
    func secondsFrom(_ date: Date) -> Int {
        return (Calendar.current as NSCalendar).components(.second, from: date, to: self, options: []).second!
    }
    
    func offsetFrom(_ date: Date) -> String {
        if yearsFrom(date)   > 0 { return "\(yearsFrom(date))y"   }
        if monthsFrom(date)  > 0 { return "\(monthsFrom(date))M"  }
        if weeksFrom(date)   > 0 { return "\(weeksFrom(date))w"   }
        if daysFrom(date)    > 0 { return "\(daysFrom(date))d"    }
        if hoursFrom(date)   > 0 { return "\(hoursFrom(date))h"   }
        if minutesFrom(date) > 0 { return "\(minutesFrom(date))m" }
        if secondsFrom(date) > 0 { return "\(secondsFrom(date))s" }
        return ""
    }
    
    func dateAt(hours: Int, minutes: Int) -> Date {
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        //get the month/day/year componentsfor today's date.
        var date_components = calendar.components(
            [NSCalendar.Unit.year,
             NSCalendar.Unit.month,
             NSCalendar.Unit.day],
            from: self)
        
        //Create an NSDate for the specified time today.
        date_components.hour = hours
        date_components.minute = minutes
        date_components.second = 0
        
        let newDate = calendar.date(from: date_components)!
        return newDate
    }
    
    private func dd_mmm_yyyy_at_h_mm_a_formattedString() -> String {
        return DateFormatterHelper.dd_mmm_yyyy_at_h_mm_a_Formatter.string(from: self)
    }
    
    func taskDateFormatedString() -> String {
        return dd_mmm_yyyy_at_h_mm_a_formattedString()
    }
    
    func isInCurrentYear() -> Bool {
        let calendar = Calendar.current
        return calendar.component(.year, from: self) == calendar.component(.year, from: Date())
    }
    
    func isInCurrentMonth() -> Bool {
        let calendar = Calendar.current
        if self.isInCurrentYear() {
            return calendar.component(.month, from: self) == calendar.component(.month, from: Date())
        } else {
            return false
        }
    }
    
    func isInCurrentWeek() -> Bool {
        let calendar = Calendar.current
        if self.isInCurrentYear() {
            return calendar.component(.weekOfYear, from: self) == calendar.component(.weekOfYear, from: Date())
        } else {
            return false
        }
    }
    
    var isFromFuture: Bool {
        return self > Date()
    }
    
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
    
    static func defaultDateForEmptyDateTask() -> Date {
        return dateAfter(hours: 0, minutes: 00, seconds: 04)
    }
    
    static func dateAfter(hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date {
        let timeIntervalInSec = hours * 60 * 60 + minutes * 60 + seconds
        let date = Date().addingTimeInterval(TimeInterval(timeIntervalInSec))
        return date
    }
}

class DateFormatterHelper {
    
    static let dd_mmm_yyyy_at_h_mm_a_Format = "dd MMM',' yyyy 'at' h:mm a"
    static let dd_mm_yyyy_Format = "dd MM yyyy"
    
    /// formats to 4 may, 2018 at 7:24 AM form
    static let dd_mmm_yyyy_at_h_mm_a_Formatter: DateFormatter = {
        let dateFormator = DateFormatter()
        dateFormator.dateFormat = dd_mmm_yyyy_at_h_mm_a_Format
        return dateFormator
    }()
}
