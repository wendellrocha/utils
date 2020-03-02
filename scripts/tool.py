 
import sys


def usage():
    print("\nUsage: tool.py [file] [search key] [outfile]\n")


def run():
    if len(sys.argv[1:]) == 0:
        usage()
    try:
        arquivo = open(sys.argv[1], "r")
        texto = arquivo.readlines()
        key = str(sys.argv[2])
        arq = open(sys.argv[3], "w")

        for index, line in enumerate(texto):
            if key in line:
                arq.write(line)
                print('Line: %d, %s' % (index, line))

        arquivo.close()
        arq.close()
    except:
        print("File not exists")


run()
