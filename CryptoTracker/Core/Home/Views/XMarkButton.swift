//
//  XMarkButton.swift
//  CryptoTracker
//
//  Created by M H on 18/09/2022.
//

import SwiftUI

struct XMarkButton: View {
	@Binding var isPresented: Bool
	
    var body: some View {
		Button(action: {
			isPresented = false
		}, label: {
			Image(systemName: "xmark")
				.font(.headline)
		})
    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
		XMarkButton(isPresented: .constant(true))
    }
}
