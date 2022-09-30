-- criação da DB
create database if not exists loja;

-- selecionando a DB
use loja;

-- Tabela de regiões
create table if not exists regiao(
codRegiao bigint,
nomeRegiao varchar(100),
descRegiao text,
primary key (codRegiao)
)default charset utf8mb4;

-- Criação da tabela Vinicola
create table if not exists vinicola(
codVinicola bigint,
nomeVinicola varchar(100),
descVinicola text,
foneVinicola varchar(15),
emailVinicola varchar(15),
codRegiao bigint,
primary key (codVinicola),
foreign key (codRegiao) references regiao(codRegiao)
)default charset utf8mb4;

-- Criação da tabela Vinhos

create table if not exists Vinho(
codVinho bigint,
nomeVinho varchar(50),
tipoVinho varchar(30),
anoVinho int,
descVinho text,
codVinicola bigint,
primary key (codVinho),
foreign key (codVinicola) references vinicola(codVinicola)
)default charset utf8mb4;

-- inserindo 5 registros na tabela regiao
insert into regiao values
('1234567', 'Boa Vista', 'Região muito conhecida pela grande variedade de vinhos'),
('78910110','Altos do Ipanema', 'Conhecida pelos vinhos secos de diversos lugares do mundo'),
('12131415', 'São bento', 'Região com mais de 458 tipos diferentes de vinhos'),
('16171819', 'São Guilherme', 'Região muito frequentada por conta dos vinhos e aperitivos'),
('20212223', 'Terras de Arieta' , 'Região com vinhos importados');


-- inserido 5 registros na tabela Vinicola
insert into vinicola values
('123', 'Margaux', 'Vinicola franqueada Francêsa, com vinhos excelentes e pacotes para degustação', '41998775544', 'mgx@hotmail.com','20212223'),
('456', 'Garzón', 'Vinicola Alemã com os melhores vinhos secos (pacotes para degustação com valor promocional)', '41 33445274', 'gza@outlook.com', '78910110'),
('789', 'Atenuê', 'Vinicola e pizzaria, com especialidade em vinhos perfeitos para acompanhamento de massas (opções de rodizio)', '41 998766652', 'atpiz@gmail.com', '16171819'),
('101', 'Duboê', 'Vinicola com centenas de vinhos diferentes e com excelentes opções','41 3233 7789', 'dsb@hotmail.com', '12131415'),
('112', 'Gorn', 'Vinicola com vinhos e espumantes para os amantes de gaseificados', '41 22335478', 'GoBV@gmail.com', '1234567');

-- inserindo 5 registros na tabela vinho
insert into vinho values
('012', 'Pérgola', 'Seco', '1982', 'Vinho produzido na Alemanha com uvas da serra MBAPE','456'),
('034', 'Chalise', 'Suave', '2000', 'Vinho indicado para consumo com massas (pizza, esfiha etc)','789'),
('056', 'Dom Bosco', 'Branco suave', '1999',  'Vinho produzido com uvas verdes diretamente da Guatemala','123'),
('078', 'Château', 'Rose seco','1873', 'Vinho Francês armazenado em barris de madeira', '101'),
('910', 'La Grupa', 'Frisante','1988', 'Vinho gaseificado para amantes de espumante','112');


-- Faça uma consulta que liste o nome e ano dos  vinhos, incluindo o nome da vinícula e o nome da região que ela pertence.
select v.nomeVinho, v.anoVinho, vi.nomeVinicola, r.nomeRegiao  
from vinho v, vinicola vi inner join  regiao r 
where vi.codVinicola = v.codVinicola and vi.codRegiao = r.codRegiao
order by v.anoVinho;

-- Crie um usuário Somellier, que deve ter acesso pelo localhost ao Select da tabela Vinho
-- E ao Select do campo codVinicula e nomeVinicula da tabela Vinicula. Além disto, ele somente pode realizar 40 consultas por hora

create user somellier@"localhost" with max_queries_per_hour 40;
grant select on vinho to somellier@localhost;
grant select  (codVinicola, nomeVinicola) on vinicola to somellier@localhost;


