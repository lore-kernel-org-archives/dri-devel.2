Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9230C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D816E10E7BD;
	Mon, 17 Aug 2026 12:59:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VlpMIfyc";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C51910E7BD
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:59:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tgS31+fUuaoAqL2ZzO6xUe5nv/OGpz4fj56ZQBGee07qWficOkDA5qk0Ss5l6oHZd5x0negC/g0+fUaDK7L1pKiMHr8rLV83tsU2zEa2KzrjdaTHHEr4K7Hzccj/PvHIwLOcUquEDATUIlL1H4WNiaVVQPuO/4pvuQWRRpIB3k+OVEl1jUW8gIrK0alMNJQMDd4C+vjMdFq+JE2dNcw7hk7f9S4pVIJNJzYUVeHqtbSN3JwgnYfUk3B7nk6EfxpBtRHg+7/HYcRg1qyupAzTR9rdnr5b+kf6iMIMpqWba6r3kzaaVz93ZUvCa8AeBWAM2ejxeB3ZHqxEny0v4jVB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfrpMSjFiDcXt2IL8uqqzJSpA4XF0PFcW4Alf02tVfg=;
 b=CYBi6+rwsVxH5kpP45NMqyxInVvkzinRYOvgOMW5Y7FF0U/QzH41nKpScQpH8Heiu6yXxRYt1ZQ5n8Rnkbq87MZw1fccwMW1OBgv0HneXRvSc1KOkjLtLWEatGceWylxMDAUw8gIsUzoeodYd8DDgc+cMbdWMk6EhhJIgzonTlvdS19CNpVYRNQaYhige6w80vQm+HQbUaXO7uXz7LCmcqQB5Lhw0nBToZDmuMBsOgn5mp/U9cHcGQaJsW3E6nk9q1AmSzciqiaEDmChWrlFzyYCMlREf0pF4SpP0WGN2jumJ4EuR6ymg+67LtW5Lcme34XtQpHVwD6Xcmjupq1N5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfrpMSjFiDcXt2IL8uqqzJSpA4XF0PFcW4Alf02tVfg=;
 b=VlpMIfyccNtKlvV9EDtAS2SezPHK3cvjTntspuqJKvxVGcl+eK2l7w8j0fXhxcqKvuz90Avs2gnEG50gmvMr0rxhodNMvqBUXWJhVEDlXnfyTrlAKQKW18TtLyJmIc+Rom3/6MjSop2kb4KFdM7Mo0U5PUbq5iBTea02MOy1enzN1hHsfOQ638gaqF18Kv6OTZcAaUC3Zafh+6kd1I7MNmvFXlABaVjtBqKrCKvhRQziYfhowKPfu4WCdFwYefmp/rAbM/9MD1zpmqc7RQoXZJttpl1TZ6w7SQEaeE9K8z/GNzw9LMP34Xv7jp3O7C+r75sEKKI+07Ii8Jj50VX7LQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH7PR12MB6833.namprd12.prod.outlook.com (2603:10b6:510:1af::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Mon, 17 Aug
 2026 12:59:04 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 12:59:04 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH 0/6] gpu: nova-core: add NVKV codec
Date: Mon, 17 Aug 2026 21:56:35 +0900
Message-Id: <20260817-b4-nvkv-v1-0-b84db5e84b67@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NwQ6CMBBEf4Xs2SbdUirwK4ZDu2y1GkBbICaEf
 7eKmdNL3sxskDgGTtAWG0ReQwrTmAFPBdDNjlcWoc8MSioja1TCaTGuj1VgidZXpIxBgmw/I/v
 w/i1duoPT4u5M87f+NyK/lnwxHxo4m1jQNAxhbgtNjbNaniXWXPfspOkdGV0iKmep9lrm+KaCb
 t8/I1wR6bcAAAA=
X-Change-ID: 20260812-b4-nvkv-131af5c2661c
To: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY6P286CA0015.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b9::12) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH7PR12MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e5eaeee-b124-4137-5861-08defc5f509c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|7416014|10070799003|18002099003|921020|56012099006|10067099003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: Kyi4k+O6YJu5B/NkfyMx7HgKGZiWf557335mtxSDWX+cd+osEPp0PeOegYAR/zTpmcEvRKbvB/i+vLj0Dlth8P1M/eIiCJU6lxz7NyPWrJdWZIGy77ymR+oNyPd2uZBI2RKyS5tDLBaazYwYWR5jm6nIPyyNLeEeP3B+PAfe7gafYxS4J7VIjvxEL8hpCAlEsxm0PAoWrdzKbrPyU5GlbOpUe2vzwrMPPRNYu1m/U2MmL9izMcGwfddjDNYfEyUK+o8TteDmwzhmg9hueMkARaqDc7DFj9Z/y+Kl1QXVSbAV6lkPOslpCtQXYrKRDXAZIpCaog/Rup/e6CrIGS/w8uxB6R1+66cjLAuJgr6TQDTrMoLarpnDmlf3NYt6YzbsxzsBtCbAuKKoSOVxPGivNpMpW/qnycCj7x1gDkhHbA1ekNeavEk9O5EUeY6elWxeR275ipuGNYol96OuBkAKqIm6ffRdoaQe6RDAUz5N8zR/MDQ7we/D7y90JCUXoZoVHnQXbOLmRgofXWHmuB++ViUxUYMp7aKsVeHp8fmf1JnIah2i6MNUiiuLEd9T7N8kF9eJjhdW7+qq+Nbz1k3rIzQ/5wrKzJXgP6b5GLLBVpJbGb4V12nHio770F4s8h3nKzER+qV7eF+7HNAzNVtEniQ2SOZT9Fq7pWuaAGuz7GDQBtUaQIPXwnH6EtYi8hIMNlH+bx8GuHLpaXpDXWBLoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(7416014)(10070799003)(18002099003)(921020)(56012099006)(10067099003)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnlQSktncUZzRW81RHpjZ0F4ZW1RUE5wVksvakwyVEdZaWRpMW52K0VTTVR2?=
 =?utf-8?B?cm1wVU5uQVcxUlRGUnI1WnpGYmpCMHRIYmVCYXpQU2t5RjdpZ1JYdGZmRmh3?=
 =?utf-8?B?Rzd6WE1PeUxvM2tDa3BaUUFZSEd4WUpyUS9wSktaZk1lZFlMc1QyZXdYQ3k3?=
 =?utf-8?B?Y0ZKUC9qZXhYTU43dmEzSWR2dytoT2xCcFRPVHc4UnJDV3o1dU9iVkViaFZG?=
 =?utf-8?B?UDd3UzdvbG1uTGw0dHVvNEo2REZ5TWg1YVdRb0ZmLzB3Y2ZoSHdIV1JkajZF?=
 =?utf-8?B?UDM4Q1BOREpVS01wS3VLd1ptQXVqMGVvSEhYVGowaWszNEhFajhtazNhOUhF?=
 =?utf-8?B?M0ZyZmZnbTMybHR2ZC9UTkFVL2xXdllvdHRrdWJNZ1p0ZTJZelVGazF3YnEy?=
 =?utf-8?B?RmpESXBKeXliMkxhUlZBaWd1UGdUbHlvU01Edm1LWC91MGxLYVFhTGtFOUxk?=
 =?utf-8?B?QXV0YW1vN2dObUZUOFdkOTViUjZwSnhIWU85clF5MTY0aHdlUzEzb3ZKYmdm?=
 =?utf-8?B?YUI4L2liOG5sakZCV3BpNVovaW9Xd240OXNDL0lwMVdxMmZ4dmx6MktXall1?=
 =?utf-8?B?YWRjcjJ3VkR0UTNYZmdRaTliWmc1OGRZazRBdklBT0lCVm9JRjlGaExSYmcr?=
 =?utf-8?B?dHdQMjBLWVJHV2JqNjNadzV1Y3VLcU5xN3pUWXV4UzFORTB5V0NabDF4Y2ZD?=
 =?utf-8?B?OG9lUFpZVW51Sm9CdUlObFJkNlQ3Q1F6Yzc4Z21Vak5rbE5pd091SExBYWM0?=
 =?utf-8?B?V2Z6Z296NnZGTFZPaDZnRGNTTnovWVVqYTJpK3BpSXZPQWNITlBZdEg3MWVB?=
 =?utf-8?B?cWFhOTR3Vm5iL24rRTlzL2lHRDZMMlMxYXJtaUVtYVhjOWpvOUNNZG5YTWtw?=
 =?utf-8?B?SmR0YytpZTFhdC9JTGNkYk5rbkRMZzV4UW4yQTFsNlhGZEF1dmtINnAzM0NZ?=
 =?utf-8?B?U0pNYjBDQmtlQ2dNSWhiQm9mRkFINXNOeUVPY3I1cjhKQXBldWJkdTN6WDEr?=
 =?utf-8?B?aG13WTFDbWVHWktyNWN4OFhGOC9laFBMckE3REVEa3pFNzRMekJqV3VMUWpL?=
 =?utf-8?B?THNabkdtKyt3U3puQ3B0cVFqcjhmUng2eGJKZW5VSWJXSkwvMXlWOWliZG1n?=
 =?utf-8?B?eE9zNHJ5UDRQekQxelVLaGJDK21ES3JqcWRpcW9QNzBmVWN0QjY3cDFrSWoy?=
 =?utf-8?B?aExhZi94aWZ3V1ZIRHpjVVp5WjVnTXVaNnQ1VWJHdkpFMTJtbW02bGhSQVh2?=
 =?utf-8?B?NUpJZGYzSXBiV3ZOZEY4aEFjckJEZVYyclFGd0plQjB3K3lad1QycFRVSEhm?=
 =?utf-8?B?MW5LUnNwaHJyZmNCVlFmZDN5VlFaSkZsZ2pjQnQ3cVlTY0dWWWYrY1U2QUNw?=
 =?utf-8?B?Rml5VEhkRnVTVmZwV2tTWklTaTY4YTM2VGxBeVljUEtENWZQajRKMHNtMng4?=
 =?utf-8?B?WUZ5QXVKUkxTN0lQRk5HcENSUEtKaEd3RXJ4blVlbDNZNitrL0pLalVyaVhv?=
 =?utf-8?B?RzArc0liOVR3dzZSSUdQbEx5SHo1U3ZUTTU1OVN5alo1ckN6YkpaTGx0MkZY?=
 =?utf-8?B?REZoa0NWZXd4aG1TR2JsMmFYeUJNaDB0eXMrOEt3WnRyV2poY3ZCK0crVlBQ?=
 =?utf-8?B?SVF4dituc3F4eXQweXZiM1lzRUVZUTNqc3JkUVNJN3RlNE9BV3JKZHB0T0tq?=
 =?utf-8?B?dXAwZHllcnAyRGxQdVRvUzJDbFhaeFI2U0JxZjh6NDBJemxRQ0cxWXNBdG1P?=
 =?utf-8?B?U2psdDg0L3EreWhrNFljTXJmL2hJaEljOURocUsweUE1ZThvV3ZmeXRzZHZw?=
 =?utf-8?B?Q2VJd1FDYStML3ZpS2pYMGpiMmptNXVYM0ZvRncxWlBSTFhDbnFLWURrSHZC?=
 =?utf-8?B?SEw1MVA0OHU4cHJNVThPMWtSdFlaa2tNNytKU01CbHIvS1FkZUowczE1SXoz?=
 =?utf-8?B?UloxZzFKZzFnOXpGSTB3S0xIYnNFclp1VElYcC92Q1ZqYU5WL0dkd083Y3Vh?=
 =?utf-8?B?b1RiR2lhVGJSaEVkeWxyVlRUdFdOM0pqbUllQVN3aVNWc3NDOURJWmVzSHNk?=
 =?utf-8?B?RFliYUJLVjlIbjd1NTkxcUtXbGRRNDlZekxEM2c0cHNRNEpQZWpraHZkc056?=
 =?utf-8?B?TC8xOVpBdDJRN2xxV1Zvalo2VmNNVis0Tlh6b054Y2N2RWxac0ZucHdDWVhq?=
 =?utf-8?B?Q2kzN3lUZDdOOHEzNWUrNU15L3p0SUs0OTdHbFBvSkx0M1plc241N1RMdUg4?=
 =?utf-8?B?N3lYOWhGcU4yTkprRnBlWElONTlTY3E0UTJNYmovTUtIMjlCUlpjdVoweXoy?=
 =?utf-8?B?QzgvZzErQjlZSXBMdlNUUG9OSTc5L3d3UG43aVFjY2lBcTVYN1oyRUY2UDV2?=
 =?utf-8?Q?7IaJDOF7VwZ2RJ/8Q8C2mtuJ4N3c8u+d75KPicgfZVA4l?=
X-MS-Exchange-AntiSpam-MessageData-1: JKqGZQH66TPBNg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5eaeee-b124-4137-5861-08defc5f509c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 12:59:03.9516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JbUOFfJnvU5pc+lTT3HOshrig1kdFZNBiNleNYiep42vMX9XmqJon6jv+DUd/dMNYdZ9aQC+UjmSSeOHfZFt4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6833
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

This series adds support for the NVKV wire format for communicating
with GSP.

Essentially, the format encodes a sequence of calls to some function
f(key, index, value), where value is a [u8], u32, u64, [u32], or a
[u64]. The key is a u16 and the index is a 12 bit integer. The
interpretation of these function calls is per GMCAPI (RPC interface
used in firmwares later than r570). Generally speaking, the function
calls will map to some struct - for example, f(GPU_NAME_STRING_KEY, 0,
b"some gpu") naturally maps to storing a &str with the GPU name.

This series adds a general encoder and decoder that works with the
base formats used ([u8], u32, u64, [u32], or a [u64]) for encode and a
general `Schema` trait for decode. This could be used directly, but
since most messages are struct-like, it's more ergonomic to use some
typed helpers for this declarative use case. So this series adds two
simple macros for encode and decode of structs, plus some general
types and implementations that help with using these.

Future patches will wire this up through the command queue.

This is based on drm-rust-next.

---
Eliot Courtney (6):
      rust: alloc: add Vec::push_init
      gpu: nova-core: add NVKV encoder
      gpu: nova-core: add NVKV decoder
      gpu: nova-core: add NVKV typed encoding
      gpu: nova-core: add NVKV typed decoding
      gpu: nova-core: add NVKV GSP_INIT schemas

 drivers/gpu/nova-core/gsp.rs             |   1 +
 drivers/gpu/nova-core/gsp/fw/commands.rs | 349 +++++++++++++++++
 drivers/gpu/nova-core/gsp/nvkv.rs        | 186 +++++++++
 drivers/gpu/nova-core/gsp/nvkv/decode.rs | 651 +++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/nvkv/encode.rs | 423 ++++++++++++++++++++
 rust/kernel/alloc/kvec.rs                |  42 +-
 6 files changed, 1651 insertions(+), 1 deletion(-)
---
base-commit: 4c9ba407018e8deb06dbc643112bac8f40404f95
change-id: 20260812-b4-nvkv-131af5c2661c

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

