Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5842CC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 14:22:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B370510E02D;
	Fri, 10 Jul 2026 14:21:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="tBz7dNIY";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011058.outbound.protection.outlook.com [52.101.62.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC88F10E02D;
 Fri, 10 Jul 2026 14:21:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KoaV43OTCh4L7w7f6DIUSWLadLF+C6REBKBeaxw6sWfLhY9xcCsBTf9a+cERGU2zg99vV8RPh+ntGHbISK174KDw+yVJdDXlZF1oECwBm0qBggq22/5sEh8J6oa4inqs6ZZ6awqydJen91z/Labah7IBWW7tzckxMjZYvY0zzyOlSYs69tPurLPn3if0/Gu5Sy6zczQtEO8uEUkC3s3DnFEj6z1uU+PZ598pg+XvOjAKEp9R9c6XkRVXoGRpUZJlXK+v/oxH8Ok5jTBxMKFC7llfWUNw5ezr4OJAOSoHk4sRm0P9gmoDFIoLM8UHzndRQgbrquS903ZKudDFdkeysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4LkIYDuRnm6XinJESylyT3fS0mQ+lcNYog+NPFClOE=;
 b=QiO8Aq7r8t8oihckhF/P5bFUandF0SdZRN6wH1xkGy2tiMQWWsOennfJ/8s7BNpDawI/q2sSGD+GtajC6shcMndrOtI+nAPsi7+AxxzkWTU/NasOlanM38jmNATo81NKKZ/W6CXr82CWnnB9hm5s/v0ObsUK/4mUG2+BZ9ZMT/invwfRFDS753IXeVAc7TWo2A9SPVIXo+V0OdXJBaB3APXouqn2NJ0eCzbi+hIzmKdNZGbHjSZDcGqFfUwaOtvmEvXOi8SpEH0Ii/Kf9r9ZaASIzah0vlp+sJP1QMDenZ7ABe5FnPXnbz1zdK/qucz+TedxyOv/H4jQuPBicmrosg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4LkIYDuRnm6XinJESylyT3fS0mQ+lcNYog+NPFClOE=;
 b=tBz7dNIY6Kip7eiG7pHULuZ6dZHQmIiUxd4FGXzNZNQFGIvRFe5TudK/0mN2+4YEoEFm8S8REKGlbirOKTVJkhXyuqzNXZjvgFg7KDugLgOze9PtJfzdsu6cytqZ+QMlHehIDO3bSi4eoGbmm2eumgQFk+uQHyQMv9eO9Z9IddDJ87YM9Civ06mNUToheyfwMCz2bwSAzDhFx59iT+lMrqdv7S40pxXapHRKEma6SYTBr9QqCdyE+zJej0UXKaNuZli3yJFEJ7uoBro1c3wGAsF2XJP+xP2qby1KxYGjSPVtczN/O9zSwrV+RVo/7qxjTWcoyWE/GKKZLJMX6JcNFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 14:21:43 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 14:21:43 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 23:21:39 +0900
Message-Id: <DJUYI5EL9MCS.F6LWYD6821YM@nvidia.com>
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Greg KH" <gregkh@linuxfoundation.org>, "Yury Norov" <ynorov@nvidia.com>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Burak Emir" <bqe@google.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 3/4] rust: id_pool: add contiguous area allocation
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
 <20260703-chid-v1-3-84fe8259e46e@nvidia.com>
 <2026070334-dollar-hexagram-e49c@gregkh>
 <DJSDFHOADWYL.V4WC2TI9UWYF@nvidia.com>
 <2026070745-unwired-maybe-769e@gregkh> <ak0pzDc69nAmnviD@yury>
 <2026070839-quadrant-gentleman-2334@gregkh>
In-Reply-To: <2026070839-quadrant-gentleman-2334@gregkh>
X-ClientProxiedBy: TYCP286CA0298.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::12) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH8PR12MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: e25ef2b2-2a24-46bc-da98-08dede8e9095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|23010399003|10070799003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: wh6BaNBqq7drrycclSGr5tH2m8MOEtDXhxCFT+6HSyQPwJgmUVA7sb+po1RCxwUVfpIO7nLLp31g9utM/rwzY2emeCG50UGKLaqyfQl9s6y6J1pVLNExJGltQ4th7PvBuooPTpbA+mDwBr4vT3I0o56GghZuwYShrc3VaKdm8Xd/TQUbBnH3fLrA50sg51WG+Bir7tQi0ofgm1l2MyplHKNA5Ek6bAn/O0fERU9nfwOiybutzectfXXNNN0qDK6ASVIhciwg8iQhNGOWFrnwHYY57DV07MAKSpx2UL75zniIx4tV5nATtzV+1zcrXyAKvGu1eD31pDW76Z+zmgmbJLOFktqo86Ubv2Wf7RI5fZpyh4wfkkRxEFr+gn0mCagRR3GVMZH4Qv9ziZJ2k8NSFoixlC7QS9XvOoz4Iwq2CGmZue78n7C/DJmpKANbLMvCEB2v/5YBSDegOtxPEXax6oUwKanhl8DlzmQnnVCmazHvIMBB+SUf5kGmzYf7c4dJKHnEpZ2UMCZCbCJs5koRTCiviA3zi1FHDlJ2ju261ihxkqIkNWEKxIwAGA03ZF2vLV15cXUVhyin/3l2FzKEL2VhBXLQOabfBe5706SActZPjRKWLQAIlgQa6Er2FDhqvWVNKO9fP07SDOBXse7Thy8g8RQNOvAfMfD3N938O0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(10070799003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGdCM2NnYVBwb1ppK3V1K2RRNURXcENSMXdxbjB1VHJVMW9lSGdDK2t5YndO?=
 =?utf-8?B?SkN4VFF4bE93YlNFc0NWNFNyUEh1TXBGRUhXUUlFZ3c4QVlsNk9GOCtNUkhL?=
 =?utf-8?B?U2FiaGxlcENTVVN2aG5neXV1VjVUdzJLQkxqZFlaVUJDbkZUTlZuYU9PVGFt?=
 =?utf-8?B?Vmtxeng4a3BWSDk2UEIvZWU3QVMzSFhSbEUrNkdkOWFtbGprNDFZT1krdU8x?=
 =?utf-8?B?MEpabnJOMU0zcU1CYU9OQ2dEQnRHaUxnTUErWFVsczczK3kyUEFSY3UvWUxL?=
 =?utf-8?B?cW5YVUZnazBYUzdFOXdMdDdNRG92dTMzUHNLMFN0cjJEL0hvelVCQ2h3T0pN?=
 =?utf-8?B?eEgyYzF0Z2ZTczRjNE9CNmNpSjBIcTJ0em96QXMyN0haUFlIUmhQVkFGV1pp?=
 =?utf-8?B?L3FvUXd4OHlpT1FkRjFOeEo3MTdONGxsRFo4N2M1bDNQdWtVSElwNHNMcWVS?=
 =?utf-8?B?VW5nSjFYYSs5QWVNb1RhODlPM0R2TjJnK3BOaTJMWTdZdVc5azZ0WUxZUWly?=
 =?utf-8?B?bXhhQ0pLclB4Rm93b1hYMUJFaDYzbXdVRStZQTkzRGovK2lpQUJLdlRsNFdq?=
 =?utf-8?B?bnA0aHdNZysrb2ttM0MybnExd1FJZGo2ZjJmeERBWS9OTWhyeExjWHRZQ2Jv?=
 =?utf-8?B?UFhIbFFBc2JWT2h4c3F0SGgzS0JmbkZVSURBNmp0bWtIczlMRWRVczF3ci9q?=
 =?utf-8?B?MWlZTzBvS2VxNVZpOS9lekJXWmdTQkd2MDhTTEJYSEdrdjNpV3NmOHljbDlr?=
 =?utf-8?B?NnVpUkFEV25zbTZzbmNhZldNR3g5YWUxdzhwdm0rSElBSFE4UFIrbS9ZMDY4?=
 =?utf-8?B?YXB4RlVnaVI1SHdBTnIrb2VFK0dJVU5FUVhrOHBES2xyUG5lelVSRG1pbUE4?=
 =?utf-8?B?NnF3M2FPTllENUtUaXFhL0pscFRta2VBM3poMjBxa0p1cmJDOENBMFNZMEp5?=
 =?utf-8?B?d1JQYzJBNVcwa3Q2UFE4eFdtc3VDK205MHpwY1RTQUo0SmxWQ1FGaURnemZ0?=
 =?utf-8?B?TEJDTTJpQkdsMUMrYldQUWx4L0FVcVl0cUF0Y09PZE5iUHVnYkFxUy9RTlBN?=
 =?utf-8?B?aHA4aEhvdmZHSmprQmVTU2NRS2JYclJHc09OVUpqbTUyZzhnRVVKT3R4eW1m?=
 =?utf-8?B?NDFOL0MzRWN4Y0FYYmtkVnR2c1RNTWRsWlJ6LzRKZXRmOU0rT2Y3M3E5cHdZ?=
 =?utf-8?B?eXFyMm12OFBkbHVIRkg2azVZTG16ZkhROUlYYjVjSU1CUjB5aHNnMVlSVUNS?=
 =?utf-8?B?VUdiMjNYNHIyZXI4U0JVV011SW02NVRIYzE3bjM5Wjd3bTg2c2pZck9IVEZN?=
 =?utf-8?B?dFlIY25vQlU4dlRtLzNBazlTQURCckYxb2phZWdrSm5zc1lGWHVjUWZKQUNR?=
 =?utf-8?B?MkRUY3V4T1o3QzlhbTdqZzhnRlpvQ2JpclpFUVNDY2p4UFp5TFBrTUZKekFR?=
 =?utf-8?B?VWpqNUo1V2tmVG9kb1BIZ3lwM1VMYUFucVJvSTlHenZTakNDb210NGtveTZF?=
 =?utf-8?B?UkNGU0M3TDFUZVphVlQ3L0U2aU1FcFpVQWhBVGM0SW1aK0ZrN3hRVUpuenJD?=
 =?utf-8?B?bWRjaWRaNnA2elZxcnlXbFRJRGFvdWZ6d1NGcXo1Q2tXMVJsQ2JzVXoyVWEw?=
 =?utf-8?B?TGdOK1ZVSnkyNSt3Ti9NU2UyemlRMXlPUjdWUnVoT2V4U0xNV2NvampwMUZo?=
 =?utf-8?B?ZGRnbzdVTWVlREgrOEZ6Q1ZjMUtjMG1CVW1wNGdRd3dDZDNsQzdObHVsVzRk?=
 =?utf-8?B?ajRzN3JTY3N1dTBTRXdQMXJuVitVYlNyajh0S1RiZ0lDKzFhZ2R2SzdxRUNU?=
 =?utf-8?B?SjZ3emVhMzN6RnVtTmU1OEZkdCtISXpQbHdZZUZydlY4TGo2UXM0MEd1SklD?=
 =?utf-8?B?b2h3QWFlTXJJZ1JVRE5oZzhVb0dGcEdnY1o3QXZXZ3FpZFpuM0Jid3lyRVBz?=
 =?utf-8?B?OXM0aWNySGtsS0VNU1Y1c2E1Mnl4V3BsUkJNSWNtUnNjUVNqT3ZSdU9rZ3BK?=
 =?utf-8?B?RU1kemt5Z1hGRUF1R0o3L09jM0l2V3NQQVRFRkg4dWluOUNZT1h6TVZBSnNS?=
 =?utf-8?B?d2IwaFlxZHZ5SjBMRWFhTXpTUWxRRjdUMXMyQmo5WVJ5TkNKbWNhOUNyZVlm?=
 =?utf-8?B?TFZCWlk4UUpFM1FtZ1c1VkxvdmhkOW5LRWFKUktCOVBybnhCdi9HR01zMVhP?=
 =?utf-8?B?NVZVeGU5dGpub0ZScEZ0T2ZSZ0pmVkd6WmIwNTFiekF6TFZ0b05WTWdBRHNy?=
 =?utf-8?B?K0REZlRzWFZtdXM2MmhrZjliU0lyK0cwNzRqR3BDcHFxMzV0d3FPUGQ4Zmdu?=
 =?utf-8?B?bG1UMk43d0U0VTdzWG9xMGRyQ0Y1MFBXVG9ENlR6U3o0QUxHcnU4TjFTSGkr?=
 =?utf-8?Q?XYGv1wVltHstFbVdwTIlY9zVvBq/9gJAozXOAsPG5HE+h?=
X-MS-Exchange-AntiSpam-MessageData-1: /HazCGHa0Ntscw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e25ef2b2-2a24-46bc-da98-08dede8e9095
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 14:21:42.8955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4TRpF/U8RL5rFKwkexjp/o4mya1BKQIWnAGPxTisy0PJGKWbfgnb5lO2w0IFRQuks36Ih8QqFfK7/mlkYobbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6914
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

On Wed Jul 8, 2026 at 2:33 PM JST, Greg KH wrote:
> On Tue, Jul 07, 2026 at 12:31:08PM -0400, Yury Norov wrote:
>> On Tue, Jul 07, 2026 at 04:13:30PM +0200, Greg KH wrote:
>> > On Tue, Jul 07, 2026 at 10:25:27PM +0900, Eliot Courtney wrote:
>> > > On Fri Jul 3, 2026 at 7:31 PM JST, Greg KH wrote:
>> > > > On Fri, Jul 03, 2026 at 07:16:06PM +0900, Eliot Courtney wrote:
>> > > >> Add support for contiguous area allocation. Add a new type,
>> > > >> `UnusedArea`, following the same pattern as `UnusedId`.
>> > > >>=20
>> > > >> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> > > >
>> > > > Why isn't the built-in idr library being used here instead of roll=
ing
>> > > > your own data structure?
>> > > >
>> > > > thanks,
>> > > >
>> > > > greg k-h
>> > >=20
>> > > For nova-core in this series, we need allocation of a contiguous
>> > > sequence of IDs with a specific length and sometimes a specific
>> > > alignment. IIUC, IDA/xarray do not support that (I checked
>> > > ida_alloc_range and it only allocates a single ID in a range, not a
>> > > contiguous sequence).
>> > >=20
>> > > For IdPool before this series, I think it could have used IDA/xarray=
.
>> > > See [1] where Alice has posted some more context.
>> > >=20
>> > > w.r.t. the structure choice, the IDs we need to allocate are channel
>> > > IDs, and the total range is limited to 2048 of them, so IMO bitmaps =
are
>> > > a better fit than e.g. maple tree.
>> >=20
>> > But again, you are having to "roll your own" logic here, please reuse
>> > the data structures we already have in the kernel for this type of
>> > thing.  If a maple tree works, please use it.
>>=20
>> I asked exactly the same question when Alice and Burak added wrappers
>> for bitmaps to implement their ID pool. This is the answer:
>>=20
>>   An alternative route of vendoring an existing Rust bitmap package was
>>   considered but suboptimal overall. Reusing the C implementation is
>>   preferable for a basic data structure like bitmaps. It enables Rust
>>   code to be a lot more similar and predictable with respect to C code
>>   that uses the same data structures and enables the use of code that
>>   has been tried-and-tested in the kernel, with the same performance
>>   characteristics whenever possible.
>>=20
>> And now it's in a commit message: 11eca92a2caeb
>>=20
>> They measured the affect of their wrapper on performance, and it appears
>> to be ~5%. See lib/find_bit_benchmark_rust.rs.
>
> You are comparing the C vs. Rust data structures here, which is not what
> I am proposing.
>
> Also, is this code being used on a "hot path" like the binder stuff is?
>
>> I didn't see any side-to-side comparison between any native Rust API vs
>> imported C bitmaps. I'm sure, I asked for that, and I still believe
>> it's the important piece of data to avoid this back-and-forth type of
>> discussions. So, Alice, Burak or anybody...
>
> Again, I'm not talking about Rust API vs. imported C bitmaps, I'm asking
> to use the C structures like maple-tree and idr instead of open-coding
> logic around the bitmap code.

Yeah, I agree that using maple tree avoids piling on more ID allocation
implementations.

Channel ID allocation isn't on a hot path (absolute peak ~100 per
second, on average < 1 per second, AFAICT).=20

I prototyped the implementation using maple tree [1]. It has some
awkward points:
- Allocating aligned IDs needs a loop on top of
  MapleTreeAlloc::alloc_range + erase, which essentially replicates the
  logic in `bitmap_find_next_zero_area`
- Since aligned allocation may take multiple tries we still need
  exclusive access in `ChannelIdPool::alloc_area` to ensure an allocated
  but about to be erased non-aligned alloc doesn't make it look like we
  ran out of IDs. Alternatively, can do a try+restart kind of loop
  instead (needs adding bindings for mas_empty_area). [1] is using the
  extra Mutex.
- The alloc_area and Drop path of `ChannelIdPool` now allocates memory.
  I *think* this is okay but it is a consideration.

These tradeoffs weren't obvious to readers because I didn't include
enough context in the patch series (and was going to add actual usage of
the aligned alloc later).

Anyway, maple tree does work for this, so if you prefer I'm happy to go
with it.

Thanks~

[1]: https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@nvid=
ia.com/
