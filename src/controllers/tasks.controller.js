const pool = require("../db");

// const createTask = async (req, res, next) => {
//   try {
//     const { title, description } = req.body;

//     const newTask = await pool.query(
//       "INSERT INTO task (title, description) VALUES($1, $2) RETURNING *",
//       [title, description]
//     );

//     res.json(newTask.rows[0]);
//   } catch (error) {
//     next(error);
//   }
// };

const getAllTasks = async (req, res, next) => {
  try {
    const allTasks = await pool.query("SELECT * FROM avaluo_schema.avaluo");
    // const allTasks = await pool.query("SELECT * FROM task");
    res.json(allTasks.rows);
  } catch (error) {
    next(error);
  }
};

const getAllClients = async(req,res,next) =>{
  try {
    const allClients = await pool.query("SELECT * FROM avaluo_schema.empresa")
    // const allClients = await pool.query("SELECT * FROM persona")
    res.json(allClients.rows)
  } catch (error) {
    next(error)
  }
}

// const getTask = async (req, res) => {
//   try {
//     const { id } = req.params;
//     const result = await pool.query("SELECT * FROM task WHERE id = $1", [id]);

//     if (result.rows.length === 0)
//       return res.status(404).json({ message: "Task not found" });

//     res.json(result.rows[0]);
//   } catch (error) {
//     next(error);
//   }
// };

const updateTask = async (req, res) => {
  try {
    const { id } = req.params;
    const { title, description } = req.body;

    const result = await pool.query(
      "UPDATE task SET title = $1, description = $2 WHERE id = $3 RETURNING *",
      [title, description, id]
    );

    if (result.rows.length === 0)
      return res.status(404).json({ message: "Task not found" });

    return res.json(result.rows[0]);
  } catch (error) {
    next(error);
  }
};

const deleteTask = async (req, res) => {
  try {
    const { id } = req.params;
    const result = await pool.query("DELETE FROM task WHERE id = $1", [id]);

    if (result.rowCount === 0)
      return res.status(404).json({ message: "Task not found" });
    return res.sendStatus(204);
  } catch (error) {
    next(error);
  }
};
const createTask = async (req, res, next) => {
  try {
    const { title, description } = req.body;

    const newTask = await pool.query(
      
      "INSERT INTO avaluo_schema.task (title, description) VALUES($1, $2) RETURNING *",
      //"INSERT INTO task (title, description) VALUES($1, $2) RETURNING *",
      [title, description]
    );

    res.json(newTask.rows[0]);
  } catch (error) {
    next(error);
  }
};



const createEntity = async (req, res, next) => {
  try {
    const { identificacion_entidad, tipo_identificacion, telefono_entidad, correo_entidad } = req.body;

    const newEntity = await pool.query(
       "INSERT INTO avaluo_schema.entidad (identificacion_entidad,tipo_identificacion, telefono_entidad, correo_entidad) VALUES ($1, $2, $3, $4) RETURNING *",
      //"INSERT INTO entidad (identificacion_entidad,tipo_identificacion, telefono_entidad, correo_entidad) VALUES ($1, $2, $3, $4) RETURNING *",
      [ identificacion_entidad, tipo_identificacion, telefono_entidad, correo_entidad]
    );

    res.json(newEntity.rows[0]);

  } catch (error) {
    next(error);
  }
  


};
const createClient = async (req, res, next) => {
  try {
    const { id_entidad, camara_comercio, nombre_empresa, razon_social} = req.body;

    const newEntity = await pool.query(
      "INSERT INTO avaluo_schema.EMPRESA (id_entidad, camara_comercio, nombre_empresa, razon_social) VALUES ($1, $2, $3, $4) RETURNING *",
      //"INSERT INTO EMPRESA (id_entidad, camara_comercio, nombre_empresa, razon_social) VALUES ($1, $2, $3, $4) RETURNING *",
      [id_entidad, camara_comercio, nombre_empresa, razon_social]
    );
    // console.log(res.json(newEntity.rows[0]));
    res.json(newEntity.rows[0]);

  } catch (error) {
    next(error);
  }

};


const getTask = async (req, res, next) => {
  try {
    const { id } = req.params;
    const result = await pool.query("SELECT * FROM task WHERE id = $1", [id]);

    if (result.rows.length === 0)
      return res.status(404).json({ message: "Task not found" });

    res.json(result.rows[0]);
  } catch (error) {
    next(error);
  }
};

const getEntity = async (req, res,next) => {
  try {
    const { correo_entidad } = req.params;
    const result = await pool.query("SELECT * FROM avaluo_schema.entidad WHERE correo_entidad = $1", [correo_entidad]);
    // const result = await pool.query("SELECT * FROM entidad WHERE id_entidad = $1", [id_entidad]);

    if (result.rows.length === 0)
      return res.status(404).json({ message: "Entidad not found" });
 
    res.json(result.rows[0]);
  } catch (error) {
    next(error);
  }
};

module.exports = {
  createTask,
  getAllTasks,
  getTask,
  updateTask,
  deleteTask,
  getAllClients,
  createClient,
  createEntity,
  getEntity,
};
