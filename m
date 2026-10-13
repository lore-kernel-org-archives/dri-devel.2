Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0451CC6B0F
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2368110E748;
	Tue, 13 Oct 2026 07:10:50 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2D5910E748;
 Tue, 13 Oct 2026 07:10:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIbssjIa7VSx4iSY/4OJq4rOeSgxtqhVqJBhCcYGT4kwAF4nk6ZcbzsNN6VhObGo1dfZAatu4upldjBxQaDhWHa3Iz9FqRDTVAWOLOUU/kByH6xJ+3s2IV1G4dqQaMzHp4Yy08Yjw0Vi7FtrN+uijdnBHT5EP8m0ft1IgPI8R98fyEuH8vPC/g1I0O9uELvzdnyDuOWKDiFzq6yYu0Sd4L15XoaF4J7L1XVF+6RnaNO6bE/K3hYlMLNefJUYsTSTO2QkXjxQuN/HwbU6nSK+148ePMFMsy5vkm65fwoA6YiCNpv9uf2emygtWt/B31DMUc00kLZQOYTxB111jq5d6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPLRpTX+NIqCylm4WWwp4l1DLdhzvnrMSlv9iAGJ7Ok=;
 b=kAFQKRICmI8OZyNj4z51NfJDz4eI61tzjFZ4eqpj3ZqmPRytFNRyTx/1AC3f0G3Eri/XHUvnPzjn+PdSo9pW9+fJPcbbzARvCF+LTMTYkrVdAB2giRbz2JSdwh1uEZSepthlPfZ9S12dIpemjwHr8dnCAxo+4BIQdh856FVpAQF8NzcazGYoLSlRqgoiLrczn+/e/xtCwI5NKjmVBKfvqIJiHOXHWS9tU1OHN9/iJ1uwodJkcfNxZFWtsBr4d3HHaPTSCSOC48G7L3V3mUP+Gd7D0xys4ZA1faGbuqZAXd1IlzjHgaGiyDiR81esIuuB1d5Y+XnWQZlnnnlVmaDm0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPLRpTX+NIqCylm4WWwp4l1DLdhzvnrMSlv9iAGJ7Ok=;
 b=eBxAW0ISBdeYoxAzgKKzEZL3fxN6VQiFWfcSQ/5vPp6ft24WfwG2x2DOYoASJIErkOig3gNfdY8ZhzfxuSI0/MOhTy7FbLFNoT+UL88dfphT9sXleuzahIIcAt6bm2HN6uJBg2CKOMLTw1GsVWW6ZLL6asmkNVWrhBIMzD6NOP0MLFMe+hzrB7HSR59rZIOs2vTJe4gze7nqs4cKxj9/nyWyIWTjxNFq7Js95WPuusXVRxni0STe+zTOS6aAnZR47AqC2JZrUvJe13vTjghm1mPor40qCuWG5KLQ842pr5RrbxKRAH3RnztpAlMLc2V9o7GAI76trjB6Ypqb5RIDRg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH7PR12MB6418.namprd12.prod.outlook.com (2603:10b6:510:1fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 07:08:38 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 07:08:38 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Oct 2026 16:08:34 +0900
Message-Id: <DM3ISBKLJ754.GDSHT5NYU0G5@nvidia.com>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v3 4/8] gpu: nova-core: add NVKV encoder
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
 <20260928-b4-nvkv-v3-4-f04504c262c2@nvidia.com>
 <DLYAO1NDXB2L.3NUUCWAWFK188@nvidia.com>
 <DLYARWONCNC4.16TY7TATZG2DX@nvidia.com>
 <4ac83051-6ac3-4919-b230-bfa059ff956f@nvidia.com>
 <DLYL5E2GFSM7.3SMUQUX8LN0C1@nvidia.com>
In-Reply-To: <DLYL5E2GFSM7.3SMUQUX8LN0C1@nvidia.com>
X-ClientProxiedBy: TY6P301CA0009.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::6) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH7PR12MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: b6811484-ef63-4932-3d91-08df28f8ce18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|10070799003|1800799024|23010399003|11063799006|4143699003|18002099003|56012099006|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: 4yJSv5hxBjBPSG7GDAbpcMThHb9/VVt8szHg+05dN3ScUfT8nooYBeRAgevgMv2hpE7ifqnUq9I+GtQSwIORAQjlY3vHt8LCnDB4du3ANqUkMLQP9ygIn17/xvUQlhjwWbK8+8G1IM0KckK8K9TFB56VNyuUYFS6x8Ey0LyKGYoiIhb2QDVP37w84y/vaNKtdKE4+xt3jZuzWj5RCtE4JNDXS+kaeLRPXI/MKo8nI/Y3N64N2kjzovXsOsndekMpfZ+c0p+Oi3qy+bKBa1GqQLtVFraoxMngWNt/zZSi5G+jHtC7wnuhAaqX7+BycQV4AUpaD4I5BbvxZzr0P/RxzBjsdGVDZEPkGwrHI0maCMWPnmSuQzACQd7ne6bBu5puk3h7bht4/+EPkSD+uMkIMP9ExXDtDy6KRb490h+CqWBX/QEKvfDXIMfW8rg67pbkG3IVHQgkRnSgcJ28TEPbOwAbBrjo4wtRTYNJW1xdpLL2F+4ow2/S/xiP23SYqoQummnSVhy46acGHNPbVWpqWB3vXf7Kfd69QNiGWQbjTk/7ZRRDyijVeQ3mc1Gm2lhQeXVVfRnofLckDWj7nocuGD6orv13f7cHPw2FEgtZqR3zYLD2jwelmhcwev7y+bptfDhDGoAo+3nAU6gaybOJQBVXhrBnksINWdAl4hNYTn4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(10070799003)(1800799024)(23010399003)(11063799006)(4143699003)(18002099003)(56012099006)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWNWNUZlTGZna1crN01yVWhsKzlMMEprMnZsZXRMZUpGcHRVYmNodjV5Sk1O?=
 =?utf-8?B?Vmk5QmlkbzMwNmJ6TGs0S243bnl4czU1MGJYdGlSMDVlSUhNenIvYktndEZB?=
 =?utf-8?B?b3lUQjhMUEJSUGZrNEZmYjhTZEEzRU0rMTNVNDJuOFp0SnRTSEJUWlhLeDYy?=
 =?utf-8?B?QitqeDA1akZWSjJPNk1mbGZVdzM0bU1sUVZXbEtQVkU5RnVZcnpDYTdJUTdu?=
 =?utf-8?B?dXZKa0JOSDBQNWNvc2xkWWhWNEpDSnFSV0ltc2tldnFuQVp3Z1YzclM5MC9t?=
 =?utf-8?B?bWRlRTkyeEl3Q3htekFta2JmRlJBV1RtWDlPQWx0T1cvYjVNTGZwSGVoazBi?=
 =?utf-8?B?bEtIeEU0NUVFN05wMXdJNmo3ZUxEUzhobHNnZkZoRHNIRFNDZW84bmFvc0hF?=
 =?utf-8?B?RjR4MkFuakFpNjVSOFBzdlZTSzVMYWppaEtCOTFHSHRUMjYwK3RuQW1Vb0JO?=
 =?utf-8?B?cE9nb0FjN3BFV0ZIdmVidUZqdWovb1RQWW45OGZ5Y2RkWXhCOTlERHdxL013?=
 =?utf-8?B?QWFNZXhNK056S2VxWnhvazRFbzFDNExIVzU1SEdyNG1MeHpWOXZPRkc3RXpS?=
 =?utf-8?B?bFNkeEU1djB3cS91aEVIdXM4YzZNTXJUaVJ1WnZ6V21nYnhBWm1KMDQ5aXBu?=
 =?utf-8?B?TFN5WTFhVlgzdkFvYTM3QnVjUFo0OGdqdDVoV08yM2lTbVNwbUNiSlI4dzZF?=
 =?utf-8?B?Wm9RZ0V0OC82MXVDZE1POUFDL002WVBHVGVaVU44NXZjbFMzQ1BBajN3MjZO?=
 =?utf-8?B?emc4RUVqYXRvcVdVeTRUcm9CMTBCalk4cnVDdmxpeG5HVXg5bnhhUkFxVnI5?=
 =?utf-8?B?cGJuQXRrRVdYbDBMdkc1Vmp4VlY1MkcxcDZPWk10YTZrdzNIQUlGeXVhbUxu?=
 =?utf-8?B?Y3ZnZW5TSlMzUUdRM3I3bTNqdVMyb0c3VmNVc1JLTVJYOG5qS1JteXg0cWo5?=
 =?utf-8?B?bEk2WHcvMFViVVg4Z1JiQnVhdEhnRXhsK2RMWlowNVBWWldGQXM4RHgvbFlW?=
 =?utf-8?B?VnFOMXZiY1M5Zk5yeVBPdzFudVgzWkhRQ0ZlY09TSmVqYWdoTUdqMFJQREVm?=
 =?utf-8?B?aEhqbExzUkk0Y3dIS3lWNjFMZmJqOXhpcEE5SUhSakdxYjlqZjI2emZRMHVj?=
 =?utf-8?B?Q0VIb2w0OHdiSVE2eDZVNTFwSnVmRCtTcG9vM3hra0RJSVYvWWlOR0syRFJh?=
 =?utf-8?B?U2R2aFhRUGtaeUtxNTJzTEFwSUtiVXRQcjRNU0lubUpZQWhRdkhhblFNSTV0?=
 =?utf-8?B?UzNZbUM1bjN6TTJ3MkdVVEdTWStRZExXT1RWNDBDTlEvTlJMbVJVTnNIWC95?=
 =?utf-8?B?L1F0Nk80NTJZZ2pUYjRSOFpkalhaR3BoMFhIRmVPc0ljYXRaWmN2b0VrQXVO?=
 =?utf-8?B?Z3dSYWhnT09nM2hnaXN1dTNVT1RKb1Z2KysvcTdZZDRoNG9ZNy9xTElLV2Mr?=
 =?utf-8?B?UDd4ckZBVGtSbVB1Nkl3WDdUSFpxTC8wQ0huOGZvdEtoOXNKTTZQdWUxSHlY?=
 =?utf-8?B?Nk5mQXlWSzAweCtncjdsTG00ajFDQU8rK0phOERzNnhPNDFMUEhMdkNqWXJV?=
 =?utf-8?B?T2pqOFM5QXZWa0dDNDRQSzU5ZERNeklHWXdMVUg5aE9KWGQ3OW9XTVpCY2lJ?=
 =?utf-8?B?M3g2eUJPS2NTSmxHbVF4cWF3Rk8zb3A4b0hzcEgvWndDeFFISDlmaTFqSUZB?=
 =?utf-8?B?VjAyS1BNUThJbFUwSEdrb0Z3K0llWnZlaTJlTmt5R1pXeFkxbzlzcnVDRThY?=
 =?utf-8?B?aHA5MXNwS1NSbi8zUmY1KzljR0RCYmFxbTg5YWVGdjB6RzkvVjRZSHgzUHh6?=
 =?utf-8?B?Z0JjaUdhRFZLTTRmb3h4YkRpanNWTWlGdjZ6V3JZc3FjZFBHYUN4dVRKREg4?=
 =?utf-8?B?TnZvRHVPazdVOEtQc1R6RDJIOHh4Tmk5cHE1UmY4Q2lTbm5RaDlnM0p4dTMr?=
 =?utf-8?B?MENLWXNKSWJnOGNsWGZ3WVBxUlUrRXg1dHlHSTZRMzdMdUdieVh1WlpjRDU5?=
 =?utf-8?B?TENZbHZHL3czcGpxV2ZxUDY5M0V3bkIybUplZlVvcGZnR2dmK2pUeDR0VWNH?=
 =?utf-8?B?ZlRXWFJCQXJFdUdIUHdFZzloa2xsK2RuaXJDaDB5S1VvL0c2enJnOGtqcytH?=
 =?utf-8?B?NGw4NVNySnkwaXlHYnlSVXZsVXVNdWVVWDVsTnBsZHdNV3lKK3hvQ2dXeGdr?=
 =?utf-8?B?Z3dINUZBSjhNdk40bW1UUFJBWjl6RldnejBxRzFvc2pwbEo0RmpqQmtmL3pE?=
 =?utf-8?B?UVVFNk5yTnVNbEVHejEydElXdVhseEcrL2l3OUhmenFMOVhCTDgxNUViWjVl?=
 =?utf-8?B?anlLRkhxN05PNjBLN1ZpNTA1dGluYmRBdUhiQ0dCTVZsMXIzbkFlaERNRWRZ?=
 =?utf-8?Q?IinjbaIMsaueaNmtItUxEzd/GjRsEvHY+pF9mUcm4cmIG?=
X-MS-Exchange-AntiSpam-MessageData-1: CffN3oRklSLsrw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6811484-ef63-4932-3d91-08df28f8ce18
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 07:08:38.6314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l028mYM0myE3atugmFMKPMX7kLf8VSgRda1dvOtShC6c2jXucQ8+GaDszBYtZYLSzanjcmRvU1VgGGTUm5uaLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6418
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

On Wed Oct 7, 2026 at 8:56 PM JST, Alexandre Courbot wrote:
> On Wed Oct 7, 2026 at 8:33 PM JST, John Hubbard wrote:
>> On 10/7/26 5:48 AM, Alexandre Courbot wrote:
>>> On Wed Oct 7, 2026 at 12:43 PM JST, Alexandre Courbot wrote:
>>>> On Mon Sep 28, 2026 at 5:42 PM JST, Eliot Courtney wrote:
>>>> <...>
>>>> ... and that's all I could find on this patch. I particularly like how
>>>> the examples have turned out!
>>>=20
>>> ... although maybe the Sashiko comments are worth considering too. Nova
>>> does depend on little-endian, but it probably wouldn't cost us much to
>>> e.g. call `to_le_bytes` instead of `to_ne_bytes` to make the code more
>>> portable.
>>
>> I recall having this conversation before, and I've tried to consistently
>> say "no". It's not a real thing, and if it ever becomes one it will be
>> a very big deal, not something we would overlook.
>
> I agree on principle when writing endian-neutral code requires some
> extra infrastructure or considerably more code, but here we are talking
> about trading a call to `to_ne_bytes` for one to `to_le_bytes`, which is
> zero effort.
>
> ... although the Sashiko warning on `extend_with_padding` *would*
> require more than just a method call to properly manage arrays of `u32`
> and `u64`, so maybe we don't need to fix them all, or any at all for
> that matter since half-fixed code is still broken code.

If I see some code that is explicitly written to handle endianness, it's
confusing, because it implies that some or all of the code is meant to
work with variable endianness. But that's not the case, and would leave
me wondering why just this bit was written in an endianness-neutral way.
I think we agree on this part though.

For the case where it requires no extra effort, e.g. `to_ne_bytes` vs
`to_le_bytes`, I think we shouldn't use review time on it. So IMO
`to_le_bytes` is conceptually slightly more correct here because NVKV is
little endian regardless of the host CPU, but I would not want to use
review time on this in the future because:

1. it's wonky to change just some of the handling, and changing more (as
   you've noted) can require extra infra/copies/affect performance.
2. I think assessing each `to_*_bytes` call every time it comes up for
   which one is more conceptually correct (is it host-related, or
   GSP-related, or if it's both, which one to choose since we're not
   going to bother adding extra infra for it) is just gonna waste review
   time.
