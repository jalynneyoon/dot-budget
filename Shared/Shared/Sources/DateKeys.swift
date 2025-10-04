
import Foundation

/// 키 유틸(집계 최적화)
public enum DateKeys {
    public static func dayKey(from date: Date, calendar: Calendar = .current) -> Int {
        let comps = calendar.dateComponents([.year, .month, .day], from: date)
        return (comps.year! * 10000) + (comps.month! * 100) + comps.day!
    }
    public static func monthKey(from date: Date, calendar: Calendar = .current) -> Int {
        let comps = calendar.dateComponents([.year, .month], from: date)
        return (comps.year! * 100) + comps.month!
    }
}
