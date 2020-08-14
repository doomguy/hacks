from zipfile import ZipFile
with ZipFile('hello.zip') as myzip:
    with myzip.open('hello.py', mode='r', pwd=bytes('pass123', 'utf-8')) as myfile:
                    exec(myfile.read())
