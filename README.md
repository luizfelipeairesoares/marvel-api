# Marvel API
## Small Swift server using [Vapor](https://vapor.codes/) framework.

Idea behind this is studying server side Swift and intercept requests made by [Portfolio app](https://github.com/luizfelipeairesoares/portfolio).

## How to run
1. Create an account and get you private and public keys from https://developer.marvel.com.
2. Clone this repository.
4. Create a `.env` and a `.env.development` files
5. In these files add:
- DOMAIN=https://gateway.marvel.com/v1/public
- PRIVATE_KEY=`<Your Private Key>`
- PUBLIC_KEY=`<Your Public Key>`
4. Open `Package.swift` in Xcode or run the server via terminal.
5. Test the requests
  - One example is `/characters`.
  
## Current endpoints:
- `/characters`: Fetch a list of characters. Accepts `offset` and `name` as query parameters.
- `/characters/:id`: Fetch a particular character data using its id.
- `/characters/:id/comics`: Fetch a list of comic books from the particular character.
