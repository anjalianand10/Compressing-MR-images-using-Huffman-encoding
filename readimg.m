function x = readimg(loc)
    img=imread(loc);
    x=reshape(double(img),[],1);
end