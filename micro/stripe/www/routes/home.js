const process = require('process');
const express = require("express");
const router = express.Router();
require("dotenv").config();
const stripe = require("stripe")(process.env.STRIPE_SECRET);

router.get("/", (req, res) => {
    res.status(200).send("esm-stripe is ready!");
});

router.post("/payments/create", async (req, res) => {
    try {
        const total = req.query.total;
        console.log("Payment Request Received: ", total);
        if (total > 0) {
            const paymentIntent = await stripe.paymentIntents.create({
                amount: total,
                currency: "usd",
            });
            console.log(paymentIntent);
            res.status(201).send({
                clientSecret: paymentIntent.client_secret,
            });
        } else {
            res.status(404).send("Total Amount is less than 0!");
        }
    } catch (e) {
        console.log("ERROR: ", e.message);
    }
});

router.post("/sub", async (req, res) => {
    try {
        const {
            email,
            paymentMethod,
            price,
            productName,
            productType,
            planInterval,
        } = req.body;

        // CUSTOMER
        const customer = await stripe.customers.create({
            payment_method: paymentMethod,
            email: email,
            invoice_settings: {
                default_payment_method: paymentMethod,
            },
        });

        // PRODUCT
        const product = await stripe.products.create({
            name: productName,
            type: productType,
        });

        // PLAN
        const CURRENCY = "usd";
        const plan = await stripe.plans.create({
            product: product.id,
            nickname: `${productName} Plan`,
            currency: CURRENCY,
            interval: planInterval,
            amount: price,
        });

        // SUBSCRIPTION
        const subscription = await stripe.subscriptions.create({
            customer: customer.id,
            items: [{ plan: plan.id }],
            expand: ["latest_invoice.payment_intent"],
        });

        res.status(201).send({ subscription });
    } catch (e) {
        console.log("ERROR: ", e.message);
    }
});

router.post("/cancel", async (req, res) => {
    try {
        const { subscription_id } = req.body;
        const subscription = await stripe.subscriptions.retrieve(
            subscription_id
        );
        if (!subscription.cancel_at_period_end) {
            const response = await stripe.subscriptions.update(
                subscription_id,
                {
                    cancel_at_period_end: true,
                }
            );
            res.status(201).send({ response });
        }
        res.status(400).send("Subscription not found!");
    } catch (ex) {
        console.log("ERROR: ", ex.message);
    }
});

router.post("/activate", async (req, res) => {
    try {
        const { subscription_id } = req.body;

        const response = await stripe.subscriptions.update(subscription_id, {
            cancel_at_period_end: false,
        });
        res.status(201).send({ response });
    } catch (ex) {
        console.log("ERROR: ", ex.message);
    }
});

router.get("/get_sub", async (req, res) => {
    const { sub_id } = req.query;
    try {
        const response = await stripe.subscriptions.retrieve(sub_id);
        res.status(201).send(response);
    } catch (ex) {
        console.log("ERROR: ", ex.message);
    }
});

module.exports = router;