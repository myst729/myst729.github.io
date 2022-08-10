---
layout: post
title: 超出 Number 类型安全范围的大整数相乘
tag: [coding, red]
date: 2022-08-09
---

脑子太久不用会生锈，做个算法题吧。

```typescript
type NumberRow = Array<number>
type NumberMatrix = Array<NumberRow>
type ReverseDigits = Array<string>

const isInteger = (n: string): boolean => {
  return /^[1-9][0-9]{0,}$/.test(n)
}

const reduceRow = (row: NumberRow): string => {
  const results: NumberRow = []
    for (let i = 0; i < row.length; i++) {
    const num: ReverseDigits = `${row[i]}`.split('').reverse()
    for (let j = 0; j < num.length; j++) {
      results[i + j] = (results[i + j] || 0) + Number(num[j])
    }
  }
  if (results.some((n) => n > 9)) {
    return reduceRow(results)
  }
  return results.reverse().join('')
}

const reduceMatrix = (matrix: NumberMatrix): string => {
  const results: NumberRow = []
  for (let i = 0; i < matrix.length; i++) {
    for (let j = 0; j < matrix[i].length; j++) {
      results[j] = (results[j] || 0) + matrix[i][j]
    }
  }
  return reduceRow(results)
}

const bigMultiply = (a: string, b: string): string => {
  if (isInteger(a) && isInteger(b)) {
    const digitsA: ReverseDigits = a.split('').reverse()
    const digitsB: ReverseDigits = b.split('').reverse()
    const results: NumberMatrix = []

    for (let i = 0; i < digitsA.length; i++) {
      const row: NumberRow = Array(i).fill(0)
      for (let j = 0; j < digitsB.length; j++) {
        row.push(Number(digitsA[i]) * Number(digitsB[j]))
      }
      results.push(row)
    }
    return reduceMatrix(results)
  }
  return '--'
}
```
