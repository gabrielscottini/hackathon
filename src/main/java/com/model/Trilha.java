package com.model;

public class Trilha {

    private int numero;
    private String nome;
    private String descricao;
    private int totalVotes = 0;

    public Trilha(int id, String nome, String descricao) {
        this.numero = id;
        this.nome = nome;
        this.descricao = descricao;

    }

    public void partido(int numero, String nome, String descricao, int totalVotes) {
        this.numero = numero;
        this.nome = nome;
        this.descricao = descricao;
        this.totalVotes = totalVotes;
    }

    public void adicionarVotes
            () {
        this.totalVotes++
        ;
    }

    public int getId
            () {
        return numero
                ;
    }

    public int getTotalVotes
            () {
        return totalVotes
                ;
    }

    public String getNome
            () {
        return nome;
    }

    public void setNome(String nome
    ) {
        this.nome = nome
        ;
    }

    public void setNumero(int numero
    ) {
        this.numero = numero
        ;
    }

    public void setTotalVotes(int totalVotes
    ) {
        this.totalVotes = 0
        ;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public  String getDescricao() {
        return descricao;
    }
}
