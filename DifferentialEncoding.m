% Load the Images
no_imgs=27;
size_img=128*128;
x=zeros(no_imgs,size_img);
for i = 1:no_imgs
    x(i,:)=readimg(strcat('D:\Q3\DC\MR images\image',int2str(i),'.png'));
end

%Finding the differences between adjacent pixels
x=reshape(x,[],1);
diff=zeros(size(x));
for i = 2:size_img*no_imgs
    diff(i)=x(i)-x(i-1);
end 

%Calculating the entropy 
[count,symbol] = groupcounts(diff);
p=count./(size_img*no_imgs);
sumofp=sum(p);
entropy =-sum(p.*log2(p));
figure
stem(symbol,p)
set(gca,'yscal','log')
xlabel('Symbol')
ylabel('Probability')

%Creating the huffman dictionary
[dict,avglen]=huffmandict(symbol,p);
code_eff=entropy/avglen
comp_ratio=8/avglen
[g,t,s]=buildHuffmanGraph(dict);
figure
h= plot(g, 'Layout', 'layered', 'NodeLabel', g.Nodes.Name);
highlight(h,setdiff(t,s),'NodeColor','r')

