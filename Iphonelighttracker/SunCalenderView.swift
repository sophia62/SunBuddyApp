//
//  SunCalendarView.swift
//  Iphonelighttracker
//
//  Created by Sophia Beebe on 12/2/25.
//

import SwiftUI

struct SunCalendarView: View {
    @State private var selectedDate: Date = Date()
    @State private var showMonthPicker = false

    private var calendar: Calendar { Calendar.current }

    private var monthYearFormatter: DateFormatter {
        let f = DateFormatter()
        f.dateFormat = "MMMM yyyy"
        return f
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 16) {
                Text("Sun Calendar")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 8)
                    .padding(.horizontal, 24)

                HStack {
                    Button {
                        changeMonth(by: -1)
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.white.opacity(0.1))
                            .clipShape(Circle())
                    }

                    Spacer()

                    Button {
                        showMonthPicker.toggle()
                    } label: {
                        HStack(spacing: 6) {
                            Text(monthYearFormatter.string(from: selectedDate))
                                .font(.system(size: 18, weight: .semibold))
                            Image(systemName: "calendar")
                                .font(.system(size: 16))
                        }
                        .foregroundColor(.white)
                    }

                    Spacer()

                    Button {
                        changeMonth(by: 1)
                    } label: {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.white.opacity(0.1))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, 24)

                HStack {
                    ForEach(["S", "M", "T", "W", "T", "F", "S"], id: \.self) { day in
                        Text(day)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal, 24)

                VStack(spacing: 12) {
                    ForEach(0..<5) { row in
                        HStack(spacing: 10) {
                            ForEach(0..<7) { col in
                                let index = row * 7 + col + 1
                                calendarDayCell(day: index)
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)

                RoundedRectangle(cornerRadius: 18)
                    .fill(Color(.darkGray).opacity(0.8))
                    .frame(height: 120)
                    .padding(.horizontal, 24)
                    .overlay(
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Weekly Summary")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)

                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Average")
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundColor(.gray)
                                    Text("1h 42m / day")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.white)
                                }

                                Spacer()

                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Best day")
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundColor(.gray)
                                    Text("Sat · 3h 12m")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.white)
                                }

                                Spacer()
                            }
                        }
                        .padding(.horizontal, 20)
                    )

                Spacer()
            }
        }
        .sheet(isPresented: $showMonthPicker) {
            MonthPickerView(selectedDate: $selectedDate)
        }
    }

    private func calendarDayCell(day: Int) -> some View {
        let hasSun = day % 3 != 0
        let isToday = day == 14

        return VStack(spacing: 6) {
            Text("\(day)")
                .font(.system(size: 14, weight: isToday ? .bold : .medium))
                .foregroundColor(isToday ? .white : .gray)

            if hasSun {
                Capsule()
                    .fill(isToday ? Color.red : Color.green)
                    .frame(width: 22, height: 6)
            } else {
                Capsule()
                    .fill(Color.gray.opacity(0.4))
                    .frame(width: 22, height: 6)
            }
        }
        .frame(width: 36, height: 44)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isToday ? Color.white.opacity(0.1) : Color.clear)
        )
    }

    private func changeMonth(by offset: Int) {
        if let newDate = calendar.date(byAdding: .month, value: offset, to: selectedDate) {
            selectedDate = newDate
        }
    }
}

struct MonthPickerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedDate: Date

    private var calendar: Calendar { Calendar.current }

    var body: some View {
        NavigationStack {
            List {
                ForEach(-6...6, id: \.self) { offset in
                    if let monthDate = calendar.date(byAdding: .month, value: offset, to: Date()) {
                        Button {
                            selectedDate = monthDate
                            dismiss()
                        } label: {
                            Text(monthLabel(for: monthDate))
                        }
                    }
                }
            }
            .navigationTitle("Select Month")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }

    private func monthLabel(for date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "MMMM yyyy"
        return f.string(from: date)
    }
}

#Preview {
    SunCalendarView()
}
