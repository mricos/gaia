import os
import pyaudio
import wave
from threading import Thread
from queue import Queue

class AudioRecorder:
    def __init__(self, format=pyaudio.paInt16, rate=44100, frames_per_buffer=1024):
        self.format = format
        self.rate = rate
        self.frames_per_buffer = frames_per_buffer
        self.audio_interface = pyaudio.PyAudio()
        self.stream = None
        self._running = False
        self._queue = Queue()
        self.channels = None
        self.validate_channels()

    def validate_channels(self):
        device_index = int(os.getenv('GAIA_AUDIO_IN_ID', self.audio_interface.get_default_input_device_info()['index']))
        device_info = self.audio_interface.get_device_info_by_index(device_index)
        # Check if the device supports stereo, otherwise set to mono
        if device_info['maxInputChannels'] >= 2:
            self.channels = 2
        else:
            self.channels = 1

    def start(self):
        # Check if a recording is already running
        if self._running:
            print("Recording is already in progress.")
            return

        # Retrieve the input device index from the environment variable
        # or use the default input device index if not available
        input_device_index = int(os.getenv('GAIA_AUDIO_IN_ID', self.audio_interface.get_default_input_device_info()['index']))

        # Open the audio stream with the correct device index
        self.stream = self.audio_interface.open(
            format=self.format,
            channels=self.channels,
            rate=self.rate,
            input=True,
            input_device_index=input_device_index,
            frames_per_buffer=self.frames_per_buffer
        )

        # Set the running flag and start the recording thread
        self._running = True
        self._thread = Thread(target=self._record)
        self._thread.start()

    def _record(self):
        while self._running:
            data = self.stream.read(self.frames_per_buffer, exception_on_overflow=False)
            self._queue.put(data)

    def stop(self):
        self._running = False
        if self._thread.is_alive():
            self._thread.join()
        self.stream.stop_stream()
        self.stream.close()
        self.stream = None

    def get_frames(self):
        frames = []
        while not self._queue.empty():
            frames.append(self._queue.get())
        return frames

    def save_to_file(self, filename):
        frames = self.get_frames()
        with wave.open(filename, 'wb') as wf:
            wf.setnchannels(self.channels)
            wf.setsampwidth(self.audio_interface.get_sample_size(self.format))
            wf.setframerate(self.rate)
            wf.writeframes(b''.join(frames))

# Usage example:
# recorder = AudioRecorder()
# recorder.start()
# ... Record some audio ...
# recorder.stop()
# recorder.save_to_file('output.wav')
