//
//  AppIcon.swift
//  DateFixer
//
//  Created by Tom Hartnett on 12/31/23.
//

import SwiftUI

// This view is used to create the AppIcon.
// Screenshot, crop, resize.
// Lazy way to create "good enough" app icon.

struct AppIcon: View {
    var body: some View {
        ZStack {
            Image(systemName: "calendar")
                .font(.system(size: 500))
                .foregroundStyle(.red)

            Circle()
                .frame(width: 290, height: 290)
                .offset(x: 0, y: 130)
                .foregroundStyle(.white)

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 250))
                .fontWeight(.heavy)
                .offset(x: 0, y: 130)
                .foregroundStyle(.red)
        }
        .frame(width: 700, height: 700)
        .border(.black)
    }
}

#Preview {
    AppIcon()
}
