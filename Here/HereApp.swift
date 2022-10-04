//
//  HereApp.swift
//  Here
//
//  Created by Simple on 8/23/22.
//

import SwiftUI

@main
struct HereApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self)
    private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            EmptyView()
                .frame(width: .zero)
        }
    }
    
    
    
}
