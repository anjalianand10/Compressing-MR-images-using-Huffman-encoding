% Loading the images and grouping 4 pixels
no_imgs=27;
size_img=128*128;
l=128;
blocks=cell([]);
for n=1:no_imgs
    img= imread(strcat('D:\Q3\DC\MR images\image',int2str(n),'.png'));
    x=double(img);
    c=cell(l/2,l/2);
    for i = 1:l/2
        for j =1:l/2
            c{i,j}=reshape(x(i*2-1:i*2,j*2-1:j*2),1,[]);
        end
    end
    blocks=[blocks;c];
end

%Calculate distribution and entropy
blocks_rearranged=reshape(blocks,[],1);
blocks_mat=cell2mat(blocks_rearranged);
[symbol,~,ic] = unique(blocks_mat, 'rows');
count = accumarray(ic, 1);
p=count./length(blocks_mat);
sumofp=sum(p);
entropy =-sum(p.*log2(p));

%Creating the huffman dictionary
symn=double(1:length(symbol));
[dict,avglen]=huffmandict(symn,p);
avglenppixel=avglen/4;
code_eff=entropy/avglen
comp_ratio=32/avglen


