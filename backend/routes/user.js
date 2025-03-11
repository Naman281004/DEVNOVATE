const express = require('express')
const router = express.Router();
const db = require("../db")

router.get('/',async (req,res) => {
    try{
        const result = await db.query(`SELECT email,first_name,last_name,about FROM event_platform_simple.users`);
        res.json(result.rows);
    }catch(err){
        res.status(500).json({error : err.message})
    }
});

router.get('/:id', async (req,res) => {
    try {
        const userId = req.params.id;
        const result = await db.query(
            'SELECT * FROM event_platform_simple.users WHERE id = $1',
            [userId]
        );
        if (result.rows.length === 0) {
            return res.status(404).json({ message: 'User not found' });
        }
        res.json(result.rows[0]);
    } catch(err) {
        res.status(500).json({error : err.message});
    }
});

router.post('/:id/edit', async (req,res) => {
    try {
        const {id, email, first_name, last_name, about} = req.body;
        const result = await db.query(
            `UPDATE event_platform_simple.users 
             SET email = $1, first_name = $2, last_name = $3, about = $4 
             WHERE id = $5 
             RETURNING *`,
            [email, first_name, last_name, about, id]
        );
        if (result.rows.length === 0) {
            return res.status(404).json({ message: 'User not found' });
        }
        res.json(result.rows[0]);
    } catch(err) {
        res.status(500).json({error : err.message});
    }
});

module.exports = router;