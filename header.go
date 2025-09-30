package main

import (
	"time"

	"github.com/ianlopshire/go-fixedwidth"
)

type RankingHeader struct {
	FileName string `fixed:"1,8"`
	DateStr  string `fixed:"9,16"`
	Date     time.Time
	Acquirer string `fixed:"17,24"`
	Lines    int32  `fixed:"25,38"`
}

// Parse parses a line of text into a RankingHeader struct
func (rh *RankingHeader) Parse(line string) (*RankingHeader, error) {
	err := fixedwidth.Unmarshal([]byte(line), rh)
	if err != nil {
		return nil, err
	}
	rh.Date, err = time.Parse("20060102", rh.DateStr)
	if err != nil {
		return nil, err
	}
	return rh, nil
}
