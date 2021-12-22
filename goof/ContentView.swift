//
//  ContentView.swift
//  goof
//
//  Created by logeast on 2021/12/21.
//

import SwiftUI

struct RoundedRectProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 375, height: 8)
                .foregroundColor(.gray)
            
            RoundedRectangle(cornerRadius: 12)
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * 375, height: 8)
                .foregroundColor(.white)
        }
        .padding()
    }
}

struct ContentView: View {
    @State private var value: Double = Double.random(in: 0...600)
    @State private var timer = Timer.TimerPublisher(interval: 10.0, runLoop: .main, mode: .common).autoconnect()
    
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                HStack {
                    Image("apple")
                        .resizable(resizingMode: .stretch)
                        .frame(width: 100.0, height: 100.0)
                        .aspectRatio(contentMode: .fit)
                    
                }
                .padding(.bottom, 96.0)
                VStack {
                    ProgressView(value: value, total: 900)
                        .frame(width: 375.0, height: 8.0)
                        .progressViewStyle(RoundedRectProgressViewStyle())
                        .onAppear {
                            timer = Timer.TimerPublisher(interval: 1.0, runLoop: .main, mode: .common).autoconnect()
                        }
                        .onReceive(timer) { _ in
                            if value < 900 {
                                value += 1
                            }
                        }
                    Text("About \(Int((Double(900) - value) / 60)) minutes remaining")
                        .multilineTextAlignment(.center)
                        .font(.body)
                        .foregroundColor(.white)
                        .padding(8.0)
                }
                .padding()
                Spacer()
            }
            Spacer()
        }
        .padding(.all, 160.0)
        .background(Color.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
