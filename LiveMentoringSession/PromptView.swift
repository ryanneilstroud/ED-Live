//
//  PromptView.swift
//  LiveMentoringSession
//
//  Created by Ryan Neil Stroud on 16/9/2023.
//

import SwiftUI

public struct PromptView: View {
    private let message: String
    private let completion: () -> Void
    
    init(message: String, completion: @escaping () -> Void) {
        self.message = message
        self.completion = completion
    }
    
    public var body: some View {
        VStack {
            Text(message)
            Button("Close") {
                completion()
            }
        }
    }
}

struct PromptView_Previews: PreviewProvider {
    static var previews: some View {
        PromptView(message: "Successful Approval", completion: {})
    }
}
