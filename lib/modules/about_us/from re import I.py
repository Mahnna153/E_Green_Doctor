n=int(input('enter the n yalue=?'))
if n<=0:
    print('the number must be +ve')
else:
    fac=1;s=0
    for i in range(1.n+1):
        fac=fac*i
        s=s+i/fac
    print(s)