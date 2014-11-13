%testing detection


L=length(array);
AVG=mean(abs(array));
array=abs(array);
starts=[];
ends=[];
i=1;
while i <= L-100
    test=array(i)>AVG;
    if test==1 
     i+1000   
     starts=[starts i];
        for k=i:(L-100)
            testarray=array(k:(k+100));
            test1=testarray>AVG;
            sumarray=sum(test1);
            if sumarray==0
                ends=[ends k];
                i=k;
                break
            end
        end
    end
    i=i+1;
end
