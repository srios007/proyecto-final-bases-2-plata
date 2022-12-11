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


  const [client, setClient] = useState({
    identificacion_entidad: "",
    tipo_identificacion: "",
    telefono_entidad: "",
    correo_entidad: "",

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
    // event.preventDefault();
    setLoading(true);
    try {
      if (editing) {

      } else {
        console.log('-------1-------');
        client.telefono_entidad = parseInt(client.telefono_entidad);
        console.log('-------2-------');

        console.log(JSON.stringify(client));
        console.log('-------3-------');

        const response = await fetch("http://localhost:4000/createClient", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(client),
        });
        await response.json();
      }

      setLoading(false);
      navigate("/clients");
    } catch (error) {
      console.error(error);
    }
  };

  const handleChange = (e) =>{   
    console.log(e.target.name);
    console.log(e.target.value);
    setClient({ ...client, [e.target.name] : e.target.value });
  };
 
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
                value={client.tipo_identificacion}
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
                value={client.identificacion_entidad}
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
                value={client.telefono_entidad}
                inputProps={{ style: { color: "white" } }}
                InputLabelProps={{ style: { color: "white" } }}
              />
          
              <TextField
              placeholder= 'Correo'
                variant="filled"
                // label=""
                sx={{
                  display: "block",
                  margin: ".5rem 0",
                }}
                name="correo_entidad"
                onChange={handleChange}
                value={client.correo_entidad}
                inputProps={{ style: { color: "white" } }}
                InputLabelProps={{ style: { color: "white" } }}
              />
              <Button
                type="submit"
                variant="contained"
                color="primary"
                disabled={!client.identificacion_entidad || !client.tipo_identificacion || !client.telefono_entidad || !client.correo_entidad}

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
