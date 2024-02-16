const express = require("express");
const TransactionDb = require("../models/transactionModel");
const router = express.Router();

router.post("/", async (req, res) => {
    try {
        // Extract the data from the request body 
        const dataa = req.body.question;
        const data = JSON.parse(dataa);

        // Create a new instance of TransactionDb model with the extracted data
        const newTransaction = new TransactionDb({
            uid: data.uid,
            type: data.type,
            category: data.category,
            amount: data.amount,
            description: data.description
        });

        // Save the new transaction to the database
        await newTransaction.save();

        // Respond with success message
        res.status(200).json({ message: "Transaction created successfully", status: true });
    } catch (error) {
        // Handle any errors that occur during transaction creation
        console.log(error.message);
        res.status(500).json({ error: error.message, status: false });
    }
});

module.exports = router;
