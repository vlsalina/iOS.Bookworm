//
//  EmojiRatingReview.swift
//  Bookworm
//
//  Created by Vincent Salinas on 9/4/22.
//

import SwiftUI

struct EmojiRatingReview: View {
    let rating: Int16

    var body: some View {
        switch rating {
        case 1:
            Text("🤮")
        case 2:
            Text("😕")
        case 3:
            Text("😃")
        case 4:
            Text("😍")
        default:
            Text("🤩")
        }
    }}

struct EmojiRatingReview_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingReview(rating: 3)
    }
}
