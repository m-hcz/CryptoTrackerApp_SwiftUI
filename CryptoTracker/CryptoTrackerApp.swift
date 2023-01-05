//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by M H on 15/09/2022.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
	@StateObject private var vm = HomeViewModel()
	@State var showLaunchView:Bool = true
	init() {
        
		UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
		UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
		UINavigationBar.appearance().tintColor = UIColor(Color.theme.accent)
		UITableView.appearance().backgroundColor = UIColor.clear
	}
	
    var body: some Scene {
        WindowGroup {
			ZStack {
				NavigationView {
					HomeView()
						.navigationBarHidden(true)
				}
				.navigationViewStyle(StackNavigationViewStyle())
				.environmentObject(vm)
				
				ZStack{
					if showLaunchView {
						LaunchView(showLaunchView: $showLaunchView)
							.transition(.move(edge: .leading))
					}
				}
				.zIndex(2)
				
			}
			
		}
    }
}
