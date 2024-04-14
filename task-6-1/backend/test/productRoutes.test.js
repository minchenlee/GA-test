const request = require("supertest");
const express = require("express");
const bodyParser = require("body-parser");
const UserModel = require("../db/model/user");
const userRouter = require("../routes/user");

const app = express();
app.use(bodyParser.json());
app.use("/users", userRouter);

// Mock UserModel methods used in the API
jest.mock("../db/model/user");

beforeEach(() => {
  jest.resetAllMocks();
});

describe("User API", () => {
  describe("GET /users", () => {
    it("should return 404 if user not found", async () => {
      UserModel.findById.mockResolvedValue(null);
      const res = await request(app).get("/users?userId=123");
      expect(res.status).toBe(404);
      expect(res.body).toEqual({ error: "User not found with ID 123" });
    });

    it("should return 200 if user is found", async () => {
      UserModel.findById.mockResolvedValue({ _id: "123" });
      const res = await request(app).get("/users?userId=123");
      expect(res.status).toBe(200);
      expect(res.body).toEqual({ message: "User found" });
    });
  });
});
