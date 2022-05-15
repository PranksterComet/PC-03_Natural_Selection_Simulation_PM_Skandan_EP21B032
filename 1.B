import random
import math

'''
NOTE: 
Parity of r+c never changes for diag movement
Similar to 1A, matrix is printed out in each step and list of positions is printed at the end. Scanning takes place radially in order of increasing integer part
of radius. To verify that range is actually radial, during testing a character was printed on cells that were scanned. Shortest path
to target is as discussed on 1.C predator and prey chasing. Input parameters similar to 1A.  
No of moves to reach point = max(abs(dr), abs(dc))
'''

def sign(x):
    if x<0:
        return -1
    elif x>0:
        return 1
    else:
        return 0


    

cont = True
while cont:
    n = int(input("Matrix size: "))
    M = [[0]*n for i in range(n)]
    
    fnum = int(input("Number of Food particles: "))
    for i in range(fnum):
        row = int(input("Enter Row: "))
        col = int(input("Enter Col: "))
        M[row][col] = 2
        
    pos = [[n//2, n//2]] #List of Positions
    it = int(input("Number of Iterations: ")) #Iterations
    Rdis = int(input("Radial Distance: ")) #Radial Distance
    target = [] #Current Target

    #Scan for food
    def scan(r, c):
        if(len(target) == 0):
            mind = Rdis
            for j in range(1, Rdis+1):
                for k in range(-1*j, j+1):
                   t = math.floor(math.sqrt((j**2) - (k**2)))
                   #print(t)
                   dis = math.sqrt((t**2) + (k**2))

                   #Closest Distance
                   
                   while dis > j-1 and dis <= j:
                       dr = t
                       dc = k
                       #print(t)
                       if r+dr<n and r+dr>=0 and c+dc<n and c+dc >= 0 and M[r+dr][c+dc] == 2:
                            if min(mind, dis) == dis:
                                mind = dis
                                if(len(target)>0):
                                    target.pop()
                                    
                                target.append([r+dr, c+dc])
                           #M[r+dr][c+dc] = 3

                       dr = -1*t
                       if r+dr < n and r+dr >= 0 and c+dc < n and c+dc >= 0 and M[r+dr][c+dc] == 2:
                           if min(mind, dis) == dis:
                                mind = dis
                                if(len(target)>0):
                                    target.pop()
                                target.append([r+dr, c+dc])
                                
                       t -= 1
                       dis = math.sqrt((t**2) + (k**2))
    
    
    for i in range(0, it):
        print("Iteration: " + str(i))
        
        moved = False
        
        r = pos[i][0]
        c = pos[i][1]
        M[r][c] = 1

        scan(r, c)
        
        d = [1, 2, 3, 4, 5, 6, 7, 8]  #Random int from 1 to 8 specifies direction, 1:UP, 2:DOWN, 3:LEFT, 4:RIGHT, 5:NE, 6:SE, 7:SW, 8:NW
        #drn = {[-1, 0]:1, [1, 0]:2, [0, -1]:3, [0, 1]:4, [-1, 1]:5, [1, 1]:6, [1, -1]:7, [-1, -1]:8}
        if(r == 0):
            d.remove(1)
            if 5 in d:
                d.remove(5)
            if 8 in d:    
                d.remove(8)
        if(r == n-1):
            d.remove(2)
            if 6 in d:
                d.remove(6)
            if 7 in d:
                d.remove(7)
        if(c == 0):
            d.remove(3)
            if 7 in d:
                d.remove(7)

            if 8 in d:
                d.remove(8)

        if(c == n-1):
            d.remove(4)
            
            if 5 in d:
                d.remove(5)

            if 6 in d:
                d.remove(6)


        ind = random.randint(0, len(d)-1)

        dr = 0
        dc = 0

        if len(target) > 0:
            x = target[0][0]
            y = target[0][1]
            dr = x - r
            dc = y - c

            if((abs(dc) == 1 and abs(dr) == 1) or (abs(dr)==1 and abs(dc)==0) or (abs(dr)==0 and abs(dc)==1)):
               target.pop()

            dr = sign(dr)
            dc = sign(dc)
            moved = True
                          
        if moved == False:
            moved = True
            if d[ind]==1:
                dr = -1
            elif d[ind]==2:
                dr = 1
            elif d[ind]==3:
                dc = -1
            elif d[ind]==4:
                dc = 1
            elif d[ind]==5:
                dr = -1
                dc = 1
            elif d[ind]==6:
                dr = 1
                dc = 1
            elif d[ind]==7:
                dr = 1
                dc = -1
            elif d[ind]==8:
                dr = -1
                dc = -1

        pos.append([r+dr, c+dc])
        print(target)
        
        for j in M:
            print(j)
        
        M[r][c] = 0    

    print(pos)
    res = input("Do you want to continue? ")
            
    if(res == 'n'):
        cont = False
        
