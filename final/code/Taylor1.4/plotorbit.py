# usage:
# python plotorbit.py myfigure
#
# will save a line plot to figures/myfigure.png

import matplotlib.pyplot as plt
import numpy as np

if __name__ == '__main__':
  # load data
  f = open('output.txt','r')
  data = [line.split() for line in f]
  f.close()
  q = [x[0] for x in data]
  r = [x[1] for x in data]

  from sys import argv
  picname = argv[1]
  picname = 'figures/{0}.png'.format(picname)

  # create a figure, fig is now a matplotlib.figure.Figure instance
  fig = plt.figure()
  ax1 = fig.add_axes([0.15,0.2,0.7,0.7]) #  [left, bottom, width, height]          
  
  ax1.plot(q,r,'b.')

  ax1.set_xlabel('q')
  ax1.set_ylabel('r')
  # ax1.set_xlim([min(dates)-buffer,max(dates)+buffer]) 
  # ax1.set_ylim([0,24])

  ax1.set_title('Taylor 1.4 Solution')
  # plt.xticks([float(i)+0.5 for i in range(4)])
  # plt.yticks([float(i)+0.5 for i in range(3)])
  # ax1.set_xticklabels([1,5,25,50])
  # ax1.set_yticklabels([22,28,35])

  # add a second axes
  # ax2 = fig.add_axes([0.2,0.2,0.7,0.7]) #  [left, bottom, width, height]          
  # make the ylabel show up on RHS, independent
  # ax2 = ax1.twinx()

  plt.savefig(picname)

  plt.close(fig)

  print "figure saved to {0}".format(picname)

