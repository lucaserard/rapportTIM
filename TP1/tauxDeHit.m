function perf=tauxDeHit(resultats)
    perf=0;
    for i=1:length(resultats)
        if(resultats(i)==floor((i-1)/10))
            perf=perf+1;
        end
    end
end