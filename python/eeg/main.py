from main_controller import MainController
from visualizer import Visualizer

def main():
    visualizer = Visualizer()
    controller = MainController(visualizer)
    try:
        controller.run()
    finally:
        visualizer.close()  # Ensures ncurses window is properly closed

if __name__ == "__main__":
    main()
