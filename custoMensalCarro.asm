segment .data
    ; --- Strings de Formatação Básica ---
    fmt_in_num  dq "%lld", 0
    fmt_in_str  dq "%s", 0
    fmt_out_msg dq "%s", 0          ; Modificado para não pular linha automaticamente
    fmt_out_res dq " -> %s | CUSTO MENSAL TOTAL: R$ %lld", 10, 0

    ; --- Textos de Cabeçalho e Introdução ---
    header      db "========================================================", 10
                db "         COMPARADOR DE CUSTO MENSAL DE VEICULOS         ", 10
                db "========================================================", 10
                db "Bem-vindo! Este programa calcula qual carro e mais barato", 10
                db "de manter por mes, considerando uso, IPVA, seguro e FIPE.", 10, 10
                db "REGRAS DE ENTRADA:", 10
                db "1. Nomes dos carros: Nao use espacos (Ex: 'Palio', 'HB20').", 10
                db "2. Valores: Digite apenas numeros inteiros (sem virgulas).", 10
                db "========================================================", 10, 10, 0

    ; --- Textos de Entrada ---
    h_gerais    db "--- Informacoes Gerais ---", 10, 0
    p_km        db "Distancia percorrida no mes (km): ", 0
    p_gas       db "Preco do litro da gasolina (R$): ", 0
    
    msg_c1      db 10, "--- Dados do 1o Carro ---", 10, 0
    msg_c2      db 10, "--- Dados do 2o Carro ---", 10, 0
    
    p_nome      db "Nome do carro: ", 0
    p_ipva      db "Valor total do IPVA (R$): ", 0
    p_seguro    db "Valor total do seguro (R$): ", 0
    p_auto      db "Autonomia (km/l): ", 0
    p_fipe      db "Valor da tabela FIPE (R$): ", 0

    ; --- Textos de Resultados ---
    h_res       db 10, "========================================================", 10
                db "                  RESUMO DOS CUSTOS                     ", 10
                db "========================================================", 10, 0

    h_conc      db 10, "========================================================", 10
                db "                      CONCLUSAO                         ", 10
                db "========================================================", 10, 0

    win_msg     db "=> O carro %s e mais barato de manter que o %s.", 10, 0
    eco_msg     db "=> Economia mensal de: R$ %lld", 10, 0
    emp_msg     db "=> Os carros %s e %s tem exatamente o mesmo custo mensal (R$ %lld).", 10, 0
    
    sep         db "========================================================", 10, 0

segment .bss
    ; --- Variáveis Globais ---
    km          resq 1
    gas         resq 1

    nome1       resb 50
    ipva1       resq 1
    seguro1     resq 1
    auto1       resq 1
    fipe1       resq 1
    total1      resq 1

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
    push RBP

    ; --- INTRODUÇÃO ---
    mov RDI, header
    mov RAX, 0
    call printf

    ; --- INFORMAÇÕES GERAIS ---
    mov RDI, h_gerais
    mov RAX, 0
    call printf

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

    ; --- DADOS CARRO 1 ---
    mov RDI, msg_c1
    mov RAX, 0
    call printf

    mov RDI, p_nome
    mov RAX, 0
    call printf
    mov RDI, fmt_in_str
    mov RSI, nome1
    mov RAX, 0
    call scanf

    mov RDI, p_ipva
    mov RAX, 0
    call printf
    mov RDI, fmt_in_num
    mov RSI, ipva1
    mov RAX, 0
    call scanf

    mov RDI, p_seguro
    mov RAX, 0
    call printf
    mov RDI, fmt_in_num
    mov RSI, seguro1
    mov RAX, 0
    call scanf

    mov RDI, p_auto
    mov RAX, 0
    call printf
    mov RDI, fmt_in_num
    mov RSI, auto1
    mov RAX, 0
    call scanf

    mov RDI, p_fipe
    mov RAX, 0
    call printf
    mov RDI, fmt_in_num
    mov RSI, fipe1
    mov RAX, 0
    call scanf

    ; --- DADOS CARRO 2 ---
    mov RDI, msg_c2
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

    ; --- MATEMÁTICA: CARRO 1 ---
    mov RCX, 0              
    mov RAX, [km]
    mov RDX, 0
    mov RBX, [auto1]
    div RBX                 
    mov RBX, [gas]
    mul RBX                 
    add RCX, RAX            

    mov RAX, [ipva1]
    mov RDX, 0
    mov RBX, 12
    div RBX
    add RCX, RAX

    mov RAX, [seguro1]
    mov RDX, 0
    mov RBX, 12
    div RBX
    add RCX, RAX

    mov RAX, [fipe1]
    mov RDX, 0
    mov RBX, 60
    div RBX
    add RCX, RAX

    mov [total1], RCX       

    ; --- MATEMÁTICA: CARRO 2 ---
    mov RCX, 0              
    mov RAX, [km]
    mov RDX, 0
    mov RBX, [auto2]
    div RBX
    mov RBX, [gas]
    mul RBX
    add RCX, RAX

    mov RAX, [ipva2]
    mov RDX, 0
    mov RBX, 12
    div RBX
    add RCX, RAX

    mov RAX, [seguro2]
    mov RDX, 0
    mov RBX, 12
    div RBX
    add RCX, RAX

    mov RAX, [fipe2]
    mov RDX, 0
    mov RBX, 60
    div RBX
    add RCX, RAX

    mov [total2], RCX       

    ; --- RESUMO DOS CUSTOS ---
    mov RDI, h_res
    mov RAX, 0
    call printf

    mov RDI, fmt_out_res
    mov RSI, nome1
    mov RDX, [total1]
    mov RAX, 0
    call printf

    mov RDI, fmt_out_res
    mov RSI, nome2
    mov RDX, [total2]
    mov RAX, 0
    call printf

    ; --- CONCLUSÃO E LÓGICA IF/ELSE ---
    mov RDI, h_conc
    mov RAX, 0
    call printf

    mov RAX, [total1]
    mov RBX, [total2]
    cmp RAX, RBX
    jl carro1_vence
    jg carro2_vence

    ; Se chegar aqui (Empate)
    mov RDI, emp_msg
    mov RSI, nome1          ; %s = nome 1
    mov RDX, nome2          ; %s = nome 2
    mov RCX, [total1]       ; %lld = valor total
    mov RAX, 0
    call printf
    jmp fim

carro1_vence:
    ; Print: O carro 1 é mais barato que o carro 2
    mov RDI, win_msg
    mov RSI, nome1          ; Vencedor
    mov RDX, nome2          ; Perdedor
    mov RAX, 0
    call printf

    ; Print: Economia mensal
    mov RDI, eco_msg
    mov RSI, [total2]
    sub RSI, [total1]       ; RSI = total2 - total1
    mov RAX, 0
    call printf
    jmp fim

carro2_vence:
    ; Print: O carro 2 é mais barato que o carro 1
    mov RDI, win_msg
    mov RSI, nome2          ; Vencedor
    mov RDX, nome1          ; Perdedor
    mov RAX, 0
    call printf

    ; Print: Economia mensal
    mov RDI, eco_msg
    mov RSI, [total1]
    sub RSI, [total2]       ; RSI = total1 - total2
    mov RAX, 0
    call printf

fim:
    ; Fechar com o separador final
    mov RDI, sep
    mov RAX, 0
    call printf

    mov RAX, 0
    pop RBP
    ret