# FinTrack

<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.9.1-orange.svg" />
    <img src="https://img.shields.io/badge/Xcode-15.2.X-orange.svg" />
    <img src="https://img.shields.io/badge/platforms-iOS-brightgreen.svg?style=flat" alt="iOS" />
    <a href="https://www.linkedin.com/in/rodrigo-silva-6a53ba300/" target="_blank">
        <img src="https://img.shields.io/badge/LinkedIn-@RodrigoSilva-blue.svg?style=flat" alt="LinkedIn: @RodrigoSilva" />
    </a>
</p>

**FinTrack** is a personal finance tracking app for iOS, developed in Swift using UIKit.  
The app allows users to register incomes and expenses, visualize monthly transactions, and analyze yearly financial summaries with dynamic year selection.

This project was built exclusively for **study purposes**, focusing on UIKit best practices and modern iOS development.

---

## 📱 Screens

| Register | Monthly Summary | Yearly Overview |
| --- | --- | --- |
| ![Register](https://github.com/user-attachments/assets/2307e75d-2a38-4be7-ab99-cfd62f6769b1) | ![Summary](https://github.com/user-attachments/assets/759a053a-a07b-41f5-94f7-02062a6e35e2) | ![Year](https://github.com/user-attachments/assets/994109b2-cc17-4b8c-ba44-22098f60a17e) |

---

## 📑 Contents

- [Features](#features)
- [Requirements](#requirements)
- [Functionalities](#functionalities)
- [Architecture & Tech](#architecture--tech)
- [Setup](#setup)

---

## ✨ Features

- UIKit interface (View Code)
- Bottom Tab Bar navigation
- Income and expense tracking
- Monthly and yearly financial summaries
- Dynamic year selection using a custom picker
- Persistent local storage
- Custom UI components
- Dark Mode support

---

## 📌 Requirements

- iOS 17.0 or later
- Xcode 15.0 or later
- Swift 5.9 or later

---

## ⚙️ Functionalities

- [x] **Register Transactions**
  - Add income (Entrada) and expense (Saída) values
  - Date selection using a custom date picker

- [x] **Monthly Transactions**
  - Transactions grouped by month and year
  - Daily income (green) and expense (red) indicators

- [x] **Yearly Overview**
  - Financial summary for each month of the selected year
  - Monthly balance with total incomes and expenses
  - Year selection using a `UIPickerView` displayed at the top of the screen
  - Automatic data reload when changing the selected year

- [x] **Local Persistence**
  - Data stored using `UserDefaults`

- [x] **Dark Mode Support**
  - Automatically follows system appearance

- [x] **UIKit Based**
  - Built entirely with UIKit
  - Modern `UITableView` usage

---

## 🧱 Architecture & Tech

- UIKit (View Code)
- MVC Architecture
- `UITableView`
- `UIPickerView`
- Custom reusable components
- `UserDefaults`
- `NumberFormatter` for currency
- `Calendar` & `DateComponents` for date handling

---

## 🚀 Setup

Clone the repository:

```
git clone git@github.com:diggosilva/FinTrack.git
```

## 📂 Open the project:

```
cd FinTrack
open FinTrack.xcodeproj
```

## 📌 Notes
This project is intended for learning purposes and does not use any external backend or database.
