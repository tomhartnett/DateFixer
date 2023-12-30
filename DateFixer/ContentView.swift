//
//  ContentView.swift
//  DateFixer
//
//  Created by Tom Hartnett on 10/25/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("referenceDate1") private var referenceDate1String = ""
    @AppStorage("referenceDate2") private var referenceDate2String = ""
    @AppStorage("inputDate") private var inputDateString = ""

    @State private var referenceDate1 = Date()
    @State private var referenceDate2 = Date()
    @State private var inputDate = Date()
    @State private var correctedDate = ""

    var plusOrMinus: String {
        referenceDate1 < referenceDate2 ? "+=" : "-="
    }

    var offset: String {
        let comps = Calendar.autoupdatingCurrent.dateComponents([.year, .month, .day, .hour, .minute],
                                                                from: referenceDate1,
                                                                to: referenceDate2)

        let year = abs(comps.year ?? 0)
        let month = abs(comps.month ?? 0)
        let day = abs(comps.day ?? 0)
        let hour = abs(comps.hour ?? 0)
        let minute = abs(comps.minute ?? 0)

        return "\(year):\(month):\(day) \(hour):\(minute):0"
    }

    var body: some View {
        VStack {
            DatePicker(selection: $referenceDate1, displayedComponents: [.date, .hourAndMinute]) {
                Text("Reference date 1")
            }
            .padding(.vertical)
            .onChange(of: referenceDate1) { _, _ in
                calculate()
                saveDates()
            }

            DatePicker(selection: $referenceDate2, displayedComponents: [.date, .hourAndMinute]) {
                Text("Reference date 2")
            }
            .padding(.vertical)
            .onChange(of: referenceDate2) { _, _ in
                calculate()
                saveDates()
            }

            HStack(spacing: 16) {
                Text("\(plusOrMinus) \(offset)")
                Button("Copy") {
                    UIPasteboard.general.string = offset
                }
            }

            Divider()
                .padding(.vertical)

            DatePicker(selection: $inputDate, displayedComponents: [.date, .hourAndMinute]) {
                Text("Input date")
            }
            .padding(.vertical)
            .onChange(of: inputDate) { _, _ in
                calculate()
                saveDates()
            }

            VStack {
                Text(correctedDate)
                Text("Corrected date")
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical)

            Spacer()
        }
        .padding()
        .onAppear {
            restoreDates()
            calculate()
        }
    }

    func calculate() {
        let correctionInterval = referenceDate2.timeIntervalSince(referenceDate1)
        correctedDate = DateFormatter.mediumDateTimeFormatter.string(
            from: inputDate.addingTimeInterval(correctionInterval)
        )
    }

    func restoreDates() {
        if let date = DateFormatter.iso8601Formatter.date(from: referenceDate1String) {
            referenceDate1 = date
        }

        if let date = DateFormatter.iso8601Formatter.date(from: referenceDate2String) {
            referenceDate2 = date
        }

        if let date = DateFormatter.iso8601Formatter.date(from: inputDateString) {
            inputDate = date
        }
    }

    func saveDates() {
        referenceDate1String = DateFormatter.iso8601Formatter.string(from: referenceDate1)
        referenceDate2String = DateFormatter.iso8601Formatter.string(from: referenceDate2)
        inputDateString = DateFormatter.iso8601Formatter.string(from: inputDate)
    }
}

#Preview {
    ContentView()
}
