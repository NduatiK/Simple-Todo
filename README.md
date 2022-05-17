# Simple-Todo
A simple haskell file-based todo list.

Create a blank `todo.txt` file

#### List todos
```shell
$ runhaskell TodoApp.hs todo.txt list
1 - Phone home
2 - Eat lunch
```


#### Bump todo to top of list
```shell
$ runhaskell TodoApp.hs todo.txt list
1 - Phone home
2 - Eat lunch

$ runhaskell TodoApp.hs todo.txt bump 2

$ runhaskell TodoApp.hs todo.txt list
1 - Eat lunch
2 - Phone home
```

#### Add a todo
```shell
$ runhaskell TodoApp.hs todo.txt list
1 - Eat lunch
2 - Phone home

$ runhaskell TodoApp.hs todo.txt add "Go shopping" "Find keys"

$ runhaskell TodoApp.hs todo.txt list
1 - Eat lunch
2 - Phone home
3 - Go shopping
4 - Find keys
```

#### Delete a todo
```shell
$ runhaskell TodoApp.hs todo.txt list
1 - Eat lunch
2 - Phone home

$ runhaskell TodoApp.hs todo.txt delete 2

$ runhaskell TodoApp.hs todo.txt list
1 - Eat lunch
```
