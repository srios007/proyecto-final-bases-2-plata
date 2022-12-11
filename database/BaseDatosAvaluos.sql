CREATE TABLE avaluo_schema.Inmueble (
	id_inmueble serial NOT NULL,
	id_sector integer NOT NULL,
	id_entidad integer NOT NULL,
	cedula_catastral varchar(20) NOT NULL,
	chip_inmueble varchar(13) NOT NULL,
	matricula_inmobiliaria varchar(15) NOT NULL,
	area_inmueble numeric(10,1) NOT NULL,
	tipo_inmueble varchar(20) NOT NULL,
	destino_economico varchar(100) NOT NULL,
	valor_inmueble numeric(11) NOT NULL,
	CONSTRAINT Inmueble_pk PRIMARY KEY (id_inmueble),
	CONSTRAINT Cedula_catastral_uq UNIQUE (cedula_catastral),
	CONSTRAINT Chip_inmuble_uq UNIQUE (chip_inmueble),
	CONSTRAINT Matricula_inmobiliaria_uq UNIQUE (matricula_inmobiliaria)
	USING INDEX TABLESPACE avaluosdb_default
)
TABLESPACE avaluosdb_default;
-- ddl-end --
COMMENT ON TABLE avaluo_schema.Inmueble IS E'Inmueble';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Inmueble.id_inmueble IS E'Identificador único del inmueble en la BD.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Inmueble.cedula_catastral IS E'Cédula única asignada por el catastro al inmueble.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Inmueble.chip_inmueble IS E'Chip asociado al inmueble.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Inmueble.matricula_inmobiliaria IS E'Matrícula inmobiliaria del inmueble.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Inmueble.area_inmueble IS E'Área del inmueble en metros cuadrados.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Inmueble.tipo_inmueble IS E'Tipo de inmueble.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Inmueble.destino_economico IS E'Destino económico del inmueble.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Inmueble.valor_inmueble IS E'Valor del inmueble en pesos colombianos.';
-- ddl-end --
COMMENT ON CONSTRAINT Cedula_catastral_uq ON avaluo_schema.Inmueble  IS E'Verifica que la cédula catastral no se repita.';
-- ddl-end --
COMMENT ON CONSTRAINT Chip_inmuble_uq ON avaluo_schema.Inmueble  IS E'Verifica que el chip no se repita.';
-- ddl-end --
COMMENT ON CONSTRAINT Matricula_inmobiliaria_uq ON avaluo_schema.Inmueble  IS E'Verifica que la matrícula inmobiliaria no se repita.';
-- ddl-end --
ALTER TABLE avaluo_schema.Inmueble OWNER TO db_avaluos_admin;
-- ddl-end --

-- object: avaluo_schema.Sector | type: TABLE --
-- DROP TABLE IF EXISTS avaluo_schema.Sector;
CREATE TABLE avaluo_schema.Sector (
	id_sector serial NOT NULL,
	codigo_sector varchar(30) NOT NULL,
	desc_sector varchar(250) NOT NULL,
	actividad_predominante varchar(15) NOT NULL,
	CONSTRAINT Sector_pk PRIMARY KEY (id_sector),
	CONSTRAINT Codigo_sector_uq UNIQUE (codigo_sector)
)
TABLESPACE avaluosdb_default;
-- ddl-end --
COMMENT ON TABLE avaluo_schema.Sector IS E'Los diferentes sectores que tiene una ciudad.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Sector.id_sector IS E'Identificador único del sector en la BD.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Sector.codigo_sector IS E'Código único del sector.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Sector.desc_sector IS E'Descripción de un sector dado.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Sector.actividad_predominante IS E'Actividad predominante del sector.';
-- ddl-end --
COMMENT ON CONSTRAINT Codigo_sector_uq ON avaluo_schema.Sector  IS E'Verifica que el código del sector no se repita.';
-- ddl-end --
ALTER TABLE avaluo_schema.Sector OWNER TO db_avaluos_admin;
-- ddl-end --

-- object: avaluo_schema.Avaluo | type: TABLE --
-- DROP TABLE IF EXISTS avaluo_schema.Avaluo;
CREATE TABLE avaluo_schema.Avaluo (
	id_avaluo serial NOT NULL,
	id_inmueble integer NOT NULL,
	id_entidad integer NOT NULL,
	num_radicado varchar(20) NOT NULL,
	fecha_solicitud_avaluo date NOT NULL,
	fecha_expedicion_avaluo date NOT NULL,
	costo_avaluo numeric(6) NOT NULL,
	proposito_avaluo varchar(15) NOT NULL,
	CONSTRAINT Avaluo_pk PRIMARY KEY (id_avaluo),
	CONSTRAINT Costo_avaluo_ck CHECK (costo_avaluo >=0)
)
TABLESPACE avaluosdb_default;
-- ddl-end --
COMMENT ON TABLE avaluo_schema.Avaluo IS E'Documento de avaluo asociado a un inmueble.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Avaluo.id_avaluo IS E'Identificador único del avalúo en la BD.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Avaluo.num_radicado IS E'Número de radicado del avalúo.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Avaluo.fecha_solicitud_avaluo IS E'Fecha de solicitud del avalúo.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Avaluo.fecha_expedicion_avaluo IS E'Fecha en la que se expide un avalúo.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Avaluo.costo_avaluo IS E'Costo total por la generación del avalúo.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Avaluo.proposito_avaluo IS E'Propósito del avalúo.';
-- ddl-end --
COMMENT ON CONSTRAINT Costo_avaluo_ck ON avaluo_schema.Avaluo  IS E'Verifica que el costo del avalúo sea un número positivo.';
-- ddl-end --
ALTER TABLE avaluo_schema.Avaluo OWNER TO db_avaluos_admin;
-- ddl-end --

-- object: avaluo_schema.Direccion | type: TABLE --
-- DROP TABLE IF EXISTS avaluo_schema.Direccion;
CREATE TABLE avaluo_schema.Direccion (
	id_direccion serial NOT NULL,
	id_inmueble integer NOT NULL,
	direccion varchar(50) NOT NULL,
	barrio varchar(30) NOT NULL,
	municipio varchar(30) NOT NULL,
	es_actual boolean NOT NULL,
	fecha_inicio date NOT NULL,
	fecha_fin date NOT NULL,
	CONSTRAINT Direccion_pk PRIMARY KEY (id_direccion),
	CONSTRAINT Fecha_direccion_ck CHECK (fecha_fin > fecha_inicio)
)
TABLESPACE avaluosdb_default;
-- ddl-end --
COMMENT ON TABLE avaluo_schema.Direccion IS E'Dirección asociada a un inmueble.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Direccion.id_direccion IS E'Identificador único de una dirección en la base de datos.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Direccion.direccion IS E'Dirección asociada a un inmueble.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Direccion.barrio IS E'Barrio al que pertenece la dirección.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Direccion.municipio IS E'Municipio al que pertenece la dirección.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Direccion.es_actual IS E'Determina si la dirección está actualmente activa en el inmueble.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Direccion.fecha_inicio IS E'Fecha de inicio de la dirección.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Direccion.fecha_fin IS E'Fecha final de la dirección.';
-- ddl-end --
COMMENT ON CONSTRAINT Fecha_direccion_ck ON avaluo_schema.Direccion  IS E'Verifica que la fecha final sea mayor que la inicial.';
-- ddl-end --
ALTER TABLE avaluo_schema.Direccion OWNER TO db_avaluos_admin;
-- ddl-end --

-- object: avaluo_schema.Entidad | type: TABLE --
-- DROP TABLE IF EXISTS avaluo_schema.Entidad;
CREATE TABLE avaluo_schema.Entidad (
	id_entidad serial NOT NULL,
	identificacion_entidad varchar(11) NOT NULL,
	tipo_identificacion varchar(3) NOT NULL,
	telefono_entidad numeric(10) NOT NULL,
	correo_entidad varchar(50) NOT NULL,
	CONSTRAINT Entidad_pk PRIMARY KEY (id_entidad),
	CONSTRAINT Identificacion_uq UNIQUE (identificacion_entidad,tipo_identificacion)
	USING INDEX TABLESPACE avaluosdb_default,
	CONSTRAINT Correo_uq UNIQUE (correo_entidad),
	CONSTRAINT Tipo_identificacion_ck CHECK (tipo_identificacion IN ('CC', 'CE', 'PAP'))
)
TABLESPACE avaluosdb_default;
-- ddl-end --
COMMENT ON TABLE avaluo_schema.Entidad IS E'Ente que puede ser propietario de un inmueble o solicitar un avalúo de un inmueble.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Entidad.id_entidad IS E'Identificador único de la entidad en la BD.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Entidad.identificacion_entidad IS E'Identificación de la entidad de acuerdo a la reglamentación colombiama.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Entidad.tipo_identificacion IS E'Tipo de identificación del ente de acuerdo a la normativa colombiana.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Entidad.telefono_entidad IS E'Teléfono asociado a la entidad.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Entidad.correo_entidad IS E'Correo asociado a una entidad.';
-- ddl-end --
COMMENT ON CONSTRAINT Identificacion_uq ON avaluo_schema.Entidad  IS E'Verifica que el número de documento sea único respecto al tipo de identificación.';
-- ddl-end --
COMMENT ON CONSTRAINT Correo_uq ON avaluo_schema.Entidad  IS E'Verifica que el correo sea único.';
-- ddl-end --
COMMENT ON CONSTRAINT Tipo_identificacion_ck ON avaluo_schema.Entidad  IS E'Verifica que el tipo de identificación sea válido de acuerdo a la normatividad colombiana.';
-- ddl-end --
ALTER TABLE avaluo_schema.Entidad OWNER TO db_avaluos_admin;
-- ddl-end --

-- object: avaluo_schema.Edificacion | type: TABLE --
-- DROP TABLE IF EXISTS avaluo_schema.Edificacion;
CREATE TABLE avaluo_schema.Edificacion (
	id_edificacion serial NOT NULL,
	nivel_edificacion varchar(10) NOT NULL,
	descripcion_edificacion varchar(100) NOT NULL,
	CONSTRAINT Edificacion_pk PRIMARY KEY (id_edificacion)
)
TABLESPACE avaluosdb_default;
-- ddl-end --
COMMENT ON TABLE avaluo_schema.Edificacion IS E'Edificación asociada a un sector.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Edificacion.id_edificacion IS E'Identificador único de la edificación de un sector en la BD.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Edificacion.nivel_edificacion IS E'Nivel de edficación de un sector dado.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Edificacion.descripcion_edificacion IS E'Descripción de la edificación de un sector.';
-- ddl-end --
ALTER TABLE avaluo_schema.Edificacion OWNER TO db_avaluos_admin;
-- ddl-end --

-- object: avaluo_schema.Servicio | type: TABLE --
-- DROP TABLE IF EXISTS avaluo_schema.Servicio;
CREATE TABLE avaluo_schema.Servicio (
	id_servicio serial NOT NULL,
	nombre_servicio varchar(15) NOT NULL,
	descripcion_servicio varchar(100) NOT NULL,
	CONSTRAINT Servicio_pk PRIMARY KEY (id_servicio)
)
TABLESPACE avaluosdb_default;
-- ddl-end --
COMMENT ON TABLE avaluo_schema.Servicio IS E'Servicios asociados a un sector.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Servicio.id_servicio IS E'Identificador único del servicio en la BD.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Servicio.nombre_servicio IS E'Nombre del servicio.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Servicio.descripcion_servicio IS E'Breve descripción del servicio.';
-- ddl-end --
ALTER TABLE avaluo_schema.Servicio OWNER TO db_avaluos_admin;
-- ddl-end --

-- object: avaluo_schema.Estrato | type: TABLE --
-- DROP TABLE IF EXISTS avaluo_schema.Estrato;
CREATE TABLE avaluo_schema.Estrato (
	id_estrato serial NOT NULL,
	num_estrato numeric(1) NOT NULL,
	CONSTRAINT Estrato_pk PRIMARY KEY (id_estrato)
)
TABLESPACE avaluosdb_default;
-- ddl-end --
COMMENT ON TABLE avaluo_schema.Estrato IS E'Estrato asociado a un sector.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Estrato.id_estrato IS E'Identificador único del estrato en la BD.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Estrato.num_estrato IS E'Número de estrado de un sector dado.';
-- ddl-end --
ALTER TABLE avaluo_schema.Estrato OWNER TO db_avaluos_admin;
-- ddl-end --

-- object: avaluo_schema.Delimitacion | type: TABLE --
-- DROP TABLE IF EXISTS avaluo_schema.Delimitacion;
CREATE TABLE avaluo_schema.Delimitacion (
	id_delimitacion serial NOT NULL,
	descripcion varchar(250) NOT NULL,
	CONSTRAINT Delimitacion_pk PRIMARY KEY (id_delimitacion)
)
TABLESPACE avaluosdb_default;
-- ddl-end --
COMMENT ON TABLE avaluo_schema.Delimitacion IS E'Delimitación asociada a un sector.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Delimitacion.id_delimitacion IS E'Identificador único de la delimitación de un sector en la BD.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Delimitacion.descripcion IS E'Descripcion de la delimitacion.';
-- ddl-end --
ALTER TABLE avaluo_schema.Delimitacion OWNER TO db_avaluos_admin;
-- ddl-end --

-- object: avaluo_schema.Persona | type: TABLE --
-- DROP TABLE IF EXISTS avaluo_schema.Persona;
CREATE TABLE avaluo_schema.Persona (
	id_entidad integer NOT NULL,
	primer_nombre varchar(30) NOT NULL,
	segundo_nombre varchar(30),
	primer_apellido varchar(30) NOT NULL,
	segundo_apellido varchar(30),
	fecha_nacimiento date NOT NULL,
	CONSTRAINT Persona_pk PRIMARY KEY (id_entidad)
)
TABLESPACE avaluosdb_default;
-- ddl-end --
COMMENT ON TABLE avaluo_schema.Persona IS E'Persona propietaria de un inmueble o que solicita un avalúo.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Persona.primer_nombre IS E'Primer nombre de la persona.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Persona.segundo_nombre IS E'Segundo nombre asociado a la persona.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Persona.primer_apellido IS E'Primer apellido asociado a la persona.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Persona.segundo_apellido IS E'Segundo apellido asociado a la persona.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Persona.fecha_nacimiento IS E'Fecha de nacimiento asociada a la persona.';
-- ddl-end --
ALTER TABLE avaluo_schema.Persona OWNER TO db_avaluos_admin;
-- ddl-end --

-- object: avaluo_schema.Empresa | type: TABLE --
-- DROP TABLE IF EXISTS avaluo_schema.Empresa;
CREATE TABLE avaluo_schema.Empresa (
	id_entidad integer NOT NULL,
	camara_comercio varchar(20) NOT NULL,
	nombre_empresa varchar(40) NOT NULL,
	razon_social varchar(100) NOT NULL,
	CONSTRAINT Empresa_pk PRIMARY KEY (id_entidad),
	CONSTRAINT Camara_comercio_uq UNIQUE (camara_comercio)
	USING INDEX TABLESPACE avaluosdb_default
)
TABLESPACE avaluosdb_default;
-- ddl-end --
COMMENT ON TABLE avaluo_schema.Empresa IS E'Empresa propietaria de un inmueble o que solicita un avalúo catastral.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Empresa.camara_comercio IS E'Número de cámara de comercio de la empresa.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Empresa.nombre_empresa IS E'Nombre asociado a la empresa.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Empresa.razon_social IS E'Razón social asociada a la empresa.';
-- ddl-end --
COMMENT ON CONSTRAINT Camara_comercio_uq ON avaluo_schema.Empresa  IS E'Verficia que el número de cámara y comercio sea único.';
-- ddl-end --
ALTER TABLE avaluo_schema.Empresa OWNER TO db_avaluos_admin;
-- ddl-end --

-- object: avaluo_schema.Via_Acceso | type: TABLE --
-- DROP TABLE IF EXISTS avaluo_schema.Via_Acceso;
CREATE TABLE avaluo_schema.Via_Acceso (
	id_via serial NOT NULL,
	direccion_via varchar(50) NOT NULL,
	descripcion_via varchar(200) NOT NULL,
	CONSTRAINT Via_Acceso_pk PRIMARY KEY (id_via)
)
TABLESPACE avaluosdb_default;
-- ddl-end --
COMMENT ON TABLE avaluo_schema.Via_Acceso IS E'Vía de acceso asociada a un sector.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Via_Acceso.id_via IS E'Identificador único de la vía de acceso en la BD.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Via_Acceso.direccion_via IS E'Dirección de la vía de acceso.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Via_Acceso.descripcion_via IS E'Descripción de la vía de acceso.';
-- ddl-end --
ALTER TABLE avaluo_schema.Via_Acceso OWNER TO db_avaluos_admin;
-- ddl-end --

-- object: Entidad_fk | type: CONSTRAINT --
-- ALTER TABLE avaluo_schema.Persona DROP CONSTRAINT IF EXISTS Entidad_fk CASCADE;
ALTER TABLE avaluo_schema.Persona ADD CONSTRAINT Entidad_fk FOREIGN KEY (id_entidad)
REFERENCES avaluo_schema.Entidad (id_entidad) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: Entidad_fk | type: CONSTRAINT --
-- ALTER TABLE avaluo_schema.Empresa DROP CONSTRAINT IF EXISTS Entidad_fk CASCADE;
ALTER TABLE avaluo_schema.Empresa ADD CONSTRAINT Entidad_fk FOREIGN KEY (id_entidad)
REFERENCES avaluo_schema.Entidad (id_entidad) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: Entidad_fk | type: CONSTRAINT --
-- ALTER TABLE avaluo_schema.Avaluo DROP CONSTRAINT IF EXISTS Entidad_fk CASCADE;
ALTER TABLE avaluo_schema.Avaluo ADD CONSTRAINT Entidad_fk FOREIGN KEY (id_entidad)
REFERENCES avaluo_schema.Entidad (id_entidad) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: Inmueble_fk | type: CONSTRAINT --
-- ALTER TABLE avaluo_schema.Avaluo DROP CONSTRAINT IF EXISTS Inmueble_fk CASCADE;
ALTER TABLE avaluo_schema.Avaluo ADD CONSTRAINT Inmueble_fk FOREIGN KEY (id_inmueble)
REFERENCES avaluo_schema.Inmueble (id_inmueble) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: Sector_fk | type: CONSTRAINT --
-- ALTER TABLE avaluo_schema.Inmueble DROP CONSTRAINT IF EXISTS Sector_fk CASCADE;
ALTER TABLE avaluo_schema.Inmueble ADD CONSTRAINT Sector_fk FOREIGN KEY (id_sector)
REFERENCES avaluo_schema.Sector (id_sector) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: Entidad_fk | type: CONSTRAINT --
-- ALTER TABLE avaluo_schema.Inmueble DROP CONSTRAINT IF EXISTS Entidad_fk CASCADE;
ALTER TABLE avaluo_schema.Inmueble ADD CONSTRAINT Entidad_fk FOREIGN KEY (id_entidad)
REFERENCES avaluo_schema.Entidad (id_entidad) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: Inmueble_fk | type: CONSTRAINT --
-- ALTER TABLE avaluo_schema.Direccion DROP CONSTRAINT IF EXISTS Inmueble_fk CASCADE;
ALTER TABLE avaluo_schema.Direccion ADD CONSTRAINT Inmueble_fk FOREIGN KEY (id_inmueble)
REFERENCES avaluo_schema.Inmueble (id_inmueble) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: avaluo_schema.Sector_Edificacion | type: TABLE --
-- DROP TABLE IF EXISTS avaluo_schema.Sector_Edificacion;
CREATE TABLE avaluo_schema.Sector_Edificacion (
	id_sector integer NOT NULL,
	id_edificacion integer NOT NULL,
	desc_sector_edificacion varchar(250) NOT NULL,
	es_actual boolean NOT NULL,
	fecha_inicio date NOT NULL,
	fecha_fin date NOT NULL,
	CONSTRAINT Sector_Edificacion_pk PRIMARY KEY (id_sector,id_edificacion),
	CONSTRAINT Fecha_edificacion_ck CHECK (fecha_fin > fecha_inicio)
)
TABLESPACE avaluosdb_default;
-- ddl-end --
COMMENT ON TABLE avaluo_schema.Sector_Edificacion IS E'Tabla de rompimiento entre sector y edificación.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Sector_Edificacion.desc_sector_edificacion IS E'Descripción de la edificación en el sector.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Sector_Edificacion.es_actual IS E'Verifica si la edificación en el sector se encuentra actualmente activa.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Sector_Edificacion.fecha_inicio IS E'Fecha de inicio de una edificación dada en un sector.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Sector_Edificacion.fecha_fin IS E'Fecha final de una edificación dada en un sector.';
-- ddl-end --
COMMENT ON CONSTRAINT Fecha_edificacion_ck ON avaluo_schema.Sector_Edificacion  IS E'Verifica que la fecha final sea mayor que la inicial.';
-- ddl-end --
ALTER TABLE avaluo_schema.Sector_Edificacion OWNER TO db_avaluos_admin;
-- ddl-end --

-- object: Sector_fk | type: CONSTRAINT --
-- ALTER TABLE avaluo_schema.Sector_Edificacion DROP CONSTRAINT IF EXISTS Sector_fk CASCADE;
ALTER TABLE avaluo_schema.Sector_Edificacion ADD CONSTRAINT Sector_fk FOREIGN KEY (id_sector)
REFERENCES avaluo_schema.Sector (id_sector) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: Edificacion_fk | type: CONSTRAINT --
-- ALTER TABLE avaluo_schema.Sector_Edificacion DROP CONSTRAINT IF EXISTS Edificacion_fk CASCADE;
ALTER TABLE avaluo_schema.Sector_Edificacion ADD CONSTRAINT Edificacion_fk FOREIGN KEY (id_edificacion)
REFERENCES avaluo_schema.Edificacion (id_edificacion) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: avaluo_schema.Via_Sector | type: TABLE --
-- DROP TABLE IF EXISTS avaluo_schema.Via_Sector;
CREATE TABLE avaluo_schema.Via_Sector (
	id_via integer NOT NULL,
	id_sector integer NOT NULL,
	es_actual boolean NOT NULL,
	fecha_inicio date NOT NULL,
	fecha_fin date NOT NULL,
	CONSTRAINT Via_Sector_pk PRIMARY KEY (id_via,id_sector),
	CONSTRAINT Fecha_via_ck CHECK (fecha_fin > fecha_inicio)
)
TABLESPACE avaluosdb_default;
-- ddl-end --
COMMENT ON TABLE avaluo_schema.Via_Sector IS E'Tabla de rompimiento entre Sector y Vía de Acceso.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Via_Sector.es_actual IS E'Verifica que la vía de acceso dada un sector se encuentre activa.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Via_Sector.fecha_inicio IS E'Fecha de inicio de la vía de acceso a un sector dado.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Via_Sector.fecha_fin IS E'Fecha final de la vía de acceso dado un sector.';
-- ddl-end --
COMMENT ON CONSTRAINT Fecha_via_ck ON avaluo_schema.Via_Sector  IS E'Verifica que la fecha final sea mayor que la inicial.';
-- ddl-end --
ALTER TABLE avaluo_schema.Via_Sector OWNER TO db_avaluos_admin;
-- ddl-end --

-- object: Via_Acceso_fk | type: CONSTRAINT --
-- ALTER TABLE avaluo_schema.Via_Sector DROP CONSTRAINT IF EXISTS Via_Acceso_fk CASCADE;
ALTER TABLE avaluo_schema.Via_Sector ADD CONSTRAINT Via_Acceso_fk FOREIGN KEY (id_via)
REFERENCES avaluo_schema.Via_Acceso (id_via) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: Sector_fk | type: CONSTRAINT --
-- ALTER TABLE avaluo_schema.Via_Sector DROP CONSTRAINT IF EXISTS Sector_fk CASCADE;
ALTER TABLE avaluo_schema.Via_Sector ADD CONSTRAINT Sector_fk FOREIGN KEY (id_sector)
REFERENCES avaluo_schema.Sector (id_sector) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: avaluo_schema.Sector_Servicio | type: TABLE --
-- DROP TABLE IF EXISTS avaluo_schema.Sector_Servicio;
CREATE TABLE avaluo_schema.Sector_Servicio (
	id_servicio integer NOT NULL,
	id_sector integer NOT NULL,
	es_actual boolean NOT NULL,
	fecha_inicio date NOT NULL,
	fecha_fin date NOT NULL,
	CONSTRAINT Sector_Servicio_pk PRIMARY KEY (id_servicio,id_sector),
	CONSTRAINT Fecha_servicio_ck CHECK (fecha_fin > fecha_inicio)
)
TABLESPACE avaluosdb_default;
-- ddl-end --
COMMENT ON TABLE avaluo_schema.Sector_Servicio IS E'Tabla de rompimiento entre Sector y Servicio.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Sector_Servicio.es_actual IS E'Verifica que el servicio se esté prestando actualmente en el sector.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Sector_Servicio.fecha_inicio IS E'Fecha de inicio de prestación de servicio en el barrio.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Sector_Servicio.fecha_fin IS E'Fecha final de prestación de servicio en el barrio.';
-- ddl-end --
COMMENT ON CONSTRAINT Fecha_servicio_ck ON avaluo_schema.Sector_Servicio  IS E'Verifica que la fecha final sea mayor que la inicial.';
-- ddl-end --
ALTER TABLE avaluo_schema.Sector_Servicio OWNER TO db_avaluos_admin;
-- ddl-end --

-- object: Servicio_fk | type: CONSTRAINT --
-- ALTER TABLE avaluo_schema.Sector_Servicio DROP CONSTRAINT IF EXISTS Servicio_fk CASCADE;
ALTER TABLE avaluo_schema.Sector_Servicio ADD CONSTRAINT Servicio_fk FOREIGN KEY (id_servicio)
REFERENCES avaluo_schema.Servicio (id_servicio) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: Sector_fk | type: CONSTRAINT --
-- ALTER TABLE avaluo_schema.Sector_Servicio DROP CONSTRAINT IF EXISTS Sector_fk CASCADE;
ALTER TABLE avaluo_schema.Sector_Servicio ADD CONSTRAINT Sector_fk FOREIGN KEY (id_sector)
REFERENCES avaluo_schema.Sector (id_sector) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: avaluo_schema.Estrato_Sector | type: TABLE --
-- DROP TABLE IF EXISTS avaluo_schema.Estrato_Sector;
CREATE TABLE avaluo_schema.Estrato_Sector (
	id_estrato integer NOT NULL,
	id_sector integer NOT NULL,
	es_actual boolean NOT NULL,
	fecha_inicio date NOT NULL,
	fecha_fin date NOT NULL,
	CONSTRAINT Estrato_Sector_pk PRIMARY KEY (id_estrato,id_sector),
	CONSTRAINT Fecha_estrato_ck CHECK (fecha_fin > fecha_inicio)
)
TABLESPACE avaluosdb_default;
-- ddl-end --
COMMENT ON TABLE avaluo_schema.Estrato_Sector IS E'Tabla de rompimiento entre Estrato y Sector';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Estrato_Sector.es_actual IS E'Determina si el estrato del sector es el actual.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Estrato_Sector.fecha_inicio IS E'Determina la fecha en la que el estrato para el sector se estableció.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Estrato_Sector.fecha_fin IS E'Determina la fecha en la que el estrato para el sector terminó.';
-- ddl-end --
COMMENT ON CONSTRAINT Fecha_estrato_ck ON avaluo_schema.Estrato_Sector  IS E'Verifica que la fecha final sea mayor que la inicial.';
-- ddl-end --
ALTER TABLE avaluo_schema.Estrato_Sector OWNER TO db_avaluos_admin;
-- ddl-end --

-- object: Estrato_fk | type: CONSTRAINT --
-- ALTER TABLE avaluo_schema.Estrato_Sector DROP CONSTRAINT IF EXISTS Estrato_fk CASCADE;
ALTER TABLE avaluo_schema.Estrato_Sector ADD CONSTRAINT Estrato_fk FOREIGN KEY (id_estrato)
REFERENCES avaluo_schema.Estrato (id_estrato) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: Sector_fk | type: CONSTRAINT --
-- ALTER TABLE avaluo_schema.Estrato_Sector DROP CONSTRAINT IF EXISTS Sector_fk CASCADE;
ALTER TABLE avaluo_schema.Estrato_Sector ADD CONSTRAINT Sector_fk FOREIGN KEY (id_sector)
REFERENCES avaluo_schema.Sector (id_sector) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: avaluo_schema.Cardinalidad | type: TABLE --
-- DROP TABLE IF EXISTS avaluo_schema.Cardinalidad;
CREATE TABLE avaluo_schema.Cardinalidad (
	id_cardinalidad serial NOT NULL,
	cardinalidad varchar(10) NOT NULL,
	CONSTRAINT Cardinalidad_pk PRIMARY KEY (id_cardinalidad),
	CONSTRAINT Cardinalidad_ck CHECK (cardinalidad IN ('Occidente', 'Oriente', 'Norte', 'Sur'))
)
TABLESPACE avaluosdb_default;
-- ddl-end --
COMMENT ON TABLE avaluo_schema.Cardinalidad IS E'Cardinalidad que existe en cada delimitación de un sector.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Cardinalidad.id_cardinalidad IS E'Identificador único de la cardinalidad de una delimitación en la BD.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Cardinalidad.cardinalidad IS E'Cardinalidad de la demilitación.';
-- ddl-end --
ALTER TABLE avaluo_schema.Cardinalidad OWNER TO db_avaluos_admin;
-- ddl-end --

-- object: avaluo_schema.Cardinalidad_Delimitacion | type: TABLE --
-- DROP TABLE IF EXISTS avaluo_schema.Cardinalidad_Delimitacion;
CREATE TABLE avaluo_schema.Cardinalidad_Delimitacion (
	id_delimitacion integer NOT NULL,
	id_cardinalidad integer NOT NULL,
	direccion_delimitacion varchar(50) NOT NULL,
	sector_delimitacion varchar(30),
	descripcion varchar(100) NOT NULL,
	CONSTRAINT Cardinalidad_Delimitacion_pk PRIMARY KEY (id_delimitacion,id_cardinalidad)
)
TABLESPACE avaluosdb_default;
-- ddl-end --
COMMENT ON TABLE avaluo_schema.Cardinalidad_Delimitacion IS E'Tabla de rompimiento entre cardinalidad y delimitación.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Cardinalidad_Delimitacion.direccion_delimitacion IS E'Dirección correspondiente a la delimitación dada una cardinalidad.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Cardinalidad_Delimitacion.sector_delimitacion IS E'Sector asociado a una delimitación dada su cardinalidad.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Cardinalidad_Delimitacion.descripcion IS E'Descripción de la delimitación dada su cardinalidad.';
-- ddl-end --
ALTER TABLE avaluo_schema.Cardinalidad_Delimitacion OWNER TO db_avaluos_admin;
-- ddl-end --

-- object: Delimitacion_fk | type: CONSTRAINT --
-- ALTER TABLE avaluo_schema.Cardinalidad_Delimitacion DROP CONSTRAINT IF EXISTS Delimitacion_fk CASCADE;
ALTER TABLE avaluo_schema.Cardinalidad_Delimitacion ADD CONSTRAINT Delimitacion_fk FOREIGN KEY (id_delimitacion)
REFERENCES avaluo_schema.Delimitacion (id_delimitacion) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: Cardinalidad_fk | type: CONSTRAINT --
-- ALTER TABLE avaluo_schema.Cardinalidad_Delimitacion DROP CONSTRAINT IF EXISTS Cardinalidad_fk CASCADE;
ALTER TABLE avaluo_schema.Cardinalidad_Delimitacion ADD CONSTRAINT Cardinalidad_fk FOREIGN KEY (id_cardinalidad)
REFERENCES avaluo_schema.Cardinalidad (id_cardinalidad) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: avaluo_schema.Sector_Delimitacion | type: TABLE --
-- DROP TABLE IF EXISTS avaluo_schema.Sector_Delimitacion;
CREATE TABLE avaluo_schema.Sector_Delimitacion (
	id_sector integer NOT NULL,
	id_delimitacion integer NOT NULL,
	id_cardinalidad integer NOT NULL,
	es_actual boolean NOT NULL,
	fecha_inicial date NOT NULL,
	fecha_fin date NOT NULL,
	CONSTRAINT Sector_Delimitacion_pk PRIMARY KEY (id_sector,id_delimitacion,id_cardinalidad),
	CONSTRAINT Fecha_delimitacion_ck CHECK (fecha_fin > fecha_inicial)
)
TABLESPACE avaluosdb_default;
-- ddl-end --
COMMENT ON TABLE avaluo_schema.Sector_Delimitacion IS E'Tabla de rompimiento entre Sector y Cardinalidad_Delimitación';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Sector_Delimitacion.es_actual IS E'Verifica si la delimitación es la actual dada un sector.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Sector_Delimitacion.fecha_inicial IS E'Fecha inicial de la delimitación dado un sector.';
-- ddl-end --
COMMENT ON COLUMN avaluo_schema.Sector_Delimitacion.fecha_fin IS E'Fecha final de la delimitación dado un sector.';
-- ddl-end --
COMMENT ON CONSTRAINT Fecha_delimitacion_ck ON avaluo_schema.Sector_Delimitacion  IS E'Verifica que la fecha final sea mayor que la inicial.';
-- ddl-end --
ALTER TABLE avaluo_schema.Sector_Delimitacion OWNER TO db_avaluos_admin;
-- ddl-end --

-- object: Sector_fk | type: CONSTRAINT --
-- ALTER TABLE avaluo_schema.Sector_Delimitacion DROP CONSTRAINT IF EXISTS Sector_fk CASCADE;
ALTER TABLE avaluo_schema.Sector_Delimitacion ADD CONSTRAINT Sector_fk FOREIGN KEY (id_sector)
REFERENCES avaluo_schema.Sector (id_sector) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: Cardinalidad_Delimitacion_fk | type: CONSTRAINT --
-- ALTER TABLE avaluo_schema.Sector_Delimitacion DROP CONSTRAINT IF EXISTS Cardinalidad_Delimitacion_fk CASCADE;
ALTER TABLE avaluo_schema.Sector_Delimitacion ADD CONSTRAINT Cardinalidad_Delimitacion_fk FOREIGN KEY (id_delimitacion,id_cardinalidad)
REFERENCES avaluo_schema.Cardinalidad_Delimitacion (id_delimitacion,id_cardinalidad) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

ALTER TABLE avaluo_schema.entidad DROP CONSTRAINT tipo_identificacion_ck;
ALTER TABLE avaluo_schema.entidad ADD CONSTRAINT Tipo_identificacion_ck CHECK (tipo_identificacion IN ('CC', 'CE', 'PAP', 'NIT'));

ALTER TABLE avaluo_schema.cardinalidad_delimitacion ALTER COLUMN sector_delimitacion TYPE VARCHAR(100);
ALTER TABLE avaluo_schema.cardinalidad_delimitacion ALTER COLUMN direccion_delimitacion TYPE VARCHAR(100);

-- Insertar una entidad
INSERT INTO avaluo_schema.entidad (identificacion_entidad, tipo_identificacion, telefono_entidad, correo_entidad)
    VALUES ('830055995', 'NIT', 0912485016, 'dac@metrovivienda.gov.co');

-- Insertar una empresa
INSERT INTO avaluo_schema.empresa (id_entidad, camara_comercio, nombre_empresa, razon_social)
    VALUES ((
            SELECT
                id_entidad
            FROM
                avaluo_schema.entidad
            WHERE
                identificacion_entidad = '830055995'), '4615C0AQS4', 'Metrovivienda', 'Actividades inmobiliarias realizadas con bienes propios o arrendados');

-- Insertar un sector
INSERT INTO avaluo_schema.sector (id_sector, codigo_sector, desc_sector, actividad_predominante)
    VALUES (1, '004598 - VILLA ANNY I', 'Sector Villa Anny I', 'Residencial');

-- Insertar una delimitación
INSERT INTO avaluo_schema.delimitacion (id_delimitacion, descripcion)
    VALUES (1, 'Úbicado en el suroccidente de la ciudad en la localidad de Bosa.')
    --Insertar todas las cardinalidades
    INSERT INTO avaluo_schema.cardinalidad (cardinalidad)
        VALUES ('Norte');

INSERT INTO avaluo_schema.cardinalidad (cardinalidad)
    VALUES ('Sur');

INSERT INTO avaluo_schema.cardinalidad (cardinalidad)
    VALUES ('Oriente');

INSERT INTO avaluo_schema.cardinalidad (cardinalidad)
    VALUES ('Occidente');

-- Insertar la delimitación de un sector
INSERT INTO avaluo_schema.cardinalidad_delimitacion (id_delimitacion, id_cardinalidad, direccion_delimitacion, sector_delimitacion, descripcion)
    VALUES (1, (
            SELECT
                id_cardinalidad
            FROM avaluo_schema.cardinalidad
            WHERE
                cardinalidad = 'Norte'), 'Diagonales 73D Sur, 73D Bis Sur y 73D Bis Sur', 'Charles Gaulle, San Bernardino', 'N/A');

INSERT INTO avaluo_schema.cardinalidad_delimitacion (id_delimitacion, id_cardinalidad, direccion_delimitacion, sector_delimitacion, descripcion)
    VALUES (1, (
            SELECT
                id_cardinalidad
            FROM avaluo_schema.cardinalidad
            WHERE
                cardinalidad = 'Sur'), 'Transversal 82B. Diagonal 73B Sur y Carrera 78', NULL, 'Limita con el municipio de Soacha');

INSERT INTO avaluo_schema.cardinalidad_delimitacion (id_delimitacion, id_cardinalidad, direccion_delimitacion, sector_delimitacion, descripcion)
    VALUES (1, (
            SELECT
                id_cardinalidad
            FROM avaluo_schema.cardinalidad
            WHERE
                cardinalidad = 'Oriente'), 'Transversal 83 y Calles 73A Sur y 74 Sur', 'José María Carbonell y El Retazo', 'N/A');

INSERT INTO avaluo_schema.cardinalidad_delimitacion (id_delimitacion, id_cardinalidad, direccion_delimitacion, sector_delimitacion, descripcion)
    VALUES (1, (
            SELECT
                id_cardinalidad
            FROM avaluo_schema.cardinalidad
            WHERE
                cardinalidad = 'Occidente'), 'N/A', NULL, 'Limita con el municipio de Soacha');

INSERT INTO avaluo_schema.sector_delimitacion (id_sector, id_delimitacion, id_cardinalidad, es_actual, fecha_inicial, fecha_fin)
    VALUES (1, 1, (
            SELECT
                id_cardinalidad
            FROM avaluo_schema.cardinalidad
            WHERE
                cardinalidad = 'Norte'), TRUE, TO_DATE('07/10/2015', 'DD/MM/YYYY'), TO_DATE('07/10/9999', 'DD/MM/YYYY'));

INSERT INTO avaluo_schema.sector_delimitacion (id_sector, id_delimitacion, id_cardinalidad, es_actual, fecha_inicial, fecha_fin)
    VALUES (1, 1, (
            SELECT
                id_cardinalidad
            FROM avaluo_schema.cardinalidad
            WHERE
                cardinalidad = 'Sur'), TRUE, TO_DATE('07/10/2015', 'DD/MM/YYYY'), TO_DATE('07/10/9999', 'DD/MM/YYYY'));

INSERT INTO avaluo_schema.sector_delimitacion (id_sector, id_delimitacion, id_cardinalidad, es_actual, fecha_inicial, fecha_fin)
    VALUES (1, 1, (
            SELECT
                id_cardinalidad
            FROM avaluo_schema.cardinalidad
            WHERE
                cardinalidad = 'Oriente'), TRUE, TO_DATE('07/10/2015', 'DD/MM/YYYY'), TO_DATE('07/10/9999', 'DD/MM/YYYY'));

INSERT INTO avaluo_schema.sector_delimitacion (id_sector, id_delimitacion, id_cardinalidad, es_actual, fecha_inicial, fecha_fin)
    VALUES (1, 1, (
            SELECT
                id_cardinalidad
            FROM avaluo_schema.cardinalidad
            WHERE
                cardinalidad = 'Occidente'), TRUE, TO_DATE('07/10/2015', 'DD/MM/YYYY'), TO_DATE('07/10/9999', 'DD/MM/YYYY'));

-- Insertar todos los estratos
INSERT INTO avaluo_schema.estrato (id_estrato, num_estrato)
    VALUES (1, 1);

INSERT INTO avaluo_schema.estrato (id_estrato, num_estrato)
    VALUES (2, 2);

INSERT INTO avaluo_schema.estrato (id_estrato, num_estrato)
    VALUES (3, 3);

INSERT INTO avaluo_schema.estrato (id_estrato, num_estrato)
    VALUES (4, 4);

INSERT INTO avaluo_schema.estrato (id_estrato, num_estrato)
    VALUES (5, 5);

INSERT INTO avaluo_schema.estrato (id_estrato, num_estrato)
    VALUES (6, 6);

-- Insertar el estrato de un sector
INSERT INTO avaluo_schema.estrato_sector (id_estrato, id_sector, es_actual, fecha_inicio, fecha_fin)
    VALUES (1, 1, TRUE, TO_DATE('07/10/2015', 'DD/MM/YYYY'), TO_DATE('07/10/9999', 'DD/MM/YYYY'));

-- Insertar todos los servicios
INSERT INTO avaluo_schema.servicio (id_servicio, nombre_servicio, descripcion_servicio)
    VALUES (1, 'Acueducto', 'Sistema de alcantarillado y acueducto');

INSERT INTO avaluo_schema.servicio (id_servicio, nombre_servicio, descripcion_servicio)
    VALUES (2, 'Electricidad', 'Servicio de energía eléctrica');

INSERT INTO avaluo_schema.servicio (id_servicio, nombre_servicio, descripcion_servicio)
    VALUES (3, 'Gas', 'Servicio de gas natural');

INSERT INTO avaluo_schema.servicio (id_servicio, nombre_servicio, descripcion_servicio)
    VALUES (4, 'Teléfono', 'Servicio de telefonía fija');

INSERT INTO avaluo_schema.servicio (id_servicio, nombre_servicio, descripcion_servicio)
    VALUES (5, 'Alumbrado', 'Alumbrado público');

INSERT INTO avaluo_schema.servicio (id_servicio, nombre_servicio, descripcion_servicio)
    VALUES (6, 'Aseo', 'Servicio de aseo y recolección de basuras');

INSERT INTO avaluo_schema.servicio (id_servicio, nombre_servicio, descripcion_servicio)
    VALUES (7, 'Transporte', 'Servicio de transporte');

DELETE FROM avaluo_schema.servicio;

-- Insertar los servicios de un sector
INSERT INTO avaluo_schema.sector_servicio (id_servicio, id_sector, es_actual, fecha_inicio, fecha_fin)
    VALUES (1, 1, TRUE, TO_DATE('07/10/2015', 'DD/MM/YYYY'), TO_DATE('07/10/9999', 'DD/MM/YYYY'));

INSERT INTO avaluo_schema.sector_servicio (id_servicio, id_sector, es_actual, fecha_inicio, fecha_fin)
    VALUES (2, 1, TRUE, TO_DATE('07/10/2015', 'DD/MM/YYYY'), TO_DATE('07/10/9999', 'DD/MM/YYYY'));

INSERT INTO avaluo_schema.sector_servicio (id_servicio, id_sector, es_actual, fecha_inicio, fecha_fin)
    VALUES (3, 1, TRUE, TO_DATE('07/10/2015', 'DD/MM/YYYY'), TO_DATE('07/10/9999', 'DD/MM/YYYY'));

INSERT INTO avaluo_schema.sector_servicio (id_servicio, id_sector, es_actual, fecha_inicio, fecha_fin)
    VALUES (4, 1, TRUE, TO_DATE('07/10/2015', 'DD/MM/YYYY'), TO_DATE('07/10/9999', 'DD/MM/YYYY'));

INSERT INTO avaluo_schema.sector_servicio (id_servicio, id_sector, es_actual, fecha_inicio, fecha_fin)
    VALUES (5, 1, TRUE, TO_DATE('07/10/2015', 'DD/MM/YYYY'), TO_DATE('07/10/9999', 'DD/MM/YYYY'));

INSERT INTO avaluo_schema.sector_servicio (id_servicio, id_sector, es_actual, fecha_inicio, fecha_fin)
    VALUES (6, 1, TRUE, TO_DATE('07/10/2015', 'DD/MM/YYYY'), TO_DATE('07/10/9999', 'DD/MM/YYYY'));

INSERT INTO avaluo_schema.sector_servicio (id_servicio, id_sector, es_actual, fecha_inicio, fecha_fin)
    VALUES (7, 1, TRUE, TO_DATE('07/10/2015', 'DD/MM/YYYY'), TO_DATE('07/10/9999', 'DD/MM/YYYY'));

--Insertar vías de acceso
INSERT INTO avaluo_schema.via_acceso (id_via, direccion_via, descripcion_via)
    VALUES (1, 'Transversal 79D', 'Vía pavimentada en aceptable estado de conservación y mantenimiento');

INSERT INTO avaluo_schema.via_acceso (id_via, direccion_via, descripcion_via)
    VALUES (2, 'Calle 74S', 'Vía pavimentada en aceptable estado de conservación y mantenimiento');

-- Insertar vías a un sector
INSERT INTO avaluo_schema.via_sector (id_via, id_sector, es_actual, fecha_inicio, fecha_fin)
    VALUES (1, 1, TRUE, TO_DATE('07/10/2015', 'DD/MM/YYYY'), TO_DATE('07/10/9999', 'DD/MM/YYYY'));

INSERT INTO avaluo_schema.via_sector (id_via, id_sector, es_actual, fecha_inicio, fecha_fin)
    VALUES (2, 1, TRUE, TO_DATE('07/10/2015', 'DD/MM/YYYY'), TO_DATE('07/10/9999', 'DD/MM/YYYY'));

-- Insertar edificación
INSERT INTO avaluo_schema.edificacion (id_edificacion, nivel_edificacion, descripcion_edificacion)
    VALUES (1, 'Mediana', 'Nivel de edificación mediano .');

-- Insertar la edificación de un sector.
INSERT INTO avaluo_schema.sector_edificacion (id_sector, id_edificacion, desc_sector_edificacion, es_actual, fecha_inicio, fecha_fin)
    VALUES (1, 1, 'Dirigida a remodelación y/o adecuación de algunos inmuebles deteriorados y la construccin de algunos proyectos de vivienda.', TRUE, TO_DATE('07/10/2015', 'DD/MM/YYYY'), TO_DATE('07/10/9999', 'DD/MM/YYYY'));

-- Insertar un inmueble
INSERT INTO avaluo_schema.inmueble (id_inmueble, id_sector, id_entidad, cedula_catastral, chip_inmueble, matricula_inmobiliaria, area_inmueble, tipo_inmueble, destino_economico, valor_inmueble)
    VALUES (1, 1, 1, 'BS U 17360', 'AAA0140DCJH', '50S-40109227', 2002.7, 'LOTE DE TERRENO', 'Ninguna', 672783220);

-- Insertar la dirección de un inmueble
INSERT INTO avaluo_schema.direccion (id_direccion, id_inmueble, direccion, barrio, municipio, es_actual, fecha_inicio, fecha_fin)
    VALUES (1, 1, 'kr 79 BIS A 73D 20 SUR', 'Villa Anny', 'Soacha', TRUE, TO_DATE('07/10/2015', 'DD/MM/YYYY'), TO_DATE('07/10/9999', 'DD/MM/YYYY'));

-- Crear un avalúo para el inmueble
INSERT INTO avaluo_schema.avaluo (id_avaluo, id_inmueble, id_entidad, num_radicado, fecha_solicitud_avaluo, fecha_expedicion_avaluo, costo_avaluo, proposito_avaluo)
    VALUES (1, 1, 1, '2015-839461', TO_DATE('07/10/2015', 'DD/MM/YYYY'), (
            SELECT
                CURRENT_DATE),
            1000000,
            'Comercial');

