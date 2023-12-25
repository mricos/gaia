import sounddevice as sd

class AudioPlayer:
    def __init__(self, sample_rate=44100):
        self.sample_rate = sample_rate

    def play(self, audio_data):
        # This method plays the given audio data
        sd.play(audio_data, self.sample_rate)

    def stop(self):
        # This method stops the playback
        sd.stop()

    # Additional methods for audio playback can be added here

