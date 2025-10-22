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


Para ver o projeto na prática, clone o repositório usando:

`git clone https://github.com/JrSEngineer/b2-people`

Selecione a branch desejada, com o comando:

`git branch [branch]` (substitua [branch] pelo nome da branch desejada)

Recupere as dependências do projeto com:

`flutter pub get`

E pronto! Basta rodar a aplicação:

`flutter run`