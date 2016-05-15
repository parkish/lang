package main

import (
	"testing"
	"github.com/stretchr/testify/assert"
)

func Test_ChannelClose(t *testing.T) {
	stringChan := make(chan string, 5)

	stringChan <- "hello world"

	// the channel is now marked as closed, but isn't closed until we retrieve the final value
	// from it.
	close(stringChan)

	// so sending on the channel is busted immediately
	assert.Panics(t, func() {
		stringChan <- "sending on a closed channel panic()'s"
	})

	valueFromClosedChannel := <-stringChan
	assert.EqualValues(t, "hello world", valueFromClosedChannel)
	
	// now that the last value has been retrieved we'll just get the empty value
	for i := 0; i < 2; i++ {
		assert.EqualValues(t, "", <- stringChan)
	}	
	
	// and we can tell definitively that it's empty as well
	val, ok := <- stringChan
	assert.EqualValues(t, "", val)
	assert.False(t, ok)
}
