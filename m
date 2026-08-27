Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B513EC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B3210EEC9;
	Thu, 27 Aug 2026 07:30:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="PU2IZSag";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010006.outbound.protection.outlook.com
 [40.93.198.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40CA610EEC7
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 07:30:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rz4B0nSj/5YMJw7L9tclN4ESpz1gQ4I4dGYIL2xFCcJORbh20ljpXCz0Zw6qeZXxh9fPRiBlJPZvhTN041YLLEMERhLYbiMgjKovnrnY013YAa0rPejT8Zhy7BTJ8XpWQhSv3OOEk2hM32ldtECxZZXh6EwdAmbb3364+jBZL+b3J5TbzGk5vmpT9tN+HEhwLDlELJ2S9QuKm1ufC61BY9hCkU/mLFoYzXOrqhzSon/z5l8niVRSnGnnf0CwLdUEJrPooArz+9bNanQK64NxvMeW13PWHtkZG4we8AGy/bQ8wfynGE1F/tG+SLBvXJi/ZDdsb7pwBl+AhRLlG1fD3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lW35W/d5BSz4A2CpgYnpAjJl8wpJErEWmlUtoDeUQM=;
 b=WTVRtgKuZ72y7eMKO2npowZzRDLwuRmFak1ETs1wNiKwBOQG6rJ/+mB7mV2Jtag2e3oa86IjRVgRU9ObByU2/h0IDwWPy7GhSXAo4P06iHHJTRpstkIfk8PDTmfbo7itD82NjzZS3CiHMfIVR9/iHJMHxHr42Ops5fI+SKldrbTH0TFT6I7YNj66WgGAZexzrCcNSHnjJq5Vz8OVcO/yBhWdFOfk+KFuJ8RWO9VhE+TL6CQpLEW48bR1wItdvmDRCIwwGmNilpazI3iCtXo9EOUP37+aMJuio+QdODBjEDT3vl1kux3l15+Z2Lug+7H7rG0RyEddr1e7ygWiYBLmMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lW35W/d5BSz4A2CpgYnpAjJl8wpJErEWmlUtoDeUQM=;
 b=PU2IZSagvJ0r25JH3hMyCVt37p8jQUnOX+T41SIFmGNvjirLlzAuNKKCfu3+Andj0ndZkRxmt7k6N5agiWWr1hRztqSF90nRhfK99YQO/cZ8gfEAmBVNPmBCy5asDpWoY9V2qgmzoYCaHw/mzvkIF8WDyNEakRALPDgeRRKmEZa9N+RuIJLlCh2zcDT7BUwtmLEWvOEBL4h7PiEygmiKjtmxIHrw6o9TkkkI8ktynKTNnz5d894NlKira6sXKGw1iuezNygN8hHmXne3RpZlog7aq5rmW/hViPmZzxoaf55IbBirkTEkVUg3GMRAmRV8iCb/iGAbsRl56HYSN2hAMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS0PR12MB999081.namprd12.prod.outlook.com (2603:10b6:8:2ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 07:30:28 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 07:30:28 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 16:28:31 +0900
Subject: [PATCH v8 03/12] rust: num: add cv! macro to create values from
 constant expressions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-chid-v8-3-bc74c77d0214@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0073.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::7) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS0PR12MB999081:EE_
X-MS-Office365-Filtering-Correlation-Id: bd1f7172-b0ef-450b-183b-08df040d1142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|366016|1800799024|376014|56012099006|6133799003|10067099003|18002099003|22082099003|11063799006|5023799004|921020;
X-Microsoft-Antispam-Message-Info: v/HaHWIFL7MgRY39cuIFgvPQd55hQtq970XK0yRpQzIbyWE9A/lVRquMwsoC40vNLbsGWmV45Mj7PL9BWYRiZlbZ2bwwKvMJdK3kxDqB+mRVtu0fh5RLm0zMnGDop43AmVCAc+R9hapL7R72MBGiSXWWQaz0NWZd6dh3vZfTabCx4uEMjZDeInvOfv7eG+eB3DZLu1D435Ngnd99embiNMUPM8v8BLFCezeLoiUMqT4ohhmW3XFlyX5XOPw6UhcMx4AEWz0L1sy4eC9pMc+1Tf0HIq1ZqZ4dWPtVBlJ7sjLeZumd8ohgM81lPdcdvIx1GizOuIJrs3yXZEUgB+cXMZVO3S9yYYk58EO/OpwcyY05BZ4Yna2X2OkTwqo3bud8R7NGCXsHblFz9HFnaYR2xwocIymKpbsn9+30HrYAIcAT2//Q4SJ3g9BbysB1nNEjpkqcyc9dBV2YHoztDl39F/ezsOiZAiFInFmkpSb1DNWTi8wI4JgsOd0OAsqXuBtP7jLfYeBQLcSUPeLVO4VN5UT3xHnrfmYluQCrXoi+Wz38EyYhs8lDkc8XFfdQh9xdO5RdmEN3E4qDdQUDPhblsNBYygH3XsG+1HTsbKaOl3HUTjQzUHPbT1ZmZmv0SWmVtALeVvRVUDC/GupWXQU524in7hIY98q1WRFhFaYpEkjJ6MXxtF+tYrwIFJSNx4VZU7qzlBZTNUdb+2J+RcFSdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(366016)(1800799024)(376014)(56012099006)(6133799003)(10067099003)(18002099003)(22082099003)(11063799006)(5023799004)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWZzV2wwNWNiSWs0Yy8xK0xwSVVoaEY5S0ZZbTlvRmhlQk00WEtiaHBkMmpX?=
 =?utf-8?B?V1p4M2d5bTZZUmh6N3hscDFhRjhrelpOU1JGYzJlOEJ3bmF3N1V1dVhHT1ZD?=
 =?utf-8?B?N1RyQVdqM0dMa1FpU1NhWHFLS3FINjlaOHlHbjVKKzVEdzhVaFRRYjZVSFRC?=
 =?utf-8?B?TDNsYWdpQy9KSUhjY3NMSlR4bzFrejY0L29hRUI0M3dSWU9FY1ZQcXl1TzhF?=
 =?utf-8?B?Uy9JOHhVUlQ5NDJ3U2E3VGphMzVIbk5qNVBmS1N2c0tuc1ZnTEpJTWpSb0Vs?=
 =?utf-8?B?UDRvZmY0NmxYRWRVcWRyRDQrTFNNUEpvNjVYWmh0MElmN0IwdW5aOXAzR3RW?=
 =?utf-8?B?SG5tRkhOWWNUT1hSaEIvUmcrM0tHSXNwMFNkOTJtWkcrOFVCcTg3OHVLbzY4?=
 =?utf-8?B?elg2ekVMcnVBREIrODFscUc3K0w2RUs1RnlRZ1VySE8zckc2MkVhT1dSMUVB?=
 =?utf-8?B?Q0t0NGpsTWFHMTZ4OUtablg1RmF2UUxBeUZXNmJqTWFpSXhOL1M3MzRuWXp1?=
 =?utf-8?B?bHdMcFIxMjZmOGtRMVNTeEhwNzdsUk1sS1dUTDBlT0duOUNDZ0hwMytMeXdD?=
 =?utf-8?B?cDNaNGxlaGYrMi9naGhZSnJmUm1McTd3Sk5MZW9FcmE3S0Yvc2VjOG5vT01D?=
 =?utf-8?B?Z3lBTlhpd1hTN25YNEc4b1FuNVVabDNpdU9WUlRSTU5vQkJUNEJMOHpjdnoy?=
 =?utf-8?B?aVhDN0dJS3NWWXNpQnNqeE55V0dlQzFoYjFKZTQ1ejdPS3JSNUtQaHFtSTFk?=
 =?utf-8?B?R2svbHcwamdlRWtsZVI2L0xhQy9vQ1pkcTNXWml6ZUlRenN6dkQrSzg3SDlR?=
 =?utf-8?B?elNydkhHcFRlak1NK00rbzg0UU1UanJCZzF6UXJRYVNhNTdzNmFmcDlkNkJ1?=
 =?utf-8?B?MFU2QVVzdjdZQm95clVTUllSYjRGeExzbWpUemlXdUI5ZWxPQU8wcDliOW9W?=
 =?utf-8?B?WG1uMEovOFV3Sno2MHpQTzhPQlRkM21nY0hQM1h4bHpiMStkTW8rOGt6cU12?=
 =?utf-8?B?UkFrc0tFYnQxQnBHdkZUZUN5Vi8weXJKVUtNSWpBT0VzVFVjdmJCOUlzbjE1?=
 =?utf-8?B?dHRncVFQZ3JRaTM1VER3Y3E2Sit4NXFubEdjd21VS3JkT0Nlcjhldm5PL3Jk?=
 =?utf-8?B?V0NzaXFubnRsREhNWmVOdzFieHJsaytiOVdDWTBxWldJZ2hQcmxncXRhaFBv?=
 =?utf-8?B?amFrTzdKSTdOUW5XbzBvSkpORkFqMlpYSzVJUFlxeFRGcVN1dlNDZThCd0Zp?=
 =?utf-8?B?b3gwRWwwNkFSQlVldlJUZ2VKUlN0VUZUbm5yMkZ5ekdFZXV3ZG1ieDRCRVQ4?=
 =?utf-8?B?YTM1RVBWWXRWVnlsZGRYckFjSjZ0anVCY2tsOURsNENIZ0lrdXY1Q2NuS0JX?=
 =?utf-8?B?WkdoVC94RjJYOWFqS2E4TVpwTnpNaXVqVzJrZWVpMEJXQWVFcVpuZmZKTmZO?=
 =?utf-8?B?RmU0aCtTcEZQUkJOU21tVWtNZjJ1SXA1SWoxZk1XbHF4TW9wWWZtWHZhRFJ4?=
 =?utf-8?B?Z3YzTXBYY1F3eWg5VEptU0RkcENUb000YzFRdFB4K1hubVEyUDFCS2VTMVdY?=
 =?utf-8?B?S29YMVlHd2Zzd3ROK1JaYTdieTNJeEd5d3Q3QmVvNXJGM0djTS9oL2tTUlNK?=
 =?utf-8?B?YUhtNmM1a2gyaGxkcjQrQ0IxZmQ2SDZTN3lqTFhHVkh6UmlkdWhPQUUzK1Q3?=
 =?utf-8?B?Y1YzN2RQQVlRd0RvNzhrem1oY2U4d25BWWh3VGVyeE11Ryt0RkF4SGtBWHk4?=
 =?utf-8?B?dmxQTE9peFNKSC8yWTRHWDRsVXdpVDFjUTNOSzY0aURYREJtbWtOTXpmY2x5?=
 =?utf-8?B?TGZuTWFxdzhpMGxwd2NJL2poUmVFRDRZTmZETkprdGgwSVpKcHZBYTZRd3Zr?=
 =?utf-8?B?Z2JWSW04eFdLSFIwTFNNekkvYW9pS0UxK2dWcTBZT3VtV01JK1lLZ1lLUWt3?=
 =?utf-8?B?Uk00bjJHSEl6aTkwRDRPVG0yaVZMcS93K0hpZVlEemk4R3hySVp4NXk1cW96?=
 =?utf-8?B?VTg2RGtBZ2ttWWh4WEtMMnhMQzF5Q1ZYSTFBbEdmRWVwWVRTQ0VycldzRFR1?=
 =?utf-8?B?WEViOURtYUM0N1ZWYVdFTXdpa0hzRkRQbE43T1NNZEI4dDYzbXdrcTFabkV5?=
 =?utf-8?B?TW9VbWMyM0VxZDlzcU9kWFRmTTlodFFuUXpLRkYyQ3ZmQ2p5NHJHT1BkUTZG?=
 =?utf-8?B?OXBITVlZazBSaW9pU0tUb09WcCsxRjMzS3l2VjZRNFl5OHl1OTVrVW1nUnBz?=
 =?utf-8?B?QjdTdHdzckp2YVdDNnpvbWY1Y2FZWE5kYjNBeGJjcHVOT2U3THlOSUVkUU9R?=
 =?utf-8?B?S3RCMFFsLzRFVlczS2JpTEV1WHNGM0JkSjkrb2N2U2FXVUpHaFdJZFVvUUd4?=
 =?utf-8?Q?Llc9+6OSN1HsLsDcgrg8sazEbQ38/ds5P5+kTlWrSiPMe?=
X-MS-Exchange-AntiSpam-MessageData-1: 3cR4sGXfn9tlmg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1f7172-b0ef-450b-183b-08df040d1142
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:30:28.1589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ER5KXScIATF9KstRxy8DkHNIbamxbW/9qdvc+q4M8Anh1uCjOqiB4+53yO6XM3FZo7+l/eRGWTfMjoOUqa71/A==
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

Currently, using NonZero/Bounded constants is quite verbose. It's
unfortunate because it disincentivizes using it in interface boundaries.
Introduce a macro to make it nicer to use. The macro `cv!` (for constant
value) takes a const integer expression and widens it to i128 (at build
time only) before passing it as a const generic value to a new trait
function `FromConst::from_const`. The trait is implemented by NonZero,
Bounded, and Alignment and lets values of each be constructed from
constants without a verbose turbofish syntax. For example,
`const { NonZero::new(1).unwrap() }` can be written as `cv!(1)`.

Suggested-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/num.rs         | 89 ++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/num/bounded.rs | 21 ++++++++++-
 rust/kernel/ptr.rs         | 13 +++++++
 3 files changed, 122 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
index 8532b511384c..29bf903a4a74 100644
--- a/rust/kernel/num.rs
+++ b/rust/kernel/num.rs
@@ -2,11 +2,100 @@
 
 //! Additional numerical features for the kernel.
 
+use crate::const_assert;
 use core::ops;
 
 pub mod bounded;
 pub use bounded::*;
 
+/// Creates a value from an integer constant expression, with validity checked at build time.
+///
+/// This works for any type that implements [`FromConst`], with the target type inferred from
+/// the context.
+///
+/// # Examples
+///
+/// ```
+/// use core::num::NonZero;
+/// use kernel::num::Bounded;
+/// use kernel::num::cv;
+/// use kernel::ptr::Alignment;
+///
+/// let v: NonZero<usize> = cv!(8);
+/// assert_eq!(v.get(), 8);
+///
+/// // Any integer constant expression works, not only literals.
+/// let m: NonZero<usize> = cv!(usize::MAX);
+/// assert_eq!(m.get(), usize::MAX);
+///
+/// let b: Bounded<u32, 4> = cv!(15);
+/// assert_eq!(b.get(), 15);
+///
+/// let a: Alignment = cv!(4096);
+/// assert_eq!(a.as_usize(), 4096);
+/// ```
+#[macro_export]
+#[doc(hidden)]
+macro_rules! cv {
+    ($v:expr) => {
+        $crate::num::FromConst::from_const::<
+            {
+                #[allow(unused_comparisons, unused_assignments, clippy::as_underscore)]
+                {
+                    let v = $v;
+                    let r = v as i128;
+                    // Pin `back` to `v`'s type so `as _` casts back to the source type.
+                    let mut back = v;
+                    back = r as _;
+
+                    ::core::assert!(
+                        back == v && (v < 0) == (r < 0),
+                        "value cannot be losslessly widened to `i128`"
+                    );
+
+                    r
+                }
+            },
+        >()
+    };
+}
+#[doc(inline)]
+pub use cv;
+
+/// Types that can be created from an integer constant expression validated at build time.
+// TODO: make this a `const` trait once they are stable. This will let cv! be used in const
+// contexts.
+pub trait FromConst: Sized {
+    /// Creates the value that corresponds to the constant `V`.
+    ///
+    /// Fails the build if `V` is not a valid value for `Self`.
+    fn from_const<const V: i128>() -> Self;
+}
+
+/// Implements [`FromConst`] for [`NonZero`](core::num::NonZero).
+macro_rules! impl_from_const_nonzero {
+    ($($type:ty)*) => {
+        $(
+        impl FromConst for core::num::NonZero<$type> {
+            #[inline]
+            fn from_const<const V: i128>() -> Self {
+                const_assert!(
+                    V >= <$type>::MIN as i128 && V <= <$type>::MAX as i128,
+                    "Constant cannot be represented by the underlying type."
+                );
+
+                const { core::num::NonZero::new(V as $type).unwrap() }
+            }
+        }
+        )*
+    };
+}
+
+impl_from_const_nonzero!(
+    u8 u16 u32 u64 usize
+    i8 i16 i32 i64 isize
+);
+
 /// Designates unsigned primitive types.
 pub enum Unsigned {}
 
diff --git a/rust/kernel/num/bounded.rs b/rust/kernel/num/bounded.rs
index dafe77782d79..b04bba3fa0cc 100644
--- a/rust/kernel/num/bounded.rs
+++ b/rust/kernel/num/bounded.rs
@@ -13,7 +13,10 @@
 };
 
 use kernel::{
-    num::Integer,
+    num::{
+        FromConst,
+        Integer, //
+    },
     prelude::*, //
 };
 
@@ -262,6 +265,22 @@ pub const fn new<const VALUE: $type>() -> Self {
                 unsafe { Self::__new(VALUE) }
             }
         }
+
+        impl<const N: u32> FromConst for Bounded<$type, N> {
+            #[inline]
+            fn from_const<const V: i128>() -> Self {
+                const_assert!(
+                    V >= <$type>::MIN as i128 && V <= <$type>::MAX as i128,
+                    "Constant cannot be represented by the underlying type."
+                );
+                // Statically assert that `V` fits within the set number of bits.
+                const_assert!(fits_within!(V as $type, $type, N));
+
+                // SAFETY: the asserts above confirmed that `V` can be represented within `N`
+                // bits.
+                unsafe { Self::__new(V as $type) }
+            }
+        }
         )*
     };
 }
diff --git a/rust/kernel/ptr.rs b/rust/kernel/ptr.rs
index 82acb531b17b..3dcf415bcec3 100644
--- a/rust/kernel/ptr.rs
+++ b/rust/kernel/ptr.rs
@@ -166,6 +166,19 @@ pub const fn mask(self) -> usize {
     }
 }
 
+impl crate::num::FromConst for Alignment {
+    #[inline]
+    fn from_const<const V: i128>() -> Self {
+        const_assert!(
+            V > 0 && V <= usize::MAX as i128,
+            "Constant cannot be represented as an Alignment."
+        );
+
+        // The unwrap fails the build if `V` is not a power of two.
+        const { Alignment::new_checked(V as usize).unwrap() }
+    }
+}
+
 /// Trait for items that can be aligned against an [`Alignment`].
 pub trait Alignable: Sized {
     /// Aligns `self` down to `alignment`.

-- 
2.55.0

