//
//  ImageViewDetail.swift
//  RequestAPhoto
//
//  Created by Nishigandha Bhushan Jadhav on 22/07/24.
//

import SwiftUI

struct ImageViewDetail: View {
    var image : ImageData
    var imageurl : String
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: imageurl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                    .padding()
            Text(image.alt_description ?? "")
                .padding()
                .font(.title2)
            HStack(alignment: .center, content: {
               Image("heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .foregroundColor(.red)
                Text("\(image.likes ?? 0)")
                    .padding()
                    .font(.title)
            })
            .padding()
        }
        .padding()
        .navigationTitle("Image Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ImageViewDetail_Previews: PreviewProvider {
    static var previews: some View {
        let image = ImageData(id: "ahCy769oG4Y", slug: "",alt_description:"A person using a laptop computer on a table", urls: URLModel(regular: "https://images.unsplash.com/photo-1720048170970-3848514c3d60?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2MzQ4MTZ8MXwxfGFsbHw0MXx8fHx8fDJ8fDE3MjE2MjI4MDR8&ixlib=rb-4.0.3&q=80&w=1080"),
                          likes: 3
                          )
        ImageViewDetail(image: image, imageurl: "https://images.unsplash.com/photo-1720048170970-3848514c3d60?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2MzQ4MTZ8MXwxfGFsbHw0MXx8fHx8fDJ8fDE3MjE2MjI4MDR8&ixlib=rb-4.0.3&q=80&w=1080")
    }
}
