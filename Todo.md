1. change the provider shape of my call to the new graphQL schema
2. Create the card on homepage to have the new data
3. Add search functionality at the top


{
  characters {
    results {
      id
      name
      species
      gender
      image
      status
      location {
        name
      }
      episode {
        name
      }
    }
  }
}