import jwt from "jsonwebtoken";

interface User {
    account_id: string;
    email: string;
}

export const generateToken = (user: User): string => {
    return jwt.sign(
        {
            userId: user.account_id,
            email: user.email,
        },
        process.env.SECRET_KEY as string,
        { expiresIn: "30 days" }
    );
}

type TokenPayload = {
    userId: string;
    email: string;
}

export const verifyToken = (token: string): TokenPayload | undefined => {
    try {
        return jwt.verify(token, process.env.SECRET_KEY as string) as TokenPayload;
    } catch (error) {
        return undefined;
    }
}