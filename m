Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25618F433D0
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 01:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7584010E164;
	Thu, 16 Apr 2026 01:35:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="E1GLnqjs";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011060.outbound.protection.outlook.com
 [40.93.194.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6012E10E07A
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 01:35:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6HnD7gAHHGyMaZW48kvVs4QMKg1KFx7JLGxsMzuOPFngXmEu9NbV8XoZyCTVG4DwGxJV52kjFhgsxnDksFb4ZfaPNULhFmdCj0aeBliaz2HY2pIw+VmK3IVKv31D9EjutdJ0f5gc77eowkPDQ/m98+kG+bWP2iRpQeHAZNEVm3LQIj/CuBWjNixzCNgAXePaDl/BfM+WnkZfg+gTAq3duZ99xwdOpJfeRBuK92kZQs0ouBDNAUXj42S9bJSoEpvAiDIPExIwMTcxIlgvCBQSxNJbnLkvbpeiYJAizzxJtvUOgawH4TRzxAkjCwCNmoUnU84lurNsCWlE7EDbURD3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPK7VCl+pWzz1rV/gi0ChsDEJqy7yMkccPFWGI9YvJg=;
 b=j7Tws35hTmpf8W7hS57EISdYJIWpipCchnlcwURpGYUzXvVFQU3DPQUcdU6gpj43ZjbYJciFs8yEVt/yfEK8kuKFeQ9DarT9ZEyNmysKGuzs5/8Q5NUPtjszIJKqr0B1tp/onn0PgbIPo4DUPLTWPGFLYsbDaLE3pvGJf0TPfLXIxR+XC5+HCl9cWC1hHjT/MkGTLBBg9bR57qXsaJEXz2yyDfBU/Y8Q23lUr6HnDrxpGCxOK05X+TXZ+fTA39MC4QjZ0puptLYKULy43oFIcoVj8Lbh8Q1k56d/iatawgpNoT8MXR8bDeIOYcUg2g5zssItjq6Wz8dgGm/SOhY0kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPK7VCl+pWzz1rV/gi0ChsDEJqy7yMkccPFWGI9YvJg=;
 b=E1GLnqjsks4jb6RihEKXI31LPEuce6iVqLzPvU2UDkBZ5DGsFVp4KUOzX+dXrulTtlDxQxHzV4ZSRX01VPrB7+6Xi99TozPgSUXVKEguyNrJSococLTQO8vb47go9iZwTOTaPJ6ABpDG1ur7OAsFnbvE19LtpkceBYtQnx/RmY6tiIj7iIKyP/C3FZrH72vVgi4ekYTOf1PIz4C7hVjoGdEisZ/ap5IAba8789rrx2OC/a4luMMlWJQvCrRpNquqf1D3VxOvkQ5A7msIY3+DmvuKW9HDJ4pmm3YB2RPbjfrbTSEwQisuxACOAuXwReNSD8s44oHBS1uQgEdlgpWLFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by SJ2PR12MB9243.namprd12.prod.outlook.com (2603:10b6:a03:578::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 01:35:15 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 01:35:15 +0000
Date: Wed, 15 Apr 2026 21:35:13 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/3] rust: extract `bitfield!` macro from `register!`
Message-ID: <aeA80WHkFBNTvQFz@yury>
References: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
 <20260409-bitfield-v2-1-23ac400071cb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260409-bitfield-v2-1-23ac400071cb@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0232.namprd03.prod.outlook.com
 (2603:10b6:408:f8::27) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|SJ2PR12MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 14aea7db-c956-4644-d72f-08de9b5868b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0H8JN80/vZlTRYf3ylQGu3fLdo09HzkSrwfHLqvOtjN0DGEHo/GZG+phvtR2W+peojN7+/2txLL7o+3Vpj8fozVXUFqQb58kdXVp3C+lfhLt6VxfkwHkifAqbiNgt4o7X21NuZ/wxFy6xiyeaO3kDw7PE1QRDkosDDgTH5dUF84nw4g03l5U9f++DzFob6I9R3u5OqDvdz751icH9NF9bfwhyunZDIjgMa/iH+HiYZ7cOM3oIKL9hAyef2VMVc8XHBSRTMUgkyCv+QAJyRyTMlSBGJ2H/tgstu9Fg5SVcalmPAE3zYmQTysZXhGC4sW/zlKsBWDqUpvaSQ4bL06zqBBHvHzzSHLYttskvVKHFEBthyIO5ZWvSAW6YDBDzpBZwg49hosfyFlqWeNUm3IkgiwauXbD2AX9xPdY2RP2lUaDau+4CCEWvBWsok2SMSMfhmnwpZsO0TuP8m8d2iO+ZRmPjyLXCC8oQUKp0FIgjsmtFGB8zPaOYIq82hjF1/pNH8NCaOUt1nId7OaD4PV5us6GGIss2JbDa8egBnOqapYYy90bLuGFUeZuq9sjLFVAhHfba5o8oE3g10eCRDOZp/f/Z+bfOLaD3VYOhVBa1srS7qs3prR79m1O1c86J1OZrHLR7h7UqPgk1BLKGykSbRkTIEY6xJDkC5u9uVQu1exE3/1A/tNnaUXRAzUw4ax4/fEGLdlDiXDOYz/6WN/c3yCFGarmF28Sg0zao2jiK0s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8300.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkNhUTZGNFpwUXA5eUljVmpXRG83Y0RNcjByRGxvVURLVExsaEdzWlVjQzVo?=
 =?utf-8?B?RHlXaHQ1a3RGcVM0YW9DejVJK2VMUDJHQ3I4TnRIejV3VXh3TlpjdHNid1BF?=
 =?utf-8?B?QzhiVCtoZmR4VlpOK0oydEl4aEg4aDBFdFlLVUJsQmVYK3ZkcnNCWUdWeVFw?=
 =?utf-8?B?bmtzUzAreDZGZlFaSU96eXFGM2ZBSVpUb3VrQy9TaGladHk2MkE5UDNiZDlz?=
 =?utf-8?B?anJ1d2NGeStsdTdrUEJoV3lIekdqUmZUQnVMejltNmdJQTlWQ1VmeVI1V0Zk?=
 =?utf-8?B?SnM1VzlnKzVLQUlLNkJ6WFVsWjRlQnBnejVXcjRXbHMyMlhhT3hLNmFQeHUv?=
 =?utf-8?B?ai8yb0x6YVUzTEhBeExsRUhaemZSSkJmd3BtTk9Fai8zTU5icTc2ZmNZN1Ba?=
 =?utf-8?B?eDZLTWZ6am8vK0J5d3B1QjJSZ1YySjRTR2RXdWtuVnJyZHZ5aHJFbm42ajhR?=
 =?utf-8?B?VEI4Nmh2T05CSGxlOTVDQnNHa3J2Q1FMcXdVZy9zNmU1WXFBeE1IaGNCOTNF?=
 =?utf-8?B?NCt2dzNJb201bWp0djMzdDNvZWdYVW5PV0J5L3B1citoZnV1MDB3Z2Y0SEp1?=
 =?utf-8?B?ZWdhZW1MYmFVRlo5MjZLRDhvRmFxUmlGc0xkUU04aWtYZFlvWGZFOE1PVFpx?=
 =?utf-8?B?NHpFZHJ6Y3BzcFI4Q2FZRWxMbTN6MWdvdzRDMHUxZXBGQkIrQzNnQUxHMjBZ?=
 =?utf-8?B?U0xLUFlHZEt6WjVhbUFrdXkwalJaZ0pGU3ZBbEFncFhOS3l0enVGakd1MTBv?=
 =?utf-8?B?UkZLdWEyZUhFSktZSit4Rk9xQlpRcDJZeENFcnlNVDJnNC9qeUpqQnFwa0Ey?=
 =?utf-8?B?THZ0eXZ5OVJOc2pscXIyVytBQ05na3RhOWlQdXpRZE1DblRYdS9xVDQ2b0lS?=
 =?utf-8?B?R2VuSGJXN3FLOFRxaTNuVjVNVlhkSUk0enBxU21tN3JYTkRWd0NjbnBuWG50?=
 =?utf-8?B?SWdjNkdIT0lST3g1dVppUjRDemFhZVV6TmUzd0VBZUw3Zm1mTFZOVlBKais1?=
 =?utf-8?B?Z3FtK1d5TFNFNkdBN2VNdm1kMXdxd3llL3pUdHgvcVl4NHNyTzVyMlVXcGph?=
 =?utf-8?B?Z2IwY2djcnBFUTBwQ3F1ZzkxWEppNmNsb0FFYjRZODZuRzE0SGh5WWNsc29v?=
 =?utf-8?B?ZjZ0QjhBNnJ6TWNJQXBuTFkyMEt2OVRpbjBQUDJLaEJKOUNZcEFaUm92TWg1?=
 =?utf-8?B?ejh2dlRLdGZPQ3lwQ1NOUEpOVE9LY0c5bXNqSmVjSS9RK1JHMFRyMEFsem0z?=
 =?utf-8?B?WlpubE5Ibm5FRkdDZDhWU0VJSTI1bnVHZEIzRDhxRFlWTzdnM0VNeVlzclp6?=
 =?utf-8?B?Qms4V0N3TU81NlJaZXJYL2FVby9ZZXVpTFBlOHljVXBpZlpXOEExTGVyZlJ2?=
 =?utf-8?B?QmpTdEZ4b25lbVFCSDRrNGpVYXA3YXpnWWtGL3RaSXF0N2VuSmNqTEhkN0dR?=
 =?utf-8?B?ZUt3aHd3aG1OdUJCVkxRaFVJVnlOTjVsRlU4Mi9qRjB0TW5NQi96ODY2MFBk?=
 =?utf-8?B?WmlBZkZSSXRUbkdYL2FVcFVWRFltbXB6ZHFwRGNVMjgvTXU3M1hVVXRqdzVs?=
 =?utf-8?B?SHdhV1Z3UFZWN2VKUnkycVNKRS9uZm10d29haEVyVVV2UzB6L2V4YlV0bXFz?=
 =?utf-8?B?Njgyb1ZPSUdIRS9yRWpzdXhVTzg4eEc2a1k5akpTelpaTzBiVStZTDE5OGJt?=
 =?utf-8?B?WHlZSUtGNGdLb25ZcGtzMWhPSFkybUtLZWZvZFJKSXNBTHhBek0xd29oelB5?=
 =?utf-8?B?RjhJT1dYSkR1VmJzZXVOeSsyNkgxYWNMRk9zWXVzdEE2VHpWOC9GVktzdXU1?=
 =?utf-8?B?Zmt4WXdnN1JISi9WUXI1VGt2M2hzY2lSc3NHeG4xTEtuVW9mUVFPSy80dTNi?=
 =?utf-8?B?U3VsMmFGekxHTUgzWlFoZWwxV08zM09SK1Q3aTBmVER6dDM5L05DWVNvSW4r?=
 =?utf-8?B?QlRnMjRxUXNMNDVkN0ZuWitjNEFvc2Q4MnF2ZEJzczdzQzZwbTZZOU9obEpW?=
 =?utf-8?B?eXRiMEVOeFRiWno3akVzdEhzRzhqWHhwNDI4WU5WekhiNmN0UHFxMWNDcEpu?=
 =?utf-8?B?dWZ4V25wUmNPNmZWUk8zSERjaDJmRENNdldjV1VYdFpZVkN1eGtHbUZIdUpr?=
 =?utf-8?B?TnlYTTFEYWF1TU9ELytwbjFpOTNrcm1YQ2g2YVBZR0trdlZKQm0vMU4rSFp0?=
 =?utf-8?B?THIzNWtyUWZTZXBjV2ZTSDdWWUR6N1hKNnZLZ0ZFLy9kN3hLNHdYeUxJaEN4?=
 =?utf-8?B?ZndXU0k2dlU5NXJWMnJBVGVWRzUrajFzV01nVE5FbGhQRFdCc3pFT1BtUUNn?=
 =?utf-8?B?dWh6eklxdDlyS2laQUI2TUxwME1pKzdaMlExTlZSV1BVMk5iQTFRcHkxZ2Jq?=
 =?utf-8?Q?6ismu7SqZRkKfvUwGacGr0MTarTdRfoQj+kQg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14aea7db-c956-4644-d72f-08de9b5868b0
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 01:35:15.3192 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gjnRuH82CVVsvER6WLyPWo+RwPHHdF/3UCZgYzYJT5fGkOSmoYtEsPPbsk4Gti3EhiQRK0PIhJhkuSuaZx841w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9243
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

On Thu, Apr 09, 2026 at 11:58:47PM +0900, Alexandre Courbot wrote:
> Extract the bitfield-defining part of the `register!` macro into an
> independent macro used to define bitfield types with bounds-checked
> accessors.
> 
> Each field is represented as a `Bounded` of the appropriate bit width,
> ensuring field values are never silently truncated.
> 
> Fields can optionally be converted to/from custom types, either fallibly
> or infallibly.
> 
> Appropriate documentation is also added, and a MAINTAINERS entry created
> for the new module.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  MAINTAINERS                |   8 +
>  rust/kernel/bitfield.rs    | 491 +++++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/io/register.rs | 246 +----------------------
>  rust/kernel/lib.rs         |   1 +
>  4 files changed, 502 insertions(+), 244 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b01791963e25..77f2617ade5d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23186,6 +23186,14 @@ F:	scripts/*rust*
>  F:	tools/testing/selftests/rust/
>  K:	\b(?i:rust)\b
>  
> +RUST [BITFIELD]
> +M:	Alexandre Courbot <acourbot@nvidia.com>
> +M:	Joel Fernandes <joelagnelf@nvidia.com>
> +R:	Yury Norov <yury.norov@gmail.com>
> +L:	rust-for-linux@vger.kernel.org
> +S:	Maintained
> +F:	rust/kernel/bitfield.rs
> +
>  RUST [ALLOC]
>  M:	Danilo Krummrich <dakr@kernel.org>
>  R:	Lorenzo Stoakes <ljs@kernel.org>
> diff --git a/rust/kernel/bitfield.rs b/rust/kernel/bitfield.rs
> new file mode 100644
> index 000000000000..f5948eec8a76
> --- /dev/null
> +++ b/rust/kernel/bitfield.rs
> @@ -0,0 +1,491 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Support for defining bitfields as Rust structures.
> +//!
> +//! The [`bitfield!`](kernel::bitfield!) macro declares integer types that are split into distinct
> +//! bit fields of arbitrary length. Each field is typed using [`Bounded`](kernel::num::Bounded) to
> +//! ensure values are properly validated and to avoid implicit data loss.
> +//!
> +//! # Example
> +//!
> +//! ```rust
> +//! use kernel::bitfield;
> +//! use kernel::num::Bounded;
> +//!
> +//! bitfield! {
> +//!     pub struct Rgb(u16) {
> +//!         15:11 blue;
> +//!         10:5 green;
> +//!         4:0 red;

Hi Alex,

Can you please describe those implied naming limitations we've
discussed on the previous round, like with_blue, BLUE_SHIFT etc.
in a separate top comment?

With that,

Acked-by: Yury Norov <ynorov@nvidia.com>

> +//!     }
> +//! }
> +//!
> +//! // Valid value for the `blue` field.
> +//! let blue = Bounded::<u16, 5>::new::<0x18>();
> +//!
> +//! // Setters can be chained. Values ranges are checked at compile-time.
> +//! let color = Rgb::zeroed()
> +//!     // Compile-time bounds check of constant value.
> +//!     .with_const_red::<0x10>()
> +//!     .with_const_green::<0x1f>()
> +//!     // A `Bounded` can also be passed.
> +//!     .with_blue(blue);
> +//!
> +//! assert_eq!(color.red(), 0x10);
> +//! assert_eq!(color.green(), 0x1f);
> +//! assert_eq!(color.blue(), 0x18);
> +//! assert_eq!(
> +//!     color.into_raw(),
> +//!     (0x18 << Rgb::BLUE_SHIFT) + (0x1f << Rgb::GREEN_SHIFT) + 0x10,
> +//! );
> +//!
> +//! // Convert to/from the backing storage type.
> +//! let raw: u16 = color.into();
> +//! assert_eq!(Rgb::from(raw), color);
> +//! ```
> +//!
> +//! # Syntax
> +//!
> +//! ```text
> +//! bitfield! {
> +//!     #[attributes]
> +//!     // Documentation for `Name`.
> +//!     pub struct Name(storage_type) {
> +//!         // `field_1` documentation.
> +//!         hi:lo field_1;
> +//!         // `field_2` documentation.
> +//!         hi:lo field_2 => ConvertedType;
> +//!         // `field_3` documentation.
> +//!         hi:lo field_3 ?=> ConvertedType;
> +//!         ...
> +//!     }
> +//! }
> +//! ```
> +//!
> +//! - `storage_type`: The underlying integer type (`u8`, `u16`, `u32`, `u64`).
> +//! - `hi:lo`: Bit range (inclusive), where `hi >= lo`.
> +//! - `=> Type`: Optional infallible conversion (see [below](#infallible-conversion-)).
> +//! - `?=> Type`: Optional fallible conversion (see [below](#fallible-conversion-)).
> +//! - Documentation strings and attributes are optional.
> +//!
> +//! # Generated code
> +//!
> +//! Each field is internally represented as a [`Bounded`] parameterized by its bit width. Field
> +//! values can either be set/retrieved directly, or converted from/to another type.
> +//!
> +//! The use of `Bounded` for each field enforces bounds-checking (at build time or runtime) of every
> +//! value assigned to a field. This ensures that data is never accidentally truncated.
> +//!
> +//! The macro generates the bitfield type, [`From`] and [`Into`] implementations for its storage
> +//! type, as well as [`Debug`] and [`Zeroable`](pin_init::Zeroable) implementations.
> +//!
> +//! For each field, it also generates:
> +//!
> +//! - `with_field(value)` — infallible setter; the argument type must be statically known to fit
> +//!   the field width.
> +//! - `with_const_field::<VALUE>()` — const setter; the value is validated at compile time.
> +//!   Usually shorter to use than `with_field` for constant values as it doesn't require
> +//!   constructing a `Bounded`.
> +//! - `try_with_field(value)` — fallible setter. Returns an error if the value is out of range.
> +//! - `FIELD_MASK`, `FIELD_SHIFT`, `FIELD_RANGE` - constants for manual bit manipulation.
> +//!
> +//! # Implicit conversions
> +//!
> +//! Types that fit entirely within a field's bit width can be used directly with setters. For
> +//! example, `bool` works with single-bit fields, and `u8` works with 8-bit fields:
> +//!
> +//! ```rust
> +//! use kernel::bitfield;
> +//!
> +//! bitfield! {
> +//!     pub struct Flags(u32) {
> +//!         15:8 byte_field;
> +//!         0:0 flag;
> +//!     }
> +//! }
> +//!
> +//! let flags = Flags::zeroed()
> +//!     .with_byte_field(0x42_u8)
> +//!     .with_flag(true);
> +//!
> +//! assert_eq!(flags.into_raw(), (0x42 << Flags::BYTE_FIELD_SHIFT) | 1);
> +//! ```
> +//!
> +//! # Runtime bounds checking
> +//!
> +//! When a value is not known at compile time, use `try_with_field()` to check bounds at runtime:
> +//!
> +//! ```rust
> +//! use kernel::bitfield;
> +//!
> +//! bitfield! {
> +//!     pub struct Config(u8) {
> +//!         3:0 nibble;
> +//!     }
> +//! }
> +//!
> +//! fn set_nibble(config: Config, value: u8) -> Result<Config, Error> {
> +//!     // Returns `EOVERFLOW` if `value > 0xf`.
> +//!     config.try_with_nibble(value)
> +//! }
> +//! # Ok::<(), Error>(())
> +//! ```
> +//!
> +//! # Type conversion
> +//!
> +//! Fields can be automatically converted to/from a custom type using `=>` (infallible) or `?=>`
> +//! (fallible). The custom type must implement the appropriate `From` or `TryFrom` traits with
> +//! `Bounded`.
> +//!
> +//! ## Infallible conversion (`=>`)
> +//!
> +//! Use this when all possible bit patterns of a field map to valid values:
> +//!
> +//! ```rust
> +//! use kernel::bitfield;
> +//! use kernel::num::Bounded;
> +//!
> +//! #[derive(Debug, Clone, Copy, PartialEq)]
> +//! enum Power {
> +//!     Off,
> +//!     On,
> +//! }
> +//!
> +//! impl From<Bounded<u32, 1>> for Power {
> +//!     fn from(v: Bounded<u32, 1>) -> Self {
> +//!         match *v {
> +//!             0 => Power::Off,
> +//!             _ => Power::On,
> +//!         }
> +//!     }
> +//! }
> +//!
> +//! impl From<Power> for Bounded<u32, 1> {
> +//!     fn from(p: Power) -> Self {
> +//!         (p as u32 != 0).into()
> +//!     }
> +//! }
> +//!
> +//! bitfield! {
> +//!     pub struct Control(u32) {
> +//!         0:0 power => Power;
> +//!     }
> +//! }
> +//!
> +//! let ctrl = Control::zeroed().with_power(Power::On);
> +//! assert_eq!(ctrl.power(), Power::On);
> +//! ```
> +//!
> +//! ## Fallible conversion (`?=>`)
> +//!
> +//! Use this when some bit patterns of a field are invalid. The getter returns a [`Result`]:
> +//!
> +//! ```rust
> +//! use kernel::bitfield;
> +//! use kernel::num::Bounded;
> +//!
> +//! #[derive(Debug, Clone, Copy, PartialEq)]
> +//! enum Mode {
> +//!     Low = 0,
> +//!     High = 1,
> +//!     Auto = 2,
> +//!     // 3 is invalid
> +//! }
> +//!
> +//! impl TryFrom<Bounded<u32, 2>> for Mode {
> +//!     type Error = u32;
> +//!
> +//!     fn try_from(v: Bounded<u32, 2>) -> Result<Self, u32> {
> +//!         match *v {
> +//!             0 => Ok(Mode::Low),
> +//!             1 => Ok(Mode::High),
> +//!             2 => Ok(Mode::Auto),
> +//!             n => Err(n),
> +//!         }
> +//!     }
> +//! }
> +//!
> +//! impl From<Mode> for Bounded<u32, 2> {
> +//!     fn from(m: Mode) -> Self {
> +//!         match m {
> +//!             Mode::Low => Bounded::<u32, _>::new::<0>(),
> +//!             Mode::High => Bounded::<u32, _>::new::<1>(),
> +//!             Mode::Auto => Bounded::<u32, _>::new::<2>(),
> +//!         }
> +//!     }
> +//! }
> +//!
> +//! bitfield! {
> +//!     pub struct Config(u32) {
> +//!         1:0 mode ?=> Mode;
> +//!     }
> +//! }
> +//!
> +//! let cfg = Config::zeroed().with_mode(Mode::Auto);
> +//! assert_eq!(cfg.mode(), Ok(Mode::Auto));
> +//!
> +//! // Invalid bit pattern returns an error.
> +//! assert_eq!(Config::from(0b11).mode(), Err(3));
> +//! ```
> +//!
> +//! [`Bounded`]: kernel::num::Bounded
> +
> +/// Defines a bitfield struct with bounds-checked accessors for individual bit ranges.
> +///
> +/// See the [`mod@kernel::bitfield`] module for full documentation and examples.
> +#[macro_export]
> +macro_rules! bitfield {
> +    // Entry point defining the bitfield struct, its implementations and its field accessors.
> +    (
> +        $(#[$attr:meta])* $vis:vis struct $name:ident($storage:ty) { $($fields:tt)* }
> +    ) => {
> +        $crate::bitfield!(@core
> +            #[allow(non_camel_case_types)]
> +            $(#[$attr])* $vis $name $storage
> +        );
> +        $crate::bitfield!(@fields $vis $name $storage { $($fields)* });
> +    };
> +
> +    // All rules below are helpers.
> +
> +    // Defines the wrapper `$name` type and its conversions from/to the storage type.
> +    (@core $(#[$attr:meta])* $vis:vis $name:ident $storage:ty) => {
> +        $(#[$attr])*
> +        #[repr(transparent)]
> +        #[derive(Clone, Copy, PartialEq, Eq)]
> +        $vis struct $name {
> +            inner: $storage,
> +        }
> +
> +        #[allow(dead_code)]
> +        impl $name {
> +            /// Creates a bitfield from a raw value.
> +            #[inline(always)]
> +            $vis const fn from_raw(value: $storage) -> Self {
> +                Self{ inner: value }
> +            }
> +
> +            /// Turns this bitfield into its raw value.
> +            ///
> +            /// This is similar to the [`From`] implementation, but is shorter to invoke in
> +            /// most cases.
> +            #[inline(always)]
> +            $vis const fn into_raw(self) -> $storage {
> +                self.inner
> +            }
> +        }
> +
> +        // SAFETY: `$storage` is `Zeroable` and `$name` is transparent.
> +        unsafe impl ::pin_init::Zeroable for $name {}
> +
> +        impl ::core::convert::From<$name> for $storage {
> +            #[inline(always)]
> +            fn from(val: $name) -> $storage {
> +                val.into_raw()
> +            }
> +        }
> +
> +        impl ::core::convert::From<$storage> for $name {
> +            #[inline(always)]
> +            fn from(val: $storage) -> $name {
> +                Self::from_raw(val)
> +            }
> +        }
> +    };
> +
> +    // Definitions requiring knowledge of individual fields: private and public field accessors,
> +    // and `Debug` implementation.
> +    (@fields $vis:vis $name:ident $storage:ty {
> +        $($(#[doc = $doc:expr])* $hi:literal:$lo:literal $field:ident
> +            $(?=> $try_into_type:ty)?
> +            $(=> $into_type:ty)?
> +        ;
> +        )*
> +    }
> +    ) => {
> +        #[allow(dead_code)]
> +        impl $name {
> +        $(
> +        $crate::bitfield!(@private_field_accessors $vis $name $storage : $hi:$lo $field);
> +        $crate::bitfield!(
> +            @public_field_accessors $(#[doc = $doc])* $vis $name $storage : $hi:$lo $field
> +            $(?=> $try_into_type)?
> +            $(=> $into_type)?
> +        );
> +        )*
> +        }
> +
> +        $crate::bitfield!(@debug $name { $($field;)* });
> +    };
> +
> +    // Private field accessors working with the exact `Bounded` type for the field.
> +    (
> +        @private_field_accessors $vis:vis $name:ident $storage:ty : $hi:tt:$lo:tt $field:ident
> +    ) => {
> +        ::kernel::macros::paste!(
> +        $vis const [<$field:upper _RANGE>]: ::core::ops::RangeInclusive<u8> = $lo..=$hi;
> +        $vis const [<$field:upper _MASK>]: $storage =
> +            ((((1 << $hi) - 1) << 1) + 1) - ((1 << $lo) - 1);
> +        $vis const [<$field:upper _SHIFT>]: u32 = $lo;
> +        );
> +
> +        ::kernel::macros::paste!(
> +        fn [<__ $field>](self) ->
> +            ::kernel::num::Bounded<$storage, { $hi + 1 - $lo }> {
> +            // Left shift to align the field's MSB with the storage MSB.
> +            const ALIGN_TOP: u32 = $storage::BITS - ($hi + 1);
> +            // Right shift to move the top-aligned field to bit 0 of the storage.
> +            const ALIGN_BOTTOM: u32 = ALIGN_TOP + $lo;
> +
> +            // Extract the field using two shifts. `Bounded::shr` produces the correctly-sized
> +            // output type.
> +            let val = ::kernel::num::Bounded::<$storage, { $storage::BITS }>::from(
> +                self.inner << ALIGN_TOP
> +            );
> +            val.shr::<ALIGN_BOTTOM, { $hi + 1 - $lo } >()
> +        }
> +
> +        const fn [<__with_ $field>](
> +            mut self,
> +            value: ::kernel::num::Bounded<$storage, { $hi + 1 - $lo }>,
> +        ) -> Self
> +        {
> +            const MASK: $storage = <$name>::[<$field:upper _MASK>];
> +            const SHIFT: u32 = <$name>::[<$field:upper _SHIFT>];
> +
> +            let value = value.get() << SHIFT;
> +            self.inner = (self.inner & !MASK) | value;
> +
> +            self
> +        }
> +        );
> +    };
> +
> +    // Public accessors for fields infallibly (`=>`) converted to a type.
> +    (
> +        @public_field_accessors $(#[doc = $doc:expr])* $vis:vis $name:ident $storage:ty :
> +            $hi:literal:$lo:literal $field:ident => $into_type:ty
> +    ) => {
> +        ::kernel::macros::paste!(
> +
> +        $(#[doc = $doc])*
> +        #[doc = "Returns the value of this field."]
> +        #[inline(always)]
> +        $vis fn $field(self) -> $into_type
> +        {
> +            self.[<__ $field>]().into()
> +        }
> +
> +        $(#[doc = $doc])*
> +        #[doc = "Sets this field to the given `value`."]
> +        #[inline(always)]
> +        $vis fn [<with_ $field>](self, value: $into_type) -> Self
> +        {
> +            self.[<__with_ $field>](value.into())
> +        }
> +
> +        );
> +    };
> +
> +    // Public accessors for fields fallibly (`?=>`) converted to a type.
> +    (
> +        @public_field_accessors $(#[doc = $doc:expr])* $vis:vis $name:ident $storage:ty :
> +            $hi:tt:$lo:tt $field:ident ?=> $try_into_type:ty
> +    ) => {
> +        ::kernel::macros::paste!(
> +
> +        $(#[doc = $doc])*
> +        #[doc = "Returns the value of this field."]
> +        #[inline(always)]
> +        $vis fn $field(self) ->
> +            Result<
> +                $try_into_type,
> +                <$try_into_type as ::core::convert::TryFrom<
> +                    ::kernel::num::Bounded<$storage, { $hi + 1 - $lo }>
> +                >>::Error
> +            >
> +        {
> +            self.[<__ $field>]().try_into()
> +        }
> +
> +        $(#[doc = $doc])*
> +        #[doc = "Sets this field to the given `value`."]
> +        #[inline(always)]
> +        $vis fn [<with_ $field>](self, value: $try_into_type) -> Self
> +        {
> +            self.[<__with_ $field>](value.into())
> +        }
> +
> +        );
> +    };
> +
> +    // Public accessors for fields not converted to a type.
> +    (
> +        @public_field_accessors $(#[doc = $doc:expr])* $vis:vis $name:ident $storage:ty :
> +            $hi:tt:$lo:tt $field:ident
> +    ) => {
> +        ::kernel::macros::paste!(
> +
> +        $(#[doc = $doc])*
> +        #[doc = "Returns the value of this field."]
> +        #[inline(always)]
> +        $vis fn $field(self) ->
> +            ::kernel::num::Bounded<$storage, { $hi + 1 - $lo }>
> +        {
> +            self.[<__ $field>]()
> +        }
> +
> +        $(#[doc = $doc])*
> +        #[doc = "Sets this field to the compile-time constant `VALUE`."]
> +        #[inline(always)]
> +        $vis const fn [<with_const_ $field>]<const VALUE: $storage>(self) -> Self {
> +            self.[<__with_ $field>](
> +                ::kernel::num::Bounded::<$storage, { $hi + 1 - $lo }>::new::<VALUE>()
> +            )
> +        }
> +
> +        $(#[doc = $doc])*
> +        #[doc = "Sets this field to the given `value`."]
> +        #[inline(always)]
> +        $vis fn [<with_ $field>]<T>(
> +            self,
> +            value: T,
> +        ) -> Self
> +            where T: Into<::kernel::num::Bounded<$storage, { $hi + 1 - $lo }>>,
> +        {
> +            self.[<__with_ $field>](value.into())
> +        }
> +
> +        $(#[doc = $doc])*
> +        #[doc = "Tries to set this field to `value`, returning an error if it is out of range."]
> +        #[inline(always)]
> +        $vis fn [<try_with_ $field>]<T>(
> +            self,
> +            value: T,
> +        ) -> ::kernel::error::Result<Self>
> +            where T: ::kernel::num::TryIntoBounded<$storage, { $hi + 1 - $lo }>,
> +        {
> +            Ok(
> +                self.[<__with_ $field>](
> +                    value.try_into_bounded().ok_or(::kernel::error::code::EOVERFLOW)?
> +                )
> +            )
> +        }
> +
> +        );
> +    };
> +
> +    // `Debug` implementation.
> +    (@debug $name:ident { $($field:ident;)* }) => {
> +        impl ::kernel::fmt::Debug for $name {
> +            fn fmt(&self, f: &mut ::kernel::fmt::Formatter<'_>) -> ::kernel::fmt::Result {
> +                f.debug_struct(stringify!($name))
> +                    .field("<raw>", &::kernel::prelude::fmt!("{:#x}", self.inner))
> +                $(
> +                    .field(stringify!($field), &self.$field())
> +                )*
> +                    .finish()
> +            }
> +        }
> +    };
> +}
> diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
> index abc49926abfe..388647f28292 100644
> --- a/rust/kernel/io/register.rs
> +++ b/rust/kernel/io/register.rs
> @@ -956,11 +956,10 @@ macro_rules! register {
>      (
>          @bitfield $(#[$attr:meta])* $vis:vis struct $name:ident($storage:ty) { $($fields:tt)* }
>      ) => {
> -        $crate::register!(@bitfield_core
> +        $crate::bitfield!(
>              #[allow(non_camel_case_types)]
> -            $(#[$attr])* $vis $name $storage
> +            $(#[$attr])* $vis struct $name($storage) { $($fields)* }
>          );
> -        $crate::register!(@bitfield_fields $vis $name $storage { $($fields)* });
>      };
>  
>      // Implementations shared by all registers types.
> @@ -1016,245 +1015,4 @@ impl $crate::io::register::RegisterArray for $name {
>  
>          impl $crate::io::register::RelativeRegisterArray for $name {}
>      };
> -
> -    // Defines the wrapper `$name` type and its conversions from/to the storage type.
> -    (@bitfield_core $(#[$attr:meta])* $vis:vis $name:ident $storage:ty) => {
> -        $(#[$attr])*
> -        #[repr(transparent)]
> -        #[derive(Clone, Copy, PartialEq, Eq)]
> -        $vis struct $name {
> -            inner: $storage,
> -        }
> -
> -        #[allow(dead_code)]
> -        impl $name {
> -            /// Creates a bitfield from a raw value.
> -            #[inline(always)]
> -            $vis const fn from_raw(value: $storage) -> Self {
> -                Self{ inner: value }
> -            }
> -
> -            /// Turns this bitfield into its raw value.
> -            ///
> -            /// This is similar to the [`From`] implementation, but is shorter to invoke in
> -            /// most cases.
> -            #[inline(always)]
> -            $vis const fn into_raw(self) -> $storage {
> -                self.inner
> -            }
> -        }
> -
> -        // SAFETY: `$storage` is `Zeroable` and `$name` is transparent.
> -        unsafe impl ::pin_init::Zeroable for $name {}
> -
> -        impl ::core::convert::From<$name> for $storage {
> -            #[inline(always)]
> -            fn from(val: $name) -> $storage {
> -                val.into_raw()
> -            }
> -        }
> -
> -        impl ::core::convert::From<$storage> for $name {
> -            #[inline(always)]
> -            fn from(val: $storage) -> $name {
> -                Self::from_raw(val)
> -            }
> -        }
> -    };
> -
> -    // Definitions requiring knowledge of individual fields: private and public field accessors,
> -    // and `Debug` implementation.
> -    (@bitfield_fields $vis:vis $name:ident $storage:ty {
> -        $($(#[doc = $doc:expr])* $hi:literal:$lo:literal $field:ident
> -            $(?=> $try_into_type:ty)?
> -            $(=> $into_type:ty)?
> -        ;
> -        )*
> -    }
> -    ) => {
> -        #[allow(dead_code)]
> -        impl $name {
> -        $(
> -        $crate::register!(@private_field_accessors $vis $name $storage : $hi:$lo $field);
> -        $crate::register!(
> -            @public_field_accessors $(#[doc = $doc])* $vis $name $storage : $hi:$lo $field
> -            $(?=> $try_into_type)?
> -            $(=> $into_type)?
> -        );
> -        )*
> -        }
> -
> -        $crate::register!(@debug $name { $($field;)* });
> -    };
> -
> -    // Private field accessors working with the exact `Bounded` type for the field.
> -    (
> -        @private_field_accessors $vis:vis $name:ident $storage:ty : $hi:tt:$lo:tt $field:ident
> -    ) => {
> -        ::kernel::macros::paste!(
> -        $vis const [<$field:upper _RANGE>]: ::core::ops::RangeInclusive<u8> = $lo..=$hi;
> -        $vis const [<$field:upper _MASK>]: $storage =
> -            ((((1 << $hi) - 1) << 1) + 1) - ((1 << $lo) - 1);
> -        $vis const [<$field:upper _SHIFT>]: u32 = $lo;
> -        );
> -
> -        ::kernel::macros::paste!(
> -        fn [<__ $field>](self) ->
> -            ::kernel::num::Bounded<$storage, { $hi + 1 - $lo }> {
> -            // Left shift to align the field's MSB with the storage MSB.
> -            const ALIGN_TOP: u32 = $storage::BITS - ($hi + 1);
> -            // Right shift to move the top-aligned field to bit 0 of the storage.
> -            const ALIGN_BOTTOM: u32 = ALIGN_TOP + $lo;
> -
> -            // Extract the field using two shifts. `Bounded::shr` produces the correctly-sized
> -            // output type.
> -            let val = ::kernel::num::Bounded::<$storage, { $storage::BITS }>::from(
> -                self.inner << ALIGN_TOP
> -            );
> -            val.shr::<ALIGN_BOTTOM, { $hi + 1 - $lo } >()
> -        }
> -
> -        const fn [<__with_ $field>](
> -            mut self,
> -            value: ::kernel::num::Bounded<$storage, { $hi + 1 - $lo }>,
> -        ) -> Self
> -        {
> -            const MASK: $storage = <$name>::[<$field:upper _MASK>];
> -            const SHIFT: u32 = <$name>::[<$field:upper _SHIFT>];
> -
> -            let value = value.get() << SHIFT;
> -            self.inner = (self.inner & !MASK) | value;
> -
> -            self
> -        }
> -        );
> -    };
> -
> -    // Public accessors for fields infallibly (`=>`) converted to a type.
> -    (
> -        @public_field_accessors $(#[doc = $doc:expr])* $vis:vis $name:ident $storage:ty :
> -            $hi:literal:$lo:literal $field:ident => $into_type:ty
> -    ) => {
> -        ::kernel::macros::paste!(
> -
> -        $(#[doc = $doc])*
> -        #[doc = "Returns the value of this field."]
> -        #[inline(always)]
> -        $vis fn $field(self) -> $into_type
> -        {
> -            self.[<__ $field>]().into()
> -        }
> -
> -        $(#[doc = $doc])*
> -        #[doc = "Sets this field to the given `value`."]
> -        #[inline(always)]
> -        $vis fn [<with_ $field>](self, value: $into_type) -> Self
> -        {
> -            self.[<__with_ $field>](value.into())
> -        }
> -
> -        );
> -    };
> -
> -    // Public accessors for fields fallibly (`?=>`) converted to a type.
> -    (
> -        @public_field_accessors $(#[doc = $doc:expr])* $vis:vis $name:ident $storage:ty :
> -            $hi:tt:$lo:tt $field:ident ?=> $try_into_type:ty
> -    ) => {
> -        ::kernel::macros::paste!(
> -
> -        $(#[doc = $doc])*
> -        #[doc = "Returns the value of this field."]
> -        #[inline(always)]
> -        $vis fn $field(self) ->
> -            Result<
> -                $try_into_type,
> -                <$try_into_type as ::core::convert::TryFrom<
> -                    ::kernel::num::Bounded<$storage, { $hi + 1 - $lo }>
> -                >>::Error
> -            >
> -        {
> -            self.[<__ $field>]().try_into()
> -        }
> -
> -        $(#[doc = $doc])*
> -        #[doc = "Sets this field to the given `value`."]
> -        #[inline(always)]
> -        $vis fn [<with_ $field>](self, value: $try_into_type) -> Self
> -        {
> -            self.[<__with_ $field>](value.into())
> -        }
> -
> -        );
> -    };
> -
> -    // Public accessors for fields not converted to a type.
> -    (
> -        @public_field_accessors $(#[doc = $doc:expr])* $vis:vis $name:ident $storage:ty :
> -            $hi:tt:$lo:tt $field:ident
> -    ) => {
> -        ::kernel::macros::paste!(
> -
> -        $(#[doc = $doc])*
> -        #[doc = "Returns the value of this field."]
> -        #[inline(always)]
> -        $vis fn $field(self) ->
> -            ::kernel::num::Bounded<$storage, { $hi + 1 - $lo }>
> -        {
> -            self.[<__ $field>]()
> -        }
> -
> -        $(#[doc = $doc])*
> -        #[doc = "Sets this field to the compile-time constant `VALUE`."]
> -        #[inline(always)]
> -        $vis const fn [<with_const_ $field>]<const VALUE: $storage>(self) -> Self {
> -            self.[<__with_ $field>](
> -                ::kernel::num::Bounded::<$storage, { $hi + 1 - $lo }>::new::<VALUE>()
> -            )
> -        }
> -
> -        $(#[doc = $doc])*
> -        #[doc = "Sets this field to the given `value`."]
> -        #[inline(always)]
> -        $vis fn [<with_ $field>]<T>(
> -            self,
> -            value: T,
> -        ) -> Self
> -            where T: Into<::kernel::num::Bounded<$storage, { $hi + 1 - $lo }>>,
> -        {
> -            self.[<__with_ $field>](value.into())
> -        }
> -
> -        $(#[doc = $doc])*
> -        #[doc = "Tries to set this field to `value`, returning an error if it is out of range."]
> -        #[inline(always)]
> -        $vis fn [<try_with_ $field>]<T>(
> -            self,
> -            value: T,
> -        ) -> ::kernel::error::Result<Self>
> -            where T: ::kernel::num::TryIntoBounded<$storage, { $hi + 1 - $lo }>,
> -        {
> -            Ok(
> -                self.[<__with_ $field>](
> -                    value.try_into_bounded().ok_or(::kernel::error::code::EOVERFLOW)?
> -                )
> -            )
> -        }
> -
> -        );
> -    };
> -
> -    // `Debug` implementation.
> -    (@debug $name:ident { $($field:ident;)* }) => {
> -        impl ::kernel::fmt::Debug for $name {
> -            fn fmt(&self, f: &mut ::kernel::fmt::Formatter<'_>) -> ::kernel::fmt::Result {
> -                f.debug_struct(stringify!($name))
> -                    .field("<raw>", &::kernel::prelude::fmt!("{:#x}", self.inner))
> -                $(
> -                    .field(stringify!($field), &self.$field())
> -                )*
> -                    .finish()
> -            }
> -        }
> -    };
>  }
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 40de00ce4f97..31e5f5908dfc 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -77,6 +77,7 @@
>  pub mod alloc;
>  #[cfg(CONFIG_AUXILIARY_BUS)]
>  pub mod auxiliary;
> +pub mod bitfield;
>  pub mod bitmap;
>  pub mod bits;
>  #[cfg(CONFIG_BLOCK)]
> 
> -- 
> 2.53.0
