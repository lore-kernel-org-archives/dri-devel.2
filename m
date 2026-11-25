Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7D8606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=ku+KA1iS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EA4A10E35B;
	Wed, 25 Nov 2026 22:13:02 +0000 (UTC)
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021097.outbound.protection.outlook.com [52.101.100.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1BD710E35B
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:12:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZUStIEnFf8Fz+l4Xvzd/qCmL/gn9P6lPwxJo8cCekhoD5MLTUrlZ3ieZeWWhTSs0wx//EQpfaqGHUNK/GQgGgrUqYPPOapl7/9mRxZtQMn7K94jlF88v+fmjklomvubSbj71uLHLOkziNCizucDa+LXQtFFn/eD0isnBmOqp3CKeahYVIWjWta+jhWYL0iDCAjwqGoazU2UNA3D536tzngq0ghkM4xpb4jTu0IIoihI90mz9RQdDNOB87/KqQ/BqXNk2vDYZ1CQn8AiY/TYqDiOK4hWdU3cxYfmraIzB7xisE4wn0Y1cu+9dq0cH8kwsrfdQqeodgjL+TvOo0lPxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsdO6RD7XQwRwfDQ/y4mkbJytJYLKhMsS9XdnqbOoX4=;
 b=kee8VbSWcTEESVgABVxOpaDHQQ2rBdHQXLkbfnQ5tMv1m9DwPPsGjQwpI7yM6nN49OD/20jzL6isIwxwp74KNja+1MZgEyMz6oVHurgFWe2FkT6E3r4wB2G2saLz67ZjYdBbC1uMG+IiXvrDFSzVizxJ3tg5FlMlBZHCQyZXdSRf0jj1t4ZBGKfVjcUUB0Q3akZYkogOqucGB9XhCwPpTvnfpLXDs6Gx74LOosE005p7gIUzODXhF37dsYg2tPqW46ixnop1RpMosjhCeLZVt0ghezPfgFRs8nKfF1/x9rqv255pL++d6ng67D+zr1o9cc3skqLenYrFNtphK+oTHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsdO6RD7XQwRwfDQ/y4mkbJytJYLKhMsS9XdnqbOoX4=;
 b=ku+KA1iScyAPZgz1YRwDhnnYBceb0UjqFQWFDsrKWgM3lkaJVKKwet7a4ej4gGZCI7JHH6zOmUEdlXHBaQLkK7Dl2551CrwSdlUSr1mzsnOULmktiAQ7qc7x5DuB4/YNGTjaPGsHLqbYgz7JDxEtJWA0llICPQiCBLvBzKNDb9E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by CW1P265MB388443.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Wed, 25 Nov
 2026 22:12:52 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 22:12:51 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 22:12:50 +0000
Message-Id: <DN4MY3SB0M5C.161B3Q6NDDXEX@garyguo.net>
Cc: <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: drm: gem: shmem: Drop unused unsafe for vm_ops
 assignment
From: "Gary Guo" <gary@garyguo.net>
To: "Janne Grunau" <j@jannau.net>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Danilo Krummrich" <dakr@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>
X-Mailer: aerc 0.22.0
References: <20261125-rust-drm-gem-shmem-unused-unsafe-v1-1-d6c5cb0b391f@jannau.net>
In-Reply-To: <20261125-rust-drm-gem-shmem-unused-unsafe-v1-1-d6c5cb0b391f@jannau.net>
X-ClientProxiedBy: LO4P123CA0633.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::20) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|CW1P265MB388443:EE_
X-MS-Office365-Filtering-Correlation-Id: 0739f70c-e5b3-4808-2d37-08df4b413f40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|1800799024|23010399003|366016|921020|10067099003|56012099006|261026121527099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: eIEiCAHIRrHlCkSa9uBsZqmU04MfGstQgTBrNMxovNml/BkDe7Kst9S9pr2DLZTBGA66Fin6eMd5h/chNerEqMbqbEtF3pDhA5zGZmSUUvR7rQPp0PYrKDc927DmskssIFnpXt+lqbxqpS+HoJf0VXr93ksPYgifo5htaaaDGcq/1MK187fFG4OwgoQtNWZbzc4bShM6SFcInnZojGDYoL6sml8Bk3aAGvB/tG9e/oEWi6f/YKhiGw3odGbR0l2APGsvyA35q3mHa/rqCuFyeoV2KXQHMPn1qPrbAVyfdy2FDmAm7e9veFrtTsXloQw4rmWbsAbhbK7ds3KwOTiHrDBy1l75od/EPQJXlfTJc0B1Y87FHzkWVP9MrcQ8FoHnggb2BMd8svaniXHZg3gzdQ1689uF2+2Ni8M7WM4pY0rJzQLl+Dfz1C9ehuz5LaunzF4hTvow9cZfQPHnnkV+pFL6Qo5RaQdAg0EHHvJvkDA7g4qtdhh+eR67G9uJDfbUFUMT0jJgZuFLlumCrfy3t6gxTlxnuASuE8t9+Y8iNEmcdMT5hh1wtXf0YaUb6Vrr7mxweK5cfOzDOmlrAlWVWOVKzBZf1Px5Vs+OBvRhjcCTFIUdZJC+sn5ZoF/KPuFesF0XF2pg23D/+ASiV5S+VZKBm/3lGe5p1jE4ImbcUlYXhUaUnKUb9NTHrCKNWPHe1QfuEejC29AH1K+IuvXg8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(23010399003)(366016)(921020)(10067099003)(56012099006)(261026121527099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDQ3dk9ZclQ3TVFrRlNhaXdVa1ZTZ1g4UEpPcVkvUHBWQWIvZzJvbXUzNXQ1?=
 =?utf-8?B?MkFScGFHbVRQSmR2YTVJcVpCRVVRdU92N1ljdUR4cnUvRDJtMnRFQU10SXo1?=
 =?utf-8?B?OTcxY3BMOWhOTTRycVI3blUrK2hZMjdxS2RFR2ZmV1gwMWgyZ3lBSWJBUWRH?=
 =?utf-8?B?c1hMYVdtYmNmaHc2c0lGV0hURnBwVHZHUlMzaE5TOElyb2h5NEtBQlZzZzkz?=
 =?utf-8?B?OEV4Zk1FRFdBeHBCam1SUEpwT2lwYTg1MTg0NFk3dHd0VTFvWWZ3d2NHZTlK?=
 =?utf-8?B?c3RiMVkwQnMyZ2hhNmk1b1UvSW96RzFBMmorOEx3eXd4MzIrTTZnRVErMnFl?=
 =?utf-8?B?dUIvSFBjb1k1a0loakZyaWNkeHZ2S1NJeGk5Yi9pdmJPVVl5Ym54c3ZrOUxP?=
 =?utf-8?B?akR2VlovRHlVRjlJeU1HUHY2MmYyOVpSeDJsWnhsM0pCcjdGZ3NXUzk4Z1VD?=
 =?utf-8?B?cFJmbWpoL3I5YXZmUTlPdTNhY21ZSDdEQTZrSm9BSGF0dklYT29UbTYvOEZy?=
 =?utf-8?B?d1YvTzdHZkdNeWxmdy9Mbi9zNllPOHY1SmsvQnNRbnJ6akxWbC91akhoelhl?=
 =?utf-8?B?U2ZFVHJ5aGdJTWpmT0loWVBYUHVKelBzZ0ZRaStzTE1ocm1HSlpxS2VpZWw2?=
 =?utf-8?B?Z0lhSHNqQUQrVHZQQnZ4clFCbGlockJEQStHY2FNVU5pZzNQcTVaV2F5NzEz?=
 =?utf-8?B?cE1ZWHVjdkJjN2xMYTJ5Q0lNYWh0Sng5TnBGQVY3UjZRZjJQOEV4bWtIQWw3?=
 =?utf-8?B?SnlxR2JGY0d3alUrby9ZbUJ5bmhUcFErVEs2TGorbnFhcW1wbElkOXBBc3pB?=
 =?utf-8?B?bEd3RFdwZDBTcXNEczIxaGM4OEVRczdtZUtYL3RPNng2TUpFY1pNS2VWbDUx?=
 =?utf-8?B?bjIrQTRpV0hSK1FKOFNab0NvOWFmMWxhY2NnczV0U3F5ZTVyRnNQVTNxUVlx?=
 =?utf-8?B?aHdxeURBTEU3dTNCWEN3dElOU3I3U3dhQU1MZkhKNHQybHZhM3JsYkhiUmMz?=
 =?utf-8?B?bTlKMTYzbEpnd2FjM3dNa1lrMlVFSW9LTyt4N29rMGcrYzNpVHQrenozNXg0?=
 =?utf-8?B?Zjg5MDZjWXRjVmpEQ3ovbnZ2ZXNUOXNvV2hLKzE0K1dwTUxjZTI3YTZDbGVx?=
 =?utf-8?B?bVozaVhPNlErT0ZURjlzelBqcFpQNXVyMzlZQkJjNW40d3ZDSHBveGxwNkxy?=
 =?utf-8?B?eERuNnVXdENQQmhya2IrY2Q4R1RuUGhaYlRTUDFFQW1QbTIwRHBZR1VEaFBL?=
 =?utf-8?B?bzUvVUcrN2ZKS1Z2cXBHUHRRaFpuaU9BMVRvYTloREVtL2J6NTEzVTJGWDI3?=
 =?utf-8?B?Vnh4T2JRZnFKcFZDdXR0VGt5cnA5NUR3MjhkMnpRRnF4M2gzcnNzU05xTXZV?=
 =?utf-8?B?dEQxYTZTeUNXRERSUklkMlAzeWU3ZEdiMXphM1cwK2pZL0g2cllYYUQzNGZX?=
 =?utf-8?B?VGhXQkUxdVNvemNLK3VUQllyU3c5UFd4Rmd6MXBFbTlkb2NZVTlpVlFDWkor?=
 =?utf-8?B?NG1FQ0hrNlhhaHZVU1N2TmNCL1BudkkwbkxaSWxJRjMxUVBoTko4eXRGeFda?=
 =?utf-8?B?dVlRK2drV21kV1VKL2tUdEgxTjFCS0dzVGh4bFpMam9zcmY1aDNKSXFpekFU?=
 =?utf-8?B?Q2RwczdkL1FjNDBKRTZIWXJ6WjhMYm5BUFVkS1ovWXRseXVKNHJHcW93ZFVo?=
 =?utf-8?B?K3ZjNkdNZ2VmcHRRMG5HQjNOU0podGpxekQwdkdjR1NjM0JrbUpFOGowUmI2?=
 =?utf-8?B?TVNWVDEvUUZIQU5pUnNFcll0VDdVTjRDczZ5T0g4OURlTUJ1eGNUMktXSTFw?=
 =?utf-8?B?WlpCRDhGb0RPdWFiKzJ1anNtV1pWUldSTGNpOXB0eWp2YklUZVF1UTRnWlFl?=
 =?utf-8?B?bWtzQThLc3NXUGFuaWg3bWlubVdWZDMwMjZPaEk4cUJrcUZDeW1ZQmMyQTZi?=
 =?utf-8?B?RkhYU3RNZDl2NXlsTE1sNmdtL3p4ejZLQk5BWTN2Nnk5enRFZGFxZHNXVlRl?=
 =?utf-8?B?ZnE4RTFUbDNDRW9MNWl3K3pHYmFEbko0RzF6Y0VkK2xrcjZtd0ZTQWhnek8z?=
 =?utf-8?B?MWdWUFZIdWdBZ1hIZWphZUZuOEtrWi9iZ3Q3Z3BWeTRaWElqczBmcXFzNTdN?=
 =?utf-8?B?dVpsSGdUd0kxSmVIS3hHSTJIcHNqeEVzd1JNdkRId1ljNVZ2ZWhGK1NsbHI4?=
 =?utf-8?B?S0t0VTdCanYxV0pXY1dlOG1iM1F4K3h0bXB5WWNnSVhtR21qVU4zNzdwWnVX?=
 =?utf-8?B?Yjd2VG8xMnZvamlERDRxTkxzOHpoY3RxZXNGTXQ5REJRTFBvZk50dGpzU2Fq?=
 =?utf-8?B?amxESWI0QlRXNHBtNEVtTU03Mi9TcUxRbW1sSnVrUDVaS2VGY1NsQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0739f70c-e5b3-4808-2d37-08df4b413f40
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 22:12:51.7279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: StkX0wmXCwONrKk2QREcMr+vbA+8lign2uyNST5SXJmPb+QAD488XaZ6gij2RJihyEAnV6bY4fa3twZC8+kXvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB388443
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed Nov 25, 2026 at 12:24 PM GMT, Janne Grunau wrote:
> The assignment uses a raw const pointer referencing the static const
> drm_gem_shmem_vm_ops from C side. This is safe since Rust 1.82.0 as
> stated by the #[allow(unused_unsafe)]` attribute.
> This was added in parallel with commit f32fb9c58a5b ("rust: bump Rust
> minimum supported version to 1.85.0 (Debian Trixie)") for Linux v7.1.
> Drop the unsafe, the SAFETY comment and the attribute as they are always
> unused with Rust 1.85.0 and later.
>=20
> Signed-off-by: Janne Grunau <j@jannau.net>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> randomly spotted while looking at the source, no other
> `#[allow(unused_unsafe)]` in rust/kernel can be dropped for the same
> reason.
> Tested with rust 1.85.1 and 1.100.0
> ---
>  rust/kernel/drm/gem/shmem.rs | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

