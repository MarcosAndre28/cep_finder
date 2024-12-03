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

## Visão Geral
Este aplicativo foi desenvolvido utilizando o **Flutter** com a arquitetura **Clean Architecture**, visando criar uma estrutura escalável e de fácil manutenção. A Clean Architecture permite separar as responsabilidades em camadas distintas, facilitando a implementação de novas funcionalidades e a realização de testes.

## Arquitetura
A Clean Architecture é dividida em camadas, cada uma com responsabilidades bem definidas. Abaixo estão as camadas e suas funções:

### 1. **Presentation Layer (Camada de Apresentação)**

- **Responsabilidade**: Gerenciar a interação com o usuário.
- **Componentes principais**:
    - **Widgets**: Componentes visuais que exibem as informações para o usuário.
    - **BLoC (Business Logic Component)**: Gerencia o estado da UI de forma reativa, recebendo eventos e emitindo estados.

### 2. **Domain Layer (Camada de Domínio)**

- **Responsabilidade**: Contém a lógica de negócios independente de qualquer framework.
- **Componentes principais**:
    - **Entities**: Representações de objetos de domínio do sistema.
    - **Use Cases**: Casos de uso que implementam a lógica de negócios, orquestrando as interações entre as entidades e os repositórios.

### 3. **Data Layer (Camada de Dados)**

- **Responsabilidade**: Gerenciar a persistência de dados e interações com fontes externas (APIs, banco de dados, etc.).
- **Componentes principais**:
    - **Repositories**: Responsáveis por fornecer dados para os casos de uso, abstraindo a origem dos dados.
    - **Data Sources**: Fontes externas de dados, como APIs ou bancos de dados locais.

### 4. **Core Layer (Camada de Core)**

- **Responsabilidade**: Contém classes e utilitários compartilhados em toda a aplicação.
- **Componentes principais**:
    - **Modelos**: Representações de objetos de dados que são usados em toda a aplicação.
    - **Constantes**: Definições de constantes reutilizáveis.

## Vantagens da Clean Architecture

- **Escalabilidade**: A estrutura modular facilita a expansão do sistema sem comprometer a qualidade do código.
- **Testabilidade**: Cada camada pode ser testada independentemente, o que facilita a criação de testes unitários e de integração.
- **Manutenção**: As responsabilidades bem definidas de cada camada tornam a manutenção e a adição de novas funcionalidades mais simples e seguras.

## Como o código está organizado

O projeto segue uma estrutura de diretórios que reflete as camadas da Clean Architecture:

### Exemplo de fluxo de dados

1. **Presentation Layer** (BLoC) chama o **Use Case** da **Domain Layer**.
2. O **Use Case** solicita dados para o **Repository** na **Data Layer**.
3. O **Repository** interage com as **Data Sources** para obter os dados necessários.
4. O **Use Case** processa os dados e os retorna para o **BLoC**.
5. O **BLoC** emite um novo estado para a UI, que é renderizada pelos **Widgets**.

## Testes

A Clean Architecture facilita a criação de testes devido à separação clara de responsabilidades. Neste app, adotamos as seguintes práticas de testes:

- **Testes Unitários**: São realizados para validar a lógica de negócios nas camadas de domínio e casos de uso.

### Exemplos de Testes

- **Testes de Use Case**: Garantem que a lógica de negócios nos casos de uso funciona como esperado.
- **Testes de Repositórios**: Validam a integração entre os repositórios e as fontes de dados.
- **Testes de DataSources**: Verificam a correta interação com as fontes de dados externas, como APIs ou bancos de dados.
- **Testes de Models**: Garantem que os modelos de dados estão sendo manipulados corretamente.
- **Testes de BLoC**: Validam a emissão de estados corretos e o fluxo de eventos no BLoC.


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
