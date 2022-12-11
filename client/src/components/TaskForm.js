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

const TaskForm = () => {

  // crea las entidades
  const [entity, setEntity] = useState({
    id_entidad: "",
    identificacion_entidad: "",
    tipo_identificacion: "",
    telefono_entidad: "",
    correo_entidad: "",

  });
  //crea los clientes
  const [client, setClient] = useState({
    id_entidad: "",
    primer_nombre: "",
    segundo_nombre: "",
    primer_apellido: "",
    segundo_apellido: "",
    fecha_nacimiento: "",

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
        client.id_entidad = entity.id_entidad;
        setClient(client);
        // client.fecha_nacimiento = Date(client.fecha_nacimiento);
        console.log(client)
        const response3 = await fetch("http://localhost:4000/createClient", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(client),
        });
        await response3.json();

      }

      setLoading(false);
      // navigate("/clients");
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

  return (
    <Grid
      container
      alignItems="center"
      direction="column"
      justifyContent="center"
    >
      <h1>{entity.id_entidad}</h1>
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


              <TextField
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
              />
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
                placeholder='primer nombre'
                variant="filled"
                // label=""
                sx={{
                  display: "block",
                  margin: ".5rem 0",
                }}
                name="primer_nombre"
                onChange={handleChange}
                value={client.primer_nombre}
                inputProps={{ style: { color: "white" } }}
                InputLabelProps={{ style: { color: "white" } }}
              />

              <TextField
                placeholder='Segundo nombre'
                variant="filled"
                // label=""
                sx={{
                  display: "block",
                  margin: ".5rem 0",
                }}
                name="segundo_nombre"
                onChange={handleChange}
                value={client.segundo_nombre}
                inputProps={{ style: { color: "white" } }}
                InputLabelProps={{ style: { color: "white" } }}
              />

              <TextField
                placeholder='Primer apellido'
                variant="filled"
                // label=""
                sx={{
                  display: "block",
                  margin: ".5rem 0",
                }}
                name="primer_apellido"
                onChange={handleChange}
                value={client.primer_apellido}
                inputProps={{ style: { color: "white" } }}
                InputLabelProps={{ style: { color: "white" } }}
              />


              <TextField
                placeholder='Segundo apellido'
                variant="filled"
                // label=""
                sx={{
                  display: "block",
                  margin: ".5rem 0",
                }}
                name="segundo_apellido"
                onChange={handleChange}
                value={client.segundo_apellido}
                inputProps={{ style: { color: "white" } }}
                InputLabelProps={{ style: { color: "white" } }}
              />

              <TextField
                placeholder='Fecha de nacimiento'
                variant="filled"
                // label=""
                sx={{
                  display: "block",
                  margin: ".5rem 0",
                }}
                name="fecha_nacimiento"
                onChange={handleChange}
                value={client.fecha_nacimiento}
                inputProps={{ style: { color: "white" } }}
                InputLabelProps={{ style: { color: "white" } }}
              />
              <Button
                type="submit"
                variant="contained"
                color="primary"
                disabled={!entity.identificacion_entidad || !entity.tipo_identificacion || !entity.telefono_entidad || !entity.correo_entidad || !client.primer_apellido || 
                !client.segundo_nombre || !client.primer_apellido || !client.segundo_apellido || !client.fecha_nacimiento }

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
