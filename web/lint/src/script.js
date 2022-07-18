const thing = document.getElementById("heading")
const func = () => {
    const bait = document.getElementById("bait")
    bait.textContent = "The flag isn't here."
    console.log("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmbGFnIjoiTDFudF9ZMHVyX0MwZEUifQ.vdC6uslOfltz04WTOgzOEODAS_1kLR5mQDpj0XgAByI");
}
thing.addEventListener("click", func)

const flag = document.getElementById("flag")
const func2 = () => {
    const bait = document.getElementById("bait")
    bait.textContent = "Get Jebaited"
}
flag.addEventListener("click", func2)