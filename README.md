# Frontend Mentor - Interactive card details form solution

![Design preview for the Interactive card details form coding challenge](./images/desktop-preview.jpg)

This is a solution to the [Interactive card details form challenge on Frontend Mentor](https://www.frontendmentor.io/challenges/interactive-card-details-form-XpS8cKZDWw). Frontend Mentor challenges help you improve your coding skills by building realistic projects.

## Table of contents

- [Overview](#overview)
  - [The challenge](#the-challenge)
  - [Links](#links)
- [My process](#my-process)
  - [Built with](#built-with)
  - [What I learned](#what-i-learned)
  - [My Opinions on Elm](#my-opinions-on-elm)
  - [Continued development](#continued-development)
  - [Useful resources](#useful-resources)
- [Author](#author)
- [Acknowledgments](#acknowledgments)

## Overview

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

- I decided to have the error messages show after the user starts typing until it passes validation. I don't know if this is more user friendly or simply an annoyance though.

- For React or Elm, they should be given control over the rendering of the state right from the beginning and this gives a lot more flexibility since we don't wait until submission to do something.

- I tried absolute positioning while I got it to work and be responsive, there were too many issues that I wasn't happy with. I find a video by Kevin Powell who covers the same topic and for the same project and after attempting his method, I still found many problems with using absolute positioning for this (_he didn't complete the project, he only did a portion_). If I were to see a design like this in the future, I will definitely use a different method

- When I first wrote my code, I had the value of the inputs be reflected by what's in the state, this is known as a controlled component in React (_and maybe other frameworks_). I didn't realize that one of the requirements for the project would make it tough when using a controlled component, namely having the cards update their information. I wanted the cards to start with an initial value (_e.g. Jane Appleseed for the card holders name_) but if I set the state to that text, then the value attribute on the input would be set to that as well. The way I got around it was by using a function to determine wether the value attribute was an empty string or not, if it was display by dummy text, else display the value thus the card updates in real time instead of only on form submission

```elm
baseTextOrUserInput : String -> String -> String
baseTextOrUserInput value defaultString =
    if value == "" then
        defaultString

    else
        value

```

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
- [Absolute Pos. By Kevin Powell](https://www.youtube.com/watch?v=H04P5YXVssE)

## Author

- [My Portfolio](https://daniel-arzani-portfolio.netlify.app/)
- [Frontend Mentor Profile](https://www.frontendmentor.io/profile/danielarzani)
- [My Github Profile](https://github.com/DanielArzani)

## Acknowledgments

- The official Elm slack channel. The members there are quick to answer, even beginner level questions and helpful
