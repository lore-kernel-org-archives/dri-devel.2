Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCDEC5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCDFF10F1AC;
	Thu, 13 Aug 2026 07:36:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="difAvkQG";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013013.outbound.protection.outlook.com
 [40.93.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B86910F190
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:36:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/E51EBidgyaR5KcDxNfc4yydvvuxmvgF9AfK8LKW634E0lce21Dfr5ixealuHJjeF/4vf5Zl1QSq3Gq5EmSBfmB+eHwDfvXYyP0YlA+OHWm5Lm7A5C+V1HFqqKR+Lfe13CRTarWx6HGqn3w3xPSQCiuGio3Vy2irg88AlrOFNpm+ReysHGPsPU7tXhmGYTMGwGPctl4gtgNouQzt3+lNZWhbRrJjFQTwGQxMiy/gqwuh/XW1IY86PATQlJYiOk8wzzJ8ImhUblGmNpYFPZHEwY5fV0N9BoCZfU6Aw2s31vyh4OVzL7xCKzqvnMEzsiBii3jghLWKInnr7s2YkGbbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcuL91YNNUq7PGNcccZl35Zz3QclHMNw75J3tKZXRNs=;
 b=S/m1o7PzNRwqcwXyr4EKmFEkeo6SqBq9MZKE34d7/QqEEGvTRt16m0NI75x0zL3rLEXSyHUOk4YBStMiGhn6Xy2DwbGRe31WU2/tKqmitzZoBwJIUPE48Cf58boWqu5T49gy7K7s78wpSHzLWQbIgmiTPRC0elhU97tRD16g5sXdyDEvWlKGDbRoMdCaqAqi0c/vhBQp/nRqa4oAsjBoaoqOMYpJ9tAdfnrBltfrttaHeKXxCZE87IzAnPAk0jDjh8IhWCRiA85ZF7CpswOyh6gSFtSltTC7W0sncXcG77MquBFtvQSNL1kIY0yG1PRPZAXdMnvd3CLNvu3TnmnqnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcuL91YNNUq7PGNcccZl35Zz3QclHMNw75J3tKZXRNs=;
 b=difAvkQGDMo8PUkK6jeaFdDkEP0GgHWVRwED42Ido+qyiBXzME94gAN37hx+7B2Ro0DPdfB2sm5i5gfBOEVDzFx8F8xa6LPX2dktxLRULyxkpjPuxxYSNsTus4BhqAxj44Vr8jzKTp6LRxQ9tPyWECdkiSsH5iWpQbEsRZEnEuLFGjaxzlC+55ObfqVC2Sg77m7+RpJu6kXi4jh+rUbZusuSxRKRSgHzTiqHgFs+9JjCfHuijnZ1O9oVDPEdf63YXNY20HQhqRP/b8wcMU5tdgzDgvobNODb6+h/SEpMA/CIca+Su9zKTmP03rBUT/MPtCUH6geFAZ1ZUY2tNkDetQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SAVPR12MB999144.namprd12.prod.outlook.com (2603:10b6:806:4e6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 07:34:51 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 07:34:51 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 13 Aug 2026 16:34:28 +0900
Subject: [PATCH v6 4/7] rust: id_pool: add contiguous area allocation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-chid-v6-4-160be5dfb5bd@nvidia.com>
References: <20260813-chid-v6-0-160be5dfb5bd@nvidia.com>
In-Reply-To: <20260813-chid-v6-0-160be5dfb5bd@nvidia.com>
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
X-ClientProxiedBy: TY6P301CA0021.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::11) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SAVPR12MB999144:EE_
X-MS-Office365-Filtering-Correlation-Id: b498e0c6-7ffb-403a-506e-08def90d5c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|10070799003|366016|1800799024|921020|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Bx463hgjRFDeyQA7T5SXYdoQXihrrbNQAa3jLkFKjXpgSjCcf/+nlk2AaJWGjaH5/C6fQ+qvNFT/n4/AZrc1QQDeL2XT8SLTMXtt5hqVK9L2ZJXX091gkOYcC0YP1oXn4cm2FVNV1V3k5lOjdwsFHzuCgywHxeZw4hgsH1no6UcS+8Jv+4PL56bGpnWDWz7Nr3ros9rS/cFJrnMotkRi2SB026DHtAjUHx5YP6BEexbQlGAXhFUzDqRzkJpJwuNfIm0ArlaSXSbchuXDoEDp5yoHUCegHR4atFFvyUWqpkrTQcP3WwYgGfni/W+fBlpMsuZuV82MUo5sRkA5MKiYv8WQAQVVZPmVdLrTOdMbCyXa5c4T402TMgnzt8g3aBQgnmtUXMVl3X8CxaPu1Do78igtVB6NGo8VTEDDI0KkPphhRhJYmB91MwpIBKHp6t0htgF1zOzOsuQhZJ7h00YTEALqxRKSAbWxBUkXFwXgYEMpsWTjqaDCRkIu7b3d0LXJ8e+lUFzD6zlv/LJZIK07C2eQrfdaJ7dSQhKSJYiWYeIvYooHp+8PbOUyr7EKsybBNBMja7mS2I1Pc6LTEbQNyHz66vRYSw+UFfHivo4gCU4XIPFXgKnt5EjEU2jBmBWmEy9jWdkeLpT9QcyLNloSJlI0tgHesYGyvsT+gMqI0N53M2Z6uqTT3gXqabjgr1jDkcKMSO+DuxYVEHFCsN7nsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(366016)(1800799024)(921020)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGhLN3V2MDFRMThsZWhKUVcwYXNZUGRFemZVckNnYkdrY01vWlJybXU2OExE?=
 =?utf-8?B?d2JlRnFkNGVBSlFLMEVyOWhRbnlKMVNQNWVQaERHSFNjdHR5emEvUTFjYklQ?=
 =?utf-8?B?WEtmL296cnM5QmRkQzhnQnE2bHVwSnhvbjBrVE80TDZsU3hkWnNua3JXK3pk?=
 =?utf-8?B?YkthWW9DWGdtVTNZL1ZjMlZqemxnRlZTZXlQRlA1UU1SYkQ3OHF0Z1liQ2pu?=
 =?utf-8?B?V2hTMSs5bWFYQUlodDVydm9aWTF1OEZqemExN1lVSFNhT2tnYTJsdFYyZnlR?=
 =?utf-8?B?SWtLNnlEb0pvTVR6SkhZTkMwaFNPcEJTTHVBazQyejQ2amxlUDNOcVV1ZmNo?=
 =?utf-8?B?NnFWQUYvbkl2NldlYlVZNytybFJldnVWeEVlSGkvamdXbmxzZmhHWG9jYWhF?=
 =?utf-8?B?S2ZEaDI2cDR6SUZIRHY5RWZncUVsUmJzYTA4SytYaEUrdmxwU3J1NXh3Ykk2?=
 =?utf-8?B?MTVtZExwc21YME1FR1hpTitTQjc3Z21mUWlOb2NKcC9sbWdNcUF5MWR1ZW5L?=
 =?utf-8?B?bmhmZllLU1hkVmJBN0sxbnp1RTY3UlVXZVpORWNjZFJqYXF0TTRmMStNZDFs?=
 =?utf-8?B?RWlubmZHb1RRK2dqWitENitKNXNyS1hvaUVLc0RJQjFXZk1CTkU4VTNYTDFZ?=
 =?utf-8?B?eFhoOTVYV1krdWRhL3ZQcnFhUHlMMnZCVXZSRk5za1czTFNramoxQnljVlN2?=
 =?utf-8?B?elhQTURzZlVHTHh0ekV0WUFhSXZLSjV4VkdwZXF1N3hQaTY2bWxTMUtQWUNz?=
 =?utf-8?B?cDJrYTVlUUtTUVVrOUVDMGE0TnFMczJraGVDTWdYbFJXZlROazFoOVVQbGxR?=
 =?utf-8?B?djhDL0o1Mks4SXJTV2tpem9Nb09uUS9ONHFGWS9OenRFTzNYMGdMU041TXo4?=
 =?utf-8?B?SHhjQkhlM1AzaGhNMDgxODB6aTgwaGo0dmgvdnV3eTFUWGI5aHpDUmtqTVhS?=
 =?utf-8?B?RWIvTnJQZ2RYeXBlZjk2UzB6SkJ3SEhLc056N25MWEFGZDQ0SWFlMjZXSEdn?=
 =?utf-8?B?bURwNXB3TkN2WG1Ed05LMnFZMnRWZGFwdkV3K0lrbE04TFpGaFdxRUUxa1NJ?=
 =?utf-8?B?QmdFUG5hLzdKWVlQaTU2c29NTDVnWjRUN1BLejlXTXIyTkVyRE1HTDJVRlpt?=
 =?utf-8?B?QjZlSWJIeGV6T0QvQnZVUDdmOTBlV01FSUxjaGpIY3QvdHdWaWdkQ25tVnpH?=
 =?utf-8?B?VGtEVHNveWM0RjFMVFdQK0twa0NMYlJyVHFXWTR6Z2JEMnFCSjFNbUdNVnd2?=
 =?utf-8?B?MDhINjNVb2NrdUdIOU5aOERxMVVIUllKVEhzM3pUK1h3SG9OMUtNYi9jU2NY?=
 =?utf-8?B?eW9DVVMvbEJSd0hmdTVLeWIzRFRaWit1bGo3dnVUVFMyZGtjeHU4MDhlYWpT?=
 =?utf-8?B?bDViTWY5ZHJQN2tFR1VWUjdIM1lyVy9lN3dNOUtjbTZSZlBuNlVPTE4ySlVE?=
 =?utf-8?B?aFhHU3ByRng1SC9SK2g2S3podm80ZEhqZWM4MFdVdzN4OVVQYXZYazhvdkRz?=
 =?utf-8?B?QndWTi80c3BxMG45ZVhpdnA1akFxbUkwbUJzNjNVamxWUW9yYVgvVDZRRy9q?=
 =?utf-8?B?OE9iREt0NXVrK1lIdEVNdUdlQXVNSGZZR0M3cEdmN3hySjRMV1RRQmlrUmVI?=
 =?utf-8?B?RmMwZFFTVjI1YUNwZ1greVB0L0Z6NlAvWllJWWswR2ZYckNWamUwZ2l2NkMy?=
 =?utf-8?B?M1prb1NOUXpKa09wdnRYUU4zSkFSWks1QW9La0N0QzdPdjlUYUthcUwzNjB4?=
 =?utf-8?B?NW1ZTFM0bFc3eW4vZjByaFdkZlZJSkplVDdoNnRXMzkrN3IwVVplQ2ttWFkv?=
 =?utf-8?B?MlZUaTFNRFBQY3F3VWJja3RaQkx2eUlyaGlUVFM0Mlk2TmVENjlvRDlpckc4?=
 =?utf-8?B?NVY1bi9BanlvM3p6ZzdYcUVaYWZMamZkWlpPQkJjSkZpdkdXR2xicHFBM1JM?=
 =?utf-8?B?SkNnYmw5ZTNhUVAwTURMQVdQeUUrSUducDZYdkQ0Rk9JZmNpa2o3cEdaajh6?=
 =?utf-8?B?QWlsYmQwblVMQUxWRTFSektPQTNlelNZRHNLRDFVZW1iVldMOXdaRUdmVm9V?=
 =?utf-8?B?LzQxV2x1cVBwQ3FueTZwdnNxekFwV21rSGxFSFRsRWF5dXUxN1NvWVYvcjdW?=
 =?utf-8?B?NmpTTUhRdUErKzJHT3llejJSWlUvdWxkeS9LQVdzZFROaXdYN3lOM3F0d0FN?=
 =?utf-8?B?N0NMb1hVTGxjZnpyODNadldIUVh1cjdBL3FJcW1iMEJhckFDT1pLTXZpQ1BI?=
 =?utf-8?B?clg2V0x3Mnh6K252bCtIVkkxTlNIWUIranc2d2QrZ29nZmJiTGhwR3o2ek5F?=
 =?utf-8?B?SWxzTjQyVmVnYjlRSVlkOEEvT1NneTVKTHE0YlZCSGRlU0lmNk5yWExYdUQ5?=
 =?utf-8?Q?jQQWysMxeiN0jPcFFhkUhC3b/WS9FFSm9by5sxsxwvoL+?=
X-MS-Exchange-AntiSpam-MessageData-1: qTFB/Kjd6uqwhg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b498e0c6-7ffb-403a-506e-08def90d5c8b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 07:34:51.7038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7otNnP6B4ABk2X0jY/95Y1rXR/BIxSmqS9vw6YAE3fWA1awgnGfP+RaW9Paj2yCDRpabh/udcTQ9pcHyE7BkBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999144
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

Add `IdPool::alloc_area` which allocates a contiguous area with the
given offset, count, and alignment.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/id_pool.rs | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
index 384753fe0e44..a4a2ff417fe8 100644
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
@@ -240,6 +246,32 @@ pub fn find_unused_id(&mut self, offset: usize) -> Option<UnusedId<'_>> {
     pub fn release_id(&mut self, id: usize) {
         self.map.clear_bit(id);
     }
+
+    /// Allocates a contiguous area of `count` IDs at or after `offset`.
+    ///
+    /// The start of the returned area is a multiple of `align`.
+    ///
+    /// Returns the allocated range upon success, or [`None`] if no such area could be found.
+    #[inline]
+    #[must_use]
+    pub fn alloc_area(
+        &mut self,
+        offset: usize,
+        count: NonZero<usize>,
+        align: Alignment,
+    ) -> Option<Range<usize>> {
+        let start = self.map.next_zero_area(offset, count, align)?;
+        self.map.set(start, count);
+        Some(start..start + count.get())
+    }
+
+    /// Releases a contiguous area of IDs.
+    #[inline]
+    pub fn release_area(&mut self, range: &Range<usize>) {
+        if let Some(nbits) = NonZero::new(range.len()) {
+            self.map.clear(range.start, nbits);
+        }
+    }
 }
 
 /// Represents an unused id in an [`IdPool`].

-- 
2.55.0

