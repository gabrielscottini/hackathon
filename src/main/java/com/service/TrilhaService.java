package com.service;


import com.model.Trilha;
import com.repository.TrilhaRepository;

import java.io.IOException;
import java.util.List;


public class TrilhaService {


    private static TrilhaService instancia;
    private final List<Trilha> trills;


    private TrilhaService() throws IOException {
        TrilhaRepository repository = new TrilhaRepository();
        trills = repository.carregarTrilhas();
    }


    public static synchronized TrilhaService getInstancia()
            throws IOException {


        if (instancia == null) {
            instancia = new TrilhaService();
        }


        return instancia;
    }


    public List<Trilha> listarTrilhas() {
        return trills;
    }


    public synchronized boolean registrarVoto(int id) {


        for (Trilha trilha : trills) {


            if (trilha.getId() == id) {


                trilha.adicionarVotes();


                return true;
            }
        }


        return false;
    }
}