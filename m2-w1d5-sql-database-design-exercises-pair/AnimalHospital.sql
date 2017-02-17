BEGIN TRANSACTION;

USE [AnimalHospital]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****** Object:  Table [dbo].[species]    Script Date: 2/17/2017 2:24:46 PM ******/

CREATE TABLE [dbo].[species](
	[species_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	CONSTRAINT pk_species_id PRIMARY KEY (species_id)
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[procedure]    Script Date: 2/17/2017 2:24:40 PM ******/

CREATE TABLE [dbo].[procedures](
	[procedure_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[price] [smallmoney] NOT NULL,
	[species_id] [int] NOT NULL,
	CONSTRAINT pk_procedure_id PRIMARY KEY (procedure_id),
	CONSTRAINT fk_procedure_species FOREIGN KEY (species_id) REFERENCES species(species_id),
	CONSTRAINT procedure_price_check CHECK (price > 0)
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[owner]    Script Date: 2/17/2017 2:24:20 PM ******/


CREATE TABLE [dbo].[owner](
	[owner_id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [varchar](50) NOT NULL,
	[last_name] [varchar](50) NOT NULL,
	[address] [varchar](100) NOT NULL,
	[phone_number] [varchar](10) NOT NULL,
	CONSTRAINT pk_owner_id PRIMARY KEY (owner_id)
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[pet]    Script Date: 2/17/2017 2:24:32 PM ******/

CREATE TABLE [dbo].[pet](
	[pet_id] [int] NOT NULL,
	[owner_id] [int] NOT NULL,
	[species_id] [int] NOT NULL,
	[name] [varchar](25) NULL,
	[age] [int] NULL,
	[sex] [varchar](7) NOT NULL DEFAULT 'UNKNOWN',
	CONSTRAINT pk_pet_id PRIMARY KEY (pet_id),
	CONSTRAINT pk_pet_species_id FOREIGN KEY (species_id) REFERENCES species(species_id),
	CONSTRAINT pk_pet_owner_id FOREIGN KEY (owner_id) REFERENCES owner(owner_id),
	CONSTRAINT pet_sex_check CHECK ((sex = 'M') OR (sex = 'F') OR (sex = 'UNKNOWN')),
	CONSTRAINT pet_age_check CHECK (age >0)
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[visit]    Script Date: 2/17/2017 2:24:52 PM ******/

CREATE TABLE [dbo].[visit](
	[visit_date] [varchar](10) NOT NULL,
	[pet_id] [int] NOT NULL,
	[procedure_id] [int] NOT NULL,
	[invoice_id] [int] IDENTITY(1,1) NOT NULL,
	CONSTRAINT pk_visit PRIMARY KEY NONCLUSTERED (visit_date, pet_id, procedure_id),
	CONSTRAINT fk_visit_procedure_id FOREIGN KEY (procedure_id) REFERENCES procedures(procedure_id),
	CONSTRAINT fk_visit_pet_id FOREIGN KEY (pet_id) REFERENCES pet(pet_id)
) ON [PRIMARY]

GO

COMMIT TRANSACTION;
