//
// WavyRectangleDemoView.swift
//
// Created by CypherPoet on 4/8/21.
// ✌️
//

import SwiftUI
import SwiftUIStarterKit
import SwiftUIWavyRectangleShape
import SwiftUIShapeDemoUtils


struct WavyRectangleDemoView {
    @State
    private var screenHeight: CGFloat = 0.0
    
    @State
    private var wavePhaseSliderProgress: CGFloat = 0.0
    
    @State
    private var isAnimatingWaves: Bool = false
    
    @State
    private var animatedPhase: Angle = .zero
}


// MARK: - Static Properties
extension WavyRectangleDemoView {
    
    enum Animations {
        static let wavePhaseChange = Animation
            .easeOut(duration: 0.4)
        
        static let continuousWaveSlide = Animation
            .linear(duration: 5.0)
        
        
        static let amplitudeChange = Animation
            .easeInOut(duration: 0.75)
    }
}


// MARK: - `View` Body
extension WavyRectangleDemoView: View {
    
    var body: some View {
        VStack(spacing: 32.0) {
            headerSection
            
            Text("Sine-Wavy Rectangles")
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.semibold)
            
            
            VStack {
                Slider(value: $wavePhaseSliderProgress) {
                    Text("Wave Phase Progress")
                }
                
                Text("Wave Phase Progress")
                    .font(.system(.headline, design: .rounded))
            }
            .padding()
            
            Spacer()
            
            buttonControlsSection
                .padding(.vertical)
            
            
            footerSection
                .frame(height: screenHeight * 0.2)
        }
        .readingFrameSize { newSize in
            screenHeight = newSize.height
        }
        .edgesIgnoringSafeArea(.vertical)
    }
}


// MARK: - Computeds
extension WavyRectangleDemoView {
    
    var baseWavePhaseOffset: Double {
        (.pi * 2 * Double(wavePhaseSliderProgress))
    }
    
    
    var animatedPhaseOffset: Double {
        baseWavePhaseOffset + Double(animatedPhase.radians)
    }
    
    
    var animationButtonText: String {
        isAnimatingWaves ? "Pause Animation" : "Start Animating"
    }
    
    var continuousWaveAnimation: Animation? {
        if isAnimatingWaves {
            return Animations.continuousWaveSlide.repeatForever(autoreverses: false)
        } else {
            return Animations.continuousWaveSlide
        }
    }
    
    
    var amplitudeAnimation: Animation? {
        if isAnimatingWaves {
            return Animations.amplitudeChange.repeatForever(autoreverses: true)
        } else {
            return Animations.amplitudeChange
        }
    }
    
    var amplitude: WavyRectangle.HeightRatio {
        isAnimatingWaves ? 0.25 : 0.125
    }
}


// MARK: - View Content Builders
private extension WavyRectangleDemoView {
    
    var headerShape: some Shape {
        WavyRectangle(
            phase: .radians(animatedPhaseOffset),
            amplitudeRatio: amplitude
        )
        .scale(x: 1.0, y: -1.0, anchor: .center)
    }
    
    
    var headerSection: some View {
        headerShape
            .frame(height: screenHeight * 0.23)
            .overlay(
                ImageAssets.nightSky1
                    .resizable()
                    .scaledToFill()
            )
            .clipShape(headerShape)
            .background(
                headerShape
                    .fill(ThemeColors.secondary1)
                    .opacity(0.3)
                    .blur(radius: 23.0, opaque: false)
            )
            .animation(Animations.wavePhaseChange, value: wavePhaseSliderProgress)
            .animation(continuousWaveAnimation, value: animatedPhaseOffset)
            .animation(amplitudeAnimation, value: amplitude)
    }
    
    
    var buttonControlsSection: some View {
        HStack {
            Spacer()
            
            Button("Reset Waves") {
                withAnimation(.easeInOut) {
                    wavePhaseSliderProgress = 0.0
                }
            }
            
            Spacer()
            
            // NOTE: An improvement here would be stopping the waves in place rather than
            // having them reset.
            //
            // One idea is making a container view for the wave
            // that held state about whether or not it was sliding continuously. We could coordinate
            // that from THIS container view, and then the container view for the shape
            // could access the properties is the shape directly to get/set the `phase`.
            Button(animationButtonText) {
                if isAnimatingWaves == false {
                    animatedPhase.radians += 2 * .pi * 10
                } else {
                    // Experiment with trying to gracefully stop the slide
                    animatedPhase.radians += animatedPhase
                        .radians
                        .truncatingRemainder(dividingBy: .pi * 2)
                }
                
                
                isAnimatingWaves.toggle()
            }
            
            Spacer()
        }
    }
    
    
    var footerSection: some View {
        ZStack {
            WavyRectangle(
                phase: .radians(baseWavePhaseOffset * -1),
                amplitudeRatio: amplitude
            )
            .fill(Color.pink)
            
            WavyRectangle(
                phase: .radians(baseWavePhaseOffset - .pi),
                amplitudeRatio: amplitude
            )
            .fill(ThemeColors.accent)
            .opacity(0.75)
//            .opacity(0.5)
            
            WavyRectangle(
                phase: .radians((baseWavePhaseOffset - .pi) * -0.5),
                amplitudeRatio: amplitude
            )
            .fill(ThemeColors.secondary1)
            .opacity(0.75)
        }
        .animation(Animations.wavePhaseChange, value: wavePhaseSliderProgress)
        //        .animation(continuousWaveAnimation, value: animatedPhase)
        .animation(amplitudeAnimation, value: amplitude)
    }
}

// MARK: - Private Helpers
private extension WavyRectangleDemoView {
}


#if DEBUG
// MARK: - Preview
struct WavyRectangleDemoView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            WavyRectangleDemoView()
            
            WavyRectangleDemoView()
                .preferredColorScheme(.dark)
        }
    }
}
#endif
