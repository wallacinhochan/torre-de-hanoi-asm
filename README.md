# 🏗️ Torre de Hanoi em Assembly x86 e C++

<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/6/60/Tower_of_Hanoi_4.gif" width="300" alt="Animação da Torre de Hanoi">
</p>

Projeto desenvolvido para a disciplina de **Arquitetura de Sistemas Operacionais** ministrada pelo professor **Sérgio Cavalcante** no [Centro de Informática da UFPE](https://www.cin.ufpe.br/).

## 📜 Sobre o Problema
A Torre de Hanoi é um quebra-cabeça matemático criado por Édouard Lucas em 1883 com três regras fundamentais:
1. Apenas um disco pode ser movido por vez
2. Nunca colocar um disco maior sobre um menor
3. Usar uma torre auxiliar quando necessário

## 🛠️ Implementações
### 1. Versão Assembly x86
- Desenvolvida para Linux x86
- Chamadas de sistema com `int 0x80`
- Lógica recursiva com manipulação direta da pilha
- **Features**:
  - Input do número de discos
  - Impressão passo a passo dos movimentos

### 2. Versão C++
- Implementação didática paralela
- Mesma lógica recursiva em alto nível
- Usada como referência para debug

## 🖥️ Como Executar

### 🔵 **Assembly (Online)**
![(https://img.shields.io/badge/Run%20Online-TutorialsPoint-blue)](http://www.tutorialspoint.com/compile_assembly_online.php)

1. Acesse o [compilador online](http://www.tutorialspoint.com/compile_assembly_online.php)
2. Copie todo o código de `hanoi.asm`
3. Cole na aba esquerda do compilador
4. Clique em **Execute**
5. Digite o número de discos (ex: `3`)

![Screenshot 2025-06-27 150114](https://github.com/user-attachments/assets/6cab1feb-3620-46fa-a40d-731d00e9991a)


## 🖥️ Como Executei o C++

Desenvolvi e testei a versão C++ no **CLion**. Para reproduzir:

Compile e execute com o botão ▶️ (ou `Shift+F10`)

![Screenshot 2025-06-27 151839](https://github.com/user-attachments/assets/3aee04a7-6aa7-4544-ab50-36900f74b6ca)

## 👥 Autores
  
- [Gustavo Ferreira Leite de Barros](https://github.com/Gustavolbarros-jpg)
- [Wallace Gabriel da Silva Leão](https://github.com/wallacinhochan)
