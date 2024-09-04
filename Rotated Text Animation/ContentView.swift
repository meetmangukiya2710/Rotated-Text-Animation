//
//  ContentView.swift
//  Rotated Text Animation
//
//  Created by R95 on 04/09/24.
//

import SwiftUI

struct ContentView: View {
    @State private var buttonColor: Color = .blue
    @State private var ViewbackColor: Color = .black
    @State private var selectedColorName: String = "Blue"
    @State private var showColorOptions: Bool = false
    @State private var rotation1: Double = 0
    @State private var rotation2: Double = 0
    
    private let outerLoop = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    private let colors: [Color] = [.blue, .red, .green, .orange, .purple, .brown, .cyan , .yellow]
    
    var body: some View {
        VStack {
            Button(action: {
                showColorOptions = true
            }) {
                Text("Edit")
                    .padding()
                    .background(buttonColor)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
            .offset(x: 150, y: -300)
            
            ZStack {
                ForEach(Array(outerLoop.enumerated()), id: \.offset) { index, character in
                    Text(String(character))
                        .font(.system(size: 25))
                        .offset(y: 180)
                        .opacity(1)
                        .rotationEffect(.degrees(Double(index) * 360 / Double(outerLoop.count)))
                        .foregroundColor(buttonColor)
                }
                .rotationEffect(.degrees(rotation1))
                
                ForEach(Array(outerLoop.enumerated()), id: \.offset) { index, character in
                    Text(String(character))
                        .font(.system(size: 20))
                        .offset(y: 130)
                        .opacity(0.8)
                        .rotationEffect(.degrees(Double(index) * 360 / Double(outerLoop.count)))
                        .foregroundColor(buttonColor)
                }
                .rotationEffect(.degrees(rotation2))
                
                ForEach(Array(outerLoop.enumerated()), id: \.offset) { index, character in
                    Text(String(character))
                        .font(.system(size: 15))
                        .offset(y: 90)
                        .opacity(0.6)
                        .rotationEffect(.degrees(Double(index) * 360 / Double(outerLoop.count)))
                        .foregroundColor(buttonColor)
                }
                .rotationEffect(.degrees(rotation1))
                
                ForEach(Array(outerLoop.enumerated()), id: \.offset) { index, character in
                    Text(String(character))
                        .font(.system(size: 10))
                        .offset(y: 50)
                        .opacity(0.4)
                        .rotationEffect(.degrees(Double(index) * 360 / Double(outerLoop.count)))
                        .foregroundColor(buttonColor)
                }
                .rotationEffect(.degrees(rotation2))
            }
            .padding()
            .onAppear {
                withAnimation(Animation.linear(duration: 20).repeatForever(autoreverses: false)) {
                    rotation1 = 360
                }
                
                withAnimation(Animation.linear(duration: 20).repeatForever(autoreverses: false)) {
                    rotation2 = -360
                }
            }
            
            if showColorOptions {
                ColorOptionsView(colors: colors, selectedColor: $buttonColor, selectedColorName: $selectedColorName, showColorOptions: $showColorOptions)
                    .transition(.move(edge: .bottom))
            }
        }
        
        .animation(.default, value: showColorOptions)
    }
    
}

struct ColorOptionsView: View {
    let colors: [Color]
    @Binding var selectedColor: Color
    @Binding var selectedColorName: String
    @Binding var showColorOptions: Bool
    
    var body: some View {
        ScrollView(.horizontal) {
            VStack {
                GridStack(rows: 1, columns: colors.count) { row, col in
                    Button(action: {
                        selectedColor = colors[col]
                        selectedColorName = colorName(for: colors[col])
                        showColorOptions = false
                    }) {
                        Circle()
                            .fill(colors[col])
                            .frame(width: 40, height: 40)
                            .overlay(
                                Circle()
                                    .stroke(Color.black, lineWidth: 2)
                            )
                    }
                    .padding(5)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
            }
            .padding()
            .background(Color.black.opacity(0.4).edgesIgnoringSafeArea(.all))
        }
        .onAppear {
            UIScrollView.appearance().showsHorizontalScrollIndicator = true
        }
    }
    
    private func colorName(for color: Color) -> String {
        switch color {
        case .blue:
            return "Blue"
        case .red:
            return "Red"
        case .green:
            return "Green"
        case .orange:
            return "Orange"
        case .purple:
            return "Purple"
        case .brown:
            return "Brown"
        case .cyan:
            return "Cyan"
        case .yellow:
            return "Yellow"
        default:
            return "Unknown"
        }
    }
}

// Simple GridStack for layout
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
