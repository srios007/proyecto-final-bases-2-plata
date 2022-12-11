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

const EditClient = () => {
  const [editing, setEditing] = useState(false);
  //crea los clientes
  const [client, setClient] = useState({
    id_entidad: "",
    camara_comercio: "",
    nombre_empresa: "",
    razon_social: "",

  });

  const [loading, setLoading] = useState(false);

  const navigate = useNavigate();
  const params = useParams();

  useEffect(() => {
    if (params.id) {
      loadTask(params.id);
    }
  }, [params.id]);

  const loadTask = async (id) => {
    const res = await fetch("http://localhost:4000/client/" + id);
    const data = await res.json();
    setClient({ 
      id_entidad: data.id_entidad, 
      camara_comercio: data.camara_comercio, 
      nombre_empresa: data.nombre_empresa, 
      razon_social: data.razon_social, 
      });
    setEditing(true);
  };

 


  const handleSubmitClient = async (event) => {
    event.preventDefault();
    console.log("first");
    setLoading(true);
    try {
      {
        const response = await fetch(
          "http://localhost:4000/client/" + params.id,
          {
            method: "PUT",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(client),
          }
        );
        await response.json();
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
    setClient({ ...client, [e.target.name]: e.target.value });
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
                placeholder='Nombre de la empresa'
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
                disabled={ 
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

export default EditClient;
