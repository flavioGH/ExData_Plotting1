## File: cachematrix.R
## Verision: 2021-05-19/1
## Assignment:
## Matrix inversion is usually a costly computation and there may be some benefit to caching the inverse of a matrix 
## rather than compute it repeatedly (there are also alternatives to matrix inversion that we will not discuss here). 
## Your assignment is to write a pair of functions that cache the inverse of a matrix.
##
## Computing the inverse of a square matrix can be done with the solve function in R. For example, 
## if X is a square invertible matrix, then solve(X) returns its inverse.
## For this assignment, assume that the matrix supplied is always invertible.
## Functions "makeCacgeMatrix" and "cacheSolve" are used to compute the inverse of a given matrix. 
## If the inverse is cached, then return the cache,
## else invert the matrix and cache the inverse matrix before return the inverse matrix.

## "makeCacheMatrix" defines functions "set", "get", "setInverse" and "getInverse".  i
## Creates a list of four functions:  functions to cache and retrieve a matrix 
## and two functions to cache and retrieve the inverse of the matrix.

makeCacheMatrix <- function(x = matrix()) {
    inverse_m <-NULL
    set <- function(y) {            ##cache matrix and clear inverse matrix
        x <<- y
        inverse_m <-NULL
    }
    get <- function() {             ##retrieve matrix from cache
        x
    }                 
    setinverse <- function(solve){  ##cache inverse matrix
        inverse_m <<- solve
    } 
    getinverse <- function() {      ##retrieve inverse matrix from cache
        inverse_m
    }
    list(set=set, get=get, setinverse=setinverse, getinverse=getinverse)
}


## Computes and caches the inverse of the special "matrix" if one does not exist and returns inverse matrix.

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    inverse_m <- x$getinverse()
    if(!is.null(inverse_m)) {               ##retrieve inverse from cache if stored
        message("getting cached data")
        return(inverse_m)
    }
        else{                               ##retrieve matrix, compute and store inverse
            data <- x$get()
            inverse_m <- solve(data, ...)
            x$setinverse(inverse_m)
            inverse_m
        }
}
