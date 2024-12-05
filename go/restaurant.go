package main

import (
	"log"
	"math/rand"
	"sync"
	"sync/atomic"
	"time"
)

func do(seconds int, action ...any) {
    log.Println(action...)
    randomMillis := 500 * seconds + rand.Intn(500 * seconds)
    time.Sleep(time.Duration(randomMillis) * time.Millisecond)
}

type Order struct {
	id           uint64
	customerName string
	reply        chan *Order
}

var orderID atomic.Uint64

const waiterCapacity = 3
var waiter = make(chan *Order, waiterCapacity)

const (
	numCustomers    = 10
	numCooks        = 3
	maxMealsPerCust = 5
)

var customerNames = []string{"Ani", "Bai", "Cat", "Dao", "Eve", "Fay", "Gus", "Hua", "Iza", "Jai"}
var cookNames = []string{"Remy", "Colette", "Linguini"}

func main() {
	rand.Seed(time.Now().UnixNano())

	var wg sync.WaitGroup

	for _, cookName := range cookNames {
		go cook(cookName)
	}

	for _, customerName := range customerNames {
		wg.Add(1)
		go customer(customerName, &wg)
	}

	wg.Wait()
	log.Println("All customers have gone home. The restaurant is closing.")
}

func cook(name string) {
	for order := range waiter {
		do(10, name, "is cooking for", order.customerName)
		order.reply <- order
	}
}

func customer(name string, wg *sync.WaitGroup) {
	defer wg.Done()
	mealsEaten := 0

	for mealsEaten < maxMealsPerCust {
		order := &Order{
			id:           orderID.Add(1),
			customerName: name,
			reply:        make(chan *Order, 1),
		}

		select {
		case waiter <- order:
			log.Println(name, "placed order", order.id)
			preparedOrder := <-order.reply
			log.Println(name, "received order", preparedOrder.id)
			do(2, name, "is eating meal", mealsEaten+1)
			mealsEaten++
		case <-time.After(7 * time.Second):
			log.Println(name, "got tired of waiting and will return later")
			time.Sleep(time.Duration(2500+rand.Intn(2500)) * time.Millisecond)
		}
	}

	log.Println(name, "has finished all meals and is leaving.")
}