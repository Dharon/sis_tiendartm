CREATE OR REPLACE FUNCTION "ti"."ft_movimiento_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Tienda
 FUNCION: 		ti.ft_movimiento_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'ti.tmovimiento'
 AUTOR: 		 (admin)
 FECHA:	        26-02-2015 23:32:18
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'ti.ft_movimiento_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'TI_MOV_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		26-02-2015 23:32:18
	***********************************/

	if(p_transaccion='TI_MOV_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						mov.id_movimiento,
						mov.tipo,
						mov.fecha,
						mov.estado_reg,
						mov.cantidad,
						mov.id_usuario_ai,
						mov.id_usuario_reg,
						mov.fecha_reg,
						mov.usuario_ai,
						mov.id_usuario_mod,
						mov.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from ti.tmovimiento mov
						inner join segu.tusuario usu1 on usu1.id_usuario = mov.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = mov.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'TI_MOV_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		26-02-2015 23:32:18
	***********************************/

	elsif(p_transaccion='TI_MOV_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_movimiento)
					    from ti.tmovimiento mov
					    inner join segu.tusuario usu1 on usu1.id_usuario = mov.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = mov.id_usuario_mod
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
					
	else
					     
		raise exception 'Transaccion inexistente';
					         
	end if;
					
EXCEPTION
					
	WHEN OTHERS THEN
			v_resp='';
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
			v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
			v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
			raise exception '%',v_resp;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "ti"."ft_movimiento_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
