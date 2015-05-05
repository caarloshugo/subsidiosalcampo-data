CREATE TABLE proagro_2014 (
	estado    integer,           
	nestado   varchar(50),
	ddr       integer,          
	nddr      varchar(55),
	cader     integer,          
	ncader    varchar(55),
	municipio varchar(55),
	nmunicipio varchar(55),
	ejido     varchar(55),
	nejido    varchar(55),
	productor varchar(55),
	nproductor varchar(155),
	superficie double precision,      
	importe   double precision,    
	ciclo     varchar(55),
	cultivo   varchar(55),
	ncultivo  varchar(55),
	clave     varchar(55),
	regimen   varchar(55),
	programa  varchar(55),
	sexo  varchar(10),
	grupoedad  varchar(255),
	region  varchar(255)
);

alter table proagro add column id serial;
alter table proagro add column ano integer;
copy cafe from '/cafe-csv/cafe-2005.csv' delimiter ',';

/*Estado,
Nombre del estado,
DDR,
Nombre del DDR,
CADER,
Nombre del CADER,
Municipio,
Nombre del municipio,
Ejido,
Nombre del Ejido,
Productor,
Nombre productor,
Superficie apoyada,
Importe apoyado,
Ciclo,
Cultivo,
Nombre del cultivo,
Clave Regimen Hidrico,
Regimen Hidrico,
Programa,
Sexo,
Grupo de Edad,
Region del pais
*/
