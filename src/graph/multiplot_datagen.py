import random
import sys

class FakeRecord(object):
    
    def __init__(self, ID, *args, **kwargs):
        self.ID = ID
        
    def _create_order_id(self):
        return 'order{:06d}'.format(random.randint(0x1FFFF, 0x7FFFF))
    
    def _create_date(self):
        return '{:04d}-{:02d}-{:02d}'.format(
            random.randint(2011, 2018), random.randint(01, 12),
            random.randint(01, 28)
        )
    
    def _create_customer_id(self):
        return 'cid{:04d}'.format(random.randint(0xFF, 0x1FF))
    
    def _create_item_count(self):
        s = str(random.randint(0x1, 0xF))
        return s.rjust(4)
        
    def _create_weight(self):
        s = '{:.03f}'.format(random.randint(0x32, 0x63) / 11.14)
        return s.rjust(8)
        
    def _create_value(self):
        s = '{:.03f}'.format(random.randint(0x13, 0x78) / 0.56)
        return s.rjust(8)
        
    def _create_shipping(self):
        return random.choice(['1-Regular', '0-Ground', '2-Express'])
    
    def to_str(self):
        s = list()
        s.append(self._create_order_id())
        s.append(self._create_date())
        s.append(self._create_customer_id())
        s.append(self._create_item_count())
        s.append(self._create_weight())
        s.append(self._create_value())
        s.append(self._create_shipping())
        return ' '.join(s)
    
    @staticmethod
    def create_header():
        return '#ID Date CusomterID ItemCount Weight Value ShipMethod'

def run(size):
    for i in xrange(size):
        print FakeRecord(i).to_str()

def run_tests(size):
    for i in xrange(size):
        print FakeRecord(i).to_str()

if len(sys.argv[1:]) == 1 and (sys.argv[1]).isdigit():
    size = int(sys.argv[1])
    print FakeRecord.create_header()
    run(size)
else:
    print FakeRecord.create_header()
    run_tests(10)
