/***********************************I-SCP-RTM-TI-0-05/03/2015****************************************/

CREATE TABLE ti.tcategoria (
  id_categoria SERIAL, 
  nombre VARCHAR, 
  CONSTRAINT tcategoria_pkey PRIMARY KEY(id_categoria)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

CREATE TABLE ti.tmarca (
  id_marca SERIAL, 
  nombre VARCHAR, 
  CONSTRAINT tmarca_pkey PRIMARY KEY(id_marca)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

CREATE TABLE ti.tmovimiento (
  id_movimiento SERIAL, 
  cantidad_movimiento INTEGER, 
  fecha DATE, 
  tipo VARCHAR, 
  id_producto INTEGER, 
  CONSTRAINT tmovimiento_pkey PRIMARY KEY(id_movimiento)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

CREATE TABLE ti.tproducto (
  id_producto SERIAL, 
  nombre VARCHAR, 
  descripccion VARCHAR, 
  id_marca INTEGER, 
  id_categoria INTEGER, 
  stock INTEGER, 
  CONSTRAINT tproducto_pkey PRIMARY KEY(id_producto)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

/***********************************F-SCP-RTM-TI-0-05/03/2015****************************************/