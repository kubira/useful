import os
import exifread

for img in os.listdir('.'):
    if img in ['sort.py']:
        continue
    print img
    f = open('./'+img, 'rb')
    tags = exifread.process_file(f)
    f.close()
    try:
        print tags['EXIF DateTimeOriginal']
        datas = str(tags['EXIF DateTimeOriginal']).replace(" ", ":").split(":")
        os.rename('./'+img, datas[0]+datas[1]+datas[2]+"_"+datas[3]+datas[4]+datas[5]+".jpg")
    except:
        continue
