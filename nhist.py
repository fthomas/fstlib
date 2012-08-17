#!/usr/bin/python

import matplotlib.pyplot as plt
import sys
import xml.sax

class NestingCounter(xml.sax.ContentHandler):
    def __init__(self):
        self.level = 0
        self.hist = {}

    def startElement(self, name, attrs):
        self.level += 1

        count = self.hist.get(self.level, 0)
        self.hist[self.level] = count + 1

    def endElement(self, name):
        self.level -= 1


nesting_counter = NestingCounter()

parser = xml.sax.make_parser()
parser.setContentHandler(nesting_counter)
parser.parse(open(sys.argv[1], "r"))

hist = nesting_counter.hist
for level, count in hist.iteritems():
    print level, count

plt.bar(hist.keys(), hist.values())
plt.show()
