package com.repository;


import com.model.Trilha;
import java.io.*;
import java.util.ArrayList;
import java.util.List;


public class TrilhaRepository {


    public List<Trilha> carregarTrilhas() throws IOException {


        List<Trilha> trilhas = new ArrayList<>();


        InputStream arquivo = getClass().getClassLoader()
                .getResourceAsStream("trilhas.txt");


        if (arquivo == null) {
            throw new IOException("Arquivo trilhas.txt não encontrado");
        }


        BufferedReader leitor = new BufferedReader(
                new InputStreamReader(arquivo, "UTF-8")
        );


        String linha;


        while ((linha = leitor.readLine()) != null) {


            String[] dados = linha.split(";", 3);




            if (dados.length == 3) {


                int id = Integer.parseInt(dados[0].trim());
                String nome = dados[1].trim();
                String descricao = dados[2].trim();


                Trilha trilha = new Trilha(id, nome, descricao);




                trilhas.add(trilha);
            }
        }


        leitor.close();


        return trilhas;
    }
}