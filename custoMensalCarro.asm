segment .data
    ; --- Strings de Formatação para printf e scanf ---
    fmt_in_num  dq "%lld", 0         ; Para ler inteiros 64-bits
    fmt_in_str  dq "%s", 0           ; Para ler strings (nomes sem espaço)
    fmt_out_msg dq "%s", 10, 0       ; Para imprimir mensagens com quebra de linha
    fmt_out_res dq "%s %s: R$ %lld", 10, 0 ; Para imprimir os resultados finais

    ; --- Textos dos Prompts ---
    p_km        db "Km mensal media: ", 0
    p_gas       db "Preco da gasolina (R$): ", 0
    
    msg_c1      db "--- DADOS DO CARRO 1 ---", 0
    msg_c2      db "--- DADOS DO CARRO 2 ---", 0
    
    p_nome      db "Nome (sem espaco): ", 0
    p_ipva      db "IPVA (R$): ", 0
    p_seguro    db "Seguro (R$): ", 0
    p_auto      db "Autonomia (km/l): ", 0
    p_fipe      db "Valor FIPE (R$): ", 0

    ; --- Textos de Conclusão ---
    res_str     db "Custo total do", 0
    win1        db "=> O CARRO 1 eh mais barato!", 10, 0
    win2        db "=> O CARRO 2 eh mais barato!", 10, 0
    empate      db "=> Ambos tem o mesmo custo!", 10, 0

segment .bss
    ; --- Variáveis Globais (Memória não inicializada) ---
    km          resq 1
    gas         resq 1

    ; Variáveis do Carro 1 (resq = reserve quadword / 64-bits)
    nome1       resb 50     ; 50 bytes para a string do nome
    ipva1       resq 1
    seguro1     resq 1
    auto1       resq 1
    fipe1       resq 1
    total1      resq 1

    ; Variáveis do Carro 2
    nome2       resb 50
    ipva2       resq 1
    seguro2     resq 1
    auto2       resq 1
    fipe2       resq 1
    total2      resq 1

segment .text
    global main
    extern printf
    extern scanf

main:
    push RBP                ; Alinha a pilha (convenção C)

    ; ==========================================
    ; LEITURA DOS DADOS GERAIS
    ; ==========================================
    mov RDI, p_km
    mov RAX, 0
    call printf
    mov RDI, fmt_in_num
    mov RSI, km
    mov RAX, 0
    call scanf

    mov RDI, p_gas
    mov RAX, 0
    call printf
    mov RDI, fmt_in_num
    mov RSI, gas
    mov RAX, 0
    call scanf

    ; ==========================================
    ; LEITURA CARRO 1
    ; ==========================================
    mov RDI, fmt_out_msg
    mov RSI, msg_c1
    mov RAX, 0
    call printf

    ; Nome 1
    mov RDI, p_nome
    mov RAX, 0
    call printf
    mov RDI, fmt_in_str
    mov RSI, nome1
    mov RAX, 0
    call scanf

    ; IPVA 1
    mov RDI, p_ipva
    mov RAX, 0
    call printf
    mov RDI, fmt_in_num
    mov RSI, ipva1
    mov RAX, 0
    call scanf

    ; Seguro 1
    mov RDI, p_seguro
    mov RAX, 0
    call printf
    mov RDI, fmt_in_num
    mov RSI, seguro1
    mov RAX, 0
    call scanf

    ; Autonomia 1
    mov RDI, p_auto
    mov RAX, 0
    call printf
    mov RDI, fmt_in_num
    mov RSI, auto1
    mov RAX, 0
    call scanf

    ; FIPE 1
    mov RDI, p_fipe
    mov RAX, 0
    call printf
    mov RDI, fmt_in_num
    mov RSI, fipe1
    mov RAX, 0
    call scanf

    ; ==========================================
    ; LEITURA CARRO 2 (Simplificada para brevidade)
    ; ==========================================
    mov RDI, fmt_out_msg
    mov RSI, msg_c2
    mov RAX, 0
    call printf

    mov RDI, p_nome
    mov RAX, 0
    call printf
    mov RDI, fmt_in_str
    mov RSI, nome2
    mov RAX, 0
    call scanf

    mov RDI, p_ipva
    mov RAX, 0
    call printf
    mov RDI, fmt_in_num
    mov RSI, ipva2
    mov RAX, 0
    call scanf

    mov RDI, p_seguro
    mov RAX, 0
    call printf
    mov RDI, fmt_in_num
    mov RSI, seguro2
    mov RAX, 0
    call scanf

    mov RDI, p_auto
    mov RAX, 0
    call printf
    mov RDI, fmt_in_num
    mov RSI, auto2
    mov RAX, 0
    call scanf

    mov RDI, p_fipe
    mov RAX, 0
    call printf
    mov RDI, fmt_in_num
    mov RSI, fipe2
    mov RAX, 0
    call scanf

    ; ==========================================
    ; MATEMÁTICA: CARRO 1
    ; ==========================================
    mov RCX, 0              ; RCX será o nosso acumulador do Total 1

    ; Gasolina = (km / auto1) * gas
    mov RAX, [km]
    mov RDX, 0              ; Zera RDX antes da divisão
    mov RBX, [auto1]
    div RBX                 ; RAX = km / auto1
    mov RBX, [gas]
    mul RBX                 ; RAX = RAX * gas
    add RCX, RAX            ; Adiciona ao total

    ; IPVA = ipva1 / 12
    mov RAX, [ipva1]
    mov RDX, 0
    mov RBX, 12
    div RBX
    add RCX, RAX

    ; Seguro = seguro1 / 12
    mov RAX, [seguro1]
    mov RDX, 0
    mov RBX, 12
    div RBX
    add RCX, RAX

    ; FIPE = fipe1 / 60 (5 anos * 12 meses)
    mov RAX, [fipe1]
    mov RDX, 0
    mov RBX, 60
    div RBX
    add RCX, RAX

    mov [total1], RCX       ; Salva o custo total do Carro 1

    ; ==========================================
    ; MATEMÁTICA: CARRO 2
    ; ==========================================
    mov RCX, 0              ; RCX será o acumulador do Total 2

    ; Gasolina = (km / auto2) * gas
    mov RAX, [km]
    mov RDX, 0
    mov RBX, [auto2]
    div RBX
    mov RBX, [gas]
    mul RBX
    add RCX, RAX

    ; IPVA = ipva2 / 12
    mov RAX, [ipva2]
    mov RDX, 0
    mov RBX, 12
    div RBX
    add RCX, RAX

    ; Seguro = seguro2 / 12
    mov RAX, [seguro2]
    mov RDX, 0
    mov RBX, 12
    div RBX
    add RCX, RAX

    ; FIPE = fipe2 / 60
    mov RAX, [fipe2]
    mov RDX, 0
    mov RBX, 60
    div RBX
    add RCX, RAX

    mov [total2], RCX       ; Salva o custo total do Carro 2

    ; ==========================================
    ; IMPRIMINDO RESULTADOS E COMPARANDO
    ; ==========================================
    ; Print Total Carro 1
    mov RDI, fmt_out_res
    mov RSI, res_str
    mov RDX, nome1
    mov RCX, [total1]
    mov RAX, 0
    call printf

    ; Print Total Carro 2
    mov RDI, fmt_out_res
    mov RSI, res_str
    mov RDX, nome2
    mov RCX, [total2]
    mov RAX, 0
    call printf

    ; Comparação
    mov RAX, [total1]
    mov RBX, [total2]
    cmp RAX, RBX
    jl carro1_vence         ; Se total1 < total2, pula para carro1_vence
    jg carro2_vence         ; Se total1 > total2, pula para carro2_vence

    ; Se chegar aqui, é empate
    mov RDI, empate
    mov RAX, 0
    call printf
    jmp fim

carro1_vence:
    mov RDI, win1
    mov RAX, 0
    call printf
    jmp fim

carro2_vence:
    mov RDI, win2
    mov RAX, 0
    call printf

fim:
    mov RAX, 0              ; Return 0
    pop RBP                 ; Restaura a pilha
    ret