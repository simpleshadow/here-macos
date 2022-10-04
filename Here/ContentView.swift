//
//  ContentView.swift
//  Here
//
//  Created by Simple on 8/23/22.
//

import SwiftUI

struct Settings {
    var isHourlyEnabled = false
    var isHalfHourEnabled = false
    var isFifteenMinutesEnabled = false
}

struct ContentView: View {
    @State var currentTime = String(DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short))
    @State var percentageOfHour = CGFloat(Calendar.current.component(.minute, from: Date())) / 60.0
    
    @State private var isHourlyEnabled = true
    @State private var isHalfHourEnabled = false
    @State private var isFifteenMinutesEnabled = false
    @State private var hasNotifications = true
    @State private var isPaused = false
    
    @State private var pauseSettings = Settings()
    
    var body: some View {
        
        let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
        
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(alignment: .center) {
                Text(currentTime).font(.system(size: 28)).fontWeight(.heavy).onReceive(timer) { input in
                    currentTime = String(DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short))
                    
                    percentageOfHour = CGFloat(Calendar.current.component(.minute, from: Date())) / 60.0
                }

                Spacer()
                
                Button(action: {
                    hasNotifications = !self.hasNotifications
                }) {
                    Image(systemName: hasNotifications ? "bell.fill" : "bell.slash.fill").frame(width: 16.0, height: 16.0, alignment: .center).padding([.top, .bottom], 12.0).padding([.leading, .trailing], 12.0)
                }.buttonStyle(BlueButtonStyle())
                
                Button(action: {
                    if (!self.isPaused) {
                        pauseSettings.isHourlyEnabled = self.isHourlyEnabled
                        pauseSettings.isHalfHourEnabled = self.isHalfHourEnabled
                        pauseSettings.isFifteenMinutesEnabled = self.isFifteenMinutesEnabled
                        
                        self.isHourlyEnabled = false
                        self.isHalfHourEnabled = false
                        self.isFifteenMinutesEnabled = false
                    } else {
                        self.isHourlyEnabled = pauseSettings.isHourlyEnabled
                        self.isHalfHourEnabled = pauseSettings.isHalfHourEnabled
                        self.isFifteenMinutesEnabled = pauseSettings.isFifteenMinutesEnabled
                    }
                    
                    self.isPaused = !self.isPaused
                }) {
                    Image(systemName: self.isPaused ? "play.fill" : "pause.fill").frame(width: 16.0, height: 16.0, alignment: .center).padding([.top, .bottom], 12.0).padding([.leading, .trailing], 12.0)
                }.buttonStyle(BlueButtonStyle())
//                Spacer()
            }.padding(.bottom, 18.0)
            
            GeometryReader { metrics in
                ZStack(alignment: .leading) {
                    Spacer().position(x: 0.0, y: 0.0).frame(width: metrics.size.width * percentageOfHour, height: 28.0).background(.blue.opacity(0.5)).cornerRadius(8.0).animation(.spring(), value: percentageOfHour)
                    
                    HStack {
                        Spacer().frame(width: 5.0, height: 28.0).background(isHourlyEnabled ? .blue : .white).cornerRadius(8.0)
                        Spacer()
                        Spacer().frame(width: 5.0, height: 28.0).background(isFifteenMinutesEnabled ? .blue : .white).cornerRadius(8.0)
                        Spacer()
                        Spacer().frame(width: 5.0, height: 28.0).background(isHalfHourEnabled ? .blue : .white).cornerRadius(8.0)
                        Spacer()
                        Spacer().frame(width: 5.0, height: 28.0).background(isFifteenMinutesEnabled ? .blue : .white).cornerRadius(8.0)
                        Spacer()
                        Spacer().frame(width: 5.0, height: 28.0).background(isHourlyEnabled ? .blue : .white).cornerRadius(8.0)
                    }
                }.padding(.bottom)
            }
            
            ToggleSwitchBar(text: "On the hour", isEnabled: $isHourlyEnabled)
            
            ToggleSwitchBar(text: "On the half hour", isEnabled: $isHalfHourEnabled)
            
            ToggleSwitchBar(text: "On the quarter hour", isEnabled: $isFifteenMinutesEnabled)
            
            //                    Text("Make\nEpic\nThings")
            //                        .font(Font.system(size: 34.0))
            //                        .fontWeight(.semibold)
            //                        .multilineTextAlignment(.leading)
            //                        .padding(.vertical, 12.0)
            //                        .frame(width: 360.0, height: 320.0, alignment: .topLeading)
            
//            Button(action: {
//                NSApplication.shared.terminate(self)
//            })
//            {
//                Text("Quit App")
//                    .font(.caption)
//                    .fontWeight(.semibold)
//            }
//            .padding(.trailing, 16.0)
        }
        .padding(24.0)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200.0, maxHeight: .infinity, alignment: .topLeading)
        //                .frame(width: 360.0, height: 360.0, alignment: .top)
    }
}

struct BlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color.blue : Color.white)
            .background(configuration.isPressed ? Color.white : Color.blue)
            .cornerRadius(8.0)
    }
}

struct ToggleSwitchBar: View {
    var text: String
    @Binding var isEnabled: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            Text(text).fontWeight(.semibold)
            Spacer()
            ToggleSwitch(isOn: $isEnabled) { isOn in
                isEnabled = isOn
            }
            .animation(.spring(), value: isEnabled)
            .scaleEffect(0.7)}
        .padding(.bottom, 4.0)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
