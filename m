Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D85EC5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:51:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9828C10EEEF;
	Wed, 12 Aug 2026 08:51:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="f18gu0Tp";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011052.outbound.protection.outlook.com [52.101.57.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 550ED10EEEF
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 08:51:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7wplp4WGsgfV6NrHLNTD+BPmIbHknaoYSjzcVbsAW6iIiYgN+of7FZ7FSrFoeGTYoKY1RBAbnynrXsAY888IJYINOpaCAziOP1sxxdit8blM2Y42gziCHY2pwqJKWz2QJEJHFOEMAW2Jxb7OTotkftfwK41lFrfxU/YJ1ne65SpAw0hw517wA7Cjx84S2KRspYhW9oscPY32sN40s2vR3rlTVH8tv8gWPLcJjSZdX4I2qe2I/m3HtkBHyuFMnvewcrx5ok3xU7+gUPLQmS90FKwzVHn+kZdN5TFs2ieof0jaZpJCNNy0TegnM19Q48X4PGGOiGf7hA85NDpfs7RMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZAlwK41n82g8iatn565fzjdFwir6Ged75v/SjZwXFs=;
 b=Hj8eFthTY128OfDJ4KzKjyqPLT3x0jrFZLqoFvPy4M9ZeWNp6+JQXeYCjSZ24G0AwNVYIIPwa7Fm2vcZflbeVvgwzfcMv7VSQ5/m34vd/UL3pQdqrvQpGH8qqaASvXfkbYIUbKa1GeUtbECpl/X9BQN5a3xf9Fx4NQvdyK3iGDFWyjirx2ZmZGetuOo8bI7V1KLYm4b7UYHzZDnoX2b9Jlk2J6e6/TP/lS/F7rQhRd1SDnnHtZ9ET2iTGN+fZTQGjrC8vKjej4S/37E2N+0mx7sImpkIcDaRIlrL/GG1HCjXqGWezNerVvqIbLDlXcSO6h5W7WQq6h+e66ripiPDHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZAlwK41n82g8iatn565fzjdFwir6Ged75v/SjZwXFs=;
 b=f18gu0TpHtuzWWJlkQoR8Jsi42MOTuAqgWgk/PYt19kgCmHI58JUrSLycibZ0pW3JHkLL9gI1wCZVtUmrn8qUwBgJUcfx0/aWsHG6c9OJ3v3tGhinGU3ciYS5hrSTOpSne830SLLkBIYLacNxATrsE7tGPu1zoepcJXaNlLtcTCT11bujWWyBpJXflZ7pp6KgHnaMSPGoKFJdwhcKVCaKGC6NwIvFIhcgSNtsmw3LShDUmql+sGzJ+OLn1+mHMbJFzCJNbsXsJtVPJXRvFQT2ZeXAZ04xPyC675ZMF8FRnhCTQM4pnTPEfPLFisjA19nBMdmxk5IYWAGj/KgobsQqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 08:51:50 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 08:51:50 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 12 Aug 2026 17:51:22 +0900
Subject: [PATCH v5 2/5] rust: bitmap: restrict bitmap length to at most
 i32::MAX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-chid-v5-2-6c767770b3f4@nvidia.com>
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
In-Reply-To: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: DU2PR04CA0207.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::32) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 35230042-eebf-4fae-c687-08def84ef355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|7416014|376014|366016|1800799024|921020|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MCKjDtPxXvQVhhobR80+XNJ3q/AVuBPGYvJsmUNgzIoLkY2v9uBCxuwU1gfEeE8JHYPTdh7Sni4MfOl4ywiehtPSq277RdonOSzstGJk2Arsl0hD8va0p2+G+WANae7xaHyGwgPTAuvIcOc5Ica0MbIPFyxS13PPSZWObcPOYOka8WpA/9CfXmw/9EN2ap+g1PEHot7QvkKWgM+1hh8qtaXwek354YyOYGbRfwtghCZmHKrvZm+xsROr8LoJlRyUfXGtEXYzl8R/nmJgBIDzi4mhHmfC/Gk+fmtY5t/yeYSx8OFzwoYk7+UCkr2vIjFPA+h0fsd7P9O/Vc9lruvVwt782v9tAp29HnysTWhHtQjMZdwjfXQcH4ML8n3i70D/ljXJpHYfjviQG0sXe3PrV07Zo2HwWNHY8WBvO8dXeSoZsIIsVq4mInQLIBlT+11wNBrMEEga8PscFgliPsl0wgB2OuLzLnf+jdDVs5S3gqewc0byvELp95Ab3A9vVwEMELGQdiYNLv4Ltd4gL6Vh05zjTFvBskG6gs9mT4+1JrN/x0BwWIPQK06qM8ue9pxtF93lE9rwxlfsXW/AfcohtA0uPxmBTVANyGB6qevL98ebb4IMNwDBQ85C7h8Wl1KZoHweMJQfq1ECtyKOJ7z+suuQ2eKye51RJMSDpG1ziQfCkr6AOJPf7wZEpe1Un1Cr7XVrySofk3xgxrDGEPCPCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(7416014)(376014)(366016)(1800799024)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjBXUDFKb1BLQlQ2NEJaMGQ2VzJTTGIrTzRQUTFYWVFxamxVS09sa3Z0ZFBS?=
 =?utf-8?B?NG9tS3lsSmtGMElmQ3dUZW05cHBlenZUMHZEbGpoK2tVMHhiVjl3ekk5QU1a?=
 =?utf-8?B?NmJzTTk2ZUIrYkpRUWZrMnpMYkNIb1dUa05nL2lINlJzYXZTWVRGVG1uQ291?=
 =?utf-8?B?VkVJRUJPbi83c2hjWGNTcEp6c05XbU5sTjB4WmUxcHUvclhoaFVTQlJtWnA5?=
 =?utf-8?B?VTR6bDJ3ck1oNGJqNDdGQzQ2ckp5MTNZaWovQUhzYSs4N29nSUUzYThPZ2JN?=
 =?utf-8?B?QUpSTG56Qk1MMHJCTHBhSnMxU05VTXR2UDdmZDEwNkJaTnNwY0FVaFlOc0V5?=
 =?utf-8?B?WjhxYmRHenFJb0wvRXI5WFRLWnJDU0VLU3QxaTBBdlFRZ1g2Rkx2MENZUFA2?=
 =?utf-8?B?NUQybEc5RVlOLzI2dnN1RDZBNkJnWmhxV05IS0szNWR4RWJ0cXdYVGRLS1gr?=
 =?utf-8?B?RmlFRGVicXhCbGVyTU9xd1k5U092RHFSZFlPOFhVRFlFcCt5UkJndmozUlJy?=
 =?utf-8?B?QmwxNVFndlV1cHoyaDJYZzFBNEV3MUIvNXAzMFRBdVltNkl2V2ZFMktMMWkr?=
 =?utf-8?B?cVZEM09wMFA5VUdXb3ZiNGpsRkVxcnR2eTVTMXdWZTI1ajNJU2tDVkhTZU5j?=
 =?utf-8?B?QWtiODI3R3lxbzhSMWRsMFhGeUpJemtYVTl6U1BxdmU2QUFvUFJVQk5zMno0?=
 =?utf-8?B?WnJ3bXZ2VHdLSFRYU0FHblpyRXRnVU0wSUpRY2pHcnlGQjQxNVdKSURScmlM?=
 =?utf-8?B?ak9LTDNWSWJqMGllYjl3a0x0d2ZmMThvdEY5Z2h6cTZZNHJyZVcvYTNVcGFh?=
 =?utf-8?B?L0tDNUZ5VVJLQU40UTYyVkNja1lqVzVwM2hPY2wzRUFFNjJkRU5LN3JyNDlm?=
 =?utf-8?B?OVAyb3o0V1RqTTJGWUpCNUJWVjVPQW9ib1VySXlGWThJRFlrV0dmOHExL0lk?=
 =?utf-8?B?aXhCZGZncHdSblovWTBqSWhNclhxTTIzUk1YaDU4MDVSanYrN2hoRi9VNTd4?=
 =?utf-8?B?VExVNFZsN2l6aUx3dXlHdUNqZEU0VU44UlJOeG1YaWViaHhJdFg1L0FqTzlp?=
 =?utf-8?B?MEt2elBCL0d1OG93YWNOYzJYRUd0blUveXFZeXZaaU1pR0NGeS9pTUhoQlM4?=
 =?utf-8?B?ZWVhUDFPRFFpYytGK0s0V21FcVRCQWFHZ1lGYTNDVmt4ai9hL3djeUpQU1V0?=
 =?utf-8?B?b3lmQVQrR0hEOTJTSzcrZmhyVkFXVlRvcDJpQWtDSE9rSUN1UE5Zd09pSGNs?=
 =?utf-8?B?K3VjUWpJNGVOZkZrMUxxVkNnY1N1Y3NLQTR4QTE3Z0Ric1dUWGNPTFBnSGpX?=
 =?utf-8?B?bDFwclBnSEFIRDBTaGhodktKMUp2eTd3WkZnZXYwdk1LRWljdCtmU3F2UGZr?=
 =?utf-8?B?UlZNM3EyQUh0blBKenFxUlhXejExWHNyeDBjK2lBWjJtRm94TU93T0wvbm0x?=
 =?utf-8?B?RDZHb2JwZVpWalUvWnZwMjhhWHBEc0liaisvQU1kRCsvZTdMMlNzd2tsMnl5?=
 =?utf-8?B?dHc4ODJFeng3VnBmcUl4Y21MWGVXRnB6TER0bGJzZXVZWUl1UVBMMDNRQk4z?=
 =?utf-8?B?OW5GVTN0eHJsS2RIdVVLYU9VdjBMcitMS2pGZXlNU1ltalRzdjhWNHlNRENT?=
 =?utf-8?B?MXdhZkQwaEV5Ny90dHFReXd3QzE3NUtCQTdkWElzOGVmOTVWUVdDOVc3d2pX?=
 =?utf-8?B?OUtHM2FTYmR3d1kxcm9LZENVa21ZNGd2T0xaSHJ0eVZQOWxDSHRLUUVPemtW?=
 =?utf-8?B?Lzc1TzArWk90czJCb3I4QXZDOGk5QThlbEc1U0RmNnhZZ09DRHNCU3BDQjBj?=
 =?utf-8?B?cm1zQzlRdnpTV2RRVXJLU2ZPcVJ1eXQvY0RRV0dVbm13R09QNmFEc3BXT1gx?=
 =?utf-8?B?ZmY0aklWaWUxemdxRE4yeVg3WGlYc1lUelBIQ0xTU3ZoeFdUTkxMUjFqbGtx?=
 =?utf-8?B?aWZ6eW5YMFkrZ1ZqQ3dBUlVxaUNiVFkxa3ZKU3A4Z2ovYjVMWUsyWWJHMVpZ?=
 =?utf-8?B?TCtBYXhWSzVBaXQ5Y29IdkxGUEhIN1lwci9SYUJrL0ZDaUZuclpsQ0U1MFhk?=
 =?utf-8?B?UTlxbFlDZG94SDRMdWk5WkNLZldVb0xqOVI1L2t0SVJNRTB2eHVBMHRaVzZk?=
 =?utf-8?B?NkpWeU9aQXpob0hrb3BVeVUzdGFkcEthU2lWNDBLVUJqQVdMdTlhTkhzWisw?=
 =?utf-8?B?VURqWjExY3YrQWdsUlpyeW41b3YvVlN0bGhCY29RKzk0L2ZOeVd0RlQ2WFR1?=
 =?utf-8?B?VkZjUTI1RFlqR3NEWEFTN3JwVmJIMm9LdTVQeThUb1FCdU5SalBNc3R5TDE2?=
 =?utf-8?B?bWlQbjY3UmI3cVhxQkRhOU1YbndqbnhPNTVGOTVEdXJpUHp3QmE1cWpqa1c1?=
 =?utf-8?Q?6Ddjv4fn+XEWcWcnEei+02/AYLPqax7h//dkgHh7vSAZI?=
X-MS-Exchange-AntiSpam-MessageData-1: uI8rlKdlqyQQ/w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35230042-eebf-4fae-c687-08def84ef355
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 08:51:50.7931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAF6Ed+MfzkKTZ1vKUG0sTvvcHsN2f6WKM8dfDjTlMz/1rV/fwMSKg803M3w/8M/UZQIfKXG375gSbdiZdox3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519
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

It is currently possible to construct a non-`BitmapVec` backed
`Bitmap` using `Bitmap::from_raw` that is larger than `i32::MAX`, and
it is not part of the unsafe requirements. Restricting all bitmaps
(even non-`BitmapVec` backed ones) to a maximum size of `i32::MAX`
simplifies a few things and matches `BitmapVec::MAX_LEN`.

Add that requirement to the unsafe requirements on `Bitmap::from_raw`
and `Bitmap::from_raw_mut`, and to the invariants on `Bitmap`.

This also fixes u32 casts truncating in `copy_and_extend`, which could
otherwise lead to OOB writes.

Fixes: 11eca92a2cae ("rust: add bitmap API.")
Link: https://lore.kernel.org/DKG0U8RLO7LZ.2I1AIH0S38PAP@nvidia.com
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/bitmap.rs | 68 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 21 deletions(-)

diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index a43bfe0ec3dc..fdcfc0409773 100644
--- a/rust/kernel/bitmap.rs
+++ b/rust/kernel/bitmap.rs
@@ -17,24 +17,57 @@
 /// # Invariants
 ///
 /// Must reference a `[c_ulong]` long enough to fit `data.len()` bits.
+/// Must not be longer than `i32::MAX` bits.
 #[cfg_attr(CONFIG_64BIT, repr(align(8)))]
 #[cfg_attr(not(CONFIG_64BIT), repr(align(4)))]
 pub struct Bitmap {
     data: [()],
 }
 
+macro_rules! bitmap_assert {
+    ($cond:expr, $($arg:tt)+) => {
+        #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
+        assert!($cond, $($arg)*);
+    }
+}
+
+macro_rules! bitmap_assert_return {
+    ($cond:expr, $($arg:tt)+) => {
+        #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
+        assert!($cond, $($arg)*);
+
+        #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
+        if !($cond) {
+            pr_err!($($arg)*);
+            return
+        }
+    }
+}
+
 impl Bitmap {
     /// Borrows a C bitmap.
     ///
+    /// # Panics
+    ///
+    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `nbits` exceeds `i32::MAX`.
+    ///
     /// # Safety
     ///
     /// * `ptr` holds a non-null address of an initialized array of `unsigned long`
     ///   that is large enough to hold `nbits` bits.
+    /// * `nbits` must not exceed `i32::MAX`.
     /// * the array must not be freed for the lifetime of this [`Bitmap`]
     /// * concurrent access only happens through atomic operations
     pub unsafe fn from_raw<'a>(ptr: *const usize, nbits: usize) -> &'a Bitmap {
+        bitmap_assert!(
+            nbits <= i32::MAX as usize,
+            "`nbits` must be <= {}, was {}",
+            i32::MAX,
+            nbits
+        );
         let data: *const [()] = core::ptr::slice_from_raw_parts(ptr.cast(), nbits);
         // INVARIANT: `data` references an initialized array that can hold `nbits` bits.
+        // INVARIANT: the caller guarantees that `nbits` does not exceed `i32::MAX`.
         // SAFETY:
         // The caller guarantees that `data` (derived from `ptr` and `nbits`)
         // points to a valid, initialized, and appropriately sized memory region
@@ -51,15 +84,27 @@ pub unsafe fn from_raw<'a>(ptr: *const usize, nbits: usize) -> &'a Bitmap {
 
     /// Borrows a C bitmap exclusively.
     ///
+    /// # Panics
+    ///
+    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `nbits` exceeds `i32::MAX`.
+    ///
     /// # Safety
     ///
     /// * `ptr` holds a non-null address of an initialized array of `unsigned long`
     ///   that is large enough to hold `nbits` bits.
+    /// * `nbits` must not exceed `i32::MAX`.
     /// * the array must not be freed for the lifetime of this [`Bitmap`]
     /// * no concurrent access may happen.
     pub unsafe fn from_raw_mut<'a>(ptr: *mut usize, nbits: usize) -> &'a mut Bitmap {
+        bitmap_assert!(
+            nbits <= i32::MAX as usize,
+            "`nbits` must be <= {}, was {}",
+            i32::MAX,
+            nbits
+        );
         let data: *mut [()] = core::ptr::slice_from_raw_parts_mut(ptr.cast(), nbits);
         // INVARIANT: `data` references an initialized array that can hold `nbits` bits.
+        // INVARIANT: the caller guarantees that `nbits` does not exceed `i32::MAX`.
         // SAFETY:
         // The caller guarantees that `data` (derived from `ptr` and `nbits`)
         // points to a valid, initialized, and appropriately sized memory region
@@ -96,26 +141,6 @@ union BitmapRepr {
     ptr: NonNull<usize>,
 }
 
-macro_rules! bitmap_assert {
-    ($cond:expr, $($arg:tt)+) => {
-        #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
-        assert!($cond, $($arg)*);
-    }
-}
-
-macro_rules! bitmap_assert_return {
-    ($cond:expr, $($arg:tt)+) => {
-        #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
-        assert!($cond, $($arg)*);
-
-        #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
-        if !($cond) {
-            pr_err!($($arg)*);
-            return
-        }
-    }
-}
-
 /// Represents an owned bitmap.
 ///
 /// Wraps underlying C bitmap API. See [`Bitmap`] for available
@@ -415,7 +440,8 @@ pub fn clear_bit_atomic(&self, index: usize) {
     #[inline]
     pub fn copy_and_extend(&mut self, src: &Bitmap) {
         let len = core::cmp::min(src.len(), self.len());
-        // SAFETY: access to `self` and `src` is within bounds.
+        // SAFETY: access to `self` and `src` is within bounds. Both lengths fit in `u32`
+        // because a `Bitmap` is at most `i32::MAX` bits, so the casts are lossless.
         unsafe {
             bindings::bitmap_copy_and_extend(
                 self.as_mut_ptr(),

-- 
2.55.0

