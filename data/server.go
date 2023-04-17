package main

import "net/http"

func main() {
	port := ":2345"
	handler := http.FileServer(http.Dir("."))
	http.ListenAndServe(port, handler)
}
