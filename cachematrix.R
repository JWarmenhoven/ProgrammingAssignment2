##  Jordi Warmenhoven
##  2015-10-13
##
##  This file contains two functions that implement the caching 
##  of the inverse of a matrix.


makeCacheMatrix <- function(x = matrix()) {
  ##  This function creates a 'matrix' object that can cache its inverse.
  ##  It takes a matrix as input and returns a list with four functions.
  
  # The inverse is set to NULL after initialisation.
  inverse <- NULL
  
  # Function to set a new matrix after initial/first call.
  set <- function(y) {
    # The new matrix is set in the enclosing environment,
    # which is the function makeCacheMatrix().
    x <<- y
    # The inverse is set to NULL, also in the enclosing environment.
    inverse <<- NULL
  }
  
  # Function to return the matrix, from enclosing environment.
  get <- function() x
  
  # Function to assign the set_inverse variable in the enclosing env. 
  set_inverse <- function(inverse_matrix) inverse <<- inverse_matrix
  
  # Function to return the inverse of the matrix, from encl. env.
  get_inverse <- function() inverse
  
  # Return a list with the four functions.
  list(set = set, get = get,
       set_inverse = set_inverse,
       get_inverse = get_inverse)  
}



cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of a matrix object created
  ## with the function makeCacheMatrix().
  
  # Return the cached inverse if it has been calculated...
  inverse <- x$get_inverse()
  if(!is.null(inverse)) {
    message("getting cached data")
    return(inverse)
  }
  
  # ...otherwise calculate the inverse.
  # First get the matrix from the makeCacheMatrix object.
  data <- x$get()
  
  # Inverse calculation requires matrix to be symmetric.
  # Check input and calculate inverse. Set the value in the
  # makeCacheObject and return it.
  if(isSymmetric.matrix(data)) {
    inverse <- solve(data, ...)
    x$set_inverse(inverse)
    inverse
  }
  else {
    print('Inverse not calculated: Matrix has to be symmetric!')
  }
  
}