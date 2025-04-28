#!/bin/bash
quotes=("Beneath every line of code lies the silent rebellion of a soul seeking order in chaos."
        "Man's greatness lies in his ability to endure the infinite while embracing the finite."
        "Even in the cold precision of machines, the heart searches for meaning."
        "A terminal, like life, offers nothing but what you put into it—yet everything you need lies within."
        "To live without beauty, even in a console, is to deny one's humanity."
        "The struggle for perfection is the essence of freedom; even a script reveals the soul's yearning."
        "Man is not only a being who suffers but one who creates—even from the bleakest command line."
        "Every keystroke is a confession, every output a truth we must reconcile."
        "The terminal reflects the user’s soul—clean, cluttered, or somewhere in between."
        "To debug is to wrestle with the absurd, yet it is this struggle that defines us.")
echo "${quotes[RANDOM % ${#quotes[@]}]}"
