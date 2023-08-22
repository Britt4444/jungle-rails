describe('Add to cart', () => {
  beforeEach(() => {
    cy.visit('/')
  })

  it('Adds item to cart, increasing cart count by 1', () => {
    cy.visit('/')
    cy.get('.end-0').contains(0)
    cy.get('button').contains('Add').eq(0).click({ force: true })
    cy.get('.end-0').contains(1)
  })

})