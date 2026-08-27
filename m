Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFE4C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:31:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94E0D10EED4;
	Thu, 27 Aug 2026 07:31:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="D8XgOO57";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0BEF10EECF
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 07:30:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSMIysy+TTsIDKRwBuEOtiixG2mesVw0xzZh3lvnAclW0OpfjSuTCiUtDFLR7ljrnfGMDdhvCBPf6cIDo1ax+TXmJRzz7qofOa7iV3dbLHkX2jdYMj3HHzojyo0yp9MOOcYv9pCTHhtbF6BT1Ujza5NT0Fjffd0foDBrdIJpuVG8aXGFj+8zw4DP+TS6+Tia5ae8t4MBodVHM96qkQg3x3vi6njQSBRJjhHqllU8BAsXKvpnW1eabEu0ofuTVeUzVXoPgmcLfqbK3rDqZD5gDhM364BBFvJz5TE2vK9xzYWSYAdde28rppdnFRjSz9ZWuUHB7F0IRUrbPKE9VXP78A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Y9HWLj8CuT0Jqtkjv0uqNaXQWOeFc2SxMxakslgRLk=;
 b=hEjMx4nz+OJjkY3Is7gVLpOcMdyZ8bLt2y+xycXXy1+Au/2Y6Ds6Jv7CzT+kM/3uD/j2uUVut1xKiq9WDo5+bk3GXJEQbDzYSUc9+ufc1RQ3jfxUuK0T2VCqy7d98SXJytncdWFhO85ooFB011fWEHhndrYabZnTx4M3dpq6ywWVHE3HbDL5Es0greuA40F26YG/ze7ZxQH0sfQVyuqfuP7axO5apbd1BqSkjmpgYuI3ID8hsr99OhxSiDFY2baAIG3+IeXbk4l6jyGxLeF3cFD0hKSpvHxTHoWSehO49JWB/FxPmACrAPMApIE4ZK763yaAYup1fTaloRdRmfOI1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Y9HWLj8CuT0Jqtkjv0uqNaXQWOeFc2SxMxakslgRLk=;
 b=D8XgOO57XapZRMOIOuaJmYKaRu8rankssPsXPRsOSBnUq4oL9mn0UglOrZkU48aEasyiEK5Eq0hHZzZmHDlc8rrtR4G7N5MwTIlBQRjJha1QGwdPEYfsLOgHZB1nHqhYvooQR63oR+m63wNva6zvUYUnDIiYBslqPNSQ9EWZYzOtUYP4Kh7Ym1o8VoCtv6b53ejZYjoVzvkt2MRahp+O05TPU5sW8js0dSLryT/igysZll2CSR72klnWls+/0tALmF8XTB5gSx1IQzbydSqn3jX0zli1h4LMetxnp5nEPufz5OnCDOfbmuEamlTnwce7fON/FyMhbt9mqDHry0dVlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS0PR12MB999081.namprd12.prod.outlook.com (2603:10b6:8:2ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 07:30:52 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 07:30:52 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 16:28:37 +0900
Subject: [PATCH v8 09/12] rust: bitmap: add contiguous area operations
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-chid-v8-9-bc74c77d0214@nvidia.com>
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
In-Reply-To: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
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
X-ClientProxiedBy: TYCP301CA0036.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::20) To IA1PR12MB6411.namprd12.prod.outlook.com
 (2603:10b6:208:388::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS0PR12MB999081:EE_
X-MS-Office365-Filtering-Correlation-Id: 0270a2b0-745e-414c-9acc-08df040d1fb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|366016|1800799024|376014|56012099006|6133799003|10067099003|18002099003|22082099003|11063799006|5023799004|921020;
X-Microsoft-Antispam-Message-Info: UQn6wLbPqSNjGjInojsxgytTprYbXqiXx1qg1PuU2D+XBUCGxLXP+g+vfkMPvf5zDow8QTphOZuu4TcBGUa7FjevZ35ud8cBHVYmSZsxvTmDGbVTDNZ6E9IWpL6/welMl5MbCx/6xkhwFsljy6HjmRSLWOLWIRSmjUbsPiotEUjXD4Az10oaD3El3A5EtUxvPk8/rncwXs+0ztY8U+DPz79amK9+aVVP2NXo4w/2U859L0ZYimlgNSBveqfavLuCwK+HR+pdrioAmtQPdiFHJM3Cd5esAZV3uk2TyyCKbmkypRhui+Gxbnf7ZvMcpsK67DDb2XEePSWAEGZZZH3FcWXP0szFluhE7z2CNZYHvQVVymyz8QoqJ9VGFhUq/skbDCSmKrs0Y+3VZnbj4dGFhQT4wBVirAGHmvVZiwMQsqScEEfLE/47dWmVvu+8cTdcFmvUYZJZaGpFVh5jtb1lJvIfajNRzp/y8MeNZVtFhcga5Fq5mw+tJ8Hn8Fh2f4SJY+HeU4ipmaddWaoJChSVqBE+KIMj0yN1yUaxWqK+pgDvx8d9RDyA76sN4BP6SQ7AQ25fhSXr5XCdsJv9G3962UfAVfhBxsdNvXOdYLQwTPW5viAeu+ShcumdyiTwDB12Yf3tSwBa8r6NlkJIkVauwSY3Tw78sWGQ64RAhT5IH1rgZVRf1b9DXfmCOflKluYk+cuMnyHe2Ag7Lrf5K0kUAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(366016)(1800799024)(376014)(56012099006)(6133799003)(10067099003)(18002099003)(22082099003)(11063799006)(5023799004)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUhFckI5TjY3SEF6ZWVVNEZJeDczMHB3cmFGMm81emNqaE40MEIwdkFBVzFp?=
 =?utf-8?B?emNHK1M1UU1ZZHU4VE1jdGNyYTJlL3ZsOTloTTExVkJweVZlYXpidUlxWERh?=
 =?utf-8?B?b2Nsd2xBRG9Obkd1ekgzTU5uL0tFUmdxNzZoL21Oc1dJc3ZLaTVtZ1h4Zjl3?=
 =?utf-8?B?VFo0Q2RoZmJTd0RhSU8yd29uUWpaU1cvK25nZG5vVmVPSmEycU9IQis2bm1I?=
 =?utf-8?B?ZkUzeUxoTElpMVpCN1k5U1R0eEY0TzNWaDhsdm1FWFcwc3prY1lyVEpvbWwx?=
 =?utf-8?B?cndZelRRZGJpeTB1SmJ4Wm1HL0FSTGt3T2pENEdrejB2UWNPUURHYmd5M2x6?=
 =?utf-8?B?WWs4UUgramF2SC9pK0dOZklEUi9hK2tYcHZ4V0hONzZsZzVzWDRKQU9JZlZk?=
 =?utf-8?B?alA3TzRVVXdhY0tsdE50b0RsSWZ5S3FuTmdzMkYxdDhNNXpybjlMdllkZnR0?=
 =?utf-8?B?cjczRFJCbDhTSEpycjh5MFB0eVlsdFN4Rjd5Z2hmdTAvVkJrT0wrOWJLZ2Jm?=
 =?utf-8?B?UEsvbDVaTmEvTlpDVjF5bC9xbzlwYzNZZUpkVDc4RE9RanYyQnFDclk1dTlp?=
 =?utf-8?B?bUo2Y3YvbnVVU0Z4dHV2dmd6VDBTVUFROFd2dmVpUHpwRW8rZkRvUHBGeUpt?=
 =?utf-8?B?ZUpnZmppMVZmVUUrM0o5TnppeTBOT0ZyRUhaZi9mb3J1akxTeWEzV1d0T3dt?=
 =?utf-8?B?OFlBcEJpMDUzMnpwano3Tlc3ajlGT2JGWVljUnFFT28wc2lkV2VSd00wT2Vl?=
 =?utf-8?B?RGU0Znp1VENFZzRONllIbUpTcHdaUmFmTlNhOTNBUk5uTlBlRU1DRWk1bm9R?=
 =?utf-8?B?YVhXeElWNjhteGtFWDUyVUJ3QUY1TVlWbmxtRnJWeHhhekVwcVovQUxhSHUv?=
 =?utf-8?B?aHRpRjFIQmExZEZFWGFpcFNnNWJWS0JKY1k4UU4vUlJlQTJpNFpoUnM5VUg5?=
 =?utf-8?B?Nzg4c0IrU0RUOUprNlJ6cEZJdmpuNGxLZ3hnbHhzV3dndHZRKzREZy9DYWZ6?=
 =?utf-8?B?K0xRUERkcGZaZzlHK3Nzc0dCZzdjbGFLamdVd29LcVB4bUs3MUUyUTJKZlFm?=
 =?utf-8?B?WDRSK3RrdlRDZi90cjR3QVB2MUdtQ3RvWHBOaGpxblZCRmF1UjU0Yi8vOWRR?=
 =?utf-8?B?QUVFQWQyYVhFYjZqcFFEZHhGNktWQWFhMkc1WVpRR0NuaG04dFRWM0hKTmZ5?=
 =?utf-8?B?aGZONXNRZ3IxS0lPTThucjNhRGtlL3pDamtYSmZ1TG5uaGpnQjF3cTVLemJ3?=
 =?utf-8?B?bVBRNHk4MVE0SU1TR1hMTUFkTDZaN1grNmt1eEpwUU9YNFV4UERDUTU5Yks0?=
 =?utf-8?B?cmFacTJGMEpWczNaL3k4eDgzaXE1NHA5MmFKM0dZNGVWTWFkaGtUeTNyaHpk?=
 =?utf-8?B?clZROWNQRklvUGFweExsTC9mUWVsUDFiMXNESHk0N2U1eFB1dWk5elZqbGNS?=
 =?utf-8?B?N0g0Q0owMWFQTm0zYzVFZlBJakdmOFpXN3JKMis0bzR6Rk04VTVoL2xkUHJO?=
 =?utf-8?B?SjdmM2s1R3BhN1d0NUwwVnNZem44Ukl6SGd0MC9xb1RQZHBGaVRsSkhGSXVX?=
 =?utf-8?B?QXU0UzlOdEorUGFwaTlpcHg3c2hYTGxuUi9jTWQrZ3VkeTZ2UDlMVWpmSlNE?=
 =?utf-8?B?QzBjb3d1b1Arbmx6WmdCNFJIeUpFRG1uUzVFZEZ2dlU4L2IySmY1bjFFVDFM?=
 =?utf-8?B?UUF6RjBqcXQ4ZmxUU1V2MlBtRXFwNnFPeFpsQ0pGcGtGRS9MVm1QVVM3VjM4?=
 =?utf-8?B?K3BQeDhVUjhMNmxsdU5nSVVkejR1dUFzSXhESEJuWHZndTRrdUhtZjlOcHgr?=
 =?utf-8?B?Qjlzc2ZsdW5tcWxVT0dUV0dsZVlxVzZ1TGp5MktRZXdQNENYWEtkWDZLeWNZ?=
 =?utf-8?B?TEl0V0h4bVdvekZzR3ZlN0ErT1hTRE8zRTdCZGErbi9XOG4xKzl3Sm5WSXF3?=
 =?utf-8?B?VzBVV1pERlVxdm4yMzBhQndxLzNLMDRVQzFZdWdzMks5Q0NXTXZaTlNwc1VW?=
 =?utf-8?B?Z1dseHliUm5ESnBXcW00L09NWDJkNXVLb0poeTdlb0dBWitYQ3BtQWtPZWYz?=
 =?utf-8?B?akY4anEzZXFJQzhMcEFpZnpmWmZWUTRUbWs5ZFNxeEhhNytNbjNkejRzK09r?=
 =?utf-8?B?ZWhUS2FzaG53TWxDNlFPWURQS0d5SFljZy9uejNjSnlIMGo5UzAwOWlYeWw4?=
 =?utf-8?B?SnVYeE1pTGovTU5wNjRPNzgxeGViTTl1UWVWVE9CYmtIVWNqd3NGWVBLTDJX?=
 =?utf-8?B?eHNXd2lZcU1Pd0lQNjAzaElITVRCdkZScVVNUGhhUVN6VGZXMHRTaTFKSUZm?=
 =?utf-8?B?SXN1dzlGeXBxY0dXeCtxMm5SN21YKzdzQVhDcGVkR2liNWRNWHUrVXJGV0Rt?=
 =?utf-8?Q?PcNDw5WRQr3JNuGzeH3hIKkOlMcowASf0eREnDd/EfX5d?=
X-MS-Exchange-AntiSpam-MessageData-1: VOfRQzJGYqZGAg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0270a2b0-745e-414c-9acc-08df040d1fb2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:30:52.7688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pI2MaVYiBaHN5I3HMhi1GDnpSHFxNTqCinBYWK4mpNGB1A21oGV5+Q6vddn7YCtEMAF9jBLPvMvVQdiFX3+9NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999081
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

Reviewed-by: Burak Emir <burak.emir@gmail.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/bitmap.rs | 241 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 239 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index df5505ec7a96..23c2b43a98ac 100644
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
@@ -525,13 +529,159 @@ pub fn next_zero_bit(&self, start: usize) -> Option<usize> {
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
+    ///     ptr::Alignment,
+    ///     sizes::SizeConstants, //
+    /// };
+    ///
+    /// let mut b = BitmapVec::new(64, GFP_KERNEL)?;
+    ///
+    /// assert_eq!(Some(0), b.next_zero_area(0, cv!(8), Alignment::SZ_1));
+    /// b.set(0, cv!(5));
+    /// assert_eq!(Some(5), b.next_zero_area(0, cv!(8), Alignment::SZ_1));
+    /// assert_eq!(Some(8), b.next_zero_area(0, cv!(8), Alignment::SZ_8));
+    /// assert_eq!(None, b.next_zero_area(0, cv!(65), Alignment::SZ_1));
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
+        num::cv,
+        sizes::SizeConstants, //
+    };
 
     #[test]
     fn bitmap_borrow() {
@@ -642,4 +792,91 @@ fn bitmap_copy_and_extend() -> Result<(), AllocError> {
         assert_eq!(Some(17), long_bitmap.last_bit());
         Ok(())
     }
+
+    #[test]
+    fn bitmap_area_set_clear_find() -> Result<(), AllocError> {
+        let mut b = BitmapVec::new(128, GFP_KERNEL)?;
+
+        assert_eq!(Some(0), b.next_zero_area(0, cv!(5), Alignment::SZ_1));
+        b.set(0, cv!(5)); // Now contains {[0, 5)}.
+
+        assert_eq!(Some(0), b.next_bit(0));
+        assert_eq!(Some(4), b.next_bit(4));
+        assert_eq!(Some(5), b.next_zero_bit(0));
+        assert_eq!(Some(5), b.next_zero_area(0, cv!(5), Alignment::SZ_1));
+        assert_eq!(Some(8), b.next_zero_area(0, cv!(5), Alignment::SZ_8));
+
+        b.set(8, cv!(8)); // Now contains {[0, 5), [8, 16)}.
+        assert_eq!(Some(16), b.next_zero_area(0, cv!(4), Alignment::SZ_16));
+        assert_eq!(Some(16), b.next_zero_area(0, cv!(4), Alignment::SZ_1));
+
+        b.clear(0, cv!(5)); // Now contains {[8, 16)}.
+        assert_eq!(Some(0), b.next_zero_area(0, cv!(5), Alignment::SZ_1));
+        assert_eq!(Some(8), b.next_bit(0));
+        assert_eq!(Some(15), b.last_bit());
+
+        b.set(60, cv!(10)); // Now contains {[8, 16), [60, 70)}.
+        assert_eq!(Some(60), b.next_bit(16));
+        assert_eq!(Some(69), b.last_bit());
+        assert_eq!(Some(16), b.next_zero_area(9, cv!(40), Alignment::SZ_1));
+        assert_eq!(Some(70), b.next_zero_area(0, cv!(45), Alignment::SZ_1));
+
+        b.clear(62, cv!(6)); // Now contains {[8, 16), [60, 62), [68, 70)}.
+        assert_eq!(Some(62), b.next_zero_area(60, cv!(6), Alignment::SZ_1));
+        assert_eq!(Some(61), b.next_bit(61));
+        assert_eq!(Some(69), b.last_bit());
+        Ok(())
+    }
+
+    #[test]
+    fn bitmap_area_exhaustion() -> Result<(), AllocError> {
+        let mut b = BitmapVec::new(64, GFP_KERNEL)?;
+
+        assert_eq!(None, b.next_zero_area(0, cv!(65), Alignment::SZ_1));
+        assert_eq!(None, b.next_zero_area(0, cv!(usize::MAX), Alignment::SZ_1));
+        assert_eq!(None, b.next_zero_area(1, cv!(usize::MAX), Alignment::SZ_1));
+
+        b.set_bit(0); // Now contains {[0, 1)}.
+        assert_eq!(None, b.next_zero_area(0, cv!(usize::MAX), Alignment::SZ_1));
+
+        b.set(0, cv!(61)); // Now contains {[0, 61)}.
+        assert_eq!(None, b.next_zero_area(0, cv!(4), Alignment::SZ_1));
+        assert_eq!(Some(61), b.next_zero_area(0, cv!(3), Alignment::SZ_1));
+        assert_eq!(None, b.next_zero_area(0, cv!(1), Alignment::SZ_64));
+        Ok(())
+    }
+
+    #[test]
+    fn bitmap_area_off() -> Result<(), AllocError> {
+        let mut b = BitmapVec::new(64, GFP_KERNEL)?;
+
+        b.set(0, cv!(5)); // Now contains {[0, 5)}.
+
+        // The area plus align_offset starts at a multiple of the alignment.
+        assert_eq!(Some(7), b.next_zero_area_off(0, cv!(8), Alignment::SZ_8, 1));
+        assert_eq!(Some(5), b.next_zero_area_off(0, cv!(8), Alignment::SZ_8, 3));
+
+        // A zero offset behaves like next_zero_area().
+        assert_eq!(
+            b.next_zero_area(0, cv!(8), Alignment::SZ_8),
+            b.next_zero_area_off(0, cv!(8), Alignment::SZ_8, 0)
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
+        b.set(64, cv!(4));
+        b.set(62, cv!(8));
+        b.set(usize::MAX, cv!(1));
+        b.clear(usize::MAX, cv!(1));
+        b.clear(2048, cv!(8));
+        assert_eq!(None, b.next_bit(0));
+        assert_eq!(None, b.next_zero_area(64, cv!(1), Alignment::SZ_1));
+        Ok(())
+    }
 }

-- 
2.55.0

