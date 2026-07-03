Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7699C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:19:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47A4010F76A;
	Fri,  3 Jul 2026 10:19:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="royTNB0A";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010068.outbound.protection.outlook.com [52.101.85.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFF9510F76A
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 10:19:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMfRBFwc/ianYYhtAvUUbYRGIvRHYV7C9UPRNvoMBoWgCpMYFJHh5xyz22MWWxoynVfsV4RFGgmzOvkeQf1EtDz2M6VkgLtwjTGL3Wbg1UavPmoDVLcHD/TLCIyw1SVFyBOwRN0J1TGUgRCbDVYwETLwLK/6sDzBJ8ayLbA89lvQl6GXKRPXik6/uITYjRZXCbBKd1Vhtfj1O/GglFBSpHkSiYC5QvnIR+vutP4RrmOkWldElLEumpxtajHJj0BfxP+0TQ8xuP8UjjtN8X7GWFboJZX+VepAtoNQf0rpBCAoMVJ2svROxuI9GjIcfi42vJyvdT8Ya1Ic5+4YToTuAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/TsJLkY7Ggv+hd0fC5wlcE6ac7Y6v4PXdVo4p3IA7c=;
 b=ldywv4HfoAQjinLmHlWHxDFCI6ekZ+cvfK6kGTLjOW6w8dCK9NJIrhgp5VTWzmJeL3kwb2ddXABmPsMarKWaofhvz/u0LoKtXA1raHvKcJlOPQ7/s0WYaHs8XBwdGkwff2P//TwERjbnkh6EmGB1jyUBfRzrS3KYQh8mBs3L3VDugr7UxF7Ljk9mkOuN2NqPFS62ajwqMOo4/IdSelZm4h6YcrA5rzIeezhw7wZ0r/xczdMzXYsHfwl+/8YYcBbMWQYMWeR0hFUn2rs0yNL3bhXEun+fRZjQZyWJRQFzPm7/DlUpI/GYqg8lzPKQGwgxveopd+bVSzjma2xW20CQMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/TsJLkY7Ggv+hd0fC5wlcE6ac7Y6v4PXdVo4p3IA7c=;
 b=royTNB0A9e4oByBCtkp/iUI1FmNm/V79Mn22t5iXia9oxR3tkl3IBmY/BfxE0dPMaB55D0626XaBqK2zjgeuStSaiMRuJeArLRKawOOr5K/WNb8pvHpb0sG+5Qd/uhIvW0B7We6XmqmAQCj2BUle30Jgs+XgBzAhchKIFVoE6yUV9+qENc8+Le4BZZ/cQiCBfjzyNi3qikQf3A6CgaCoU96KIk2q8Y1GJ94H7Ba8QWIHtG+SJYFDqGxdKy0AaQdkx1UQlx0akZqwrlw1ydL34DjDvQKbxNMWTc3cj8oaVZMvszZwtZpnbxwAFlVXEc5sL6DPu3ri5yYPKgO1uQNCWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 10:19:33 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:19:33 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 03 Jul 2026 19:16:06 +0900
Subject: [PATCH 3/4] rust: id_pool: add contiguous area allocation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-chid-v1-3-84fe8259e46e@nvidia.com>
References: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
In-Reply-To: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>, Burak Emir <bqe@google.com>, 
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
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P286CA0044.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::15) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cdaac71-f190-49d6-193a-08ded8ec9383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|23010399003|7416014|376014|18002099003|22082099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info: c7CUIHokIrh9DDN4pRnd8bDLspWKQyKgGzDtX+J2/JxBnl00GEOrJWRSh9RqCiyp0PyUzU64j5mSh0N6LE2TjC6s5j4Gf0TaQwzUDn6rso+oM5qv5dXmiho519HF2qyStSlPLZwmWnIQi6Co9VDDFUXmpPYt6B1FXOpjDZ5z+Hj/YnJmdTCjGSc4fmkTaOt4dWtnIjBPqUpOdePi1W3OSKeBQtkaqzXiXKQ1RlehUoxwN44Sa9bmXasGfKZwsd8Z0pLBsi6rUYiE07ZDfLbmlNoanmkLwifsXP1jCnPDKtD+Y5vEbvervW9E1RV9YDfiFYUi2Cdty6uTxuQWd3lWjcezHY9J5PUOJe5MjYA+uNBUuAU5yI4Kv+b6K/C/YuCPolt3G2EYrVKdy/TswwZbuBorqP/G/spLeiHpUfnY6M53u8zr+28TSK+d2Q+GIpMIBhvfFsi4+lbAM0v75eCVtc5hnBeZNDlABbW+8zi1UcRo31y2yT1X6WBOUvJlVDxVXEnFEzKusa64B86oj7eYcSNVZjXlHZeA3N2Id2VxTZ9P8h5GWDqXcUPxvvpR/gv/2C3LmAi/ZUiGuXJzAz/qjulqtlYhaCIWFPu3JV14LBSkqFCJBvyMXQY1p9LK1Axd8/fvduI6M7W3FT2DLvCsO+7+lRGcO7YEsCFTQGDcJy7Yjv9+aV7+gt/FAZZwL6B35wsL2JTCHpWwWmQfadDprA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(7416014)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWIzRHEwVTZqcXlVZHViSkVNVlkzZjE4RFduZWF6YmVvcHBNWC9UMmpuWE01?=
 =?utf-8?B?dGxxTXByb0RrVjdmZ0RFVzRQSDkzYmVjQnVTOUpLQnkxczhuV1BpL2M4WktE?=
 =?utf-8?B?WUFqQkVudTc2VXoyVTZxM3R1NG16emdzcmVoaExvRkV5YUQ0WmJMZnpUNi9q?=
 =?utf-8?B?MDVoR3NabzgxZVliQXg4WThrMmEwd0I3MEZ6a0d5ajgwczB3dkJCUG5nc3Rv?=
 =?utf-8?B?aFE5end6eUhhdjJnVzJCaGE4dTU1NERETzYvdE1GbGdBVGZDU21GQ2M0ci85?=
 =?utf-8?B?ZGhXQWxpV200SmNiWlRJZ01ZMUR6Ukp3Z1laczlzNXprZlRQRnE2NEJxUk1k?=
 =?utf-8?B?S3J1M1p3UnlCVlNOWHprbkpDOThJQU5WcnJYV3NLVUhFelg3a0lqSDNhcmNR?=
 =?utf-8?B?d1IveFQ3TktaTkhmMWpqMmZleXJmcm05QjBRQVhZTFpFVVFTdFRUQ1RjbmZD?=
 =?utf-8?B?S3liaTBzVDNtTkt4dC90UTVVa1JEV1ROd2dxYnFIemQ2RVg1ZVlRVVNhRjVS?=
 =?utf-8?B?SUNoaXB6dkd1M0xPaUdIK011Y011UkdQTXF0NDg4aXJlOHBPUW9iQWs3NVFs?=
 =?utf-8?B?TlUyREtITjBic3lOczc4ZXRpai9DaUczbi9IVEY4aXN0UTZFUG5LeWluamNH?=
 =?utf-8?B?aWtqV3VOS3ZRNjlhaTdZZnhUdm50UmlzSHVuS1hQZktuenZrbldnY0o0ZEMy?=
 =?utf-8?B?WTJjNjVrdW1CUmxFSktQckJOQi9KdFhnWG9SVlBaWk9NWm9ZMEZtY1dkWDFE?=
 =?utf-8?B?bzRISUNDcElVR29xaVU0TmxnR0FYZGZZQ2tFWVZoeHd5ckRveDdnenpLSlBw?=
 =?utf-8?B?akVjYzM4Um84RFBHc2syL3pERFRuUWxWMFpNRGJOUm02SE43TXV3aCtsOVhz?=
 =?utf-8?B?R1ZmSDF5MmRsR3M3cWdZSTRQZTlsMGtvMDU0amZuTWdhZnJlMnRoZGJ6ZVpC?=
 =?utf-8?B?dVpHQXVLdk01NVFWZXBPVko0RUhrT1NwYjVXWG5NNlFOVTZ6YWFLK3pGWUNm?=
 =?utf-8?B?bGMyaUs4UU4xd0ZHdDQvNTgwai9PTW53cjJoaHR4YmF2S0I3VVVRSGNUeG1V?=
 =?utf-8?B?ZEduZTZhUGVTUjR0NlJDa3R5NDllNkUxWXBWOWVjTnVMYnRrdzNMcnJIVXl5?=
 =?utf-8?B?VDdWdEpsd2lSZ0VIeTZIQitSaW45cGRHL1RSV3F3MkdneEUxdzN0N2hZR25U?=
 =?utf-8?B?Mmdyd05rSUZyaEM0TFZDaXcvOXltdndTZW5OTGlkbW9BWmdjN3Y1MWJlbW9J?=
 =?utf-8?B?T1ZxbDM3UTVxbTE4YjNpNVFiNkZkTzhlQ0J5ampCb1cydFNCNmZwZTNqb3ZK?=
 =?utf-8?B?WFcxbjg4c2ltZUJYUk5CYVowT0FwYTh2TjlaZkNKZ2d1a3RNeFVTSityYWFL?=
 =?utf-8?B?eW9ETHhYaWJyelh0VkZuK2Q3N29KejRNenVUcjBSVmJFdG5ML3BEN0NTTjgx?=
 =?utf-8?B?QTJhZFYyMXZvaXcxRENuMk90NkVWZzJEajZ6VUZpUXZSODVGbjF6Wkk2RWkv?=
 =?utf-8?B?UXk1bW5oay94Ty8xTFcrdENoUkR0c0hadTJ4ZWppdTBVWWtUYThydjBURjMy?=
 =?utf-8?B?TWxZQXZndVNJeGxHQUpkMG9CRFRwMEtRTTFXTnBDN1EySmVWd1k0NnVhMm0w?=
 =?utf-8?B?NXlrcU94aUVWREh6RGZSMFQzY0ZsTEwrR2wvZGtZNzFaWENzOXdkc2tweDhH?=
 =?utf-8?B?LzVjbCtjMEt1MzhHUnVmUjVqSGllTmRDUmJlSVJPOVllZGd5OWhQbmZrd3NY?=
 =?utf-8?B?OTZmMmYwOFlPcERwMXlMdmhLWU1Ub053NDFaSlFvKzhNOG5CQ0toVTF2SS8r?=
 =?utf-8?B?a0Jhbno5SFl2NlhEZ0d6NkVDdmljWi9lVDRYR1l5ZTNOK2lFaTd1ZFVVUE81?=
 =?utf-8?B?VjlVK3JvbXBPWTFhTHhmNTk2aU1YQWpJQXRibWl1YStDaFErdEdrZTlNc2Zs?=
 =?utf-8?B?aVNVUVYyUkJ4VXNZZ3dFRVkzK1pSR0xxRUtBaUtBdGFjV0NubVN6ZG1UL0xU?=
 =?utf-8?B?bFdxOHRGdTZFTno4MkpWdjZOQTNjQys0RUUzMzlPaTVad0VFMFFQZ2hMS0JB?=
 =?utf-8?B?SDNSeWwzTXNtNUYrc25VOFdnaGdWTU5CdUNERnRMMVNQaXcwZEs0Yy94UFRE?=
 =?utf-8?B?RmNLQ0FTZHoyL3dDNGhaRG9zMy9VV005ejBkMXZFNDRYWlhxcnE2Ti9iOXJr?=
 =?utf-8?B?M3lEdTU0UkFPY1lJQlJmWmgxMW5NbzAxcm03T0svdSt2RW9CZjN6RzRkeWxp?=
 =?utf-8?B?aTNScHdxaHFac29GVUwrTFhuTXEyMnMwd1djL1d4dDZHTTJaeGZhaEo3T2Ez?=
 =?utf-8?B?Zy9SNVNtRnZKK1F6K1JxNitJNHVmajhJdUtnRGRQMUtxKy9oRHBSelg1SXBJ?=
 =?utf-8?Q?GrcMQK7Y1iwk4ZPUun1o0hghXBCXYvKGDKd0va5moKiwg?=
X-MS-Exchange-AntiSpam-MessageData-1: ZNewjA4/AGYRjw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdaac71-f190-49d6-193a-08ded8ec9383
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:19:33.4486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yr0IZYdf3B6+mtCjwfMs4cmdZbwtxackJx9czJCwoxuPGbdVyGk1Vxg9f/t4LNdxwf34JJaaQ6S7x+q8MoyICQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326
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

Add support for contiguous area allocation. Add a new type,
`UnusedArea`, following the same pattern as `UnusedId`.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/id_pool.rs | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
index 384753fe0e44..b471bfd97487 100644
--- a/rust/kernel/id_pool.rs
+++ b/rust/kernel/id_pool.rs
@@ -4,6 +4,11 @@
 
 //! Rust API for an ID pool backed by a [`BitmapVec`].
 
+use core::{
+    num::NonZero,
+    ops::Range, //
+};
+
 use crate::alloc::{AllocError, Flags};
 use crate::bitmap::BitmapVec;
 
@@ -240,6 +245,33 @@ pub fn find_unused_id(&mut self, offset: usize) -> Option<UnusedId<'_>> {
     pub fn release_id(&mut self, id: usize) {
         self.map.clear_bit(id);
     }
+
+    /// Finds a contiguous area of `count` unused IDs at or after `offset`.
+    ///
+    /// `align_mask` must be `0` (no alignment) or one less than a power of two, in which case the
+    /// start of the returned area is a multiple of that power of two.
+    ///
+    /// Returns an [`UnusedArea`] upon success, or [`None`] if no such area could be found.
+    #[inline]
+    #[must_use]
+    pub fn find_unused_area(
+        &mut self,
+        offset: usize,
+        count: NonZero<usize>,
+        align_mask: usize,
+    ) -> Option<UnusedArea<'_>> {
+        let start = self.map.next_zero_area(offset, count.get(), align_mask)?;
+        Some(UnusedArea {
+            range: start..start + count.get(),
+            pool: self,
+        })
+    }
+
+    /// Releases a contiguous area of IDs.
+    #[inline]
+    pub fn release_area(&mut self, range: &Range<usize>) {
+        self.map.clear_area(range.start, range.len());
+    }
 }
 
 /// Represents an unused id in an [`IdPool`].
@@ -287,6 +319,42 @@ pub fn acquire(self) -> usize {
     }
 }
 
+/// Represents an unused, contiguous area of IDs in an [`IdPool`].
+///
+/// # Invariants
+///
+/// `range.start <= range.end <= pool.map.len()`.
+#[must_use = "the ID range is not reserved unless acquired"]
+pub struct UnusedArea<'pool> {
+    range: Range<usize>,
+    pool: &'pool mut IdPool,
+}
+
+impl<'pool> UnusedArea<'pool> {
+    /// Returns the unused ID range.
+    ///
+    /// Be aware that the area has not yet been acquired in the pool. The
+    /// [`acquire`] method must be called to prevent others from taking it.
+    ///
+    /// [`acquire`]: UnusedArea::acquire()
+    #[inline]
+    #[must_use]
+    pub fn range(&self) -> Range<usize> {
+        self.range.clone()
+    }
+
+    /// Acquires the area.
+    ///
+    /// Returns the now-reserved ID range.
+    #[inline]
+    pub fn acquire(self) -> Range<usize> {
+        let Self { range, pool } = self;
+        // By the type invariants, the range is within bounds.
+        pool.map.set_area(range.start, range.end - range.start);
+        range
+    }
+}
+
 impl Default for IdPool {
     #[inline]
     fn default() -> Self {

-- 
2.54.0

