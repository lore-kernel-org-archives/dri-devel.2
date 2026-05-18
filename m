Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D16BCD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFCCA10E99E;
	Mon, 18 May 2026 18:12:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="fPdJAjYh";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 405A110E993
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:11:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YaYVbtQkcguHX8CgBNHb2ONwyh3wT/HTKDLa/Uau3X76GM7QeeTqC8bcn0jv5wswdo6Xqs5HnkukdVBmVwElCEcz7DBg73TaNB6N/Hi5Ie8GM8v3E80NUToB3tjdWzkyBX4TaAUUX1QBhuzwxJzayqkamrwRdvmI3PGnkqIqX3Fx2nFIUllVo3WI6sImlCjGz1fJsfN7DPO1+FE0Q/8SD5cbOn+eqq0KMZ3yQcUtUDFFt56/ZE3JFOi9QEErjhKm6NjH4VWk/h+vB8aYW9uSf/bgp1WK59DrsHctWZHB9+mOUfD5014l3HJ2NeuIuzdZjLwiog50SI4q0UBoaKtFMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHPKd0nkSgYvOsfXeDGU2sCTgH/sfkV80HeFNqC7ZA8=;
 b=E2chhzHmFCvdzejAC/iILY9Xvm6QzB/qVYksSWba76nCLs/FNgoUxPEc9MGnuR6YtaKGAjt5vWofzG4DpKFK5mkcxs96gRm36DusakHZNyGmW6xCVottdI3nWj/Ga65gxBWIHD4P2UHPBDPJDdRJHTbRiRSeuqFH50n5ndDbcN1Q16Elb3rzRFpVN9dK6JKt9Dx/ua52Dgj7KAnSK1dAHjbIxXlAuXFVlSQXK3BXmYxB7vHJAfFtFNn2cu6ClsyqRRCMA0/5EVHQrkMPlIR9Mp3BeEp89/DBVkXjfTJSPGoC0L8q1+BoYf4TLZve+dh63Xc+uQH/C2jlfZu8hVLfgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHPKd0nkSgYvOsfXeDGU2sCTgH/sfkV80HeFNqC7ZA8=;
 b=fPdJAjYh31d8YFTnUunnVGKBdel+kh8WjGBT+JCFl6dme9Uq4gg2ZCr/1RYTTdIlsBTP3JNW2Md1MAT3RYHzSFQgdMwSd2ezhlMiSCOzXT0NEMgXNUjVgUPXYfdFvNZY6SFoty8wMpNedXKiKsTs+wvVWKRsQgvP7gSVMnmZ7xDxmXcEZoX47eT+bJ6dwQ3AxfcecHMLHL4VNS30TAK2refKmOSHhUi0RMRufRvljKjKnHopQJHbuTlP/oVA8WgrvCes3qXdxmZ3CzddywOjsCmi1Ke7Tc13FWOnouJeYa7idZd9xwl7vTVA+1LuSVuVlzTc2wQQqRzG1Z0oTztuDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH7PR12MB5952.namprd12.prod.outlook.com (2603:10b6:510:1db::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.23; Mon, 18 May 2026 18:11:46 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0025.012; Mon, 18 May 2026
 18:11:46 +0000
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
Subject: [PATCH v1 10/16] gpu: nova-core: mm: Add page table walker for MMU
 v2/v3
Date: Mon, 18 May 2026 14:11:19 -0400
Message-Id: <20260518181126.2493572-11-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518181126.2493572-1-joelagnelf@nvidia.com>
References: <20260518181126.2493572-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::7) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH7PR12MB5952:EE_
X-MS-Office365-Filtering-Correlation-Id: cbdbc5c8-9736-4125-d51d-08deb508ec31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|11063799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: MCmQW02wJs+YO4OcBvdgpl9xPkNYzspYessP0qDCZdA5F/LqAujtoFNmXTyTpbK92oEPQIMHMCwJADrCrDW46fQGQiCoiHllx6Hm1yVn/nlwFjrJmTv1IQMtM81IoN1SN+SODBOUvFbZJ0NyQN7Nyb8GZ3ciLK1unu0hLK9fGyAeVD3LuOt+THe5wgbhfF8pZuwXYTZEpnFnr/TORmPGJgfiU2aY7JHXj11AAfD746GkPig4hEArcABbgroZXf7HWSsGRdVHTuE9NBqOS5noW3Oe+bQDPau5vXZqdLTuX2KlBu5wRYAn/b9qde+Z2Inb5D/UnDh3xhQ4AViwLQtsNSZn58+3b3i94wDNsmpYdMoKE8x5pcBpv7gQh3Kkya9KGD4R/Fzc7ZHZenCVDbTeBbjKGkmyGS/ddv8KOHTPyUcE2znSbAEceJ1+Ta4kDSql6eBIxvVwSxJhWEg7q0pAt9tbQSSxBmL29/c57fFEk8QvcClUxf3GxqN9SwkX15A2Hxx4Vgf4VyWMmArHYa+moPAU4TEbTiiOYhbtBW72hcx8EW+BS818/Begq8VD2TbuQK1ly/IYmWf4KonWfW/RqWtCMolgvJWWdKyjkufGJ/x5nwitHyf3wBqn/oknp/1WLV9zAXRopN+XF1ORkk+K7O266h1Z2YqZ56qBOehztRsA5i2KKJOPWto9Ou+S6NRl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(11063799003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?svLSxIXuQn8hhZ2h5Y5erO5ZwKDPqN7QDvX2j80OtdzDW4vMSi/9C8lk6gFw?=
 =?us-ascii?Q?sxWAd4uPIvRc3zf85Ce4GZvp0lgy1RVwM6WiKhNJVOlc41mnfSWEzCSWRGzS?=
 =?us-ascii?Q?mm3osae9zpTOOGvAGLNBj5iZ3E/+RYZ9ZlOor7kW0XMlxZmSBznWkLIExngd?=
 =?us-ascii?Q?d0sbuWoSSylwGUJCKr3P/s9I4LcoAelOtJBtS1uzkbS1AWAGFWY/LVw7Zy04?=
 =?us-ascii?Q?quf+ShWfR2U1vRUd5idrLIfM0XeJnanj2F7EMvqJXrYI7lUYc0DC5V+reBbX?=
 =?us-ascii?Q?y6oShM7sFPwHBzImI7nfqhdofHKBfizkPaaLRyGUdpM8JjOaafsSYqbGtz6c?=
 =?us-ascii?Q?2r9HxNuL3RfDguohED/Wxq4OO0IkKZR2TT+ceUYDZPTNoKFa+3PKNH6Pqzss?=
 =?us-ascii?Q?rj3dhTDrGiI5zTzxj4ITrQlQjpmELMqoIYdG6HpzzMLqGkJMm9gNeo7e2tbR?=
 =?us-ascii?Q?iIlW27UTkjZFBQcX3vcbdleV2n4yy8FYa2RQ+UeiXKe3aXu/401FqDyijAp5?=
 =?us-ascii?Q?lvAARZ4XoZiwnpIET6nc6RauD8OSbGmglldMMRSV20TuyKhvyQeD62cWxDuK?=
 =?us-ascii?Q?w2zwGBrrWp6RUwUka+0RCy+7q/23RKs67/DtJ7UEG1TcFylcktI+a9hHrRDw?=
 =?us-ascii?Q?VPYoBMqxfM0KUgbMz6bUAgOAoiFiinmq3635DhyY9gQo2G/r3XzpwxFIchWg?=
 =?us-ascii?Q?y7TTiHzyk0kS9kbP3DoxDMlS31nZWnD3t1Iyn6RWQIvYVloSiYmXobeVOQYV?=
 =?us-ascii?Q?f0ZhHC9aZJwG/oYUH60kBCuRxmiyQzq7Ts7Usg5ABxPmtlrmvYGeQ4XI7go3?=
 =?us-ascii?Q?FyqxT6TkXeHs1Xu3xAJh4pAK44ZHx2PZdijaz/VA4HmlQCQ5pGeifgSKG02a?=
 =?us-ascii?Q?+BcNbKONigyAWMZxkC3PJJ1RPyMRPQOC0jmMRsRCBUYLiPY1Ovf8uy3O7TZ7?=
 =?us-ascii?Q?B5BUVhAPNRJFWr/U7mS2EWwCDGjrBOsU/nqJFcyoxBPOHpVBSzSqMhiwyYLX?=
 =?us-ascii?Q?oo9PsNUMtkFSR23pUGge+rf9q6gdZqUNndg950oghnqbzgO6diu5BxarelUZ?=
 =?us-ascii?Q?Iuk10x2AlGJPaSro4Psj4VF/P7xYA0eDX1ik0aeuCIojHkmB5ApLP3s8+qhe?=
 =?us-ascii?Q?DpFkLVF8IgdvtFfJu5Vgcv3o5yHZmdpveBTZHBEiHfZ6XegU76Ujc3wp6HwY?=
 =?us-ascii?Q?gz0YkVeU5m+RAssT7iFiDYhNWePeh19iSlCI8w7I/8PsLyyDpe9ORwxeSeU+?=
 =?us-ascii?Q?KRS/j/ZMhhiwL3q2TmUV/vzzT08xZ/aH0fAWwwk5rJLPEBqgOETJgMvjZA8J?=
 =?us-ascii?Q?vOZK33uUWpFstH2Kso19BeDH10TyHbpZCv2TOYLQxhu71A/M/o4IeGe02gHX?=
 =?us-ascii?Q?1EQ/CnWlmNXC+ePg7VFPVsbSz46G+RiGWv7RH50P0E01Het88NuZEl1fzcu/?=
 =?us-ascii?Q?dq+I6exAniOG4eKOll9Z1QJ7ysP8irbUn34Fc5ZWS81PAjtKZvyAqfGIvU5C?=
 =?us-ascii?Q?ntBzEO2xtj/Iqcr3I46PdZOStQDXEFSaPFAFFwKdvgjEljg8loIS3oYoMSyM?=
 =?us-ascii?Q?QJqegeQg34WmyLuUZF2LFCB5+yIFBo7AQ0QLxTeu66+L+e6zhWDxjlAaAXgx?=
 =?us-ascii?Q?YjRnLx1bDPZbnLZU2mTMDDtE3DrLAf0UXTZ7VhKSFpKGDghTVsSLKlwTKf4q?=
 =?us-ascii?Q?Q8iF+x0aJMUaN5DaHn5ndqBi1Sco+Kmmo8+5k8FoB4C44lHFE4/uV2pHox0S?=
 =?us-ascii?Q?w92Dchhayw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbdbc5c8-9736-4125-d51d-08deb508ec31
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:11:46.1705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gK8FpBPMx893yonZwSpuheCtB182q6Rqk4OwqOTquieFmnkulvdxmUUE04+YNPOLZvx64pqKuN4eWWpqd12dAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5952
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

Add the page table walker implementation that traverses the page table
hierarchy for both MMU v2 (5-level) and MMU v3 (6-level) to resolve
virtual addresses to physical addresses or find PTE locations.

Currently only v2 has been tested (nova-core currently boots pre-hopper)
with some initial preparatory work done for v3.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/mm/pagetable.rs      |   1 +
 drivers/gpu/nova-core/mm/pagetable/walk.rs | 258 +++++++++++++++++++++
 2 files changed, 259 insertions(+)
 create mode 100644 drivers/gpu/nova-core/mm/pagetable/walk.rs

diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-core/mm/pagetable.rs
index 38f4f0c6e8ce..5e192679f27c 100644
--- a/drivers/gpu/nova-core/mm/pagetable.rs
+++ b/drivers/gpu/nova-core/mm/pagetable.rs
@@ -10,6 +10,7 @@
 
 pub(super) mod ver2;
 pub(super) mod ver3;
+pub(super) mod walk;
 
 use kernel::prelude::*;
 
diff --git a/drivers/gpu/nova-core/mm/pagetable/walk.rs b/drivers/gpu/nova-core/mm/pagetable/walk.rs
new file mode 100644
index 000000000000..a5f6c461f96a
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/pagetable/walk.rs
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Page table walker implementation for NVIDIA GPUs.
+//!
+//! This module provides page table walking functionality for MMU v2 and v3.
+//! The walker traverses the page table hierarchy to resolve virtual addresses
+//! to physical addresses or to find PTE locations.
+//!
+//! # Page Table Hierarchy
+//!
+//! ## MMU v2 (Turing/Ampere/Ada) - 5 levels
+//!
+//! ```text
+//!     +-------+     +-------+     +-------+     +---------+     +-------+
+//!     | PDB   |---->|  L1   |---->|  L2   |---->| L3 Dual |---->|  L4   |
+//!     | (L0)  |     |       |     |       |     | PDE     |     | (PTE) |
+//!     +-------+     +-------+     +-------+     +---------+     +-------+
+//!       64-bit        64-bit        64-bit        128-bit         64-bit
+//!        PDE           PDE           PDE        (big+small)        PTE
+//! ```
+//!
+//! ## MMU v3 (Hopper+) - 6 levels
+//!
+//! ```text
+//!     +-------+     +-------+     +-------+     +-------+     +---------+     +-------+
+//!     | PDB   |---->|  L1   |---->|  L2   |---->|  L3   |---->| L4 Dual |---->|  L5   |
+//!     | (L0)  |     |       |     |       |     |       |     | PDE     |     | (PTE) |
+//!     +-------+     +-------+     +-------+     +-------+     +---------+     +-------+
+//!       64-bit        64-bit        64-bit        64-bit        128-bit         64-bit
+//!        PDE           PDE           PDE           PDE        (big+small)        PTE
+//! ```
+//!
+//! # Result of a page table walk
+//!
+//! The walker returns a [`WalkResult`] indicating the outcome.
+
+use core::marker::PhantomData;
+
+use kernel::{
+    device,
+    prelude::*, //
+};
+
+use super::{
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
+        pramin,
+        GpuMm,
+        Pfn,
+        Vfn,
+        VirtualAddress,
+        VramAddress, //
+    },
+    num::{
+        IntoSafeCast, //
+    },
+};
+
+/// Result of walking to a PTE.
+#[derive(Debug, Clone, Copy)]
+pub(in crate::mm) enum WalkResult {
+    /// Intermediate page tables are missing (only returned in lookup mode).
+    PageTableMissing,
+    /// PTE exists but is invalid (page not mapped).
+    Unmapped { pte_addr: VramAddress },
+    /// PTE exists and is valid (page is mapped).
+    Mapped { pte_addr: VramAddress, pfn: Pfn },
+}
+
+/// Result of walking PDE levels only.
+///
+/// Returned by [`PtWalkInner::walk_pde_levels()`] to indicate whether all PDE
+/// levels resolved or a PDE is missing.
+#[derive(Debug, Clone, Copy)]
+pub(in crate::mm) enum WalkPdeResult {
+    /// All PDE levels resolved -- returns PTE page table address.
+    Complete {
+        /// VRAM address of the PTE-level page table.
+        pte_table: VramAddress,
+    },
+    /// A PDE is missing and no prepared page was provided by the closure.
+    Missing {
+        /// PDE slot address in the parent page table (where to install).
+        install_addr: VramAddress,
+        /// The page table level that is missing.
+        level: PageTableLevel,
+    },
+}
+
+/// Page table walker.
+pub(in crate::mm) struct PtWalkInner<M: MmuConfig> {
+    pdb_addr: VramAddress,
+    _phantom: PhantomData<M>,
+}
+
+impl<M: MmuConfig> PtWalkInner<M> {
+    /// Calculate the VRAM address of an entry within a page table.
+    fn entry_addr(table: VramAddress, level: PageTableLevel, index: u64) -> VramAddress {
+        let entry_size: u64 = M::entry_size(level).into_safe_cast();
+        table + index * entry_size
+    }
+
+    /// Create a new page table walker.
+    pub(super) fn new(pdb_addr: VramAddress) -> Self {
+        Self {
+            pdb_addr,
+            _phantom: PhantomData,
+        }
+    }
+
+    /// Walk PDE levels with closure-based resolution for missing PDEs.
+    ///
+    /// Traverses all PDE levels for the MMU version. At each level, reads the PDE.
+    /// If valid, extracts the child table address and continues. If missing, calls
+    /// `resolve_prepared(install_addr)` to resolve the missing PDE.
+    pub(super) fn walk_pde_levels(
+        &self,
+        window: &mut pramin::PraminWindow<'_>,
+        vfn: Vfn,
+        resolve_prepared: impl Fn(VramAddress) -> Option<VramAddress>,
+    ) -> Result<WalkPdeResult> {
+        let va = VirtualAddress::from(vfn);
+        let mut cur_table = self.pdb_addr;
+
+        for &level in M::PDE_LEVELS {
+            let idx = M::level_index(va, level.as_index());
+            let install_addr = Self::entry_addr(cur_table, level, idx);
+
+            if level == M::DUAL_PDE_LEVEL {
+                // 128-bit dual PDE with big+small page table pointers.
+                let dpde = M::DualPde::read(window, install_addr)?;
+                if dpde.has_small() {
+                    cur_table = dpde.small_vram_address();
+                    continue;
+                }
+            } else {
+                // Regular 64-bit PDE. Use `is_valid_vram()` because
+                // `table_vram_address()` only reads the VRAM frame-number
+                // bitfield; system-memory PDEs store the address in a
+                // different (wider) field and would be silently truncated.
+                let pde = M::Pde::read(window, install_addr)?;
+                if pde.is_valid_vram() {
+                    cur_table = pde.table_vram_address();
+                    continue;
+                }
+            }
+
+            // PDE missing in HW. Ask caller for resolution.
+            if let Some(prepared_addr) = resolve_prepared(install_addr) {
+                cur_table = prepared_addr;
+                continue;
+            }
+
+            return Ok(WalkPdeResult::Missing {
+                install_addr,
+                level,
+            });
+        }
+
+        Ok(WalkPdeResult::Complete {
+            pte_table: cur_table,
+        })
+    }
+
+    /// Walk to PTE for lookup only (no allocation).
+    ///
+    /// Returns [`WalkResult::PageTableMissing`] if intermediate tables don't exist.
+    pub(super) fn walk_to_pte_lookup(
+        &self,
+        dev: &device::Device<device::Bound>,
+        mm: &GpuMm,
+        vfn: Vfn,
+    ) -> Result<WalkResult> {
+        let mut window = mm.pramin().get_window(dev)?;
+        self.walk_to_pte_lookup_with_window(&mut window, vfn)
+    }
+
+    /// Walk to PTE using a caller-provided PRAMIN window (lookup only).
+    pub(super) fn walk_to_pte_lookup_with_window(
+        &self,
+        window: &mut pramin::PraminWindow<'_>,
+        vfn: Vfn,
+    ) -> Result<WalkResult> {
+        match self.walk_pde_levels(window, vfn, |_| None)? {
+            WalkPdeResult::Complete { pte_table } => {
+                Self::read_pte_at_level(window, vfn, pte_table)
+            }
+            WalkPdeResult::Missing { .. } => Ok(WalkResult::PageTableMissing),
+        }
+    }
+
+    /// Read the PTE at the PTE level given the PTE table address.
+    fn read_pte_at_level(
+        window: &mut pramin::PraminWindow<'_>,
+        vfn: Vfn,
+        pte_table: VramAddress,
+    ) -> Result<WalkResult> {
+        let va = VirtualAddress::from(vfn);
+        let pte_level = M::PTE_LEVEL;
+        let pte_idx = M::level_index(va, pte_level.as_index());
+        let pte_addr = Self::entry_addr(pte_table, pte_level, pte_idx);
+        let pte = M::Pte::read(window, pte_addr)?;
+
+        if pte.is_valid() {
+            return Ok(WalkResult::Mapped {
+                pte_addr,
+                pfn: pte.frame_number(),
+            });
+        }
+        Ok(WalkResult::Unmapped { pte_addr })
+    }
+}
+
+macro_rules! pt_walk_dispatch {
+    ($self:expr, $method:ident ( $($arg:expr),* $(,)? )) => {
+        match $self {
+            PtWalk::V2(inner) => inner.$method($($arg),*),
+            PtWalk::V3(inner) => inner.$method($($arg),*),
+        }
+    };
+}
+
+/// Page table walker dispatch.
+pub(in crate::mm) enum PtWalk {
+    /// MMU v2 (Turing/Ampere/Ada).
+    V2(PtWalkInner<MmuV2>),
+    /// MMU v3 (Hopper+).
+    V3(PtWalkInner<MmuV3>),
+}
+
+impl PtWalk {
+    /// Create a new page table walker for the given MMU version.
+    pub(in crate::mm) fn new(pdb_addr: VramAddress, version: MmuVersion) -> Self {
+        match version {
+            MmuVersion::V2 => Self::V2(PtWalkInner::<MmuV2>::new(pdb_addr)),
+            MmuVersion::V3 => Self::V3(PtWalkInner::<MmuV3>::new(pdb_addr)),
+        }
+    }
+
+    /// Walk to PTE for lookup.
+    pub(in crate::mm) fn walk_to_pte(
+        &self,
+        dev: &device::Device<device::Bound>,
+        mm: &GpuMm,
+        vfn: Vfn,
+    ) -> Result<WalkResult> {
+        pt_walk_dispatch!(self, walk_to_pte_lookup(dev, mm, vfn))
+    }
+}
-- 
2.34.1

