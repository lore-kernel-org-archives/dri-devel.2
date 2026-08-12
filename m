Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1972C5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFC3410EEF1;
	Wed, 12 Aug 2026 08:52:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="pxhGYq3a";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 816E310EEF1
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 08:52:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lV26MiT/zbrXiWRDVSB/EF1rF9UZ7d7rm/v5GoCMLfIfNdzTnIDvTQZEwDF9jrSBGZyn4Ki5x4iYpn6g0xvFVVKOIgoh/6AKcs+JM3HfOgIDAWGxovdEPsKEaYibW0i8cY36AAIi8LYhU6QczND73ZRrXC5Unq6B9Zc087bRpF+MQgJKv6XNEgZKkw2cAZ3gUvdoMmHtnk/f2Ka0SADVinHctXtT00T/1Np+NaM7+XwN/BtNGPhJehUo2GkSsc3JoFZgNqnO2PFV49WzG3+Gm+MHF2NiqgOi+OcBSPD2YDH2O6GPkJ+8tk5rxXWgIZgHq1nkZlyKJ6SbzH7cihwB8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JI5YO14EBH7jrfKXmTFOimrsxEJ4OqmjrhnnTe2TufQ=;
 b=akgUem9UcgFgiRuSPQzcQ9HE52cMi3wlmUHPZZFgTha2Kqd5VGbgVCMr13yKkEeiR+fv3SQEK7hC5gu1r/5omylA+ZSHDY+Bj0P7BxJKAWDkLZCQiEx5h/SpfVxi5xG4JRKPuUGAYOG46yx9IChLwof2tm25vNx0eAitt2vYCKQiErP+qBSH9hHvkYxiOTgCpgb5xU8ZKiiAS71nMXxc10kBbdo6yw/1Eww2eJa972/NxnLC2y/32OjUkni6CI7PFe5pkI/gj8ao61/a8ZgwPrcWOdf2041Bt4AJ5S2nlATOBr/6Am+fe3W7q+CqRCSWKyKkAQj2HLsKJRe1M10KXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JI5YO14EBH7jrfKXmTFOimrsxEJ4OqmjrhnnTe2TufQ=;
 b=pxhGYq3axY0U/EIW/VzyQhA1IIsgF2FHMV3pndhA/JpQxAvi3aGmmdXDazjCimzvdvORCx2PWVbPApJuio3V2XGegLZ2OHLwMzsfbtO9cOn0LF+cGOlhD/v1FHBLkkCXSHtbmifoVVes84l2ZKujCCRaS0HI18p7Z9yw2DR/DIW3Y63Bb20+kXzDClYHsxav9Q67E1uK7eZ8Y5CHFuv3L+Q0P7O+Cw7sflhUH+uU6oR4QUFANTuRxFfPye32RDM6cfHdT7PWPG3C8cSS7B6x2xuD4WpqLjpLV8zXBg+PvlLYSY//OQftV3dD3KL7VUE/Wo9cJcB6GP6V73Cduirmug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 08:51:56 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 08:51:56 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 12 Aug 2026 17:51:23 +0900
Subject: [PATCH v5 3/5] rust: bitmap: add contiguous area operations
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-chid-v5-3-6c767770b3f4@nvidia.com>
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
In-Reply-To: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
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
X-ClientProxiedBy: DU7P189CA0003.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::9) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eb76d2a-19f9-4e16-ed3c-08def84ef6bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|7416014|376014|366016|1800799024|921020|6133799003|10067099003|11063799006|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: J17lICQlf1f/MbYSWTqmSpbNOwuAEnXhz+ueADDP/zaPS7zRFLYlYpcgjJeXLriT2PKVOEmGHUV3DiojoWybqDs8vmG0ntUm6LHvOz31esvzb2vmf/qYajsUvgTvfMy+6UXlUT+KpnTVqUS2OtUxocTXYixLMrcAgIs6TBRrihBg6Bj6fJY1XXvpE6AEtvei2CmPH7fvBoYXlGqSUyfb2QG1QYHL/ZwuWkOhaiX+HQlPUixw67q796ArbRU6JznMdBAVLH1Iqj8rIiwHW/two17IrINRRZwZs0M/qQrOm5mP9aZ84OpRiXyxNDBk0wblOY34HyH3bNoTqQTNEKPxZcL6Mzi/2rLtm4Ayih0DzTogfH6bBSMo/j/O3JmSeofhFMrIZt6XSUZOG3WXwybmchZ8r6WSHcRrfPOwoV61JJ/f29ZTBOEwrJw0oVawOvNtksA69wECD+w6AVGplxIiDlttfZD545lF/P6Qp5kN/ObCiswhr8jytFoEZcmH8adg3sbnaQk+TYp1KGauOqrsD/TaFoVhslMV7JshRaioYvBoKAUpltKtIH+dH96saOsGoP7xJCYxQLRHpwwYUIeTGrviHTAT17eO0WOiVVcewW2hPkodZ6YbQ7VOAD+pj372cIv8PIVYyQ6L1YO14HXRUehdF6yg8k8t5qudxBVZtUS7lOqBOXcLOYIJRNODXmNT6SVwoTJXoQNDiItQnxMJNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(7416014)(376014)(366016)(1800799024)(921020)(6133799003)(10067099003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUw3VWVraWV2cHZKMkxsbUVNSUVOd3FsektMM0dpVkdNNUJJendCaFoycUtp?=
 =?utf-8?B?eE1Ea1ZhWlh5YjNQZTlGUlpPWFZqWU4vQmxvQ1ovdTBqSzV1VEwycUJRSkJT?=
 =?utf-8?B?bUZJZjdpckRWYnNPOGt5LzhtZnoyQ1l6dGdMYW1NWEk2YzV3dXNvSTgzNmpW?=
 =?utf-8?B?OHNEbE80MnhyeEc1cUY1N3hWTGlLTmI0K0dLVHZjZHY0YW4zSlU1OExYQmlv?=
 =?utf-8?B?M25MblNGNG9KOUNMdllub0hHTUNzQS8rTjUvUHljamVDTlFaYW9OejFmdUxS?=
 =?utf-8?B?U0NlSFRwOE4rZEdwLzJxK1Y5akpibWR2OEdhbGZSdVBvczkxNWUzaGdtSzRq?=
 =?utf-8?B?ZzRSMytuVkJwbU56OFAxY0czM01aczFzUnBYK2FxNXpWZ2V0SkhiQzJZYzk2?=
 =?utf-8?B?SUpaaEF0V2dXcloyWkdtd1RGVWhLa1lkSDVka3BxcndqRmxjWllncG5qTzJv?=
 =?utf-8?B?bFJyOUcwV2xCZzZyb0JHa0dGMmJpbHM0bHk0U2QxRm1PaVRiU29NWU84bTdL?=
 =?utf-8?B?cFVRU2tka2dGQVdvOHlRVDFNcVEvSmtZY3RZSDVLUHhWYTR1S005NHc0WWl6?=
 =?utf-8?B?dzFBSlZES3J3TjhiK1JMcXZIVG9zQS9ZTmVMTm82L2F0K2NqK0VHSGkzRElk?=
 =?utf-8?B?Y2FOU2w1TXgyNnh5SlZTb1c3NnpKUEFTbmhqakhqME95ZlhkUk9vYXJZMGl5?=
 =?utf-8?B?NTlNLzZSYTduRzJQYUw4UmpTUHdLTjJVb09CSFpSN2lKT0RBZjRKb2M5L3JG?=
 =?utf-8?B?Uy9mN3dkNHA2ZnpTVWEvRlFuQ1E4RWluVmFPSC81K1RObTJuby9jd0ZrNEt6?=
 =?utf-8?B?ZVF3RmpMUm1WVVV0VzliMFhQZGFERkp3VExWak5aNTRKUXRBZW92a1BsbjVL?=
 =?utf-8?B?Vm5adlFRRU1wRzVxN3Z6VU0zalhGUDRFeVJ0UjlndU51VnhzcUNuVldyOTZ5?=
 =?utf-8?B?bmZwY2ZpOHdEM0M0N1B1WjI4RFhiNk5idmtTWkdJME03b3VaQ1VrTVhvZ1pi?=
 =?utf-8?B?VTk5cWdKNktOZkNiaFNPK2IzV2J6SXNtR1dTV2xGNHFnUzV2cmJNUGhxU2Zs?=
 =?utf-8?B?N0pNU1k5YVRxd3JrQzJHMTVqd2ppbFZDYkp4dDZ3djFrU1BqdjB2WjEyTDBL?=
 =?utf-8?B?NEZtekN5OTRUNnpzbWxMakx3TzdNbDQxbFBCaHNvalJLOHlpQ3kyQjFYUlJW?=
 =?utf-8?B?eFV5Uk83NFlNQThnSno1cUQremlLMlNkalVmeTNjTHYxU251clJ2N2s1d2lP?=
 =?utf-8?B?S1lUT2F3UkozUmhGV0VFZVQrTGtVM2ppTHBqNWx1VzRWNzB4dll1b3d6c0JM?=
 =?utf-8?B?UUhkY1QzZ0x1VTlFSnM4NThmUDRlcE5zNTUzN3psS0RyWmYycURMc1dIRWV0?=
 =?utf-8?B?MTBlWWxzc29OWlIxeFEzY1dyYVFhcDM0U3VPb2hTWmZoWW9RRWpMYzBtR0hY?=
 =?utf-8?B?RVRJZEkyK1NpUFBBNTUvNkJEd1Njck11TVI5bTU1MUw0eEMwd3A3T2dWY3hC?=
 =?utf-8?B?M0Rjd09HT0ZhaWpaM1lNUUVRNGhCQ1hxTXg0V29Ua2Q3M3VTOStCZVQ3V3c1?=
 =?utf-8?B?N1dyRllPUGNMVHZDVjZoTlJueEtEUW4xS0N5aysvVTE1dXRmYnF0d1ZEY0ZK?=
 =?utf-8?B?eUxkWW1QcVJLOEllRXJhTi84KzlaUmFLNXA4eEJCd0Jmc0RLNVNkNE5mRDNR?=
 =?utf-8?B?THYwRVlqeFdXVk5SblgxWHllbXVENCtBWkxzQjQrL3RkVzlwQ2o3WFZMb3Nm?=
 =?utf-8?B?K2NXQmR0azYzcllIL3ZkbDRWa0k0UGNObHVsQmI5Mkw3Y3hhd2JEZjFuM0l2?=
 =?utf-8?B?U2FQWUZWNnVkRnU0R2hCU0RzMkorczlvT24wK2N4NWFNODJSaUVLdEpWSnpl?=
 =?utf-8?B?ZDFqMmQveXdUVmlpdXZ0bWMzNVRqZ2hLUHg5VW0rVDhHV3BNVHNDeWJIblJE?=
 =?utf-8?B?YUFUWi8wTUNGeW0wL285YW0xUjdqQlZmR0Ywb25haHZwL2haczVRbUxrc0lo?=
 =?utf-8?B?eDVRaUVCZ25Cb1J2ZzR3UmpTRVhHeFVvb25aT0FJdEd2N3h3T3B5c1JueFVS?=
 =?utf-8?B?QmpMelFISlpoSU15WmdMS3FHTzI2dVB3cHdTRCtLN0w4V2RxWS83WlhXLzVo?=
 =?utf-8?B?Yys0RFp4clZEV1VhZWNuTElPSWE3TUg2MGc3bGFva2VaRkdXUlBQVHVKeG9J?=
 =?utf-8?B?bVN3Sm5QRC9Gd3Z5MEdUOXdNcGsrOE52dFJCYjZxMlN0OVBRYnRMbVgrOHdH?=
 =?utf-8?B?NzZ2c1hYMno0ZGVIaGxBRC80TTBVTWtObDhSdUtCd2RiaUw2NERyeG1rdmRE?=
 =?utf-8?B?QjJOQ3Y1TjEyTXVWZEtYUDlqWUxjUTFCaHdzaUllckwzZTFXUkhMTGxIejdE?=
 =?utf-8?Q?Q2CgJxxMd8jGwodUduSRsAFpXotr75dRmIv5xnGIcwxWL?=
X-MS-Exchange-AntiSpam-MessageData-1: /72MAhH5xutDAQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb76d2a-19f9-4e16-ed3c-08def84ef6bd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 08:51:56.5871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Da5nCmgkHyhRYES5qlEV75rBTZHyvkRFCTFJgXiChNUeDGrl3RnuX3rZikAKrFNfUObv5/2eA7IPuk5C3ZvqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519
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
 rust/kernel/bitmap.rs | 236 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 236 insertions(+)

diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index fdcfc0409773..74c92cc452c9 100644
--- a/rust/kernel/bitmap.rs
+++ b/rust/kernel/bitmap.rs
@@ -10,6 +10,7 @@
 use crate::bindings;
 #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
 use crate::pr_err;
+use crate::ptr::Alignment;
 use core::ptr::NonNull;
 
 /// Represents a C bitmap. Wraps underlying C bitmap API.
@@ -523,6 +524,139 @@ pub fn next_zero_bit(&self, start: usize) -> Option<usize> {
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
+        let align_mask = align.as_usize() - 1;
+
+        // The C alignment and end arithmetic must not overflow, or it can read out of bounds.
+        // Overflow is only possible on 32-bit.
+        #[cfg(not(CONFIG_64BIT))]
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
@@ -640,4 +774,106 @@ fn bitmap_copy_and_extend() -> Result<(), AllocError> {
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

