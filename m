Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A4FE9380B
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 02:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 061BB10E2F4;
	Mon, 13 Apr 2026 02:29:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="oUdNd+Rk";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D70710E2F2
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 02:29:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCs29zJaJrF4NcvEK75eZs1xglT3n5WI1uxTAd7INLrFLhj65hMOJbukzuT0+RbMEmVnXmaQn5A910peyiMdcbj8EA+S60F41WUvcIWjTvFzmU39v/dVcEx56fPxZpbuThsW/Gv/vY53zVHxzCkiBOOOCpGq+VNODytWehkqiRJRTOCol9soD2hSRQxmK7jxaVuGAqrhqr5l6/OCZKGy7jwuHWl+7fNyJ3EC4cL/3IhaXRicRazn6lWmSaS4JeCqb6vm001behSKzK71832F+5fyq6MEtQ5eJKcQ62DSRgzLIqYUJymSgSgBDYcYVPUJaFmWydUfisrEsKAGQhDzxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBPzilbHWPPS89ZP2/+OiByqghl+lyOhdDZp4bzBWLo=;
 b=pTG/10G5qOari8nXguaDI9EdkHiYnbQ3d01kyQdERp7Rx7aSDSkeP7Gtj/nW7wEAUStyQaBmB3sqOO36IgFjdC384OD27e6qwMxLMymR60E2z0CcZK2vAi8Q+G1R8t7FlcS11CSYNUQB8dHr5kXsJDVPrY4Ow2kyMWsZuZmeRWAcEVMnE4eMvep4s2Ye7SD5pTeBbIwP2G0/bNpnJnkMkNsAZK217LQlHL/7KBqH0WzOpQjcGv57O/Ra4A4Lp5p1gSLXQDT0ubWveoka7Es37Wza17KwJlN9cIpr48YEEYxx5GvTzvDrTlN1FUbjF4/3NeNw2wxXyqAyT0IydAwpYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBPzilbHWPPS89ZP2/+OiByqghl+lyOhdDZp4bzBWLo=;
 b=oUdNd+Rki9+eYh6J8TGuNweqDF19P4hNq0ZKJVKv6lrDe2bQhvKcLNYWIKdv5MdEkMpgjpYdQOTQZK+e/b9XgowykF7QJckAV1MYwyXTA8A1w0+/3ocW29JBE67k9pmcQjnfTGVeE65cttS1dreax+ccTIsRtQhX80JMpaw35zvq97T/svjL4IlBnvB2yCg8d7zHz9K2XmH3+KF9j0ZkJZ1WFvbDYAwH2iDlXCQpLdMtKSuHLQMNmldn4tp1FEQEbURFSahy6TkikkeereVL2ppiwlN3mEMlxvb9vcDM9q/GJK/W4ntbciB/+GEx2jrUwds89lvO9dUS2LfgdohahQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CYXPR12MB9428.namprd12.prod.outlook.com (2603:10b6:930:d5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Mon, 13 Apr
 2026 02:29:51 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 02:29:51 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Apr 2026 11:29:47 +0900
Message-Id: <DHRO963VKBJG.1RNNN4EJ791PP@nvidia.com>
Subject: Re: [PATCH v2 1/3] rust: extract `bitfield!` macro from `register!`
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
 <20260409-bitfield-v2-1-23ac400071cb@nvidia.com>
In-Reply-To: <20260409-bitfield-v2-1-23ac400071cb@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0194.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::18) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CYXPR12MB9428:EE_
X-MS-Office365-Filtering-Correlation-Id: 97ad40bc-6e43-4d7c-3f97-08de99048a60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|10070799003|376014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: FXBohKrN+hj5Sd2eOh+opI5HBQAsfmugImCYpi0Q6ydiAT7hN5QIH45NavxDGGq3Pt5zOZSSB+S3ZX3G+tun/sKPxFHLEmXQFhhrhBg0SORXuRhXL1QQl7PDh/Rm8nHx8UmV39nIzlQrAvskJ9rx+Iv6xdsVSSl8X+YPqzKEopEb2DefFwOLvimR9UHamii3202BoU7swcrN+x79y34k5sKPbQeyZ75XTuxDRZO5NodjxI+1HViKKjYOctjCK7s9QTRzEZiQGMam0T5eotbyNS5i63RdN1HJSey/ODFS5YdUpSmpq5PKCkP6zRBQ2rZPm+T31uKuIKiGEHbQxgla3+CPFphdkmuJo2DmzAbVu/ikmWnl19VlyTjRpq1spSbYbVBLqcRiChfdZ8CmyYlgCpsxkacYP35SDPkRCT9hUbZZpNn0HGgD8rVWkKMF5GHCKEhIZw6YNMJ649ovuk5AOlDCEBc9f2Z2F9K71EVXSEfVwJn7sjoP5VWIjgTmlbxILeTIumhbC6jpNa86UIHvDSFcl0ur/ujQOXfIZ6jXSO42u99UOC2SWw6UlnC7oKK5rL3Ci8Gm4zHILYc8+FSfl/jPbRTm9poD7Hxrrykq5avjEqkBjz8u5bIJlupsEs3xOAzQ/C0FxWzcEmoMwYSLdQTQdizejhXqT4XWFTkUM4Q1tOipr6vA8mtlwtgcqZEiKtIr7cxbnmt52dZwCYn/eJJW7vJ/gK11Nm4rwz5L/t68Q/2TM3Jn6/HITEzf7oTxiBFQlrPl21kBL+DehpmUXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(10070799003)(376014)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akgxYzVKN2xjVlpqTE1zVmpwWENpb1Yra1dQUFovdTk5UUZUejZ1cm82T25v?=
 =?utf-8?B?RlFvcmJZb2wzb2lVcUQ1aWZPVERVeVpzb0x2dHAvS0xpZm1HZEgxd1o4QWpF?=
 =?utf-8?B?ZmVCeDBnUHNOQ2JBQXZGQTBLMjI3UXZFbUlnVVhVRWNxeWVUdEwwTThwSUhL?=
 =?utf-8?B?Qk0xMi9SWHNPc1pEY21mczZXNXVhREphME51MEcxNVd5T0o2MWNXd0tEcjNN?=
 =?utf-8?B?U2pZbHcreGhjbkZOeUNmTnNHSi8vQUVFclJzOVBab1VMaTdMTHFEelRpdE1q?=
 =?utf-8?B?aytWRjVZTWU1OVpXWTRBRElnQXNGQitVRU1oTHNEN0ZTeEYvRlVhdis3YUV5?=
 =?utf-8?B?bTJOVnZMOUJsVEU5Sk03c3BmbGZhVFZqSDYxeXFxOW1JVW80Z0ZOdlNST0My?=
 =?utf-8?B?M3NUVVlldS9KSnU1NzZkMHMyRktKMzhBYmRYQllYYTlkczRYYlBmS0tXZFVD?=
 =?utf-8?B?Vm4zVGhQMi9aRDRzNm9IaFJNTEFDL3VjMXZVYmNZRnlSdFl3TVFMWmFPdHhv?=
 =?utf-8?B?SFUyWUZ6cVBzTVdQMTgrQ0NiTk1lUHp5VnhhMXdVSk0zVS9SdnNxRU5aa1Fs?=
 =?utf-8?B?SUxlVHMyWWd3T3dneXc0TVI1Mzh3OExDdWplQWFYTnVZak5FTmZld0wzTkZa?=
 =?utf-8?B?MTUyRzV5STI3QjJER0ZPMTV0RWhpelcxUE9uRHVPQ2piaTIrZlJnZlczOXRI?=
 =?utf-8?B?Qlk2YW8xakpOZmtkYzlOdUxwKzdnVlh1SDF0bGlFbmtKTFA4SnNXcWJaVHlp?=
 =?utf-8?B?ZWJuSUlTdStIbVdIWC9PZldJQldKWkJyeGpHNWNBRUY4UUQwWEhLVFBNYllQ?=
 =?utf-8?B?dmpvUHlIbVYvL1YrT1FMMjdwMk9EcTFndm1mRHlrNEtaaEZscThuYXdSNHZr?=
 =?utf-8?B?UU5kNm5UZWdrV1ZDK1hYSWlleWp4REtuOW9RZEU5eWkzYW1lK1hkTlRFMWhw?=
 =?utf-8?B?UTlHWkR4a29Ma0VaKzFRWU9uOGNaT3FnOFEwcm8za3lsMVFibWpYUUtOZHhB?=
 =?utf-8?B?Q0FMeERnYmRwY0w4VnRFQTFLeHBtYlp1REI2eU00QklVbS9FOVJFS0d5Rzdp?=
 =?utf-8?B?anFNVHc1RFBMV004VHVDSmg0a2JEUDlZbkhraW5nL1l6VjljbHgzUU1qb0Rj?=
 =?utf-8?B?UjBsMXJuUlRPLzhKSHVTTy8vY282QitHb0tSZHN0K3VvY3dzRUNpMXRpWDYz?=
 =?utf-8?B?azdTeWxpWW1JMzljT0hqTkVaMDluMkVTcFFHaDl5WU11eTI1Rk5yZ3d4VG9p?=
 =?utf-8?B?Y1BBOXQvYUZtazd2QkZDSGxpT0lXbkphWmsxSjE3VnVjYnZlSUtoNFNOZXhB?=
 =?utf-8?B?NGZ2YlpkQzNjajFCWHVlb2hudXA0MlJpbG1Qb2ErcVVFMHdDTHNQbTk1Q3dz?=
 =?utf-8?B?cm5OWWdhQzc0OUE4ekcxYWdaZ3VoTks2UGhPbE4vTjZNTTAvVFV6SUNMSWsy?=
 =?utf-8?B?RDFwU0xCckp2eGtua2xiRHdZcXBUZy8xTVV2YmdMZVU2ZTlHVnk1OFcxdWtX?=
 =?utf-8?B?cklBQmNOS0hZLzN3bXNzZk1KaTBYMnBJYUYvR0s0YXYxNUgzdTBRZmQxYzV2?=
 =?utf-8?B?dmkyMGYwSmVCbkh2RzY1UWs1elNhbnAvNnh3NHd3YjF2azAyZko2ZnBodER5?=
 =?utf-8?B?K0duVkZCdU9pOHVDUHFaQ2ZQUlJWdlRzZVozZ0xhcjU0UlR2WFNJZi90SE13?=
 =?utf-8?B?S0c1OWdmalVIR0J5cGNmdlNWOC9jeDEzelEzOHVNOHZGcS94dTBlNEI1Nmc3?=
 =?utf-8?B?UHVTa1oyYzlCMzZMLzJXT3h6U0t6QmVyOFk0bnMwQ0dQRndJTnh4aGF3RVBG?=
 =?utf-8?B?RHJtZUpBaURzMFlEcTVBRUhhejVFTEVySlZTNnpXMEpOMzExcUx2WGlHeWZM?=
 =?utf-8?B?aHYrV0o3ZkFmei9vVEFqSWZzb3E1VERZdzBwNjA4TWNiUmVTLzhwR2ZXUE44?=
 =?utf-8?B?VHVleVFNTHdHT20wVUh6ZVdNc2hlWHdpemtvWkx4RXdwT3ZMVU9WUFV5aXJ2?=
 =?utf-8?B?QkhrMHBtcUZNWTljcHdDLzQrLzlIWW5UdDlQSTdvNDdvNmFGeFkzNmdDclMx?=
 =?utf-8?B?TkgxZit1elVMeTJ1WmhJVVZGbEhCZlpNWkIrdkpIcEFrdHYzS3pydGZXSVNB?=
 =?utf-8?B?dDdBUTVwNExpSmtYK2paR1h3ZlRGdGZObWwyblE4YUVlMGJLOXZoM3NoSUwz?=
 =?utf-8?B?TjZDRFVjUGd2VjBlZlZXdnRXNURBL0F1dFc1WHBLRkpaZFZBR2FKSVBRM2NJ?=
 =?utf-8?B?blc0dUxZL0JNZWJWSHdPZUxYaEsyTUVIaGRHQkZhMWVjbCtuU0NNOGdhOHRQ?=
 =?utf-8?B?dDgxcDNFaTdMNGlwbmZTNUxkL3VBUG5JR1A5WVRYRDYxM2pTMWRIRVJTUUVT?=
 =?utf-8?Q?7wt/vgzkaXl71ahhJRBVW19t0rBzc9x8zQiM/xUTjPMmu?=
X-MS-Exchange-AntiSpam-MessageData-1: 9yIBAStVg+PkVg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ad40bc-6e43-4d7c-3f97-08de99048a60
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 02:29:51.5325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tp7XA4gi2QJyZNEs9hgvD+ClFFZRzjZ2hG0G/bJEs3PjjklIsSZUZJjb4gtBArkcB25HiZDm2U+lWZMX55VxpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9428
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

On Thu Apr 9, 2026 at 11:58 PM JST, Alexandre Courbot wrote:
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
>  rust/kernel/bitfield.rs    | 491 +++++++++++++++++++++++++++++++++++++++=
++++++
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
> =20
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

nit: Should this be kept in alphabetical order (e.g. with ALLOC here
below?).

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
> +//! The [`bitfield!`](kernel::bitfield!) macro declares integer types th=
at are split into distinct
> +//! bit fields of arbitrary length. Each field is typed using [`Bounded`=
](kernel::num::Bounded) to
> +//! ensure values are properly validated and to avoid implicit data loss=
.
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
> +//!     }
> +//! }
> +//!
> +//! // Valid value for the `blue` field.
> +//! let blue =3D Bounded::<u16, 5>::new::<0x18>();
> +//!
> +//! // Setters can be chained. Values ranges are checked at compile-time=
.
> +//! let color =3D Rgb::zeroed()
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
> +//! let raw: u16 =3D color.into();
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
> +//!         hi:lo field_2 =3D> ConvertedType;
> +//!         // `field_3` documentation.
> +//!         hi:lo field_3 ?=3D> ConvertedType;
> +//!         ...
> +//!     }
> +//! }
> +//! ```
> +//!
> +//! - `storage_type`: The underlying integer type (`u8`, `u16`, `u32`, `=
u64`).
> +//! - `hi:lo`: Bit range (inclusive), where `hi >=3D lo`.
> +//! - `=3D> Type`: Optional infallible conversion (see [below](#infallib=
le-conversion-)).
> +//! - `?=3D> Type`: Optional fallible conversion (see [below](#fallible-=
conversion-)).
> +//! - Documentation strings and attributes are optional.
> +//!
> +//! # Generated code
> +//!
> +//! Each field is internally represented as a [`Bounded`] parameterized =
by its bit width. Field
> +//! values can either be set/retrieved directly, or converted from/to an=
other type.
> +//!
> +//! The use of `Bounded` for each field enforces bounds-checking (at bui=
ld time or runtime) of every
> +//! value assigned to a field. This ensures that data is never accidenta=
lly truncated.
> +//!
> +//! The macro generates the bitfield type, [`From`] and [`Into`] impleme=
ntations for its storage
> +//! type, as well as [`Debug`] and [`Zeroable`](pin_init::Zeroable) impl=
ementations.
> +//!
> +//! For each field, it also generates:
> +//!
> +//! - `with_field(value)` =E2=80=94 infallible setter; the argument type=
 must be statically known to fit
> +//!   the field width.
> +//! - `with_const_field::<VALUE>()` =E2=80=94 const setter; the value is=
 validated at compile time.
> +//!   Usually shorter to use than `with_field` for constant values as it=
 doesn't require
> +//!   constructing a `Bounded`.
> +//! - `try_with_field(value)` =E2=80=94 fallible setter. Returns an erro=
r if the value is out of range.
> +//! - `FIELD_MASK`, `FIELD_SHIFT`, `FIELD_RANGE` - constants for manual =
bit manipulation.
> +//!
> +//! # Implicit conversions
> +//!
> +//! Types that fit entirely within a field's bit width can be used direc=
tly with setters. For
> +//! example, `bool` works with single-bit fields, and `u8` works with 8-=
bit fields:
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
> +//! let flags =3D Flags::zeroed()
> +//!     .with_byte_field(0x42_u8)
> +//!     .with_flag(true);
> +//!
> +//! assert_eq!(flags.into_raw(), (0x42 << Flags::BYTE_FIELD_SHIFT) | 1);
> +//! ```
> +//!
> +//! # Runtime bounds checking
> +//!
> +//! When a value is not known at compile time, use `try_with_field()` to=
 check bounds at runtime:
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
> +//! Fields can be automatically converted to/from a custom type using `=
=3D>` (infallible) or `?=3D>`
> +//! (fallible). The custom type must implement the appropriate `From` or=
 `TryFrom` traits with
> +//! `Bounded`.
> +//!
> +//! ## Infallible conversion (`=3D>`)
> +//!
> +//! Use this when all possible bit patterns of a field map to valid valu=
es:
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
> +//!             0 =3D> Power::Off,
> +//!             _ =3D> Power::On,
> +//!         }
> +//!     }
> +//! }
> +//!
> +//! impl From<Power> for Bounded<u32, 1> {
> +//!     fn from(p: Power) -> Self {
> +//!         (p as u32 !=3D 0).into()
> +//!     }
> +//! }
> +//!
> +//! bitfield! {
> +//!     pub struct Control(u32) {
> +//!         0:0 power =3D> Power;
> +//!     }
> +//! }
> +//!
> +//! let ctrl =3D Control::zeroed().with_power(Power::On);
> +//! assert_eq!(ctrl.power(), Power::On);
> +//! ```
> +//!
> +//! ## Fallible conversion (`?=3D>`)
> +//!
> +//! Use this when some bit patterns of a field are invalid. The getter r=
eturns a [`Result`]:
> +//!
> +//! ```rust
> +//! use kernel::bitfield;
> +//! use kernel::num::Bounded;
> +//!
> +//! #[derive(Debug, Clone, Copy, PartialEq)]
> +//! enum Mode {
> +//!     Low =3D 0,
> +//!     High =3D 1,
> +//!     Auto =3D 2,
> +//!     // 3 is invalid
> +//! }
> +//!
> +//! impl TryFrom<Bounded<u32, 2>> for Mode {
> +//!     type Error =3D u32;
> +//!
> +//!     fn try_from(v: Bounded<u32, 2>) -> Result<Self, u32> {
> +//!         match *v {
> +//!             0 =3D> Ok(Mode::Low),
> +//!             1 =3D> Ok(Mode::High),
> +//!             2 =3D> Ok(Mode::Auto),
> +//!             n =3D> Err(n),
> +//!         }
> +//!     }
> +//! }
> +//!
> +//! impl From<Mode> for Bounded<u32, 2> {
> +//!     fn from(m: Mode) -> Self {
> +//!         match m {
> +//!             Mode::Low =3D> Bounded::<u32, _>::new::<0>(),
> +//!             Mode::High =3D> Bounded::<u32, _>::new::<1>(),
> +//!             Mode::Auto =3D> Bounded::<u32, _>::new::<2>(),
> +//!         }
> +//!     }
> +//! }
> +//!
> +//! bitfield! {
> +//!     pub struct Config(u32) {
> +//!         1:0 mode ?=3D> Mode;
> +//!     }
> +//! }
> +//!
> +//! let cfg =3D Config::zeroed().with_mode(Mode::Auto);
> +//! assert_eq!(cfg.mode(), Ok(Mode::Auto));
> +//!
> +//! // Invalid bit pattern returns an error.
> +//! assert_eq!(Config::from(0b11).mode(), Err(3));
> +//! ```
> +//!
> +//! [`Bounded`]: kernel::num::Bounded

In the nova version of bitfield we had @check_field_bounds. If we put
in the bit numbers the wrong way around, this patch gives a compile
error like:

```
attempt to compute `4_u32 - 7_u32`, which would overflow
```

The original nova version looks like it used build_assert, but I think
we can do it with const assert!, so we should be able to get a better
build error message for this case:

```
const _: () =3D assert!($hi >=3D $lo, "bitfield: hi bit must be >=3D lo bit=
");
```

With just that we get an extra build error, although it still spams the
confusing build error. We could also consider adding a function like:

```
pub const fn bitfield_width(hi: u32, lo: u32) -> u32 {
  assert!(hi >=3D lo, "bitfield: hi bit must be >=3D lo bit");
  hi + 1 - lo
}
```

Using this instead gets rid of some confusing build errors since we can
also use it in type bounds. But to get rid of all of them we would need
to do it for the mask etc and others.

WDYT?
