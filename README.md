# Neander em VHDL

Criação do computador Neander em VHDL para a matéria de Sistemas Digitais da Universade Estadual do Oeste do Paraná.

## Organização

| Abreviação | Nome       | Função                                                     |
| ---------- | ---------- | ---------------------------------------------------------- |
| tb         | Testbench  | Serve para testar os componentes/módulos                   |
| comp       | Componente | Realiza alguma ou várias funções                           |
| mod        | Módulo     | Conecta os componentes fazendo o funcionamento em paralelo |

## Componentes

| Nome     | Função                                                                        |
| -------- | ----------------------------------------------------------------------------- |
| Alu      | Faz as ações combinacionais (STA, AND, NOT, OR)                               |
| As_RAM   | Seria a memória RAM, armazenando valores nas posições                         |
| Contador | Faz a contagem do tempo necessário para executar uma instrução (0 até 7)      |
| Decode   | Faz a decodificação do barramento para a unidade de controle                  |
| Fadder1  | Faz o soma entre A e B (1 bit)                                                |
| Fadder4  | Chama e o fadder1 8 vezes, fazendo a soma de 1 byte                           |
| FFJKTD   | Basicamente armazena um valor ou faz a leitura de um registrador              |
| UC       | Verifica qual é a instrução a ser executada de acordo com o comando do decode |

## Módulos

| Nome     | Função                                                                                     |
| -------- | ------------------------------------------------------------------------------------------ |
| Controle | Verifica as instruções a ser executado e envia ao barramento de controle                   |
| Memória  | Responsável por armazenar os valores na memória                                            |
| PC       | Faz a contagem de passos e salva a posição atual a ser executdada                          |
| ULA      | Responsável por fazer algumas instruções e armazenar o resultado no AC e repassar as flags |
