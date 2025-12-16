//
//  TransactionListViewModelTests.swift
//  FinTrackTests
//
//  Created by Diggo Silva on 15/12/25.
//

import XCTest
@testable import FinTrack

final class TransactionListViewModelTests: XCTestCase {
    
    private var repository: MockRepository!
    private var sut: TransactionListViewModel!
    
    override func setUp() {
        super.setUp()
        repository = MockRepository()
    }
    
    override func tearDown() {
        repository = nil
        sut = nil
        super.tearDown()
    }
    
    func testLoadTransactions_withEmptyRepository_resultsEmptySections() {
        repository.savedTransactions = []

        sut = TransactionListViewModel(repository: repository)

        XCTAssertTrue(sut.transactions.isEmpty, "transactions deve estar vazio quando o repositório não tem itens")
        XCTAssertEqual(sut.numberOfSections(), 0, "não deve haver seções")
    }
    
    func testLoadTransactions_withOneTransaction_populatesSectionAndRow() {
        let date = makeDate(year: 2025, month: 3, day: 5)
        let transaction = TransactionModel(date: date, income: 10.5, expense: 0.0)
        
        repository.savedTransactions = [transaction]
        
        sut = TransactionListViewModel(repository: repository)
        
        XCTAssertEqual(sut.numberOfSections(), 1, "deve haver uma seção")
        XCTAssertEqual(sut.numberOfRows(in: 0), 1)
        XCTAssertEqual(sut.transactions.count, 1)
        
        let fetched = sut.transactionForRow(in: 0, at: 0)
        XCTAssertEqual(fetched.income, 10.5)
        XCTAssertEqual(fetched.expense, 0.0)
        XCTAssertEqual(fetched.date, date)
        
        let expectedTitle = transaction.date.toMonthAndYear()
        XCTAssertEqual(sut.titleForSection(at: 0), expectedTitle)
    }
    
    func testLoadTransactions_groupsByMonth_andSortsTransactionsByDateDescending() {
        let date1 = makeDate(year: 2025, month: 3, day: 10)
        let date2 = makeDate(year: 2025, month: 3, day: 5)
        let date3 = makeDate(year: 2025, month: 2, day: 20)
        
        let transaction1 = TransactionModel(date: date1, income: 1.0, expense: 0.0)
        let transaction2 = TransactionModel(date: date2, income: 2.0, expense: 0.0)
        let transaction3 = TransactionModel(date: date3, income: 3.0, expense: 0.0)
        
        repository.savedTransactions = [transaction1, transaction2, transaction3]
        
        sut = TransactionListViewModel(repository: repository)
        
        XCTAssertEqual(sut.numberOfSections(), 2, "Devem existir 2 seções (Março e Fevereiro)")
        
        // Verifica que a primeira seção é Março (mais recente) e a segunda Fevereiro
        let firstSectionTitle = sut.titleForSection(at: 0)
        let secondSectionTitle = sut.titleForSection(at: 1)
        XCTAssertEqual(firstSectionTitle, date1.toMonthAndYear())
        XCTAssertEqual(secondSectionTitle, date3.toMonthAndYear())
        
        // Na seção de Março, as transações devem estar ordenadas por data desc
        XCTAssertEqual(sut.numberOfRows(in: 0), 2)
        let firstInMarch = sut.transactionForRow(in: 0, at: 0)
        let secondInMarch = sut.transactionForRow(in: 0, at: 1)
        XCTAssertEqual(firstInMarch.date, date1)
        XCTAssertEqual(secondInMarch.date, date2)
    }
}
