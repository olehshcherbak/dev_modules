#########################     archiving in workdir
#
import os
import zipfile
from datetime import datetime, date, time

path = 'workdir'
file_dir = os.listdir(path)

with zipfile.ZipFile('archive.zip', mode='w', compression=zipfile.ZIP_DEFLATED) as zf:
    for file in file_dir:
        add_file = os.path.join(path, file)
        zf.write(add_file)


# rename files in workdir
time_stamp = datetime.now().strftime("%Y%m%d-%H%M")

for count, filename in enumerate(file_dir):
    dst = f"{time_stamp}-{str(count+1)}.jpg"
    src = f"{path}/{filename}"
    dst = f"{path}/{dst}"

    os.rename(src, dst)




##################            clean downloads in Linux by mask
#
# import os
os.chdir('~/Downloads')
for file in os.listdir():
    if file.endswith(('.iso', '.png', '.jpg')):
        os.remove(file)


# delete logs
import glob

# Get a list of all the file paths
fileList = glob.glob('/var/log/nginx/*.log')

for filePath in fileList:
    try:
        os.remove(filePath)
    except:
        print("Error while deleting file : ", filePath)
