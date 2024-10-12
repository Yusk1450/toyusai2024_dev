//
//  BlinkEffect.swift
//  ipad screen01
//
//  Created by 中野結菜 on 2024/10/11.
//

import Foundation
import SwiftUI
struct BlinkEffect: ViewModifier {
    @State var isOn: Bool = false
    let opacityRange: ClosedRange<Double>
    let interval: Double

    init(opacity: ClosedRange<Double>, interval: Double) {
        self.opacityRange = opacity
        self.interval = interval
    }

    func body(content: Content) -> some View {
        content
            .opacity(self.isOn ? self.opacityRange.lowerBound : self.opacityRange.upperBound)
            .animation(Animation.linear(duration: self.interval).repeatForever())
            .onAppear(perform: {
                self.isOn = true
            })
    }
}

extension View {
    func blinkEffect(opacity: ClosedRange<Double> = 0.1...1, interval: Double = 0.6) -> some View {
        self.modifier(BlinkEffect(opacity: opacity, interval: interval))
    }
}

