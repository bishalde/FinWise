const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  firstName: {
    type: String,
  },
  lastName: {
    type: String,
  },
  avatarId:{
    type: String,
  },
  dob:{
    type: String,
  },
  email: {
    unique: true,
    required:true,
    type: String,
  },
  password: {
    required: true,
    type: String,
  },
  phoneNumber: {
    type: String,
  },
  gender: {
    type: String,
  },
  address: {
    type: String,
  },
  city: {
    type: String,
  },
  state: {
    type: String,
  },
  country: {
    type: String,
  },
  zipCode: {
    type: String,
  },
  upi:{
    type: String,
  }
});

userSchema.pre('save', function(next) {
  if (this.isNew) {
      this.upi = this.phoneNumber+"@finwise"
  }
  if (this.gender.toLowerCase() === 'female') {
    this.avatarId = 'female_avatar_1';
  } else {
    this.avatarId = 'men_avatar_1';
  }
  next();
});


const User = mongoose.model("User", userSchema);
module.exports = User;
