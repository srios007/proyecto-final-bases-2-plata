import * as React from "react";

import { Link, useNavigate } from "react-router-dom";

import AppBar from "@mui/material/AppBar";
import Box from "@mui/material/Box";
import Button from "@mui/material/Button";
import { Container } from "@mui/material";
import Toolbar from "@mui/material/Toolbar";
import Typography from "@mui/material/Typography";

export default function ButtonAppBar() {
  const navigate = useNavigate();

  return (
    <Box sx={{ flexGrow: 1 }}>
      <AppBar position="static" color="transparent">
        <Container>
          <Toolbar>
            <Typography variant="h6" component="div" sx={{ flexGrow: 2 }}>
              <Link to="/home" style={{ textDecoration: "none", color: '#eee',paddingRight: "3rem"}}>
                AVALUOS
              </Link>
              <Link to="/clients" style={{ textDecoration: "none", color: '#eee'}}>
                CLIENTES
              </Link>
            </Typography>
            <Button
              variant="contained"
              color="primary"
              onClick={() => navigate("/clients/new")}
            >
              AGREGAR CLIENTE
            </Button>
          </Toolbar>
        </Container>
      </AppBar>
    </Box>
  );
}
