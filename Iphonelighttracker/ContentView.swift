//
//  ContentView.swift
//  Iphonelighttracker
//
//  Created by Sophia Beebe on 11/18/25.
//

import SwiftUI

struct MainSunlightView: View {
    enum Tab {
        case today
        case calendar
        case social
        case pro
    }

    @State private var selectedTab: Tab = .today

    // Demo data
    let goalSeconds: Double = 36 * 60 * 60      // 36h goal
    let elapsedSeconds: Double = 13 * 60 * 60 + 35 * 60 + 8

    var progress: Double {
        min(elapsedSeconds / goalSeconds, 1.0)
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                Group {
                    switch selectedTab {
                    case .today:
                        todayPage
                    case .calendar:
                        SunCalendarView()
                    case .social:
                        SunSocialView()
                    case .pro:
                        proPage
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                bottomTabBar
                    .padding(.horizontal, 24)
                    .padding(.bottom, 10)
                    .padding(.top, 8)
            }
            .padding(.top, 8)
        }
    }

    // MARK: - Pages

    private var todayPage: some View {
        VStack(spacing: 0) {
            topStatusBar

            Text("SunZero")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.red)
                .padding(.top, 8)

            weekdayRow
                .padding(.top, 16)

            Spacer(minLength: 24)

            sunlightRing
                .frame(width: 320, height: 320)

            startGoalRow
                .padding(.top, 24)

            endSessionButton
                .padding(.horizontal, 24)
                .padding(.top, 24)

            Spacer()

            challengesSection

            Spacer(minLength: 8)
        }
    }

    private var proPage: some View {
        VStack {
            Text("SunZero Pro")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)
                .padding(.top, 32)

            Text("Advanced analytics, smart recommendations, and custom goals coming soon.")
                .font(.system(size: 15))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .padding(.top, 8)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea())
    }

    // MARK: - Top

    private var topStatusBar: some View {
        HStack {
            Text("10:55")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)

            Spacer()

            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color.gray.opacity(0.6), lineWidth: 1)
                .frame(height: 32)
                .overlay(
                    HStack(spacing: 8) {
                        Image(systemName: "bolt.circle.fill")
                        Text("13:36:03")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                )
        }
        .padding(.horizontal, 16)
    }

    private var weekdayRow: some View {
        HStack(spacing: 24) {
            weekdayDot("WED", isActive: false)
            weekdayDot("THU", isActive: false)
            weekdayDot("FRI", isActive: true)
            weekdayDot("SAT", isActive: false)
            weekdayDot("SUN", isActive: true)
            weekdayDot("MON", isActive: false)
            weekdayDot("TUE", isActive: true)
        }
        .padding(.horizontal, 24)
    }

    private func weekdayDot(_ label: String, isActive: Bool) -> some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.gray)

            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.6), lineWidth: 2)
                    .frame(width: 24, height: 24)

                if isActive {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 18, height: 18)
                }
            }
        }
    }

    // MARK: - Sunlight ring with PNG center

    private var sunlightRing: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.6), lineWidth: 26)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [Color.pink, Color.pink.opacity(0.8)]),
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: 26, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))

            Image("SunIcon") // your PNG asset name in Assets.xcassets
                .resizable()
                .scaledToFit()
                .frame(width: 140, height: 140)
                .clipShape(Circle())
                .overlay(
                    VStack(spacing: 4) {
                        Text(elapsedTimeString)
                            .font(.system(size: 32, weight: .bold, design: .monospaced))
                            .foregroundColor(.white)

                        Text("SUNLIGHT (\(Int(progress * 100))%)")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.white.opacity(0.85))
                    }
                )
        }
        .padding(.horizontal, 24)
    }

    // MARK: - Middle content

    private var startGoalRow: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("STARTED")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.gray)

                roundedPill(text: "MON, 9:19 AM")
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text("36H GOAL")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.gray)

                roundedPill(text: "WED, 9:19 PM")
            }
        }
        .padding(.horizontal, 24)
    }

    private func roundedPill(text: String) -> some View {
        RoundedRectangle(cornerRadius: 18)
            .strokeBorder(Color.gray.opacity(0.7), lineWidth: 1)
            .frame(height: 40)
            .overlay(
                Text(text)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
            )
    }

    private var endSessionButton: some View {
        Button(action: {
            // end sunlight tracking
        }) {
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.gray.opacity(0.25))
                .frame(height: 52)
                .overlay(
                    Text("End Session")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                )
        }
    }

    // MARK: - Challenges

    private var challengesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Challenges")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
                Text("SEE ALL")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 24)

            RoundedRectangle(cornerRadius: 18)
                .fill(Color(.darkGray).opacity(0.7))
                .frame(height: 90)
                .padding(.horizontal, 24)
                .overlay(
                    HStack {
                        ZStack {
                            Circle().fill(Color.blue).frame(width: 44, height: 44)
                            Text("20m")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(.leading, 32)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Join challenges to earn")
                            Text("sunlight achievements")
                        }
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.white.opacity(0.85))

                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white.opacity(0.8))
                            .padding(.trailing, 24)
                    }
                )
        }
        .padding(.top, 24)
    }

    // MARK: - Bottom tab bar

    private var bottomTabBar: some View {
        HStack {
            tabButton(icon: "sun.max.fill", label: "Today", tab: .today)
            Spacer()
            tabButton(icon: "calendar", label: "Calendar", tab: .calendar)
            Spacer()
            tabButton(icon: "person.2.fill", label: "Social", tab: .social)
            Spacer()
            tabButton(icon: "flame.fill", label: "Pro", tab: .pro)
        }
    }

    private func tabButton(icon: String, label: String, tab: Tab) -> some View {
        let isSelected = (selectedTab == tab)

        return Button {
            selectedTab = tab
        } label: {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                Text(label)
                    .font(.system(size: 11, weight: isSelected ? .bold : .medium))
            }
            .foregroundColor(isSelected ? .red : .gray)
        }
    }

    // MARK: - Helpers

    private var elapsedTimeString: String {
        let hours = Int(elapsedSeconds) / 3600
        let minutes = (Int(elapsedSeconds) % 3600) / 60
        let seconds = Int(elapsedSeconds) % 60

        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

#Preview {
    MainSunlightView()
}
