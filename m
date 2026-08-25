Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62891C61DB9
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 23:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A411110EB85;
	Tue, 25 Aug 2026 23:43:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="R+1M59XQ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C75010EB85;
 Tue, 25 Aug 2026 23:43:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSkBH+CrApP2Sj8/kb6B2j6XJ3BM7CGxLvkfhBRFSxy5LwbwZ9H2/55lcpmlbtzLRRKUoPueGgqaWgOquoL/Uk5WUPl5UhjsHMy/+ypnPX8pABpGM4W+/8t+Rx0xXfL50yfxElIy4DcgwMUSVTUcmEJJVqznI9VaN9ysRBDjN2f1LjYFBZ33uhna1u+s6ygLjFx4vFhhcOuPO6lxAsGMxIwKQMzaIe2oV+OGMbnW2pwa7AWKr6qUrteRlABqCIEOJj3Gxybrb2D3tVpAX2sXSlXmyvoBzsspZTHNEaAgQCgAB32EqwVqZ0z+9YN1HVAPQlCMPOk/P1TOXm1TfnN/YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xja3VuJ16Z8QYLyXsDAZtLwpqM60gaf6oZV2iBfDBaE=;
 b=ZHEA/XzgucUu7BRpci5MoiPFNwYLw+988Qr/TF/9dHxVZoYwNnozZXsNUXvdwETvZHRnVKuE/x4qFw9KzFh4O/U2t/nMgaOHZdW7zDpyU9ogAFaw5eiP9LdXIc3HrSXzmTv0ndBnMhtOx83gQjrQ/2Q4GdHuURwANG8au/DWEjNDg8JfDc/417YZJO//Y083pVWowzYXh6y77/m7psjhlhVjZfLS4yTaWllp40NW5l0BjPdZG2kX/Ux2PvIwN7Jlm024lrUd3sE18aENYaHMV28SQi5gBeeqpNRgoI0RChud/GywprzDB8Swaf7SYi0tVwxLipM79aNCFvUVnLg4KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xja3VuJ16Z8QYLyXsDAZtLwpqM60gaf6oZV2iBfDBaE=;
 b=R+1M59XQQEZ5pm6lusOy0go5t7LN+hkk6WVS/DMYVtIRzDMBJs3X7q6p0Dx0tLa/knIPo0i1P/fZH6G/A8I7NSyUrTnc1vbc0+oWzV3YwQl4Ie6A9xlD59qPUbgcKpL5vVRAiBLH0DsP9aSmwlg6BST2PVJwpwU5UzzZ4oHO/5OuJdzmPPaabj88YuiaIlg3AlDQKrqBvJHzxw2SjZJ5KbloToqQdYeX7SRphYjs5CHcx6YOmrxwnMox4S3zZXs4ztrIWpas0f/mq0dnFNgH/TKgLjh8E93b/36ZrH/slt7EkEj5j3bvm70MEelFcAN+j70HaD886R7LVtFIOVWn3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.12; Tue, 25 Aug 2026 23:43:20 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.006; Tue, 25 Aug 2026
 23:43:20 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Aug 2026 08:43:17 +0900
Message-Id: <DKYF98H0MCX2.2H6XFF3UVYA4J@nvidia.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Burak Emir"
 <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v7 06/10] rust: id_pool: take a NonZero capacity in
 with_capacity
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alice Ryhl" <aliceryhl@google.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-6-a5872e64d8f4@nvidia.com>
 <DKUHJF1YTTY6.1XXC1L2SYXEMF@nvidia.com>
 <DKXZ7VHUCLWL.C6IPHWPTEJW4@nvidia.com> <ao2U1jNaT7waibJW@google.com>
In-Reply-To: <ao2U1jNaT7waibJW@google.com>
X-ClientProxiedBy: TYCP286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::17) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|BL1PR12MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: 96e43e19-1675-4b5b-b41f-08df0302a51f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|10070799003|1800799024|366016|10067099003|56012099006|5023799004|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: I41cW1AKYdASKAsT6nobRO/jjxYGN6Mr9SHTrqVkLkfNcKaSw9MYTpf7x4xAlwGMCslkyE/yjPAOpUotJsVBow8Bm8yCx70FI9lug1IQ+tr2yDzI0XDvyLXrrV2MBlUH3gKFWVwi2pgYBAdvtvJ6I9kqr3u2/J/C816JSx6VvYtoamGtR7Y74hqY4UfdVr8nmPDo9Fg1CLmIsc96VQTN11IU2VzlTNQxTsCPvHQM9vUCC1GSaTBIaPo+KwP7NQOJHvVRy7S4WKK2dlf5vZH4dbxX76OEO6BAJRf6Nzu1JUL/11JMDDaIEKNfecoHkaqLTCMWBLG6etn17kYgziZ/cLAJK8Zai3RljRPBGd1EiSX8TMZ0zTcvHlqBuzMMDARHiB0vNLFfgPWPJHACM1d4rZDFC20KCzi89+k8cWqskCS2kQ5RpSWbPAAYtfT+NMG2RtH3JN2KW4FsGvFnMxw/0MKTTgC7KFO/eSKFa5NgQneI7MfT0IkUb9ZMrxdtv35Ro19PIAgDwdhBREZSCQP+Go6TjWq/MBAC2MeJhJhjyd8RNE2GCly5RkZq6EehNOXKlBRriRKJXTCmqwczz/Fi9/C/y+W2G4sBbpgc8oqd42hu96wKzsT73CxR4RBCPrNl6kC4ABWwdSaEz5zugsRF651TdHkSjbvzY0ZvNiMp4bM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(10070799003)(1800799024)(366016)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGpRTHBmbWJFQlNoaDBmNk1XY1R5TkxKZWJjUy9oeS9CclVMMWl3ZnN4TkxL?=
 =?utf-8?B?bXpoWEJ5RVhDdksrWE01MVhjY25obTRTK2dTaXNpVkRXcmJTREtUOVRlbE5K?=
 =?utf-8?B?Q0RzY1BWQmF3SGVwczY3NHc3SE9rcXNTakZ1NzNYelVYbXFvQjQwODJuZFR2?=
 =?utf-8?B?NUNyQ3IzMndPbDlmN1E4WTlZRU1YOTJwTGR2SVYyRm1aVzdYWTFHcFFKM01O?=
 =?utf-8?B?dER1QmtadHV5dUFWTmFVbFJQYS9zMHhOaVU4d2E2a0o5MHlIUEpOR2graWJX?=
 =?utf-8?B?TGp2MHY5VStaaFdsZW1JSzNlaVZyZWxyNnozY1dUekdIekVMOUNNSStocENq?=
 =?utf-8?B?SWZpRHk4U0pIK0tESzB1dWFGVXJZMXVOVUp0YkRPMkVuNEhiQmpNYmt6cGdp?=
 =?utf-8?B?VGFkZnFKUVNSa3BOUE40SWZTcTlUVzZoZnpmcWk4eXZKdWZzV2xkRnFPYmY1?=
 =?utf-8?B?dFRTaXVSVHlzd1I5L3JjY3hrVG00Zk1VdlFCbjh6R0ttYjF4YXpOTm5RSUFh?=
 =?utf-8?B?VGFiQUNJWHZnbkdXMnBya0d6dkgybGJ6ZWdmdVRPbml3ZGpVRVdWQXNHMDVa?=
 =?utf-8?B?MSsvYlJpRElPV3A5TThxMWh1ZVVpOXFROTI2Yi9XOVJIVjV0VFF4K2ZhYTdG?=
 =?utf-8?B?bjE5aitwSGkvTjViNEkrSlFxZkdGTHNNR2NycU15dTlSVEF4L09hb29oaCsr?=
 =?utf-8?B?NXZJRU01OUp2QXZkQnJZdi94YWtLRjBrZ2ZjVEJ4eFJGZ2FVNEZDNExpbFlx?=
 =?utf-8?B?S2krQW1ydHA5SnNMT0RraDV0T0Y0S0hGNmw4bVM0ak9aRnYvYURSNE9EaVFx?=
 =?utf-8?B?Y1pNTHNoMzlCS0dDdlQxaXhIZ0lHT3pOMTFOVWNwUnN0QUxEam4vUkY3bmFk?=
 =?utf-8?B?TjdEbWdMd1plRVdENWlqZkNFOGkxbUoyS21aK25oTkIvL1N0WC8xdWFkK1JO?=
 =?utf-8?B?dXFtelR0eXV3UHppVS91VlZtM25VL2hYVUFWWmhXVkxhbHFUMnM4Zi8zL29Y?=
 =?utf-8?B?RzBjTml5a250SkhDWnlkeVdPc2w0MmpLNUltd0RweE0rYkdxYTBLbmxSdUF4?=
 =?utf-8?B?aCtjK2ovbVpNVFZIM043SmJQaU5KYXA5anlOd0U1MEVRdStCZU9IdExSWmVl?=
 =?utf-8?B?M3dZYnZ6WG41WnFDOSszMFJvbytIR3M0TWhWdVhKN0lWQ3huVlhzYnZyWHpL?=
 =?utf-8?B?ZTY2UjVVa2NtWnZvSndMcW9YUEh1RCt5TmpKbXcyZHlTcTVZcEFXQUNkZkhG?=
 =?utf-8?B?YWk1OVE0K0k4RkI0Vkh0SXJMQ0xmNU9YSSt6dFZDSXhpWm9MRFJkY3YyaTk3?=
 =?utf-8?B?QW5PdW0yL2J1OXliRVkvQ2xBejhsWUhBV2lHU2hUbzl3RmVTRkptdW1iUFho?=
 =?utf-8?B?MGtVb0V2WmRFSnlmY0M2WlNnUVJVTHd1UWFScXFxVFRVdk5aOVZXVDRML2pU?=
 =?utf-8?B?c1daTldzdUFNYkt3dWpxQmFjWHdyNFAvUm83ZzFJUW5zc3hFZmlBeU1rVVlX?=
 =?utf-8?B?eW9wZjZYdnlCeW9PNG9SbTk3N3oyd3JEZnQ4TzE0REdhSGQ4T1V5Q3ZwTSti?=
 =?utf-8?B?cmVFNFh2dU5xc0Y2NXpLNVJ4MDhDWnJFZlR5TEx3ZnZIWEdFNURTM09ZQjRZ?=
 =?utf-8?B?a0VGWDl1MFdlREFaS3BNUU9aNWtGMVlmdWxOUHovMmpnNXFEb2ZDKyt4cnpO?=
 =?utf-8?B?ZW1rL2Z4UitmQUxHSjZKSUdKeDAvSXhqbHA5VUU0ZlF2dWYrTTBzZGtRRWRx?=
 =?utf-8?B?cGsvcU54dHhwY3BhQTRZMGpOSTdWeEZueS9vakNiOVp0SGtQdW1iOFNoclhC?=
 =?utf-8?B?TTM5MVFKM28wemFGNlJRK0IzRzd6eS9ub3JjS05kQUlYZGppZ0w3MW85WVk0?=
 =?utf-8?B?L2xla1MySWYvcDFpQmxrdFJFQmphRm9aK3ZyaTNrSzNRZHNRMCtkVWs0UThB?=
 =?utf-8?B?eWYvSEx6V05DQjRLdm9mMnhaaTlwc2F2czdLemxUTFJsd2h6RXN0RU11WmpF?=
 =?utf-8?B?UU15NHRkMHlCdTBEN2ZVQTRvczI2QkNvRFlOWXhQYmpEajVTbks5OUtNZGtY?=
 =?utf-8?B?bEk2ZFYwcVYxd0tVU0w5YW9RSUNLcjFxbWZZYWkvUzYzTGdPNjYwZDJ2RnRJ?=
 =?utf-8?B?NzRPbGRNOHptWE1GelFOQXlZb05TU3hONmluUGpLdHJ1WEpvVzdwdCsxeVBQ?=
 =?utf-8?B?MndCaVcxZVJpbXZubzVMMjNOY2I5WC8wRGxIcjI2MXMvYkxGWkNMc3RNa2V1?=
 =?utf-8?B?TmhnL1ZSS1hFQ01WVUhwaGV2bkNCeENCWlZTYVYvNllsdGZmV3g5V0R1N2FP?=
 =?utf-8?B?c3VzVE0xVDdzMVJtZXFxSXdkYi9GelFzMHNobUd1YkNmSzBHK3k2aGFFc1pY?=
 =?utf-8?Q?X8i+KE8CHLriuCPEZu0ppB+nytFPT+IJQYHRiQY4WStXF?=
X-MS-Exchange-AntiSpam-MessageData-1: eM5BuK/6UctKdg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e43e19-1675-4b5b-b41f-08df0302a51f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 23:43:20.6908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xg0JU1SNZ/K43M4Id93RQSHgBhMMdpj6LH2gtNRWId46jmv+k0zzetZWIrYGvzeXVc3j2E1h3jLKTOSYwtVRnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804
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

On Tue Aug 25, 2026 at 10:12 PM JST, Alice Ryhl wrote:
> On Tue, Aug 25, 2026 at 08:09:13PM +0900, Eliot Courtney wrote:
>> On Fri Aug 21, 2026 at 5:39 PM JST, Alexandre Courbot wrote:
>> > On Mon Aug 17, 2026 at 4:04 PM JST, Eliot Courtney wrote:
>> >> There is no good reason to allocate an IdPool with zero capacity.
>> >> Reflect this in IdPool::with_capacity.
>> >>
>> >> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> >
>> > I am not sure this one is justifiable; `KVec::with_capacity(0)` is
>> > doable, so why not here? As long as it doesn't introduce soundness
>> > issues I'd say this is the caller's business; a driver with a legitima=
te
>> > empty IdPool use-case would now need to special-case it.
>> >
>> > Now we do have an actual soundness issue with zero-sized IdPools, whic=
h
>> > is that `find_unused_id` would panic with `CONFIG_RUST_BITMAP_HARDENED=
`,
>> > but as I said on patch 5 I don't think it should anyway. Another
>> > potential issue is that `grow_request` would not grow anything; but th=
at
>> > should be fixed there by handling the `capacity =3D=3D 0` case. Actual=
ly
>> > that would give justification for empty IdPools to exist: just like a
>> > vector can start empty and grow, so can an IdPool.
>>=20
>> I don't have a very strong opinion here but I can't really think of a
>> use case for a zero capacity IdPool. Unlike an empty vector, since
>> IdPool doesn't automatically grow (there is a notion of a fixed ID
>> space), the only thing you can do with a zero capacity IdPool is grow it
>> to non-zero. All the other operations don't do anything useful.
>
> It may not grow automatically, but that's only because Binder (which
> will grow its IdPool) holds it in a spinlock and needs to use the
> PoolResizer and so on to grow it without allocating under said spinlock.
>
>> If such a use case exists, maybe it'd have to be something like you are
>> using the capacity to identify your ID space size (and the ID space size
>> is important otherwise you would just use IdPool::new() with the
>> MAX_INLINE_LEN capacity) but then the only way you can grow it is via
>> grow_request() which doesn't grow the ID space in caller controllable
>> way.
>>=20
>> Anyway, let me know if you feel strongly about this one. FWIW, previous
>> to this patch series you couldn't construct a 0 capacity IdPool either.
>
> I feel strongly.
>
> Using NonZero to prevent passing zero is a very strong mitigation due to
> its big ergonomic cost. There's nothing really wrong about a
> zero-capacity IdPool, so let's not pay the ergonomics cost when we don't
> need to.
>
> Alice

Ok, sounds good. I'll also update grow_reqest() to grow properly from
zero capacity.

