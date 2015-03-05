/********************************************I-DAT-RTM-TI-0-05/03/2015********************************************/


INSERT INTO segu.tsubsistema ( codigo, nombre, fecha_reg, prefijo, estado_reg, nombre_carpeta, id_subsis_orig)
VALUES ('TI', 'tienda', '2015-03-05', 'TI', 'activo', 'tienda', NULL);


----------------------------------
--COPY LINES TO data.sql FILE  
---------------------------------

select pxp.f_insert_tgui ('TIENDA', '', 'TI', 'si', 1, '', 1, '', '', 'TI');
select pxp.f_insert_tgui ('Categoria', 'categoria', 'CAT', 'si', 1, 'sis_tienda/vista/categoria/Categoria.php', 2, '', 'Categoria', 'TI');
select pxp.f_insert_tgui ('Marca', 'marca', 'MAR', 'si', 2, 'sis_tienda/vista/marca/Marca.php', 2, '', 'Marca', 'TI');
select pxp.f_delete_tgui ('PRODUC');
select pxp.f_delete_tgui ('MOV');
select pxp.f_insert_tgui ('Movimiento', 'movimiento', 'MOV', 'si', 4, 'sis_tienda/vista/movimiento/Movimiento.php', 2, '', 'Movimiento', 'TI');
----------------------------------
--COPY LINES TO dependencies.sql FILE  
---------------------------------

select pxp.f_insert_testructura_gui ('TI', 'SISTEMA');
select pxp.f_insert_testructura_gui ('CAT', 'TI');
select pxp.f_insert_testructura_gui ('MAR', 'TI');
select pxp.f_delete_testructura_gui ('PRODUC', 'TI');
select pxp.f_delete_testructura_gui ('MOV', 'TI');
select pxp.f_insert_testructura_gui ('MOV', 'TI');

/********************************************F-DAT-RTM-TI-0-05/03/2015********************************************/
