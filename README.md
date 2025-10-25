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

#### :test_tube: Cobertura de testes em 92.2%

#### Packages adicionados:
    dio: ^5.9.0
    country_flags: ^4.1.0
    flutter_modular: ^6.4.1
    google_sign_in: ^7.2.0
    firebase_core: ^4.2.0
    cloud_firestore: ^6.0.3

#### Dependências de desenvolvimento:
    flutter_lints: ^5.0.0
    mocktail: ^1.0.4
    network_image_mock: ^2.1.1
    flutter_launcher_icons: ^0.14.4
    fake_cloud_firestore: ^4.0.0

## :sparkles: Executando

Clone o repositório usando:

`git clone https://github.com/JrSEngineer/b2-people`

Selecione a branch mvvm_arch, com o comando:

`git branch mvvm_arch`

Recupere as dependências do projeto com:

`flutter pub get`

E pronto! Basta rodar a aplicação:

`flutter run`

## :test_tube: Rodando os testes:

para executar os testes integração realizados, va à pasta raiz do projeto e rode:

`flutter test .\integration_test\app_start_test.dart` 
Que executa o teste de inicialização com navegação para a página inicial

`flutter test .\integration_test\user_page_navigation_test.dart`
Que foi criado para selecionar o primeiro item na lista e navegar para a página do usuário selecionado.

## :rotating_light: AVISO :rotating_light:
Neste teste é necessário informar uma conta google para que o teste seja concluído com sucesso.

Rode também:

`flutter test`

para executar os testes unitários e de widget criados.