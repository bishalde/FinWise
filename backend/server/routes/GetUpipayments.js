const express = require("express");
const Users = require("../models/userModel");
const TransactionDb = require("../models/transactionModel");
const Wallet = require("../models/walletModel");

const router = express.Router();

router.get("/", async (req, res) => {
  res.send({ message: "Welcome To UPI Transfer FinWise API" });
});

router.post("/", async (req, res) => {
  Data=req.body;
  try {
    const fromWallet = await Wallet.findOne({ uid: Data.uid });
    const fromUser = await Users.findOne({ _id: Data.uid });
    if (!fromWallet) {
      return res.status(404).json({ message: "Wallet not found",success:false });
    }
    if (fromWallet.balance < Data.amount) {
        return res.status(400).json({ message: "Insufficient balance",success:false });
    }
    fromWallet.balance = fromWallet.balance - Data.amount;
    await fromWallet.save();

    const newTransaction = new TransactionDb();
    newTransaction.uid = Data.uid;
    newTransaction.type = 'debit';
    newTransaction.category=Data.category;
    newTransaction.amount = Data.amount;
    newTransaction.description = `UPI Transfer to ${Data.toupi}`;
    await newTransaction.save();


    const toUser = await Users.findOne({ upi: Data.toupi });
    const toWallet = await Wallet.findOne({ uid: toUser._id });
    if (!toWallet) {
      return res.status(404).json({ message: "Wallet not found",success: false});
    }
    toWallet.balance = toWallet.balance + Data.amount;
    await toWallet.save();

    const toTransaction = new TransactionDb();
    toTransaction.uid = toUser._id;
    toTransaction.type = 'credit';
    toTransaction.category=Data.category;
    toTransaction.amount = Data.amount;
    toTransaction.description = `UPI Transfer From ${fromUser.upi}`;
    await toTransaction.save();

    res.status(200).json({ message: "UPI Transfer Successful",transId:(Math.floor(Math.random() * 900000000000) + 100000000000).toString(), success: true });
  
   
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: error.message,success: false });
  }
});

module.exports = router;
