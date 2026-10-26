Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CBE606A325
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tfnQa80g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FEC610EEB1;
	Mon, 26 Oct 2026 12:30:12 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012021.outbound.protection.outlook.com [52.101.53.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D05610EEE2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:30:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nce6DRY92trok+l8sgP0yGWqKxLcgnAPYj4rvo4nRiNlsqfBwH/U0a4flFkpHiSVOfKowWA3IJSwFDQDM44terMUGumP0bdYBbnUFa4AN8q58jvzYLd8FUMZiUkIKPZOgcKFiUX2HPnR3qX3kTM/y/oFEl72nips4d32o7BgbCzVTeKIGbIVLr2T+GjeyEjumW0lhsPW6bZ/saDjo30Xi3Yt6LwXC9A/S2QModIWrha0BXuK9HlCkhM1fH61vXymdYKBi8AE62RYnDc+DmHrj1Q4R/NrLpBlr861zrgIi7bSsTkbOaWD5A25Ilurvn91N9jXLuFFl8tareZfqUPrFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Idlm7EDRzRSycgoet/q18BiVYzrbhzykbCttwUtOoI=;
 b=UlHzzapIvVHPgKPGeb0K2oLNWPDiZI030Cfac77hSFhhhb2aGv9z/cJ8xGupI4S6dbLsc1I8g/ISAlmI2mUqHXgZaH1Tz8WRDdPClhGRBj+C47hudxg3FXi0JnDXht3MIqHmYkV/HvBQmMivwCmgbph+q2xP/lmmKkGxRoznCN10ICwEdoPl4rNkTXx3xx3y9ePACQMpfNb99Gl/jwA/i5Uq6+XXarMUUWShQg+dPhFLo3S/hDfSfhgLgoGqERBzsFSnMSDe6FK/irmabNZnEQYyuCGdYT8NwTP9237xMagVmj+fK8mDg7/Q0taqj26PMoR4DjoiNBNp472O5bC7rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Idlm7EDRzRSycgoet/q18BiVYzrbhzykbCttwUtOoI=;
 b=tfnQa80gAod4wGFqJSufWtaLhiENGKMd7x4/OFRgjZOwTcOPyV8Asdc/Hr9jbp+Co50rYKTdo/y+Qk7YXs8GXeF4ZJ6viVjF49vQIuezzR+bMUVOFojveicTR6FV/a98vkc1iVg3h/dSriBqtGV73muDA/vBlxQ5319xuJon21bp8lKDnJYoX+paS+FFbXN8XAjqVA6K6qA11w97rwJU40oXRrc5qfHCYK2ZoYwWJX5jSWYxswnYn5P9M18TITLXrzbJP0XlTPDOeh+6D2eWCfZbnxXylbXlP1Cwf0RZznPkewGT6wfJ2zxb77zgdZ7oPXNmeE9sXwSQRJGE97Bwhw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 12:30:02 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 12:30:01 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Oct 2026 21:29:58 +0900
Message-Id: <DMERRHB51QZ2.3BHL28WN4DSJ3@nvidia.com>
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
Subject: Re: [PATCH v4 6/7] gpu: nova-core: add NVKV typed decoding
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20261016-b4-nvkv-v4-0-e8b92b91aa5b@nvidia.com>
 <20261016-b4-nvkv-v4-6-e8b92b91aa5b@nvidia.com>
In-Reply-To: <20261016-b4-nvkv-v4-6-e8b92b91aa5b@nvidia.com>
X-ClientProxiedBy: TYCP286CA0015.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::19) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SN7PR12MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: 078efd76-5bb8-410a-3c47-08df335cdb02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|1800799024|23010399003|366016|22082099003|18002099003|3023799007|56012099006|11063799006|4143699003|261022075727099003|261021121427099003|10067099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: oBatr2KltQAHT8DiNC3QhcPg/Rde1woXOZWOeJDdih4D9Wm2qVesDqyVVuOxwP49KWCZkLHXO8VaCQpLUx9GOCUca+lk36naQWE/FuLiKocAKT+mdYWSnNPi4EvBRJBILT2wO0EE47EZeo8NC6tMiGk9145LDrBybDGOlxGGNW6grdMsqpnrvcP7G08Bkm9wGNNRurNDBbn1CUW9eLo/qjBVoTN2eVILVfkHMUqVn8Dm7GWXyNGcw5P4Q4drm5CYDawyy3AgTrBt9F2sfiVwRSCH1icPrm2e/KThVFIzJmDFdaeJiT2TRBbVl1as14D0fP+u0WPH3s5P48UEdytdVB6W5bjDVoRd43Bf15moIe1v8uM2QyXhXLWWyHH6D148DqaObMGJ5sinxEEBm092wgK43zYCyJYzSutxEPsy+5uatjsAMtsSn/g48gOnKmWuo2EG9bdYBAztpR6TuhgQBY/eNs3c7FrOZCGD1CVWi62w1MpxFdMi7ArdmfR8X0JXlw8sS+w4z1Yzd6hXERJifd4WouoJkJqPgZA6BjuBR7/TIBI01oCdNZ+8jShK3d8ZhzA+n1nD6qHwRqwUOELIqiDUMpvQYjqBVhWaUynOsC5iiwM0pJZlYKoAsb0p/cxauPOF9wJIYhy3M6RsXDknS89wbxgpP2nrjQZedXk6WFo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(4143699003)(261022075727099003)(261021121427099003)(10067099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUxsbGp3K3hkOSt4S0ppRVpXVW4xQ001RWQray9MN3JRc0gzZnlsVm5yK09G?=
 =?utf-8?B?Z1dGTGJSUjBCUG5PV0g1dTgzSjlhRkNyemZjanJ1TzJjb2hKa1RMM2pIOUdi?=
 =?utf-8?B?ZGVFSEV4eUduUlZURDVCVGptOHhaTkRxU1gzcXdaZlRFVCttVURhNExZSldO?=
 =?utf-8?B?STVtaGJKZU83Q3pOaWdPZStzL1dBUUszdlE1SHhDWkFDUmtIaHJNM3ZZUjBG?=
 =?utf-8?B?bUtkeVpRcEIxUDVDVSt3SVkyeHFGZE1GSkpoU1hnSEN1NUM2WlowMmhJb3Bh?=
 =?utf-8?B?VUNacERaU0JMZS8rUnlTWVlWWjErWU5mdkhEUXhlZzdZalpYdDNwVGY3WS9t?=
 =?utf-8?B?WW42QXpXenErTEJLR1diTE5lK1NiVkhsQWpvVlpoaUdyYmlCUzkxQ3NIODZJ?=
 =?utf-8?B?WUhVTFpVNHNVYlZWQkdrSGdtalVzaDR0SU1QWHBQWEVvWU9kNHk1YkNVNGU4?=
 =?utf-8?B?WU5sWVZiOXAxYzdneVhrYy9uSCtjdFBvdnlKL1lMN2JiOTR2M0JOTEY1VzVF?=
 =?utf-8?B?U1ZiNlVUTTdHOTN4VEVpRU81ZXNRMkdQcGJMc3YvTUQyT2pmTFkydzQ1Y3ZG?=
 =?utf-8?B?MTlwYlVaaEJLU1FlQnlYTjgyd0liWlZHYlg1QjlxWXd5NUpndlJ1ekE5TXZN?=
 =?utf-8?B?Yzh5Zm51L1BTTUxrWTh1OVo1UzlUZDd3K09MTzYyaCsyR0gxT24rNktIWE4y?=
 =?utf-8?B?L003cWozTWFHRUtjVVpmS2J3b2M5U0dicGNGR3pWNHEyWk01RTBVUFlPckNW?=
 =?utf-8?B?ejBKbklyUFVvYXk1QXl4dmNpWnBYbDF4Yks0ckUvL0VRU0pqQTdUcHkwTW4r?=
 =?utf-8?B?ZDJIWGNuWmdEMStGUk5KYkJjQnFsMzFtKytEdXEyUGo0dFVITHh3M0p0bDBZ?=
 =?utf-8?B?WkdTQno2aFFZQWZ2K1IwK3NIOHNISk0wanMzRlg3cEozc3B0R0xlaldIeGlr?=
 =?utf-8?B?bHFQcEtISG1WVnRlRDFXZjU4UU15ZGdBWnA5T09xTHFsY25UYlJHQUxQa2dz?=
 =?utf-8?B?RmFhdG5jVjA2SUIzUXBrMi9mcjM0eXpVQUx5cUY2UHNzMHFtb3VjUVpDbzg5?=
 =?utf-8?B?NW5RRWxJbDdwVXJDWmtLczJTRmdaTzU5eFRUWDVOeDBoYVovRzMwRkVNaHg0?=
 =?utf-8?B?WG5TTVVDaXlRajh6bXE0ZVZNOTQ2c2pwLzRrSWFUNEJ3c0pBMGZXUms5b0Nq?=
 =?utf-8?B?L2dXTDR1MU85NTFMVk9ObmhGVmNYRDZlenJEZW9Tdmd1L2piWDVsTUYrcUpO?=
 =?utf-8?B?VEFkeDVUNjI4L3JKdGpjblhFZUc5eFQ4QlByNkJVUTdqTG5SU1dMeXRYVUhG?=
 =?utf-8?B?MndudWpsREFsdkIrc3BoTnN2ZWR4Y1hLTVRyNWo0NEpoOHRQUWowMzM3eFlt?=
 =?utf-8?B?eWFabSsySzA1UUhBd1lzb2RqSVN2dU5Gd1U5SFJJWFNQaDc0MjlFelBwS2k2?=
 =?utf-8?B?OG1uaUxBT2xvQUdIQWJCZk1ic3l5eDVza054Y2kxMGhIMTE0MHRFSWwzc2J4?=
 =?utf-8?B?MVFHT2daajdmV2xUVk96MDFvNVlMem05YlBDU0tDQldKMnMwUXhlZzBGcjVN?=
 =?utf-8?B?MkNka0hQU2hoanpCSm5BNURhOC9YVm1MM2g0MTU4dHRuMFpIM2lHdlNXZG5x?=
 =?utf-8?B?MzNnc2dta09ERkpLV2phVzgzTUZLdFd3Z1FLeUtYekRNaE1STkErMW56ZVBt?=
 =?utf-8?B?TVlueXpob3Z2U1dZQUlQNW55TnNyTVUzamlWNngyRmh5cjhTcEI1SzlTaHJB?=
 =?utf-8?B?b0tqYkR3RytYL2d4NWFyekxUOWVtVHhNN0JaUTFlUEVsbi9yVmNsc1dUWVFh?=
 =?utf-8?B?Z1Y0bU9rYTFmb0g1R0ZyQkVuQjVnWFJ0bzduZDZFdUJNYm12WXNFZzhsTVJH?=
 =?utf-8?B?ZDIwYTUvbkFpbGR2SHB0all3cDd1Z3l0RU5JdGdkdCt4bllUdk83bUdFdUs1?=
 =?utf-8?B?MS9IbEZUZmd4cVdBcGZjdk9zM0ZFV2dEZldoZkJpTU4wODNOOTN0amJPZ3Z6?=
 =?utf-8?B?cWlEUW15bytVQ2dDTGxnTUo2UGhvempVYld4WXcvcHRTVlZjVHg4MVRDc2lE?=
 =?utf-8?B?WnljdU9vMm04eENiTE9oczA0c3Y2Wm81ZU5oUnROdGVIWCszd3hKc2lIV3NI?=
 =?utf-8?B?OWhxcnc0K1lRbG5NUTZXc2hRclhuUnQ5eHp0NDJwVVhQMk02RkkwNGdZSEJq?=
 =?utf-8?B?MXJxQ1lGMlFOTkRrUVJ3YVhaWlpqeUE1NWtPdDYxMkw4UUllRTFPYmkxV0NJ?=
 =?utf-8?B?TTFVeTFPa3prcDRzUzBxQXUwQkQ3WTROTFd6TnVTSlNHU3dTb0tQUHdNb1h0?=
 =?utf-8?B?RGZENllxTG5ISXBBUkJFTU1YZnBCOGpDYVYzbzlOVVAyVkozWFJqcnc3WFhU?=
 =?utf-8?Q?nbCqgt3ANazSK8g47NbPnvo3XiX6P4smZkKTO8RyOWW0W?=
X-MS-Exchange-AntiSpam-MessageData-1: 9F6SDeOz0ff4ZQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078efd76-5bb8-410a-3c47-08df335cdb02
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 12:30:01.5779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qeyDY9w4lxjTbkLydojgSPqtyYlZtmzGUBhGCy0txkfF0h/iPTL0ejR4DNC6T/ygmldUmkbBPT33Sh1LaUSXQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8101
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
> Similar to the typed encoding layer, add some decoding type machinery.
> Add a simple macro `nvkv_decode!` which implements `Schema` for a struct
> by composing visit calls to each member. Add some common `Schema` kinds,
> such as `Array` which collects an array value into a fixed maximum size
> array, and `Required` which fails a decode if the value is not sent.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

A few (hopefully final) nits below.

<...>
> +impl<T: Default, const KEY_ID: KeyId, As> Schema for Key<T, KEY_ID, As> =
{
> +    type Target =3D T;
> +
> +    fn init() -> impl Init<Self> {
> +        Self::default()
> +    }
> +
> +    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
> +        const_assert!(
> +            size_of::<T>() <=3D 32,

Let's use a constant here again instead of a hardcoded value. We could
share that constant with `Encodable::encode`.

<...>
> +/// A schema field for an array value under the NVKV key `KEY_ID` that k=
eeps at most `N` elements.
> +///
> +/// Unlike [`Array`], a longer value is truncated to its first `N` eleme=
nts instead of failing the
> +/// decode.
> +pub(crate) struct TruncatingArray<T, const N: usize, const KEY_ID: KeyId=
> {
> +    vec: ArrayVec<T, N>,
> +}

This is basically a copy/paste of `Array`, with one line changing in
`visit`. Is it possible to just wrap `Array`, proxy the methods that are
identical, and only duplicate `visit`? (or better, have a private
function in `Array` that is called by both `visit` implementations to
reduce code duplication even more)
