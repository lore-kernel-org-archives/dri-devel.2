Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF9AC54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 06:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA75510EAAE;
	Wed, 29 Jul 2026 06:54:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sajtg46+";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013052.outbound.protection.outlook.com
 [40.93.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB0EC10EAAC
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 06:54:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NulzB2KDiTkOVt3zl5wH5rM5a8Gh90r9kR71N4OikK4t3jHfE4kDduhtuCcG2PCgg8RaEO0ccHplJtJSUmyjbuR8WEgkdLs0Gs6KDXRavueMHpuqUH/D6xoD+9qRu6tSuh7Ly2GLglhfKUfJ/gggiMj07vGSjDSNt8uCNwV0of1mJJFSd/oPQrIVbyReE1kH8UAT4fD/0rrwYBXd+fhgNBVaGkX22c0BgMDyVXCK+ETjvFLcu/FBwEOUi1lP5BMjuEXY/kP5OFEhcyxPZNE0/KXhFwIpcwI7MFJvZ1Tgdci99pYyAWFRlg1OsZJEzLm+NL8HWW7YDJEWdB8hwbnRpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBWa5tFnDAYid/53BtJQEhxB04OqYLxXPt1H44UHjD8=;
 b=DmIWbKxxyniXAxmW6sywwJEeLbZo359FClKfb5+rjhp2/lZYDS/Mrj1auIrjjPqvMpz2ck3rQ5X/HNunsZISVupLYZG+z9lNuCrHpTPdt+764nJ6UBt5dl+nBBrCllAk8qjP43z38o7pwifJVw7Yk0MBHXllrHmWzXcEenCrhVr0EZdkMuTFucba+dl1Y3xwGs9osZGGn8m3Dd+dnABB78RS1tVXHdcxyqJ7rBt1z80lbU2x38OPkSJbuFp1zBagJrETPxfzg4SOswjDzh4Yauvn962YuPOsHLDp4mtDeibYN5K4XyMztjzPCcJ9t1nNt2gDR+c+ciI1/h+e8BYTnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBWa5tFnDAYid/53BtJQEhxB04OqYLxXPt1H44UHjD8=;
 b=Sajtg46+MbD5KEqup0OvooWH7K36GmDhScjlUFped4agu6XxDztGX9BhxaYT3Xvxv1nB7u2TlxNrrsrF6hRx+NyziUW1V3JI8nUECBe+o4w31F/cO954dtykZ2QXD+VI6vy6TJJQeb0R5fgWAZJy35ecce3PRUoXCFD8dvw7gGAaZJ/bC+8m48MzHhAE5yqvrjr68zJRDKTXPLZnQhRsZwKT+CdnhrpEnPQrdIta3RBhl3c4vxoM7a0lYVSmtQFIHmPprXU2HxZJZ+dtVlSqlTaaxHZdXh7y/7Xzgg2ZR05YNQIFHHrOjWzrnn1PtjbXtPVKcT/XytggRVhSM16ZiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8894.namprd12.prod.outlook.com (2603:10b6:208:483::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 06:54:34 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 06:54:34 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 29 Jul 2026 15:54:14 +0900
Subject: [PATCH v3 3/4] rust: id_pool: add contiguous area allocation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-chid-v3-3-20cc08032bbc@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0129.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::10) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: 7161d0ed-2ba1-48d9-314b-08deed3e3fb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|10070799003|376014|23010399003|366016|56012099006|11063799006|10067099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: eSwWPQlIvbwm76840Zei+5qvqJTJmuZ6hIFKppx1ijrdOwaxsUtnyFDRuKQJdwlmTdR+GCYwFUOnHBnGVZ0gH7LGwAkhiRxP2/IfbvSRfiUPLHyIcHNkgMCgbM+2gCS3lJVV6caI+fzrbKhjX6uLJj8vterXXZ1sRfyi6G1aIqznzO+Yyuu+qir9kUGg2j61ZDr9X1UrzUhMZFPfjCRCeiXm8c4VpbbCNs3ALflNmBcn/MkTJZ/zdT8qJIfyY/tmW11A90a+/7ddxyKtCt5zsjB9ox9oCjczxBaa5kzoEwNPF0RtrqS27REhTpcaY1rSiVLR9DsJFRNlt6LUWiQ019y+uUAqXGlD/2vKWU2vOGvwo5D7iJcb4EiAxZMLAFxYaeV7CyBfGbzDKBCT33sK1VHWR+bNyL6yc19Q9+tdpTyJ+fsg8d6hXX31Uj1kV8LaSU3ybvJ7gBrEpOgPAc2VQfb6LV8e4aq9kREjr3nAy9ME3dN7R0Xf1sxs5Z59XOggnjIi5jGzzeRpYJEgppOmGGK37kUE7wg9TM7QfX0vL/vLaicURK5a4q7I9OKJsU5oGMZOOQR5Qw2IDlPhMuusMWWQNj+MhJ1lY4b8/Fl1pTqAJtpsH1G2iu8N9qrn0jck+Yq/eLi4ZM0EphgXc4N8Q2EhvN1dKNbMp2bEoOYQramq0nXKRX8DFnWjqvzj5/hxyuq5+iM4mcooxL3MEMbzwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(10070799003)(376014)(23010399003)(366016)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkI2eFNpeE8wTjIvNWJvL1VVczdyVXBtSHNTeXkzdS8vaEV3WmcybDNvTDN2?=
 =?utf-8?B?MTFBZ01KWUFMMVBpZjdwZGJiVGxVWFJuY25kbWFFSk5uM1k4OHhwcFBzc1Z0?=
 =?utf-8?B?S2JEVmJFMnMyUlBucFk4QVJlYzVUVjJ1T3E2Y0VnRFkxbjlHMVFYclQ0Zlkv?=
 =?utf-8?B?U1I1QVBuN3VhVmdMcWtGd2o0QnpwN2ZnTFRSNjhxWWtneHF3UXdPcUQ1SENH?=
 =?utf-8?B?S3lCWnVrTU00Rm5ES0xlamVuVFd4elVqWWRCVkJ6a2tDZmx1S2VDUjZOWFAy?=
 =?utf-8?B?QnIwMU5qSld5Nm81WWczbGZXQmMwbTNHTWZ1b2RQaTIyZlUwbjNVQ1JHMTc3?=
 =?utf-8?B?dzhiejRqOVcwV1RaUFNQUlc1SkhHUDV5dW0wUmRzQjZUb0NHQWJkK2FhdVp3?=
 =?utf-8?B?WmttclA5Nlk4RWljZFpDTlZqTjMrR3dRUkRsNi9ieXNobnBJRjNHMGRQOW9G?=
 =?utf-8?B?R3BFR2FoVHhEaURLTjlYalFYdHp5UnJGVmpkQnlVOXNMQ1hoMzBYL01NdGwv?=
 =?utf-8?B?OGFhTm5Dd2EvSjRBb3c5dVNlZG56ZmlaODM3a1htUUlIWTIrWnBmUE1ZbU01?=
 =?utf-8?B?Z2dTVVJJYSswcFNnMXhvSHdjNFZCRmZ5S2UzQ2RGVHVkV3doOUtSc0l2Ymdx?=
 =?utf-8?B?azY5WW1VcjE1THE1VExtRGhxbUNCTmtVeVFIdXg4cHc2cHVQWUR3MHY1Umcw?=
 =?utf-8?B?UjBTQ1FvL1h2QlRkZE1sYjFTQ0hDbG9OQytaYlR6UE4zb1VJTGVXc1RrN3RN?=
 =?utf-8?B?by9MZ2s3UGdyNTBaY0hvbXp5YUFQNkQzdk03bEl4T0lwR1MvYUR0ZzE2Y3dQ?=
 =?utf-8?B?VEc5K0xyT3pFamZMcm5iZGJRWDRkUmtpL2Y2SEFFbGE3NDQzb2wvVUVVRGlT?=
 =?utf-8?B?c0QwUVgxaGtPbTYxenNQeTNCb3MyUCtabFhMeTR6cDhJdmgrZndjTkF6eVdW?=
 =?utf-8?B?aGhjazlIS3IycThsZUQ2MDM2UDhTWHJOZ1RIR1dnb1FNREhiUlpabGNjNDZ6?=
 =?utf-8?B?TTQyblZRRk55TGRyZzJEZHhPNFV5dnZlRjQvVFErWWdZRnNIRnVLTHlqWjNM?=
 =?utf-8?B?OEg0U2FHYnJHYm5RODJyelhiNXNuT3pYR05HRGJ4amlhT0JycHRzcytDdU9W?=
 =?utf-8?B?OEt4cy9jYmJKZ09VeHh6VWN1ajY0OXZrK2lWcmZFblFCSkxMOXd1NlJ5MlFj?=
 =?utf-8?B?aWZGSElnTlJtSldTWG5jWCtZdGtVZ3FXazNpbk5BSFFXckJQTzFIcEhXVENO?=
 =?utf-8?B?NXBpbVFHOHBScVIyRUxuR0JNK2pvZGsxUlJaSzQvYkFuOUVQTXBNMlp6Yi9w?=
 =?utf-8?B?VU9DMDMzSWRLMmptZkhwMDRySmFqbml5MWthamdwK2hWZTN6YUI5bWI3bmNV?=
 =?utf-8?B?a3B6WTY1MXdZeFl5MDVxQnk3K0IxVXNJejM0ZXVoK3lZV2pVU05pSXV0ekRX?=
 =?utf-8?B?M3A3VFcxbXN6dDBqUG5IWXlpa1NUK3NzL0NTVWJmb3Jjd2RRdVgwd1FyLzgw?=
 =?utf-8?B?dWRPdkJRMzIvZmlkVmozWklNQ1J4dEIvOFBKSjJJdndsNU9jZytpY0ZTOXJL?=
 =?utf-8?B?eW9qMm4ydS8rYVU3QmpQdEcxcmtlUVJFZi9LUmh5YlBSTVcrS29BSWpFVmVi?=
 =?utf-8?B?ZDB4WXdkZ1dzaVEySERzdWhjUXAyNndQOGQ0WTlVZnpNbmx3d3FsaDluY3lq?=
 =?utf-8?B?TjdPeXVnUnNiOGgvNkEvRnhRZmc5K25ReEJ1SWxiN0FUQVo2MzZtZEVsWTNr?=
 =?utf-8?B?T0J6bzZKZ3FhSld2QnBLQ1hITUNEdHMvT1B5UTRkdGNLcFNxK24wRFJrRFhD?=
 =?utf-8?B?Y0RHaTRoNmdxc0swRlZIaVpKU0cxNkxQK2hLN1czSHE5WXRLRU9naVFSRW9p?=
 =?utf-8?B?R0pWbHFKZU00ZUZjY0hkVS9keDNNVEE2SHZaaVVROG4zMHNDVmU3b3g0bUph?=
 =?utf-8?B?WkRjRmZnMVpiN1BEbUlCd0tXMzJUeWJNZE4zLzNTY1BnZlM3YVBCeWdrSXdY?=
 =?utf-8?B?TmpvSUxMWGJGaTRHVVozV1phN1p3emhsMG1QNjd5WDFUMy9ZZ2JJZ0VjWGVs?=
 =?utf-8?B?WnhGYTdRelFkdmIzMjRJVXh2OWExUWM0L29RVytGc201eG5OaWxkQWEvcTUv?=
 =?utf-8?B?eWtXUklRVnlId3pnR25ncGVmamt0ZGo0cHpuUmhuWFg4Z0tRTEp0dUs4c1dN?=
 =?utf-8?B?eHVTQzgxcERSYm1vYWxLTEFiSktOZWg5MTNGOFdsWjJmNElOVnZtdm55VWVE?=
 =?utf-8?B?czUvVlNJbmlEN1dJcFgyeHkxQnVWbUZyZkpYZ0pUZnNGbCtGRHpBY0pjNWt0?=
 =?utf-8?B?M1p4dThWK3FDYnYxNzJwK0kwMFBRWFlObmlpTU15ZDJMZDNIMkpvejdJVE5i?=
 =?utf-8?Q?EIrCkL8EjONH/MCfue3zZTsHowiwaej8TxnRB8+45kSo9?=
X-MS-Exchange-AntiSpam-MessageData-1: zbBM/WUOgdg/iQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7161d0ed-2ba1-48d9-314b-08deed3e3fb4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 06:54:34.6832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sR7+92Qd1bTSTIMb3YzHvBux415+RAYXDrJ505TMDs/UAyn4G7QQwJPy0Qp4obMROLbw9LQ51P8XiKJ5b9cDOQ==
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

