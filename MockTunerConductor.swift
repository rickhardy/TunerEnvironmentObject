

import SwiftUI
import AudioKit

class MockTunerConductor: TunerConductorProtocol {
    @Published var data = TunerData()
    let engine = AudioEngine()
    var timer = Timer()
    init () {
        data.pitch = 50
        data.amplitude = 1.3
        data.noteNameWithFlats = "Xb"
        data.noteNameWithSharps = "Z#"
        
        //DispatchQueue.main.async
        //{self.update(1.0, 1.2)}
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.data.pitch += 1.0}
    }
    
    func update(_ pitch: AUValue, _ amp: AUValue) {
        data.pitch += 1
    }
    

    
}
