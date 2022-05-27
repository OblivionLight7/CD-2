import re

from re import split

def quadruple(fname: str):
    lines = []

    with open(fname) as file:
        for line in file.readlines():
            line = line.replace(" ", "").strip()

            if not line:
                continue

            result, _, parts = line.partition('=')
            arg1 = arg2 = operation = ''
            
            parts = split('[^\da-zA-Z]', parts)
            
            if len(parts) == 2:
                arg1, arg2 = parts
            elif len(parts) == 1:
                arg1 = parts[0]

            lines.append((
                operation or '=',
                arg1,
                arg2,
                result
            ))

    return lines

def display_table(table):
    if len(table) == 0:
        print("Empty Table")
        return

    print("-"*40)
    print("SrNo Operation Arg1 Arg2 Result")
    print("-"*40)

    for i, line in enumerate(table):
        print(
            f"{(i + 1):<4} {line[0]:<10} {line[1]:<4} {line[2]:<4} {line[3]} ")



def main() -> None:
    quadtable = quadruple('./cf.txt')

    display_table(quadtable)
#    print(quadtable[1])

if __name__ == '__main__':
    main()
