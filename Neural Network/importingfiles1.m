opts = detectImportOptions('filenames.xlsx');
H = readmatrix('filenames.xlsx',opts);
opts = detectImportOptions('lhs_data.xlsx');
K = readmatrix('lhs_data.xlsx',opts);
for z=1:350
    fname=H{z};
    opts = detectImportOptions(fname);
    M = readmatrix(fname,opts);
    f=M(:,1);
    S=M(:,2);
    for i=1:1001
        if S(i)<=-10
            f1=f(i);
            p=i;
            break
        end
    end
    for i= p:1001
         if(S(i)<S(i+1))
            fr=f(i);
            q=i;
            break
         end
    end
    for i=q:1001
         if(S(i)>-10)
            f2=f(i-1);
            break
         end
    end
    K(z+1,5)=f1;
    K(z+1,6)=f2;
    K(z+1,7)=fr
    end