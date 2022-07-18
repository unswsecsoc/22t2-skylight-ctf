const queryType = require("query-types");
const express = require("express");
const app = express();

app.use(queryType.middleware());

app.use(express.urlencoded());

app.get("/math", (req, res) => {
    const { num1, op, num2 } = req.query;

    const opMappings = {
        add: "+",
        subtract: "-",
        multiply: "*",
        divide: "/",
    };

    // Check for hackers
    if (
        num1.constructor.name !== "Number" ||
        num2.constructor.name !== "Number" ||
        !(op in opMappings)
    ) {
        res.send(
            `Looks like you're trying to do something naughty!<br><a href="/">Back</a>`
        );
        return;
    }

    // Round down numbers to integers and apply math operation
    const code =
        "parseInt('" +
        JSON.stringify(num1) +
        "')" +
        opMappings[op] +
        "parseInt('" +
        JSON.stringify(num2) +
        "')";

    const result = eval(code);

    res.send(
        `Your result is ` + JSON.stringify(result) + `.<br><a href="/">Back</a>`
    );
});

app.get("/", (req, res) => {
    res.sendFile("./index.html", {
        root: __dirname,
    });
});

app.listen(80, () => {
    console.log(`App listening on port 80`);
});
