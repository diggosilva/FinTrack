//
//  DateTestHelper.swift
//  FinTrack
//
//  Created by Diggo Silva on 15/12/25.
//

import Foundation

func makeDate(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0) -> Date {
    var dc = DateComponents()
    dc.year = year
    dc.month = month
    dc.day = day
    dc.hour = hour
    dc.minute = minute
    return Calendar(identifier: .gregorian).date(from: dc)!
}
