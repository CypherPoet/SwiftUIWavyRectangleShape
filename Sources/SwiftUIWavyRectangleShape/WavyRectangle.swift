//
// 📝 References and Resources
//  - https://en.wikipedia.org/wiki/Waveform
//  - https://support.apple.com/guide/logicpro/other-waveform-properties-lgsife418f71/mac
//  - https://pudding.cool/2018/02/waveforms
//  - https://www.electronics-tutorials.ws/waveforms/waveforms.html
//  - https://en.wikipedia.org/wiki/Angular_frequency
//  - http://mriquestions.com/angular-frequency-omega.html
//

import SwiftUI
import SwiftUIGeometryUtils
import UnitIntervalPropertyWrapper
import ClampedPropertyWrapper


public struct WavyRectangle {
    public typealias HeightRatio = CGFloat
    
    /// Periods (i.e., repetitions of the wave) within the rectangle bounds.
    public typealias Hertz = CGFloat
    
    
    public var phase: Angle
    
    
    /// Ratio of amplitude height to total height of the shape's bounding rect.
    @UnitInterval
    public var amplitudeRatio: HeightRatio
    
    
    /// Number of wave repetitions
    ///
    /// Frequency, measured in Hertz, is meant to define the number of wave repetitions
    /// per second. In the context of a single shape, we can translate that to repetitions
    /// within the rectangle bounds.
    @Clamped(within: CGFloat(0.0).nextUp...Hertz.infinity)
    public var frequency: Hertz = 1.0


    // MARK: - Init
    public init(
        phase: Angle = .zero,
        amplitudeRatio: HeightRatio = 0.25,
        frequency: Hertz = 1
    ) {
        self.phase = phase
        self.amplitudeRatio = amplitudeRatio
        self.frequency = frequency
    }
}


// MARK: - Shape
extension WavyRectangle: Shape {

    public func path(in rect: CGRect) -> Path {
        let rectWavelength = self.wavelength(in: rect)
        let rectHeight = rect.height
        
        var path = Path()

        path.move(to: rect.bottomLeading)
        
        for xPosition in stride(from: 0.0, through: Double(rect.width), by: 1.0) {
            path.addLine(
                to: wavePoint(
                    at: CGFloat(xPosition),
                    inRectWithWavelength: rectWavelength,
                    andHeight: rectHeight
                )
            )
        }
        
        path.addLine(to: rect.bottomTrailing)
        
        return path
    }
}


// MARK: - AnimatableData
extension WavyRectangle {

    public var animatableData: AnimatablePair<Double, CGFloat> {
        get {
            AnimatablePair(phase.radians, amplitudeRatio)
        }
        set {
            phase = .radians(newValue.first)
            amplitudeRatio = newValue.second
        }
    }
}


// MARK: - Computeds
extension WavyRectangle {
    
    func wavelength(in rect: CGRect) -> CGFloat {
        let angularFrequency = (.pi * 2) * frequency

        return rect.width / angularFrequency
    }
}


// MARK: - Private Helpers
private extension WavyRectangle {
    
    func wavePoint(
        at xPosition: CGFloat,
        inRectWithWavelength rectWavelength: CGFloat,
        andHeight rectHeight: CGFloat
    ) -> CGPoint {
        let xPositionRelativeOfWavelength = xPosition / rectWavelength
        let sine = sin(xPositionRelativeOfWavelength + CGFloat(phase.radians))
        
        // Adjust the height so that it the line falls back within the rectangle's bounds.
        let heightShift = rectHeight * amplitudeRatio

        let yPosition = (sine * rectHeight * amplitudeRatio) + heightShift

        return CGPoint(x: xPosition, y: yPosition)
    }
}


#if DEBUG

struct WavyRectangle_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            WavyRectangle()
                .fill(Color.accentColor)
            
            WavyRectangle()
                .stroke(Color.pink, lineWidth: 10)
            
            WavyRectangle(
                phase: .radians(.pi / 6),
                amplitudeRatio: 0.75
            )
            .stroke(Color.pink, lineWidth: 10)
            
            WavyRectangle(
                amplitudeRatio: 0.75
            )
            .stroke(Color.pink, lineWidth: 10)
            .frame(width: 100)
            
            
            WavyRectangle(
                amplitudeRatio: 0.75
            )
            .stroke(Color.pink, lineWidth: 10)
            .frame(width: 629)
        }
        .frame(height: 200)
        .previewLayout(.sizeThatFits)
    }
}


#endif
