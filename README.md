# Frontend Mentor - Interactive card details form solution

![Design preview for the Interactive card details form coding challenge](./images/desktop-preview.jpg)

This is a solution to the [Interactive card details form challenge on Frontend Mentor](https://www.frontendmentor.io/challenges/interactive-card-details-form-XpS8cKZDWw). Frontend Mentor challenges help you improve your coding skills by building realistic projects.

## Table of contents

- [Overview](#overview)
  - [The challenge](#the-challenge)
  - [Screenshot](#screenshot)
  - [Links](#links)
- [My process](#my-process)
  - [Built with](#built-with)
  - [What I learned](#what-i-learned)
  - [My Opinions on Elm](#my-opinions-on-elm)
  - [Continued development](#continued-development)
  - [Useful resources](#useful-resources)
- [Author](#author)
- [Acknowledgments](#acknowledgments)

### The challenge

Users should be able to:

- Fill in the form and see the card details update in real-time
- Receive error messages when the form is submitted if:
  - Any input field is empty
  - The card number, expiry date, or CVC fields are in the wrong format
- View the optimal layout depending on their device's screen size
- See hover, active, and focus states for interactive elements on the page

### Links

- Live Site URL: [Add live site URL here](https://sparkling-sable-189165.netlify.app)

## My process

### Built with

- Semantic HTML5 markup
- SCSS
- Elm

### What I learned

- The importance of 2 way data binding. This concept isn't unique to Elm. I thought it was fine simply to get the users input and after receiving it, do something with it.

- For React or Elm, they should be given control over the rendering of the state right from the beginning and this gives a lot more flexibility since we don't wait until submission to do something.

### My Opinions on Elm

- It is hard because of the lack of guided tutorials, even the documentation is hard to understand at times but its a good way to program. I went and tried a different project out, one I didn't really think I could do and I followed the Elm architecture, taking Functional Programming principles and applying them and it went really well.

- The code was easy to read, organized and worked very well and was very scalable and manageable and didn't even require testing

- I especially like the method where the event listeners send _messages_ and the elm runtime will respond by calling the update function and running the appropriate code to create a new, update state

- I also like how it forces you to cover all your bases so you can't leave edge cases

- I can definitely see my self improving if I continue coding in Elm, so I will.

### Continued development

- Perhaps taking this opportunity to integrate something common like Stripe for payments?

### Useful resources

- [Forms in React by Josh Comeau](https://www.joshwcomeau.com/react/data-binding/)
- [Web.dev](https://web.dev/learn/forms/validation/)
- [MDN Docs](https://developer.mozilla.org/en-US/docs/Learn/Forms/Form_validation)
- [deque.com](https://www.deque.com/blog/anatomy-of-accessible-forms-error-messages/)

## Author

- [My Portfolio](https://daniel-arzani-portfolio.netlify.app/)
- [Frontend Mentor Profile](https://www.frontendmentor.io/profile/danielarzani)
- [My Github Profile](https://github.com/DanielArzani)

## Acknowledgments

- The official Elm slack channel. The members there are quick to answer, even beginner level questions and helpful
