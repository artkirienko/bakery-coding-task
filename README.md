### Important! My notes:

For the example input

```
14 MB11
```

you want the following output:

```
14 MB11 $54.8
    1 x 8 $24.95
    3 x 2 $9.95
```

but there is another solution with the same number of packs:

```
14 MB11 $53.8
    2 x 5 $16.95
    2 x 2 $9.95
```

The only difference is price. So I assume, that I need to:
* find solution **min by number of packs,** if there are solutions with **the same number of packs:**
* find among them solution **max by total price,** if there are solutions with **the same price:**
* choose any of them.

### Production: benchmarks etc.

```bash
$ chmod +x example/benchmarks/benchmark.sh
$ ./example/benchmarks/benchmark.sh
```

To make this application production-ready: implement an algorythm to simplify Linear Diophantine Equation:
https://habrahabr.ru/post/330632/

### Production: how to change inventory/menu (products and packs)?

I use config file located at `config/inventory.yml` to store inventory/menu (products and packs).
To make this application production-ready: use a database to store inventory/menu + create an Admin UI to manage it.

#### Requirements

**Ruby 2.5.3** or **Docker**

#### Run with Ruby

```bash
$ gem install bundler
$ bundle
```

You can run a script and input data from keyboard. Use CTRL-D to send EOF.

```bash
$ bundle exec ruby lib/bakery_runner.rb
```

You can provide a file with example data

```bash
$ ruby lib/bakery_runner.rb example/input.txt
```

```bash
$ ruby lib/bakery_runner.rb < example/input.txt
```

```bash
$ cat example/input.txt | bundle exec ruby lib/bakery_runner.rb
```

#### Run with Docker

```bash
$ docker build -t bakery .
```

You can run a script and input data from keyboard. Use CTRL-D to send EOF.

```bash
$ docker run -i bakery
```

You can provide a file with example data

```bash
$ cat example/input.txt | docker run -i bakery
```

#### Run test suite with ruby

```bash
$ gem install bundler
$ bundle
```

```bash
$ rake
```

#### How to run within your own project

There is an example file `example/run_within_your_application.rb`.

#### ToDo (paranoid mode):

validations:
empty code, empty name, empty price, empty count etc.

### Bakery

#### Background

A bakery used to base the price of their produce on an individual item cost. So if a customer ordered 10 cross buns then they would be charged 10x the cost of a single bun. The bakery has decided to start selling their produce prepackaged in bunches and charging the customer on a per pack basis. So if the shop sold vegemite scroll in packs of 3 and 5 and a customer ordered 8 they would get a pack of 3 and a pack of 5. The bakery currently sells the following products:

| Name             | Code | Packs |
| ---------------- | ---- | ------------------------------------- |
| Vegemite Scroll  | VS5  | 3 @ $6.99<br>5 @ $8.99                |
| Blueberry Muffin | MB11 | 2 @ $9.95<br>5 @ $16.95<br>8 @ $24.95 |
| Croissant        | CF   | 3 @ $5.95<br>5 @ $9.95<br>9 @ $16.99  |

#### Task

Given a customer order you are required to determine the cost and pack breakdown for each product. To save on shipping space each order should contain the minimal number of packs.

#### Input

Each order has a series of lines with each line containing the number of items followed by the product code. 

An example input:

```
10 VS5
14 MB11
13 CF
```

#### Output

A successfully passing test(s) that demonstrates the following output:

```
10 VS5 $17.98
    2 x 5 $8.99
14 MB11 $54.8
    1 x 8 $24.95
    3 x 2 $9.95
13 CF $25.85
    2 x 5 $9.95
    1 x 3 $5.95
```

#### Advice:

* Choose whatever language you're comfortable with
* The input/output format is not important, do whatever feels reasonable
* Make sure you include at least one test
* We expect the see code which you would be happy to put in production
* If something is not clear don't hesitate to ask or just make an assumption and go with it

#### CodingTaskCriteria

* Is the code functional:
  * Are there instructions to setup/install?
  * Does it meet the minimum requirements in the specification?
  * Does it return appropriate results in other circumstances?
* Is the code readable:
  * Sensible naming of variables and methods?
  * Sensible method sizes (<20 lines)?
  * Low complexity methods?
* Is the code tested:
  * Unit tests for at least major classes?
  * End to end functional or integration tests?
* Is the design sound:
  * Is it object oriented?
  * Does it follow the Single Responsibility Principle?
  * Does it follow the Law of Demeter?
