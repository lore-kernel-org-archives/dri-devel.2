Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B268B606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 06:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bYIzSwcw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C42B10E2EC;
	Mon, 26 Oct 2026 06:46:07 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE0B210E2EC
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:46:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBa2lKBbTUyxzFIKFA2/KadRHsCOomdlQNiMcRTopM/E3sD3yro9DkXWVd/VW8lUH6t4QOY/PX6v7EUGiaH2fVXrcmBvmC0K3kaiDdRnP+7NTkG0eQjxtuLiThg3x906LC+6Uyy1Fk+iNRQOSs5XIrc57ms8tQJrzc/Sh2EMpOsNTQf5B04Va52HJGJLdmaefy0KbiyGDS71szyLN5kQpr+iOzPitjYITseFta7vJpxsfqdfFlREqU14AT0BHZZDlncTQHJg45VpoXuIZs66stZSpGLAsUKQzAT9prR11qHlACRfEht6w5EGRU4Rg0vQIDzwm8qvooqiusDBuOw74w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gScKGLauzqGEz27PQt5r4mP7krYePINnm+Ke1uP/ANc=;
 b=E2uG7vYOKU1MknPnm3F6QB7F+ucArhFHdLOfXbZ2+w2ysK5lRjiaGp4MHrN0E1BaozDJ2aAN0Ukg57OdTz1n35wIf/p05qEh3504UMutTF0rRk8ivCdhO1qR3fyK9rsDRe3R+Af2oth8/2dtRVqm0NIX8vmjOfWkF2/yYDEnQN1eb4fJ+zQoI/9YXeXF9mdp8FA8+MRKpcU+pc6Zz8GnkcLFPuCZyCte4CsiHQniHoPUignGhDnYEpk1DD8163sX/KJeT92tD4mdoKIP6O+XRwLsPnCbCkQ3f/PRSGVfpGkRzpz8J4Q/5oX5BV1nLusWiK1uFAax5pg8KpEW5yg6yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gScKGLauzqGEz27PQt5r4mP7krYePINnm+Ke1uP/ANc=;
 b=bYIzSwcwFC4nSzjjeXYFt1HwmYDOmjZkwNDKsu6RoziN20j3UQQYIUKJusBkOXOHiWK4jpFddWdkpBd8VcUJgP5D5yNdrqgpuk7U9mqrSpgkbYKvWdMnbXJIS+c+sYnjOTwH1WEiimzx4MN0JZjDtWqZ40L3+EhbOFtsgGX5J2CL0fju1y9x82RjIF+boGIKC9hvW9BYBoEfHA9cJjYH47ZxfAxz/xB4X5VWBbEDQ2SRWr9mEaSZGPsQUlihOvFKB8vKI6UGUr6Pu/rYpbEqK0qXC2LrPSkX265D9G7PgBU6PZmYU+SQ9McafWxy1b6xOrOC42DjZVzqfR7HRoF2kQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CY1PR12MB9604.namprd12.prod.outlook.com (2603:10b6:930:108::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 06:45:57 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 06:45:56 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Oct 2026 15:45:53 +0900
Message-Id: <DMEKG15PB803.2T4JUPAN0HAH@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 5/7] gpu: nova-core: add NVKV typed encoding
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20261016-b4-nvkv-v4-0-e8b92b91aa5b@nvidia.com>
 <20261016-b4-nvkv-v4-5-e8b92b91aa5b@nvidia.com>
In-Reply-To: <20261016-b4-nvkv-v4-5-e8b92b91aa5b@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0196.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::20) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CY1PR12MB9604:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb3c29b-f762-4848-d8d4-08df332cc9b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|366016|1800799024|23010399003|11063799006|4143699003|56012099006|261021121427099003|261022105027099003|261022075727099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: UkGFS3iDpLYD0dyqxUiRjKIpWqj/kExOY3LK0Lp+HhKWGJ89+obZ+q4vjGK7gOVj6zLBRBLohl3QyjbsknYj5LIoAXAm6t+YT/+yicqyPxroTPI6BGLQxolVk8dXzWCRu2hZRmb1S5EUbsi+8nuwt5Cqe7NtbHg9HU6WGezwmwD2vuwmZAW5Rlf9eaKPsphZ+N3kD7JCcgiSBzVoba2ILMWKzXirUdNLe53CwuMgibpu41X/3yeBa0nWCCDuCygxTfmXJPl4zKkr+UAZyqCTUtGRhdswYV6EIZpoJSQuK3yV63cXcj9Q6JHJvQOcsilN7y3xPYuOel3t/fpKQUQFv1IqetOiVZaE16wthT3VLbCAJuHWX1zVsqYO6eYdp6Gg2iIyjR1/bCUewFaU1MeIAf3BerOArj3a1rMh4kM8j5Jqx4xrInZrFRZtyauJBjxZeJkMEAGT2amGgqbbYjoBzrlGXnn/oubfGsPHv52DgQ8zZLKzPtRSI8a0x0ELWCIfLqG6Wvm5DsXWinSBo7ILT55r+ubMLown6nerK7uJizq0ObusmnmL+T05Cq7TGV9bda7sYMbfVbrS3SVEJhON6732drw3t+itd3LnmeWSjwF69ZH2x2cyvHm+RjAIHhbfDAedQEr9hL9e0YAmo5quNgbns5ZGEpkb0+6cTMYsxhY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(23010399003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022105027099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWZXS0VxUW5EcytKVDV5U2FqL2U3WVdlZlh3aTh6WjkvWXI0SVgzN1hZWHVu?=
 =?utf-8?B?RkN4bXViSUR2YXRYVFh3UngvRzUyWlY0R3NmM0lmZ0hoTlQwaFNOYnh2TDEy?=
 =?utf-8?B?d0toWmR2UkpDSFVCaERvamdqQWExRzIwSjBPTnlGTVUyQ2dSSVdSdVd2RXZ4?=
 =?utf-8?B?Z0hoeVFYN1cxYUpXaU04a1JxMDk3VW9OSk9tSVR0QnBCSExhZlpzR0RrT1Nv?=
 =?utf-8?B?eEZ1ZlNKVzdweldQL015WTd6L3dpQlJ4cE1FMUZZN3NrS01NeFN6SlVOZXQr?=
 =?utf-8?B?NzAxcjlaUGF1MHN0QndJemQ0RWNqb0VOdWpYYkdIREpqdEFXSUpZKzVVUW1z?=
 =?utf-8?B?OEFKMm5qcVk0ODByL3hGQys5SFlnR2VtVDZYdVJOU3hCUGJ4eE93TEtjTXd1?=
 =?utf-8?B?NGJWZkowWEdodGRJZEh2RkhDWkJZbDN1eGk3OEtjaUtZYWljdWttcEZZUEQ1?=
 =?utf-8?B?NWJSM09ocXptb0h5aTFOUng1ZGZmQUpYemxRcm0vQ0YyTndjZklKTVhLS014?=
 =?utf-8?B?ekhZeU9xZkNvenN5TE9tZlkzTUwyM3RjZnd3RUtPM0o5dGhaZVYvRkdEemxz?=
 =?utf-8?B?S0VJVGF5WEU1QkVpTFY4K2k1enBTcmExL284NlpxaVlwSldqbjlmcmF2TE1T?=
 =?utf-8?B?Rzc0dStRcW1YQ3R5T0NxYmh6Z0MwUUowSjhNOEZkVmlTTlJiMXVud0pCWjdB?=
 =?utf-8?B?SDlBallSWVEvc1Izd2pycEtIMms4dzhDK3dKTllCVWN3UTNCcEZ4Tjh3ZS9K?=
 =?utf-8?B?bit0TVVzWHNwWVp5TWQ2QzA0aWI0MjJCZFlWcng0SkpiZzFCZUMwSE1BbG0z?=
 =?utf-8?B?UXRrc0ZHY0pQQ3g1b25IdnU4a1lrTmVzMUJQRmR2N05YUUhPNWZ5eWVNcW5a?=
 =?utf-8?B?RHppcUtneXpsTFJ2djRzeGJMcW9TMlU3cU52YWQycWdyaHVSVTZSQmtKbnhu?=
 =?utf-8?B?ak95SGl6RWNhZFFYQSsraXBBaG5NOTluRGpCcjNDdWU1ck5pTktGa1p2Vk9p?=
 =?utf-8?B?d3NCQXNHcEg2TjhqNkttUmI3a3hiOVJVVlpDOVcyWEhGM2l6K0FKUE9HRjFW?=
 =?utf-8?B?ekhpdGw0S3RKR1hMUHFmaWJkQ1Y5YjNra2huTnFIdXBlL09ESytQcWRFcjha?=
 =?utf-8?B?VlB6S3JPT3Q2RDRLTysyeGZNQjY2UWozVHB6NTFKTXh5YlZycjVhay9sMC85?=
 =?utf-8?B?SEkrKzBtSWdoRDA0OWZTcG85aXVnajNPcjU3RXlpZjlNK1dkYmNXZlNYcXIz?=
 =?utf-8?B?U0JVai9SNk9ZS09Qelp6S1dkYlVZTFFaVlVNYTYvWTJpRjA0R1JFOEl4Uzlm?=
 =?utf-8?B?c01xZTNvM3lCdVMybXNmUjMxVG42aUR4Vnp2Q2ZYZFhyVmk4YktQLzdyZEpW?=
 =?utf-8?B?Q0I0VlJzYitZY01kckI2YVJnUE1kTnlvSlJYcXV1U1pKbTEyL05IRVNLdHRi?=
 =?utf-8?B?RFlmcGxLVzNjUlpYSmxqeWI1QmcvZGxRdERkeXBzdld3Uk8za1hHYzJMSCtO?=
 =?utf-8?B?TGZlbzdvaWhLcE15MzdTS3FmUU9hUEtmN3Z0MDByaUNDZDhhK0RaSjhpOEtZ?=
 =?utf-8?B?YUlleUd0MXhIZ1hjUDdtNDJQM1dTcXN6SUYzbmdHTTFYT2t3Ry95MFU4NFkz?=
 =?utf-8?B?a1BFenZjdHYwNzBiVzMyUzQ0bjBxQWEyMEx1N05SeXNWLy9nQk5QWW42M3lL?=
 =?utf-8?B?ZTZseFhZL3dHNnA3dWNKd2t5bnc2cm84V1pSZUhhVWF6ekI0MlZUQmtGZ216?=
 =?utf-8?B?RlFSVytZRzE5UzF1UjBQak91RVJsVXJSTGhPMlEzbXRtNERDL3Y2eG9LUWFU?=
 =?utf-8?B?ZnlMQVZnaWtremRqOGh6RzJzdzZBUG1qL3JqazZzR25XU1Mvemh6QWtGdno1?=
 =?utf-8?B?TWtoanZyM0lyMlBwYTF0cnRTcEZ6S09BKzV2QUZUWnliZWdyaVlxaXpjVjIw?=
 =?utf-8?B?dHpnNk9yWWUyNG9JWXovVi9FMjBhWm9pMVBjSVdGUkhuZTl4TVg3VlJ0eTV2?=
 =?utf-8?B?VGdxR21jU0JLUXhSbk9CRnpsU1dtOFFxcnluL3RvWVd0bTdxM3laUEJuMlo2?=
 =?utf-8?B?ZFN6RDFxT1RKRzVQc3FtYkVsVFpVOHFLUjBRZUpWV1AxM1NQT01ydEZ0cnZB?=
 =?utf-8?B?UktXclZhUW9EUU04dkJDRVBwNWdXbFV6YmZWYWlnU0I2NDVud1g2VW0zVnhl?=
 =?utf-8?B?QXhuZjFZUW5lNzgzdkc3MStRWmpTcU4rSjlqR3BLdmwwSUc4bFVSVG1jWmxm?=
 =?utf-8?B?WUpqancxZ21sdGhoS053dW1KVTgrc2w0UHN0N2JZdnBXOXN1bms4dFIzcHpF?=
 =?utf-8?B?dkhRN2xuWnBYdWpqcWVoeDM5eHhsUE90b3NjVDFENUF1UnZtUVVndUNOWEdU?=
 =?utf-8?Q?Q8jMwSwi1SSXYy4kJsXPeNo/lOUV8JhEjGszzskH4IMxL?=
X-MS-Exchange-AntiSpam-MessageData-1: zxE0SQTCLu++Kw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb3c29b-f762-4848-d8d4-08df332cc9b5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 06:45:56.6946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+CStYt2/y+B0WSkJemdHWLbbmFEHNrfl0JeE9uETlUYKfWriIrJdG3EHj03P80QwqqZ9cAR6rZ+LnSYcsgZpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9604
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Oct 16, 2026 at 10:53 AM JST, Eliot Courtney wrote:
> For struct-like GMCAPI messages encoding field by field manually is
> noisy. Add some type machinery and a macro to automate encoding of
> struct-like messages. The `Encodable` trait can be implemented by any
> type to say that it can be encoded into an NVKV `Encoder`. Add a simple
> `nvkv_encode!` macro that works on structs and encodes each field in
> order. Provide some base types, such as `Key` which statically
> associates an NVKV key with some value, to avoid having to make a lot of
> newtypes and implement `Encodable` on them.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
