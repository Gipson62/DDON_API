// Exclude keys from user
export const exclude = (user: { [s: string]: unknown; } | ArrayLike<unknown>, keys: string | string[]) => {
    return Object.fromEntries(
        Object.entries(user).filter(([key]) => !keys.includes(key))
    );
}