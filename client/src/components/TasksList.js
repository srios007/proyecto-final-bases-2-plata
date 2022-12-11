import { Button, Card, CardContent, Typography } from "@mui/material";
import React, { useEffect, useState } from "react";

// import DeleteModal from "./DeleteModal";
import { useNavigate } from "react-router-dom";

const TasksList = () => {
  const [tasks, setTasks] = useState([]);
  const navigate = useNavigate();

  const loadTasks = async () => {
    const response = await fetch("http://localhost:4000/tasks");
    const data = await response.json();
    setTasks(data);
  };

  const handleDelete = async (id) => {
    try {
      await fetch(`http://localhost:4000/tasks/${id}`, {
        method: "DELETE",
      });
      setTasks(tasks.filter((task) => task.id !== id));
    } catch (error) {
      console.error(error);
    }
  };

  useEffect(() => {
    loadTasks();
  }, []);

  return (
    <>
      <h1>Avaluos</h1>
      {tasks.map((task) => (
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
              <Typography>{"Avaluo: "+task.id_avaluo}</Typography>
              {/* <Typography>{task.id_entidad}</Typography> */}
              <Typography>{"Número de radicado: "+task.num_radicado}</Typography>
              <Typography>{"Fecha de solicitud: "+task.fecha_solicitud_avaluo}</Typography>
              <Typography>{"Fecha de expedición: "+task.fecha_expedicion_avaluo}</Typography>
              <Typography>{"Costo: "+task.costo_avaluo}</Typography>
              <Typography>{"Proposito: "+task.proposito_avaluo}</Typography>
            </div>
            <div>
              
            </div>
          </CardContent>
        </Card>
      ))}
    </>
  );
};

export default TasksList;
