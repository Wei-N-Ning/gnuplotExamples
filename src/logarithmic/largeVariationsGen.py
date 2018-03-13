
import random
import sys


class Point(object):
    
    def __init__(self, base_value, deviation):
        self._base_value = base_value
        self._deviation = deviation
    
    def y(self):
        return self._base_value * (1 - random.random() * self._deviation)


def iter_segments(from_, to_, num_segments):
    segment_size = (to_ - from_ + 1) / float(num_segments)
    half_size = segment_size / 2
    for x in xrange(from_, to_):
        distance = float(x - from_ + 1) % segment_size
        ratio = 1.0
        if distance >= 0 and distance < half_size:
            yield x, False, ratio
        else:
            yield x, True, ratio
    
    
def gen(from_, to_, num_peaks=3, deviation=0.75, min_=40, max_=4000):
    for x, is_peak, ratio in iter_segments(from_, to_, num_peaks):
        if is_peak:
            base_value = max_ * ratio
        else:
            base_value = min_ * ratio
        print x, Point(base_value, deviation).y()
        
        
def test():
    print list(iter_segments(1, 18, 3))


if __name__ == '__main__':
    if sys.argv[1:] == []:
        test()
    else:
        from_ = int(sys.argv[1])
        to_ = int(sys.argv[2])
        gen(from_, to_)
