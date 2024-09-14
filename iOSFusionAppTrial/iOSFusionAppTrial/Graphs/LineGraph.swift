
import SwiftUI

struct LineGraph: Shape {
    var data: [GraphData]
    var projection: CGFloat?  // Represents the projected value

    func path(in rect: CGRect) -> Path {
        var path = Path()

        guard !data.isEmpty else { return path }

        // Scale data points to fit within the graph
        let maxValue = data.map { $0.value }.max() ?? 1
        let minValue = data.map { $0.value }.min() ?? 1
        let scale = rect.height / (maxValue - minValue)
        
        let stepX = rect.width / CGFloat(data.count - 1)

        // Move to the first point
        let startPoint = CGPoint(x: 0, y: (maxValue - data[0].value) * scale)
        path.move(to: startPoint)
        
        // Create line for each data point
        for index in data.indices {
            let xPos = stepX * CGFloat(index)
            let yPos = (maxValue - data[index].value) * scale
            path.addLine(to: CGPoint(x: xPos, y: yPos))
        }

        // Draw projection line if provided
        if let projectionValue = projection {
            let lastPointX = rect.width
            let lastPointY = (maxValue - data.last!.value) * scale
            let projectionY = (maxValue - projectionValue) * scale
            let projectionHeight: CGFloat = 40  // Height of the projection line
            let endProjectionY = min(lastPointY - projectionHeight, lastPointY) // Extend slightly above

            // Create a dotted line for the projection
            var dottedPath = Path()
            let dashPattern: [CGFloat] = [2, 6] // Dotted line pattern
            dottedPath.addLines([
                CGPoint(x: lastPointX, y: lastPointY),
                CGPoint(x: lastPointX, y: endProjectionY)
            ])
            
            // Draw dotted projection line
            path.addPath(dottedPath.strokedPath(StrokeStyle(lineWidth: 1, dash: dashPattern)))
            
            // Draw solid projection line for the last point to the end
            path.addLine(to: CGPoint(x: lastPointX, y: endProjectionY))
            path.move(to: CGPoint(x: lastPointX, y: lastPointY)) // Move to the original last point for the projection line

            // Add a small circle at the end of the projection
        }

        return path
    }
}

