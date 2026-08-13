Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BAEC5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5895E10F1C4;
	Thu, 13 Aug 2026 07:34:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lo1Yac3b";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C88FD10F1C0
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:34:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgd2S7obbW0PIwYV4C5NPnXjfk/7hMLubRXt6WH8moT28hR6yjIJWovA6aUFDeZxGh3N/nM7MeC66of0e40hnGxe8zKCHTP50frwI1ezl7wG6pDgCZKPNftwBpb21uO9x1a5ZtEQSQgxNr7IyzMvz7GeOD4AIZyH0olk2qLi0gfXJ/xR3NOXyIt+gjdxRyLTHkyZ5GOn2hrPK5IywbZ+zaWS+Pp1zO3FmObWj8jQtc98l/mylsiSyM96boTDYgoeMoIlQwk+prvNRpthBDLEcTi2eLhAkJQjwXYLBlCq0ahWSCobPV4go3GV0eu56+VP4AfQ+j3CQ6VTT5Ok/Vo1PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAoe+PMq+mGEPRPGNJpMYmVzM3E/f2BoSsiZaRKdt2Y=;
 b=ooxgjRWc/1HpxAmxxIwybg47vvBQGtBeTXk2n86+GBajtMKCohLcDzsDaV6CoaOA/7/rCIqonXsvmZ52ZPrxodtvRWnaeAyRe7PQP2Ln+AMGw31+1HlSDjTgX/3XugBZhdJYivxSWzm/uJHJCGnlVpBcsT/JFWzvf5P9dsYPJVkgFTwjcxgZffnuggbF7z5BPFun14YVJBt3yWsNvBjvKV5hryWilW1FLHkNGMk0alDOWMQgZPHrdQnqsdnbfcaeAN2VlFmhzxliaavZPaOSZhSAicYoGfuvgcN9rlmOEkWUPpw9FajMs41DqXk4mFS/XU+MYqoGDxkbQRnFmtsCJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAoe+PMq+mGEPRPGNJpMYmVzM3E/f2BoSsiZaRKdt2Y=;
 b=Lo1Yac3bETRLsQ5qzAobjyCO5IeTIXegD2VH44tTwHfuMLn6pcvAXUUb/S4/yhhDaqRAYzIzM5M2zO/qrnKmrW6vxlZV3+Ftkl4zN4ul7mEjQ16dSXJzQRy+DIC+I6bliVEli5Hq35FpfK04luQ0Lbz21js3LmemzFisIJo93uy7CfEQEfokC1o0youRlzAbBJylKfhpjm835kcSqh/QsEBCylfQ5Q8dPokrpyn9uo7SRjxx1gSneky5xVQDVVupIWmRgmBlXyllNFf4wfpkpEyOEEN4pN1bBiqZLWfgWR5xVh8Rbtwj7gp3gtYl6PUvNfQN7396euNVqDbvwRIkpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SAVPR12MB999144.namprd12.prod.outlook.com (2603:10b6:806:4e6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 07:34:48 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 07:34:48 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 13 Aug 2026 16:34:27 +0900
Subject: [PATCH v6 3/7] rust: bitmap: add contiguous area operations
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-chid-v6-3-160be5dfb5bd@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0288.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::16) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SAVPR12MB999144:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f0a834b-f8e8-46c6-1db1-08def90d5a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|10070799003|366016|1800799024|921020|6133799003|56012099006|10067099003|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: up6Xkc16h0zs9WHrzOtjfVTr1czWL1WvVBEIoP8StAS50hsGYNJp8tLhukbc/7mM/Erav3/r8djKXcK17M7arMqQYR5Hok7GBx4gNeAXDb40xLTlqtT1iQbXioJQuL0qZMkxeCtZ7NZcSb6YkMykFw27W3GlLweSOMCbNRnYkdzAFfrMUkeediMLS1G1ckkTsEyzNGlXEJUAV4wrty9X3qpglmLK1vumZqohiHPxx31vXnxA82OpeE6CxK0D438H6fOytgqYc4PdNi1QUvWB+2T4WOopdv+6698eM//pfsF18AZqr2E9uPwW8n1rXe35oyZgTYlEYhecBcYcbAUU9yvR1DA1RXEos+X0/cZsK64zvz4OwIqN+cdIqYssMYbrgQ6Eo1cMwxXF80jyxAi/PKRhQa9vBUCzEABn7PerjkrdlBmoCRcQtP0rx6TH+utQJp2dAZVZof/eZvrXysX7Yi7R+PlDW3WO9xg2kT1pBoEIe3BoS+MtJQjco96clG0lyEK9ELBnoWpFZUbbz99So30X+p/vl4Wzp3tRis9WztVCqtQr6D7x3FtM7qYwzMTm0SRGzq2fOsk99CU6kIiw+v2J8v8siZ8GLeECOIznWfhJRd6tJHeZ3JoknwQ9cAFzBoUvLQ/8V4Clkgy4+bG3zgEWxb9CD0WnzltVJ/HmOa1fP+VEHwkXCUD0a1orh1A+IKKjLYNsfG0kJ6byQgR68w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(366016)(1800799024)(921020)(6133799003)(56012099006)(10067099003)(5023799004)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUJJZkJ1c3dCc1ZLQjlFaUdTR2tEbW45dkNFc283VXJpR3Bnc2NmZUw4WWNh?=
 =?utf-8?B?Qm1KKzUwNnhlN016MmZuNmJKRzcxOFhzU3hwT3lEVHA2Y1dWcjVTOERkWEIw?=
 =?utf-8?B?RWJIZi9MZTc5c0FZeFhNSG45NjZmeHNiT0dtS3ZaSnBidUNibmNFejY1c1Qz?=
 =?utf-8?B?bmNVZDNnY1IzVVA1SG1TU0dIRzM2Y1RCZ0hIN3RjMCtiNW1LeGFOckdya3Na?=
 =?utf-8?B?NTFYKzZMb0ZWTGEvZEtTdm1kVk1MeEliTzJ2bDU4NkVTdng1K0MwcGlJNHFW?=
 =?utf-8?B?VktYZlBua210L3IwKzJxcWdCSi9iQWxZZkJkZ0ZEMS9hRzlMdlJYRmo5RXhB?=
 =?utf-8?B?UXBKSC9VS21ZR0pYdDhUSjdxQmlZWjE4NVNnQ3JhWDNLbEZScUk0YzBpQmRC?=
 =?utf-8?B?bkJiZUlxUk53QnVmbEhLZTRhUFBXZkZUUG1zZjlSYSt0VVhiZVQrdXhyWnlU?=
 =?utf-8?B?M3JYbHgrVzVHOUZZa0RWcEdkTW9mN1NOVjJSRzNreU5DcEorZnlGcUJFR2Rq?=
 =?utf-8?B?Rks0NGwzUHlXSXlhdktZUGhaRkwrTXJIZUw2M2lqd04zL3A3K1hkc1QvcnpK?=
 =?utf-8?B?QlhOWjFpUXIySHAySnZlV0pmV1JzaEdOYldnTHpmRGY5RzE3RVVxRGU4Vy85?=
 =?utf-8?B?OC9CQlJ1c2VPMFZ5VHFoY1ZIaUhoeWlsSUZMUCtFYjVqUUVoQk5KYnFtdG5S?=
 =?utf-8?B?djR6SXBMVGZjc281dWZQNDN2TmpxU0hvYk1XcHBJWFovV2dSVTlBNU95RTJP?=
 =?utf-8?B?T1l0clZzSW1NbGlsWWNHZUJTazlGVGNFM21HWDcxbzU2b2NCM294UDgwblVM?=
 =?utf-8?B?dEdrMlpuclZzUXZMdDltZ0tKUjhXSkhhaEluc2xMVGF6bld3Rm9ndlVRYXND?=
 =?utf-8?B?K3RUUHZwRnROWUltcng1NEVFUER1ZmlmVUJiSkFVNUJqckNZMHpYcXlYUURz?=
 =?utf-8?B?K0tUQkVQbWxxWGJjbTlYT3pzODl3OTMyS0hoOFRpV1YwKzhrVndhMTBvaWEv?=
 =?utf-8?B?V2VYb0ZnOU1RT1dlZFVDbjRpNnBOaFk3R09SY0djandVNnEwWFNLZmhyM2Nm?=
 =?utf-8?B?a3EySXI0WWtlVE9acTJnVGdHaUdCbGxBSUhORnkrOUJDWGR1SmE0cUxuM0hK?=
 =?utf-8?B?TXZPb0RNK0kwQnBjQVVkSGJRbURuVTlyL1IrWmI3L1liZDBtRGl4Ym9zamNy?=
 =?utf-8?B?UUN4allGOWxNY0UzeTJkblpuV2xRN2EvaWVtWGRJZlVtbGN5UEIrWXZzcmdB?=
 =?utf-8?B?ZDZDaU5DVk5Yb2tHY010ZHJpV0dwWnBFczB5ejdwdHB3TjBZK3BqTFFXUFNp?=
 =?utf-8?B?blFhMHZTMGh5R3piTWZTTllEWUV2RTEvbmpJWUsrZStscDZHaWw3cDNRYnd2?=
 =?utf-8?B?aXdma2R2bjhwZXRMUHlLTDdVa1d4TDBsTCtQN0hoVDRYN2R1MVFONm9LRmox?=
 =?utf-8?B?cmNsNGRqSlRiR2kwNXNQb0YrMGVWWlBSTXoyNi9vdy9hTUdFK1JROUxtQnlt?=
 =?utf-8?B?TCtVRVFGb2xXdm5XajFRZERyUVBQZG5ydFowZ3RYSFpMUWI2MDEzWVIvRjNj?=
 =?utf-8?B?MDJQbkphdlZ0elpVb0FxcmxsZExNUDQrQjRXSGU0ZEdlVTNsdjlKMmZBQTYw?=
 =?utf-8?B?NjZzejlnempSbzQ0dThPUnlEc1MrNjhoVitvVGhwQVNlVVgxSUN2NFRaUGx3?=
 =?utf-8?B?a3ZQbnRLZTJocERxL2hraGdnUjJPOGxWS1N4OEd3UGF2bSsyNldTaGZRemh4?=
 =?utf-8?B?MHRmMHpxQTlqTkVBQ0Y3NGx3dWNNNjhNQnZFeXRwbzA3TG5MMHZwc3pSM1JI?=
 =?utf-8?B?c2pZVnJVVnR6U1MyaVhIdC9PTE4wL0FVYlFrV1ZWemFLUGtSR1dtNU9rZ29k?=
 =?utf-8?B?ZTVDVkk0bGRkeTR5RTI2MXZ6eFBaNmVtVTU2UG5kQnphemxwOWZOSk1Palpv?=
 =?utf-8?B?cTM0bDhKdkFwVGx6M2o1OHpoclVJRm1CRHIyWnpmT2VDSGZGbTQvVExKaUh3?=
 =?utf-8?B?STNFY1hZK3llRW0rYkx5c2gzbGwveXN4TnpFcXMwK0loQjBzcFdSSGZMV3Vo?=
 =?utf-8?B?V1J2N25sRWRtOUsySGxveGlqOVdlTDJLQ3hYTnpzWHlaSUtjMk9UN3dWTUdl?=
 =?utf-8?B?TExzRTZQWGdqTnhSNEg1VUljem9ZSlBucEZZckxnNjMwQzdxbVNYNkphN0Zq?=
 =?utf-8?B?cUUrbkNYZ1B3d1dBOHJ5aTk3bjMxeVFSR1NuM2hrTDJIMDhDUzZ5L3ZLYTZt?=
 =?utf-8?B?VDNFRTczTVhoLzh1TDl1V3V4VFJ0UUF1ejFrOGVKUVBHTklkY1RHQXJNODI5?=
 =?utf-8?B?TzhmUURNTDBEcEJwRi9aSXBlRWpDNHYwNUhhdGdDMVZPcTQ3QVJoc0Y3WGJ5?=
 =?utf-8?Q?yIXLefN44VLidQIivRY0XB+uDOWXbpqPMPoNVhKxdjqUI?=
X-MS-Exchange-AntiSpam-MessageData-1: C86JtJYisfqjpw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0a834b-f8e8-46c6-1db1-08def90d5a4a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 07:34:48.0422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdBdmxk1k4LJJlekvdf2hKut9+JsaOQ/n1iHzy1eZWnQ5yw7SAMSQ2CrOjVKDFWT99jrpvvzAwRWveL8H42fng==
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

Add bindings for area operations on bitmaps. Each one is
made safe by adding some extra checks compared to the underlying C code
(for example, checking bounds) and with additional checks to catch
likely erroneous usage if `CONFIG_RUST_BITMAP_HARDENED` is on.

Add tests demonstrating the edge cases.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/bitmap.rs | 248 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 247 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index fdcfc0409773..ad63f248a6ae 100644
--- a/rust/kernel/bitmap.rs
+++ b/rust/kernel/bitmap.rs
@@ -10,7 +10,11 @@
 use crate::bindings;
 #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
 use crate::pr_err;
-use core::ptr::NonNull;
+use crate::ptr::Alignment;
+use core::{
+    num::NonZero,
+    ptr::NonNull, //
+};
 
 /// Represents a C bitmap. Wraps underlying C bitmap API.
 ///
@@ -523,6 +527,148 @@ pub fn next_zero_bit(&self, start: usize) -> Option<usize> {
             Some(index)
         }
     }
+
+    /// Finds a contiguous area of `nbits` zero bits at or after `start`, where the area plus
+    /// `align_offset` is aligned to `align`.
+    ///
+    /// Returns the bit index of the start of the area, or [`None`] if no such area fitting in
+    /// the bitmap exists.
+    ///
+    /// The returned index plus `align_offset` is a multiple of `align`.
+    ///
+    /// # Panics
+    ///
+    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `start` is out of bounds.
+    #[inline]
+    pub fn next_zero_area_off(
+        &self,
+        start: usize,
+        nbits: NonZero<usize>,
+        align: Alignment,
+        align_offset: usize,
+    ) -> Option<usize> {
+        bitmap_assert!(
+            start < self.len(),
+            "`start` must be < {}, was {}",
+            self.len(),
+            start
+        );
+
+        let nr = u32::try_from(nbits.get()).ok()?;
+        let align_mask = align.as_usize() - 1;
+
+        // The C alignment and end arithmetic must not overflow, or it can read out of bounds.
+        // Overflow is only possible on 32-bit.
+        #[cfg(not(CONFIG_64BIT))]
+        align_mask
+            .checked_add(self.len())?
+            .checked_add(nbits.get())?;
+
+        // SAFETY: `bitmap_find_next_zero_area_off` is safe to use with an out of bounds `start`
+        // value and, given the overflow check above, never reads beyond `self.len()` bits.
+        let index = unsafe {
+            bindings::bitmap_find_next_zero_area_off(
+                self.as_ptr().cast_mut(),
+                self.len(),
+                start,
+                nr,
+                align_mask,
+                align_offset,
+            )
+        };
+
+        (index < self.len()).then_some(index)
+    }
+
+    /// Finds a contiguous area of `nbits` zero bits at or after `start`, aligned to `align`.
+    ///
+    /// Returns the bit index of the start of the area, or [`None`] if no such area fitting in
+    /// the bitmap exists.
+    ///
+    /// The returned index is a multiple of `align`.
+    ///
+    /// # Panics
+    ///
+    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `start` is out of bounds.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use core::num::NonZero;
+    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
+    /// use kernel::bitmap::BitmapVec;
+    /// use kernel::ptr::Alignment;
+    ///
+    /// let mut b = BitmapVec::new(64, GFP_KERNEL)?;
+    /// let unaligned = Alignment::new::<1>();
+    /// let eight = NonZero::new(8).unwrap();
+    ///
+    /// assert_eq!(Some(0), b.next_zero_area(0, eight, unaligned));
+    /// b.set(0, NonZero::new(5).unwrap());
+    /// assert_eq!(Some(5), b.next_zero_area(0, eight, unaligned));
+    /// assert_eq!(Some(8), b.next_zero_area(0, eight, Alignment::new::<8>()));
+    /// assert_eq!(None, b.next_zero_area(0, NonZero::new(65).unwrap(), unaligned));
+    /// # Ok::<(), AllocError>(())
+    /// ```
+    #[inline]
+    pub fn next_zero_area(
+        &self,
+        start: usize,
+        nbits: NonZero<usize>,
+        align: Alignment,
+    ) -> Option<usize> {
+        self.next_zero_area_off(start, nbits, align, 0)
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
+    pub fn set(&mut self, start: usize, nbits: NonZero<usize>) {
+        bitmap_assert_return!(
+            start
+                .checked_add(nbits.get())
+                .is_some_and(|end| end <= self.len()),
+            "Area `start..start + nbits` ({}..{}) must be within bounds {}",
+            start,
+            start.saturating_add(nbits.get()),
+            self.len()
+        );
+        // SAFETY: The area `start..start + nbits` is within bounds and a `Bitmap` is at most
+        // `i32::MAX` bits, so the casts are lossless.
+        unsafe { bindings::__bitmap_set(self.as_mut_ptr(), start as u32, nbits.get() as i32) };
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
+    pub fn clear(&mut self, start: usize, nbits: NonZero<usize>) {
+        bitmap_assert_return!(
+            start
+                .checked_add(nbits.get())
+                .is_some_and(|end| end <= self.len()),
+            "Area `start..start + nbits` ({}..{}) must be within bounds {}",
+            start,
+            start.saturating_add(nbits.get()),
+            self.len()
+        );
+        // SAFETY: The area `start..start + nbits` is within bounds and a `Bitmap` is at most
+        // `i32::MAX` bits, so the casts are lossless.
+        unsafe { bindings::__bitmap_clear(self.as_mut_ptr(), start as u32, nbits.get() as i32) };
+    }
 }
 
 #[cfg(CONFIG_RUST_BITMAP_KUNIT_TEST)]
@@ -531,6 +677,10 @@ mod tests {
     use super::*;
     use kernel::alloc::flags::GFP_KERNEL;
 
+    const fn nz<const N: usize>() -> NonZero<usize> {
+        const { NonZero::new(N).unwrap() }
+    }
+
     #[test]
     fn bitmap_borrow() {
         let fake_bitmap: [usize; 2] = [0, 0];
@@ -640,4 +790,100 @@ fn bitmap_copy_and_extend() -> Result<(), AllocError> {
         assert_eq!(Some(17), long_bitmap.last_bit());
         Ok(())
     }
+
+    #[test]
+    fn bitmap_area_set_clear_find() -> Result<(), AllocError> {
+        let mut b = BitmapVec::new(128, GFP_KERNEL)?;
+        let unaligned = Alignment::new::<1>();
+
+        assert_eq!(Some(0), b.next_zero_area(0, nz::<5>(), unaligned));
+        b.set(0, nz::<5>()); // Now contains {[0, 5)}.
+
+        assert_eq!(Some(0), b.next_bit(0));
+        assert_eq!(Some(4), b.next_bit(4));
+        assert_eq!(Some(5), b.next_zero_bit(0));
+        assert_eq!(Some(5), b.next_zero_area(0, nz::<5>(), unaligned));
+        assert_eq!(
+            Some(8),
+            b.next_zero_area(0, nz::<5>(), Alignment::new::<8>())
+        );
+
+        b.set(8, nz::<8>()); // Now contains {[0, 5), [8, 16)}.
+        assert_eq!(
+            Some(16),
+            b.next_zero_area(0, nz::<4>(), Alignment::new::<16>())
+        );
+        assert_eq!(Some(16), b.next_zero_area(0, nz::<4>(), unaligned));
+
+        b.clear(0, nz::<5>()); // Now contains {[8, 16)}.
+        assert_eq!(Some(0), b.next_zero_area(0, nz::<5>(), unaligned));
+        assert_eq!(Some(8), b.next_bit(0));
+        assert_eq!(Some(15), b.last_bit());
+
+        b.set(60, nz::<10>()); // Now contains {[8, 16), [60, 70)}.
+        assert_eq!(Some(60), b.next_bit(16));
+        assert_eq!(Some(69), b.last_bit());
+        assert_eq!(Some(16), b.next_zero_area(9, nz::<40>(), unaligned));
+        assert_eq!(Some(70), b.next_zero_area(0, nz::<45>(), unaligned));
+
+        b.clear(62, nz::<6>()); // Now contains {[8, 16), [60, 62), [68, 70)}.
+        assert_eq!(Some(62), b.next_zero_area(60, nz::<6>(), unaligned));
+        assert_eq!(Some(61), b.next_bit(61));
+        assert_eq!(Some(69), b.last_bit());
+        Ok(())
+    }
+
+    #[test]
+    fn bitmap_area_exhaustion() -> Result<(), AllocError> {
+        let mut b = BitmapVec::new(64, GFP_KERNEL)?;
+        let unaligned = Alignment::new::<1>();
+
+        assert_eq!(None, b.next_zero_area(0, nz::<65>(), unaligned));
+        assert_eq!(None, b.next_zero_area(0, nz::<{ usize::MAX }>(), unaligned));
+        assert_eq!(None, b.next_zero_area(1, nz::<{ usize::MAX }>(), unaligned));
+
+        b.set_bit(0); // Now contains {[0, 1)}.
+        assert_eq!(None, b.next_zero_area(0, nz::<{ usize::MAX }>(), unaligned));
+
+        b.set(0, nz::<61>()); // Now contains {[0, 61)}.
+        assert_eq!(None, b.next_zero_area(0, nz::<4>(), unaligned));
+        assert_eq!(Some(61), b.next_zero_area(0, nz::<3>(), unaligned));
+        assert_eq!(None, b.next_zero_area(0, nz::<1>(), Alignment::new::<64>()));
+        Ok(())
+    }
+
+    #[test]
+    fn bitmap_area_off() -> Result<(), AllocError> {
+        let mut b = BitmapVec::new(64, GFP_KERNEL)?;
+        let align8 = Alignment::new::<8>();
+
+        b.set(0, nz::<5>()); // Now contains {[0, 5)}.
+
+        // The area plus align_offset starts at a multiple of the alignment.
+        assert_eq!(Some(7), b.next_zero_area_off(0, nz::<8>(), align8, 1));
+        assert_eq!(Some(5), b.next_zero_area_off(0, nz::<8>(), align8, 3));
+
+        // A zero offset behaves like next_zero_area().
+        assert_eq!(
+            b.next_zero_area(0, nz::<8>(), align8),
+            b.next_zero_area_off(0, nz::<8>(), align8, 0)
+        );
+        Ok(())
+    }
+
+    #[test]
+    #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
+    fn owned_bitmap_area_out_of_bounds() -> Result<(), AllocError> {
+        let mut b = BitmapVec::new(64, GFP_KERNEL)?;
+
+        // Should be ignored since out of bounds.
+        b.set(64, nz::<4>());
+        b.set(62, nz::<8>());
+        b.set(usize::MAX, nz::<1>());
+        b.clear(usize::MAX, nz::<1>());
+        b.clear(2048, nz::<8>());
+        assert_eq!(None, b.next_bit(0));
+        assert_eq!(None, b.next_zero_area(64, nz::<1>(), Alignment::new::<1>()));
+        Ok(())
+    }
 }

-- 
2.55.0

