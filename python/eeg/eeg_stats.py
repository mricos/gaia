class EEGStats:
    def __init__(self, alpha=0.25):
        self.alpha = alpha
        self.avg = 0
        self.variance = 0
        self.n = 0

    def update(self, value):
        if self.n == 0:
            self.avg = value
        else:
            self.avg = self.alpha * value + (1 - self.alpha) * self.avg
            delta = value - self.avg
            self.variance = ((self.n - 1) * self.variance + delta * delta) / self.n
        self.n += 1

    def get_mean(self):
        return self.avg

    def get_std_dev(self):
        return self.variance ** 0.5 if self.n > 1 else 0

# Function to handle time delta calculations
def calculate_delta_time(prev_timestamp, current_timestamp):
    if prev_timestamp is None:
        return None
    return (current_timestamp - prev_timestamp) / 1e6  # Convert ns to ms
