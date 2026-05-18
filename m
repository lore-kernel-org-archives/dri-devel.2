Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A84CD4F58
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:12:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EA8910E99C;
	Mon, 18 May 2026 18:12:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="L2ekmmY6";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C960610E985
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:12:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqaSjTyPth3hdcJgOXeaTDCtj2yElgU9mrhrebMaQRBBCm7M0AdKdJ0c1bh3pDqVFCltjWjTEehwBRzbEVrqG/GYKkoE1ovQ19s8xO0PGv9/39Ay/dZEbR+oCoSR2Q6eaXfdDo/C+2QIM/Y0GxtRxVd+1BuqZXgkD3nb/Fqih31NAZKisQWTQmyLFe1JdYoG9UnZEJ+RLOlBdDPiyl0ltyU2Sa6rZtmtA8+YycIsAcnzymTVCsg/yhoA2v6Yoi3+SUAv6trE5mreB+bC4UHzBxhGZ6XsdV9rcTondpjNQN470IYkvfQ4NwkF9uKSqQNPAPVCjNRBn+zsn0sOMdio2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sM9iioe54Q374I19LlhS3BBMvNUoUaKfXk4drH8Z32A=;
 b=BJZVqy4kgmcjbL5RtvqcikXNXvT5d7De9EP7Qom6owiqItE8DPOwDaPhP980zkWMj4uAxRi/RbR4xKjOJC0BLB8y6xNgDewkpuNq9u1jVIhg0MRvDKU5eyo/2Gk+v8qUM0L3VB0xUx8ENlzJcm9cYdH+JAQGHWkq4ChrEGhygktyObdjLLhNbptUyJEaFE9h8/Z6NOcIckrWS2zEVwidbsyQqeON71K2qlCythjwj6MBnNhv9EuRRVEMipG+TbEG66srjj3Lot8ry7Vcw2FY77qWwCKVJBXhQoKA5jK3HoDzmmeF4kGAMAt61LNwuZlJSVIcMEnF1CZlXxfrkRwP9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sM9iioe54Q374I19LlhS3BBMvNUoUaKfXk4drH8Z32A=;
 b=L2ekmmY6J4uNUz0RhEYXg41crMeYdw4WvaXzHwSMuBUKmSTJVl9yi2Ph/X75E9dOSfAYHq15O6N75L4X7NKGPnVT/lsTr8g5DzDm/gYKaTfWFxqH2jcSr6I41Ro2RTfIJfp+2HBIqUW4BzCfhpPVwxciNeVimpSzwnuBtvk61d9YFb7z80SLK0kvoW02hydpMzBxvNfJSYzW4ik6Qh26AtPMETd3MSuFhK6BINL8UGR5bECgSVjvPkq6lcTJDDcZoAeUXgW0kbZqvu5Ct5gknUWc+VAdctEA7qMtcjUM4742gfwLE7eAHPzPGaemD++NPIA3hthW+iv0bPQ/0xv15w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CH3PR12MB8727.namprd12.prod.outlook.com (2603:10b6:610:173::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 18:11:50 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0025.012; Mon, 18 May 2026
 18:11:50 +0000
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
Subject: [PATCH v1 13/16] gpu: nova-core: mm: Add multi-page mapping API to VMM
Date: Mon, 18 May 2026 14:11:22 -0400
Message-Id: <20260518181126.2493572-14-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518181126.2493572-1-joelagnelf@nvidia.com>
References: <20260518181126.2493572-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0001.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::6) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CH3PR12MB8727:EE_
X-MS-Office365-Filtering-Correlation-Id: a94413bb-7a9c-4247-4df9-08deb508eead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|11063799003|22082099003|56012099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info: Ktzqf7l8Z36U2fulqkvI0Y/AgYdrs3rd64jK0U8mD8nyldmuM6aS/HPWQbu2V5KhRWk77VnnN3q25mlpHd9bMqySalg8MzFrQNK5GYHB5hptYpTSJmasl1x3bkSFuUaYn+8jO2wJy5w6MxinnaKfRVkHhgPxNgQNOWIf5PTiI7JNJ9JNfCY+f20SqJxPA6Fy0fW0u5yu97mimzz8g+2PditV5VaAjESJ6NaoSfwMlQgVgD5zWyXjhDCZe9aJZ1hbSpiGQEZv1MDcIvTmrUGiTelP2qeOWHd85lmQEKc3VFA0oXHXOlYErWwCE7kp45JCtLVPtYuzOaVL0Jn5gMoyW547FmWBBTM6nhg8eiYE7nnSz3NgyWEIqxlvLiFWOBR0tRbaJECdAgI05e7xUOZifVKY8EW88uK1+Lqm6VNT2F+NQviauvXfce8OKEWrIeug2XreyhC6KHYAlF+mK7z/cwyF82CO3xRj9ogBOw/hM5YZOAyeV4L7se//OR9wDvqrDDRpx1NsMG/Kgq1A+HHy/t6ulA0ylZnCKs/K7EiDu3NfXotBjjE61gYhI5dJe0DMgQaUvo19Fpbh4lCzzXtkpcT3ZyhwjQxIJv1yzoggmjQ4/ta6QF95NplpWVNzJiZbBpNXOLSu3UVSPsxU2SKXreMgsbUwejSFanE4sTCUMUWG4UbOa05XTlt4JBoCPBhH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(11063799003)(22082099003)(56012099003)(18002099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CRAmj64UliiAbrUoUvn/ADmbDeWHNlGXa4ZLf+NtPIR1MDoZhCLUFZj2/LdT?=
 =?us-ascii?Q?Id4nb/FyXgfBVEBNY8WVMDAHGkQH2+Yc5wEpjeAFrDj8JKLvcaCo/CeJj8LS?=
 =?us-ascii?Q?n5vrQOF9u44prQRrPexo42F9vvFIrsAOZfaglZoQ/BAGTLI1jZBCFlfVMOcf?=
 =?us-ascii?Q?B1nloC4tzzP9ZLm/Y7Ar5z01CdjcgsyfgNZiGddeqnbwn/oILHZTEY6gjk0W?=
 =?us-ascii?Q?5LCXZ14FspDdoR2Npk7Ff88DNqOsveNqip3C4cdc3bp/K8b8o3EGc82unNaJ?=
 =?us-ascii?Q?9q3b5v5zf1bMhGKTcOE64BqyC+2PQFJebDUsFVa/Ej5HnvkiAv5mH05pfFx0?=
 =?us-ascii?Q?t3nprH7tXr9bEJyjLM6hGBlyqO2ZbbmCsQ6kSUT59ltaVlYa7YfkZjPK/JcY?=
 =?us-ascii?Q?4lsrrjMElyIXQEOrIJ84R3TxlB+fS25r351RaZzKi/hdgRbgWFfaN2N/Wvam?=
 =?us-ascii?Q?p8fd07cN/KBdy2HdmlK1jz9zANJ7FtRo4db9cZwW+14WRxAW2ZkWprWvWUig?=
 =?us-ascii?Q?7j/A6QUCgZWm5rfxCDhYINTiYO+tE7tXqtcnmDyT9RhUmpCA7JrBhwgrF6/Z?=
 =?us-ascii?Q?rMSy8pewq6LphhHqQdHNvVNHQElc4d2XVkFIC1Qlx0U6f6KCL2nVRIdLKsuM?=
 =?us-ascii?Q?fbSvsqgtSIeyluYAqODtBvUAKkMTE15eqs5X4qN/Dp1+i0/TsamLm7RsZvwD?=
 =?us-ascii?Q?gikRhhVTeQAJV/VU8Wefj7WCbeUBVmLfkRCFcjBN1TNFbynOSjbbV04/BkQD?=
 =?us-ascii?Q?q6pM8zyedx4cjBYNJIgGfw/vI4qv+91z6/lzr7F+uuOayc6kuB+RD2c7qSnx?=
 =?us-ascii?Q?XI5UXKJuH0OBpvQynfEs4DoSXLPGrsqhVQnA07hvwMGDPSBsWRZ7RszPYHNs?=
 =?us-ascii?Q?fM6pl3lGCdgwDwdF+vbzRFhxFgbABNu51gFNwT82MYdazDQLgoIbZWD6CF1h?=
 =?us-ascii?Q?oWB7lJPmKRMumQ6mJuqIcc/E0bQTVlvbfiWE56OPx1VSmOGFRRWyd9a6E6Hr?=
 =?us-ascii?Q?7MxxcnijsHmCX+8Ct//4WbpTmJFLBKe1PfbO7x3SwcS5Cd9x7NjMYUH9v729?=
 =?us-ascii?Q?g21nq/Swt5c7yqmwYHVCxzcylnPfspaMPYNXRlrCidHb60yIHPrgzStrwLZ2?=
 =?us-ascii?Q?MbHUbvwmZFazk6FqFwUfjqIuBhJ/yyy2Dqn+HHtGy6hiI5rgkvfUiME7FVCi?=
 =?us-ascii?Q?XBz7hQhH61vi0rfE35twixObYEGzwZ/jeO04w4dPEuuEp3tBjedhzSp/ud3Y?=
 =?us-ascii?Q?fNB/ZNIQMHj/KdRi1ovtR7egLAFqGVMGXq0MhrbLSJMp7P9oRNhWZThL1cDf?=
 =?us-ascii?Q?K5b5XniQEHUxvSXesO8K5ns5+zyxqDzoYyRJjjgIK1jKI+txfuNj7grp15rO?=
 =?us-ascii?Q?qIEy5QD1FUA7oI+8CzSfRloY0VQE0cyY9wb256lUua2XviiHfLW6gQc7/Hq8?=
 =?us-ascii?Q?jluJtumwf42Vo5/fhqTdZ/lq6Q87T50imsunYAxHjitI0buKMAcJlVyq8PyD?=
 =?us-ascii?Q?Mk+AhkS+KgJ5JIN5nMTc+r9K3en9UOR1LSajChjBcbauvmBIMAowz+XI4P8B?=
 =?us-ascii?Q?t2vqZ+Jr1W4CtrsgBCgTJK9DvJo5eNJQYJ9V3xA021TJ+pnsRnFkRiwxOVvs?=
 =?us-ascii?Q?3nF/48nIApwx7ECOphHzsXiFbvxlUiEZjlNT89u0rcVUdxsgkgb8gHFeRzch?=
 =?us-ascii?Q?I/VDUoHHuj+4zg+eZGleZZtGJUxTpz3i2PAHgurGzUD5kJAthgrlJ3x0zkyF?=
 =?us-ascii?Q?F9BAwVOg6A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94413bb-7a9c-4247-4df9-08deb508eead
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:11:50.3622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/KWqlFGWksnPWEvwguB6/k4rEHgF2OQ39ggnKe6hl7+sRqDigSTMKr8mht50abYSX3aO1kd//K9rCe3YaxijA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8727
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

Add the page table mapping and unmapping API to the Virtual Memory
Manager, implementing a two-phase prepare/execute model suitable for
use both inside and outside the DMA fence signalling critical path.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/mm/pagetable.rs     |   1 +
 drivers/gpu/nova-core/mm/pagetable/map.rs | 367 ++++++++++++++++++++++
 drivers/gpu/nova-core/mm/vmm.rs           | 270 ++++++++++++++--
 3 files changed, 619 insertions(+), 19 deletions(-)
 create mode 100644 drivers/gpu/nova-core/mm/pagetable/map.rs

diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-core/mm/pagetable.rs
index 5e192679f27c..042584e5178b 100644
--- a/drivers/gpu/nova-core/mm/pagetable.rs
+++ b/drivers/gpu/nova-core/mm/pagetable.rs
@@ -8,6 +8,7 @@
 
 #![expect(dead_code)]
 
+pub(super) mod map;
 pub(super) mod ver2;
 pub(super) mod ver3;
 pub(super) mod walk;
diff --git a/drivers/gpu/nova-core/mm/pagetable/map.rs b/drivers/gpu/nova-core/mm/pagetable/map.rs
new file mode 100644
index 000000000000..b0678a36d406
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/pagetable/map.rs
@@ -0,0 +1,367 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Page table mapping operations for NVIDIA GPUs.
+
+use core::marker::PhantomData;
+
+use kernel::{
+    device,
+    gpu::buddy::{
+        AllocatedBlocks,
+        GpuBuddyAllocFlags,
+        GpuBuddyAllocMode, //
+    },
+    prelude::*,
+    ptr::Alignment,
+    rbtree::{RBTree, RBTreeNode},
+    sizes::SZ_4K, //
+};
+
+use super::{
+    walk::{
+        PtWalkInner,
+        WalkPdeResult,
+        WalkResult, //
+    },
+    AperturePde,
+    AperturePte,
+    DualPdeOps,
+    MmuConfig,
+    MmuV2,
+    MmuV3,
+    MmuVersion,
+    PageTableLevel,
+    PdeOps,
+    PteOps, //
+};
+use crate::{
+    mm::{
+        GpuMm,
+        Pfn,
+        Vfn,
+        VramAddress,
+        PAGE_SIZE, //
+    },
+    num::{
+        IntoSafeCast, //
+    },
+};
+
+/// A pre-allocated and zeroed page table page.
+///
+/// Created during the mapping prepare phase and consumed during the execute phase.
+/// Stored in an [`RBTree`] keyed by the PDE slot address (`install_addr`).
+pub(in crate::mm) struct PreparedPtPage {
+    /// The allocated and zeroed page table page.
+    pub(in crate::mm) alloc: Pin<KBox<AllocatedBlocks>>,
+    /// Page table level -- needed to determine if this PT page is for a dual PDE.
+    pub(in crate::mm) level: PageTableLevel,
+}
+
+/// Page table mapper.
+pub(in crate::mm) struct PtMapInner<M: MmuConfig> {
+    walker: PtWalkInner<M>,
+    pdb_addr: VramAddress,
+    _phantom: PhantomData<M>,
+}
+
+impl<M: MmuConfig> PtMapInner<M> {
+    /// Create a new [`PtMapInner`].
+    pub(super) fn new(pdb_addr: VramAddress) -> Self {
+        Self {
+            walker: PtWalkInner::<M>::new(pdb_addr),
+            pdb_addr,
+            _phantom: PhantomData,
+        }
+    }
+
+    /// Allocate and zero a physical page table page.
+    fn alloc_and_zero_page(
+        dev: &device::Device<device::Bound>,
+        mm: &GpuMm,
+        level: PageTableLevel,
+    ) -> Result<PreparedPtPage> {
+        let blocks = KBox::pin_init(
+            mm.buddy().alloc_blocks(
+                GpuBuddyAllocMode::Simple,
+                SZ_4K.into_safe_cast(),
+                Alignment::new::<SZ_4K>(),
+                GpuBuddyAllocFlags::default(),
+            ),
+            GFP_KERNEL,
+        )?;
+
+        let page_vram = VramAddress::new(blocks.iter().next().ok_or(ENOMEM)?.offset());
+
+        // Zero via PRAMIN.
+        let mut window = mm.pramin().get_window(dev)?;
+        for off in (0..PAGE_SIZE).step_by(8) {
+            let off_u64: u64 = off.into_safe_cast();
+            window.try_write64(page_vram + off_u64, 0)?;
+        }
+
+        Ok(PreparedPtPage {
+            alloc: blocks,
+            level,
+        })
+    }
+
+    /// Ensure all intermediate page table pages exist for a single VFN.
+    ///
+    /// PRAMIN is released before each allocation and re-acquired after. Memory
+    /// allocations are done outside of holding this lock to prevent deadlocks with
+    /// the fence signalling critical path.
+    fn ensure_single_pte_path(
+        &self,
+        dev: &device::Device<device::Bound>,
+        mm: &GpuMm,
+        vfn: Vfn,
+        pt_pages: &mut RBTree<VramAddress, PreparedPtPage>,
+    ) -> Result {
+        let max_iter = 2 * M::PDE_LEVELS.len();
+
+        for _ in 0..max_iter {
+            let mut window = mm.pramin().get_window(dev)?;
+
+            let result = self
+                .walker
+                .walk_pde_levels(&mut window, vfn, |install_addr| {
+                    pt_pages
+                        .get(&install_addr)
+                        .and_then(|p| p.alloc.iter().next().map(|b| VramAddress::new(b.offset())))
+                })?;
+
+            match result {
+                WalkPdeResult::Complete { .. } => {
+                    return Ok(());
+                }
+                WalkPdeResult::Missing {
+                    install_addr,
+                    level,
+                } => {
+                    // Drop PRAMIN before allocation.
+                    drop(window);
+                    let page = Self::alloc_and_zero_page(dev, mm, level)?;
+                    let node = RBTreeNode::new(install_addr, page, GFP_KERNEL)?;
+                    let old = pt_pages.insert(node);
+                    if old.is_some() {
+                        kernel::pr_warn_once!(
+                            "VMM: duplicate install_addr in pt_pages (internal consistency error)\n"
+                        );
+                        return Err(EIO);
+                    }
+                }
+            }
+        }
+
+        kernel::pr_warn!(
+            "VMM: ensure_pte_path: loop exhausted after {} iters (VFN {:?})\n",
+            max_iter,
+            vfn
+        );
+        Err(EIO)
+    }
+
+    /// Prepare page table resources for mapping `num_pages` pages starting at `vfn_start`.
+    ///
+    /// Reserves capacity in `page_table_allocs`, then walks the hierarchy
+    /// per-VFN to prepare pages for all missing PDEs.
+    pub(super) fn prepare_map(
+        &self,
+        dev: &device::Device<device::Bound>,
+        mm: &GpuMm,
+        vfn_start: Vfn,
+        num_pages: usize,
+        page_table_allocs: &mut KVec<Pin<KBox<AllocatedBlocks>>>,
+        pt_pages: &mut RBTree<VramAddress, PreparedPtPage>,
+    ) -> Result {
+        // Pre-reserve so install_mappings() can use push_within_capacity (no alloc
+        // in fence signalling critical path).
+        let pt_upper_bound = M::pt_pages_upper_bound(num_pages);
+        page_table_allocs.reserve(pt_upper_bound, GFP_KERNEL)?;
+
+        // Walk the hierarchy per-VFN to prepare pages for all missing PDEs.
+        for i in 0..num_pages {
+            let i_u64: u64 = i.into_safe_cast();
+            let vfn = Vfn::new(vfn_start.raw() + i_u64);
+            self.ensure_single_pte_path(dev, mm, vfn, pt_pages)?;
+        }
+        Ok(())
+    }
+
+    /// Install prepared PDEs and write PTEs, then flush TLB.
+    ///
+    /// Drains `pt_pages` and moves allocations into `page_table_allocs`.
+    #[expect(clippy::too_many_arguments)]
+    pub(super) fn install_mappings(
+        &self,
+        dev: &device::Device<device::Bound>,
+        mm: &GpuMm,
+        pt_pages: &mut RBTree<VramAddress, PreparedPtPage>,
+        page_table_allocs: &mut KVec<Pin<KBox<AllocatedBlocks>>>,
+        vfn_start: Vfn,
+        pfns: &[Pfn],
+        writable: bool,
+    ) -> Result {
+        let mut window = mm.pramin().get_window(dev)?;
+
+        // Drain prepared PT pages, install all pending PDEs.
+        let mut cursor = pt_pages.cursor_front_mut();
+        while let Some(c) = cursor {
+            let (next, node) = c.remove_current();
+            let (install_addr, page) = node.to_key_value();
+            let page_vram = VramAddress::new(page.alloc.iter().next().ok_or(ENOMEM)?.offset());
+
+            if page.level == M::DUAL_PDE_LEVEL {
+                let new_dpde = M::DualPde::new_small(Pfn::from(page_vram));
+                new_dpde.write(&mut window, install_addr)?;
+            } else {
+                let new_pde = M::Pde::new(AperturePde::VideoMemory, Pfn::from(page_vram));
+                new_pde.write(&mut window, install_addr)?;
+            }
+
+            page_table_allocs
+                .push_within_capacity(page.alloc)
+                .map_err(|_| ENOMEM)?;
+
+            cursor = next;
+        }
+
+        // Write PTEs (all PDEs now installed in HW).
+        for (i, &pfn) in pfns.iter().enumerate() {
+            let i_u64: u64 = i.into_safe_cast();
+            let vfn = Vfn::new(vfn_start.raw() + i_u64);
+            let result = self
+                .walker
+                .walk_to_pte_lookup_with_window(&mut window, vfn)?;
+
+            match result {
+                WalkResult::Unmapped { pte_addr } | WalkResult::Mapped { pte_addr, .. } => {
+                    let pte = M::Pte::new(AperturePte::VideoMemory, pfn, writable);
+                    pte.write(&mut window, pte_addr)?;
+                }
+                WalkResult::PageTableMissing => {
+                    kernel::pr_warn_once!("VMM: page table missing for VFN {vfn:?}\n");
+                    return Err(EIO);
+                }
+            }
+        }
+
+        drop(window);
+
+        // Flush TLB.
+        mm.tlb().flush(dev, self.pdb_addr)
+    }
+
+    /// Invalidate PTEs for a range and flush TLB.
+    pub(super) fn invalidate_ptes(
+        &self,
+        dev: &device::Device<device::Bound>,
+        mm: &GpuMm,
+        vfn_start: Vfn,
+        num_pages: usize,
+    ) -> Result {
+        let invalid_pte = M::Pte::invalid();
+
+        let mut window = mm.pramin().get_window(dev)?;
+        for i in 0..num_pages {
+            let i_u64: u64 = i.into_safe_cast();
+            let vfn = Vfn::new(vfn_start.raw() + i_u64);
+            let result = self
+                .walker
+                .walk_to_pte_lookup_with_window(&mut window, vfn)?;
+
+            match result {
+                WalkResult::Mapped { pte_addr, .. } | WalkResult::Unmapped { pte_addr } => {
+                    invalid_pte.write(&mut window, pte_addr)?;
+                }
+                WalkResult::PageTableMissing => {
+                    continue;
+                }
+            }
+        }
+        drop(window);
+
+        mm.tlb().flush(dev, self.pdb_addr)
+    }
+}
+
+macro_rules! pt_map_dispatch {
+    ($self:expr, $method:ident ( $($arg:expr),* $(,)? )) => {
+        match $self {
+            PtMap::V2(inner) => inner.$method($($arg),*),
+            PtMap::V3(inner) => inner.$method($($arg),*),
+        }
+    };
+}
+
+/// Page table mapper dispatch.
+pub(in crate::mm) enum PtMap {
+    /// MMU v2 (Turing/Ampere/Ada).
+    V2(PtMapInner<MmuV2>),
+    /// MMU v3 (Hopper+).
+    V3(PtMapInner<MmuV3>),
+}
+
+impl PtMap {
+    /// Create a new page table mapper for the given MMU version.
+    pub(in crate::mm) fn new(pdb_addr: VramAddress, version: MmuVersion) -> Self {
+        match version {
+            MmuVersion::V2 => Self::V2(PtMapInner::<MmuV2>::new(pdb_addr)),
+            MmuVersion::V3 => Self::V3(PtMapInner::<MmuV3>::new(pdb_addr)),
+        }
+    }
+
+    /// Prepare page table resources for a mapping.
+    pub(in crate::mm) fn prepare_map(
+        &self,
+        dev: &device::Device<device::Bound>,
+        mm: &GpuMm,
+        vfn_start: Vfn,
+        num_pages: usize,
+        page_table_allocs: &mut KVec<Pin<KBox<AllocatedBlocks>>>,
+        pt_pages: &mut RBTree<VramAddress, PreparedPtPage>,
+    ) -> Result {
+        pt_map_dispatch!(
+            self,
+            prepare_map(dev, mm, vfn_start, num_pages, page_table_allocs, pt_pages)
+        )
+    }
+
+    /// Install prepared PDEs and write PTEs, then flush TLB.
+    #[expect(clippy::too_many_arguments)]
+    pub(in crate::mm) fn install_mappings(
+        &self,
+        dev: &device::Device<device::Bound>,
+        mm: &GpuMm,
+        pt_pages: &mut RBTree<VramAddress, PreparedPtPage>,
+        page_table_allocs: &mut KVec<Pin<KBox<AllocatedBlocks>>>,
+        vfn_start: Vfn,
+        pfns: &[Pfn],
+        writable: bool,
+    ) -> Result {
+        pt_map_dispatch!(
+            self,
+            install_mappings(
+                dev,
+                mm,
+                pt_pages,
+                page_table_allocs,
+                vfn_start,
+                pfns,
+                writable
+            )
+        )
+    }
+
+    /// Invalidate PTEs for a range and flush TLB.
+    pub(in crate::mm) fn invalidate_ptes(
+        &self,
+        dev: &device::Device<device::Bound>,
+        mm: &GpuMm,
+        vfn_start: Vfn,
+        num_pages: usize,
+    ) -> Result {
+        pt_map_dispatch!(self, invalidate_ptes(dev, mm, vfn_start, num_pages))
+    }
+}
diff --git a/drivers/gpu/nova-core/mm/vmm.rs b/drivers/gpu/nova-core/mm/vmm.rs
index 05ff77c5f888..1cceea759f6a 100644
--- a/drivers/gpu/nova-core/mm/vmm.rs
+++ b/drivers/gpu/nova-core/mm/vmm.rs
@@ -3,22 +3,31 @@
 //! Virtual Memory Manager for NVIDIA GPU page table management.
 //!
 //! The [`Vmm`] provides high-level page mapping and unmapping operations for GPU
-//! virtual address spaces (Channels, BAR1, BAR2). It wraps the page table walker
-//! and handles TLB flushing after modifications.
+//! virtual address spaces (Channels, BAR1, BAR2).
 
 use kernel::{
     device,
     gpu::buddy::AllocatedBlocks,
     maple_tree::MapleTreeAlloc,
-    prelude::*, //
+    prelude::*,
+    rbtree::RBTree, //
 };
 
-use core::ops::Range;
+use core::{
+    cell::Cell,
+    ops::Range, //
+};
 
 use crate::{
     mm::{
         pagetable::{
-            walk::{PtWalk, WalkResult},
+            map::{
+                PtMap, //
+            },
+            walk::{
+                PtWalk,
+                WalkResult, //
+            },
             MmuVersion, //
         },
         GpuMm,
@@ -32,22 +41,108 @@
     },
 };
 
+/// Multi-page prepared mapping -- VA range allocated, ready for execute.
+///
+/// Produced by [`Vmm::prepare_map()`], consumed by [`Vmm::execute_map()`].
+/// The VA space allocation is tracked in the [`Vmm`]'s maple tree and freed
+/// on error or via [`Vmm::unmap_pages()`].
+///
+/// Dropping without calling [`Vmm::execute_map()`] logs a warning and leaks
+/// the VA range in the maple tree.
+pub(crate) struct PreparedMapping {
+    vfn_start: Vfn,
+    num_pages: usize,
+    /// Logs a warning if dropped without executing.
+    _drop_guard: MustExecuteGuard,
+}
+
+/// Result of a mapping operation -- tracks the active mapped range.
+///
+/// Returned by [`Vmm::execute_map()`] and [`Vmm::map_pages()`].
+/// Callers must call [`Vmm::unmap_pages()`] before dropping to invalidate
+/// PTEs and free the VA range. Dropping without unmapping logs a warning
+/// and leaks the VA range in the maple tree.
+pub(crate) struct MappedRange {
+    pub(super) vfn_start: Vfn,
+    pub(super) num_pages: usize,
+    /// Logs a warning if dropped without unmapping.
+    _drop_guard: MustUnmapGuard,
+}
+
+/// Guard that logs a warning if a [`PreparedMapping`] is dropped without
+/// being consumed by [`Vmm::execute_map()`].
+struct MustExecuteGuard {
+    armed: Cell<bool>,
+}
+
+impl MustExecuteGuard {
+    const fn new() -> Self {
+        Self {
+            armed: Cell::new(true),
+        }
+    }
+
+    fn disarm(&self) {
+        self.armed.set(false);
+    }
+}
+
+impl Drop for MustExecuteGuard {
+    fn drop(&mut self) {
+        if self.armed.get() {
+            kernel::pr_warn!("PreparedMapping dropped without calling execute_map()\n");
+        }
+    }
+}
+
+/// Guard that logs a warning if a [`MappedRange`] is dropped without
+/// calling [`Vmm::unmap_pages()`].
+struct MustUnmapGuard {
+    armed: Cell<bool>,
+}
+
+impl MustUnmapGuard {
+    const fn new() -> Self {
+        Self {
+            armed: Cell::new(true),
+        }
+    }
+
+    fn disarm(&self) {
+        self.armed.set(false);
+    }
+}
+
+impl Drop for MustUnmapGuard {
+    fn drop(&mut self) {
+        if self.armed.get() {
+            kernel::pr_warn!("MappedRange dropped without calling unmap_pages()\n");
+        }
+    }
+}
+
 /// Virtual Memory Manager for a GPU address space.
 ///
 /// Each [`Vmm`] instance manages a single address space identified by its Page
-/// Directory Base (`PDB`) address. The [`Vmm`] is used for Channel, BAR1 and
-/// BAR2 mappings.
+/// Directory Base (`PDB`) address. Used for Channel, BAR1 and BAR2 mappings.
 pub(crate) struct Vmm {
     /// Page Directory Base address for this address space.
     pdb_addr: VramAddress,
-    /// MMU version used for page table layout.
-    mmu_version: MmuVersion,
+    /// Page table walker for reading existing mappings.
+    pt_walk: PtWalk,
+    /// Page table mapper for prepare/execute operations.
+    pt_map: PtMap,
     /// Page table allocations required for mappings.
     page_table_allocs: KVec<Pin<KBox<AllocatedBlocks>>>,
     /// Maple tree allocator for virtual address range tracking.
     virt_alloc: Pin<KBox<MapleTreeAlloc<()>>>,
     /// Total number of pages in the virtual address space.
     va_pages: usize,
+    /// Prepared PT pages pending PDE installation, keyed by `install_addr`.
+    ///
+    /// Populated during prepare phase and drained in execute phase. Shared by all
+    /// pending maps, preventing races on the same PDE slot.
+    pt_pages: RBTree<VramAddress, super::pagetable::map::PreparedPtPage>,
 }
 
 impl Vmm {
@@ -65,20 +160,16 @@ pub(crate) fn new(
 
         Ok(Self {
             pdb_addr,
-            mmu_version,
+            pt_walk: PtWalk::new(pdb_addr, mmu_version),
+            pt_map: PtMap::new(pdb_addr, mmu_version),
             page_table_allocs: KVec::new(),
             virt_alloc,
             va_pages,
+            pt_pages: RBTree::new(),
         })
     }
 
     /// Allocate a contiguous virtual frame number range.
-    ///
-    /// # Arguments
-    ///
-    /// - `num_pages`: Number of pages to allocate.
-    /// - `va_range`: `None` = allocate anywhere, `Some(range)` = constrain allocation to the given
-    ///   range.
     fn alloc_vfn_range(&self, num_pages: usize, va_range: Option<Range<u64>>) -> Result<Vfn> {
         let page_size: u64 = PAGE_SIZE.into_safe_cast();
 
@@ -119,11 +210,152 @@ pub(super) fn read_mapping(
         mm: &GpuMm,
         vfn: Vfn,
     ) -> Result<Option<Pfn>> {
-        let walker = PtWalk::new(self.pdb_addr, self.mmu_version);
-
-        match walker.walk_to_pte(dev, mm, vfn)? {
+        match self.pt_walk.walk_to_pte(dev, mm, vfn)? {
             WalkResult::Mapped { pfn, .. } => Ok(Some(pfn)),
             WalkResult::Unmapped { .. } | WalkResult::PageTableMissing => Ok(None),
         }
     }
+
+    /// Prepare resources for mapping `num_pages` pages.
+    ///
+    /// Allocates a contiguous VA range, then walks the hierarchy per-VFN to prepare pages
+    /// for all missing PDEs. Returns a [`PreparedMapping`] with the VA allocation.
+    ///
+    /// If `va_range` is not `None`, the VA range is constrained to the given range. Safe
+    /// to call outside the fence signalling critical path.
+    pub(crate) fn prepare_map(
+        &mut self,
+        dev: &device::Device<device::Bound>,
+        mm: &GpuMm,
+        num_pages: usize,
+        va_range: Option<Range<u64>>,
+    ) -> Result<PreparedMapping> {
+        if num_pages == 0 {
+            return Err(EINVAL);
+        }
+
+        // Allocate contiguous VA range.
+        let vfn_start = self.alloc_vfn_range(num_pages, va_range)?;
+
+        if let Err(e) = self.pt_map.prepare_map(
+            dev,
+            mm,
+            vfn_start,
+            num_pages,
+            &mut self.page_table_allocs,
+            &mut self.pt_pages,
+        ) {
+            self.free_vfn(vfn_start);
+            return Err(e);
+        }
+
+        Ok(PreparedMapping {
+            vfn_start,
+            num_pages,
+            _drop_guard: MustExecuteGuard::new(),
+        })
+    }
+
+    /// Execute a prepared multi-page mapping.
+    ///
+    /// Installs all prepared PDEs and writes PTEs into the page table, then flushes TLB.
+    pub(crate) fn execute_map(
+        &mut self,
+        dev: &device::Device<device::Bound>,
+        mm: &GpuMm,
+        prepared: PreparedMapping,
+        pfns: &[Pfn],
+        writable: bool,
+    ) -> Result<MappedRange> {
+        if pfns.len() != prepared.num_pages {
+            self.free_vfn(prepared.vfn_start);
+            return Err(EINVAL);
+        }
+
+        let PreparedMapping {
+            vfn_start,
+            num_pages,
+            _drop_guard,
+        } = prepared;
+        _drop_guard.disarm();
+
+        if let Err(e) = self.pt_map.install_mappings(
+            dev,
+            mm,
+            &mut self.pt_pages,
+            &mut self.page_table_allocs,
+            vfn_start,
+            pfns,
+            writable,
+        ) {
+            self.free_vfn(vfn_start);
+            return Err(e);
+        }
+
+        Ok(MappedRange {
+            vfn_start,
+            num_pages,
+            _drop_guard: MustUnmapGuard::new(),
+        })
+    }
+
+    /// Map pages doing prepare and execute in the same call.
+    ///
+    /// This is a convenience wrapper for callers outside the fence signalling critical
+    /// path (e.g., BAR mappings). For DRM usecases, [`Vmm::prepare_map()`] and
+    /// [`Vmm::execute_map()`] will be called separately.
+    pub(crate) fn map_pages(
+        &mut self,
+        dev: &device::Device<device::Bound>,
+        mm: &GpuMm,
+        pfns: &[Pfn],
+        va_range: Option<Range<u64>>,
+        writable: bool,
+    ) -> Result<MappedRange> {
+        if pfns.is_empty() {
+            return Err(EINVAL);
+        }
+
+        // Check if provided VA range is sufficient (if provided).
+        if let Some(ref range) = va_range {
+            let required: u64 = pfns
+                .len()
+                .checked_mul(PAGE_SIZE)
+                .ok_or(EOVERFLOW)?
+                .into_safe_cast();
+            let available = range.end.checked_sub(range.start).ok_or(EINVAL)?;
+            if available < required {
+                return Err(EINVAL);
+            }
+        }
+
+        let prepared = self.prepare_map(dev, mm, pfns.len(), va_range)?;
+        self.execute_map(dev, mm, prepared, pfns, writable)
+    }
+
+    /// Unmap all pages in a [`MappedRange`] with a single TLB flush.
+    pub(crate) fn unmap_pages(
+        &mut self,
+        dev: &device::Device<device::Bound>,
+        mm: &GpuMm,
+        range: MappedRange,
+    ) -> Result {
+        let result = self
+            .pt_map
+            .invalidate_ptes(dev, mm, range.vfn_start, range.num_pages);
+
+        // TODO: Internal page table pages (PDE, PTE pages) are still kept around.
+        // This is by design as repeated maps/unmaps will be fast. As a future TODO,
+        // we can add a reclaimer here to reclaim if VRAM is short. For now, the PT
+        // pages are dropped once the `Vmm` is dropped.
+
+        // Free the VA range regardless of PTE invalidation success, so that the VA
+        // range is recovered even on failure (PTEs may be stale, but that is better
+        // than leaking both PTEs and VA range).
+        self.free_vfn(range.vfn_start);
+
+        // Unmap complete, safe to drop `MappedRange`.
+        range._drop_guard.disarm();
+        result
+    }
 }
-- 
2.34.1

