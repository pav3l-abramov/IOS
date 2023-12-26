//
//  ContentView.swift
//  PetAdoption
//
//  Created by user252252 on 12/26/23.
//


import SwiftUI

struct ContentView: View {
    
    @State var currentIndex: Int = 0
    @State var isPresented: Bool = false
    private let _maxIndex = 2
    
    var body: some View {
        ZStack {
            Color.primaryColor
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
           
        }
    }
    
}

struct SplashView: View {
    let image: String
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image(image)
                .frame(maxWidth: .infinity)
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.system(size: 30, weight: .medium))
                Text(description)
                    .font(.system(size: 16, weight: .regular))
            }
            .foregroundColor(.white)
            .padding(.leading)
            .padding(.trailing)
        }
    }
    
}

struct PagingView<Content>: View where Content: View {
    
    @Binding var index: Int
    let maxIndex: Int
    let content: () -> Content
    
    @State private var _offset: CGFloat = .zero
    @State private var _isDragging = false
    
    init(index: Binding<Int>, maxIndex: Int, @ViewBuilder content: @escaping() -> Content) {
        self._index = index
        self.maxIndex = maxIndex
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    self.content()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                }
            }
            .content.offset(x: self.offset(in: geometry), y: 0)
            .frame(width: geometry.size.width, alignment: .leading)
            .gesture(
                DragGesture().onChanged { value in
                    _isDragging = true
                    _offset = -CGFloat(self.index) * geometry.size.width + value.translation.width
                }
                .onEnded { value in
                    let predictedEndOffset = -CGFloat(self.index) * geometry.size.width + value.predictedEndTranslation.width
                    let predictedIndex = Int(round(predictedEndOffset / -geometry.size.width))
                    self.index = clampedIndex(from: predictedIndex)
                    withAnimation(.easeOut) {
                        _isDragging = false
                    }
                }
            )
        }.clipped()
    }
    
    func offset(in geometry: GeometryProxy) -> CGFloat {
        if _isDragging {
            return max(min(self._offset, 0), -CGFloat(self.maxIndex) * geometry.size.width)
        }
        return -CGFloat(self.index) * geometry.size.width
    }
    
    func clampedIndex(from predictedIndex: Int) -> Int {
        let newIndex = min(max(predictedIndex, self.index - 1), self.index + 1)
        guard newIndex >= 0 else { return 0 }
        guard newIndex <= maxIndex else { return maxIndex }
        return newIndex
    }
    
}

struct PagingControlView: View {
    
    @Binding var index: Int
    
    let maxIndex: Int
    
    var normalPageControl: some View {
        Circle()
            .stroke(Color.white)
            .frame(width: 8, height: 8)
    }
    
    var selectedPageControl: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(Color.primaryDark)
            .frame(width: 20, height: 9)
    }
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0...maxIndex, id: \.self) { index in
                self.index == index ? selectedPageControl : nil
                self.index == index ? nil : normalPageControl
            }
        }
    }
    
}

struct RoundedCorner: Shape {
    var radius: CGFloat = 0.0
    var corners: UIRectCorner = []
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: .init(width: radius, height: radius))
        return Path(path.cgPath)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
