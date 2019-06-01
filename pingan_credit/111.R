A %你的系数矩阵
m=zeros(113*113,3);
for i=1:1:113
  for j=1:1:113
    m(i*j,1)=i;
    m(i*j,2)=j;
    m(i*j,3)=A(i,j)
  end
end

m就是你要的矩阵