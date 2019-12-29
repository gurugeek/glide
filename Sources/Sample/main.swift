import SwiftExpress
import HTMLKit
import MongoKitten
import Meow

let db = try MongoDatabase.synchronousConnect("mongodb://admin:password@localhost:27017/playground")
let pokemonCollection = MeowDatabase(db).collection(for: Pokemon.self)

let app = SwiftExpress()

app.use { request, response, next in
  print("\(request.header.method):", request.header.uri)
  next()
}

app.use(
  parseParameters,
  cors(allowOrigin: "*")
)

app.useHTML { html in
  html.addTemplate(view: HelloTemplate())
  html.addStaticPage(view: StaticPage())
  html.registerLocalization(atPath: "./", defaultLocale: "en")
}

app.get("/hello") { _, response, _ in
  response.send("Hello, world!")
}

app.get("/template") { _, response, _ in
  response.render(
    HelloTemplate(),
    context: .init(name: "Sam", title: "Porter")
  )
}

app.get("/static") { _, response, _ in
  response.render(StaticPage())
}

app.get("/create") { _, response, _ in
  let pokemon = Pokemon(name: "Abra", type: "Psychic", HP: 255)

  pokemonCollection.insert(pokemon).whenSuccess { _ in
    response.render(
      HelloTemplate(),
      context: .init(name: "\(pokemon.name) was created successfully!", title: "Success")
    )
  }
}

app.listen(1337)
