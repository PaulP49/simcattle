package errors

// A helper class to return custom errors from services.
type Error struct {
	StatusCode int
	Msg string
}

// New creates a new Error.
func New(statusCode int, msg string) *Error {
	return &Error{
		StatusCode: statusCode,
		Msg: msg,
	}
}