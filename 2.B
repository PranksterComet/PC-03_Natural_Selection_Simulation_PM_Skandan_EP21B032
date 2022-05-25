
'''
NOTE: this code prints out scores of A, B and C types as well as their population each round. 
Press 'n' to quit
Min ind, max ind are for debugging purposes
For eliminating the lowest 5, the player with the lowest score and non-zero player loses 5 players if value>=5, else loses all its players if value < 5
this process is repeated till 5 players are eliminated
'''
cont = True

while cont:
    x = int(input("Enter number of A: "))
    y = int(input("Enter number of B: "))
    z = int(input("Enter number of C: "))

    def sig(x):
        if x>1:
            return 1
        else:
            return 0


    it = 1

    l = [x, y, z]

    while l[0]*l[1] + l[1]*l[2] + l[2]*l[0]>0:
        score = [0, 0, 0]

        print("Iteration:", it)

        for i in range(len(l)):
            if l[i] != 0:
                if i==0:
                    score[i] += (30*l[1] + 3*l[2])
                elif i==1:
                    score[i] += (-10*l[0] + 20*(l[1]-1)*sig(l[1]) + 20*l[2])
                elif i==2:
                    score[i] += (-1*l[0] + 20*l[1] + 20*(l[2]-1)*sig(l[2]))

        print("Scores: ", score)

        elim = 0
        temp = score.copy()
        t = -1
        while elim<5:
            t = -1
            while t==-1:
                m = min(temp)
                t = -1
                
                indices = [i for i, x in enumerate(score) if x == m]
                for k in indices:
                    if l[k] != 0:
                        t = k

                if t == -1:
                    temp.remove(m)    

            #print("Min Ind: ", t)
            if l[t] > 5 - elim:
                l[t] -= (5 - elim)
                elim = 5
            elif l[t] <= 5 - elim:
                elim += l[t]
                l[t] = 0
            

        t = score.index(max(score))

        #print("Max Ind:", t)
        l[t] += 5
        print("Players: ", l)
        '''       
        for i in range(len(l)):
            if l[i] == 0:
                l.remove(l[i])
        '''


        it += 1

    res = input("Do you want to continue?")
    if res == "n":
        cont = False
