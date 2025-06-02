const URL = process.env.API_URL ?? '';
const API_KEY = process.env.API_KEY ?? '';
const API_FINGERPRINT = process.env.API_FINGERPRINT ?? '';
const START_DATE = '2025-06-01';
const END_DATE = '2025-06-30';
import type {EventBridgeEvent} from 'aws-lambda';

import json from '../../test.json' assert { type: 'json' };

export const fetchBarberData = async (startDate: string, endDate: string): Promise<Response> => {
    return await fetch(URL, {
        method        : 'POST',
        referrer      : 'https://booksy.com/',
        referrerPolicy: 'strict-origin-when-cross-origin',
        body          : `{"subbookings":[{"service_variant_id":12105956,"staffer_id":-1}],"start_date":"${startDate}","end_date":"${endDate}"}`,
        headers       : {
            Accept           : 'application/json, text/plain, */*',
            'Accept-Language': 'en',
            'Cache-Control'  : 'no-cache',
            'Content-Type'   : 'application/json',
            Pragma           : 'no cache',
            Priority         : 'u=3, i',
            'User-Agent'     : 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Safari/605.1.15',
            'X-Api-Key'      : API_KEY,
            'X-App-Version'  : '3.0',
            'X-Fingerprint'  : API_FINGERPRINT,
        },
    });
};

export const handler = async (event: EventBridgeEvent<string, any>): Promise<void> => {
    console.log('Received EventBridge event:', JSON.stringify(event, null, 2));

    const resp = await fetchBarberData(START_DATE, END_DATE);

    if (resp.status !== 200) {
        console.error(`received error from api: ${resp.statusText}`);
        return;
    }

    const json = await resp.json();
};
