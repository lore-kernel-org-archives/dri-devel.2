Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D7AC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:04:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16E1310E68F;
	Mon, 17 Aug 2026 07:04:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="C2xHQuxm";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012042.outbound.protection.outlook.com [40.107.209.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11F6410E68F
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:04:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3Gyglz6YtE1J4CVs4Ok+o7ocyE6H0LhWiSZ5UZU9RitVz9HUy5bfo9yQ5l0pI4PA7ImWngyQnTEr54SyE+sz7abqp7FjY3AVth+jdeenzW0pBL0JAeFF5oAJ9gokpPzaPR08z8VZG6LD/xIJXn2O4ktlQiWAu+Kxp5YMSfetH38kqKG0gAMbQezdM/7EU9D9cBeloVlwehUfmLGiW2CfuzXGITmhHXRXbLDr23UERm9Us6ftVNfQkndT+aeFMKnSGeAyYru3JZtcXb7OxMuuxB+HvS8ENPxDx/HPMPcumSQKY6z31UmvF1LG5KkBV/MoJugDnlm2LFJK894M7Of8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2t2rB8RaypvDvjtkn730BLj+dIrVOAUvW+9i5po3Iyc=;
 b=GiK1p98+Js1+qQNF+ZPQsB7B/W2ojCIkWCRUSuaoDVcADooDWmcg3wiLkIKWPMowndB2FXt8Ga4JrwCDCHUfHZfD0aVu6Kpz2ac+WEGQDdLFG3vY+7SZkz8Aa3w/4ZaAO+fyiPWXUyLST4sHJC5i6SoDnTT0gHQVBPbM8BZeUSOKoUrddCVCeTQbinAy1kauCkrq0q0VFekL/2W6Aa+rTKgL9Ei0zwEirTbLAoukZGZU06BgmFY/bEz3Tw49rfA+OiqtCLEpIFgVCSeh3jVAydhwV5RL7fYvd/MGm0arnvGJ+xDHY9e2Q8TouxGJwYwMXRy/To2pmzG/+P+oGnggLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2t2rB8RaypvDvjtkn730BLj+dIrVOAUvW+9i5po3Iyc=;
 b=C2xHQuxm4SB4jXa560NkzQ03Wog53wJaa4R5pK2xrakptGdGW86Ty0DRCGfV3fdoW1M02qbbxc2ka/dWR3xzJ9oZL2CpaLdwYo8fOdQBJLkfs/RQuP6R3VO5yys/uCZ8Ja+AvXpyU9vmF8DMr9v3MMRjx88FkJt1v4esmulL5lG5VsO1k3VuHjw+EKIuUFr6eZqAzXhO8sSEh+irhwV/ImXpvaLvnUDc1FBiuh3rbthOHt6xJV6vyqEE2knzKIJr+hpDurFtkw0EmxSKCZPdzNyAWii6KEJruCg0Au60HmUbc8mIZdDcln5sasmZ5V7DCFssx3lLGQyEpwE6q4FrOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Mon, 17 Aug
 2026 07:04:43 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 07:04:43 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 17 Aug 2026 16:04:19 +0900
Subject: [PATCH v7 05/10] rust: bitmap: add contiguous area operations
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-chid-v7-5-a5872e64d8f4@nvidia.com>
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
In-Reply-To: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
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
X-ClientProxiedBy: TY6P286CA0017.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b9::15) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: 260577da-05dd-48b8-3aa1-08defc2dd038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|366016|10070799003|376014|921020|6133799003|10067099003|5023799004|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Koya7WmKvgjWWGAYQkOzocRaZu+yLup4RLrRHP4bw7HBtDrQ/w9X4ignk96Ai5yUsa8qJ6+PrCpC9ODVHbbQwaApTN2DVR8uEc5SSerDjmyt44jrqWnnLoIIqfqAmCCAVm8PfZnZaZyPe26DZ0u+43EYbBLHRtsLdYSniLzsIDnfVKPjFD06fV+uQsy/RW2vDvq53hlq+6QBg96e7P7jBLiW7gFJzLt9Hylbjq2FbBALMzbgym+uIQaIV9lCb7/FbqWkKEIKH3rbwB0rZItTXvc9ATVCvYFTahHiMNpaWXP0HM53novV3fUQe1X/2Ycp2WTJuOS6Ob2l+9rS1G/ScvGAPoEAZ+d0nBZBOa/bpVWVIEiLXUftlki0tTPBv3lzdN5mfsTvIJBgeWvu8c2qe797EC5g3D76ypyPFGjUrrYMR/wFhBxTYRKKdTnJrmQJS3YLkl6Ue8m+7M5UouVfzGrECLVoYwrFwN7/GvlXuh3thDdy4nXXLRpt5cGuDut1m7FhLtZWR9sIq4DxhE6xrPUTbLHhotqFjDpobtZUes5Y/vzCJ61SZLfm8VWylfNlIOhnhREyjzabGUiYEzQrIK8DlIix30t3W/+lCOhxu+13LFk6ZCoeS6fSdUstUozT7uo+Rr9iz5B0rRiKMIrMcuXKYQ8RACCzGW5gwIWVJyIP1j4llUf0bkImK676HSKoKLSRbV2wh4jO9aiJSqA1Og==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(10070799003)(376014)(921020)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2F2YjJ3bjB6Zmc1eFYrbHI4RUpyNi9SQ3hCaHBibmpMa25CcnFXeUp2N01Q?=
 =?utf-8?B?aFNQNTdzZitESnhEOFpBZGhKWko5TDhaUFJpNlh3dFNENVNUcG1pNmZDejdS?=
 =?utf-8?B?djIwTmZnY3FZVXRWNmlUMlFRaTdTa1U0NzhjcjhDeG1hNnd0VXZBc1lLa0c2?=
 =?utf-8?B?dDdnbzdiYmtlOVR1bE0vUFQrUndVTG1LV3JnYWVKQ2dGcGdXaFhnYU1jRUcr?=
 =?utf-8?B?MFBOaW9ZQUxCaTV5TDNRdVJ2MTB4RDZRSlhWdVUvUXVmVHRaenlNeFRPK090?=
 =?utf-8?B?d1N3d1l0WVBQL0ZNaVVaVlVneUdIZzNQQy9MMzFobTRUMU9Wb3V5Y3AxaWhI?=
 =?utf-8?B?U2ErNDFqb0pQcHhZT3B5SE4wdklNZGJIV0tCMkIwMGpDSVRlZ3cxY25HY3Zo?=
 =?utf-8?B?N3E3THNnQ3dnSklIQ2R6K1JzU3oyTTJrd1MvL3BxMXpFaHpYN1pic1BZNzhx?=
 =?utf-8?B?cDl5MVM4M0hvODlMZHFhUUh2UjkweU0xM0tyYmltcXoyODJnanFQWldOKzBv?=
 =?utf-8?B?TTFiRXhvcGxSSGJ4Mis4TEJockRqQnlKYmJOaERpZGlIUjJRaytTb3ViQ2lB?=
 =?utf-8?B?em9VY0c4dmpxYnRHM2VKeTdSUmNWa0lMWFFtb3h4S2FnVkN4QXRkOGE4cG9o?=
 =?utf-8?B?NXpTU0F6Q1R0OG9pTEpQV1pVdU5JeEJRbVJacEVpUUg2eTMxV0pUTFY5bDlJ?=
 =?utf-8?B?d0xMVWU0dEFIeTFNZ0Y4dTgzUG43ai90WjFocy9XNWM4ayt5ejVZdWN0bVRS?=
 =?utf-8?B?RTVsUSszdEMrOERQbmdMTG9FSDZiSkhWeGxqMVRWTTNIOHVQSDA4UVRlQlhT?=
 =?utf-8?B?UmtJc1d1SWZiUFVjaFN3dVpkdkd2bklOOXlINzY5REdxQTZsMlJWOFpTRnY4?=
 =?utf-8?B?REc3WkVSaVZ6dndkY3k3TnhyYVNtZThQQnVhNlBsV0N2YlVReGtHMGJsZHgr?=
 =?utf-8?B?TGNNZmY4QVB1eXBYeGUwajhnSFBzTUZsb0ZRRXlVSXhJKzExUGhaOEE0NGJU?=
 =?utf-8?B?a1BqTkZFV2lscWRBTTJrdUZYdnkyVjA3R1VVTlc4TnpwQ1cvV0YxS3JiaU5r?=
 =?utf-8?B?S3orREMwMlBSY292dWtCMkx4Tk5LQWlmdGZLUHBtTWFoeVc1ZlFrUkltVVI0?=
 =?utf-8?B?dzJLamtRNkwvNGVRd2xhQnE4UWJkL3pqU0tWMVlnamRiZWFsVmp4OW80SDRr?=
 =?utf-8?B?YWNNUzlZNHRRZ3lyOWg2WW93ZWRSelVOa2pRSExFd0FHZkRxbTRzTG9NRVdo?=
 =?utf-8?B?eUJTUHpvT1FWeU1zNWc0T3UzQ2RzZ0tkUHUyYk9EdjZ5MitNWXo2dEl3RDR3?=
 =?utf-8?B?VFg0MUZzQTNKNFRMYU9yVFFudWovOXdoVCtlRkMrVHdSeDVaQ01MMTgvc2Va?=
 =?utf-8?B?V1BPUHJETFZGRFB1M0llYUFUOWUycVpYVkFPRUdNRnlNanlhc0ptYUFIS3ZM?=
 =?utf-8?B?b1hLSVJhWEtZelJmTmx5VUpOZ1lraXZOVjR1YXJsZmlKLzVBNlNJUFVocWhW?=
 =?utf-8?B?T05PcDJHSmQ0UDI4OE80ZThMcWoyQnlDb0JCcGVtUmlFV0I0b29RV3JKUVZE?=
 =?utf-8?B?U2lTVmNrV1Noc2xVWndRa3N1ZldJN3RIYTdDcW1YeUdqSGVIb3lZZmIyNzM1?=
 =?utf-8?B?UldBQnE4OHVFNVVodDd1eHN2QmUrRmw3UExMKzNOSnRXQktTQ01jQWNsaThJ?=
 =?utf-8?B?TzE2RHdodUh1cTIzb2NDNTRCeXUrcEdValMxTmFuT2p5ejI3RWZDN0VXUDlv?=
 =?utf-8?B?bElnQjQ1WG5OOGZIZVNQZkVTV0pJaTkyU0NuYjlFd1dsWGVaOTdDVkI2OEFs?=
 =?utf-8?B?SW1HSnJDVGh4NWFBSkVjeDkzTXpncC9hUW0yZVhLQ1N0UDBtMmhOVXk1aHkv?=
 =?utf-8?B?dFpCOUhlQ1F5cmYzbjUzZGZuUHhIUUh1TFlaRjBRbUpxMnl1SHVyb1NTdi9Z?=
 =?utf-8?B?U0JrQWlhNFF6Y0ZCdlExZUdxR2lCVk8xbGdEaUt2Y3JZZE5mT1FjTTY4UTBB?=
 =?utf-8?B?RDlhQ1ZVWENXQ09vRGhUV21TRFhoSmNWQ3BrcDBzdlV5SUZxTUVybEJGU2JL?=
 =?utf-8?B?TDgrcllicGsrVytrT0QwazhnWWUzZHp6V3ZlbHFXM3BmQnBPaFptaUZUSG00?=
 =?utf-8?B?K3VoMDl4VlNCTXdFQ3k0UU1hcUJJRE5rMzRacXYxVmlaL1M2QmluL0kyd1lD?=
 =?utf-8?B?THRkd21sYS83VC9Hc3kzSWpWZmkxMWdYWG5yQ1BGS2RVRG1qQkt5K2dvb3pL?=
 =?utf-8?B?NWYrbmVkaWJwd3VsNDVLSDhyWGZzVmFxeTRzb3g0eGdlOGZydEZ4QTJjRmRY?=
 =?utf-8?B?T243dzBKS1k1aFBacXUxN0RhWEJVaW91UGpSbkEwMVRWY3JxWFdDcHl3QlQx?=
 =?utf-8?Q?kDFqsfkNEilBY7utjUxroRuimwLQMY4+YblcAln8OlqWr?=
X-MS-Exchange-AntiSpam-MessageData-1: vbNr//p1ravvZg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 260577da-05dd-48b8-3aa1-08defc2dd038
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 07:04:43.1124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C35mb6COdXqiorxvMUCxILqxT175oxlJqQxO4qxBu3K4/obkyRTbImvHKbQg3NmqNhk3W+M5n5umayR3Ev3Rkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732
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
 rust/kernel/bitmap.rs | 242 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 240 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index fdcfc0409773..a4997022ff0f 100644
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
@@ -523,13 +527,160 @@ pub fn next_zero_bit(&self, start: usize) -> Option<usize> {
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
+    /// use kernel::{
+    ///     alloc::{AllocError, flags::GFP_KERNEL},
+    ///     bitmap::BitmapVec,
+    ///     nz,
+    ///     ptr::Alignment,
+    ///     sizes::SizeConstants, //
+    /// };
+    ///
+    /// let mut b = BitmapVec::new(64, GFP_KERNEL)?;
+    ///
+    /// assert_eq!(Some(0), b.next_zero_area(0, nz!(8), Alignment::SZ_1));
+    /// b.set(0, nz!(5));
+    /// assert_eq!(Some(5), b.next_zero_area(0, nz!(8), Alignment::SZ_1));
+    /// assert_eq!(Some(8), b.next_zero_area(0, nz!(8), Alignment::SZ_8));
+    /// assert_eq!(None, b.next_zero_area(0, nz!(65), Alignment::SZ_1));
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
 #[macros::kunit_tests(rust_kernel_bitmap)]
 mod tests {
     use super::*;
-    use kernel::alloc::flags::GFP_KERNEL;
+    use kernel::{
+        alloc::flags::GFP_KERNEL,
+        nz,
+        sizes::SizeConstants, //
+    };
 
     #[test]
     fn bitmap_borrow() {
@@ -640,4 +791,91 @@ fn bitmap_copy_and_extend() -> Result<(), AllocError> {
         assert_eq!(Some(17), long_bitmap.last_bit());
         Ok(())
     }
+
+    #[test]
+    fn bitmap_area_set_clear_find() -> Result<(), AllocError> {
+        let mut b = BitmapVec::new(128, GFP_KERNEL)?;
+
+        assert_eq!(Some(0), b.next_zero_area(0, nz!(5), Alignment::SZ_1));
+        b.set(0, nz!(5)); // Now contains {[0, 5)}.
+
+        assert_eq!(Some(0), b.next_bit(0));
+        assert_eq!(Some(4), b.next_bit(4));
+        assert_eq!(Some(5), b.next_zero_bit(0));
+        assert_eq!(Some(5), b.next_zero_area(0, nz!(5), Alignment::SZ_1));
+        assert_eq!(Some(8), b.next_zero_area(0, nz!(5), Alignment::SZ_8));
+
+        b.set(8, nz!(8)); // Now contains {[0, 5), [8, 16)}.
+        assert_eq!(Some(16), b.next_zero_area(0, nz!(4), Alignment::SZ_16));
+        assert_eq!(Some(16), b.next_zero_area(0, nz!(4), Alignment::SZ_1));
+
+        b.clear(0, nz!(5)); // Now contains {[8, 16)}.
+        assert_eq!(Some(0), b.next_zero_area(0, nz!(5), Alignment::SZ_1));
+        assert_eq!(Some(8), b.next_bit(0));
+        assert_eq!(Some(15), b.last_bit());
+
+        b.set(60, nz!(10)); // Now contains {[8, 16), [60, 70)}.
+        assert_eq!(Some(60), b.next_bit(16));
+        assert_eq!(Some(69), b.last_bit());
+        assert_eq!(Some(16), b.next_zero_area(9, nz!(40), Alignment::SZ_1));
+        assert_eq!(Some(70), b.next_zero_area(0, nz!(45), Alignment::SZ_1));
+
+        b.clear(62, nz!(6)); // Now contains {[8, 16), [60, 62), [68, 70)}.
+        assert_eq!(Some(62), b.next_zero_area(60, nz!(6), Alignment::SZ_1));
+        assert_eq!(Some(61), b.next_bit(61));
+        assert_eq!(Some(69), b.last_bit());
+        Ok(())
+    }
+
+    #[test]
+    fn bitmap_area_exhaustion() -> Result<(), AllocError> {
+        let mut b = BitmapVec::new(64, GFP_KERNEL)?;
+
+        assert_eq!(None, b.next_zero_area(0, nz!(65), Alignment::SZ_1));
+        assert_eq!(None, b.next_zero_area(0, nz!(usize::MAX), Alignment::SZ_1));
+        assert_eq!(None, b.next_zero_area(1, nz!(usize::MAX), Alignment::SZ_1));
+
+        b.set_bit(0); // Now contains {[0, 1)}.
+        assert_eq!(None, b.next_zero_area(0, nz!(usize::MAX), Alignment::SZ_1));
+
+        b.set(0, nz!(61)); // Now contains {[0, 61)}.
+        assert_eq!(None, b.next_zero_area(0, nz!(4), Alignment::SZ_1));
+        assert_eq!(Some(61), b.next_zero_area(0, nz!(3), Alignment::SZ_1));
+        assert_eq!(None, b.next_zero_area(0, nz!(1), Alignment::SZ_64));
+        Ok(())
+    }
+
+    #[test]
+    fn bitmap_area_off() -> Result<(), AllocError> {
+        let mut b = BitmapVec::new(64, GFP_KERNEL)?;
+
+        b.set(0, nz!(5)); // Now contains {[0, 5)}.
+
+        // The area plus align_offset starts at a multiple of the alignment.
+        assert_eq!(Some(7), b.next_zero_area_off(0, nz!(8), Alignment::SZ_8, 1));
+        assert_eq!(Some(5), b.next_zero_area_off(0, nz!(8), Alignment::SZ_8, 3));
+
+        // A zero offset behaves like next_zero_area().
+        assert_eq!(
+            b.next_zero_area(0, nz!(8), Alignment::SZ_8),
+            b.next_zero_area_off(0, nz!(8), Alignment::SZ_8, 0)
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
+        b.set(64, nz!(4));
+        b.set(62, nz!(8));
+        b.set(usize::MAX, nz!(1));
+        b.clear(usize::MAX, nz!(1));
+        b.clear(2048, nz!(8));
+        assert_eq!(None, b.next_bit(0));
+        assert_eq!(None, b.next_zero_area(64, nz!(1), Alignment::SZ_1));
+        Ok(())
+    }
 }

-- 
2.55.0

