package com.rank;

import com.model.Trilha;
import java.util.ArrayList;
import java.util.List;

public class Rank {

    public List<Trilha> organizar(List<Trilha> trilhas) {

        List<Trilha> list = new ArrayList<>(trilhas);

        list.sort((a, b) ->
                Integer.compare(b.getTotalVotes(), a.getTotalVotes())
        );

        return list;
    }
}