Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76029C5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F29710EEF7;
	Wed, 12 Aug 2026 08:52:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="rAipExcx";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011027.outbound.protection.outlook.com [52.101.57.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FAC010EEF7
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 08:52:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXf2NrnSIkgrdPCpqZAo9aCFlViXWpZ+RtoS2Up9qUiyxteJX5TcJ4Oe5+JXZMXH4BT/cxXHgIaZvFtugKCd+v9toixuVVc9GKSq7ohyj8nMexAabJtmP+JLQP52JRjv1G0ufng0NtjtvoNtikyK0mfOLppvOlqJvOfee6hfL1wW9j4deBohRAW+P3thPBs1uHKFiITyfoB1FXglPyG8BrBVTdai+2SyjKHiPgZ+dXVuXOEqEvU1RQwXDUHoaYAtw8Gjw8D1qV9mdxUhHysbMQZ9TKnvWDkrS1ohe/Gc4H0XbsmE0eVH5oGiMXhhfPFvFk7IPqBY5HofJzMJfxzHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBWa5tFnDAYid/53BtJQEhxB04OqYLxXPt1H44UHjD8=;
 b=XvYoin0xoIXj2MLf1AwBbGvd2cXfsAdoy1S6qWga9a+vRQOhSpHm3wLW5aUPoHi4XLM4xG8ZzRBStsc6nFh0I75oiFstTRoBzohn9kuY/W9IkorETmW/3Rgni4RHUtltkZOLU+EqpIeHZjG+h6zWGlaYhlE5gmKLgGt9Xmf2CwhF2fX9yd5Vle0KlL6GyTSm0RWsmKW1n4R81G2Ujn8zDqTshpzi1Y+N09tYSy0EageklEdTPwRSNIv4S6q4CfhWLIlX4sDM0uutC9EwHAW1fOe3hD3T2tmuPTqXtzxDd3/zYFyLGShfdwPMuYkROh7leDQ7qi/n1VHGy5J10qrCyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBWa5tFnDAYid/53BtJQEhxB04OqYLxXPt1H44UHjD8=;
 b=rAipExcxIfZG+zcZR/MndsZmu2G7dn3ptUyIRoUm4cjm8ykjfmGUvwSNd6YJ+zqYW9MShccLn4mSad0+9cuSzGcGWfQ2+OctJKqTQ2+ypwF10hnpMlgB4g+CZQO7H+F0q0PnoZZFFBBXFXdQbjjfbda8CaBxZJgsDvQxkooVn/JhzELW3hozc4q0xLrdrs1PfRJaM/esDy8nupAFNDRNnNURLUwqQaRNBW4nqKj0z/R4UBMsm5EYP9eFn95f4qZ8oiSBKS9xtiSwrpjuIWDzmjqtsg3vcAy4Zc8ZgzZHvSyG01zsGQHFU0aj9eQH8gSR+fbz7Dbqq7TRO3UFEDwowg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 08:52:00 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 08:52:00 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 12 Aug 2026 17:51:24 +0900
Subject: [PATCH v5 4/5] rust: id_pool: add contiguous area allocation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-chid-v5-4-6c767770b3f4@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0351.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::20) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 1942b742-b822-42a6-e17f-08def84ef92b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|7416014|376014|366016|1800799024|921020|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: B61lbB9KWLieQvQnzQsN5jErFgDwds8UUP+tic8X2R62Cuqee/E3Hq0WAvMaFksG4JiK1yUbE2+TPdGAsLofSyjQBHxl69XXungqyQdI1ZcZnkGwMWKTSFmXiQ7CHahLz2ge8n4czaRyBC9vme52xrvzaOjebKywBbAqpkmTLGQ+jl48W1/du1MB37KST4bAMTrR958MRNoreanDWYPx7Hwnl00eIWOjMVXdCBdz9w45aWAeFX4rMFyrwlRP9tJ6NQH5LxJjEarMT0IsXqRkqKr62Qc2TsjH/JKoaoF73oRnVe+BcGMcr0LBcgl85gIwxJg70toSjSiiLKPc5jheXLlAv8DQGPBLIH2cycftGvUtA4uqqasoqwlED6EVPwVfMg7jgntgjzhu0xFIe5AtYND37elqGmXv4dhAP/Yyd0ltPvwnWuCHyOlJbtr7McQDnIqHuyaGkEBbVdTO2TTnDV9XgWXeYygHtqXHekQEE85eCQu9WM0FKoMqK8/9HdFU72etz+hvmjCf9Qgaafw+zTvcvHFM64CcVzZx0XiVsXXGQ5bZgoRYaxm38jjtABhNVpYGMcfZEqbPrsP3C8vsDjL4tGBb++rF1fqiVGxr2QEyETy8szEA3Mst5me/Lq2BT6DOLAGm3ZL4cuzE1caAc/3Ucy+NhxgrFr3SE2rsYDbhKLFjHXkHU3lJ2QQQP5GrTKjgB7reoQ1mQrVg4cGBmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(7416014)(376014)(366016)(1800799024)(921020)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M09iQ016RFo4VEJBVmpSNnIwZzFmaXVpdElLRm9aekhNekNNdEpTcUQ3V0o2?=
 =?utf-8?B?S29CMHJkM1VSRE54RTlCbEpJL3NoNFk3NXVwSkVpeUZjeExMN29GQVJiV1Z5?=
 =?utf-8?B?RTBDcHhucDMvU0VIQUFpbWNPRG0wUEMvRnJucU9paFVDcitXTUFNZWFDR2Fw?=
 =?utf-8?B?YUVTRW1VcTJEN1ZETytpQ0hhR05NcjRaMlY5WHd0cTdlWVlHTVZJUVdHdUhT?=
 =?utf-8?B?NXd5UUdQa0ZqcHRJVU9WdjJTUFpjTVdpMDlVbzdzcFovQ0d2aVNXV3RINURL?=
 =?utf-8?B?Y2xwaTFiLzZVSFVVN1l6VmRlUzFzeGNLRmpNcVduQWJvNUtYUDRlWmdxU2I0?=
 =?utf-8?B?V1lYUDJHc083UmVzUnAzYlV6ei90RC9Qdlo1Q2E4NVB2cEJzSDA2SDhyNFRq?=
 =?utf-8?B?ZTB0WjBVZVk2SlBjSzBtZEVvUE03ZXhubzZQYlJMZzI3eXhQbkNLMVRsUWQ1?=
 =?utf-8?B?KzJPS0w4S1JueUVzZnJyb2dKOEYySlUwcDIwSWdhMjhaN0U2d0g1QThmQTE3?=
 =?utf-8?B?T0N2SEJmRjlKZWR0QkZuMThSRHJrTFR5YjcxU3RqRnRjcGVPbGlUcTdQL3Fv?=
 =?utf-8?B?KzZiai9rV1hCbmhjUERBQnRZZC95WFlya3FRSmpiTlFaQyt1aDd1aFFlL3Ux?=
 =?utf-8?B?S3ZycUtoUVh2V01Qa1VJSnpUWXhOemp3UDhpcFhaakt6UTVRYy96eG05OWNT?=
 =?utf-8?B?QXIrcFgyc25jQXJTSDhXcVd2dkNOS042Vnl1c1hQTVJ0QXZibnF6REU5QVA4?=
 =?utf-8?B?OWY1enRPdHhEWkw4YlRmQ2Zra0tiM1FBUlNBUUJadEd1Ti9TZEk0V09GbW9L?=
 =?utf-8?B?Yzg0ZFJWSTZ5QnEveUtSdzBxbE1BY2hkL1NrTXNJYmRFOU9CdEdhN1AxMDZO?=
 =?utf-8?B?WTNqeUVLS3FDRGZZUk9HZG1JS09QL1pEd0ZPVFNtSmZNRXBjR05Jc2Z1MWVi?=
 =?utf-8?B?cWtLTXJXS2k3amk4ZWxGWHlZUStvRXlmK1RhbHBGNGIvOUM3NjdNMXFEV0Js?=
 =?utf-8?B?bS84MDJOTGwvVXVwYkpzN2JrQUcxaSs2MldGbFYzd3k0RmtPd2xPUkY5OURo?=
 =?utf-8?B?VU42U25zRjh4MUI1b0EyZWMrN0czUHlSbFE5dzZldWoydTdoZmhuZ2NzWkhL?=
 =?utf-8?B?Sy8xOTMrM0JYWXNYejVMUWJIUkVLVERBQmNEbXFYck9ZdDAyU2xyaEtWeFJM?=
 =?utf-8?B?OGMrVjRTQlk3NkxXcXRNaHkrWEZKeUtjWWxrd1Q2T0ZqY1h6dDRUNGN2SXpn?=
 =?utf-8?B?TytDRXY4Uzhsd0FJT3lhK0Q4emRxWmRPMVlWYnFqTzYyOWtrZXB1cU9VUDhj?=
 =?utf-8?B?Znc4TmxLcXNGS25MeEpsanc1SnI0S0FEVXVhclZBMlQyOEgzQ29ReVp0aEZs?=
 =?utf-8?B?TU5LMkFBZkNZMHA2eFVhbFo5RFVyZmgyQTVycldtU01aNkFQdFFDYXBsbXVm?=
 =?utf-8?B?UGw2NWFjN2w1VUtJSnlCbktwdlZFK1IzQTVzbjFwRElkQi9hWWVjUmhxY2Zn?=
 =?utf-8?B?eEJLQnVkQVR5ZzhYanAvRDlraEc2djFobGt0RUZYd1AyRHk4Yko0ajhjOXFY?=
 =?utf-8?B?aDdhU1JKREhuWU84cW9KNk5vRDV5R2dXdkpsUnlaY3BHbWNZeDA3VjBvMjRW?=
 =?utf-8?B?c0dHbGFVK1JwK1Z6eEk1TVFYNWE3RDdvR0xOTHFzc0N6cUdnM0hkZWhDSXRt?=
 =?utf-8?B?eUdxOHFRYmVjYUxRaUZSeHpDSVVSSmhxR09DZC9BM0x3Y0hIeVA0L1c3T2dE?=
 =?utf-8?B?L3ZocjY5RFVrQVpiczRvVkVaaWpVaXJwNEZ5OVhOeDVsazVDai9xcFNFRkJ2?=
 =?utf-8?B?RVdxMkR6Q3NUSGN4b1ZxbjV1SjNpVzYrY3laUmJQZ0pqWllDb0tkdWdwQlA2?=
 =?utf-8?B?YjIrTUduWDVOblV2b1FLb3B4Ui9NZHdRMitIU1FxRzdheFlIT0o4UVNEeFZC?=
 =?utf-8?B?NUZMSEJwSG1JSjZzZlZsZ2NRR0kyc0Y0cFhPalZiLzdjOFJsSU9nYVVZQ3FF?=
 =?utf-8?B?OXlQbTRzV005SFdrNzByUnEzNjVaUVJCRU10ZCtPd291WHJoV0hLaGhaWmZQ?=
 =?utf-8?B?U1lMeVVkMDZFK0xDQmlsN2FWNTFGczM5WVBha0xBL2hsY2htcGE0bnRqQXJl?=
 =?utf-8?B?dGNZeldmTDRoNkM0WUhWRXVvY3ZTYjFXVW9ZOGErVy9JYTVmcDJTajFoODIz?=
 =?utf-8?B?dkhnZ3pjbGovU1pkeGszdW8wL29hcy9yL3N6Q3JQYmVpVG0wOWNkd2ZYVXdG?=
 =?utf-8?B?bEQ3Wkx3ZERrQkVTckljRmY2Rk8yZjdKQ0hnWEZ4UXVGNzlwOFhNcFEvZ2V0?=
 =?utf-8?B?NWNvVFpWdTNGK0toTTNTa0Q5UDA1WU5oVWIyd3R1MlRxQWxiekFaczl6b01S?=
 =?utf-8?Q?P6xQ8KbIp/TqeXYTVmo0o+6Chnpv+9pfssfueIG7oYPDQ?=
X-MS-Exchange-AntiSpam-MessageData-1: Ox23RJs1JLV7wQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1942b742-b822-42a6-e17f-08def84ef92b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 08:52:00.5877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4oRqAsls/bJPHNczY7Qhl3n4gp4OGKbw1sGfC1Rs1xApyO7uLlAX+H2Grc+hUO/W1HGvk+32Z1I3aJ+kfXMYQ==
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

