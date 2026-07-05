exports.handler = async (event) => {
    console.log("Lambda executed successfully");
    console.log("Event:", JSON.stringify(event));

    return {
        statusCode: 200,
        body: "Hello from Lambda mock"
    };
};