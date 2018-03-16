import random
import sys


class FakeRecord(object):
    
    def __init__(self, record_id):
        self.ID = record_id

    @staticmethod
    def _create_order_id():
        return 'order{:06d}'.format(random.randint(0x1FFFF, 0x7FFFF))

    @staticmethod
    def _create_date():
        return '{:04d}-{:02d}-{:02d}'.format(
            random.randint(2011, 2018), random.randint(01, 12),
            random.randint(01, 28)
        )

    @staticmethod
    def _create_customer_id():
        return 'cid{:04d}'.format(random.randint(0xFF, 0x1FF))

    @staticmethod
    def _create_item_count():
        s = str(random.randint(0x1, 0xF))
        return s.rjust(4)

    @staticmethod
    def _create_weight():
        s = '{:.03f}'.format(random.randint(0x32, 0x63) / 11.14)
        return s.rjust(8)

    @staticmethod
    def _create_value():
        s = '{:.03f}'.format(random.randint(0x13, 0x78) / 0.56)
        return s.rjust(8)

    @staticmethod
    def _create_shipping():
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


def run(sz):
    for i in xrange(sz):
        print FakeRecord(i).to_str()


def run_tests(sz):
    for i in xrange(sz):
        print FakeRecord(i).to_str()


if len(sys.argv[1:]) == 1 and (sys.argv[1]).isdigit():
    size = int(sys.argv[1])
    print FakeRecord.create_header()
    run(size)
else:
    print FakeRecord.create_header()
    run_tests(10)
