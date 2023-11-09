
import time
import threading
from audio_recorder import AudioRecorder
import pyaudio
import wave

# Function to wait for a key press or timeout
def wait_for_keypress(timeout):
    input_ready = threading.Event()

    def wait_for_input():
        input("Press Enter to stop recording early...  ")
        input_ready.set()

    input_thread = threading.Thread(target=wait_for_input)
    input_thread.daemon = True
    input_thread.start()
    input_thread.join(timeout)
    return input_ready.is_set()

# Function to play back the recorded audio
def play_audio(filename):
    with wave.open(filename, 'rb') as wf:
        pa = pyaudio.PyAudio()
        stream = pa.open(format=pa.get_format_from_width(wf.getsampwidth()),
                         channels=wf.getnchannels(),
                         rate=wf.getframerate(),
                         output=True)
        data = wf.readframes(1024)

        while data:
            stream.write(data)
            data = wf.readframes(1024)

        stream.stop_stream()
        stream.close()
        pa.terminate()

# Main function to record and play back audio
def main():
    filename = 'recorded_audio.wav'

    # Initialize the recorder
    recorder = AudioRecorder()

    # Start recording
    print("Recording...")
    recorder.start()

    # Wait for 5 seconds or a key press, whichever comes first
    key_pressed = wait_for_keypress(5)

    # Stop recording
    recorder.stop()
    print("Recording stopped.")

    if key_pressed:
        print("Key press detected.")
    else:
        print("5 second timeout reached.")

    # Save the recording to a file
    recorder.save_to_file(filename)
    print(f"Saved recording to {filename}.")

    # Play back the recording
    print("Playing back the recording...")
    play_audio(filename)
    print("Playback finished.")

if __name__ == "__main__":
    main()
