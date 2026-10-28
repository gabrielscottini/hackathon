
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Trilha" %>
<%@ page import="com.service.TrilhaService" %>

<%
    request.setCharacterEncoding("UTF-8");

    TrilhaService service = TrilhaService.getInstancia();

    String mensagem = null;
    String tipoMensagem = "success";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String idRecebido = request.getParameter("id");

        try {
            int id = Integer.parseInt(idRecebido == null ? "" : idRecebido);

            if (service.registrarVoto(id)) {
                mensagem = "Voto computado com sucesso! Obrigado por participar.";
            } else {
                mensagem = "A opção selecionada não existe.";
                tipoMensagem = "error";
            }

        } catch (NumberFormatException e) {
            mensagem = "Selecione uma trilha válida.";
            tipoMensagem = "error";

        } catch (Exception e) {
            mensagem = "Erro ao registrar o voto. Tente novamente.";
            tipoMensagem = "error";
            application.log("Erro ao registrar voto", e);
        }
    }

    List<Trilha> trilhas = null;
    String erroLeitura = null;

    try {
        trilhas = service.listarTrilhas();
    } catch (Exception e) {
        erroLeitura = "Não foi possível carregar as trilhas.";
        application.log("Erro ao carregar trilhas", e);
    }

    int totalTrilhas = trilhas == null ? 0 : trilhas.size();
%>

<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Votação de Trilhas - Mundo SENAI</title>

    <script src="https://cdn.tailwindcss.com"></script>

    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        senai: {
                            blue: '#004A99',
                            darkBlue: '#002E62',
                            red: '#E30613'
                        }
                    },
                    fontFamily: {
                        sans: ['Inter', 'Segoe UI', 'Arial', 'sans-serif']
                    }
                }
            }
        };
    </script>

    <style>
        .candidate-card {
            transition: transform 0.25s, box-shadow 0.25s;
        }

        .candidate-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.10);
        }
    </style>
</head>

<body class="bg-gray-100 text-gray-800 min-h-screen flex flex-col font-sans">

<!-- CABEÇALHO -->

<header class="bg-white border-b border-gray-200 shadow-sm">

    <div class="max-w-6xl mx-auto px-4 h-20 flex items-center justify-between">

        <div class="flex items-center space-x-4">

            <div class="bg-senai-blue text-white font-extrabold px-4 py-2 rounded text-lg">
                SENAI
            </div>

            <div class="border-l border-gray-300 pl-4">

                    <span class="text-xs uppercase text-gray-500 font-semibold block">
                        Feira Tecnológica
                    </span>

                <span class="font-bold text-gray-900">
                        Mundo SENAI
                    </span>

            </div>

        </div>

        <span class="hidden sm:inline-flex items-center px-3 py-2 rounded-full text-xs font-semibold bg-green-50 text-green-700 border border-green-200">

                <span class="w-2 h-2 bg-green-500 rounded-full mr-2"></span>

                Votação Aberta ate as 19 horas

            </span>

    </div>

</header>

<!-- CONTEÚDO PRINCIPAL -->

<main class="flex-grow max-w-6xl w-full mx-auto px-4 sm:px-6 py-10">

    <!-- INTRODUÇÃO -->

    <section class="mb-10 bg-white p-6 sm:p-8 rounded-2xl border border-gray-200 shadow-sm">

        <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-5">

            <div>

                <div class="flex items-center gap-3 mb-3">

                        <span class="bg-senai-blue text-white w-9 h-9 rounded-lg flex items-center justify-center font-bold">
                            1
                        </span>

                    <h1 class="text-2xl sm:text-3xl font-extrabold text-gray-900">
                        Escolha seu curso favorito
                    </h1>

                </div>

                <p class="text-gray-600 text-base sm:text-lg">
                    Selecione uma das opções abaixo e registre seu voto.
                </p>

            </div>

            <div class="bg-gray-50 border border-gray-200 rounded-xl px-4 py-3 text-sm text-gray-600">

                Total de cursos:

                <strong class="text-gray-900">
                    <%= totalTrilhas %>
                </strong>

            </div>

        </div>

    </section>

    <!-- MENSAGENS -->

    <% if (mensagem != null) { %>

    <% if ("success".equals(tipoMensagem)) { %>

    <div class="mb-6 bg-green-100 border border-green-300 text-green-800 p-4 rounded-xl font-semibold" role="alert">
        <%= mensagem %>
    </div>

    <% } else { %>

    <div class="mb-6 bg-red-100 border border-red-300 text-red-800 p-4 rounded-xl font-semibold" role="alert">
        <%= mensagem %>
    </div>

    <% } %>

    <% } %>

    <!-- LISTA DE TRILHAS -->

    <% if (erroLeitura != null) { %>

    <div class="bg-red-100 text-red-800 p-5 rounded-xl" role="alert">
        <%= erroLeitura %>
    </div>

    <% } else if (trilhas != null && !trilhas.isEmpty()) { %>

    <div class="space-y-6">

        <%
            int numero = 1;

            for (Trilha trilha : trilhas) {
        %>

        <article class="candidate-card relative bg-white rounded-2xl border border-gray-200 p-6 sm:p-9 shadow-sm overflow-hidden">

            <!-- FAIXA COLORIDA -->

            <div class="absolute left-0 top-0 bottom-0 w-2 bg-senai-blue"></div>

            <div class="flex flex-col md:flex-row md:items-center justify-between gap-6 pl-3">

                <!-- INFORMAÇÕES -->

                <div class="flex-1">

                            <span class="inline-block text-xs font-bold uppercase tracking-wider text-blue-800 bg-blue-50 px-3 py-1 rounded-md border border-blue-200 mb-4">

                                Opção <%= numero %>

                            </span>

                    <div class="flex items-center gap-3 mb-3">

                                <span class="text-lg font-bold text-gray-400">
                                    #<%= numero %>
                                </span>

                        <h2 class="text-2xl font-bold text-gray-900">
                            <%= trilha.getNome() %>
                        </h2>

                    </div>

                    <p class="text-gray-600 leading-relaxed">
                        <%= trilha.getDescricao() %>
                    </p>

                </div>

                <!-- BOTÃO DE VOTO -->

                <div class="md:border-l border-gray-100 md:pl-8 pt-4 md:pt-0">

                    <form method="post" action="<%= request.getContextPath() %>/index.jsp">

                        <input type="hidden"
                               name="id"
                               value="<%= trilha.getId() %>">

                        <button type="submit"
                                class="w-full md:w-auto min-w-[200px] px-6 py-4 bg-white hover:bg-senai-blue text-gray-900 hover:text-white border-2 border-gray-300 hover:border-senai-blue font-semibold rounded-xl transition duration-200">

                            Votar neste curso

                        </button>

                    </form>

                    <p class="text-xs text-gray-400 text-center mt-3">
                        Clique para registrar seu voto
                    </p>

                </div>

            </div>

        </article>

        <%
                numero++;
            }
        %>

    </div>

    <% } else { %>

    <div class="bg-yellow-100 text-yellow-800 p-5 rounded-xl">
        Nenhum curso foi cadastrada no arquivo trilhas.txt.
    </div>

    <% } %>

</main>

<!-- RODAPÉ -->

<footer class="mt-auto bg-white border-t border-gray-200 py-8">

    <div class="max-w-6xl mx-auto px-4 sm:px-6">

        <div class="flex flex-col sm:flex-row items-center justify-between gap-6 pb-6 border-b border-gray-100">

            <div class="flex items-center gap-3 text-gray-700">

                <span class="w-3 h-3 bg-green-500 rounded-full"></span>

                <span>
                        Votação aberta ao público ·
                        <strong>Mundo SENAI</strong>
                    </span>

            </div>

            <!-- LINK CORRETO DO RANKING -->

            <a href="<%= request.getContextPath() %>/resultado.jsp"
               class="inline-flex items-center justify-center px-7 py-4 bg-senai-red hover:bg-red-700 text-white font-bold rounded-xl shadow-md transition duration-200">

                Ver ranking da feira →

            </a>

        </div>

        <div class="pt-6 flex flex-col sm:flex-row items-center justify-between text-sm text-gray-500 gap-2">

            <p>
                SENAI · Educação Profissional e Tecnológica
            </p>

            <p>
                Inovação, Indústria 4.0 e Futuro do Trabalho
            </p>

        </div>

    </div>

</footer>

</body>
</html>
