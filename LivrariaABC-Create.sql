-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LivrariaABC
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LivrariaABC
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LivrariaABC` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema new_schema1
-- -----------------------------------------------------
USE `LivrariaABC` ;

-- -----------------------------------------------------
-- Table `LivrariaABC`.`Sexo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`Sexo` (
  `idSexo` INT NOT NULL AUTO_INCREMENT,
  `DescSexo` VARCHAR(45) NULL,
  PRIMARY KEY (`idSexo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`Naturalidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`Naturalidade` (
  `idNaturalidade` INT NOT NULL AUTO_INCREMENT,
  `DescNaturalidade` VARCHAR(45) NULL,
  PRIMARY KEY (`idNaturalidade`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`EstadoCivil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`EstadoCivil` (
  `idEstadoCivil` INT NOT NULL AUTO_INCREMENT,
  `DescEstadoCivil` VARCHAR(45) NULL,
  PRIMARY KEY (`idEstadoCivil`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`Escolaridade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`Escolaridade` (
  `idEscolaridade` INT NOT NULL AUTO_INCREMENT,
  `DescEscolaridade` VARCHAR(45) NULL,
  PRIMARY KEY (`idEscolaridade`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`TipoLogradouro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`TipoLogradouro` (
  `idTipoLogradouro` INT NOT NULL AUTO_INCREMENT,
  `DescTipoLogradouro` VARCHAR(200) NULL,
  PRIMARY KEY (`idTipoLogradouro`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`UF`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`UF` (
  `idUF` INT NOT NULL AUTO_INCREMENT,
  `NomeUF` VARCHAR(200) NULL,
  `SiglaUF` VARCHAR(45) NULL,
  PRIMARY KEY (`idUF`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`Cidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`Cidade` (
  `idCidade` INT NOT NULL AUTO_INCREMENT,
  `NomeCidade` VARCHAR(45) NULL,
  `UF_idUF` INT NOT NULL,
  PRIMARY KEY (`idCidade`),
  INDEX `fk_Cidade_UF1_idx` (`UF_idUF` ASC) VISIBLE,
  CONSTRAINT `fk_Cidade_UF1`
    FOREIGN KEY (`UF_idUF`)
    REFERENCES `LivrariaABC`.`UF` (`idUF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`Bairro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`Bairro` (
  `idBairro` INT NOT NULL AUTO_INCREMENT,
  `NomeBairro` VARCHAR(200) NULL,
  `Cidade_idCidade` INT NOT NULL,
  PRIMARY KEY (`idBairro`),
  INDEX `fk_Bairro_Cidade1_idx` (`Cidade_idCidade` ASC) VISIBLE,
  CONSTRAINT `fk_Bairro_Cidade1`
    FOREIGN KEY (`Cidade_idCidade`)
    REFERENCES `LivrariaABC`.`Cidade` (`idCidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`CEP`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`CEP` (
  `idCEP` INT NOT NULL AUTO_INCREMENT,
  `numeroCEP` VARCHAR(200) NULL,
  `Bairro_idBairro` INT NOT NULL,
  PRIMARY KEY (`idCEP`),
  UNIQUE INDEX `numeroCEP_UNIQUE` (`numeroCEP` ASC) VISIBLE,
  INDEX `fk_CEP_Bairro1_idx` (`Bairro_idBairro` ASC) VISIBLE,
  CONSTRAINT `fk_CEP_Bairro1`
    FOREIGN KEY (`Bairro_idBairro`)
    REFERENCES `LivrariaABC`.`Bairro` (`idBairro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`Endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`Endereco` (
  `NumeroEndereco` INT NOT NULL,
  `CEP_idCEP` INT NOT NULL,
  `Complemento` VARCHAR(200) NULL,
  `TipoLogradouro_idTipoLogradouro` INT NOT NULL,
  PRIMARY KEY (`NumeroEndereco`, `CEP_idCEP`),
  INDEX `fk_Endereco_TipoLogradouro1_idx` (`TipoLogradouro_idTipoLogradouro` ASC) VISIBLE,
  INDEX `fk_Endereco_CEP1_idx` (`CEP_idCEP` ASC) VISIBLE,
  CONSTRAINT `fk_Endereco_TipoLogradouro1`
    FOREIGN KEY (`TipoLogradouro_idTipoLogradouro`)
    REFERENCES `LivrariaABC`.`TipoLogradouro` (`idTipoLogradouro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Endereco_CEP1`
    FOREIGN KEY (`CEP_idCEP`)
    REFERENCES `LivrariaABC`.`CEP` (`idCEP`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `CPF` VARCHAR(100) NOT NULL,
  `Nome` VARCHAR(200) NOT NULL,
  `RG` VARCHAR(100) NOT NULL,
  `Email` VARCHAR(200) NOT NULL,
  `NomeMae` VARCHAR(200) NULL,
  `NomePai` VARCHAR(200) NULL,
  `Sexo_idSexo` INT NOT NULL,
  `Naturalidade_idNaturalidade` INT NOT NULL,
  `EstadoCivil_idEstadoCivil` INT NOT NULL,
  `Escolaridade_idEscolaridade` INT NOT NULL,
  `Endereco_NumeroEndereco` INT NOT NULL,
  `Endereco_CEP_idCEP` INT NOT NULL,
  PRIMARY KEY (`idCliente`),
  INDEX `fk_Cliente_EstadoCivil1_idx` (`EstadoCivil_idEstadoCivil` ASC) VISIBLE,
  INDEX `fk_Cliente_Escolaridade1_idx` (`Escolaridade_idEscolaridade` ASC) VISIBLE,
  INDEX `fk_Cliente_Sexo_idx` (`Sexo_idSexo` ASC) VISIBLE,
  INDEX `fk_Cliente_Naturalidade1_idx` (`Naturalidade_idNaturalidade` ASC) VISIBLE,
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE,
  UNIQUE INDEX `RG_UNIQUE` (`RG` ASC) VISIBLE,
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE,
  INDEX `fk_Cliente_Endereco1_idx` (`Endereco_NumeroEndereco` ASC, `Endereco_CEP_idCEP` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Sexo`
    FOREIGN KEY (`Sexo_idSexo`)
    REFERENCES `LivrariaABC`.`Sexo` (`idSexo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Naturalidade1`
    FOREIGN KEY (`Naturalidade_idNaturalidade`)
    REFERENCES `LivrariaABC`.`Naturalidade` (`idNaturalidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_EstadoCivil1`
    FOREIGN KEY (`EstadoCivil_idEstadoCivil`)
    REFERENCES `LivrariaABC`.`EstadoCivil` (`idEstadoCivil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Escolaridade1`
    FOREIGN KEY (`Escolaridade_idEscolaridade`)
    REFERENCES `LivrariaABC`.`Escolaridade` (`idEscolaridade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Endereco1`
    FOREIGN KEY (`Endereco_NumeroEndereco` , `Endereco_CEP_idCEP`)
    REFERENCES `LivrariaABC`.`Endereco` (`NumeroEndereco` , `CEP_idCEP`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`TipoTelefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`TipoTelefone` (
  `idTipoTelefone` INT NOT NULL AUTO_INCREMENT,
  `DescTipoTelefone` VARCHAR(45) NULL,
  PRIMARY KEY (`idTipoTelefone`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`Telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`Telefone` (
  `DDD` INT NOT NULL,
  `NumeroTelefone` VARCHAR(45) NOT NULL,
  `TipoTelefone_idTipoTelefone` INT NOT NULL,
  PRIMARY KEY (`DDD`, `NumeroTelefone`),
  INDEX `fk_Telefone_TipoTelefone1_idx` (`TipoTelefone_idTipoTelefone` ASC) VISIBLE,
  CONSTRAINT `fk_Telefone_TipoTelefone1`
    FOREIGN KEY (`TipoTelefone_idTipoTelefone`)
    REFERENCES `LivrariaABC`.`TipoTelefone` (`idTipoTelefone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`Editora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`Editora` (
  `idEditora` INT NOT NULL AUTO_INCREMENT,
  `NomeEditora` VARCHAR(200) NULL,
  PRIMARY KEY (`idEditora`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`Categoria` (
  `idCategoria` INT NOT NULL AUTO_INCREMENT,
  `NomeCategoria` VARCHAR(200) NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`Livro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`Livro` (
  `idLivro` INT NOT NULL AUTO_INCREMENT,
  `ISBN` VARCHAR(200) NOT NULL,
  `Titulo` VARCHAR(200) NOT NULL,
  `Desconto` FLOAT NULL,
  `Preco` FLOAT NULL,
  `Ano` INT NOT NULL,
  `Paginas` INT NOT NULL,
  `Editora_idEditora` INT NOT NULL,
  `Categoria_idCategoria` INT NOT NULL,
  PRIMARY KEY (`idLivro`),
  INDEX `fk_Livro_Editora1_idx` (`Editora_idEditora` ASC) VISIBLE,
  INDEX `fk_Livro_Categoria1_idx` (`Categoria_idCategoria` ASC) VISIBLE,
  UNIQUE INDEX `ISBN_UNIQUE` (`ISBN` ASC) VISIBLE,
  CONSTRAINT `fk_Livro_Editora1`
    FOREIGN KEY (`Editora_idEditora`)
    REFERENCES `LivrariaABC`.`Editora` (`idEditora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Livro_Categoria1`
    FOREIGN KEY (`Categoria_idCategoria`)
    REFERENCES `LivrariaABC`.`Categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`Autor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`Autor` (
  `idAutor` INT NOT NULL AUTO_INCREMENT,
  `NomeAutor` VARCHAR(45) NULL,
  PRIMARY KEY (`idAutor`),
  UNIQUE INDEX `NomeAutor_UNIQUE` (`NomeAutor` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`StatusCesta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`StatusCesta` (
  `idStatusCesta` INT NOT NULL AUTO_INCREMENT,
  `DescStatusCesta` VARCHAR(100) NULL,
  PRIMARY KEY (`idStatusCesta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`Cesta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`Cesta` (
  `idCesta` INT NOT NULL AUTO_INCREMENT,
  `StatusCesta_idStatusCesta` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idCesta`),
  INDEX `fk_Cesta_StatusCesta1_idx` (`StatusCesta_idStatusCesta` ASC) VISIBLE,
  INDEX `fk_Cesta_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Cesta_StatusCesta1`
    FOREIGN KEY (`StatusCesta_idStatusCesta`)
    REFERENCES `LivrariaABC`.`StatusCesta` (`idStatusCesta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cesta_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `LivrariaABC`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`StatusLivroAcervo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`StatusLivroAcervo` (
  `idStatusLivroAcervo` INT NOT NULL AUTO_INCREMENT,
  `DescStatusLivroAcervo` VARCHAR(45) NULL,
  PRIMARY KEY (`idStatusLivroAcervo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`LivroAcervo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`LivroAcervo` (
  `idLivroAcervo` INT NOT NULL AUTO_INCREMENT,
  `CodigoBarras` VARCHAR(200) NOT NULL,
  `Cesta_idCesta` INT NULL,
  `StatusLivroAcervo_idStatusLivroAcervo` INT NOT NULL,
  `Livro_idLivro` INT NOT NULL,
  PRIMARY KEY (`idLivroAcervo`),
  INDEX `fk_LivroAcervo_Cesta1_idx` (`Cesta_idCesta` ASC) VISIBLE,
  INDEX `fk_LivroAcervo_StatusLivroAcervo1_idx` (`StatusLivroAcervo_idStatusLivroAcervo` ASC) VISIBLE,
  INDEX `fk_LivroAcervo_Livro1_idx` (`Livro_idLivro` ASC) VISIBLE,
  UNIQUE INDEX `CodigoBarras_UNIQUE` (`CodigoBarras` ASC) VISIBLE,
  CONSTRAINT `fk_LivroAcervo_Cesta1`
    FOREIGN KEY (`Cesta_idCesta`)
    REFERENCES `LivrariaABC`.`Cesta` (`idCesta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LivroAcervo_StatusLivroAcervo1`
    FOREIGN KEY (`StatusLivroAcervo_idStatusLivroAcervo`)
    REFERENCES `LivrariaABC`.`StatusLivroAcervo` (`idStatusLivroAcervo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LivroAcervo_Livro1`
    FOREIGN KEY (`Livro_idLivro`)
    REFERENCES `LivrariaABC`.`Livro` (`idLivro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`StatusCompra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`StatusCompra` (
  `idStatusCompra` INT NOT NULL AUTO_INCREMENT,
  `DescStatusCompra` VARCHAR(100) NULL,
  PRIMARY KEY (`idStatusCompra`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`TipoPagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`TipoPagamento` (
  `idTipoPagamento` INT NOT NULL AUTO_INCREMENT,
  `DescTipoPagamento` VARCHAR(45) NULL,
  PRIMARY KEY (`idTipoPagamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`CPFCartao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`CPFCartao` (
  `idCPF` INT NOT NULL AUTO_INCREMENT,
  `NumeroCPF` VARCHAR(100) NULL,
  PRIMARY KEY (`idCPF`),
  UNIQUE INDEX `DescCPF_UNIQUE` (`NumeroCPF` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`Cartao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`Cartao` (
  `idCartao` INT NOT NULL AUTO_INCREMENT,
  `NumeroCartao` VARCHAR(100) NOT NULL,
  `DataVencimento` DATE NOT NULL,
  `NomeCartao` VARCHAR(200) NOT NULL,
  `CodigoSeguranca` VARCHAR(45) NULL,
  `CPF_idCPF` INT NOT NULL,
  UNIQUE INDEX `NumeroCartao_UNIQUE` (`NumeroCartao` ASC) VISIBLE,
  UNIQUE INDEX `CodigoSeguranca_UNIQUE` (`CodigoSeguranca` ASC) VISIBLE,
  INDEX `fk_Cartao_CPF1_idx` (`CPF_idCPF` ASC) VISIBLE,
  PRIMARY KEY (`idCartao`),
  CONSTRAINT `fk_Cartao_CPF1`
    FOREIGN KEY (`CPF_idCPF`)
    REFERENCES `LivrariaABC`.`CPFCartao` (`idCPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`Pagamento` (
  `idPagamento` INT NOT NULL AUTO_INCREMENT,
  `TipoPagamento_idTipoPagamento` INT NOT NULL,
  `Cartao_idCartao` INT NOT NULL,
  PRIMARY KEY (`idPagamento`),
  INDEX `fk_Pagamento_TipoPagamento1_idx` (`TipoPagamento_idTipoPagamento` ASC) VISIBLE,
  INDEX `fk_Pagamento_Cartao1_idx` (`Cartao_idCartao` ASC) VISIBLE,
  UNIQUE INDEX `Cartao_idCartao_UNIQUE` (`Cartao_idCartao` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamento_TipoPagamento1`
    FOREIGN KEY (`TipoPagamento_idTipoPagamento`)
    REFERENCES `LivrariaABC`.`TipoPagamento` (`idTipoPagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pagamento_Cartao1`
    FOREIGN KEY (`Cartao_idCartao`)
    REFERENCES `LivrariaABC`.`Cartao` (`idCartao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`Funcionario` (
  `idFuncionario` INT NOT NULL AUTO_INCREMENT,
  `CPF` VARCHAR(100) NOT NULL,
  `NomeFuncionario` VARCHAR(45) NULL,
  PRIMARY KEY (`idFuncionario`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`Compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`Compra` (
  `idCompra` INT NOT NULL AUTO_INCREMENT,
  `DataDeCompra` DATE NULL,
  `Frete` FLOAT NULL,
  `ValorCompra` VARCHAR(45) NULL,
  `StatusCompra_idStatusCompra` INT NOT NULL,
  `Cesta_idCesta` INT NOT NULL,
  `Pagamento_idPagamento` INT NOT NULL,
  `Funcionario_idFuncionario` INT NOT NULL,
  `Endereco_NumeroEndereco` INT NOT NULL,
  `Endereco_CEP_idCEP` INT NOT NULL,
  PRIMARY KEY (`idCompra`),
  INDEX `fk_Compra_StatusCompra1_idx` (`StatusCompra_idStatusCompra` ASC) VISIBLE,
  INDEX `fk_Compra_Cesta1_idx` (`Cesta_idCesta` ASC) VISIBLE,
  INDEX `fk_Compra_Pagamento1_idx` (`Pagamento_idPagamento` ASC) VISIBLE,
  INDEX `fk_Compra_Funcionario1_idx` (`Funcionario_idFuncionario` ASC) VISIBLE,
  INDEX `fk_Compra_Endereco1_idx` (`Endereco_NumeroEndereco` ASC, `Endereco_CEP_idCEP` ASC) VISIBLE,
  CONSTRAINT `fk_Compra_StatusCompra1`
    FOREIGN KEY (`StatusCompra_idStatusCompra`)
    REFERENCES `LivrariaABC`.`StatusCompra` (`idStatusCompra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Compra_Cesta1`
    FOREIGN KEY (`Cesta_idCesta`)
    REFERENCES `LivrariaABC`.`Cesta` (`idCesta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Compra_Pagamento1`
    FOREIGN KEY (`Pagamento_idPagamento`)
    REFERENCES `LivrariaABC`.`Pagamento` (`idPagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Compra_Funcionario1`
    FOREIGN KEY (`Funcionario_idFuncionario`)
    REFERENCES `LivrariaABC`.`Funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Compra_Endereco1`
    FOREIGN KEY (`Endereco_NumeroEndereco` , `Endereco_CEP_idCEP`)
    REFERENCES `LivrariaABC`.`Endereco` (`NumeroEndereco` , `CEP_idCEP`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`Livro_has_Autor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`Livro_has_Autor` (
  `Livro_idLivro` INT NOT NULL,
  `Autor_idAutor` INT NOT NULL,
  PRIMARY KEY (`Livro_idLivro`, `Autor_idAutor`),
  INDEX `fk_Livro_has_Autor_Autor1_idx` (`Autor_idAutor` ASC) VISIBLE,
  INDEX `fk_Livro_has_Autor_Livro1_idx` (`Livro_idLivro` ASC) VISIBLE,
  CONSTRAINT `fk_Livro_has_Autor_Livro1`
    FOREIGN KEY (`Livro_idLivro`)
    REFERENCES `LivrariaABC`.`Livro` (`idLivro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Livro_has_Autor_Autor1`
    FOREIGN KEY (`Autor_idAutor`)
    REFERENCES `LivrariaABC`.`Autor` (`idAutor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LivrariaABC`.`Cliente_has_Telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LivrariaABC`.`Cliente_has_Telefone` (
  `Cliente_idCliente` INT NOT NULL,
  `Telefone_DDD` INT NOT NULL,
  `Telefone_NumeroTelefone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Cliente_idCliente`, `Telefone_DDD`, `Telefone_NumeroTelefone`),
  INDEX `fk_Cliente_has_Telefone_Telefone1_idx` (`Telefone_DDD` ASC, `Telefone_NumeroTelefone` ASC) VISIBLE,
  INDEX `fk_Cliente_has_Telefone_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_has_Telefone_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `LivrariaABC`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_has_Telefone_Telefone1`
    FOREIGN KEY (`Telefone_DDD` , `Telefone_NumeroTelefone`)
    REFERENCES `LivrariaABC`.`Telefone` (`DDD` , `NumeroTelefone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
