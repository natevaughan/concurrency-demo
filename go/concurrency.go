package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"math/rand"
	"time"
)

func addFactToChannel(client http.Client, url string, t int, ch chan CatFact) {
	f, err := getFact(client, url, t)
	if err != nil {
		log.Fatal(err)
		return
	}
	ch <- f
} 

func getFact(client http.Client, url string, t int) (CatFact, error) {
	f := CatFact{}
	time.Sleep(time.Duration(t) * time.Millisecond)

	req, err := http.NewRequest(http.MethodGet, url, nil)
	if err != nil {
		return f, err
	}

	res, err := client.Do(req)
	if err != nil {
		return f, err
	}

	if res.Body != nil {
		defer res.Body.Close()
	}

	body, err := ioutil.ReadAll(res.Body)
	if err != nil {
		return f, err
	}

	err = json.Unmarshal(body, &f)
	if err != nil {
		return f, err
	}
	return f, err
}

type CatFact struct {
	Fact   string `json:"fact"`
	Length int    `json:"length"`
}

func main() {
	n := 5
	url := "https://catfact.ninja/fact"
	client := http.Client{ Timeout: 5 * time.Second }
	r := rand.New(rand.NewSource(3))
	ch := make(chan CatFact)
	timings := make([]int, n)
	
	start := time.Now()
	for i := 0; i < n; i++ {
		timings[i] = int(r.Float64() * 3000)
		a, err := getFact(client, url, timings[i])
		if err != nil {
			log.Fatal(err)
		} else {
			fmt.Println(a.Fact)
		}
	}
	fmt.Printf("Time was %v\n", time.Since(start))
	start = time.Now()

	for i := 0; i < n; i++ {
		go addFactToChannel(client, url, timings[i], ch)
	}

	for i := 0; i < n; i++ {
		a := <- ch
		fmt.Println(a.Fact)
	}
	fmt.Printf("Time was %v\n", time.Since(start))

}
