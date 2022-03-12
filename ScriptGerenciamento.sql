show databases;
use LivrariaABC;
show tables;

-- Sexo
delimiter $$
	create procedure CriarSexo(in descSexo varchar(45))
		begin
			insert into Sexo(DescSexo) values (descSexo);
        end $$
delimiter ;

delimiter $$
	create procedure ObterSexo()
		begin
			select * from Sexo;
        end $$
delimiter ;

call CriarSexo('Masculino');
call CriarSexo('Feminino');
-- call ObterSexo();

-- Naturalidade
delimiter $$
	create procedure CriarNaturalidade(in naturalidade varchar(45))
		begin
			insert into Naturalidade(DescNaturalidade) values(naturalidade);
        end $$
delimiter ;

delimiter $$
	create procedure ObterNaturalidade()
		begin
			select * from Naturalidade;
        end $$
delimiter ;

call CriarNaturalidade('brasileiro');
call CriarNaturalidade('portugues');
call CriarNaturalidade('colombiano');
call CriarNaturalidade('argentino');
call CriarNaturalidade('russo');
-- call ObterNaturalidade();

-- EstadoCivil
delimiter $$
	create procedure CriarEstadoCivil(in estadoCivil varchar(45))
		begin
			insert into EstadoCivil(DescEstadoCivil) values(estadoCivil);
        end $$
delimiter ;

delimiter $$
	create procedure ObterEstadoCivil()
		begin
			select * from EstadoCivil;
        end $$
delimiter ;

call CriarEstadoCivil('solteiro');
call CriarEstadoCivil('casado');
-- call ObterEstadoCivil();

-- Escolaridade
delimiter $$
	create procedure CriarEscolaridade(in escolaridade varchar(45))
		begin
			insert into Escolaridade(DescEscolaridade) values(escolaridade);
        end $$
delimiter ;

delimiter $$
	create procedure ObterEscolaridade()
		begin
			select * from Escolaridade;
        end $$
delimiter ;

call CriarEscolaridade('ensino fundamental');
call CriarEscolaridade('ensino medio');
call CriarEscolaridade('ensino superior');
-- call ObterEscolaridade();

-- Tipo Telefone
delimiter $$
	create procedure CriarTipoTelefone(in tipoTelefone varchar(45))
		begin
			insert into TipoTelefone(DescTipoTelefone) values(tipoTelefone);
        end $$
delimiter ;

delimiter $$
	create procedure ObterTipoTelefone()
		begin
			select * from TipoTelefone;
        end $$
delimiter ;

call CriarTipoTelefone('Telefone Fixo');
call CriarTipoTelefone('Telefone Movel');

-- call ObterTipoTelefone();

-- UF
delimiter $$
	create procedure CriarUF(in nomeUF varchar(200), in siglaUF varchar(45))
		begin
			insert into UF(NomeUF, SiglaUF) values(nomeUF, siglaUF);
        end $$
delimiter ;

delimiter $$
	create procedure ObterUF()
		begin
			select * from UF;
        end $$
delimiter ;

call CriarUF('Acre', 'AC');
call CriarUF('Distrito Federal', 'DF');
call CriarUF('Mato Grosso', 'MT');
call CriarUF('Sao Paulo', 'SP');
call CriarUF('Rio de Janerio', 'RJ');
-- call ObterUF();

-- Cidade
delimiter $$
	create procedure CriarCidade(in nomeCidade varchar(45), in uf int)
		begin
			insert into Cidade(NomeCidade, UF_idUF) values(nomeCidade, uf);
        end $$
delimiter ;

delimiter $$
	create procedure ObterCidade()
		begin
			select * from Cidade;
        end $$
delimiter ;

call CriarCidade('Rio Branco', 1);
call CriarCidade('Brasilia', 2);
call CriarCidade('Cuiaba', 3);
call CriarCidade('Sao Paulo', 4);
call CriarCidade('Rio de Janeiro', 5);
-- call ObterCidade();

-- select Cidade.NomeCidade, UF.SiglaUF from Cidade, UF where Cidade.UF_idUF = UF.idUF;
-- select Cidade.NomeCidade, UF.SiglaUF from Cidade inner join UF on Cidade.UF_idUF = UF.idUF;

-- Logradouro 
delimiter $$
	create procedure CriarTipoLogradouro(in tipoLogradouro varchar(200))
		begin
			insert into TipoLogradouro(DescTipoLogradouro) values(tipoLogradouro);
        end $$
delimiter ;

delimiter $$
	create procedure ObterTipoLogradouro()
		begin
			select * from TipoLogradouro;
        end $$
delimiter ;

call CriarTipoLogradouro('avenida');
call CriarTipoLogradouro('condominio');
call CriarTipoLogradouro('quadra');
call CriarTipoLogradouro('rua');
call CriarTipoLogradouro('vale');
-- call ObterTipoLogradouro();

-- Bairros
delimiter $$
	create procedure CriarBairro(in nomeBairro varchar(200), in idCidade int)
		begin
			insert into Bairro(NomeBairro, Cidade_idCidade) values(nomeBairro, idCidade);
        end $$
delimiter ;

delimiter $$
	create procedure ObterBairro()
		begin
			select * from Bairro;
        end $$
delimiter ;

call CriarBairro('São Cristovão', 5);
call CriarBairro('Águas Claras', 2);
call CriarBairro('Cambuci', 4);
call CriarBairro('Liberdade', 4);
call CriarBairro('Botafogo', 5);
-- call ObterBairro();

-- select Bairro.NomeBairro, UF.SiglaUF from Bairro inner join Cidade 
-- on Bairro.Cidade_idCidade = Cidade.idCidade inner join UF on Cidade.UF_idUF = UF.idUF;

-- CEP
delimiter $$
	create procedure CriarCEP(in numero varchar(200), in idBairro int)
		begin
			insert into CEP(numeroCEP, Bairro_idBairro) values(numero, idBairro);
        end $$
delimiter ;

delimiter $$
	create procedure ObterCEP()
		begin
			select * from CEP;
        end $$
delimiter ;

call CriarCEP('20941-180', 1);
call CriarCEP('71900-100', 2);
call CriarCEP('01515-000', 3);
call CriarCEP('01503-010', 4);
call CriarCEP('22250-140', 5);
-- call ObterCEP();

select CEP.numeroCEP, Cidade.NomeCidade, UF.SiglaUF from CEP inner join Bairro 
on CEP.Bairro_idBairro = Bairro.idBairro 
inner join Cidade on Cidade.idCidade = Bairro_idBairro inner join UF on Cidade.UF_idUF = UF.idUF;

-- StatusCesta
delimiter $$
	create procedure CriarStatusCesta(in statusCesta varchar(100))
		begin
			insert into StatusCesta(DescStatusCesta) values(statusCesta);
        end $$
delimiter ;

delimiter $$
	create procedure ObterStatusCesta()
		begin
			select * from StatusCesta;
        end $$
delimiter ;

call CriarStatusCesta('Em Andamento');
call CriarStatusCesta('Finalizada');
-- call ObterStatusCesta();

-- StatusCompra
delimiter $$
	create procedure CriarStatusCompra(in statusCompra varchar(100))
		begin
			insert into StatusCompra(DescStatusCompra) values(statusCompra);
        end $$
delimiter ;

delimiter $$
	create procedure ObterStatusCompra()
		begin
			select * from StatusCompra;
        end $$
delimiter ;

call CriarStatusCompra('Em Andamento');
call CriarStatusCompra('Finalizada');
call CriarStatusCompra('Devolvida');
call CriarStatusCompra('Negada');
-- call ObterStatusCompra();

-- StatusLivroAcervo
delimiter $$
	create procedure CriarStatusLivroAcervo(in statusLivroAcervo varchar(45))
		begin
			insert into StatusLivroAcervo(DescStatusLivroAcervo) values(statusLivroAcervo);
        end $$
delimiter ;

delimiter $$
	create procedure ObterStatusLivroAcervo()
		begin
			select * from StatusLivroAcervo;
        end $$
delimiter ;

call CriarStatusLivroAcervo('Livre');
call CriarStatusLivroAcervo('Em Cesta');
call CriarStatusLivroAcervo('Comprado');
-- call ObterStatusLivroAcervo();

-- Categorias
delimiter $$
	create procedure CriarCategoria(in nomeCategoria varchar(200))
		begin
			insert into Categoria(NomeCategoria) values(nomeCategoria);
        end $$
delimiter ;

delimiter $$
	create procedure ObterCategoria()
		begin
			select * from Categoria;
        end $$
delimiter ;

call CriarCategoria('Infantil');
call CriarCategoria('Técnico');
call CriarCategoria('Ficção');
call CriarCategoria('Não Ficção');
-- call ObterCategoria();

-- Editora
delimiter $$
	create procedure CriarEditora(in nomeEditora varchar(200))
		begin
			insert into Editora(NomeEditora) values(nomeEditora);
        end $$
delimiter ;

delimiter $$
	create procedure ObterEditora()
		begin
			select * from Editora;
        end $$
delimiter ;

call CriarEditora('Intrinseca');
call CriarEditora('Pearson');
call CriarEditora('Panini');
call CriarEditora('Companhia das Letras');
call CriarEditora('Darkside Books');
call CriarEditora('Rocco');
-- call ObterEditora();

-- Autor
delimiter $$
	create procedure CriarAutor(in nomeAutor varchar(45))
		begin
			insert into Autor(NomeAutor) values(nomeAutor);
        end $$
delimiter ;

delimiter $$
	create procedure ObterAutor()
		begin
			select * from Autor;
        end $$
delimiter ;

call CriarAutor('Neil Gaiman');
call CriarAutor('Hugh D. Young');
call CriarAutor('Roger A. Freedman');
call CriarAutor('Yuval Noah Harari');
call CriarAutor('J.K. Rowling');
-- call ObterAutor();

-- TipoPagamento
delimiter $$
	create procedure CriarTipoPagamento(in tipoPagamento varchar(45))
		begin
			insert into TipoPagamento(DescTipoPagamento) values(tipoPagamento);
        end $$
delimiter ;

delimiter $$
	create procedure ObterTipoPagamento()
		begin
			select * from TipoPagamento;
        end $$
delimiter ;

call CriarTipoPagamento('cartao de credito');
call CriarTipoPagamento('cartao de debito');
-- call ObterTipoPagamento();

-- Livro
delimiter $$
	create procedure CriarLivro(in isbn varchar(200), in titulo varchar(200), in desconto float, 
    in preco float, in ano int, in paginas int, in idEditora int, in idCategoria int)
		begin
			insert into Livro(ISBN, Titulo, Desconto, Preco, Ano, Paginas, Editora_idEditora, Categoria_idCategoria) 
values(isbn, titulo, desconto, preco, ano, paginas, idEditora, idCategoria);
        end $$
delimiter ;

delimiter $$
	create procedure ObterLivros()
		begin
			select * from Livro;
        end $$
delimiter ;

call CriarLivro('8551006754', 'Coraline', 0, 41.20, 2010, 192, 6, 1);
call CriarLivro('6559213013', 'Sapiens', 0, 52.99, 2018,572, 4, 4);
call CriarLivro('854300568X', 'Física de Sears & Zemansky', 0, 124.83, 2015, 448, 2, 2);
call CriarLivro('8532530796', 'Harry Potter e a câmara secreta', 0, 24.40, 2017, 224, 6, 3);
call CriarLivro('8565484114', 'ABSOLUTE SANDMAN VOL. 3', 0, 164.40, 2018, 612, 3, 3);
-- call ObterLivros();

-- Relação Autor/Livro
delimiter $$
	create procedure CriarRelLivroAutor(in idAutor int, in idLivro int)
		begin
			insert into Livro_has_Autor(Livro_idLivro, Autor_idAutor) values(idLivro, idAutor);
        end $$
delimiter ;

delimiter $$
	create procedure ObterRelLivroAutor()
		begin
			select * from Livro_has_Autor;
        end $$
delimiter ;

call CriarRelLivroAutor(1,1);
call CriarRelLivroAutor(2,4);
call CriarRelLivroAutor(3,2);
call CriarRelLivroAutor(3,3);
call CriarRelLivroAutor(4,5);
-- call ObterRelLivroAutor();

-- Livros Acervo
delimiter $$
	create procedure CriarLivroAcervo(in codigoBarras varchar(200), in idStatusLivroAcervo int, 
    in idLivro int)
		begin
			insert into LivroAcervo(CodigoBarras, StatusLivroAcervo_idStatusLivroAcervo, Livro_idLivro)
values(codigoBarras, idStatusLivroAcervo, idLivro);
        end $$
delimiter ;

delimiter $$
	create procedure ObterLivroAcervo()
		begin
			select * from LivroAcervo;
        end $$
delimiter ;

delimiter $$
	create procedure ObterLivroAcervoDisponiveis()
		begin
			select Livro.Titulo, Livro.Preco from LivroAcervo inner join Livro 
            on LivroAcervo.Livro_idLivro = Livro.idLivro 
            where LivroAcervo.StatusLivroAcervo_idStatusLivroAcervo = 1;
        end $$
delimiter ;

call CriarLivroAcervo('9788579800481', 1, 1);
call CriarLivroAcervo('9788579800482', 1, 1);
call CriarLivroAcervo('9788565484114', 1, 1);
call CriarLivroAcervo('9788543005683', 1, 3);
call CriarLivroAcervo('9788532530790', 1, 4);
-- call ObterLivroAcervo();
-- call ObterLivroAcervoDisponiveis();

-- Endereco
DELIMITER $$
CREATE PROCEDURE  CriarEndereco(in numeroEndereco int , in complemento varchar(200), in idTipoLogradouro int, in idCEP int)
BEGIN
	insert into Endereco(Complemento, NumeroEndereco, TipoLogradouro_idTipoLogradouro, CEP_idCEP)
    values(complemento, numeroEndereco, idTipoLogradouro, idCEP); 
END $$
DELIMITER ;

call CriarEndereco(8,'Casa',3,1);
call CriarEndereco(10,'Apartamento 23',3,2);
call CriarEndereco(24,'Casa',4,1);
call CriarEndereco(32,'Casa',1,1);
call CriarEndereco(94,'Casa',1,2);

-- select * from TipoLogradouro;
-- select CEP.idCEP, Cidade.NomeCidade from CEP inner join Bairro on CEP.Bairro_idBairro = Bairro.idBairro 
-- inner join Cidade on Cidade.idCidade = Bairro.idBairro;
-- select * from Endereco;

-- Cliente
delimiter $$
create procedure  CriarCliente(in nome varchar(200), in cpf varchar(100) , in rg varchar(100), 
in email varchar(200), in nomeMae varchar(200), in nomePai varchar(200),
in sexo int, in naturalidade int, estadoCivil int, in escolaridade int, in numeroEndereco int, cepEndereco int)
begin
	insert into Cliente(Nome, CPF, RG, Email, NomeMae, NomePai, Sexo_idSexo, Naturalidade_idNaturalidade,
    EstadoCivil_idEstadoCivil, Escolaridade_idEscolaridade, Endereco_NumeroEndereco, Endereco_CEP_idCEP) values(nome, cpf,rg,
    email, nomeMae, nomePai, sexo, naturalidade, estadoCivil, escolaridade, numeroEndereco, cepEndereco);
end $$
delimiter ;

delimiter $$
create procedure ObterClientes()
	begin
		select * from Cliente;
	end $$
delimiter ;

call CriarCliente('Pessoa1', '087.405.050-22', '30.417.343-5', 'pessoa1@email.com', '', '', 1, 1,1,1,8,1);
call CriarCliente('Pessoa2', '849.058.110-07', '43.939.130-1', 'pessoa2@email.com', '', '', 2, 2,2,2,10,2);
call CriarCliente('Pessoa3', '078.072.180-29', '30.626.896-6', 'pessoa3@email.com', '', '', 1, 3,2,3,24,1);
call CriarCliente('Pessoa4', '532.223.820-42', '11.588.938-3', 'pessoa4@email.com', '', '', 2, 4,1,3,32,1);
call CriarCliente('Pessoa5', '158.004.670-30', '44.804.407-9', 'pessoa5@email.com', '', '', 1, 5,1,2,94,2);

-- call ObterClientes();

-- Telefone
delimiter $$
create procedure CriarTelefone(in ddd int, in numero varchar(45), in idTipoTelefone int)
	begin
		insert into Telefone(DDD, NumeroTelefone, TipoTelefone_idTipoTelefone) values(ddd, numero, idTipoTelefone);
	end $$
delimiter ;

delimiter $$
create procedure ObterTelefones()
	begin
		select * from Telefone;
	end $$
delimiter ;

call CriarTelefone(65, '39452-5229',1);
call CriarTelefone(85, '26513-7760',1);
call CriarTelefone(39, '82121-4704',1);
call CriarTelefone(15, '67008-6492',1);
call CriarTelefone(69, '33910-1883',1);

call ObterTelefones();

-- Cliente Has Telefone
delimiter $$
create procedure CriarRelClienteTelefone(in idCliente int, in dddTelefone int, in numeroTelefone varchar(45))
	begin
		insert into Cliente_has_Telefone(Cliente_idCliente, Telefone_DDD, Telefone_NumeroTelefone) values(idCliente,
        dddTelefone, numeroTelefone);
	end $$
delimiter ;

delimiter $$
create procedure ObterRelClienteTelefone()
	begin
		select * from Cliente_has_Telefone;
	end $$
delimiter ;

call CriarRelClienteTelefone(1,65, '39452-5229');
call CriarRelClienteTelefone(2,85, '26513-7760');
call CriarRelClienteTelefone(3,39, '82121-4704');
call CriarRelClienteTelefone(4,15, '67008-6492');
call CriarRelClienteTelefone(5,69, '33910-1883');

-- call ObterRelClienteTelefone();

-- Cesta
delimiter $$
create procedure CriarCesta(in idCliente int, in idStatusCesta int)
	begin
		insert into Cesta(Cliente_idCliente, StatusCesta_idStatusCesta) value(idCliente, idStatusCesta);
	end $$
delimiter ;

delimiter $$
create procedure ObterCesta()
	begin
		select Cesta.idCesta, Cliente.Nome from Cesta inner join Cliente on Cesta.Cliente_idCliente = Cliente.idCliente;
	end $$
delimiter ;

delimiter $$
create procedure AdicionarACesta(in idCesta int, in idLivroAdicionado int)
	begin 
		update LivroAcervo set LivroAcervo.StatusLivroAcervo_idStatusLivroAcervo = 2, LivroAcervo.Cesta_idCesta = idCesta
        where LivroAcervo.idLivroAcervo = idLivroAdicionado;
    end $$
delimiter ;

call CriarCesta(1,1);
call CriarCesta(2,1);
call CriarCesta(3,1);
call CriarCesta(4,1);
call CriarCesta(5,1);

-- call ObterCesta();
-- call AdicionarACesta(1,1);
-- call AdicionarACesta(1,3);
-- call ObterLivroAcervo();

-- select LivroAcervo.idLivroAcervo, StatusLivroAcervo.DescStatusLivroAcervo from LivroAcervo inner join StatusLivroAcervo
-- on LivroAcervo.StatusLivroAcervo_idStatusLivroAcervo = StatusLivroAcervo.idStatusLivroAcervo;

-- Funcionario
delimiter $$
	create procedure CriarFuncionario(in cpf varchar(100), in nomeFuncionario varchar(100))
		begin 
			insert into Funcionario(CPF, NomeFuncionario) values(cpf, nomeFuncionario);
        end $$
delimiter ;

delimiter $$
	create procedure ObterFuncionarios()
		begin 
			select * from Funcionario;
		end $$
delimiter ;

call CriarFuncionario('518.468.040-35', 'Funcionario1');
call CriarFuncionario('101.862.290-03', 'Funcionario2');
call CriarFuncionario('860.148.030-68', 'Funcionario3');
call CriarFuncionario('555.519.440-42', 'Funcionario4');

-- call ObterFuncionarios();

-- CPF Cartão
delimiter $$
	create procedure CriarCPFCartao(in numeroCPF varchar(100))
		begin
			insert into CPFCartao(NumeroCPF) values(numeroCPF);
        end $$
delimiter ;

delimiter $$
	create procedure ObterCPFCartao()
		begin
			select * from CPFCartao;
        end $$
delimiter ;

call CriarCPFCartao('502.496.680-50');
call CriarCPFCartao('214.203.010-63');
call CriarCPFCartao('411.664.540-02');
call CriarCPFCartao('131.938.520-66');
call CriarCPFCartao('289.643.210-81');

-- call ObterCPFCartao();

-- Cartão
delimiter $$
	create procedure CriarCartao(in numero varchar(100), in dataVenc date, in nome varchar(200), 
    in codigoSeg varchar(45), in cpf int)
		begin
			insert into Cartao(NumeroCartao, DataVencimento, NomeCartao, CPF_idCPF, CodigoSeguranca) values(numero,
            dataVenc, nome, cpf, codigoSeg);
        end $$
delimiter ;

delimiter $$
	create procedure ObterCartao()
		begin
			select * from Cartao;
        end $$
delimiter ;

call CriarCartao('5159 7633 7176 6206', '2023-02-26', 'PessoaCartao1', '441',1);
call CriarCartao('5449 0118 0146 2149', '2023-09-26', 'PessoaCartao2', '914',2);
call CriarCartao('5140 9192 8580 2931', '2022-08-26', 'PessoaCartao3', '376',3);
call CriarCartao('5334 3527 5194 7327', '2022-12-26', 'PessoaCartao4', '905',4);
call CriarCartao('5378 0279 4428 5937', '2022-12-02', 'PessoaCartao5', '149',5);

-- call ObterCartao();

-- Pagamento
delimiter $$
	create procedure CriarPagamento(in idTipoPagamento int, in idCartao int)
		begin
			insert into Pagamento(TipoPagamento_idTipoPagamento, Cartao_idCartao) values(idTipoPagamento,
            idCartao);
        end $$
delimiter ;

delimiter $$
	create procedure ObterPagamento()
		begin
			select * from Pagamento;
        end $$
delimiter ;

call CriarPagamento(1,1);
call CriarPagamento(1,2);
call CriarPagamento(1,3);
call CriarPagamento(1,4);
call CriarPagamento(1,5);

-- call ObterPagamento();

-- Compra
delimiter $$
create procedure CriarCompra(in dataCompra date, in frete float, in valor float,
in idStatusCompra int, in idCesta int, in idPagamento int,
in idFuncionario int, in idCEPEndereco int, in idNumeroEndereco int)
	begin
		insert into Compra(DataDeCompra, Frete, ValorCompra, StatusCompra_idStatusCompra,
        Cesta_idCesta, Pagamento_idPagamento, Funcionario_idFuncionario, Endereco_CEP_idCEP, Endereco_NumeroEndereco) values (dataCompra, frete, valor,
        idStatusCompra, idCesta, idPagamento, idFuncionario, idCEPEndereco, idNumeroEndereco);
        
        update Cesta set Cesta.StatusCesta_idStatusCesta = 2 where Cesta.idCesta = idCesta;
        update LivroAcervo set LivroAcervo.StatusLivroAcervo_idStatusLivroAcervo = 3 where LivroAcervo.Cesta_idCesta = idCesta;
    end $$
delimiter ;

delimiter $$
	create procedure ObterCompra()
		begin
			select * from Compra;
        end $$
delimiter ;

delimiter $$
	create procedure ObterCompraFinalizada()
		begin
			select * from Compra where Compra.StatusCompra_idStatusCompra=2;
        end $$
delimiter ;

call CriarCompra('2021-11-12', 0, 23, 1, 1, 1, 1, 1, 8);
call CriarCompra('2021-11-12', 0, 23, 1, 2, 2, 2, 2, 10);
call CriarCompra('2021-11-12', 0, 23, 1, 3, 3, 3, 1, 24);
call CriarCompra('2021-11-12', 0, 23, 1, 4, 4, 4, 2, 94);
call CriarCompra('2021-11-12', 0, 23, 1, 5, 5, 4, 1, 32);

call ObterCompra();
-- update Compra set Compra.StatusCompra_idStatusCompra=2 where Compra.idCompra = 1;
-- select * from Compra where Compra.StatusCompra_idStatusCompra=2;
