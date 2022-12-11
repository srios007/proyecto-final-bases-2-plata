const { Router } = require("express");
const {
  createTask,
  getAllTasks,
  getTask,
  updateTask,
  deleteTask,
  getAllClients,
  createClient,
  getEntity,
  createEntity,

} = require("../controllers/tasks.controller");
const router = Router();
// const pool = require('../db');

// router.get("/prueba", async (req, res)=>{
//  const result = await pool.query('SELECT NOW()')
//  console,console.log(result);
//  res.json(result.rows[0].now)
// })// create a task


router.post("/tasks", createTask);

router.get("/tasks", getAllTasks);

router.get("/tasks/:id", getTask);


router.put("/tasks/:id", updateTask);

router.delete("/tasks/:id", deleteTask);

router.post("/createEntity", createEntity);

router.post("/createClient", createClient);

router.get("/clients", getAllClients);

router.get("/entity/:correo_entidad", getEntity);

module.exports = router;
