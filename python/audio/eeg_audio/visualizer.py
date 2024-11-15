import curses
import numpy as np

class Visualizer:
    def __init__(self):
        # Initialize the ncurses screen
        self.screen = curses.initscr()
        curses.noecho()
        curses.cbreak()
        curses.start_color()
        self.screen.keypad(True)

        # Define color pair
        curses.init_pair(1, curses.COLOR_GREEN, curses.COLOR_BLACK)

        # Set up the window dimensions
        self.height, self.width = self.screen.getmaxyx()

    def display_vu_meter(self, audio_data):
        # Calculate the RMS (Root Mean Square) of the audio data
        rms = np.sqrt(np.mean(np.square(audio_data)))

        # Convert RMS to a logarithmic scale (dB)
        # Adding a small constant to avoid log(0) which is undefined
        db = 20 * np.log10(rms + 1e-6)

        # Normalize and scale dB value to fit the screen width
        # Adjust these values as needed for sensitivity
        min_db = -60  # Minimum dB value for display
        max_db = 0    # Maximum dB value for display
        db_normalized = (db - min_db) / (max_db - min_db)
        meter_width = int(db_normalized * self.width)

        # Ensure meter_width does not exceed screen width
        meter_width = min(meter_width, self.width)

        # Clear the screen and display the VU meter
        self.screen.clear()
        self.screen.addstr(0, 0, "#" * meter_width, curses.color_pair(1))
        self.screen.refresh()

    def close(self):
        # Revert the terminal to its original settings
        curses.nocbreak()
        self.screen.keypad(False)
        curses.echo()
        curses.endwin()

