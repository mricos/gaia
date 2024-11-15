import pyaudio

class AudioPlayer:
    def __init__(self, sample_rate=44100):
        self.sample_rate = sample_rate
        self.audio_interface = pyaudio.PyAudio()
        self.stream = None

    def play(self, audio_data):
        # This method sets up and starts the PyAudio stream for playback
        if self.stream is None:
            self.stream = self.audio_interface.open(format=pyaudio.paFloat32,
                                                    channels=1,
                                                    rate=self.sample_rate,
                                                    output=True)
        self.stream.write(audio_data)

    def stop(self):
        if self.stream is not None:
            self.stream.stop_stream()
            self.stream.close()
            self.stream = None
        self.audio_interface.terminate()

    # Additional methods for audio playback can be added here

