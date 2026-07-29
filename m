Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631BCC53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 06:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE15010EAAC;
	Wed, 29 Jul 2026 06:54:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="iBCG52oa";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013052.outbound.protection.outlook.com
 [40.93.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79C6910E653
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 06:54:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5V/ri+zuhFDOmFiPB7ffp2YZNbKIuZakBvpMM0dtdoFC+u/Bt53/HahE/Dg7nRC/6Wp2sGM6bjHmjP1ZjXPr80aOJveh468yshmHkhTjMzVUXgguXTjivHzKk74QytggEIGfAJ5OaujRw8v/pITe6eUcB7f0L1hDVM/yEqc8T0MpT/VCIbV9Hx2xdyLrfNTdjJ8N/UW0rtY2HQNaSK6ZHebdGCnBcdWyVehVyrRZk6QQXtqdOSQnmAjK4NFDHcE7g9sW8f0W86azX2Lwpcsj8eidUDZ/vcAGCoT254ZvtyjpOp8JsZ7Df/du2VwBR8PEPjZOH4p0yEJx88PqWy/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzVQX5HFIpoSVsfM6+nY12LKfmYaUP7iQIANam8VxXo=;
 b=jpGw2AqwYAAUw3o0ZsVJzc0bWzXzgrlK6zV0cjuTylCkzql957ab5lM/vJxV/Hk6nexXztTJdZ1b01Lqwt3pVA8Uv8WafnJvf+sUnLjrMnTbKJ3Q/8QJS0jdumjdpVtQ4zCtOC/YrPwR52csEN9aVJBezUArkt2Jd7qt1bxdYlp8JAjNXLT1R9AvDuJfivg6oX5+I4ycn20wtqZ/LbWeeH5RUPQHLoqgyk/wVzHmNZjFP20LxqrETP9SM+wa8hhJhAQnL0o1bDdKtNDhH4Nc9JvPw57xv0zXpEsJ7QUR43Yhj6ECxcgp4jjKS2DEGPZzhqSJyQ7mEA0Xmt/d6ZoYsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzVQX5HFIpoSVsfM6+nY12LKfmYaUP7iQIANam8VxXo=;
 b=iBCG52oaNZbdopg8IPlx192pyqhL21WmDKRKAvzm5XjZQOrkG8vBulJlDWe7sZ7S7uwre8LoFzP4GuSE1/6ddnho1YGp1o0knDb7Fmb/RfUodftsMDzIxAmDOShyFZ/WtNJsrVY2GbPXkuZnRRZMzVdOjxvnSkPDmW6TXgxgORUz/tSK0Qyu/u3rNcp2C/u5WfjuBylJw9uVwqmL2fBnXfsGwJFZQv20oZ7OhJJvFOdgiJzolkF0FdGVMZDNMx/cZdVCnZrPPpHQXleeY2srdgQm9yODp0GGi4Q6ouwCl0d00VlHuJr3lxYSdBV1HIZlO3LWkEIvbKoz9YFqwrsC2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8894.namprd12.prod.outlook.com (2603:10b6:208:483::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 06:54:30 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 06:54:30 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 29 Jul 2026 15:54:13 +0900
Subject: [PATCH v3 2/4] rust: bitmap: add contiguous area operations
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-chid-v3-2-20cc08032bbc@nvidia.com>
References: <20260729-chid-v3-0-20cc08032bbc@nvidia.com>
In-Reply-To: <20260729-chid-v3-0-20cc08032bbc@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0139.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::19) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: bb80af25-b40c-4aa8-f7a9-08deed3e3d47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|10070799003|376014|23010399003|366016|56012099006|5023799004|11063799006|6133799003|3023799007|10067099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: +TK3iJ22drksY/k3smKX28swrbiWaikEVNFT6G2iFMyQguNbPx03atvvx0eaoewxCOqi9vLeDbUeUxG7FUggBMVC2BJ7nI4DN81Is2nGhmDTI2QCJDO4hgPADsAXTXBixggISSE/M73Cl+xbIGSe/+byygE/9XasfDzNp8/j7DQZwgm9aJF6rr1HgcDqYCB3fhMcDddjTyo2Rf2Gx7MezhB2xbP3GiVWMuvlPvTMIn1Oox2070kN0Cf4dykgV+Zbz1MtnEBHqmK3SXHzdkZ2I9DEM3ONqucGZIN8rxbvAV0tgGvlhfbhC3C+kGE1hQoPDDwa6kVnQ0G31do7Srt1wkBBYjWfKZjI/yZJDmhIWCuF6O4sMgVv+lJVB23V91Pd0MajwV5rlVdFo1f24YEAPaPMD69n4BM3TlBLzOlu40og3ltYewK/5H1oHUTwL4XiWTcJ9C3vTPJxFDNub17xqgDD4GSMla+vxA1jorZUvYIS1zNrkahlpI9LNQp3ba8oSbtovpUAmjH3wRU82JMmQPUqVOueSa3NW/TAz0NTfnFedGpSpuHT3myFaAXWJy3ufVI/2RaYSQKC8Rgo9len12ceL3e/J/YBNdoAFU17vXlJudidgHQiNwLY3WzjCafvQxhfm2wA/g04wtmeu9s57g/V+jgNemOKDEvWl55xB7Rr2qpaBlJsqVsBDnAVL6+TFSjqGcWKgh9DWl0+RyIvgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(10070799003)(376014)(23010399003)(366016)(56012099006)(5023799004)(11063799006)(6133799003)(3023799007)(10067099003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjhGQ0F4ZnVEYStUc0JCZDZ6UXdJV2I3YXZtRGhGajVpSUppSkpKN2ZJcEFu?=
 =?utf-8?B?RG5Vb21xZjJmajhqZnFJTDF3dXJETU9TRmFHTmtodVJkMXpoWHQxWE80Y0Vr?=
 =?utf-8?B?RmhGWEJhNWVNZFhXdE5UM2diOGlTSS8rV3o1TlVDRGtycGsza3JOcXdsaVZj?=
 =?utf-8?B?YUp1NW1hUDJBTjQzd3FKT2lVN3FpaEV6UWw1TXBxQkg3blJaVnQwaWRqVnZj?=
 =?utf-8?B?M3A5MHJtSFIzR2xkRS9aYU85OERGL1c1WUZ1M0FaWFNEQ3ZVTHhrVStpcEJG?=
 =?utf-8?B?NDA2MjltNWhxRFZWYlpFU2t5WHBPZ3g3bmJmK1ovaXpnVUQ5U0NZdENuTXlw?=
 =?utf-8?B?SGp0UzV4ckdMVjdzZ05ESXZpc1ZDYU9CdGhhQUpLd1dMa1Jta285SXVsSjFy?=
 =?utf-8?B?OTJNMldkZzlHWHhPRC90T2cvUzVYa1hnWHFXd2pTd1FNYTR4dVdUQ2VmOUV0?=
 =?utf-8?B?R0lZWi9hVUQ4NUFCTWc1SFdyUUJzdDRqUm0vMTZCM0NSSDRMcUhBSVNNM21a?=
 =?utf-8?B?bzlFYnhXN1VaMWlqZnVhNmNOdmdDWGVhUjcrblpWTGJYQlFYZjdGOGI5NjVi?=
 =?utf-8?B?TkFzSWYwaDQ2K0hBVkw4ZklTdzcrb05iRkFHbjcxelJqUm1yckJUN00reXRO?=
 =?utf-8?B?K21GM2VPMit5R0ZOUjBIeDZPZlJ2REVrL3pUNktKQVpnRWJja2FYVGFEbi8v?=
 =?utf-8?B?OFhhRDJZQXhWRkxwT21PNURnaVR4VlRRYjdrNThPRTl0KzVsV0Y5dDVoZ3RS?=
 =?utf-8?B?NUJnVng4SGJMeHBLSzQ0N0lRZUFPakY3NXpnSXlxKzM2Zk9xUGwwOG1xN2dO?=
 =?utf-8?B?VEdubUpxVERtZGM3blpPeVduQmViTEQ3SE9mYmZVbkMrMlgwYVNEMGpYUkk1?=
 =?utf-8?B?bmpMUFc4Q2t0emFBZ0hCTC9RYTlEYkltUTRkZmxXbGROK1hTWTg2YjlSdkRR?=
 =?utf-8?B?TGs1bWxKcjBLOFpwR1FCdkhmelJZOTIvQVIxb0NnSXBKU1Vvb1o0UEpoTFZO?=
 =?utf-8?B?bFlXRCs0a3BOVWxYM1JZOXd3UVErZ3dmRU95Z0RvTE1QOXBaaVdjMXU0eHR3?=
 =?utf-8?B?aVE4WHJkdlJ1YXlnWnpCaVZCbEYxcExyeHlrSXV6UTBqdVpiaHVkRVJxam1s?=
 =?utf-8?B?MmlQMndiTEV0MU9jZXYvMjFHc2dISm1IWGVDTlNudDBIUURrZ3JRSWhNc1Fq?=
 =?utf-8?B?MUIvSUpSYTl6cmpML3hVMVJpdWtnNGJ5cEV3eWFTcm5UeDhDckl5QzVUN2ZB?=
 =?utf-8?B?OWt4aWM3bDk3V3ZmMGxTdkl0clRCdktvQWF0aTE4c2J0SVVONTBCc3JocFhT?=
 =?utf-8?B?NXByb1hJQXFzdnArUzNIcTQxN2lHbEhzblF5OEphSHFkN21BbVVPSkJ6Ymdi?=
 =?utf-8?B?bnFsZkZwTGxxLzBURm1KS0xpSDlQaTFiZXIzVWdLVElBSTJoSjVoYjdNU2ZS?=
 =?utf-8?B?WDZHK1duSVEveHFKLzZRdDBGZlkvSkNobkNNSVUyWmdqTllOZFAzS2NTdHZZ?=
 =?utf-8?B?YmZ5c2l4RVZ6azhwQjRIWE5ISlFUa0ZFL0dQSWpTV2l6VWpyZnV5UnNIdjRy?=
 =?utf-8?B?VUt5cjhRa0FqZkNsZUx3dENYMlFEb0lYc2RaVTRmcG02UnFGZDQxd2JnWS9t?=
 =?utf-8?B?czV0OEFmQlVVbStTUmE2YldsZ3BKRU9WdWxlVCtndE9LSVZkQ0YzUVFuNHNt?=
 =?utf-8?B?RE9KcDdFMHBjNTJzcjM0cWo1ejBPRGY2UUppS0xiRFpBYjZkSjBSSy9BUlZC?=
 =?utf-8?B?SkVoVHZXL0NHMkc5Ny9JVVlIeXNRR0ZDOVlhdTRIZkJ3WkpXYzBINk5EY3N5?=
 =?utf-8?B?RnlDY2VUd3l2YVZnbkNGbkp5M0tFc3RoUkYxbkppMXZPbUF6S1VsUVZySlRx?=
 =?utf-8?B?QUdGNXY3YStwRUFEZWI2djcxajZwQmZpc0xWYThGeEoxQzFZOEVBNGI2VHUx?=
 =?utf-8?B?aWFBMmRkaU9vVnJYRGN6b0I3cGFhaEk4U0pPaE90QzVmazM1UDExL2lUcitx?=
 =?utf-8?B?c2RVcXJ3L0N4YnBLdHpLVE05RWxvMWR6Z3pwQzJMbU43ajhwbTRaOWFUTitv?=
 =?utf-8?B?TmJaUUhldFgzUkd6di8rV0VXa0lHZXJ6K25MU0VheEJUUlQ2VlMvcmcyVmZY?=
 =?utf-8?B?MlhVYWhodFViWTB4Y29INUJMN1d5U0srRkJSV3VwaDdWZERFZGRCeCtQRzUr?=
 =?utf-8?B?T2NqeGtrUjg3emVFRWZpMXJsdE1OcEpaTCtRUkluYm9XK3o2ZlFTSWVxNWdU?=
 =?utf-8?B?bjhuaWV5WThsWmRyb29OSnJ0MmFJUjIwWVhZOW5sL1RYVks4cy85TWIwOU1G?=
 =?utf-8?B?cnFTV2JGWjVEbUpia3pMN0lmN05HeTluMjhUQTJ5V04zK1hGUERBM2Y3QmIw?=
 =?utf-8?Q?DxIanFrUksQsvsAbgPz8OoxutdE4a3utW8GdfqKfvDbZB?=
X-MS-Exchange-AntiSpam-MessageData-1: onm1e6gtqf6QfA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb80af25-b40c-4aa8-f7a9-08deed3e3d47
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 06:54:30.6467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+GaHmGy0Xyimuj60S2G2RKbQlnfb5bJMmDLnFwrPGkxysXxJkufgCafUMYJZprzXKgJN/OhsEVfyT4r7qzW6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8894
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
backed by `BitmapVec`.

Add tests demonstrating the edge cases.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/bitmap.rs | 194 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 194 insertions(+)

diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index a43bfe0ec3dc..f4b0b8ae39d8 100644
--- a/rust/kernel/bitmap.rs
+++ b/rust/kernel/bitmap.rs
@@ -10,6 +10,7 @@
 use crate::bindings;
 #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
 use crate::pr_err;
+use crate::ptr::Alignment;
 use core::ptr::NonNull;
 
 /// Represents a C bitmap. Wraps underlying C bitmap API.
@@ -497,6 +498,116 @@ pub fn next_zero_bit(&self, start: usize) -> Option<usize> {
             Some(index)
         }
     }
+
+    /// Finds a contiguous area of `nbits` zero bits at or after `start`, aligned to `align`.
+    ///
+    /// Returns the bit index of the start of the area, or [`None`] if no such area fitting in
+    /// the bitmap exists.
+    ///
+    /// The returned index is a multiple of `align`. Alignments where `self.len() + align - 1`
+    /// overflows a `usize` can hang the underlying C code.
+    ///
+    /// # Panics
+    ///
+    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `start` is out of bounds.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
+    /// use kernel::bitmap::BitmapVec;
+    /// use kernel::ptr::Alignment;
+    ///
+    /// let mut b = BitmapVec::new(64, GFP_KERNEL)?;
+    /// let unaligned = Alignment::new::<1>();
+    ///
+    /// assert_eq!(Some(0), b.next_zero_area(0, 8, unaligned));
+    /// b.set(0, 5);
+    /// assert_eq!(Some(5), b.next_zero_area(0, 8, unaligned));
+    /// assert_eq!(Some(8), b.next_zero_area(0, 8, Alignment::new::<8>()));
+    /// assert_eq!(None, b.next_zero_area(0, 65, unaligned));
+    /// # Ok::<(), AllocError>(())
+    /// ```
+    #[inline]
+    pub fn next_zero_area(&self, start: usize, nbits: usize, align: Alignment) -> Option<usize> {
+        bitmap_assert!(
+            start < self.len(),
+            "`start` must be < {}, was {}",
+            self.len(),
+            start
+        );
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
+                align.as_usize() - 1,
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
@@ -614,4 +725,87 @@ fn bitmap_copy_and_extend() -> Result<(), AllocError> {
         assert_eq!(Some(17), long_bitmap.last_bit());
         Ok(())
     }
+
+    #[test]
+    fn bitmap_area_set_clear_find() -> Result<(), AllocError> {
+        let mut b = BitmapVec::new(128, GFP_KERNEL)?;
+        let unaligned = Alignment::new::<1>();
+
+        assert_eq!(Some(0), b.next_zero_area(0, 5, unaligned));
+        b.set(0, 5); // Now contains {[0, 5)}.
+
+        assert_eq!(Some(0), b.next_bit(0));
+        assert_eq!(Some(4), b.next_bit(4));
+        assert_eq!(Some(5), b.next_zero_bit(0));
+        assert_eq!(Some(5), b.next_zero_area(0, 5, unaligned));
+        assert_eq!(Some(8), b.next_zero_area(0, 5, Alignment::new::<8>()));
+
+        b.set(8, 8); // Now contains {[0, 5), [8, 16)}.
+        assert_eq!(Some(16), b.next_zero_area(0, 4, Alignment::new::<16>()));
+        assert_eq!(Some(16), b.next_zero_area(0, 4, unaligned));
+
+        b.clear(0, 5); // Now contains {[8, 16)}.
+        assert_eq!(Some(0), b.next_zero_area(0, 5, unaligned));
+        assert_eq!(Some(8), b.next_bit(0));
+        assert_eq!(Some(15), b.last_bit());
+
+        b.clear(16, 0); // Zero-length in-bounds clears are no-ops.
+        assert_eq!(Some(8), b.next_bit(0));
+        assert_eq!(Some(15), b.last_bit());
+
+        // A zero-length request returns the first aligned position at or
+        // after the next zero bit, even if that position's own bit is set.
+        assert_eq!(Some(1), b.next_zero_area(1, 0, unaligned));
+        assert_eq!(Some(8), b.next_zero_area(1, 0, Alignment::new::<8>()));
+
+        b.set(60, 10); // Now contains {[8, 16), [60, 70)}.
+        assert_eq!(Some(60), b.next_bit(16));
+        assert_eq!(Some(69), b.last_bit());
+        assert_eq!(Some(16), b.next_zero_area(9, 40, unaligned));
+        assert_eq!(Some(70), b.next_zero_area(0, 45, unaligned));
+
+        b.clear(62, 6); // Now contains {[8, 16), [60, 62), [68, 70)}.
+        assert_eq!(Some(62), b.next_zero_area(60, 6, unaligned));
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
+        let unaligned = Alignment::new::<1>();
+
+        assert_eq!(None, b.next_zero_area(0, 65, unaligned));
+        assert_eq!(None, b.next_zero_area(0, usize::MAX, unaligned));
+        assert_eq!(None, b.next_zero_area(1, usize::MAX, unaligned));
+
+        b.set_bit(0); // Now contains {[0, 1)}.
+        assert_eq!(None, b.next_zero_area(0, usize::MAX, unaligned));
+
+        b.set(0, 61); // Now contains {[0, 61)}.
+        assert_eq!(None, b.next_zero_area(0, 4, unaligned));
+        assert_eq!(Some(61), b.next_zero_area(0, 3, unaligned));
+        assert_eq!(None, b.next_zero_area(0, 1, Alignment::new::<64>()));
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
+        assert_eq!(None, b.next_zero_area(64, 1, Alignment::new::<1>()));
+        Ok(())
+    }
 }

-- 
2.55.0

