package handle

import (
	"backend/model"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestAllData(t *testing.T) {
	m := NewMember()

	result := m.AllData()

	var expect []model.Member

	assert.Equal(t, expect, result)

}

func TestAddData(t *testing.T) {
	m := NewMember()
	data := model.Member{
		Name:  "Frank",
		Phone: 123456,
		Email: "Frank@mail.com",
	}
	_ = m.AddData(data)

	result := m.AllData()

	var expect []model.Member
	expect = append(expect, data)

	assert.Equal(t, expect, result)
}
