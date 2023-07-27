//
//  CircleButtonAnimationView.swift
//  CryptoInfo
//
//  Created by Md Shohidur Rahman on 7/13/23.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .animation(animate ? Animation.easeOut(duration: 0.5) : .none,value: animate)
           
    }
}

struct CircleButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimationView(animate: .constant(false))
            .foregroundColor(.teal)
            .frame(width: 100, height: 100)
    }
}
