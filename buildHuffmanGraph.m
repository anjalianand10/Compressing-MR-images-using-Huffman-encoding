function [G,t,s] = buildHuffmanGraph(dict)
    nodeCount = 1; 
    edges = zeros(0,3); 
    labels = {'Root'}; 

    for i = 1:size(dict, 1)
        code = dict{i, 2}; 
        currentNode = 1; 

        for bit = code
            if isempty(edges)
                edge = []; 
            else
                edge = find(edges(:,1) == currentNode & edges(:,3) == bit, 1);
            end
            
            if isempty(edge) 
                nodeCount = nodeCount + 1;
                edges(end+1, :) = [currentNode, nodeCount, bit]; 
                currentNode = nodeCount; 
                labels{end+1} = sprintf('%d', nodeCount); 
            else
                currentNode = edges(edge, 2);
            end
        end
        labels{currentNode} = sprintf('S= \\bf%d\\rm',dict{i,1}); 
    end
    
    s = edges(:,1);
    t = edges(:,2);
    G = graph(s, t, [], labels);
end
