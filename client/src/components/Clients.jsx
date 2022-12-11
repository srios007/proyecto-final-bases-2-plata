import {
    Button,
    Card,
    CardContent,
    Typography,
} from "@mui/material";
import React, { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom";

const Clients = () => {
    const [clients, setClient] = useState([]);
    const navigate = useNavigate();

    const loadClient = async () => {
        const response = await fetch("http://localhost:4000/clients");
        const data = await response.json();
        console.log(data)
        // comentar esto en caso de daño
        setClient(data);
    };

    useEffect(() => {
        loadClient();
    }, []);

    return (
        <>
            <h1>Clientes</h1>
            {
                clients.map((clients) => (
                    <Card
                        style={{
                            marginBottom: ".7rem",
                            backgroundColor: "#1e272e",
                        }}
                    >
                        <CardContent
                            style={{
                                display: "flex",
                                justifyContent: "space-between",
                            }}
                        >
                            <div
                                style={{
                                    color: "white",
                                }}
                            >
                                {/* <Typography>{+clients.id_entidad}</Typography> */}
                                <Typography>{"Cámara de comercio: " + clients.camara_comercio}</Typography>
                                {/* <Typography>{clients.segundo_nombre}</Typography> */}
                                <Typography>{"Nombre: " + clients.nombre_empresa}</Typography>
                                {/* <Typography>{clients.segundo_apellido}</Typography> */}
                                <Typography>{"Razón social: " + clients.razon_social}</Typography>
                            </div>
                            <div>
                                <Button
                                    variant="contained"
                                    color="inherit"
                                    onClick={() => navigate(`/clients/${clients.id_entidad}/edit`)}
                                >
                                    Editar
                                </Button>
                            </div>
                        </CardContent>
                    </Card>
                ))
            }
        </>
    );
};

export default Clients;


