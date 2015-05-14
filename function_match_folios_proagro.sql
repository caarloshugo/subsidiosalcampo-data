CREATE OR REPLACE FUNCTION match_folios_proagro()
RETURNS TABLE (text varchar) AS

$$
DECLARE
 registros RECORD;
 registro RECORD;
 registroexiste RECORD;
 years varchar;
 nombres varchar;
 superficies float[];
 cultivos integer[];
 ids varchar;
 suma float;
 sumasuperficie float;
 text varchar;

 BEGIN

 -- Ciclo para recorrer tabla de proagro_2014
 FOR registros IN select productor from proagro_2014 group by productor LOOP

         years  := '';
         ids    := '';
         nombres := '';
         suma   := 0;
         sumasuperficie := 0;
         superficies := NULL;
         cultivos    := NULL;

         -- Ciclo para recorrer los apoyos donde el folio del ciclo anterior aparezca en la misma tabla en repetidas ocasiones
         FOR registro IN select id, productor, superficie, cultivo, nproductor, ano, importe, estado from proagro_2014 where productor=''||registros.productor||'' LOOP
                 years   := years   || registro.ano         || ',';
                 ids     := ids     || registro.id          || ',';
                 nombres := nombres ||  registro.nproductor || ',';
                 suma    := suma + registro.importe;
                 sumasuperficie := sumasuperficie + registro.superficie;
                 superficies := superficies || registro.superficie;

                 IF registro.cultivo = '' THEN 
                         cultivos := cultivos || 1000;
                 ELSE
                         cultivos := cultivos || cast(registro.cultivo as integer);
                 END IF;

         END LOOP;

         years  := rtrim(years, ',');
         ids    := rtrim(ids, ',');
         nombres := rtrim(nombres, ',');

         text:= superficies;
         RETURN QUERY                                                                                                                                                                                           
         select text;

         text:= cultivos;
         RETURN QUERY                                                                                                                                                                                           
         select text;
		
		IF(SELECT count(*) FROM match_folios2 WHERE producer=''||registros.productor||'') > 0 THEN
			RAISE NOTICE 'Registro existente';
			RAISE NOTICE 'Producer buscado: = %',registros.productor;
			SELECT unnest(years) as years  INTO STRICT registroexiste FROM match_folios2 WHERE producer=''||registros.productor||'' LIMIT 1;
			RAISE NOTICE 'years seleccionado: = %',registroexiste.years;
			
			/*
			array_to_string
			roducer     | character varying(155) | 
			ids          | text[]                 | 
			name         | text[]                 | 
			years        | text[]                 | 
			crops        | integer[]              | 
			surface      | double precision[]     | 
			totalsurface | double precision       | 
			total        | double precision       | 
			keystate     | integer                | 
			textsearch   | tsvector   
			*/
		ELSE
			RAISE NOTICE 'Insert';
			-- Se inserta en la tabla de match_folios
			--select match_folios_proagro();
			--INSERT INTO match_folios2 (producer,ids, name, years, crops, surface, totalsurface, total, keystate) VALUES (registros.productor, string_to_array(ids, ','), string_to_array(nombres, ','), string_to_array(years, ','), cultivos, superficies, sumasuperficie, suma, 32);
		END IF;
 END LOOP;

END;
$$
LANGUAGE plpgsql;
