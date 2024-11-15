import time
from pythonosc import dispatcher
from pythonosc import osc_server

ip = "0.0.0.0"
port = 5001

def eeg_handler(address: str, *args):
    try:
        timestamp_ns = time.time_ns()
        printStr = f"{timestamp_ns}"
        for arg in args:
            printStr += f",{arg}"
        print(printStr)
    except Exception as e:
        print(f"Error in eeg_handler: {e}")

if __name__ == "__main__":
    try:
        disp = dispatcher.Dispatcher()
        disp.map("/muse/eeg", eeg_handler)
        server = osc_server.ThreadingOSCUDPServer((ip, port), disp)
        server.serve_forever()
    except KeyboardInterrupt:
        print("Server interrupted by user")
    except Exception as e:
        print(f"Error in main: {e}")

