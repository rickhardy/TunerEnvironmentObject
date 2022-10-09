import AudioKit
import AudioKitEX
import SoundpipeAudioKit
import SwiftUI
import Foundation

/// Protocol allowing switch between Tuner Conductor and Mock
protocol TunerConductorProtocol : ObservableObject,  HasAudioEngine {
    var published_pitch : Float { get }
}

/// TunerViewModel enables a protocol to be used to publish the Tuner Conductor or Mock as an observable object
/// But it is not updated unless forced to (I have used a timer with repeat : true to do this)
class TunerViewModel : ObservableObject {
    var conductor : any TunerConductorProtocol
    @Published private var pitch : Float
    var timer = Timer()
    
    init (tunerConductor : any TunerConductorProtocol) {
        conductor = tunerConductor
        pitch = 0.0
        conductor.start()
        
        ///This timer is only here to force the TunerViewModel to refresh its observable object
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            self.pitch += 1
        }
    }
}

/// Observes a TunerViewModel that contains a £Tuner Conductor
struct TunerView: View {
    @StateObject var  conductorVm : TunerViewModel

    var body: some View {
        VStack {
            HStack {
                Text("Frequency")
                Spacer()
                Text("\(conductorVm.conductor.published_pitch, specifier: "%0.1f")")
            }.padding()
        }
    }
}

/**This is the observable object **/
/// Observes the mic using a pitch tap supplied by Audiokit
class TunerConductor: TunerConductorProtocol{
    //@Published var data = TunerData()
    @Published var published_pitch : Float = 0.0
    @Published var amplitude : Float = 0.0

    let engine = AudioEngine()
    let initialDevice: Device
    let mic: AudioEngine.InputNode
    let tappableNodeA: Fader
    let silence: Fader
    var tracker: PitchTap!

    init() {
        guard let input = engine.input else { fatalError() }
        guard let device = engine.inputDevice else { fatalError() }
        initialDevice = device
        mic = input
        tappableNodeA = Fader(mic)
        silence = Fader(tappableNodeA, gain: 0)
        engine.output = silence
        tracker = PitchTap(mic) { pitch, amp in
            DispatchQueue.main.async {
                self.update(pitch[0], amp[0])
                print ("Running the real conductor")
            }
        }
        tracker.start()
    }

    func update(_ pitch: AUValue, _ amp: AUValue) {
        // Reduces sensitivity to background noise to prevent random / fluctuating data.
        guard amp > 0.1 else { return }
        published_pitch = pitch
        amplitude = amp
    }
}

/// The Mock just increments the pitch forever, not using the mic
class MockTunerConductor: TunerConductorProtocol {
    @Published var published_pitch : Float = 0.0
    @Published var amplitude : Float = 0.0
    let engine = AudioEngine() // Dummy engine, Not used, required to conform to protocol
    var timer = Timer()
    init () {
        published_pitch = 50
        amplitude = 1.3
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
        self.published_pitch += 1.0}
    }
}

/* ContentView can publish either the Mock or the real TunerConductor or both */
struct ContentView: View {
    var body: some View {
        VStack {
            TunerView(conductorVm: TunerViewModel(tunerConductor: TunerConductor()))
            //TunerView(conductorVm: TunerViewModel(tunerConductor: MockTunerConductor()))
        }
    }
}
