//
//  ImageView.swift
//  RequestAPhoto
//
//  Created by Nishigandha Bhushan Jadhav on 21/07/24.
//

import SwiftUI

struct ImageView: View {
    let url : String
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 110, height: 110)
                        .clipped()
                        .cornerRadius(10)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 110, height: 110)
                
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(url: "https://images.unsplash.com/photo-1720048171596-6a7c81662434?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2MzQ4MTZ8MXwxfGFsbHwxfHx8fHx8Mnx8MTcyMTQ3NTcyOXw&ixlib=rb-4.0.3&q=80&w=1080")
    }
}
