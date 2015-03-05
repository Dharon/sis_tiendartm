CREATE OR REPLACE FUNCTION "ti"."ft_marca_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Tienda
 FUNCION: 		ti.ft_marca_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'ti.tmarca'
 AUTOR: 		 (admin)
 FECHA:	        23-02-2015 23:20:00
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
	v_id_marca	integer;
			    
BEGIN

    v_nombre_funcion = 'ti.ft_marca_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'TI_MAR_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		23-02-2015 23:20:00
	***********************************/

	if(p_transaccion='TI_MAR_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into ti.tmarca(
			estado_reg,
			nombre,
			id_usuario_ai,
			id_usuario_reg,
			fecha_reg,
			usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.nombre,
			v_parametros._id_usuario_ai,
			p_id_usuario,
			now(),
			v_parametros._nombre_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_marca into v_id_marca;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','marca almacenado(a) con exito (id_marca'||v_id_marca||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_marca',v_id_marca::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'TI_MAR_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		23-02-2015 23:20:00
	***********************************/

	elsif(p_transaccion='TI_MAR_MOD')then

		begin
			--Sentencia de la modificacion
			update ti.tmarca set
			nombre = v_parametros.nombre,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_marca=v_parametros.id_marca;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','marca modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_marca',v_parametros.id_marca::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'TI_MAR_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		23-02-2015 23:20:00
	***********************************/

	elsif(p_transaccion='TI_MAR_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from ti.tmarca
            where id_marca=v_parametros.id_marca;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','marca eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_marca',v_parametros.id_marca::varchar);
              
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
ALTER FUNCTION "ti"."ft_marca_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
