# Rainbow Text

``` css

.rainbow {
    padding: 10px !important;
    font-size: 2.3rem;
    background: red; /* For browsers that do not support gradients */
    background: -webkit-linear-gradient(right, orange, yellow, green, cyan, blue, violet); /* For Safari 5.1 to 6.0 */
    background: -o-linear-gradient(right, orange, yellow, green, cyan, blue, violet); /* For Opera 11.1 to 12.0 */
    background: -moz-linear-gradient(right, orange, yellow, green, cyan, blue, violet); /* For Firefox 3.6 to 15 */
    background: linear-gradient(to right, violet, indigo, blue, green, yellow, orange, red); /* Standard syntax (must be last) */

    -webkit-background-clip: text;
    background-clip: text;
    -webkit-text-fill-color: transparent;
    color: transparent !important;    

    animation: rainbow_animation 25s ease-in-out infinite; /*animation*/
    background-size: 400% 100%; /*animation*/
}

@keyframes rainbow_animation {
    0%,100% {
        background-position: 0 0;
    }

    50% {
        background-position: 100% 0;
    }
}

```