import sounddevice as sd
from visualizer import Visualizer

class AudioProcessor:
    def __init__(self, visualizer):
        self.visualizer = visualizer
        self.fs = 48000  # Sample rate

    def audio_callback(self, indata, frames, time, status):
        # Process the audio data and display it on the VU meter
        self.visualizer.display_vu_meter(indata)

    def start(self):
        with sd.InputStream(callback=self.audio_callback, samplerate=self.fs):
            sd.sleep(10000)  # Keep capturing for a given duration
