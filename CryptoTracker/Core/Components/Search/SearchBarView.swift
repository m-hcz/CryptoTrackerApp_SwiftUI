//
//  SearchBarView.swift
//  CryptoTracker
//
//  Created by M H on 17/09/2022.
//

import SwiftUI

struct SearchBarView: View {
	
	@Binding var searchText:String
	
    var body: some View {
		HStack {
			Image(systemName: "magnifyingglass")
				.foregroundColor(searchText.isEmpty ? Color.theme.secondaryText : Color.theme.secondaryText)
			TextField("Search by name or symbol", text: $searchText)
				.foregroundColor(Color.theme.accent)
				.disableAutocorrection(true)
				.overlay(alignment: .trailing) {
					Image(systemName: "xmark.circle.fill")
						.padding()
						.offset(x: 10)
						.foregroundColor(Color.theme.accent)
						.opacity(searchText.isEmpty ? 0 : 1)
						//.background(.red)
						.onTapGesture {
							UIApplication.shared.endEditing()
							searchText = ""
						}
				}
		}
		.font(.headline)
		.padding()
		.background(
			RoundedRectangle(cornerRadius: 25)
				.fill(Color.theme.background)
				.shadow(color: Color.theme.accent.opacity(0.15), radius: 10, x: 0, y: 0)
		)
		.padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
		SearchBarView(searchText: .constant(""))
			.preferredColorScheme(.light)
		SearchBarView(searchText: .constant(""))
			.preferredColorScheme(.dark)
    }
}
