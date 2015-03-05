CREATE OR REPLACE FUNCTION "ti"."ft_categoria_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Tienda
 FUNCION: 		ti.ft_categoria_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'ti.tcategoria'
 AUTOR: 		 (admin)
 FECHA:	        23-02-2015 23:17:24
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_categoria	integer;
			    
BEGIN

    v_nombre_funcion = 'ti.ft_categoria_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'TI_CAT_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		23-02-2015 23:17:24
	***********************************/

	if(p_transaccion='TI_CAT_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into ti.tcategoria(
			estado_reg,
			nombre,
			fecha_reg,
			usuario_ai,
			id_usuario_reg,
			id_usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.nombre,
			now(),
			v_parametros._nombre_usuario_ai,
			p_id_usuario,
			v_parametros._id_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_categoria into v_id_categoria;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','categoria almacenado(a) con exito (id_categoria'||v_id_categoria||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_categoria',v_id_categoria::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'TI_CAT_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		23-02-2015 23:17:24
	***********************************/

	elsif(p_transaccion='TI_CAT_MOD')then

		begin
			--Sentencia de la modificacion
			update ti.tcategoria set
			nombre = v_parametros.nombre,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_categoria=v_parametros.id_categoria;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','categoria modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_categoria',v_parametros.id_categoria::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'TI_CAT_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		23-02-2015 23:17:24
	***********************************/

	elsif(p_transaccion='TI_CAT_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from ti.tcategoria
            where id_categoria=v_parametros.id_categoria;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','categoria eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_categoria',v_parametros.id_categoria::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
         
	else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

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
ALTER FUNCTION "ti"."ft_categoria_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
