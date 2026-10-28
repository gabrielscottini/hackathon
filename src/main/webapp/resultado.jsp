
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Trilha" %>
<%@ page import="com.service.TrilhaService" %>
<%@ page import="com.rank.Rank" %>

<%
    TrilhaService service = TrilhaService.getInstancia();

    Rank rank = new Rank();

    List<Trilha> lista = rank.organizar(service.listarTrilhas());

    int totalVotos = 0;

    for (Trilha trilha : lista) {
        totalVotos += trilha.getTotalVotes();
    }

    int posicao = 1;
%>

<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Ranking dos Cursos - Mundo SENAI</title>

    <script src="https://cdn.tailwindcss.com"></script>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">

    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        sans: ['Inter', 'Arial', 'sans-serif']
                    },

                    colors: {
                        brand: {
                            500: '#3b82f6',
                            600: '#2563eb',
                            700: '#1d4ed8',
                            800: '#1e40af',
                            900: '#1e3a8a',
                            950: '#0f172a'
                        }
                    }
                }
            }
        };
    </script>

    <style>
        body {
            font-family: 'Inter', Arial, sans-serif;
        }

        .ranking-card {
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .ranking-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(37, 99, 235, 0.10);
        }
    </style>

</head>

<body class="bg-slate-50 text-slate-800 min-h-screen flex flex-col">

<!-- CABEÇALHO -->

<header class="relative bg-gradient-to-r from-brand-950 via-brand-900 to-brand-800 text-white shadow-xl overflow-hidden py-16 px-4">

    <div class="absolute -top-24 -left-20 w-96 h-96 bg-blue-500/20 rounded-full blur-3xl"></div>

    <div class="max-w-4xl mx-auto text-center relative">

        <div class="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-white/10 text-blue-200 text-xs font-semibold uppercase tracking-wider mb-5 border border-white/10">

            <span class="text-yellow-400">★</span>

            Resultado da Votação

        </div>

        <h1 class="text-3xl sm:text-5xl font-extrabold text-white mb-4">

            Ranking dos Cursos

        </h1>

        <p class="text-base sm:text-lg text-blue-100">

            Confira os cursos mais votados do Mundo SENAI!

        </p>

    </div>

</header>

<!-- CONTEÚDO -->

<main class="flex-grow max-w-4xl w-full mx-auto px-4 sm:px-6 py-12">

    <!-- RESUMO -->

    <div class="flex flex-col sm:flex-row items-center justify-between gap-4 mb-8 pb-5 border-b border-slate-200">

        <div>

            <h2 class="text-2xl font-bold text-slate-900">

                Classificação Geral

            </h2>

            <p class="text-sm text-slate-500 mt-2">

                Total de <strong><%= totalVotos %></strong> votos computados no sistema

            </p>

        </div>

        <div class="inline-flex items-center gap-2 px-4 py-2 bg-green-50 text-green-700 border border-green-200 rounded-full text-xs font-semibold">

            <span class="w-2 h-2 bg-green-500 rounded-full"></span>

            Resultado Atual

        </div>

    </div>

    <!-- LISTA DO RANKING -->

    <div class="space-y-4">

        <% for (Trilha trilha : lista) {

            int votos = trilha.getTotalVotes();

            double porcentagem = 0;

            if (totalVotos > 0) {
                porcentagem = (votos * 100.0) / totalVotos;
            }

            String corBorda = "bg-slate-300";
            String corPosicao = "bg-slate-50 text-slate-500 border-slate-200";
            String corBarra = "bg-slate-300";
            String destaque = "";

            if (posicao == 1) {

                corBorda = "bg-gradient-to-b from-yellow-400 to-amber-500";
                corPosicao = "bg-yellow-50 text-yellow-700 border-yellow-200";
                corBarra = "bg-yellow-400";

                destaque = "★ Mais Votado";

            } else if (posicao == 2) {

                corBorda = "bg-gradient-to-b from-slate-400 to-slate-500";
                corPosicao = "bg-slate-100 text-slate-700 border-slate-200";
                corBarra = "bg-slate-400";

            } else if (posicao == 3) {

                corBorda = "bg-gradient-to-b from-amber-600 to-amber-700";
                corPosicao = "bg-amber-50 text-amber-800 border-amber-200";
                corBarra = "bg-amber-600";

            }
        %>

        <!-- CARD DA TRILHA -->

        <div class="ranking-card relative bg-white rounded-2xl p-5 sm:p-6 shadow-md border border-slate-100 overflow-hidden">

            <!-- FAIXA LATERAL -->

            <div class="absolute left-0 top-0 bottom-0 w-2.5 <%= corBorda %>"></div>

            <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-5 pl-3">

                <!-- INFORMAÇÕES -->

                <div class="flex items-center gap-4">

                    <!-- POSIÇÃO -->

                    <div class="flex-shrink-0 w-12 h-12 rounded-xl border flex items-center justify-center font-black text-lg <%= corPosicao %>">

                        <%= posicao %>º

                    </div>

                    <!-- NOME -->

                    <div>

                        <div class="flex items-center gap-2 flex-wrap">

                            <h3 class="text-lg font-bold text-slate-900">

                                <%= posicao %>º - <%= trilha.getNome() %>

                            </h3>

                            <% if (posicao == 1) { %>

                            <span class="text-xs font-bold px-3 py-1 rounded-full bg-yellow-100 text-yellow-800">

                                        <%= destaque %>

                                    </span>

                            <% } %>

                        </div>

                        <p class="text-xs text-slate-400 mt-2">

                            <% if (posicao == 1) { %>

                            Primeiro colocado no ranking

                            <% } else if (posicao == 2) { %>

                            Segundo colocado no ranking

                            <% } else if (posicao == 3) { %>

                            Terceiro colocado no ranking

                            <% } else { %>

                            Participante da classificação geral

                            <% } %>

                        </p>

                    </div>

                </div>

                <!-- VOTOS E PORCENTAGEM -->

                <div class="sm:text-right min-w-[150px]">

                    <div class="flex items-baseline sm:justify-end gap-2">

                            <span class="text-2xl font-extrabold text-brand-700">

                                <%= votos %>

                            </span>

                        <span class="text-xs font-medium text-slate-500 uppercase">

                                <%= votos == 1 ? "voto" : "votos" %>

                            </span>

                    </div>

                    <p class="text-xs text-slate-500 mt-1">

                        <%= String.format(java.util.Locale.US, "%.1f", porcentagem) %>% dos votos

                    </p>

                    <!-- BARRA DE PROGRESSO -->

                    <div class="w-full sm:w-36 bg-slate-100 rounded-full h-2 mt-3 overflow-hidden ml-auto">

                        <div class="<%= corBarra %> h-2 rounded-full"
                             style="width: <%= porcentagem %>%;">
                        </div>

                    </div>

                </div>

            </div>

        </div>

        <%
                posicao++;
            }
        %>

    </div>

    <!-- SEM PARTICIPANTES -->

    <% if (lista.isEmpty()) { %>

    <div class="bg-white p-8 rounded-xl text-center text-gray-500 border border-gray-200">

        Nenhuma trilha foi cadastrada.

    </div>

    <% } %>

    <!-- BOTÃO VOLTAR -->

    <div class="mt-12 text-center">

        <a href="<%= request.getContextPath() %>/index.jsp"
           class="inline-flex items-center justify-center gap-3 px-8 py-4 bg-brand-600 hover:bg-brand-700 text-white font-semibold rounded-xl shadow-lg transition duration-200">

            <span>←</span>

            Voltar para votação

        </a>

    </div>

</main>

<!-- RODAPÉ -->

<footer class="py-6 border-t border-slate-200 text-center text-sm text-slate-500 bg-white">

    <p>
        Alunos: Gabriel Scottini, Lucas Henrique Schuch, Warlley Ramon e Samuel. - 2026
    </p>

    <p class="mt-1">
        Mundo SENAI · Sistema de Votação
    </p>

</footer>

</body>
</html>
