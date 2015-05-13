function delete_secure( h )
% delete_secure( h )
% Delete graphics handle only if falid, without throwing error

    s = size(h); % h could be even a matrix
    for i=1:s(1)
        for j=1:s(2)
            try % If error appears because bad value is given, e.g. 0, skip
                delete(h(i,j));
            end
        end
    end
end
