Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C52C9832F
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 20:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C569410E123;
	Sat, 26 Sep 2026 20:59:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="JFnX+4uG";
	dkim-atps=neutral
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021087.outbound.protection.outlook.com [52.101.100.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44F4D10E123
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 20:59:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+zJTf6DLMTcqTDNR1OqCyhFSOVUKENUKkOcQ+0LBrq7HDSULZwrnCznNJ7K28vt6973w9SUDiI5ex8lquBluU/rjspX2qoM4Za0TvLB0vTgtSInm6EFtWHtYDEi5U4pNo3VgocwEe8s2xCkYteTHbungg+c/iP3rGuYDEW6igHgaJD7lgsvPgoW92KanYXaO6WKbOVZpJo62aCku/wzLEE9ybpMkolbMb2EpH7va1RvfPsMTZU+tdS/D55EoIa591bmf1r1UFHmL1+jxUTiuaRsqsOL8NAfGg0gEufNcygv/cM8Xrkdq28WRrG7sLIK2mf+JfbIDZLWfrMcvEptBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kr4++w1uAHwd0Le0YbXbhQ0HkzO8jaQLFkYjO/7fQzE=;
 b=yTZg/t+5l/vqVcfGdkHDa+ghV00JMUKOf/Fj5DOcCGjVxAePNopBddOWHjSys1yHYVlNRQ4OM/9+KSWsZAIKtOwBshPCdcQ0JgEfRib3ECZxHZtYYfzJvbREO8nvBcW8EhcTr4ab+58JFpWOxoKg/ibQB5PWq50zIvMdftpTAso2F4BP1YBizsAMEqWi/xijSalFRcPVlKJLk79mBz9GCqrlouphQCiJtmrZr+pCpYnqbu27sBm2TlHSEInJZShXQXQO2TH5ByrErz5sAYCbC9wtTsqvivPH6GTM5xgZGIFE1m8Z9eJz7zGhS2vaMnM1Z6fq4+ql4+lIf/A2XMCh9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kr4++w1uAHwd0Le0YbXbhQ0HkzO8jaQLFkYjO/7fQzE=;
 b=JFnX+4uG1aL8IVgrJZhil2F8UjfS6TMh23eGj+wiZ+Hd/0dM+hPd/UfLm580N5H0rZdMYdW3TNynuIZCIsGEqy2rCTjCP43+unK/bhmVUOyrews7Z9h5tfNQsqY47zAaSC9mOIyXb+XFhoCHk+PSoxWguKOSwZkufUF4BCsts0M=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO4P265MB6965.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Sat, 26 Sep
 2026 20:59:13 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.014; Sat, 26 Sep 2026
 20:59:13 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Sep 2026 21:59:13 +0100
Message-Id: <DLPJT1IUSKQO.1CAWHDECQAFPO@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
Cc: "Deborah Brouwer" <deborah.brouwer@collabora.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] rust: uapi: add zerocopy/zerocopy_derive
X-Mailer: aerc 0.22.0
References: <20260925-b4-gpu_info_intobytes-v3-0-e19bcb71980d@collabora.com>
 <20260925-b4-gpu_info_intobytes-v3-1-e19bcb71980d@collabora.com>
 <DLPD8RQKM8VU.3QWOV9RFLA8S6@garyguo.net>
 <DLPE0D8F96DE.91C7E0MAERDS@kernel.org>
In-Reply-To: <DLPE0D8F96DE.91C7E0MAERDS@kernel.org>
X-ClientProxiedBy: LO4P265CA0250.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::12) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO4P265MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c4f829-a1bd-429b-203f-08df1c110528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|7416014|376014|23010399003|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PCndnF2MW+WdCEgd9kmOdIvi7gV5S4QKQ1VbTc8zqyPJt16ICzIqtFLSg48zoCcWDnCQ/kJnX1F7VnBKDZhDrJhxIHVwfXoS1sSFQtIAI35DRUlTFcBoFwMoysQLWJbX08KBeXRSku2y8YRjLUsDX2Ey8iN/6kzmgv7Rr1JuVriR/EgCZzua7WqV03m5NNYhBtRlFuz2+eYg2WHxZSUSyLvRUJQ0JUf2i75Bi38yH7nd1QxzDpr52iBO3ZzT2cZY8K0mrY94csS8Bau6ueVxjjoBfviCGpRKmpnd8bTWDhpR/twsk+NsHkp7OVnsK8+UmWrPSmGYiIytqzB0zZQrr64UXakbRVFEQ6XVjzAKdICucJP/V+OjDOp+DjDVt+SQd24M0dOUMKxT2fsffA/ScGsjjETUWU/KW7j8PpeICsLxHBnPOVwFVLBowep9tI5ffWB25uZPSNobVSTL+ltDBr3DFYq4iWOB0lpPoJNY1w5GlQJMB3V5cHTw1toMuCmatiqQMzJAJl18+KylzJ2ayeb7CB6cJ4RkMFGfTw18RF6mK/UlMe/iYLdsub4JCo2DJ57cGVUCwc4Dk23r53zPuKAI/UbGnqFoLuEk2uePP6QGENwlkKv3463BdMVkE0beDXDh4Lwolp57M1+pAht+PUCVoilW2Tyc0MwT+RQqCBw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(23010399003)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHhwTHByU0FSa0RxU1RXSlo5WHNUMGhoVVBVOEswaldzQ3V0eGRKSER2dGJM?=
 =?utf-8?B?UXRzcnR1aUdVVzFLNTNZeDUwK0pqVnlUanU0SWNCZXlDUEc0Y1o3Y0ViSldF?=
 =?utf-8?B?bGEzT0tVVGxzeVpmV3o0bHZKVThmNzZMdEVVdGwyeXJ5aWFyT0tsWDVoeXhZ?=
 =?utf-8?B?SnhVZEpyU2FmQjV3bzdDSGpsWmhaR1daSkxKNmdaQVZFek1GKzFHR0daQ1dO?=
 =?utf-8?B?R3pVSE9RdTdDTEMrZHYyUU5jVWY0bUhJSnozaFd2MWdjZDNtRWhYREh6cktX?=
 =?utf-8?B?S1RlSFJjdlp0YmM1OFdSOGcxMkY1SGdOVGNxZXBCREtqaWtvU3dKVFV0YmJx?=
 =?utf-8?B?WU40R1g2Y0RiZ2d4RE4rMlRzS3lHS1ZxTWVDNk1TdWNiMGtCODdubHZsL25U?=
 =?utf-8?B?TE45VFJqSGtITFoxMVQ5WjNXeFdiUGExa3M5MmVjVkI3cDRTbEU5bGtMT0ZL?=
 =?utf-8?B?U21RSzk1WTdsNXZYVmFUMkJSQTVHUkZ4dzFxRjNqL3hQVnJIcHIwTHJQMldV?=
 =?utf-8?B?eHA1a3RBRGZVZ1huU3RQRnVXZXpvR0xEYXI2QStCdmZXU1FHZnF1TDJDMFcz?=
 =?utf-8?B?bEtYdTZzdUdwWDhwck9VOFBTRytEMHpHTjBQRXRyS1F6eGY0bURNYnlRZzJn?=
 =?utf-8?B?QVRGNXNiTkVKMzlGVlVwUXMyaGJHS3c3S29INVNuOWhsRjFORVFUM1grb08y?=
 =?utf-8?B?OC9ERmtkdzF6K2wrSXlHUXg2d0Q2bG4wa1JwQlNkeFh2VnpEd1hOMEp4aTRU?=
 =?utf-8?B?Mm93NXREOHIxR1BYeFFPZ0lOSkR6Y1p6WkxrTjZwS2VXZS94eVRaNkxUV3B2?=
 =?utf-8?B?cTd4V2R0TjVsM0dNbDVZTk0wZS9zL3FIa0MyNmtFSnhiRnN6Z3FlRjkwQ01a?=
 =?utf-8?B?THdkeGRLOGRiTDZ5ZEFMUnNnYVVQSUJWRk9ZMmpzdyt3RVRiMGdoc3dDaENu?=
 =?utf-8?B?UzFBb3kwcFlPU2Y5Vll1NlAzekx3eC9mZGR1SnBwVnFNWmUrNXJNdjkyK1RN?=
 =?utf-8?B?WEt2bmlkTDhFYWZ1SkYrb0FJVExMQ05JWktTNHlLeWl6SFZRTU80NzR2aS9Q?=
 =?utf-8?B?a2s1L0lsOTVqdFc0RzlFM1BCUExmNGNGOE9sU25jM3VTYk9LY0g2d3JYSmxB?=
 =?utf-8?B?T2dBazVLOThpeHJRVGYwM2xWM0lEL0YxRE8renNGYjlRRW5DaXZrSEFlamZG?=
 =?utf-8?B?ZHdkNGJPdlp5UTg2Qndna3BMSWFNMDJaaG0yczJ2UTJvRlA4UFF2S2NsM3VI?=
 =?utf-8?B?K2hJckMyK3dSYlh6QkFCaloycXFaeUdZTFhOWnFLZTNLQXM4bHpxOXRYZlk0?=
 =?utf-8?B?LzRsUnpMWEtmRmxTbndHdDVUNXZPTm1IWms4RzRNTmVHMFRmMWltYS92dVQ5?=
 =?utf-8?B?NlRCVjFEM0E4UkYzanA4K0VXSnptZjM3cm9MU1BnRkpsT2lsd1hYL0VaU3RI?=
 =?utf-8?B?NTJwSGpoVHBYOTh4akZRblpDcUNuT055T0xwRDNkMENUckx4WWhVSHRveDJZ?=
 =?utf-8?B?MFN4TmgxeXlsdzBpZk0ySTBRblZuTEF3bGxiMmFNblg4VE9uakE5bGxzMDgw?=
 =?utf-8?B?ckJET0c4Qk5SSzQ4VVBwcDFRdUtGVnVhQ1BjZ2hqbGFRVVV4N2dZTE9RdXFn?=
 =?utf-8?B?LytTc2Y3d3h3azVkdDQ2M3NvL2dPbFZPVG5SMlF1bkwvbnduNmZ4dXp1NUE2?=
 =?utf-8?B?TEhlU1loUGNjWmMzSWtUQklIY1M4M2pFbFo1bDlQWW95cUh6VTRlUkxLMXdC?=
 =?utf-8?B?WWZzZGFqbWFMdGZzbjJyYUlEeEtCekdJUnVuWVNPMU04b0ZsMjkwMUV6Tm9h?=
 =?utf-8?B?b1RLYURRQlJHaTh4aDZIMlhoZUVlUjJpUnB6T1ZWWGJCZERPWmdpbW1OQmxs?=
 =?utf-8?B?K3Z1a1J1VGlieERKaEJzWVF5YUZocVNFWGZ3NHluZHFVc1FpQXl0RUJzMDhH?=
 =?utf-8?B?TWpXWk92REJrVkllY0JIZGlONzUxODFORUdsVlpZT2Y3Rk9LL3pXMzFFWlBY?=
 =?utf-8?B?OVRRM0k1MjlGVmhTa0R0dHhEWnZTYnVmdVJBL3o4c25mME92NHhpeXJ1Y2JI?=
 =?utf-8?B?YURYQS9RNmRPZWY1VG9hdHZIWFhhN3VzdjhsQ28xUEZkMklpNnhJWURHSmRt?=
 =?utf-8?B?T08zSEtEMVlDUytqTHlSeXBINkZCZW5vQkdEWE5QNjlVSG5ISFpXM0dEcUVs?=
 =?utf-8?B?YjJLRUg0Z1BxWFhvd0tBb0RWdTNUQ0VENmZ4bFY1dE5kRmk3RW5sc0Jrd2Nu?=
 =?utf-8?B?MmxyN3kxR2l6RHRHVGlGRnNsZ3UyUnFkTk5CNFJFcEJ3R3g1bWpPS2RJNm5K?=
 =?utf-8?B?OG5hekllSC9HOVJrMDFwejNGVXZVQlowNlRGMUIrRmF0bWZyd2Jxdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c4f829-a1bd-429b-203f-08df1c110528
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 20:59:13.7500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDvd85ygOgCx3D9j1pO8KJh8jZfvx29AFhsj6skRyecMWBCSdBIp7wh4DWpjxx/u+PVL4uaET4uVvpljA6Zd5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6965
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Sat Sep 26, 2026 at 5:26 PM BST, Danilo Krummrich wrote:
> On Sat Sep 26, 2026 at 5:50 PM CEST, Gary Guo wrote:
>> On Sat Sep 26, 2026 at 1:26 AM BST, Deborah Brouwer wrote:
>>> @@ -71,3 +71,6 @@
>>>  # Structs should implement `Zeroable` when all of their fields do.
>>>  --with-derive-custom-struct .*=3DMaybeZeroable
>>>  --with-derive-custom-union .*=3DMaybeZeroable
>>> +
>>> +# `drm_panthor_gpu_info` is copied byte-for-byte to userspace.
>>> +--with-derive-custom-struct '^drm_panthor_gpu_info$'=3Dzerocopy_derive=
::most_traits
>>
>> This is Tyr specific change and should be in patch 2.
>
> Why list all of them separately? Can't we apply this to all uAPI structs?

There are types with paddings which cannot derive `IntoBytes`.

Best,
Gary
