Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103CDC5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 08:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E90510E71E;
	Mon, 10 Aug 2026 08:35:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="PRva55HT";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012039.outbound.protection.outlook.com [52.101.53.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05B9510E71E
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 08:35:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttEAwlcymxnxXjWmngl62upOXkXS3Iz3970yi8wrmtCmmStX7qvD71SGsarx3VTp2zfUpGiABo+e86PFygDpjhGYP+17wdhGenIoSl0/PpdmEDInOYwbzoDLq+H1gvtuagEQA8YWYFPus/XDpFu6IyYWT0cDYKO2nVD0VcohZLAARnj/MZb0Cn7RdGM/W6z85FQXK15+fslvt94NnIz+kqOyuMPL0qHfZRvdZT79/fASTgqIeia2yqhtdMvGpzNXzJrOlvNBjk3HTm2nZ0PIoRGUwdAmN0DikCJPcow2kLaQeX7Ohyx37sNb24KpcUE+tGMCSb8Q6BLMSZK12WiIdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EfpNXYZNQb95qB8zSqk17KFoQZWzSx1vuxImCjgYF4=;
 b=dpwF55KMsk2EMvDSIopq72+siEPwWpp1RcNDpS6Z2XxX4gJWtPmGf/IP6yuXaVV9RC/xFTWoO4alohnldW8FYu6aqswZp2Kdd5Bz9Kq/oIZ0f0j3sb3SwCIrqeYDdQJfL7h6U+BBqp5/2kTblYsriZl7e9O7YZlfbishp26TeeTo2AGpX+VIRJG5q1aM+d/hZygrc8Vf3PGaSn0CcPWGsOB3WiFDeKQExJGJyISFzGVBQHkV7f6Q4xBLyrbSmOERKPBfsDO4EITD4bu/tXbEnAR8hJGN6+cXqPaFeLMgOtp9lF1o9EZ6dmEdQXWHds2Ni1ynwvX124VHzCNm6ysnRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EfpNXYZNQb95qB8zSqk17KFoQZWzSx1vuxImCjgYF4=;
 b=PRva55HTSppTFjg2dqGN9qLG2zRTEGMmZSDytBnuPADhmFdeLB0KKtceuefymLFY+b+XTyNyh8ou/jdF7p73ZtBSpIc3hpowpgvyxDFGWOjTAajwrZX7VFfat3Vu36nUCKs+AvykAZQTfYtXET6y6qSLd5Smd4NZGJj5/FSOV9zkqRLN4OUjrRtURAEdn/GcZl113Y2lk7Mr6e05DpuMTWkTRD4iML0D3xfvT+17oo9q1k4hRRcxFBXue2YlbV4CUv3K9khfCUrGbyFWVUppDOAwIOYGPJcAOx0PIOzi/p78agwSDgyrChjlYwBn9qKFZtWSixYg8hnTZK8mgUD3qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY5PR12MB6036.namprd12.prod.outlook.com (2603:10b6:930:2c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 08:35:48 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 08:35:48 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 10 Aug 2026 17:34:11 +0900
Subject: [PATCH v4 3/5] rust: bitmap: add contiguous area operations
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-chid-v4-3-c9f206fdcb97@nvidia.com>
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
X-ClientProxiedBy: DU7P190CA0014.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::12) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY5PR12MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc638a5-4c2a-4dc6-9b45-08def6ba60d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|10070799003|366016|18002099003|22082099003|6133799003|5023799004|11063799006|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: 5WwCriuY2ttkrTPkFYlJPLRC80+5/JIYsO+QWyubD2I0ExjNrhxRRUQftOPhZjMlLsRsJNERXFo1FA/6AmvbPw5PH+Oqs0ZHelaaR4F1Vd0DZWIeWciYt5aoCU1QETEHsijpS5lI61jjtR4tNoGsycC2gqp+4C124NORosZ4Zjo70VfD6MbpXKcXtOQR0wf6zCRoIoC9JXF28Oty9FRQzOKi7Nczy8SAg3ca1l0xWaMfPQ/ze0Sjan0gXRLgV6Ac3xUA+TkvZfxNnmOv6vJxUBdnoQbohd3u0s5qrhi9oPevjHAv/U5iJR+tOOifjuY0t48deKm2lJyu670kAaxlkf02vItEwqUoFIoRys5XapYTdm014/8xzqzmC7dPs6W1T7IN+zoi8Rvqs0GMBx69OxseQ/WFYLQ5vNBKHrKoFkaB5KHbWA5avbX3sIKQcDhYL5g8xhMyqCJxvV51afq0vAVekKn6IasddgZSomTeUfSHTdr0HrWEnkqhpjs+bgZagoWxvfdN10KHW8EqYKyFz3dodDXAJcRuWjbscQPHIKjPYBjHy6mxJit3MzDl6OhZ5YS3LhC5r28aeDyYBtx/cOHp5FMuFK95LFq/GX5Ts7WEtfKnDrN20WJ0EUooJtycCugTt2dyTGr9erGXQjg9zMqsIWoaHxS4n3STSTujgtrxgCZ0mD56JC1i93JmEjHO1Q5uhAVnzKGVUUv8/LYxgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(10070799003)(366016)(18002099003)(22082099003)(6133799003)(5023799004)(11063799006)(56012099006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXRuNVM4QTlLdVNjMlYrNFVQVi9yR1JUeE81bElMcmtqczNlaDNxWU5Ndnp0?=
 =?utf-8?B?QjJzZVkzTmF2M1Ava2w0ekZ1LzdHNm9rc252Q0V2OE13VkkvVkFqRnk3TXZa?=
 =?utf-8?B?bmxjVUhiejNDVFRPN1Y4cEVFZklKZ1c4aFZIV3FzQXFzaDY2RjJNWm4xb3Y3?=
 =?utf-8?B?Z3JtWGh0M2ZCak1KWUdnWFFER1c1QXpBdi84eDdUWnQ1YTJWa3FDY2NwR05M?=
 =?utf-8?B?UjJITHVZWlBEd29pSTN0TWEzaTRWZ0c5RC92WEdveFhPOGZXODRZaDhISWZk?=
 =?utf-8?B?NThTa21vdklCR1F0KzBQTVV0RGt1bXRuZWNXeGR4RG9PS0J6ZFp1VzZsR0lt?=
 =?utf-8?B?ZjBoK01CMlplU093ZjN2UlJTWkpYOXorSTk2YjBUM1Bsakw4VEhFdW13b2lR?=
 =?utf-8?B?NWtHNnpFaysyc0ZwVjJ0dFIrWTVkM2NQU2lkQ2E5YlMyV2JReUdzV1l5cHpF?=
 =?utf-8?B?SVFyRFJEVGYyVTRRMDF0THFwM2JVUzZLemg5UGxTTW9DZmxvd0V2YkxLbU9u?=
 =?utf-8?B?eWtjMmNNYllRcG02R0Z6bWRpdFV6bWp2dldHNzhZbzQvMWJSUHk1YTY0a3k1?=
 =?utf-8?B?UjRVR1A3RjZjVngzWGlNa1BKaTNXejlUQ1M2dHVRaGgzaWdYV201WXNNN3dh?=
 =?utf-8?B?ZXhVdWd3K21EZytyRVZsaWxzMkpFVGFSUjhEY1hLamM4MHErRTVOZnpkaTh3?=
 =?utf-8?B?clpTOC9ZUjl1ZnBBK0syNjhOcjQvbWE3b3BUaXNqTXhDNjhIN1U0KytsWUYy?=
 =?utf-8?B?N0tYbXRxZ1RzVjZ4SHNSNjFqa3ArcHgwcXlHRHI0QjRScFZ4cDZsUit1ZkZp?=
 =?utf-8?B?azE2cWZ6TXIxTjBFczMvMW44NDJxMjgwbmE1dmxXUVlkNGZpdkI3WVFJa2VT?=
 =?utf-8?B?TXlNaUpWVjdDSXBjL1YwOElyNXh0bFFOU2xoN3ZwczIreDg1U0hwWWVTQkUw?=
 =?utf-8?B?SXdLcEdSMzlFU0hmdDdtS0pGczdvelh4Wk9VVmFhdkErUUJSTE5tOUV0V3hO?=
 =?utf-8?B?NnVvazdKTEEwVVhDQ1c2MFhwc0hIcG5ZSTBmRTVCZ0g0NGZWUFBGa1BCS3hL?=
 =?utf-8?B?RUh0c1JsK0x2c01GZ3kwUUp2WWUxdVJkZFV4bzBoS3ZDc3dQdFJrS2pBSUtT?=
 =?utf-8?B?Qzl6RkN2cjNibGNyUEJTVzl3aDVDZy8rOWVQNGxXUHhBSHZBZ1p0Wk5DbFZK?=
 =?utf-8?B?V2JtRUVuRUJsYkVnMDNPTkFsL0k3d1orb3AyMmJyR0R3Y2gySkovanVVOXpl?=
 =?utf-8?B?RjM4bEtGZ1UzdHpodm4ycFY4T3ZUYmlNcHFDVHJaUFg3SlU2dUtTb094UWVl?=
 =?utf-8?B?N24rQ2x1RkFRb0lXTlI4UEpjL1hrckJNQjZFRW9ZWGx1OVVuM3JPR2o4b0VQ?=
 =?utf-8?B?RzkyU1gzcis0OWRyZWtMbittMVJWK3pqRDZSc2JsQTNQOU81dmFPaUlndFdT?=
 =?utf-8?B?N3hBUjZEaHVqOHRwYVZpc3F6eitWczNsWkIzeE1IakFhQjZhSjExaHppeWlq?=
 =?utf-8?B?M2x3dXBqSG5OejV5Q2tXcGZHWG1GOElTQzlrbldUV1l2RTFRNm0xa3NTbWt1?=
 =?utf-8?B?bGtjcWQ0TlJNRmU5MlpySDZpc2NTZE1qcDl2OGZhcmwxTGk0YmwyZXI2MkF6?=
 =?utf-8?B?K2lRR3o5cjhla0pINTRXUzY5cjVsVXJBVTZoOVhiQUovU1gwYzV0UjJGWjVm?=
 =?utf-8?B?aHVCd21pa0JqMHRTVVhSK2NqQjdWR09WZU9maS9zSmVpNzJmZkJLYTdsR1VR?=
 =?utf-8?B?eEdVcVFLeHBMc2JEL3I3Z1I4U1dxUzMxdDF3SFFhdE5QK1pNT1pKbkMwNmw3?=
 =?utf-8?B?N2Vwc3BDbUpYM2YzaGdSSkpGcFNUK0VwMVpTemlUb1hjNHN4dTdvbGN0KzFP?=
 =?utf-8?B?emZvbzVvYTduZTAxajQ1ZFd0eWJOb2xyVXk5OUhITk5RRTVSNFMrWC9yTHhR?=
 =?utf-8?B?RXByc3NnRGFnemh5Q2dPNG50OFdsQnh2cGxoMlhYOG9GU2grN2JLTldhVlVn?=
 =?utf-8?B?U05tS0RESGZ6Ty9KeVQrMG1jbzYwMUJFb0grK21lUysvT1pWYVdYMnVDblRk?=
 =?utf-8?B?NjFBMGpqczkyYUh3SFU4MDFoekZobDc5eWtsSnc4R0tLTnpMN2xaWDNmWDZr?=
 =?utf-8?B?TDBvYTNRaGI1R2Jac25WWUhlaGU2VUpkM2NXS2w5LzBLelNoTHVHR2Qwc3pV?=
 =?utf-8?B?UVMrT24yQnQ3MjJTNXpIdW1oRUJXNlhEQ2d5em5UVGk5WHFHODVlMGd2VjVz?=
 =?utf-8?B?Wm11TW9oMCtDTEkvVlVhZm5mcGxUL1E5TVFzNVR4bXZuS0ZpcnpDb0tsMEtC?=
 =?utf-8?B?OGIzeVQ5bXQxQ2ZOWktHVzFJM1lXNmR0dEFSb2FsbTFCSkhzUmZHUXJCYTFR?=
 =?utf-8?Q?J5+fyIbcM0s5pGJpWnBTGfK9rVY9YVThfPCK1kjgTOGMj?=
X-MS-Exchange-AntiSpam-MessageData-1: r5LWqf5ZDk6Nxg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc638a5-4c2a-4dc6-9b45-08def6ba60d4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 08:35:48.3102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9IKXL00jrKB4z5WKc6uL0dHcUmB6iWLw/LMKTILJkrDQ6oRz/mmH8uuCUOYhQ+w5WxxJ4oMBcrcaFgkD3Qm4w==
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

Add bindings for area operations on bitmaps. Each one is
made safe by adding some extra checks compared to the underlying C code
(for example, checking bounds) and with additional checks to catch
likely erroneous usage if `CONFIG_RUST_BITMAP_HARDENED` is on.

Add tests demonstrating the edge cases.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/bitmap.rs | 235 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 235 insertions(+)

diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index 0d481d761f2a..a2557e9c5cfe 100644
--- a/rust/kernel/bitmap.rs
+++ b/rust/kernel/bitmap.rs
@@ -10,6 +10,7 @@
 use crate::bindings;
 #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
 use crate::pr_err;
+use crate::ptr::Alignment;
 use core::ptr::NonNull;
 
 /// Represents a C bitmap. Wraps underlying C bitmap API.
@@ -503,6 +504,138 @@ pub fn next_zero_bit(&self, start: usize) -> Option<usize> {
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
+        nbits: usize,
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
+        let nr = u32::try_from(nbits).ok()?;
+
+        // The C alignment and end arithmetic must not overflow, or it can read out of bounds.
+        // Overflow is only possible on 32-bit.
+        let align_mask = align.as_usize() - 1;
+        align_mask.checked_add(self.len())?.checked_add(nbits)?;
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
+    pub fn set(&mut self, start: usize, nbits: usize) {
+        bitmap_assert_return!(
+            start
+                .checked_add(nbits)
+                .is_some_and(|end| end <= self.len()),
+            "Area `start..start + nbits` ({}..{}) must be within bounds {}",
+            start,
+            start.saturating_add(nbits),
+            self.len()
+        );
+        // SAFETY: The area `start..start + nbits` is within bounds and a `Bitmap` is at most
+        // `i32::MAX` bits, so the casts are lossless.
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
+                .is_some_and(|end| end <= self.len()),
+            "Area `start..start + nbits` ({}..{}) must be within bounds {}",
+            start,
+            start.saturating_add(nbits),
+            self.len()
+        );
+        // SAFETY: The area `start..start + nbits` is within bounds and a `Bitmap` is at most
+        // `i32::MAX` bits, so the casts are lossless.
+        unsafe { bindings::__bitmap_clear(self.as_mut_ptr(), start as u32, nbits as i32) };
+    }
 }
 
 #[cfg(CONFIG_RUST_BITMAP_KUNIT_TEST)]
@@ -620,4 +753,106 @@ fn bitmap_copy_and_extend() -> Result<(), AllocError> {
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
+    fn bitmap_area_off() -> Result<(), AllocError> {
+        let mut b = BitmapVec::new(64, GFP_KERNEL)?;
+        let align8 = Alignment::new::<8>();
+
+        b.set(0, 5); // Now contains {[0, 5)}.
+
+        // The area plus align_offset starts at a multiple of the alignment.
+        assert_eq!(Some(7), b.next_zero_area_off(0, 8, align8, 1));
+        assert_eq!(Some(5), b.next_zero_area_off(0, 8, align8, 3));
+
+        // A zero offset behaves like next_zero_area().
+        assert_eq!(
+            b.next_zero_area(0, 8, align8),
+            b.next_zero_area_off(0, 8, align8, 0)
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

