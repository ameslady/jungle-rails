/// <reference types="cypress" />

describe("Home", () => {
  beforeEach(() => {
    cy.visit("http://localhost:3000/");
  });

  it("There are products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There are 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("Clicking add button increases cart by one", () => {
    cy.get("li.nav-item.end-0").should("include.text", "My Cart (0)");
    cy.get(".button_to:first").submit();
    cy.get("li.nav-item.end-0").should("include.text", "My Cart (1)");
  });
});
