module.exports = {
  db: {
    user: process.env.DB_USER || "db_avaluos_admin",
    password: process.env.DB_PASSWORD || "1234",
    host: process.env.DB_HOST || "localhost",
    port: process.env.DB_PORT || 5432,
    database: process.env.DB_DATABASE || "pgavaluos",
  },
};
