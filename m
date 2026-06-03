Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB641CD6E5D
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:58:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B51FD10F76F;
	Wed,  3 Jun 2026 01:58:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="PNB6dODt";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010035.outbound.protection.outlook.com [52.101.61.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4C6710F76F;
 Wed,  3 Jun 2026 01:58:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEpuwvsPvywf7HwldGWz1UlxqJc3HnX8qFaNM/54LVGfKGcJFQ1Mj8loljo6FP7pOoqHEQGPmqFJ48WcluW6mel0d6XgxMreKSvUgPBgeEFT9RgCIkU02tWiWtPGI+nKphP2g2r4uixiYPtCT6OObAXg6y6Xvz2lvKywA32lXinX79JgOxHUynVprkdjUC1emjxwIglIz65NHCXTLMi/LFKdQgc5inl5yZuesFtuWH0gIKHDU4F5xPfw/IEL1aDQ2dNvjzKvRsUO5i4RbWxCaZ3typJ9u+eZBPE3O2FzdkljWuW2jzLpbyusbguIMavSiAb0EgxNTBqNUQk652OCLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1+7SU2R9gsTVSNpMeZcVJt++g0cscRS4TXBZclkYi0=;
 b=mKB0g5U43t8akvYQN70q43biIlNOufZORs3mTBbttq0olETyTGCf93CvqUMwkdXO1tybacMJtpojlJo0ZDMEYUQ8JFD+JRYRW/EPpLY2TmD+DBK+0p1b8tdH3A+GNX2iNawTOUkhw+F+RUyty8x1Sm10sjqEHhYskyy0dw2/x75B3dzO246ysXeHQUXslcbJ8ayBIVKcZBZfu3ePtoP2VqrjtIV8XCrnzXjeDK61+VRtaHVFy+yQMxTQJhqYnVtliBGZ2DaJGIkDmIdVsBdgFbOFlqSm+13C3GxibXrApMxpmOmT2aarFM3dtpJ3ill8ZtkpFZPhowbeElWyVPbNGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1+7SU2R9gsTVSNpMeZcVJt++g0cscRS4TXBZclkYi0=;
 b=PNB6dODt8EsIpAdNSjtilkIicI1rRJoCVoUqrgAQ2u3FhFLJ6dA0yYJQutLz84J+8WqKmAfSqwUELF/9OMdKb1VLWUN6jjV4Mg6+xy+IML60VHx9xhBfLXwEJ8BhtoxtMOUtOtucnqFVUYbR2z+gktbvb6Fhbof7BWl0jpsA179DhjgPpAyZWODVTY4mZi6EoqTwyslqPSqM3UvBZUYOFTNcWqwuDXsO/rgsE//udjCHF7XyarlCKJ3M61ocExWaBOn1hLY5+6rQYsRsRRo9vpR88oriqhZSXVm4kz3GxxIhnzHtv+/ALeUODKQnjo3Kc+6SescazESdXu8BRuDNXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN1PR12MB2368.namprd12.prod.outlook.com (2603:10b6:802:32::23)
 by LV3PR12MB9354.namprd12.prod.outlook.com (2603:10b6:408:211::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Wed, 3 Jun 2026
 01:58:42 +0000
Received: from SN1PR12MB2368.namprd12.prod.outlook.com
 ([fe80::281e:52ee:b18e:ad42]) by SN1PR12MB2368.namprd12.prod.outlook.com
 ([fe80::281e:52ee:b18e:ad42%7]) with mapi id 15.21.0071.015; Wed, 3 Jun 2026
 01:58:42 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jun 2026 10:58:29 +0900
Message-Id: <DIZ1IZJWNI8L.176YPYSVFLUKH@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH] gpu: nova-core: move lifetime to `Bar0`
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Gary Guo" <gary@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260602170416.2268531-1-gary@kernel.org>
In-Reply-To: <20260602170416.2268531-1-gary@kernel.org>
X-ClientProxiedBy: TYCPR01CA0060.jpnprd01.prod.outlook.com
 (2603:1096:405:2::24) To MW2PR12MB2363.namprd12.prod.outlook.com
 (2603:10b6:907:f::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2368:EE_|LV3PR12MB9354:EE_
X-MS-Office365-Filtering-Correlation-Id: 38e7d5ba-c0a1-4e12-8ed3-08dec113a106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|7416014|1800799024|376014|921020|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: YwNelbadzGtYTTXZ7FPjmvFnFwjQ+SC2Wd6xpIqtUvgINFMGHGzPVCxLwDdCKmj+V77mIlEceqEvGXp2vJ2rm2Z2os75lN4d65z2jlHqPuhEtcEzPG4VI/yRZRD+h5KjKywegmbzkbM+UPC5XZ1baEuvsjblCmmafGK9jDJduB81M3Hnb5oE/KS25npYC9kU62abNGdjzhJOKWr1RM8hzvdSYanCWnZdPBZj3tAXZalY+5Dodbg6VhlOVapXFtSjcf+cKx7W9pXKM1Ln8Ia07by1jPx3o1ek24Z9fr4qeMDv3Qq+jDkYNmmnaEiABpvDeVB5EkllCdZTlHZorTRZG/0cZfXWQLBkTwHyAr5wTCB7lLu2XPGF3UkhHDO/wJBN0TFjr2FOtRpQKEKGYq351jE5ctHJGmCIzUuvGc/GlqZNk4cMSKb+920VJCiN1keFOxJAFnxuX2YxmPjdSjfCFIBvc4yH+oDMWtbT+AA2HTfIHxz+wXfnErh6ls8t9B6M5n4g0UdzKO7R9cL0SAgzp63D84p9VVfJ98r2pJytM5g5qeKYB579yLpdYwg6WF1eAAX/fMuMSX7NG0UlgRgbRC7m+pVs7p+oS2UyHsQ9qWPmBWxZDrRa5sDwAQWRuIyr0Nt1iqP5nykvEM/Q7rAyRBegWsRUOLsDL5adSceHLfAKDyXssSVZCeBNJEEw6R8OC4DWw6ZyYpnZiETHifT42jsq6bicANoXQK2DIs68Lpg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(7416014)(1800799024)(376014)(921020)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXVpUDNFemR0akdaRVRGSy91VkNZZnlaalJ5aWo1Sk9JdWxGRzJ1Qk1peThZ?=
 =?utf-8?B?ckVuaWFQWUtCclZFUEorVEpWRzd3T21WUE9yaGFhQXBpV0s1L1FScXR3TFFZ?=
 =?utf-8?B?YjFacm9qVDZIUWxMa1FmSzd5dXovbTc3VWFCRnlwTmZZQkUrdkdMSjZ1OGRr?=
 =?utf-8?B?K0RWck5DYWNIRW1pU3dCM0xKZ1pJdEV5ZDEyeUNxQVA1VmNVN0tNUGEzY1Ni?=
 =?utf-8?B?QlF2KzNxZkFrU3p3aFdGVnFjek5teTBtbU5ZRSt5czhrZUI2K0pCSHZPUExP?=
 =?utf-8?B?eEpKd3kwNzgyREZwOGdCWU1BWFovckhWUlU2MWZqRTBqZXVRV0pVTWFrZWkz?=
 =?utf-8?B?UFU1V25PQml6QXgzWWRNODdLYWZpbm03WTExRng4OXJpZENLN1NvdkRVSTUw?=
 =?utf-8?B?bHlNV3VmTU9GR2EzUkluYWRuMEtzVytaNHAzMGczRDhGRVJDOWFvOWxXY00r?=
 =?utf-8?B?dWZjcUoxT0FOclp1S3RaZ1NHVW1tV0FsTXpweEJvT0F0dUdsc1IvL0ZHRzRB?=
 =?utf-8?B?R2ZROWZYSWVNTXFGRWlBcE93ZXhJTkViSTdHWHVuTjRKNkxORkpMN0dzd0o3?=
 =?utf-8?B?aklxcW41cy83VzhEWldBLzRXNS9mWDdlcE1XVXFJWHRaY09YRmtpazZhdXh6?=
 =?utf-8?B?ai83RWEwc015THlJVVV4K1VaWVgrLzc0ZGo3eHpXdkw3YXNGKzREU09iN2dG?=
 =?utf-8?B?M0ozTDZjbVNnd09HcGdsd0RnZ1YyYXNqUjhmU3ZNN3NYb1JxT01Dc1hNcUVq?=
 =?utf-8?B?cVVoeUZVRVhVWml6ZWswTlJGQWxJdW8zWS96OVljZXczSlRDYnhaSUVIdlAv?=
 =?utf-8?B?MGF3bFhpNUlUOWkrZjhYRmZJVHdHbDNGSGNCWDk1U0lRYUtGRzBBcWtkR0NL?=
 =?utf-8?B?MXVNOENqN2NUbDVDd3BUVUFIbnZYR1dLOW51NUlXWEpKWUJObWJhMTl5YTd2?=
 =?utf-8?B?S0FLOE91WndjRkw3cHhtVmFYREpTY25FcU5RWVlpZkR1T2IwbCtWaDJpVHZR?=
 =?utf-8?B?ZmJXR28zWlVUM2ZIT2RrbE40TTNwMGFaYXo1cTJZVFE2ZG9MeU5iaDlWZGt5?=
 =?utf-8?B?VGRjR1o0OWlhNjR5THFVODRNeHBvVjU1QlNiUzU2QmR6MDZJNVBEaERpRmIw?=
 =?utf-8?B?MStpd1V0c2d1cE5ERjhWMWUzSjY0SGgwQ0Z1VFhIWXZjZWR5ZnZyTEM0cnFI?=
 =?utf-8?B?M0syK0R6WGpkYzVpS3lVcU9MS2FvMmI3UmxVSlp3THl4V1M3aUZ5cm9EWlM0?=
 =?utf-8?B?T0h5U1FIMldmZTE0OFVLOHcyNVRjYmFOQlk2bFEwOHc2M2FObjB1b2Npb3ly?=
 =?utf-8?B?U1J3amJYM2FsaHRidllCdDJ2Q1N0R0JwSE9lUXRqRUxJV0hDT2szaWtBajZM?=
 =?utf-8?B?V1FxS2I2eFhzV1VlSE9Ud2hkcCtIYzF6WE9ndkZ0amVFSmZ5akVkM2Y3U0FB?=
 =?utf-8?B?RVIzVlZoc3ZLdW15QVp6cEc4Vmx5Y1cvTUJLUERqK3A5MDdINi90b1pOdDJh?=
 =?utf-8?B?bGpEOHBMMDJOT0Urd2pLRkVxWFJQVkJEQ3pJNVh0dHVrUTRDNDNqNE1BRHhF?=
 =?utf-8?B?YktzcE1kQ2NZMEdUWURGM1l1ZEdDZnRhaU0wYU1pNXRwanZZRXkzOWxsVnJx?=
 =?utf-8?B?Z0xkQ1QxcWdjWUFmMmtJMWQzaHdrTU90TDducXlJUXl3V0tDODROaElkd09m?=
 =?utf-8?B?b0VyMi9Uc0xMdDRUYllPWjhJQ21vZENVT2tEUFZJcVk0NnI4RzRBdncrTERI?=
 =?utf-8?B?T0M0RXAzOXdBU0I1eGZwYnJvOXhMZHBmSGNGM3IrcmJaK1JCbERCTDY0UEVj?=
 =?utf-8?B?RGttaklzSFU0NlhCaGZEcGJPVDNNdkZDMkdpT3h5VTJkT0xDSzV6REpxZkJQ?=
 =?utf-8?B?V3dYaG5pQUZpTW4xNUR6WGJST2J6OEpJQzhXY1BhVDF4T2VaRWtPcXMzdVQ1?=
 =?utf-8?B?RU1ocEg0WVhBWnRKZk80dlhUNEVnTFgxNzhSTzZwRDJ5bmNuMStDb3BCaVBh?=
 =?utf-8?B?bHhVYVNqRmQzUUh2VGFVbFI1UjJiTzNNc0ZsQ3dvUHEyY0VySVM4RURqL0lw?=
 =?utf-8?B?b2FyamQrQnFEc1VLQlRGQ1NrR3RxdHZ6ekVHUERWWG1KdHhMUlBlMG5Dak9U?=
 =?utf-8?B?R0dOelJWRHUrUldhZDgvUmVGUUhXaGIvQWttR0lTQ0RGZ011SS9KRVZJY3E1?=
 =?utf-8?B?dWxpbE9MQ0cvdTBKWkRNTDR4R1dFYW5ZQzRTVDJVblh1RkhSZlR0ZjhhVS84?=
 =?utf-8?B?a0pkNTd5dzlDUWpicjI0YnhyK2t1OFlOYVQxMFo1eWE1dUxXTjFSeDVhZ2du?=
 =?utf-8?B?bytyNXJhb2hwaERveVFGd2cwdG1LaG56VytxZ3JCSHZJMGVTUkQyME9NdXMx?=
 =?utf-8?Q?WospjY/h6BaWQDWKOoZaVtIrvHRDDM/RxJwXC2AlTXSpn?=
X-MS-Exchange-AntiSpam-MessageData-1: AhimclBo78Amgw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e7d5ba-c0a1-4e12-8ed3-08dec113a106
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 01:58:42.1513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjX9XB8a32zuHz5jAJLpMYLMkeBcfzVvIieM4m/QWzKHyD8ypapq0dVQe3hnYnlSXxWRKPgfzSLhKJhNkpayCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9354
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

On Wed Jun 3, 2026 at 2:04 AM JST, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
>
> Currently Nova code uses `&'a Bar0` a lot. This is `&'a Mmio`, where `Mmi=
o`
> represents an owned MMIO region; this type only exists as a target for
> `Deref` so `Bar` and `IoMem` can share code and should be avoided to be
> named directly. The upcoming I/O projection series would make `Io` trait
> much simpler to implement, and thuis the owned MMIO type would be removed
> in favour of direct `Io` implementation on `Bar` and `IoMem`.
>
> Add lifetime parameter to `Bar0<'a>` and change it to be alias of `&'a
> pci::Bar<'a, ..>`. This also prepares Nova core so that when I/O projecti=
on
> series land, this could be changed to using a MMIO view type directly whi=
ch
> avoids double indirection.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

