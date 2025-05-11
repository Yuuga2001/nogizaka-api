import express, { Request, Response } from 'express';
import mysql from 'mysql';
import knex from 'knex';
import cors from 'cors';
import dotenv from 'dotenv';

dotenv.config();

const app = express();
const port = 3000;

app.use(cors());
app.use(express.json());

const db = knex({
  client: 'mysql',
  connection: {
    host: process.env.DB_HOST,
    port: Number(process.env.DB_PORT),
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE,
  },
});

app.get('/api/spots', async (req: Request, res: Response) => {
  try {
    const spots = await db.select().from('spots');
    res.json(spots);
  } catch (error) {
    console.error('Error fetching spots:', error);
    res.status(500).json({ error: 'Failed to fetch spots' });
  }
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
