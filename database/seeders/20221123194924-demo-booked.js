'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
 
   await queryInterface.bulkInsert('booked',[{
    createdAt: new Date(),
    updatedAt:new Date,
    UserId: 1,
    CenterId:1
   },{
    createdAt: new Date(),
    updatedAt:new Date,
    UserId: 2,
    CenterId:1
   },{
    createdAt: new Date(),
    updatedAt:new Date,
    UserId: 3,
    CenterId:1
   }])
  },

  async down (queryInterface, Sequelize) {
  
     await queryInterface.bulkDelete('booked', null, {});
  }
};
