# B2-People
## mvvm_arch
#### Refatoração do app inicial para versão com arquitetura MVVM

Usando este modelo arquitetural serão realizadas as seguintes modificações em relação à abordagem anterior:

Introdução à Orientação a Objetos, com uso de abstrações, encapsulamentos e herança, além da criação das camadas da arquitetura:

## Models
    User
    Profile
    Address
    
## Views
    HomePage
    UserPage

## ViewModels
    HomeController

## Data 
    Camada para consumo e tratamento de dados externos (API, storage).
    HomeRepositoryImpl


## Outras Melhorias

#### Estrutura de pastas:

    lib/
    └── src/
        ├── data/
        ├── models/
        ├── modules/
        └── view_models/
        └── views/
    tests/

#### Introdução de:
- Modularização;
- Injeção de dependências;
- Emprego do Strategy e Repository patterns;
- Componentização de Widgets;
- Testes de unidade;
- Testes de widget;
- Testes E2E.

#### :test_tube: Cobertura de testes em 75.7%

#### Packages adicionados:
    dio: ^5.9.0
    country_flags: ^4.1.0
    flutter_modular: ^6.4.1

#### Dependências de desenvolvimento:
    flutter_lints: ^5.0.0
    mocktail: ^1.0.4
    network_image_mock: ^2.1.1
    flutter_launcher_icons: ^0.14.4

Para ver o projeto na prática, clone o repositório usando:

`git clone https://github.com/JrSEngineer/b2-people`

Selecione a branch desejada, com o comando:

`git branch mvvm_arch`

Recupere as dependências do projeto com:

`flutter pub get`

E pronto! Basta rodar a aplicação:

`flutter run`