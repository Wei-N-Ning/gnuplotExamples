#!/usr/bin/env bash

function createData() {
    echo "
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
" > /tmp/_.py
    if ! ( /usr/bin/env python /tmp/_.py 100 > /tmp/_ ); then
        echo "failed to create data"
        exit 1
    fi
}

function runGnuplot() {
    echo "${PNG_OUTPUT}
unset key
set multiplot layout 2,2 margins 0.06,0.95,0.085,0.95 spacing 0.075,0.1

# ----
set xtics 2,2
set mxtics 2
set label 1 'Orders per Day' at 8,3
plot [1:14] '/tmp/_' u (strcol(2)[9:10]+0):(1) s f w lp pt 7
set xtics 1
unset mxtics
# ----
set label 1 'Histogram:\nItems per Order' at 3.5,50
plot [0:7] '' u 4:(1) s f w boxes
# ----
set label 1 'Value v.s. Weight' at 4,7
plot '' u 5:6 w p pt 6
# ----
set xtics ('Date' 1, 'Items' 2, 'Weight' 3, 'Value' 4, 'Ship' 5)
unset ytics

set style parallel lw 1
set linetype 1000 lc '0xff000000'
ship(c) = 0+strcol(c)[1:1]
unset label 1
plot [1:5] '' u (strcol(2)[9:10]+0):4:5:6:(ship(7)) w parallel lt 10,\
'' u (strcol(2)[9:10]+0):4:5:6:(ship(7)):(ship(7)==0?1:1000) w parallel lc var
unset multi
" > /tmp/_.gnuplot
    gnuplot -p -c /tmp/_.gnuplot
}

function run() {
    createData
    runGnuplot
}

run
