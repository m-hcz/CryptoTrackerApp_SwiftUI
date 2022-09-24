//
//  SettingsView.swift
//  CryptoTracker
//
//  Created by M H on 24/09/2022.
//

import SwiftUI

struct SettingsView: View {
	
	@Binding var isPresented:Bool
	
	let defaultURL = URL(string: "https://www.coingecko.com/en/api")!
	
    var body: some View {
		NavigationView {
			ZStack {
				Color.theme.background.ignoresSafeArea()
				
				List {
					appSection
						.listRowBackground(Color.theme.background.opacity(0.5))
					coinGeckoSection
						.listRowBackground(Color.theme.background.opacity(0.5))
				}
			}
			.font(.headline)
			.accentColor(.blue)
			.listStyle(GroupedListStyle())
			.navigationTitle("Settings")
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					XMarkButton(isPresented: $isPresented)
				}
			}
		}
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
		SettingsView(isPresented: .constant(false))
    }
}

extension SettingsView {
	private var appSection:some View {
		Section(header: Text("App")) {
			VStack(alignment: .leading) {
				Image("logo")
					.resizable()
					.scaledToFit()
					.frame(width: 100, height: 100)
					.clipShape(RoundedRectangle(cornerRadius: 20))
				Text("Crypto App, CoinDecko API, MVVM/Service Architecture, Combine, FileManager and CoreData")
					.font(.callout)
					.fontWeight(.medium)
					.foregroundColor(Color.theme.accent)
			}
			.padding(.vertical)
		}
	}
	private var coinGeckoSection:some View {
		Section(header: Text("API")) {
			VStack(alignment: .leading) {
				Image("coingecko")
					.resizable()
					.scaledToFit()
					.frame(height: 100)
					.clipShape(RoundedRectangle(cornerRadius: 20))
				Text("Explore The Most Comprehensive Cryptocurrency API for Traders and Developers. Use our crypto API to receive crypto prices, historical market data, exchanges trading volume and trading pairs, and other cryptocurrencies data in real time.")
					.font(.callout)
					.fontWeight(.medium)
					.foregroundColor(Color.theme.accent)
			}
			.padding(.vertical)
			
			Link("CoinDecko", destination: defaultURL)
		}
	}
}
