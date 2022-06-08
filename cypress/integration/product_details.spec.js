/// <reference types="cypress" />

describe("Product Details ", () => {
  beforeEach(() => {
    cy.visit("http://localhost:3000/");
  });

  it("There are products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There are 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("Clicking a product navigates to its details page", () => {
    cy.get(".products article:first").click();
  });
});
