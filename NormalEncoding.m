%Loading the images
no_imgs=27;
size_img=128*128;
x=zeros(no_imgs,size_img);
for i = 1:27
    x(i,:)=readimg(strcat('D:\Q3\DC\MR images\image',int2str(i),'.png'));
end

%Calculating the entropy of all the slices together
[counts,symbol] = groupcounts(reshape(x,[],1));
p=counts./(size_img*no_imgs);
sumofp=sum(p);
entropy =-sum(p.*log2(p));
figure
stem(symbol,p)
xlabel('Symbol')
ylabel('Probability')
set(gca,'yscal','log')

%Creating the huffman dictionary
[dict,avglen]=huffmandict(symbol,p);
[g,t,s]=buildHuffmanGraph(dict);
figure
h= plot(g, 'Layout', 'layered', 'NodeLabel', g.Nodes.Name);
highlight(h,setdiff(t,s),'NodeColor','r')

%Encoding a particular image
sel_img=17;
y=x(sel_img,:);
code = huffmanenco(y,dict);
code_eff=entropy/avglen
comp_ratio=8/avglen

%Decoding and reconstructing the image
dec_img = huffmandeco(code,dict);
isequal(y,dec_img)
new_img=reshape(dec_img, [128,128]);
figure
imshow(uint8(new_img))