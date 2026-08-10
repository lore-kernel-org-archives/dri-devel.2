Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD4CC5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 08:36:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7834C10E71A;
	Mon, 10 Aug 2026 08:36:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="dSB9DiRj";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011058.outbound.protection.outlook.com
 [40.93.194.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F5DB10E720
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 08:35:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQdd3XuIMP1U2EvN5jnZQ64MjakGx/E1tpED1hzJtjRNpDjji+Na/Z+s/1MUVxkEkJdQRvtiIgpSZK7WXqMHaAcwbf0kfXfjcm26NFF0+h1OwlogbAX+6je/S6LI41FX3pDNqBbTzXQVuY3eWEfrSAmC/1xyK1Xmx2GI4aFYamd7NPTBJHxfLygCDwm3/Q2I1hJ7vJ9PpfzsfkibEJWk7FoRRwrIH2v9J7NeBiyGkEaBkVz4/qGCJ1bqipnpz+6AvP0WyS8YA8NBRh0Ynn8AMHrclC52DaSivh6awpv0VBAgw0OyKaURo8xcAVl7Zl53QKCVCPmh4srLc34osGzvqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBWa5tFnDAYid/53BtJQEhxB04OqYLxXPt1H44UHjD8=;
 b=YT2PFkfYG8nkYeUH3NZLvVbc3n7NgzVM1/trZIdvk7K99ye2QAeoyTCxNRNzY1MBKwb/88iUzQhGUn8fG/nHK9mJHHkk2aNkYr5J1QfyiaKGDglug3YyBf+wt4+zA/3/0VRe82pSBsRuz3prGHEvkZbx3RnFNjCsSADVT0y0V+zhU0lxoDm3vNmMJsuwtdTO+5sK+rCIm20z0oXoM9C+hf5BX4Q02cB/NAB8KlteGfqVaNoAzojHRRksPDou9XqfYlKpkFPVb+nVHdGd7HH5awPXsi1uZyFnrxrTPx9VNWfcbN9cc921MEp0s4GyBSYOQp4bURW8Ffj4BWGoWxw7Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBWa5tFnDAYid/53BtJQEhxB04OqYLxXPt1H44UHjD8=;
 b=dSB9DiRjcMAcFC0emLQGEeW9vGYzbMipwzxweZXWa3qEIt+7DMGd9JJPrXskhK+Gx9nXu8BVqdK2fHav/CVYGc1vGLhWB8nC870JX6edHwvAh0AxEH35dOqj0N6fs8ksiwcUy/i5A6Yx3ux6vQik/EI24FcJlH1bC5ooNX1V2CocMivjhhKaO5gXMg2qlXdbFiEeKiY9a74w9o8C8Hn05OzqjmQaG2ILihN6I593iQ3bn7dUY2mx6nKphmJTcQrRFKxED0ruHrw6bLMFkdMn9VlyPqVwEJfuqdew//cdOpfA4XFNl2H+7PifApYruQ94O2G/E47ygvGIXqz5PDsvlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY5PR12MB6036.namprd12.prod.outlook.com (2603:10b6:930:2c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 08:35:53 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 08:35:53 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 10 Aug 2026 17:34:12 +0900
Subject: [PATCH v4 4/5] rust: id_pool: add contiguous area allocation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-chid-v4-4-c9f206fdcb97@nvidia.com>
References: <20260810-chid-v4-0-c9f206fdcb97@nvidia.com>
In-Reply-To: <20260810-chid-v4-0-c9f206fdcb97@nvidia.com>
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
X-ClientProxiedBy: DU7P195CA0005.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::24) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY5PR12MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a7f126-966b-4342-e99f-08def6ba63fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|10070799003|366016|18002099003|22082099003|11063799006|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: lDJ0E91NHVmuCf9ZjkSI1NCIjEpUTZS+IRVHlh14I+SvcZhEGVUErqkEVqxPFm9PLdon0NAlln02dcvLCVIuxhkvUJr+6DFZ7kmmINpvHTeuOUfIQ2zw8Kn2vwwiSV2LUbP1ezKjEm09RjAhHQrXx/3Vh6VeK5GO1w/ewyV3q/ZXqYhBmBl++JUVo94KvIn4+RSoIVi/wEsseAQT/k2VNBuaAJIuFcMYBM6HQvzjQRwHRuAm2xP36NI19qhLL1qoB3d49Pdv5MXy3o0lxuSkly84PJZaudJSF2USBj9B9fuKWlwnIJWFyWS53QNef2iR5qwezsJ56zoCDI5/QdZaFQGjCHFCAFCnHgIZisGaxW7k4XEFHpY0dkGEJbAdwr/yqxtQPZLE5sudyZeKxmXPrc+NOr00H6H+GBgIMQ9JlW4DlU8C3yUXG+UI64PK7sDtR5LS3G8Sktdq2CiDa1QOzNs+fDs9hj0z4wSW5LKlnV4SAPlgfrIY2wv1C+yi4IRtXbXrbptAr0MQO98Xl8OvXAcsrERMpMacOxVA6NOKyrpdJOVpqB2YWnnrl7bm8xIlDIY6fpKC/9DVehFN3mW4Qp7QNKBZTTruGGy7MmtrHzTPKyuuSGkSmcrMrpWmAn7Ov3F1PdyBPHh7O2rCWkflbZOrQJSimNBPvH3A9susTWLY94bJSucUToIdqshlqUnuxfQ91Vu5VgmBG8nnon8AeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(10070799003)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDRsN3NoL0xkQU9WOS9TUWpmdm4rOFVDVGRXMG01VnNuajNHZ1g0R0I0d2ti?=
 =?utf-8?B?MEtHazJJZTlOTnMvQ2xNOUxnM3pFVXNoZEw2d0hyYUtmcml1VXkzMUVrd1ox?=
 =?utf-8?B?YkNBeWFCUnRPWTdqS1gzc09KNjlOL281TTZmd25ObE1mbm1QclNwSWxyUmIy?=
 =?utf-8?B?VStoRWxtMTRoUG5rbjZpdkpsMUNRWWl5UEFrTFlucS9TZzFHZ055RmdoVTR1?=
 =?utf-8?B?VDYzVjU3dVFMaVRrN3d6a0RxWGRkNnRXNXRFU3pyR291dnBvWTF5Mk9DNUlG?=
 =?utf-8?B?c2JkTmFGbmVNbyt1cHBhOUZMSHZCSXRrbEUwaFNVSE56ODZvVzh5ZmV0YWdw?=
 =?utf-8?B?RXNzS1BwYUhNeHY5MElMSndpQ0lxdkpvTnhyZkJpU0hMeUl0T28vSlFkRlQ0?=
 =?utf-8?B?bnhjT3l0d1BFUmk1YVdOWmFpVHpMaGFuSjhKT3d6T2NqRGwxSXd0YzBpeDhU?=
 =?utf-8?B?cEFYTUNYdkw1V1hGRG13U3dRa1oyZS9jejZBWC9taFRMZ09idk5qNDZmRGo0?=
 =?utf-8?B?bEFLR0VsTE0rSU0vdGdmdGlIa2ZaMTZrV2duNkE4T2pRYVdIZTJvVUQyUlhz?=
 =?utf-8?B?aVZaaXc0Y0dScXA4RER2S1JXNzc2WCtSeWRsUUVvVzVqNm9BWjV6OVRpV0pH?=
 =?utf-8?B?Ly9TZVRCaEV1Z2MrZk1Fck5LY0xUK0RndXJPV0Z2a0xKQ2l0d0xVcUZ0Snl1?=
 =?utf-8?B?QkhvV1ZQNkJuT2RTLzRldm5XTzU5d29ETDc5S2tJQUdUUTM0MCtqLzArTkFC?=
 =?utf-8?B?ZTlWaTVzVit1RUVqS0hpRGVDa3RNbUwwbFFJdFB5Vm9IanNudmU1Y3dBemQ0?=
 =?utf-8?B?RldhQis4TTI4VWp6WHYvbHdGMnpjUkJ0amZoaXM3MTAxazNNc2FQRGpIM2RQ?=
 =?utf-8?B?VnpoOG5tTVUxTTE1RStUblFnMjRLMkhteVE0M0l4cUdZVXhaSXhKQjJraXFo?=
 =?utf-8?B?c0Nkdk1RMnFFZHpzZ2NoeGtGVW9DQms0aThMYkdTSjlmM2hRZnFrK05UWU5k?=
 =?utf-8?B?ZnZjY0xPT05nMGE0UHp3S2VYRFdsMi9NZmVEdnlNWngweE1xeE9xZk5SR3hY?=
 =?utf-8?B?NG5xT1c0K0xTLzJKbTM1dW1DNVB0L0dMYjh2YW4zUVhtaWpGdjVkSmNtY0Zy?=
 =?utf-8?B?d3lzQTg0ZFc3MklWQy9Vai9RbGVQRUZMc3lFbVZWQVR4RUxTQkNNWEZKYmVO?=
 =?utf-8?B?OVoxNTJsMDhHdHoyYmg5NUxiNEQ5bVhMbjNLRndDSjAxNm5QRW1Dam0xTUJx?=
 =?utf-8?B?blQ4cm5wekdGSUY0UXYwQ25naUdabHMybTV2c2tsek5jdjl2eUZORytnSUx2?=
 =?utf-8?B?UDRFT0FGWFFzbkU4ZVQ4K0d3dEtnb2lzekhGWXEwc3M0Q01hTTU1ZG82NStD?=
 =?utf-8?B?V2JKcEJJSmgyVnhDN3MxcXRabHgzWlF6WGx1NHR1MHdoUDRsMk13ekJLbkhV?=
 =?utf-8?B?UWpOUE5TaVZNMzM2Y3hGTXgwSXVqUHc1MXNkeWtGQ3U5ZEVHeXBWQmNlLzhu?=
 =?utf-8?B?dCtqYVJ4bjQ5Qm11Zmx1OXBhYXljRTZqaVRadExZeUhRaCs0SU16M2tLdDdE?=
 =?utf-8?B?MWNnVkMzTzY1ZnNsOFRuaStHZ24xT01NL1FqTVFYQnNFT2lxb3d3ekNpZTgw?=
 =?utf-8?B?cEVqMitRR1pGUHlEZlplTjFlZy9sdVdCNzNoRDNQY3ZqSkJCYTBDR0YyL1dl?=
 =?utf-8?B?TWhtSXBVUytUV2lQWkxURjI5c3FaeUloNzdsUlIxZVF4SFZybDNqUnJtamdE?=
 =?utf-8?B?MnZjOWdpSDB0V2ord2dTeDU5OWZ1a3VGRWFTaURDRWR2R29oaEN3aVdQVkVp?=
 =?utf-8?B?YTQyR1g5TlFBVVU1bjhkbzZkNi93TlFFV25qOU5WTnQ0eFNQdURiSFNDaWFL?=
 =?utf-8?B?TlVFRlBYQWVpU1pvaSt6ODdLMmJDa3RYcGRhSERuM2Q2Y0YzcGxEZEdKaTNG?=
 =?utf-8?B?OUZwS0RuK1ZvaGt6QXVwTEsxRTBySXVMZjh6d0VDV1JmNGlTZnJnMnhwT3dY?=
 =?utf-8?B?aEN0L1dhNWZaZFhrdWh1R1BLY3dXd0NLd3IwTS9EZjQwR09hbHRpaDV0Y0Zq?=
 =?utf-8?B?UUM3N1BMU0p6cFJRRVBEODN1bWxUMWIwb3RYYm5xYkM0UWYwSUhNRUtkYU50?=
 =?utf-8?B?Z2pNU1BLU3pGYVpzT01xMlJwcGRQVFNIWVNOYWFaTWlEMlJ6dEVDc0tXb2d5?=
 =?utf-8?B?QVR4cWZ3RTkyRzhFanRqTEk2aUlnV29yaWZXU01zTFk0QWJwSEZHaWl1NWZy?=
 =?utf-8?B?SXBESmRKK1Q5OExTMEIzS0RNUUk1SzZNVUJ4aHhNZFQyYVNyRjNtVXNRM2tq?=
 =?utf-8?B?d1VMbDRXVnJubEwxaDhReTAwY1U4eVpQRE9NWTNzMjFNUlJJajlkQk0yb0ZG?=
 =?utf-8?Q?RfrwMWLTlSfhdtL6j+9DXaZZQ37jtIVHD5VpRkiVPPu0y?=
X-MS-Exchange-AntiSpam-MessageData-1: uIs5rj6HTcE6Tg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a7f126-966b-4342-e99f-08def6ba63fa
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 08:35:53.8143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVnM94s3DsMXddvGULexX8KtsImRGbpOni0RHX/jiVIZ5rXdC6eRdlMF6oTxasPdfVbgl/2azTKYJY3JJStWwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6036
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
 rust/kernel/id_pool.rs | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
index 384753fe0e44..eb911a0e3217 100644
--- a/rust/kernel/id_pool.rs
+++ b/rust/kernel/id_pool.rs
@@ -4,8 +4,14 @@
 
 //! Rust API for an ID pool backed by a [`BitmapVec`].
 
+use core::{
+    num::NonZero,
+    ops::Range, //
+};
+
 use crate::alloc::{AllocError, Flags};
 use crate::bitmap::BitmapVec;
+use crate::ptr::Alignment;
 
 /// Represents a dynamic ID pool backed by a [`BitmapVec`].
 ///
@@ -240,6 +246,33 @@ pub fn find_unused_id(&mut self, offset: usize) -> Option<UnusedId<'_>> {
     pub fn release_id(&mut self, id: usize) {
         self.map.clear_bit(id);
     }
+
+    /// Finds a contiguous area of `count` unused IDs at or after `offset`.
+    ///
+    /// The start of the returned area is a multiple of `align`.
+    ///
+    /// Returns an [`UnusedArea`] upon success, or [`None`] if no such area could be found.
+    #[inline]
+    #[must_use]
+    pub fn find_unused_area(
+        &mut self,
+        offset: usize,
+        count: NonZero<usize>,
+        align: Alignment,
+    ) -> Option<UnusedArea<'_>> {
+        let start = self.map.next_zero_area(offset, count.get(), align)?;
+        // INVARIANT: `next_zero_area()` returns None or a start with `start + count <= map.len()`.
+        Some(UnusedArea {
+            range: start..start + count.get(),
+            pool: self,
+        })
+    }
+
+    /// Releases a contiguous area of IDs.
+    #[inline]
+    pub fn release_area(&mut self, range: &Range<usize>) {
+        self.map.clear(range.start, range.len());
+    }
 }
 
 /// Represents an unused id in an [`IdPool`].
@@ -287,6 +320,42 @@ pub fn acquire(self) -> usize {
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
+        pool.map.set(range.start, range.end - range.start);
+        range
+    }
+}
+
 impl Default for IdPool {
     #[inline]
     fn default() -> Self {

-- 
2.55.0

