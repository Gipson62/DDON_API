import jwt from "jsonwebtoken";

export const generateToken = (user) => {
    return jwt.sign(
        {
            userId: user.account_id,
            email: user.email,
        },
        process.env.SECRET_KEY,
        { expiresIn: "30 days" }
    );
}

export const verifyToken = (token) => {
    return jwt.verify(token, process.env.SECRET_KEY);
}