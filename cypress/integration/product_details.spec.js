describe('Products page', () => {
  beforeEach(() => {
    cy.visit('/')
  })

  it('loads product details page', () => {
    cy.get('[alt="Giant Tea"]').click();
  })

  it("displays product details", () => {
    cy.get('[alt="Giant Tea"]').click();
    cy.get(".price").contains(64.99);
    cy.get(".quantity").contains(0);
    cy.get(".product-detail p").contains("It blooms twice a year, for 3 weeks");
  });

})