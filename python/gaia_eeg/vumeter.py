import curses
import pyaudio
import numpy as np
import audio_recorder  # Assume this is the module with your AudioRecorder class

# Function to calculate RMS
def calculate_rms(data, format):
    # Assuming format is pyaudio.paInt16 for simplicity
    count = len(data)/2
    format = np.int16
    rms = np.sqrt(np.mean(np.square(np.frombuffer(data, dtype=format))))
    return rms

# Global variable to keep track of the highest RMS level seen so far
max_rms_seen = 0


# Global variable to keep track of the highest RMS level seen so far
max_rms_seen = 0

def draw_vu_meter(win, level):
    global max_rms_seen
    win.clear()

    # Update the highest RMS level seen if the current level is higher
    max_rms_seen = max(max_rms_seen, level)

    # Set a minimum threshold to ensure the VU meter reacts to lower levels
    min_threshold = 5
    max_rms_seen = max(max_rms_seen, min_threshold)

    # Scale the VU meter to the highest RMS level seen so far
    vu_meter_width = 10  # Width of the VU meter
    vu_meter = int((level / max_rms_seen) * vu_meter_width)
    vu_meter = min(max(vu_meter, 0), vu_meter_width)  # Clamp value between 0 and the width of the VU meter

    win.addstr(0, 0, "VU Meter:")
    win.addstr(1, 0, '[' + '=' * vu_meter + ' ' * (vu_meter_width - vu_meter) + ']')
    win.addstr(2, 0, f'RMS Level: {level:.2f} / {max_rms_seen:.2f}')  # Add RMS level logging
    win.refresh()


# Main function to run the VU meter
def main(win):
    recorder = audio_recorder.AudioRecorder()
    recorder.start()
    max_rms = 1000  # This is a placeholder, adjust according to your microphone and environment

    try:
        while True:
            data = recorder.stream.read(recorder.frames_per_buffer, exception_on_overflow=False)
            rms = calculate_rms(data, recorder.format)
            draw_vu_meter(win, rms)  # Updated to pass only 2 arguments

            curses.napms(50)  # Refresh every 50 milliseconds
    except KeyboardInterrupt:
        pass
    finally:
        recorder.stop()

if __name__ == "__main__":
    curses.wrapper(main)
