# Desperte Mulher – Avaliação de Risco

## Sobre o Projeto

O projeto **Desperte Mulher** consiste em um protótipo desenvolvido em Flutter com o objetivo de apoiar a identificação de fatores de risco relacionados à violência doméstica e familiar contra a mulher.

A aplicação foi inspirada no Formulário Nacional de Avaliação de Riscos (AR PAX), utilizado como instrumento de apoio à análise de situações de vulnerabilidade e ameaça, transformando as respostas fornecidas pela usuária em indicadores de risco que auxiliam na compreensão da situação apresentada.

Além da implementação funcional do questionário, o projeto buscou aplicar conceitos de **UX Design**, **Acessibilidade Digital** e **Design Centrado no Usuário**, proporcionando uma experiência mais acolhedora, intuitiva e segura.

---

## Objetivos

### Objetivo Geral

Desenvolver uma aplicação mobile capaz de realizar uma avaliação de risco baseada em violência doméstica e familiar contra a mulher, apresentando ao final um relatório interpretativo dos resultados.

### Objetivos Específicos

* Aplicar conceitos de desenvolvimento mobile utilizando Flutter.
* Implementar um formulário estruturado com múltiplas etapas.
* Calcular indicadores de ameaça, vulnerabilidade e grau de risco.
* Gerar um relatório visual e interpretativo.
* Aplicar princípios de UX e acessibilidade.
* Melhorar a experiência do usuário em comparação ao protótipo inicial.

---

## Tecnologias Utilizadas

* Flutter
* Dart
* Material Design
* Navigator (gerenciamento de rotas)
* Widgets Stateful e Stateless

---

## Funcionalidades

### Avaliação de Risco

A aplicação apresenta um questionário dividido em etapas contendo perguntas relacionadas a:

* Histórico de ameaças;
* Violência física;
* Violência sexual;
* Controle e perseguição;
* Descumprimento de medidas protetivas;
* Situação familiar;
* Dependência financeira;
* Vulnerabilidades sociais;
* Acesso do agressor a armas de fogo.

As respostas são processadas para compor os indicadores utilizados no relatório final.

---

### Relatório Final

Ao concluir a avaliação, a usuária recebe um relatório contendo:

* Grau de vulnerabilidade;
* Grau de ameaça;
* Grau geral de risco;
* Classificação de risco;
* Interpretação dos resultados;
* Recomendações iniciais;
* Canais de apoio e emergência;
* Resumo das respostas fornecidas.

---

### Identificação Opcional

Antes da geração do relatório, a usuária pode optar por:

* Continuar de forma anônima;
* Informar dados para identificação no relatório.

Essa funcionalidade respeita diferentes necessidades de privacidade e segurança.

---

## Melhorias de UX Implementadas

O projeto original foi reformulado com foco em experiência do usuário.

### Nova Identidade Visual

Foi adotada uma paleta baseada em:

* Lavanda;
* Lilás;
* Rosa bebê.

Essas cores foram escolhidas por transmitirem:

* Acolhimento;
* Segurança;
* Tranquilidade;
* Sensação de cuidado.

---

### Hierarquia Visual

Foram adicionados:

* Indicadores de progresso;
* Separação clara das perguntas;
* Cartões informativos;
* Destaque visual para resultados críticos.

---

### Navegação

O fluxo foi reorganizado para:

1. Avaliação;
2. Escolha de identificação;
3. Relatório final.

Reduzindo a complexidade da navegação e tornando o processo mais intuitivo.

---

## Recursos de Acessibilidade

O sistema também incorpora recursos voltados à acessibilidade.

### Alto Contraste

Permite aumentar a legibilidade para usuários com baixa visão.

### Aviso de Confidencialidade

Informa que os dados fornecidos são confidenciais e que o relatório pode ser gerado anonimamente.

### Saída Rápida

Permite encerrar imediatamente a avaliação e retornar à tela inicial.

Esse recurso é especialmente importante para contextos de vulnerabilidade e segurança.

### Indicador de Progresso

Exibe o andamento da avaliação através de:

* Barra de progresso;
* Identificação da pergunta atual;
* Quantidade total de perguntas.

---

## Estrutura do Projeto

```text
lib/
│
├── Models/
│
├── common/
│   ├── app_routes.dart
│   └── route_manager.dart
│
├── Screens/
│   ├── login/
│   ├── registration/
│   ├── profile/
│   ├── photo/
│   ├── quiz/
│   └── result/
│
└── main.dart
```

---

## Principais Alterações Realizadas

### Quiz

* Atualização das perguntas.
* Inclusão do cálculo de risco.
* Reestruturação visual.
* Inclusão de acessibilidade.
* Inclusão de anonimato.

### Relatório

* Novo layout visual.
* Interpretação dos resultados.
* Recomendações contextualizadas.
* Resumo das respostas.
* Canais de emergência.

### Interface

* Nova paleta de cores.
* Gradientes suaves.
* Melhor organização visual.
* Melhor legibilidade.

---

## Considerações Finais

O desenvolvimento deste projeto permitiu aplicar conhecimentos de desenvolvimento mobile, experiência do usuário, acessibilidade e design de interfaces, demonstrando como a tecnologia pode ser utilizada para apoiar iniciativas voltadas à proteção e orientação de mulheres em situação de vulnerabilidade.

Mais do que apresentar resultados numéricos, a proposta buscou transformar a avaliação em uma experiência acolhedora, compreensível e segura para a usuária.
