# Cep Finder

## Introdução
Carlos é um servidor público de 48 anos que trabalha organizando documentos por
localidade. Ele precisa rotineiramente pesquisar endereços de CEP na internet para saber
qual o bairro correspondente e ter uma visão no mapa de onde fica esse bairro na cidade.
Além disso, Carlos precisa anotar todos os CEPs e endereços correspondentes numa
caderneta para ter o registro dos locais que ele já pesquisou a fim de futuramente utilizar
em relatórios da repartição na qual trabalha.

## Problema
Carlos reclama que o tempo de anotar o CEP e o endereço na caderneta atrasa o
seu fluxo de trabalho, ele também tem dificuldade em procurar na caderneta um endereço
que ele já anotou.
O Carlos não é muito chegado com tecnologia então, rotineiramente, tem
dificuldades em pesquisar os CEPs nos sites da internet e de visualizar no mapa,
principalmente quando o documento que ele está analisando está com um CEP inválido.

## Solução
Desenvolva um aplicativo para android, utilizando Flutter, que ajude o Carlos a
melhorar o seu fluxo de trabalho.

# Dependências do Projeto

## Dependências Principais

- [bloc](https://pub.dev/packages/bloc): Biblioteca para gerenciamento de estado usando o padrão BLoC (Business Logic Component).
- [brasil_fields](https://pub.dev/packages/brasil_fields): Utilizada para máscaras de dados brasileiros como CPF, CNPJ, e CEP.
- [cloud_firestore](https://pub.dev/packages/cloud_firestore): Integração com o Firestore do Firebase para armazenamento e sincronização de dados em tempo real.
- [equatable](https://pub.dev/packages/equatable): Facilita a comparação de objetos, essencial para gerenciar estados no BLoC.
- [fake_cloud_firestore](https://pub.dev/packages/fake_cloud_firestore): Simulação do Firestore em testes unitários.
- [flutter_bloc](https://pub.dev/packages/flutter_bloc): Implementação do padrão BLoC para Flutter.
- [firebase_core](https://pub.dev/packages/firebase_core): Dependência base para inicializar o Firebase em projetos Flutter.
- [flutter_svg](https://pub.dev/packages/flutter_svg): Renderiza imagens SVG no Flutter.
- [get_it](https://pub.dev/packages/get_it): Injeção de dependência para desacoplar componentes no Flutter.
- [go_router](https://pub.dev/packages/go_router): Solução moderna para gerenciamento de rotas no Flutter.
- [google_maps_flutter](https://pub.dev/packages/google_maps_flutter): Integração com o Google Maps para exibir mapas e interagir com geolocalização.
- [http](https://pub.dev/packages/http): Biblioteca para realizar requisições HTTP.
- [lottie](https://pub.dev/packages/lottie): Exibição de animações Lottie no Flutter.

## Dependências de Desenvolvimento

- [flutter_test](https://pub.dev/packages/flutter_test): Biblioteca para testes unitários e de widget no Flutter.
- [bloc_test](https://pub.dev/packages/bloc_test): Biblioteca para testes de blocos de estado (BLoC).
- [flutter_lints](https://pub.dev/packages/flutter_lints): Conjunto de regras de lint para garantir boas práticas no código.
- [mocktail](https://pub.dev/packages/mocktail): Biblioteca para simulação de objetos em testes unitários.
