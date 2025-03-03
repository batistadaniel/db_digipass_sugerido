-- Criar o banco de dados
CREATE DATABASE digipass_db;
USE digipass_db;

-- Tabela de usuários
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Identificador unico do usuario
    nome VARCHAR(100) NOT NULL,  -- Nome do usuario
    data_nascimento DATE NOT NULL,  -- Data de nascimento do usuario
    telefone VARCHAR(13),  -- Telefone no formato 55XXXXXXXXXXX
    email VARCHAR(100) UNIQUE NOT NULL,  -- E-mail unico para login
    senha_hash TEXT NOT NULL,  -- Senha armazenada de forma segura
    cep VARCHAR(9),  -- Codigo postal do endereco
    logradouro VARCHAR(255),  -- Nome da rua/avenida
    numero VARCHAR(10),  -- Numero da residencia
    complemento VARCHAR(50),  -- Complemento do endereco (ex: Apto 101)
    bairro VARCHAR(100),  -- Bairro
    cidade VARCHAR(100),  -- Cidade
    estado VARCHAR(2),  -- Estado (UF)
    status ENUM('ativo', 'inativo') DEFAULT 'ativo',  -- Status do usuario
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Data de criacao do registro
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP  -- Ultima modificacao
);

-- Tabela de transacoes
CREATE TABLE transacoes (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Identificador unico da transacao
    usuario_id INT NOT NULL,  -- Chave estrangeira referenciando o usuario
    tipo ENUM('pagamento', 'recarga', 'estorno') NOT NULL,  -- Tipo da transacao
    valor DECIMAL(10,2) NOT NULL,  -- Valor da transacao
    status ENUM('pendente', 'concluida', 'cancelada') NOT NULL DEFAULT 'pendente',  -- Status da transacao
    data_transacao DATE NOT NULL,  -- Data da transacao
    hora_transacao TIME NOT NULL,  -- Hora exata da transacao
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Data de criacao do registro
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- Ultima modificacao
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE  -- Relacionamento com usuarios
);

-- Tabela de pagamentos
CREATE TABLE pagamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Identificador unico do pagamento
    transacao_id INT NOT NULL,  -- Chave estrangeira referenciando a transacao
    valor DECIMAL(10,2) NOT NULL,  -- Valor do pagamento
    metodo ENUM('pix') NOT NULL,  -- Metodo de pagamento (apenas pix)
    status ENUM('pendente', 'concluido', 'falhou') NOT NULL DEFAULT 'pendente',  -- Status do pagamento
    horario TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Data e hora do pagamento
    FOREIGN KEY (transacao_id) REFERENCES transacoes(id) ON DELETE CASCADE  -- Relacionamento com transacoes
);
