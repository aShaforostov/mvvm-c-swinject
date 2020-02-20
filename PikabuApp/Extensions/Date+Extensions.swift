//
//  Date+Extensions.swift
//  PikabuApp
//
//  Created by Alexey Shaforostov on 20.02.2020.
//  Copyright © 2020 Alex Hafros. All rights reserved.
//

import Foundation

extension Date {

    func timeAgoSinceDate() -> String {

        let fromDate = self

        let toDate = Date()

        if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0 {

            return interval == 1 ? "\(interval)" + " " + "Год назад" : "\(interval)" + " " + "лет назад"
        }

        if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0 {

            return interval == 1 ? "\(interval)" + " " + "Месяц назад" : "\(interval)" + " " + "месяцев назад"
        }

        if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0 {

            return interval == 1 ? "\(interval)" + " " + "Вчера" : "\(interval)" + " " + "дня назад"
        }

        if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {

            return interval == 1 ? "\(interval)" + " " + "Час назад" : "\(interval)" + " " + "часов назад"
        }

        if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {

            return interval == 1 ? "\(interval)" + " " + "Минуту назад" : "\(interval)" + " " + "минут назад"
        }

        return "Только что"
    }
}
