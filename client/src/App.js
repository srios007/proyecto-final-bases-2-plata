import { BrowserRouter, Route, Routes } from "react-router-dom";
import React, { Component }  from 'react';

import AllValuations from "./components/TasksList";
import Clients from "./components/Clients";
import { Container } from "@mui/material";
import EditClient from "./components/EditClient";
import InitialPage from "./components/InitialPage";
import Menu from "./components/Navbar";
import NewClient from "./components/TaskForm";

function App() {
  return (
    <BrowserRouter>
      <Menu />
      <Container>
        <Routes>
          {/* PÁGINA INICIAL */}
          <Route index path="/" element={<InitialPage />} />
          {/*HOME - TODOS LOS AVALUOS*/}
          <Route index path="/home" element={<AllValuations />} />
          {/*TODOS LOS CLIENTES*/}
          <Route index path="/clients" element={<Clients />} />
          {/*AGREGAR CLIENTE*/}
          <Route path="/clients/new" element={<NewClient />} />
          {/*EDITAR CLIENTE*/}
          <Route path="/clients/:id/edit" element={<EditClient />} />
        </Routes>
      </Container>
    </BrowserRouter>
  );
}

export default App;
