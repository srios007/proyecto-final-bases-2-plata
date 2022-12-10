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

const InitialPage = () => {
    const [task, setTask] = useState({
        title: "",
        description: "",
    });
    const [loading, setLoading] = useState(false);
    const [editing, setEditing] = useState(false);

    const navigate = useNavigate();
    const params = useParams();

    useEffect(() => {
        if (params.id) {
            loadTask(params.id);
        }
    }, [params.id]);

    const loadTask = async (id) => {
        const res = await fetch("http://localhost:4000/tasks/" + id);
        const data = await res.json();
        setTask({ title: data.title, description: data.description });
        setEditing(true);
    };


    return (
        <div>
            <h1></h1>
        </div>
    );
};

export default InitialPage;
