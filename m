Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CAAC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96CF010EED2;
	Thu, 27 Aug 2026 07:30:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="N4PWA/la";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B86410EECF
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 07:30:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwC2YmevLmxvCSoweoQ2uf1bgxK9HJB8Qtc0ZMXQHwy3ttKb8z4LWlY2ZsWD9OsfrTzJCj/lMIE6D3Zmt0TN3aUVhqSYe/Rm8fMjrvprIM93O++CFL/ukdAeiMoLwoc0wbSWYgIYX+fe/sC4peyWNeSPkNuex/LeGryI9S8z8juOhjdhN+K1nS/vLKelH+n97+Ne+C0Z4q7/WIwpkiOeYf0SvquzPpuLszT4spcb7jUjeYlp+4pT7tAfbVSZqX+/tl3AfvqHmfRYJXbUjniOwWB3cB34WcgrFSPcm8JGcuXE1nYmk7Vb/2Tt52VqrnW2xQs7Pv0chGlaf7XOtHzkGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+O3A4qzXACX8TaeBvjTt5HvhSNbOWZfwzvYwFL/fI4=;
 b=LG8fszfqW+mFqxDRr70tpS/ECedklpwvrbLbv7iE+Yv5FbbQz5n6cWR4WCVcw/mCs6GprXDhI7KOxr43bCFApSDKDhu4ewYXV8i9j1gXEaO9Eestqh85qtrIXLCcmDKLeHYNd2coqUHKvfsW7aTueZJdPxmfkyRR8pW9HTC82T2YZPdIaVq5jDlNuVDR9McBBdBG7fA0gkYaV1ruhGebfH6gnzD23dQ1cAM3CcSG529N/qTgd4H8xZwqlBtcLTy/eVAETFAown+BvCBxBsuXZUQwjQqnJ/12OJdW8CWaOvrVk4wtt8js6oZrgXGgwOmogJDbnT80AmElDFeMYMJPXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+O3A4qzXACX8TaeBvjTt5HvhSNbOWZfwzvYwFL/fI4=;
 b=N4PWA/lavb0PeGXjg4FS93QhvBWQeve0ea8dqmEof62lCMYjBVAW8IdQoozDTqWrDkfd/mhG26TjL+89Zl5dCBgRzhP8AOCX3j5CSjJo8bog69xDRyuyg29a9PTbhTmRHBVaSLeVweYstcjOQZi3A/arpLkfdn1OWhSsUU1tkiL8+zbkJ/rSbNAbEWWsxIzfNnGRgsBHLuE6tMnznupryEUeaGAZKFbP6XXlZ3s5pz8+xGpocvZIoDO/7jyFO32L4Pf5RKnL5yTURpGupim4qmzkhKsnLK716anaslJ16wtvv4D/hVYwLR66iiUfy9cd8WWwjtW5GAKRqwA2Mssd8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS0PR12MB999081.namprd12.prod.outlook.com (2603:10b6:8:2ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 07:30:45 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 07:30:45 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 16:28:35 +0900
Subject: [PATCH v8 07/12] rust: sizes: implement SizeConstants for
 Alignment
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-chid-v8-7-bc74c77d0214@nvidia.com>
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
In-Reply-To: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
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
X-ClientProxiedBy: TY6PR01CA0029.jpnprd01.prod.outlook.com
 (2603:1096:405:3bd::6) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS0PR12MB999081:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cc295dc-881f-4e91-cd11-08df040d1b44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|366016|1800799024|376014|56012099006|10067099003|18002099003|22082099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: E/iDJbPHXbq9WOwwk+tK5tspwa+h8PPDw6M1KZLIAdOXBz4oqOZq5qejTIChKorr1IyYe6aH2EJ+ioZuZTbiVodBbtd4WvlJVMMYeBZKTk2C85dxWzpJHsWwW91IdMAp5ok9TvTQO/je+o/a8/Z39pwybA7JYEjoQPKbtTs/GOqvjBXiPUnRQuJLzqucqwbIGnG5PAzxup8GDtVqBOMQmcTSV0dHxHwYnKzXpI4Yr5YRroWiW593H2D+Hx12Q8wweA55gtMS8LZgKYoV/4GgKxAAnXr2kNz3wXkJqdRcWHFeGUlflLoXZcxVjcsPzPr1nhqhMbP+eEu/+JBnvUR5D5ivugaytVoqnqxNy1/Ezquqg1d78VflvLwKTmWevm4ObE93baLcZq7wpCOsWSJsx9MNfetBU9ZAI0woUadlPHO0nC+W9Rh8/AZ2VZxztbeINoqFMOSbCQSRGUoMt34+1kTNuekEbUXrr8TdHb7UI2zwf9/c15KlXbCH2l+e22TpaPHD+eR19jZWm64L9A6eR8zKBWelYCJNFyd3C8sBfWG+mYbWvTVX+GQ6DII04F+oxSjruBsCVm5Mgn/FDT/v45CV8LhZNy6+HnWtAuIITBdQ64KNVhe88/SX5kIXTueXY/ITCmFNxpqcrVbLsRt473rdZliZBNpH0cc8PrEy8t7AnlfM5RNbEkb8T//tnMjR66WM0m0B51jRDTBYDcZWiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(366016)(1800799024)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2tsUlhGYi9xdUdzRGR2WVNoS3hrVUNJc2Z5Y2VmQjAxY3YyUTFYY3g0U1hq?=
 =?utf-8?B?SFBkU2xMMXkxdWlvUzZlRE1vbHdxM1cwVy9CU1ZWNWtlNGx1ZHN5OWJKRGJl?=
 =?utf-8?B?aVcwUDRFRFB1NDFhN2Q5NFEyTVNNMzN2Mlo4Zk1nYWJsN1ZxRHZiVjZ2RUxs?=
 =?utf-8?B?dmR0amtwK2swSm5UY25KMjlJR0FERklhUzAyVXpFd3pCZmR2WGZZK1lZL0pt?=
 =?utf-8?B?TUdha3BpcDhYKzlGcG5SS1RjRlE1em1kK1hYVElCaTNCcmZRMHFFT0FZNjcv?=
 =?utf-8?B?TkRHTWpwaGJrY2g4b0FUbzFMWEV2UjNWRW5jVW5URytIZUFSWi9acFJ2S09S?=
 =?utf-8?B?dVFiQVRIZ2h1SzB0Rm9mV0QxeHJrZlpuS1hmMXRROW96SWlmTnNGOERReHlt?=
 =?utf-8?B?K3BpYyt0WWFXaG1vc3ZvanVHWUR5WndQUXI0VzhlRlFkQ1JLVkJhM0o0MXcy?=
 =?utf-8?B?UStYdGk3RFpQcWdxR1h3S0swb0UwN3c0WGJpT084MU8yUnd3Wk1yMkRtRnBK?=
 =?utf-8?B?ZnYzVWhCODltVStoT0dBZ3AzbURwZURleWlmOHE0QlpFZk5WeUJ5a3U2SUtz?=
 =?utf-8?B?TnhJeFhsWUNSQmxuY05HMW9mS0hrb0tWRk9yOUVuMDdQTGQrbStsZVlwa2hK?=
 =?utf-8?B?aDBveG9Lc3J2cXhMUXVndVBPUDNOdlF3L0xLdlJ4d3I0d0NFeXNqNmNxNXh1?=
 =?utf-8?B?OGNRN3AxQmlpSTJxS1QvSnJObC9HeEx1Qzc2MDRncE9NUFhGdzVhUzhLVEFs?=
 =?utf-8?B?ZG1CUmd2NWk4V2prWlVUaE1FNi9QazZxK0E3dFkzUFNLWkI3UW9aWVU0d01U?=
 =?utf-8?B?bEN4R21iU0dKRWJmT25zc1BGYlc1MkVYU3Z4c2RjbmF6eCsvOUI1NndTSWk0?=
 =?utf-8?B?ZjJJKzhlMFFzUTVWMzVzN2hvOWthMWNpbC9YSHo4OS9mQ3BzZkplTHJkb1ZQ?=
 =?utf-8?B?MFdMZHoxQ2NDRDhJNVRnWGxGZ3BPSHpxRytuSDlRNTB1ZGRqbmcxTUdjQTRI?=
 =?utf-8?B?SjhFUng4Wll5Z0xodDREbE0wSTVDd0xDblU2UjN6Tk5ZSjlndnFFWnlFekxt?=
 =?utf-8?B?WXg4UGRmQkw1dkFFOUlNTjB4UFNDM2tOM1lqeXU5NEJ3SWtNVUVHSjEyOEpZ?=
 =?utf-8?B?YTVNcG9lQTdqUmVKVkNVOUFjOXRoWEgwK0pjMTBvZUFoZkI1M29kYW82VVBH?=
 =?utf-8?B?YUcxb3dBZnFjR01OL2F2R3ZjZmtqNXdyWithZmFXcDNabE5qUk5ueDEvZ0pp?=
 =?utf-8?B?TE9neldRUHhQd0JlZnFkMitQeGtJTk5lRDczTXI2eG0wOVo4dEdqaVNnOHhP?=
 =?utf-8?B?d0tibGxQNXhCRjkrYzNLZ1pKT3oyZWk5R3E2V3R1Yy9maTQ1ZTE3Zyt5VXZp?=
 =?utf-8?B?ZWdhZEdqamhBQURpUE1FTXp5eWZPWll0VlVGQXRlanBHYjdJcW1EWjFFZzF4?=
 =?utf-8?B?N2pJMDEzWjY0aDlPSHZxV2ljUUZqZHhoMHY0L1labW1ZNURTRzg4K0pJd01N?=
 =?utf-8?B?dmY0VCtIdXNiVE9WS2VUa1E5eHNwWkJrRlRmZlF5aXppZS8vR3VwdVB3L1J5?=
 =?utf-8?B?cmlpNXRlMXBlUWxUN28yQ1hKL2p3UVJrSjRHRTZXL2R6U0F5UThudGdoOTQy?=
 =?utf-8?B?Q2YxV0tYWHFZTWxHRzg4b2dIcXlhSzR4dGU0ZldkQ1o1VzVuMk5ZQ2NkU3V4?=
 =?utf-8?B?UGxkc0ZtckNTM05VL0VVZjhXM045TW5nMGtZYW4zTjA0bzhVN0VBYzgzcHZK?=
 =?utf-8?B?UGQvU1ljaXZpVFJnVC82UVJRYXROenk2UExid2UwbUM1WjNOVHZoZ0VnLzdl?=
 =?utf-8?B?WVFra2gyMldScU5FS3lSUnZTbGFJUVh5SUpkc3NsZUVEY1NpVzBpKy9TNExJ?=
 =?utf-8?B?ejJkbHZLdSs3cFVWRjZ5ZTl6OHR1UTYrM0FxajJsb0h3OGU5SER6UXdRcU12?=
 =?utf-8?B?L0FmZVRVRTFvazFWVkt5bEZBYVA2aE1LajQ4RzYrMXdDK2JXakthS0oyTTdy?=
 =?utf-8?B?dXlPSEtZNml6NHAzTmgzZUJ5YVZTajU1UE1HYWxUWVZGWEFCRGx0TzkyeUN1?=
 =?utf-8?B?UGppdGhPbDgxUGg3VExiL3ZiZzhpUEEvOEdabGkyTUoyWEY1bEI0SENZaWcz?=
 =?utf-8?B?c01DUXNlZEJMbTdGSERTVTA0cnN0UjZyQlV1SWVMZ3UyUzBMT1VJajF4eXB4?=
 =?utf-8?B?VzFIRnhiRmlydjBwOStxUmJDWi9pM2NWZlFrUXcrdzNmaWt0d0Jjak11SGI2?=
 =?utf-8?B?enhURzExWm1xYVBWMVJSN2p6cDQ5Rkk0UXl3Tm95eGNaWTYrcEJ1cHVkYzZ0?=
 =?utf-8?B?ZUZNbTR5NDUyeHRNMHpFcGlObE9TM0d3ckVHZGtuS3V0TjF6OFlLVXU2M0lG?=
 =?utf-8?Q?2Z/WyXECW6X71m/LOfx8CPv4Jdv+AljJqh4bVfApM7q+G?=
X-MS-Exchange-AntiSpam-MessageData-1: fQao2tAgW0F57A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc295dc-881f-4e91-cd11-08df040d1b44
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:30:44.9515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBYQ1xI8j966cAjz8RHFNQ1DAtbAUu1CeNn+xvj7QJS7ZF/yzAiLbFWs3ekLAz8ez9N8Cj+EOBaifba78ZMkPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999081
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

Currently, constructing an alignment is quite verbose:

`Alignment::new::<8>()`

It's unfortunate because it disincentivizes using it at interface
boundaries. Implement `SizeConstants` for `Alignment` so we can write
e.g. `Alignment::SZ_8` instead.

Link: https://lore.kernel.org/an4xDp29VX8Am0uR@yury
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/sizes.rs | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sizes.rs b/rust/kernel/sizes.rs
index 7d03361eae3d..188e00c2b8b4 100644
--- a/rust/kernel/sizes.rs
+++ b/rust/kernel/sizes.rs
@@ -13,6 +13,11 @@
 //! these constants as [`u64`] (or [`u32`]) rather than [`usize`], because
 //! device address spaces are sized independently of the CPU pointer width.
 //!
+//! The trait is also implemented for [`Alignment`], providing each size as a
+//! compile-time validated alignment.
+//!
+//! [`Alignment`]: crate::ptr::Alignment
+//!
 //! # Examples
 //!
 //! ```
@@ -105,6 +110,7 @@ macro_rules! define_sizes {
     (@internal [$($type:ty),*] $($names_and_metas:tt)*) => {
         define_sizes!(@consts_and_trait $($names_and_metas)*);
         define_sizes!(@impls [$($type),*] $($names_and_metas)*);
+        define_sizes!(@impl_alignment $($names_and_metas)*);
     };
 
     (@consts_and_trait $($(#[$meta:meta])* $name:ident,)*) => {
@@ -119,13 +125,22 @@ macro_rules! define_sizes {
         /// choose the width that matches their hardware. All `SZ_*` values fit
         /// in a [`u32`], so all implementations are lossless.
         ///
+        /// Also implemented for [`Alignment`], providing each size as a
+        /// compile-time validated alignment.
+        ///
+        /// [`Alignment`]: crate::ptr::Alignment
+        ///
         /// # Examples
         ///
         /// ```
-        /// use kernel::sizes::SizeConstants;
+        /// use kernel::{
+        ///     ptr::Alignment,
+        ///     sizes::SizeConstants, //
+        /// };
         ///
         /// let gpu_heap = 14 * u64::SZ_1M;
         /// let mmio_window = u32::SZ_16M;
+        /// let page_align = Alignment::SZ_4K;
         /// ```
         pub trait SizeConstants {
             $(
@@ -137,6 +152,16 @@ pub trait SizeConstants {
 
     (@impls [] $($(#[$meta:meta])* $name:ident,)*) => {};
 
+    (@impl_alignment $($(#[$meta:meta])* $name:ident,)*) => {
+        impl SizeConstants for crate::ptr::Alignment {
+            $(
+                $(#[$meta])*
+                // A non-power-of-two constant will fail the build here if used.
+                const $name: Self = crate::ptr::Alignment::new::<{ self::$name }>();
+            )*
+        }
+    };
+
     (@impls [$first:ty $(, $rest:ty)*] $($(#[$meta:meta])* $name:ident,)*) => {
         impl SizeConstants for $first {
             $(

-- 
2.55.0

