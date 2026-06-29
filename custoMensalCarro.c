#include <stdio.h>
#include <stdlib.h>
    
#define ANOS 5

int custoMensalCarro(char nomeCarro[], int ipva, int seguro, int autonomia, int valorFIPE, int kilometragem_mensal, int gasolina) {
    int custoGasolina = (kilometragem_mensal / autonomia) * gasolina;
    printf(" -> %s | Gasolina: R$ %d\n", nomeCarro, custoGasolina);

    int custoIPVA = ipva / 12;
    printf(" -> %s | IPVA: R$ %d\n", nomeCarro, custoIPVA);

    int custoSeguro = seguro / 12;
    printf(" -> %s | Seguro: R$ %d\n", nomeCarro, custoSeguro);

    int parcelaFIPE = valorFIPE / (ANOS * 12);
    printf(" -> %s | Parcela FIPE (%d anos): R$ %d\n", nomeCarro, ANOS, parcelaFIPE);

    int custoTotal = custoGasolina + custoIPVA + custoSeguro + parcelaFIPE;
    printf(" -> %s | CUSTO MENSAL TOTAL: R$ %d\n\n", nomeCarro, custoTotal);
    
    return custoTotal;
}

void lerCarro(int numeroCarro, char nomeCarro[], int *ipva, int *seguro, int *autonomia, int *valorFIPE) {
    printf("--- Dados do %dº Carro ---\n", numeroCarro);
    
    printf("Nome do carro: ");
    scanf("%s", nomeCarro);

    printf("Valor anual do IPVA (R$): ");
    scanf("%d", ipva);

    printf("Valor anual do seguro (R$): ");
    scanf("%d", seguro);

    printf("Autonomia (km/l): ");
    scanf("%d", autonomia);

    printf("Valor da tabela FIPE (R$): ");
    scanf("%d", valorFIPE);
    
    printf("\n");
}

int main() {
    // 1. Introdução e Regras para o Usuário
    printf("========================================================\n");
    printf("         COMPARADOR DE CUSTO MENSAL DE VEICULOS         \n");
    printf("========================================================\n");
    printf("Bem-vindo! Este programa calcula qual carro e mais barato\n");
    printf("de manter por mes, considerando uso, IPVA, seguro e FIPE.\n\n");
    printf("REGRAS DE ENTRADA:\n");
    printf("1. Nomes dos carros: Nao use espacos (Ex: 'Palio', 'HB20').\n");
    printf("2. Valores: Digite apenas numeros inteiros (sem virgulas).\n");
    printf("========================================================\n\n");

    int kilometragem_mensal;
    int gasolina;

    char nomeCarro1[100];
    int ipva1, seguro1, autonomia1, valorFIPE1;

    char nomeCarro2[100];
    int ipva2, seguro2, autonomia2, valorFIPE2;

    // 2. Leitura de Dados Gerais
    printf("--- Informacoes Gerais ---\n");
    printf("Distancia percorrida no mes (km): ");
    scanf("%d", &kilometragem_mensal);
    
    printf("Preco do litro da gasolina (R$): ");
    scanf("%d", &gasolina);
    printf("\n");
    
    // 3. Leitura dos Carros
    lerCarro(1, nomeCarro1, &ipva1, &seguro1, &autonomia1, &valorFIPE1);
    lerCarro(2, nomeCarro2, &ipva2, &seguro2, &autonomia2, &valorFIPE2);
    
    // 4. Resultados
    printf("========================================================\n");
    printf("                  RESUMO DOS CUSTOS                     \n");
    printf("========================================================\n");
    
    int custoCarro1 = custoMensalCarro(nomeCarro1, ipva1, seguro1, autonomia1, valorFIPE1, kilometragem_mensal, gasolina);
    int custoCarro2 = custoMensalCarro(nomeCarro2, ipva2, seguro2, autonomia2, valorFIPE2, kilometragem_mensal, gasolina);

    // 5. Conclusão Final
    printf("========================================================\n");
    printf("                      CONCLUSAO                         \n");
    printf("========================================================\n");
    
    if (custoCarro1 < custoCarro2) {
        printf("=> O carro %s e mais barato de manter que o %s.\n", nomeCarro1, nomeCarro2);
        printf("=> Economia mensal de: R$ %d\n", custoCarro2 - custoCarro1);
    } else if (custoCarro1 > custoCarro2) {
        printf("=> O carro %s e mais barato de manter que o %s.\n", nomeCarro2, nomeCarro1);
        printf("=> Economia mensal de: R$ %d\n", custoCarro1 - custoCarro2);
    } else {
        printf("=> Os carros %s e %s tem exatamente o mesmo custo mensal (R$ %d).\n", nomeCarro1, nomeCarro2, custoCarro1);
    }
    printf("========================================================\n");

    return 0;
}