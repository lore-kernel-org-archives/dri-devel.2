Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BF7C531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 09:01:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65FE810E565;
	Thu, 23 Jul 2026 09:01:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qj6vd0UN";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8275510E778
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 09:01:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RAmsbQdTHYp8XqRBLyRX7Pt25W4rCbHtbwTUP/ZIRvDCMJmjWBvSKucIgAPPfvdlcouHE5QDERS6rpFBhslofc7kiptL2hCFriGo8uidEeXH8QOvWza1MDsu4R6YVHriI0S2O2ivFB6l5sRmacrKdPLBIVsKL2R/K5Y+ydsO88Fp5rrGqLGNxsEmdUa05TTJHl/3h2OXlrqRWfA03vuLA0IG/7w3WggOJ1eradponbGkI4ekvIDF14O4O3gTYS58PdmJ1tjulIYYjp3LDSW3hyyVyu6cBhAndbT6DEG6vE0Dmw7ZosyIPre/Ut0Uz4dCH9P9h28kwgFMhqTutqTyaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OC58iInQGyjLPfbhggyWjI/MOwIUsNz/d/TYiFPJPYs=;
 b=G77gwbrYWwPiaYb1mwmlJYk/QGn+3F5R1aJ2O4fFuhdJrBn9R5QPYhaFqK6JwJ3SaAxkaDylCB26cyjGsELAXMgT8iexRlmucOZwIqt1yWtNPGktu2dKqYyZbgaBbmGkZq+kvh9pgkpS/WWPKO6TyMLkfN170bn06t3gfM6RXZKZFTGLefxHYbCM2l2qrG5vu+ppPNyk184aviz5ELeplyjNHzFQUL8zJsKydHOsVe+QeSm/SwHPlufsPqWSj2PqiQAvmwcho1erHjekzWCHdUHFJKDuxBhUEeFKCnSb49OGf/DI8GPr710ivcZh+ydV+xczTyaNpfAbA0ve4HYeDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OC58iInQGyjLPfbhggyWjI/MOwIUsNz/d/TYiFPJPYs=;
 b=Qj6vd0UN2e1q2XgowJ8rxprj87hrn+gMleAKn1uRn1EaqI8mVGA1gu7Pn0auFjTHwyPUJ/KAHG8SaPA4La08SPkVYIRLMvbUNBG4NVIgnSQZrhqsm6mCjdBWtVRPiv57+S089grUP65DVnbm9cJKHljfOHN+CYBvHnf6t3zviGY+Qrw/D4csg3zZXiZKdDJ1m6fH5YqWPBHAYmeu7aE0xLNfy+V/vwTkcznUp+H7NYqtFTeLoQjSN76JwxcIjy7i5K7myQwbuzOIo1QwOiCd8sE/GgN71gWpvCw79h+MTxUDqcCsav6KDd2nMCytCTuXScYj8gTMP3IAN9uygR0lqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Thu, 23 Jul
 2026 09:00:58 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 09:00:58 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 23 Jul 2026 17:59:11 +0900
Subject: [PATCH v2 2/4] rust: bitmap: add contiguous area operations
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-chid-v2-2-c35e5e9fb3d9@nvidia.com>
References: <20260723-chid-v2-0-c35e5e9fb3d9@nvidia.com>
In-Reply-To: <20260723-chid-v2-0-c35e5e9fb3d9@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0206.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::14) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SA1PR12MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: edc06dbc-b19c-450d-36c1-08dee898e9ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|10070799003|22082099003|18002099003|3023799007|10067099003|56012099006|5023799004|11063799006|921020|6133799003;
X-Microsoft-Antispam-Message-Info: KsCkT6O3YZoOk1wJKzHN08wLmyHkyCjLb7yNx7+NgZD40alTefH6Cpp+9+RTdOxCw/BVP02hXsoLjbp8UF6rg3GlXOIWKZU2LETVFa2YlLmp3VOClXye/oCrSND6qRW2iWznere0gqv6SH3BtBxH8LXFOKvmpLIyoEAeWt/3+oNP3ZQ50BeZSXEENR/n8jI2efDgid6qTCf48Hn7sMcZ24Fvewnz+J9iB8fYQQ1Ry0jhadeOS6iNW0O2iG8qV62oi/VMTEDHQFcTB2/076k3RK4qtCKrusJqPE80o2A+WE7gStKuMEh4R+fPiju0G2zAwEbKn3Uk5F+UTW8I7JXEbTceTlytgY5HCfLVeFmuUboJPtWqbGIxuTJRLL9Hs/C7qB/MTPqncOu4NUPOf5oBdpTXlSUF6le4SCwpQab2NSIz9DURqDoR8AZVWynft3WS00qRTuKLWeJULSy5CEhefhtrDOAfZR48SWGNdhRm0cO4l4hPon3vpIwuKYv2g3Xk6IFF4qEdNBcPTqqLkaVp/o2J674HGE6H9r4bmwOiDexNHo2NgRWJhgZGpGlVNa8ua5+4wwFaT+EiWVCWlNbg7XdlE0K4d5TGk3OWkdN73fda2ZPtjJ7xeX/PKVTyN1yUhMml/LXAHxlWZTT5tY5gEVhzZSh81duebdSnD0eyXjX04kZrXopfEEALQvqvSDuIA3H/jbVAddPJd9qn5rSb3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10070799003)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(5023799004)(11063799006)(921020)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azdUUWVIT3J3a0w2Y0Erays0WTNpaTlBYy8rNmRFY2lNeWFuYm5zUUp5Wm5x?=
 =?utf-8?B?MHJrRnBTWlhPbEdVcUp0dzY4cHJBWmU3cTZRVjQ3enp0WGRXRnFlOC91Y2VC?=
 =?utf-8?B?TkdWVDZLekFJRkpvNkE2cTQ1UHB2N1JQRkozZ3NnMGdxUi9NSDhueWMydHQv?=
 =?utf-8?B?K2JzOVBTYy9FZ0Exc25ubC9kN09Ta3M4aDBTSUNyU0thTVZkTGUzdGFjS3Vz?=
 =?utf-8?B?eDRyUnNkNG5JUllpbDBoT3M1SUhzRkhwMitqZjlIWk96YTVleW9xUkdGUVl1?=
 =?utf-8?B?dEhmZHhWMXY0a2dGM3RjTk1kemNiRTZwV1ZLUlFFS0lsMXhsWk9XOGIvUjRr?=
 =?utf-8?B?cFhFRldkT3c2UGVSL0lVaktNOW1tVzVyWWtNRWx1NjhpYWpoTHdkRFllaDFR?=
 =?utf-8?B?VjQ0WlhJdityRU95cHdZQXlNRFdWY0tmWVVzTlJ2Q2FXdUppTTF2Nm5OMVUz?=
 =?utf-8?B?R2srcnBmYzE2M3F5ZlNrWHp3Q2ZEbnF0c1NpQXZTeHBUVUxOc3lwL1FMdmtT?=
 =?utf-8?B?NXFvb1VxbXdvMElzZFdDS0R6L21EVU5LZkd4TFEyTlhBMk1iT3c3YVY4MEV5?=
 =?utf-8?B?SVgvZTZDMUlHTnozd3IvUFVuM092djUzOTM2ck1iZGYxa2x5VWZSM0VmZ1VE?=
 =?utf-8?B?OG5KRnNxZW9yTUFVZFNWbUdRcEFwanlldXlJWkVqRTgzWXNWaDJFZUpzT0c5?=
 =?utf-8?B?ckVDWHBkdjVkdllkN0d0Z0w1S1ZLS3BjdWd5TmFrSHB5a0RKdXlUOWxjZ1Nr?=
 =?utf-8?B?V1JPY1VYK0daVG1CRVg2ZkI0VDUvR3c5RXNCYkVDWGZ0c3B5ZkN2b0pPZG1r?=
 =?utf-8?B?QVhQRzc5WmhrTThnVFRVemM0a0wyUDk2MGRJLytvWVpVQ3ZSelEyeUY0OG9o?=
 =?utf-8?B?UVVvbE4zclU2R3ZRQXRIbnNYeUpQVUF0SHc4TmJIWXNZTlRyQ09VREkwemNl?=
 =?utf-8?B?OS84RE1LK25GU0Z0R3FLR1BHaklLNSs2UzZ5dkgvdG5PdlhtVmlYR3Jua3Jq?=
 =?utf-8?B?dUs4ckxmQ3VZZGphbU1oMm1UbkdjQlFmNHJJRW1ub0lQR3VaVDZVazVhcUtF?=
 =?utf-8?B?d3pPNExYd1ZiMFZ1WkI1U0ZLbmJXdjB0Q2xRMnlOZ2tKcWVuY1lkREgwRzJo?=
 =?utf-8?B?Ylk0MXZDTi9sTEc1UVd5bURJa1F0QTJkcGl1L2JEZ29sZm1KV1F0SjhYZ2wy?=
 =?utf-8?B?a3AxSENRQ1RmNmN4S2VKd2J2dHdhNjRZaHJmK3U5eVd4UG11NkRZSzYzR08w?=
 =?utf-8?B?eFByQ2JmMzg1YXZtSDBjMXZJMTJpTUN1dUhwbXZ4ZFVUZmxPWFFXQUNjd2N4?=
 =?utf-8?B?dFVhSWxqMlNGc3JMckpab1o3dVliaTdjZEl6NjV3NnBoZml0ZTNFS0o1YStY?=
 =?utf-8?B?dnhPbmlXUVV1ZzBvQmVrejl2ZlZMTk1qVXE2Vk05MlRFQnR5eCtlUHJKZGpT?=
 =?utf-8?B?cUpQK0VCaTZLQTYzdWtaTlZDTEQrMU1NTFhYTVo4ckZpRzZsOWozcTN3dXVQ?=
 =?utf-8?B?c2d5ZERUbzFBYWU5bzJOd09PSGRoaUkweFdyR0pEbEM2S1hrYVdOdVhvU2tH?=
 =?utf-8?B?U3dNQmgzYlRXLytEY2xRK2xwalZqL2ZlQjB1NlQrcGJPUktMMTFDSjhwWFJV?=
 =?utf-8?B?ZnFSb3pwUDFGd0pvbVZ0dVZBN3dJNlRwQkRkZlJvT01hdGRGNVZyNmRlYTJU?=
 =?utf-8?B?TzNDUklFd3JYZG5kZUFWT0ZPOHVKRmpycHdvNGZJcFFMSU81Q3NLOHhyUU0w?=
 =?utf-8?B?V2MvZ2hwNlZ4dXRXZkhhT2Y5SUQzM3RrMUpiTCtycEpjTDZwMmhiZUdzNHJt?=
 =?utf-8?B?Z09OUDAzei95amx0bEFaRlpSOVBQcUsyQUFXalFJYzd6Mm9BKzZCRlk2K1RJ?=
 =?utf-8?B?NldRdEFkdG9DS1hqZW1NQzluTXdJOTFRL3hicndqWFVVZEw5T2RsOTVaVlhh?=
 =?utf-8?B?MDlpaVloWU1XcjUxSDJ2UUt1MUsyR2JrdDR2TlF4azlEYW03Mk1IejRMTjJ5?=
 =?utf-8?B?cmtRMUtxUm5TUU9PTVVlM2dZMERXS0k3V1RDOCsrZCtuazhPSnFyeGxmRTc0?=
 =?utf-8?B?QUFCaXI2ZVpoTmExckYvQytraTBmMTlMQm5wNStkdzJmZERBNE4rSHdiSTlU?=
 =?utf-8?B?OXh5dExPbnVFRnJoZUNhSGtTU2MzMlhiazJ5eFJLT05JcjJlam04RU9DcFVr?=
 =?utf-8?B?REdDeE9YNVdNdFdYdnA5SlF4T0s3ekVhdU45RWsweElmMStjTWsxcFBFQVQ0?=
 =?utf-8?B?YVNRaUg4eE1lTktUc2JiZjBPdGVDcjdVR3lkNzJqQVdINUxTeER4SmhhZEZS?=
 =?utf-8?B?WWJRZDIrdlpZUUhBNFhScW5rUEx1MjlGc2Y5UEhKZXhpdm5HbXQxTG9yUC91?=
 =?utf-8?Q?sx5luHHCzpPk/wccNj+HFfnuxG60Yiv4l4NYYOpj08njI?=
X-MS-Exchange-AntiSpam-MessageData-1: CW5UUIjhFwXXNg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc06dbc-b19c-450d-36c1-08dee898e9ae
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 09:00:58.7551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1hWfhm1bNKlH6ySJl21VpUrHoPyiVKXG36f2M1BRBiE/Tmwg+VEfQUm0e5Z48xxJHPfEMRJZTt3t80XwTyiKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104
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

Add bindings for area operations on bitmaps. Each one is
made safe by adding some extra checks compared to the underlying C code
(for example, checking bounds) and with additional checks to catch
likely erroneous usage if `CONFIG_RUST_BITMAP_HARDENED` is on.

The C code uses signed integers for some parameters, for example the
length for `__bitmap_set`, so bounds check against i32::MAX. We can't
rely on `BitmapVec::MAX_LEN` because `Bitmap` may not necessarily be
backed by `BitmapVec`. There's also a few cases where an `align_mask`
can cause an infinite loop in the C code: masks that are not a power
of two minus one, and masks where `self.len() + align_mask` overflows
the alignment step, so check for those.

Add tests demonstrating the edge cases.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/bitmap.rs | 217 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 217 insertions(+)

diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index a43bfe0ec3dc..1395bbe99cbb 100644
--- a/rust/kernel/bitmap.rs
+++ b/rust/kernel/bitmap.rs
@@ -497,6 +497,127 @@ pub fn next_zero_bit(&self, start: usize) -> Option<usize> {
             Some(index)
         }
     }
+
+    /// Finds a contiguous area of `nbits` zero bits at or after `start`, aligned per `align_mask`.
+    ///
+    /// Returns the bit index of the start of the area, or [`None`] if no such area fitting in
+    /// the bitmap exists or the `align_mask` is invalid.
+    ///
+    /// `align_mask` should be `0` (no alignment) or one less than a power of two, in which case the
+    /// returned index is a multiple of that power of two. Masks such that `self.len() + align_mask`
+    /// overflows are checked and considered invalid, as they can hang the underlying C code.
+    ///
+    /// # Panics
+    ///
+    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `start` is out of bounds or
+    /// `align_mask` is invalid.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
+    /// use kernel::bitmap::BitmapVec;
+    ///
+    /// let mut b = BitmapVec::new(64, GFP_KERNEL)?;
+    ///
+    /// assert_eq!(Some(0), b.next_zero_area(0, 8, 0));
+    /// b.set(0, 5);
+    /// assert_eq!(Some(5), b.next_zero_area(0, 8, 0));
+    /// assert_eq!(Some(8), b.next_zero_area(0, 8, 7));
+    /// assert_eq!(None, b.next_zero_area(0, 65, 0));
+    /// # Ok::<(), AllocError>(())
+    /// ```
+    #[inline]
+    pub fn next_zero_area(&self, start: usize, nbits: usize, align_mask: usize) -> Option<usize> {
+        bitmap_assert!(
+            start < self.len(),
+            "`start` must be < {}, was {}",
+            self.len(),
+            start
+        );
+
+        let valid_align_mask = align_mask.wrapping_add(1).is_power_of_two()
+            && align_mask.checked_add(self.len()).is_some();
+        bitmap_assert!(
+            valid_align_mask,
+            "`align_mask` must be 0 or `2^k - 1`, with `len + align_mask` not overflowing, was {}",
+            align_mask
+        );
+        if !valid_align_mask {
+            return None;
+        }
+
+        let nr = u32::try_from(nbits).ok()?;
+
+        // SAFETY: `bitmap_find_next_zero_area_off` is safe to use with an out of bounds `start`
+        // value and never reads beyond `self.len()` bits.
+        let index = unsafe {
+            bindings::bitmap_find_next_zero_area_off(
+                self.as_ptr().cast_mut(),
+                self.len(),
+                start,
+                nr,
+                align_mask,
+                0,
+            )
+        };
+
+        // In case of overflow, we may get back a range outside of what we requested.
+        let end = index.checked_add(nbits)?;
+        if index < start || index >= self.len() || end > self.len() {
+            None
+        } else {
+            Some(index)
+        }
+    }
+
+    /// Sets a contiguous area of `nbits` bits starting at `start`.
+    ///
+    /// If CONFIG_RUST_BITMAP_HARDENED is not enabled and the area `start..start + nbits` is out of
+    /// bounds, does nothing.
+    ///
+    /// # Panics
+    ///
+    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and the area `start..start + nbits` is out
+    /// of bounds.
+    #[inline]
+    pub fn set(&mut self, start: usize, nbits: usize) {
+        bitmap_assert_return!(
+            start
+                .checked_add(nbits)
+                .is_some_and(|end| end <= self.len() && end <= i32::MAX as usize),
+            "Area `start..start + nbits` ({}..{}) must be within bounds {}",
+            start,
+            start.saturating_add(nbits),
+            self.len()
+        );
+        // SAFETY: The area `start..start + nbits` is within bounds.
+        unsafe { bindings::__bitmap_set(self.as_mut_ptr(), start as u32, nbits as i32) };
+    }
+
+    /// Clears a contiguous area of `nbits` bits starting at `start`.
+    ///
+    /// If CONFIG_RUST_BITMAP_HARDENED is not enabled and the area `start..start + nbits` is out of
+    /// bounds, does nothing.
+    ///
+    /// # Panics
+    ///
+    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and the area `start..start + nbits` is out
+    /// of bounds.
+    #[inline]
+    pub fn clear(&mut self, start: usize, nbits: usize) {
+        bitmap_assert_return!(
+            start
+                .checked_add(nbits)
+                .is_some_and(|end| end <= self.len() && end <= i32::MAX as usize),
+            "Area `start..start + nbits` ({}..{}) must be within bounds {}",
+            start,
+            start.saturating_add(nbits),
+            self.len()
+        );
+        // SAFETY: The area `start..start + nbits` is within bounds.
+        unsafe { bindings::__bitmap_clear(self.as_mut_ptr(), start as u32, nbits as i32) };
+    }
 }
 
 #[cfg(CONFIG_RUST_BITMAP_KUNIT_TEST)]
@@ -614,4 +735,100 @@ fn bitmap_copy_and_extend() -> Result<(), AllocError> {
         assert_eq!(Some(17), long_bitmap.last_bit());
         Ok(())
     }
+
+    #[test]
+    fn bitmap_area_set_clear_find() -> Result<(), AllocError> {
+        let mut b = BitmapVec::new(128, GFP_KERNEL)?;
+
+        assert_eq!(Some(0), b.next_zero_area(0, 5, 0));
+        b.set(0, 5); // Now contains {[0, 5)}.
+
+        assert_eq!(Some(0), b.next_bit(0));
+        assert_eq!(Some(4), b.next_bit(4));
+        assert_eq!(Some(5), b.next_zero_bit(0));
+        assert_eq!(Some(5), b.next_zero_area(0, 5, 0));
+        assert_eq!(Some(8), b.next_zero_area(0, 5, 7));
+
+        b.set(8, 8); // Now contains {[0, 5), [8, 16)}.
+        assert_eq!(Some(16), b.next_zero_area(0, 4, 15));
+        assert_eq!(Some(16), b.next_zero_area(0, 4, 0));
+
+        b.clear(0, 5); // Now contains {[8, 16)}.
+        assert_eq!(Some(0), b.next_zero_area(0, 5, 0));
+        assert_eq!(Some(8), b.next_bit(0));
+        assert_eq!(Some(15), b.last_bit());
+
+        b.clear(16, 0); // Zero-length in-bounds clears are no-ops.
+        assert_eq!(Some(8), b.next_bit(0));
+        assert_eq!(Some(15), b.last_bit());
+
+        // A zero-length request returns the first aligned position at or
+        // after the next zero bit, even if that position's own bit is set.
+        assert_eq!(Some(1), b.next_zero_area(1, 0, 0));
+        assert_eq!(Some(8), b.next_zero_area(1, 0, 7));
+
+        b.set(60, 10); // Now contains {[8, 16), [60, 70)}.
+        assert_eq!(Some(60), b.next_bit(16));
+        assert_eq!(Some(69), b.last_bit());
+        assert_eq!(Some(16), b.next_zero_area(9, 40, 0));
+        assert_eq!(Some(70), b.next_zero_area(0, 45, 0));
+
+        b.clear(62, 6); // Now contains {[8, 16), [60, 62), [68, 70)}.
+        assert_eq!(Some(62), b.next_zero_area(60, 6, 0));
+        assert_eq!(Some(61), b.next_bit(61));
+        assert_eq!(Some(69), b.last_bit());
+
+        b.set(64, 0); // Zero-length in-bounds sets are no-ops.
+        assert_eq!(Some(62), b.next_zero_bit(62));
+        Ok(())
+    }
+
+    #[test]
+    fn bitmap_area_exhaustion() -> Result<(), AllocError> {
+        let mut b = BitmapVec::new(64, GFP_KERNEL)?;
+
+        assert_eq!(None, b.next_zero_area(0, 65, 0));
+        assert_eq!(None, b.next_zero_area(0, usize::MAX, 0));
+        assert_eq!(None, b.next_zero_area(1, usize::MAX, 0));
+
+        b.set_bit(0); // Now contains {[0, 1)}.
+        assert_eq!(None, b.next_zero_area(0, usize::MAX, 0));
+
+        b.set(0, 61); // Now contains {[0, 61)}.
+        assert_eq!(None, b.next_zero_area(0, 4, 0));
+        assert_eq!(Some(61), b.next_zero_area(0, 3, 0));
+        assert_eq!(None, b.next_zero_area(0, 1, 63));
+        Ok(())
+    }
+
+    #[test]
+    #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
+    fn bitmap_area_invalid_align() -> Result<(), AllocError> {
+        let mut b = BitmapVec::new(64, GFP_KERNEL)?;
+        b.set_bit(0);
+
+        assert_eq!(Some(1), b.next_zero_bit(1));
+        // If this isn't rejected, it would cause a hang in the C code.
+        assert_eq!(None, b.next_zero_area(1, 1, usize::MAX));
+        // Reject non `2^k - 1` alignment masks.
+        assert_eq!(None, b.next_zero_area(1, 1, 2));
+        assert_eq!(None, b.next_zero_area(1, 1, 5));
+        Ok(())
+    }
+
+    #[test]
+    #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
+    fn owned_bitmap_area_out_of_bounds() -> Result<(), AllocError> {
+        let mut b = BitmapVec::new(64, GFP_KERNEL)?;
+
+        // Should be ignored since out of bounds.
+        b.set(64, 4);
+        b.set(62, 8);
+        b.set(usize::MAX, 0);
+        b.clear(usize::MAX, 0);
+        b.clear(2048, 8);
+        assert_eq!(None, b.next_bit(0));
+        assert_eq!(None, b.next_zero_area(64, 1, 0));
+        Ok(())
+    }
 }

-- 
2.55.0

