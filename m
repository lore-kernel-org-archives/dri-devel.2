Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49391CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FF9A10E990;
	Mon, 18 May 2026 18:11:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="a63NXPm5";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013041.outbound.protection.outlook.com
 [40.93.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A9CD10E98F
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:11:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XE3tEXg2R8otiFPT4czdJhRf7/KXZ/OBdUuv28cBt+83lpBVpWR6zOQH1ISl9+BCaH8XKGJXLgG//BKgP7qVYoTqfAVeXG4s7mGzSG3Zk0VTTW34ukmoybL1fv0OZSvLdfOKTtH0LGUC8JO1pO1UkyvyDxWAZ3XKYL6UeUkadvOMPaFbYQ6EnZzIVpVBhgVTCctZdK+pe66c81Kl9oh4QxjaRdXeMza+TVmc95BDph4JpRNnCbgImZjEIUQEL9b95tDRl90Ngr997aom2z3HuiVLCAQW+W8mw9E6pLN206arUvqiMUJI0f6gel9F6iAfEyeaanv6RniRo6v/+YNPJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYY4qn+aC6o2TZ1FYQTzJVNngDk/MRUy4aemOkDs86Y=;
 b=T5NaFYjrhDnTWH7z26d8o0pzhj1RR26cjYsIzN7jgjFIZUnW3IfshmFzKwhp98fJVoF44dlWVFUFQR9Kseu0JJGTo/aML7hFWIoQZEd0m/7SPFK2gUhipRq/uF2vujXFwLT4iFhiPg2jihCf1FGX1lteKalEY5D3U1VHQMoQy99lgOXNbbBNTUnmqHcsVzOCa3Xaq3DxTWV7Olw4dDaDAW/BxY2vb6CV+Lmd7vh6swR8wrr6yzUsa5VLxfNKGRuShQ7ncl9babPd6z/0ijrgYopbi30g/X17m+DPJ7RWJ0dTBn0VSXPY+Ub8gXqFC0TcgNIbQMOdlSrDtPbwQbuGtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYY4qn+aC6o2TZ1FYQTzJVNngDk/MRUy4aemOkDs86Y=;
 b=a63NXPm5oQ4VLWcxkxRN0EiczAJM3rDp4vPh86qeioFwGKy/ZLeKSYUz5+yHqmw7VSjT38aAO6SWcSWhAopIPquB7Y0ZGmVd/eeL4SyxKaXSsmWD+skafl7Cqi3/vGS3SrwbkcZfaCj0n05w6ZU/Tsh9A3MZCFueoRhimKqzF7ZayNTOSMWPRXLL/bwWp5d3bU9IcNn9M2ItoMiRC73gp8G9TOr6gZ0shdnQRSw1EG/JIjbLxYw4P8xaLjqEsZ0AbzkRjFgUWEOQtDM6bQ9/TKLOCZZuIyn1stgoR8eqkSl94eo1dRWo5Rq/5hUa6+FeckIrbWGYtweO+Dfx0q+osQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 18:11:43 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0025.012; Mon, 18 May 2026
 18:11:43 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, Nikola Djukic <ndjukic@nvidia.com>,
 David Airlie <airlied@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Andrea Righi <arighi@nvidia.com>,
 Andy Ritger <aritger@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Philipp Stanner <phasta@kernel.org>,
 alexeyi@nvidia.com, Eliot Courtney <ecourtney@nvidia.com>,
 joel@joelfernandes.org, linux-doc@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v1 08/16] gpu: nova-core: mm: Add MMU v3 page table types
Date: Mon, 18 May 2026 14:11:17 -0400
Message-Id: <20260518181126.2493572-9-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518181126.2493572-1-joelagnelf@nvidia.com>
References: <20260518181126.2493572-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0606.namprd03.prod.outlook.com
 (2603:10b6:408:106::11) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BY5PR12MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: e78141b3-7037-415b-85df-08deb508ea27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: Kp3Hs3rOjQHWEVgCSD4+g0gZud2wjXFbElVhzQ7/fRcGTjLICcRKFHsdTopDvVTwZkoZVN5PAk3IVlWPqhaD3QrLzfdGJ3gIdT8ERvEAi5IMk4XgOzrOCLBJgmf6Vp5wSCRUUcoxKqOG//kbyVgrR/rnIyWvrQZzo9xTHxLA/zdCp8GFjB3hLVkfGtY1Z693B5rxaFAXbyPunN07RAjR3KEUInib5ZJJzhM2NKJz64UrYwM6GCn5WY/vYpW+40pO4KAesvid8N/Yg9t7X9JjtU0X092dpuFbP27WhvVxo8aVAZAzPax6KGidrJS1hYoPqQGBfuTJ30X85cZjR1thGxnplHDsFwAqyOjhBiSo9zrxMMs1DIdXga4X6st1GwH5aOt80oJEMESfRLT1Eu0KgrAyjegkbVn0o3JsXVglXY1jv08Uh4br13t08dhKSdFn3fVWYAKp9NpAzJR5Bzj7kdVmiviVmsRl0RG9eb9N+Z6njYHcVJDIozeX5ujcQHnnMh0EjvqVPQ9Yu+sKTLQA7eEk3lCJZnZ8dgQDlaDSJo9SoX82Mmj+irI8Rw5HxbtqUj+zp5mWEXyKBI4iCLgMUTDrRNKWvdRUzo4EekaAnwTbDfEymcakDhuPqHJjWCMdTc9RSCEkm3Sdp25kpvK8PaQVNeykxOgC2pZlzlmyJxUPzqLmw+7KwrR9z/78hmNs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L7uIR2Ql8h7/sVLcHk3K7BjwmuqIFfTj9TKFKoEdretgG+QrW7NoiSX2ZWC2?=
 =?us-ascii?Q?EgOy1MtNthRYrh0nrwoLmq9T1FLWgizC2Xnx4VS/lpLISXOYh1fBcilLxYT5?=
 =?us-ascii?Q?3C7ksuW6S4ccGhTfVBrW+U2Ifu11zM7ZQ/Rs0YuJOSU42oEoKDsy/NssSq71?=
 =?us-ascii?Q?ULwth494tUIXtryN2LZWa2KM9yF21hxUhQKq56gYqtfUvEpKegpssvPql+bG?=
 =?us-ascii?Q?+iU4ZsjnkHLtCaeVaAYF8aN43MQS2LQ6N02jB2Mq6I5NdwVpqVPWr6hQhuzy?=
 =?us-ascii?Q?HA4flSHgbfdzD5DuyOPV8aHjVEv89I3QNaRvFfmWTbjs4J1F7tDQ8bTpBBjE?=
 =?us-ascii?Q?xy14f5pfXrrOrOJGCaSkGGXs1mZAiuJW+nK9fTJ9DV6sIHByUjMXlu5qBMPF?=
 =?us-ascii?Q?HoJWTsQQ1BiZWTai+g+x7i54uleNOzPPCRmjI5HOf7hAq7p0SpKM+UXA9xhr?=
 =?us-ascii?Q?Z85KXxW95GmekawMHr89gUg9iQJIrxyHxap/L50ApnAh4r51A5ZHvKB8OFbM?=
 =?us-ascii?Q?jvSW1EN+PC4D/CoE8c2JZDl2WRgDd31v5prqDpx3fcnnFhYcoHp2ysmu+iyC?=
 =?us-ascii?Q?XceAAChYshdQw9uGD4481Ir9EBFjT+yBMl0GkD0JL0t3TDmGUr3xUxxPyFuo?=
 =?us-ascii?Q?psp1EAHFFiYF255cKMPN9SNeeCz1Wz3joWM6GFCH98I/3rwoYLJv+IYZaSbg?=
 =?us-ascii?Q?BO6+6yoMSQpouq0RE+NkWhvsiIANCq6bf+gkG5GwyCH1//oN7lCsIyVICxXV?=
 =?us-ascii?Q?B2JmvEDmutduPEVnkvQy98Dt7n7eknovBBOU0n3MpEV/IwFoLk400YeTf1d0?=
 =?us-ascii?Q?bWGIa8PLl/wvYSXHCIwxssg/CPGAFIM9/5Hr0+rFWmjA6fDUQSVyCbmMUZut?=
 =?us-ascii?Q?ttSvgoW7U0ywyFK/cZx/MTp1N9h5GfOSktOhgFqpwg4kxXC2trjprq5PZp7w?=
 =?us-ascii?Q?0u46oDdbp1L3o9dDBLGBHyBW/PlOOnR1KywGxAoHgl951XEBCtRNdLecSDHX?=
 =?us-ascii?Q?3gevCKHpAwYTYo8fgv2IJ5dg7mFBkkiXbhXHL7WdLKK9skq7rvEl9gMKu0CE?=
 =?us-ascii?Q?hglY/EWc1n39TDekla8rYsrQbWOuP9ntaZZyWzF2cqSjYYatif9PyjzezKjm?=
 =?us-ascii?Q?o6y532rQLADAEfdE3IgmUlvYktScc9T4t7UmUrFj9uDoLC4vwbGjaf88MiW+?=
 =?us-ascii?Q?WRE3WYMoLcouR+hL1d4pUA+drCShJAECYROKE07o+84eWRircW6YibI2EUOf?=
 =?us-ascii?Q?xOuPVe1FdryMGUqrZ89iR9MnE9s5cjGHlGLiE1DJYnUhzE2EHLCijs8wd0t/?=
 =?us-ascii?Q?44s01AWVIIkla2AsUA14eObPMVjo5fR/DqXlr+beuXZTzHF8JN4cJr2cz2UK?=
 =?us-ascii?Q?fSuQzFqEUVODFZ1vkLCrUwySQepzqdsHI9xNf1j3hU3TsPR0KD5tDDwy6USL?=
 =?us-ascii?Q?H+0W1Pmn9k2aaS4umvUNZeW1+XRqqD5bVelWTmm/VDSH9T46z2A/qUpj9I9U?=
 =?us-ascii?Q?n37OhJWitSQzq9YfN3sCC+xsdLTpCNCJtcO8bTdQiBDSaENlkQbNp/H3Earx?=
 =?us-ascii?Q?Wc2NbIlx0Q2slHftmx6Qr/BLEwHJLxTudwg53I8oiRxwIk0x1bBGKhbwpsns?=
 =?us-ascii?Q?mjD30xxjgONaN7IpuREZjSxw8YLY5Byku3b8sy9lkJ61Vte+Q5ZxticaK+Kx?=
 =?us-ascii?Q?U7R1/3RPCbMTEMjntFKZopQtR5xbKDwypo0o75Mw2ZyBtqx7FRSSOgEiuI0F?=
 =?us-ascii?Q?bk7VEgBs0w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e78141b3-7037-415b-85df-08deb508ea27
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:11:43.4393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MX7SLh/2jZqKg5qttVcPlYvU07t9JLRCgjEdyzKSIM5dfp64jjNbRX7FHg+8AQA4Ohg/c6udkSXU9dHL4ow18w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4276
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

Add page table entry and directory structures for MMU version 3 used by
Hopper and later GPUs. The `Pte`, `Pde`, and `DualPde` types each
implement the `PteOps`, `PdeOps`, and `DualPdeOps` traits introduced
earlier in the series, providing the version-agnostic API used by the
forthcoming page-table walker and mapper.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/mm/pagetable.rs      |   1 +
 drivers/gpu/nova-core/mm/pagetable/ver3.rs | 421 +++++++++++++++++++++
 2 files changed, 422 insertions(+)
 create mode 100644 drivers/gpu/nova-core/mm/pagetable/ver3.rs

diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-core/mm/pagetable.rs
index df041fc89390..3cc546f94fdb 100644
--- a/drivers/gpu/nova-core/mm/pagetable.rs
+++ b/drivers/gpu/nova-core/mm/pagetable.rs
@@ -9,6 +9,7 @@
 #![expect(dead_code)]
 
 pub(super) mod ver2;
+pub(super) mod ver3;
 
 use kernel::prelude::*;
 
diff --git a/drivers/gpu/nova-core/mm/pagetable/ver3.rs b/drivers/gpu/nova-core/mm/pagetable/ver3.rs
new file mode 100644
index 000000000000..805be90df45d
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/pagetable/ver3.rs
@@ -0,0 +1,421 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! MMU v3 page table types for Hopper and later GPUs.
+//!
+//! This module defines MMU version 3 specific types (Hopper and later GPUs).
+//!
+//! Key differences from MMU v2:
+//! - Unified 40-bit address field for all apertures (v2 had separate sys/vid fields).
+//! - PCF (Page Classification Field) replaces separate privilege/RO/atomic/cache bits.
+//! - KIND field is 4 bits (not 8).
+//! - IS_PTE bit in PDE to support large pages directly.
+//! - No COMPTAGLINE field (compression handled differently in v3).
+//! - No separate ENCRYPTED bit.
+//!
+//! Bit field layouts derived from the NVIDIA OpenRM documentation:
+//! `open-gpu-kernel-modules/src/common/inc/swref/published/hopper/gh100/dev_mmu.h`
+
+#![allow(dead_code)]
+
+use kernel::bitfield;
+use kernel::num::Bounded;
+use kernel::prelude::*;
+use pin_init::Zeroable;
+
+use super::{
+    AperturePde,
+    AperturePte,
+    DualPdeOps,
+    PageTableLevel,
+    PdeOps,
+    PteOps,
+    VaLevelIndex, //
+};
+use crate::mm::{
+    Pfn,
+    VirtualAddress,
+    VramAddress, //
+};
+
+// Bounded to version 3 Pfn conversion.
+impl_pfn_bounded!(40);
+
+bitfield! {
+    /// MMU v3 57-bit virtual address layout.
+    pub(super) struct VirtualAddressV3(u64) {
+        /// Page offset [11:0].
+        11:0    offset;
+        /// PT index [20:12].
+        20:12   pt_idx;
+        /// PDE0 index [28:21].
+        28:21   pde0_idx;
+        /// PDE1 index [37:29].
+        37:29   pde1_idx;
+        /// PDE2 index [46:38].
+        46:38   pde2_idx;
+        /// PDE3 index [55:47].
+        55:47   pde3_idx;
+        /// PDE4 index [56].
+        56:56   pde4_idx;
+    }
+}
+
+impl VirtualAddressV3 {
+    /// Create a [`VirtualAddressV3`] from a [`VirtualAddress`].
+    pub(super) fn new(va: VirtualAddress) -> Self {
+        Self::from_raw(va.into_raw())
+    }
+}
+
+impl VaLevelIndex for VirtualAddressV3 {
+    fn level_index(&self, level: u64) -> u64 {
+        match level {
+            0 => *self.pde4_idx(),
+            1 => *self.pde3_idx(),
+            2 => *self.pde2_idx(),
+            3 => *self.pde1_idx(),
+            4 => *self.pde0_idx(),
+            5 => *self.pt_idx(),
+            _ => 0,
+        }
+    }
+}
+
+/// PDE levels for MMU v3 (6-level hierarchy).
+pub(super) const PDE_LEVELS: &[PageTableLevel] = &[
+    PageTableLevel::Pdb,
+    PageTableLevel::L1,
+    PageTableLevel::L2,
+    PageTableLevel::L3,
+    PageTableLevel::L4,
+];
+
+/// PTE level for MMU v3.
+pub(super) const PTE_LEVEL: PageTableLevel = PageTableLevel::L5;
+
+/// Dual PDE level for MMU v3 (128-bit entries).
+pub(super) const DUAL_PDE_LEVEL: PageTableLevel = PageTableLevel::L4;
+
+bitfield! {
+    /// Page Classification Field for PTEs (5 bits) in MMU v3.
+    pub(in crate::mm) struct PtePcf(u8) {
+        /// Bypass L2 cache (0=cached, 1=bypass).
+        0:0     uncached;
+        /// Access counting disabled (0=enabled, 1=disabled).
+        1:1     acd;
+        /// Read-only access (0=read-write, 1=read-only).
+        2:2     read_only;
+        /// Atomics disabled (0=enabled, 1=disabled).
+        3:3     no_atomic;
+        /// Privileged access only (0=regular, 1=privileged).
+        4:4     privileged;
+    }
+}
+
+impl PtePcf {
+    /// Create PCF for read-write mapping (cached, no atomics, regular mode).
+    fn rw() -> Self {
+        Self::zeroed().with_no_atomic(true)
+    }
+
+    /// Create PCF for read-only mapping (cached, no atomics, regular mode).
+    fn ro() -> Self {
+        Self::zeroed().with_read_only(true).with_no_atomic(true)
+    }
+
+    /// Get the raw `u8` value.
+    fn raw_u8(&self) -> u8 {
+        self.into_raw()
+    }
+}
+
+impl From<Bounded<u64, 5>> for PtePcf {
+    fn from(val: Bounded<u64, 5>) -> Self {
+        Self::from_raw(u8::from(val))
+    }
+}
+
+impl From<PtePcf> for Bounded<u64, 5> {
+    fn from(pcf: PtePcf) -> Self {
+        Bounded::from_expr(u64::from(pcf.into_raw()) & 0x1F)
+    }
+}
+
+bitfield! {
+    /// Page Classification Field for PDEs (3 bits) in MMU v3.
+    ///
+    /// Controls Address Translation Services (ATS) and caching.
+    pub(in crate::mm) struct PdePcf(u8) {
+        /// Bypass L2 cache (0=cached, 1=bypass).
+        0:0     uncached;
+        /// ATS disabled (0=enabled, 1=disabled).
+        1:1     no_ats;
+    }
+}
+
+impl PdePcf {
+    /// Create PCF for cached mapping with ATS enabled (default).
+    fn cached() -> Self {
+        Self::zeroed()
+    }
+
+    /// Get the raw `u8` value.
+    fn raw_u8(&self) -> u8 {
+        self.into_raw()
+    }
+}
+
+impl From<Bounded<u64, 3>> for PdePcf {
+    fn from(val: Bounded<u64, 3>) -> Self {
+        Self::from_raw(u8::from(val))
+    }
+}
+
+impl From<PdePcf> for Bounded<u64, 3> {
+    fn from(pcf: PdePcf) -> Self {
+        Bounded::from_expr(u64::from(pcf.into_raw()) & 0x7)
+    }
+}
+
+bitfield! {
+    /// Page Table Entry for MMU v3.
+    pub(in crate::mm) struct Pte(u64) {
+        /// Entry is valid.
+        0:0     valid;
+        /// Memory aperture type.
+        2:1     aperture => AperturePte;
+        /// Page Classification Field.
+        7:3     pcf => PtePcf;
+        /// Surface kind (4 bits, 0x0=pitch, 0xF=invalid).
+        11:8    kind;
+        /// Physical frame number (for all apertures).
+        51:12   frame_number => Pfn;
+        /// Peer GPU ID for peer memory (0-7).
+        63:61   peer_id;
+    }
+}
+
+impl PteOps for Pte {
+    fn from_raw(val: u64) -> Self {
+        Self::from_raw(val)
+    }
+
+    fn invalid() -> Self {
+        Self::zeroed()
+    }
+
+    fn new(aperture: AperturePte, pfn: Pfn, writable: bool) -> Self {
+        let pcf = match (aperture, writable) {
+            (AperturePte::VideoMemory, true) => PtePcf::rw(),
+            (AperturePte::VideoMemory, false) => PtePcf::ro(),
+            // Sysmem PTEs use uncached+no_atomic PCF for cache coherency.
+            (AperturePte::SystemCoherent, true) => PtePcf::zeroed()
+                .with_uncached(true)
+                .with_no_atomic(true),
+            (AperturePte::SystemCoherent, false) => PtePcf::zeroed()
+                .with_uncached(true)
+                .with_no_atomic(true)
+                .with_read_only(true),
+            (AperturePte::PeerMemory | AperturePte::SystemNonCoherent, _) => {
+                kernel::pr_warn!("MMU v3 PTE aperture {:?} not supported\n", aperture);
+                return Self::invalid();
+            }
+        };
+        Self::zeroed()
+            .with_valid(true)
+            .with_aperture(aperture)
+            .with_pcf(pcf)
+            .with_frame_number(pfn)
+    }
+
+    fn is_valid(&self) -> bool {
+        self.valid().into_bool()
+    }
+
+    fn frame_number(&self) -> Pfn {
+        Pte::frame_number(*self)
+    }
+}
+
+bitfield! {
+    /// Page Directory Entry for MMU v3 (Hopper+).
+    ///
+    /// ## Note
+    ///
+    /// v3 uses a unified 40-bit address field (v2 had separate sys/vid address fields).
+    pub(in crate::mm) struct Pde(u64) {
+        /// Entry is a PTE (0=PDE, 1=large page PTE).
+        0:0     is_pte;
+        /// Memory aperture type.
+        2:1     aperture => AperturePde;
+        /// Page Classification Field (3 bits for PDE).
+        5:3     pcf => PdePcf;
+        /// Table frame number (40-bit unified address).
+        51:12   table_frame => Pfn;
+    }
+}
+
+impl PdeOps for Pde {
+    fn from_raw(val: u64) -> Self {
+        Self::from_raw(val)
+    }
+
+    fn new(aperture: AperturePde, table_pfn: Pfn) -> Self {
+        match aperture {
+            AperturePde::VideoMemory => Self::zeroed()
+                .with_is_pte(false)
+                .with_aperture(aperture)
+                .with_table_frame(table_pfn),
+            AperturePde::Invalid
+            | AperturePde::SystemCoherent
+            | AperturePde::SystemNonCoherent => {
+                kernel::pr_warn!("MMU v3 PDE aperture {:?} not supported\n", aperture);
+                Self::invalid()
+            }
+        }
+    }
+
+    fn invalid() -> Self {
+        Self::zeroed().with_aperture(AperturePde::Invalid)
+    }
+
+    fn is_valid(&self) -> bool {
+        Pde::aperture(*self) != AperturePde::Invalid
+    }
+
+    fn aperture(&self) -> AperturePde {
+        Pde::aperture(*self)
+    }
+
+    fn table_vram_address(&self) -> VramAddress {
+        debug_assert!(
+            Pde::aperture(*self) == AperturePde::VideoMemory,
+            "table_vram_address called on non-VRAM PDE (aperture: {:?})",
+            Pde::aperture(*self)
+        );
+        VramAddress::from(self.table_frame())
+    }
+}
+
+bitfield! {
+    /// Big Page Table pointer in Dual PDE (MMU v3).
+    ///
+    /// 64-bit lower word of the 128-bit Dual PDE.
+    pub(super) struct DualPdeBig(u64) {
+        /// Entry is a PTE (for large pages).
+        0:0     is_pte;
+        /// Memory aperture type.
+        2:1     aperture => AperturePde;
+        /// Page Classification Field.
+        5:3     pcf => PdePcf;
+        /// Table frame (table address 256-byte aligned).
+        51:8    table_frame;
+    }
+}
+
+impl DualPdeBig {
+    /// Create an invalid big page table pointer.
+    fn invalid() -> Self {
+        Self::zeroed().with_aperture(AperturePde::Invalid)
+    }
+
+    /// Create a valid big PDE pointing to a page table in the given aperture.
+    fn new(aperture: AperturePde, table_addr: VramAddress) -> Result<Self> {
+        // Big page table addresses must be 256-byte aligned (shift 8).
+        if table_addr.raw() & 0xFF != 0 {
+            return Err(EINVAL);
+        }
+        let table_frame = Bounded::from_expr(table_addr.raw() >> 8);
+        match aperture {
+            AperturePde::VideoMemory => Ok(Self::zeroed()
+                .with_is_pte(false)
+                .with_aperture(aperture)
+                .with_table_frame(table_frame)),
+            AperturePde::Invalid
+            | AperturePde::SystemCoherent
+            | AperturePde::SystemNonCoherent => {
+                kernel::pr_warn!("MMU v3 DualPdeBig aperture {:?} not supported\n", aperture);
+                Ok(Self::invalid())
+            }
+        }
+    }
+
+    /// Check if this big PDE is valid.
+    fn is_valid(&self) -> bool {
+        self.aperture() != AperturePde::Invalid
+    }
+
+    /// Get the VRAM address of the big page table.
+    fn table_vram_address(&self) -> VramAddress {
+        debug_assert!(
+            self.aperture() == AperturePde::VideoMemory,
+            "table_vram_address called on non-VRAM DualPdeBig (aperture: {:?})",
+            self.aperture()
+        );
+        VramAddress::new(*self.table_frame() << 8)
+    }
+}
+
+/// Dual PDE at Level 4 for MMU v3 - 128-bit entry.
+///
+/// Contains both big (64KB) and small (4KB) page table pointers:
+/// - Lower 64 bits: Big Page Table pointer.
+/// - Upper 64 bits: Small Page Table pointer.
+///
+/// ## Note
+///
+/// The big and small page table pointers have different address layouts:
+/// - Big address = field value << 8 (256-byte alignment).
+/// - Small address = field value << 12 (4KB alignment).
+///
+/// This is why `DualPdeBig` is a separate type from `Pde`.
+#[repr(C)]
+#[derive(Debug, Clone, Copy)]
+pub(in crate::mm) struct DualPde {
+    /// Big Page Table pointer.
+    pub(super) big: DualPdeBig,
+    /// Small Page Table pointer.
+    pub(super) small: Pde,
+}
+
+// SAFETY: Both `DualPdeBig` and `Pde` fields are `Zeroable` (bitfield types are Zeroable).
+unsafe impl Zeroable for DualPde {}
+
+impl DualPde {
+    /// Check if the big page table pointer is valid.
+    fn has_big(&self) -> bool {
+        self.big.is_valid()
+    }
+}
+
+impl DualPdeOps for DualPde {
+    fn from_raw(big: u64, small: u64) -> Self {
+        Self {
+            big: DualPdeBig::from_raw(big),
+            small: PdeOps::from_raw(small),
+        }
+    }
+
+    fn new_small(table_pfn: Pfn) -> Self {
+        Self {
+            big: DualPdeBig::invalid(),
+            small: PdeOps::new(AperturePde::VideoMemory, table_pfn),
+        }
+    }
+
+    fn has_small(&self) -> bool {
+        PdeOps::is_valid(&self.small)
+    }
+
+    fn small_vram_address(&self) -> VramAddress {
+        PdeOps::table_vram_address(&self.small)
+    }
+
+    fn big_raw_u64(&self) -> u64 {
+        self.big.into_raw()
+    }
+
+    fn small_raw_u64(&self) -> u64 {
+        self.small.into_raw()
+    }
+}
-- 
2.34.1

