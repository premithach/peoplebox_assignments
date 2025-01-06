function convertToCamelCase(obj) {
    const result = {};

    // Iterate over each key in the object
    for (const key in obj) {
        if (obj.hasOwnProperty(key)) {
            // Convert the snake_case key to camelCase
            const camelCaseKey = key.replace(/_([a-z])/g, (match, letter) => letter.toUpperCase());
            result[camelCaseKey] = obj[key];
        }
    }

    return result;
}

const snakeCaseObj = {
    "first_name": "John",
    "last_name": "Doe",
    "email_address": "john.doe@example.com"
};

const camelCaseObj = convertToCamelCase(snakeCaseObj);
console.log(camelCaseObj);

