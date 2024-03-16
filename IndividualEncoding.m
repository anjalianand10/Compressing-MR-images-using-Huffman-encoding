no_imgs=27;
size_img=128*128;
x=zeros(no_imgs,size_img);
entropy=zeros(no_imgs,1);
avglen=zeros(no_imgs,1);
for i = 1:27
    x(i,:)=readimg(strcat('D:\Q3\DC\MR images\image',int2str(i),'.png'));
    [count,symbol] = groupcounts(reshape(x(i,:),[],1)) ;
    p=count./(size_img);
    entropy(i) =-sum(p.*log2(p));
    [d,avglen(i)]=huffmandict(symbol,p);    
end
code_eff=entropy./avglen;
comp_ratio=8./avglen;
%[m,ind]=max(ent)