#include"hanoi.h"  // Inclui o cabeçalho com a definição da classe
#include<iostream>
#include<string>

using namespace std;

// Implementação do método hanoi da classe torreDeHanoi
void torreDeHanoi::hanoi(int n, const std::string& source, 
                        const std::string& auxiliary, const std::string& dest) {
    // Caso base: quando há apenas 1 disco
    if(n == 1) {
        cout << "O disco 1 foi movido da torre " << source 
             << " para torre " << dest << endl;
    }
    else {
        // 1. Move n-1 discos da torre origem para a auxiliar (usando destino como auxiliar)
        hanoi(n-1, source, dest, auxiliary);
        
        // 2. Move o disco maior (n) da origem para o destino
        cout << "O disco " << n << " foi movido da Torre " << source 
             << " para Torre " << dest << endl;
        
        // 3. Move os n-1 discos da auxiliar para o destino (usando origem como auxiliar)
        hanoi(n-1, auxiliary, source, dest);
    }
}

int main() {
    torreDeHanoi torre;  // Cria uma instância da classe torreDeHanoi

    int n;
    cout << "Digite o número de discos[1-9]: ";
    cin >> n;  // Lê o número de discos do usuário

    // Define os nomes das torres como strings
    string source = "A";     // Torre origem
    string auxiliary = "B";  // Torre auxiliar
    string dest = "C";       // Torre destino

    // Chama o método para resolver o problema
    torre.hanoi(n, source, auxiliary, dest);
    cout << "Concluído!\n";

    return 0;
}