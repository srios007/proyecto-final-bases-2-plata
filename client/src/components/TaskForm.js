import {
  Button,
  Card,
  CardContent,
  CircularProgress,
  Grid,
  TextField,
  Typography,
} from "@mui/material";
import React, { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom";
import { ComboBox } from 'react-widgets/Combobox';
import Select from 'react-select';


const TaskForm = () => {

  // crea las entidades
  const [entity, setEntity] = useState({
    id_entidad: "",
    identificacion_entidad: "",
    tipo_identificacion: "NIT",
    telefono_entidad: "",
    correo_entidad: "",

  });
  //crea los clientes
  const [client, setClient] = useState({
    id_entidad: "",
    camara_comercio: "",
    nombre_empresa: "",
    razon_social: "",

  });

  const [loading, setLoading] = useState(false);
  const [editing, setEditing] = useState(false);

  const navigate = useNavigate();
  // const params = useParams();

  // useEffect(() => {
  //   if (params.id) {
  //     loadTask(params.id);
  //   }
  // }, [params.id]);

  // const loadTask = async (id) => {
  //   const res = await fetch("http://localhost:4000/tasks/" + id);
  //   const data = await res.json();
  //   setTask({ title: data.title, description: data.description });
  //   setEditing(true);
  // };

  // const handleSubmit = async (event) => {
  //   event.preventDefault();
  //   setLoading(true);
  //   try {
  //     if (editing) {
  //       const response = await fetch(
  //         "http://localhost:4000/tasks/" + params.id,
  //         {
  //           method: "PUT",
  //           headers: { "Content-Type": "application/json" },
  //           body: JSON.stringify(task),
  //         }
  //       );
  //       await response.json();
  //     } else {
  //       const response = await fetch("http://localhost:4000/createClient", {
  //         method: "POST",
  //         headers: { "Content-Type": "application/json" },
  //         body: JSON.stringify(task),
  //       });
  //       await response.json();
  //     }

  //     setLoading(false);
  //     navigate("/");
  //   } catch (error) {
  //     console.error(error);
  //   }
  // };


  const handleSubmitClient = async (event) => {
    event.preventDefault();
    console.log("first");
    setLoading(true);
    try {
      if (editing) {

      } else {
        entity.telefono_entidad = parseInt(entity.telefono_entidad);

        console.log(JSON.stringify(entity));

        const response = await fetch("http://localhost:4000/createEntity", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(entity),
        });
        await response.json();

        const response2 = await fetch("http://localhost:4000/entity/" + entity.correo_entidad);
        const data2 = await response2.json();
        console.log(data2);

        // comentar esto en caso de daño
        setEntity(data2);
        client.id_entidad = data2.id_entidad;
        setClient(client);
        // client.fecha_nacimiento = Date(client.fecha_nacimiento);
        console.log(client);
        console.log("first");
        const response3 = await fetch("http://localhost:4000/createClient", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(client),
        });
        await response3.json();

      }

      setLoading(false);
      navigate("/clients");
    } catch (error) {
      console.error(error);

    }
  };
  const handleChange = (e) => {
    console.log(e.target.name);
    console.log(e.target.value);
    setEntity({ ...entity, [e.target.name]: e.target.value });
    setClient({ ...client, [e.target.name]: e.target.value });
  };
  const handleSelect = (e) => {
    console.log(e);
    console.log(e.label);
    entity.tipo_identificacion = e.label;
    setEntity(entity);
  };
  const options = [
    { value: 'CC', label: 'CC' },
    { value: 'NIT', label: 'NIT' },
    { value: 'PAP', label: 'PAP' },
    { value: 'CE', label: 'CE' }
  ]

  return (
    <Grid
      container
      alignItems="center"
      direction="column"
      justifyContent="center"
    >
      <Grid item xs={3}>
        <Card
          sx={{ mt: 5 }}
          style={{
            backgroundColor: "#1E272E",
            padding: "1rem",
          }}
        >
          <Typography variant="h5" textAlign="center" color="white">
            {editing ? "Update Task" : "Crear cliente"}
          </Typography>
          <CardContent>
            <form onSubmit={handleSubmitClient}>
              
              <Select
                className="basic-single"
                classNamePrefix="select"
                defaultValue={options[1]}
                isDisabled={false}
                isLoading={false}
                isClearable={false}
                isRtl={false}
                isSearchable={true}
                name="color"
                options={options}
                onChange={handleSelect}
              />
              
              
              {/* <Select options={options} 
               defaultValue={options[1]}
               placeholder="tipo de identificación"
               name="tipo_identificacion"
               onChange={handleSelect}
               value={entity.tipo_identificacion}
               inputProps={{ style: { color: "white" } }}
               InputLabelProps={{ style: { color: "white" } }}
              
              /> */}
                

              {/* <ComboBox
                defaultValue="NIT"
                data={["CC", "CE", "PAP", "NIT"]}
                name="tipo_identificacion"
                onChange={handleChange}
                value={entity.tipo_identificacion}
                inputProps={{ style: { color: "white" } }}
                InputLabelProps={{ style: { color: "white" } }}
              />; */}
              {/* <TextField
                placeholder="Tipo de identificación"
                variant="filled"
                label=""
                sx={{
                  display: "block",
                  margin: ".5rem 0",
                }}
                name="tipo_identificacion"
                onChange={handleChange}
                value={entity.tipo_identificacion}
                inputProps={{ style: { color: "white" } }}
                InputLabelProps={{ style: { color: "white" } }}
              /> */}
              {/* <TextField
                variant="outlined"
                label=""
                multiline
                rows={4}
                sx={{
                  display: "block",
                  margin: ".5rem 0",
                }}
                name="description"
                onChange={handleChange}
                value={task.description}
                inputProps={{ style: { color: "white" } }}
                InputLabelProps={{ style: { color: "white" } }}
              /> */}

              <TextField
                placeholder="Número de identificación"
                variant="filled"
                label=""
                sx={{
                  display: "block",
                  margin: ".5rem 0",
                }}
                name="identificacion_entidad"
                onChange={handleChange}
                value={entity.identificacion_entidad}
                inputProps={{ style: { color: "white" } }}
                InputLabelProps={{ style: { color: "white" } }}
              />
              <TextField
                placeholder="Teléfono"
                variant="filled"
                label=""
                sx={{
                  display: "block",
                  margin: ".5rem 0",
                }}
                name="telefono_entidad"
                onChange={handleChange}
                value={entity.telefono_entidad}
                inputProps={{ style: { color: "white" } }}
                InputLabelProps={{ style: { color: "white" } }}
              />

              <TextField
                placeholder='Correo'
                variant="filled"
                // label=""
                sx={{
                  display: "block",
                  margin: ".5rem 0",
                }}
                name="correo_entidad"
                onChange={handleChange}
                value={entity.correo_entidad}
                inputProps={{ style: { color: "white" } }}
                InputLabelProps={{ style: { color: "white" } }}
              />

              <TextField
                placeholder='Cámara de comercio'
                variant="filled"
                // label=""
                sx={{
                  display: "block",
                  margin: ".5rem 0",
                }}
                name="camara_comercio"
                onChange={handleChange}
                value={client.camara_comercio}
                inputProps={{ style: { color: "white" } }}
                InputLabelProps={{ style: { color: "white" } }}
              />

              <TextField
                placeholder='Nombre de  la empresa'
                variant="filled"
                // label=""
                sx={{
                  display: "block",
                  margin: ".5rem 0",
                }}
                name="nombre_empresa"
                onChange={handleChange}
                value={client.nombre_empresa}
                inputProps={{ style: { color: "white" } }}
                InputLabelProps={{ style: { color: "white" } }}
              />

              <TextField
                placeholder='Razón social'
                variant="filled"
                // label=""
                sx={{
                  display: "block",
                  margin: ".5rem 0",
                }}
                name="razon_social"
                onChange={handleChange}
                value={client.razon_social}
                inputProps={{ style: { color: "white" } }}
                InputLabelProps={{ style: { color: "white" } }}
              />

              <Button
                type="submit"
                variant="contained"
                color="primary"
                disabled={!entity.identificacion_entidad || !entity.tipo_identificacion || !entity.telefono_entidad || !entity.correo_entidad || !client.camara_comercio || 
                !client.nombre_empresa || !client.razon_social }

              >
                {loading ? (
                  <CircularProgress color="inherit" size={25} />
                ) : (
                  "Guardar cliente"
                )}
              </Button>
            </form>
          </CardContent>
        </Card>
      </Grid>
    </Grid>
  );
};

export default TaskForm;
