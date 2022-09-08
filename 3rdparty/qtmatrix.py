from struct import *
import os, sys      

filename = sys.argv[1]
#filename = '/Users/reid/Desktop/tic.mov'
#filename = '/Users/reid/Sites/vidsite/SOAPnetDaytime.mov'

mvhdmatrix = {}
tkhdmatrix = {}
size = {}      

with open(filename, 'rb') as f:

        while f.read(4) != 'mvhd':
                pass
        f.seek(36, os.SEEK_CUR)
        mvhdmatrix['a'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        mvhdmatrix['b'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        mvhdmatrix['u'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        mvhdmatrix['c'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        mvhdmatrix['d'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        mvhdmatrix['v'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        mvhdmatrix['x'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        mvhdmatrix['y'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        mvhdmatrix['w'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        print mvhdmatrix

        while f.read(4) != 'tkhd':
                pass
        f.seek(40, os.SEEK_CUR)
        tkhdmatrix['a'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        tkhdmatrix['b'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        tkhdmatrix['u'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        tkhdmatrix['c'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        tkhdmatrix['d'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        tkhdmatrix['v'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        tkhdmatrix['x'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        tkhdmatrix['y'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        tkhdmatrix['w'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        print tkhdmatrix
        size['width'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        size['height'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        print size

        while f.read(4) != 'tkhd':
                pass
        f.seek(40, os.SEEK_CUR)
        tkhdmatrix['a'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        tkhdmatrix['b'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        tkhdmatrix['u'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        tkhdmatrix['c'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        tkhdmatrix['d'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        tkhdmatrix['v'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        tkhdmatrix['x'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        tkhdmatrix['y'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        tkhdmatrix['w'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        print tkhdmatrix
        size['width'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        size['height'] = int(unpack('>L', f.read(4))[0]) * 0.0000152587890625
        print size

#import hashlib
#m = hashlib.md5()
#with open(filename, 'rb') as f:
#       m.update(f.read())      
#print m.hexdigest()      
