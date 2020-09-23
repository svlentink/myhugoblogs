---
title: "Open database of exam questions"
date: "2020-07-13"
draft: true
---

This post expands on
[my previous post](post/rethinking-education/).

Open database of exams questions

## Leveraging cryptography to proof fairness

Let's say a new testing facility/organization wants to enter the market
and hasn't got a trust worthy name yet.
It could propose a model where the examinee is able to choose which topics it wants
tested.
Let's explain this with the following example workflow:

1. Examinee picks topics
2. X time before the test (e.g. 1h) a highly volatile public resource is used as a seed (e.g. downloading the webpage of stock market overview or latest Bitcoin hash)
3. This seed is combined with the full name and or birth date of the examinee to create a hash, which in turn is converted a decimal number
4. This number is used to perform a modulo function over the amount of questions available in the open questions database, to retrieve tha amount required (e.g. 2 questions per topic)
5. When the questions are known, they can be printed and only then the total time of the exam is known. (i.e. you will know beforehand that the questions in topic A are 1-2min and topic B 10-30min per questions)
6. The examinee get a personalized, freshly printed exam.
7. Afterwards, the written exam is scanned/photographed and digitally send to the examinee.
8. The final result will be published pubically under the hash, of which the examinee can proof that it's the author, but is not required to.

```javascript
// the following code can be ran in the terminal of a web browser
const questions_array = [
  '1 + 1',
  '1 - 2',
  '1 + 3',
  '1 - 4',
  '1 + 5',
  '1 - 6',
  '1 + 7',
  '1 - 8',
  '2 + 1',
  '2 - 2',
  '2 + 3',
  '2 - 4',
  '2 + 5',
  '2 - 6',
  '2 + 7',
  '2 - 8'
]
function pickQuestions(hash_string, questions_array, no_of_questions){
	if (no_of_questions >= questions_array.length) return questions_array
	let result = []
	for (let i = 0; i < no_of_questions; i++){
		let hashno = parseInt(hash_string.substr(10),16) // base16 hash to decimal
		let magicno = (hashno+i) * (i+1)
		for (let j = 0; j < questions_array.length; j++) {
			let qi = (magicno + j) % questions_array.length
			let question = questions_array[qi]
			//console.log('Debug info',hashno,magicno,i,j,qi)
			if (result.includes(question)) continue
			else {
				result.push(question)
				break
			}
		}
	}
	return result
}
//testing
pickQuestions('abcdef0123456789', questions_array, 15)
```


so the exam is generated just before it begins and printed,
directly afterwards, images are taken of written exam and hash of it is added to public ledger,
proving it happened in that moment in time.
E.g. also video material of person making exam is available.

hash(exam hash + fullname.toLower())


