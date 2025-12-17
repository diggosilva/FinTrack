//
//  YearSummaryViewModelTests.swift
//  FinTrackTests
//
//  Created by Diggo Silva on 16/12/25.
//

import XCTest
@testable import FinTrack

final class YearSummaryViewModelTests: XCTestCase {
    
    private var repository: MockRepository!
    private var sut: YearSummaryViewModel!
    
    override func setUp() {
        super.setUp()
        repository = MockRepository()
    }
    
    override func tearDown() {
        repository = nil
        sut = nil
        super.tearDown()
    }
    
    func testInitialLoad_includesAll12Months_andZerosWhenNoTransactions() {
        repository.savedTransactions = []
        sut = YearSummaryViewModel(year: 2025, repository: repository)
        
        XCTAssertEqual(sut.numberOfRows(), 12)
        let monthNames = Calendar.current.shortMonthSymbols
        for i in 0..<12 {
            let summary = sut.summaryForMonth(at: i)
            XCTAssertEqual(summary.month, monthNames[i])
            XCTAssertEqual(summary.totalIncome, 0.0)
            XCTAssertEqual(summary.totalExpenses, 0.0)
        }
    }
    
    func testSummaries_calculatesTotalsForMonthsInSelectedYear() {
        let marchDate1 = makeDate(year: 2025, month: 3, day: 15)
        let marchDate2 = makeDate(year: 2025, month: 3, day: 20)
        let fevDate1 = makeDate(year: 2025, month: 2, day: 10)
        
        let transaction1 = TransactionModel(date: marchDate1, income: 100.0, expense: 50.0)
        let transaction2 = TransactionModel(date: marchDate2, income: 10.0, expense: 5.0)
        let transaction3 = TransactionModel(date: fevDate1, income: 20.0, expense: 2.0)
        
        repository.savedTransactions = [transaction1, transaction2, transaction3]
        sut = YearSummaryViewModel(year: 2025, repository: repository)
        XCTAssertEqual(sut.numberOfRows(), 12)
        
        let marchSummary = sut.summaryForMonth(at: 2)
        XCTAssertEqual(marchSummary.totalIncome, 110.0)
        XCTAssertEqual(marchSummary.totalExpenses, 55.0)
        XCTAssertEqual(marchSummary.movement, 165.0)
        
        let febSummary = sut.summaryForMonth(at: 1)
        XCTAssertEqual(febSummary.totalIncome, 20)
        XCTAssertEqual(febSummary.totalExpenses, 2)
        XCTAssertEqual(febSummary.movement, 22)
        
        let janSummary = sut.summaryForMonth(at: 0)
        XCTAssertEqual(janSummary.totalIncome, 0.0)
        XCTAssertEqual(janSummary.totalExpenses, 0.0)
        XCTAssertEqual(janSummary.movement, 0.0)
    }
    
    func testReloadData_updatesSummariesAfterRepositoryChange() {
        // Inicia com repositório vazio
        repository.savedTransactions = []
        sut = YearSummaryViewModel(year: 2024, repository: repository)
        XCTAssertEqual(sut.summaryForMonth(at: 0).totalIncome, 0.0)
        
        // Quando repositório mudou (adiciona uma transação) e chamamos reloadData
        let date = makeDate(year: 2024, month: 7, day: 15)
        let transaction = TransactionModel(date: date, income: 5.0, expense: 1.0)
        repository.savedTransactions = [transaction]
        
        sut.reloadData()
        
        // Então: julho (index 6) deve refletir a nova transação
        let julSummary = sut.summaryForMonth(at: 6)
        XCTAssertEqual(julSummary.totalIncome, 5.0)
        XCTAssertEqual(julSummary.totalExpenses, 1.0)
        XCTAssertEqual(julSummary.movement, 6.0)
    }
}
