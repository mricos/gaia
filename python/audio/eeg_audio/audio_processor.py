import pyaudio
import numpy as np
from visualizer import Visualizer

class AudioProcessor:
    def __init__(self, visualizer):
        self.visualizer = visualizer
        self.fs = 48000  # Sample rate
        self.chunk_size = 1024  # Adjust as needed
        self.audio_interface = pyaudio.PyAudio()
        self.stream = None

    def audio_callback(self, in_data, frame_count, time_info, status):
        audio_data = np.frombuffer(in_data, dtype=np.float32)
        self.visualizer.display_vu_meter(audio_data)
        return (in_data, pyaudio.paContinue)

    def start(self):
        self.stream = self.audio_interface.open(format=pyaudio.paFloat32,
                                                channels=1,
                                                rate=self.fs,
                                                input=True,
                                                frames_per_buffer=self.chunk_size,
                                                stream_callback=self.audio_callback)
        self.stream.start_stream()

    def stop(self):
        if self.stream is not None:
            self.stream.stop_stream()
            self.stream.close()
        self.audio_interface.terminate()

