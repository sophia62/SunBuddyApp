//
//  SunSocialView.swift
//  Iphonelighttracker
//
//  Created by Sophia Beebe on 12/2/25.
//


//
//  SunSocialView.swift
//  Iphonelighttracker
//
//  Created by Sophia Beebe on 12/2/25.
//

import SwiftUI

struct SunSocialView: View {
    struct Friend: Identifiable {
        let id = UUID()
        let name: String
        let streak: Int
        let todayMinutes: Int
        let avatarSymbol: String
    }

    let friends: [Friend] = [
        Friend(name: "Lilly", streak: 12, todayMinutes: 54, avatarSymbol: "person.crop.circle.fill"),
        Friend(name: "Talu", streak: 7, todayMinutes: 32, avatarSymbol: "person.crop.circle.badge.sun.max"),
        Friend(name: "Helios", streak: 25, todayMinutes: 88, avatarSymbol: "sun.max.circle.fill")
    ]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 16) {
                Text("Social")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 8)
                    .padding(.horizontal, 24)

                RoundedRectangle(cornerRadius: 18)
                    .fill(Color(.darkGray).opacity(0.8))
                    .frame(height: 120)
                    .padding(.horizontal, 24)
                    .overlay(
                        HStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(Color.orange)
                                    .frame(width: 60, height: 60)

                                Image(systemName: "person.2.wave.2.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24))
                            }

                            VStack(alignment: .leading, spacing: 6) {
                                Text("Connect with friends")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.white)

                                Text("Share sunlight streaks and join daily challenges together.")
                                    .font(.system(size: 13))
                                    .foregroundColor(.white.opacity(0.8))
                                    .lineLimit(2)
                            }

                            Spacer()

                            Button {
                                // invite action
                            } label: {
                                Text("Invite")
                                    .font(.system(size: 14, weight: .semibold))
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 8)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .clipShape(Capsule())
                            }
                        }
                        .padding(.horizontal, 20)
                    )

                Text("Friends")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)

                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(friends) { friend in
                            friendRow(friend)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)
                }

                Text("Groups")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)

                HStack(spacing: 16) {
                    groupCard(
                        title: "Morning Walk Crew",
                        subtitle: "6 members · Daily 20 min",
                        icon: "figure.walk.circle.fill"
                    )
                    groupCard(
                        title: "Study in the Sun",
                        subtitle: "3 members · Weekdays",
                        icon: "book.circle.fill"
                    )
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 8)

                Spacer()
            }
        }
    }

    private func friendRow(_ friend: Friend) -> some View {
        HStack(spacing: 12) {
            Image(systemName: friend.avatarSymbol)
                .font(.system(size: 30))
                .foregroundColor(.yellow)
                .frame(width: 40, height: 40)

            VStack(alignment: .leading, spacing: 4) {
                Text(friend.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)

                HStack(spacing: 8) {
                    Label("\(friend.streak) day streak", systemImage: "flame.fill")
                        .font(.system(size: 12))
                    Text("Today: \(friend.todayMinutes) min")
                        .font(.system(size: 12))
                }
                .foregroundColor(.gray)
            }

            Spacer()

            Button {
                // nudge friend
            } label: {
                Text("Nudge")
                    .font(.system(size: 13, weight: .semibold))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.white.opacity(0.1))
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
        }
        .padding(12)
        .background(Color.white.opacity(0.04))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func groupCard(title: String, subtitle: String, icon: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(.yellow)
                Spacer()
            }

            Text(title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.white)

            Text(subtitle)
                .font(.system(size: 12))
                .foregroundColor(.gray)

            Spacer()

            Button {
                // join group
            } label: {
                Text("Join")
                    .font(.system(size: 13, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 6)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity)
        .frame(height: 140)
        .background(Color.white.opacity(0.06))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    SunSocialView()
}
