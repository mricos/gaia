import curses
import sys
from datetime import datetime
from eeg_stats import EEGStats, calculate_delta_time

# Global variable for the previous timestamp
prev_timestamp_ns = None
total_delta_time_ms = 0

# Initialize EEGStats objects for each channel and for time delta
channel_stats = [EEGStats() for _ in range(5)]
time_delta_stats = EEGStats()

def parse_and_validate(line):
    global prev_timestamp_ns

    parts = line.strip().split(',')
    if len(parts) < 6:
        return None, ["Invalid line format"], None

    timestamp_ns = int(parts[0])
    delta_time_ms = calculate_delta_time(prev_timestamp_ns, timestamp_ns)
    prev_timestamp_ns = timestamp_ns

    # Update time delta stats
    if delta_time_ms is not None:
        time_delta_stats.update(delta_time_ms)
        global total_delta_time_ms
        total_delta_time_ms += delta_time_ms

    values = parts[1:]
    valid_values = []
    for i, val in enumerate(values):
        try:
            number = float(val)
            channel_stats[i].update(number)
            formatted_number = f"{number:.6g}".rjust(12)
            valid_values.append(formatted_number)
        except ValueError:
            valid_values.append("NaN".rjust(12))

    return datetime.fromtimestamp(timestamp_ns / 1e9).strftime('%Y-%m-%d %H:%M:%S.%f'), valid_values, delta_time_ms

def display_line(win, line, max_y, max_x, line_number):
    x = max_x // 2 - len(line) // 2
    y = line_number
    win.addstr(y, x, line)

def main(stdscr):
    while True:
        try:
            line = sys.stdin.readline()
            if line:
                max_y, max_x = stdscr.getmaxyx()
                timestamp, values, delta_time_ms = parse_and_validate(line)

                if timestamp:
                    stdscr.clear()

                    # Display timestamp
                    display_line(stdscr, f"Timestamp: {timestamp}", max_y, max_x, 1)

                    # Display total delta time and current delta time with statistics
                    total_time_str = f"Total Time: {total_delta_time_ms:.2f} ms"
                    delta_stats = f"Delta Time: {delta_time_ms:.2f} ms (Avg: {time_delta_stats.get_mean():.2f}, StdDev: {time_delta_stats.get_std_dev():.2f})"
                    display_line(stdscr, total_time_str, max_y, max_x, 2)
                    display_line(stdscr, delta_stats, max_y, max_x, 3)

                    # Display each channel value with its statistics
                    for i, value in enumerate(values):
                        channel_info = f"Channel {i+1}: {value} (Avg: {channel_stats[i].get_mean():.2f}, StdDev: {channel_stats[i].get_std_dev():.2f})"
                        display_line(stdscr, channel_info, max_y, max_x, i + 4)

                    stdscr.refresh()
                else:
                    # Handle invalid format
                    for i, msg in enumerate(values):
                        display_line(stdscr, msg, max_y, max_x, i + 1)
            else:
                # End of input
                break
        except KeyboardInterrupt:
            # Handle user interruption
            break

curses.wrapper(main)
