export type Opaque<K, T> = T & { __opaque__ : K };


export class Result<T, Err> {
    private readonly success: boolean;
    private readonly value?: T | undefined;
    private readonly error?: Err;
    private constructor(
        success: boolean,
        value?: T,
        error?: Err
    ) {
        this.success = success;
        this.value = value;
        this.error = error;
    }

    static ok<T, Err = never>(value: T): Result<T, Err> {
        return new Result(true, value);
    }

    static err<Err, T = never>(error: Err): Result<T, Err> {
        return new Result<T, Err>(false, undefined, error);
    }

    isSuccess(): boolean {
        return this.success;
    }

    isFailure(): boolean {
        return !this.success;
    }

    getValue(): T {
        if (!this.success) 
            throw new Error("Cannot get value from a failed result");
        
        return this.value!;
    }

    getError(): Err {
        if (this.success) 
            throw new Error("Cannot get error from a successful result");
        
        return this.error!;
    }
}