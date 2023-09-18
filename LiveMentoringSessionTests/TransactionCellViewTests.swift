//
//  TransactionCellViewTests.swift
//  LiveMentoringSessionTests
//
//  Created by Ryan Neil Stroud on 18/9/2023.
//

import XCTest
import LiveMentoringSession
import ViewInspector

final class TransactionCellViewTests: XCTestCase {

    func test_cellCountdown() {
        let timer = TimerMock()
        let currentDate = Date()
        var currentDateCount: TimeInterval = 0
        let model = TransactionModel(
            id: UUID().uuidString,
            description: "Some description",
            optionalProperty: nil,
            expirationDate: Date() + 5)
        let sut = TransactionCellView(
            viewModel: TransactionCellViewModel(
                model: model,
                timer: timer,
            getCurrentDate: {
                defer { currentDateCount += 1 }
                return currentDate + currentDateCount
            }),
            tap: {})
        
        let expectedExpirationDates = [
            "0h 0m 5s",
            "0h 0m 4s",
            "0h 0m 3s"
        ]
        
        for expectedExpirationDate in expectedExpirationDates {
            timer.fire()
            
            let actualExpirationDate = try! sut.inspect().find(viewWithId: "12345").text().string()
            XCTAssertEqual(expectedExpirationDate, actualExpirationDate)
        }
    }
    
    class TimerMock: Timeable {
        private var timer: Timer?
        var block: ((Timer) -> Void)?
        
        init() {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timer in
                self?.block?(timer)
            })
        }
        
        func fire() {
            timer?.fire()
        }
    }
}
