Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E4DFF8864
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 21:15:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45B4F10E493;
	Sat, 25 Apr 2026 21:15:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jx9n4ZS0";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011030.outbound.protection.outlook.com [52.101.57.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA9FA10E48C
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:15:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQ5DWzNnW/7Z0G9YWrUzApRWmReuk6inx6ueRq6rQsEDkag9v4N4ZMkRHqFJK8SvFMIh502+eD3C2ehQdVIt1d/j2KiUaV2+HY5h3sJ1TQcJebiPK5tuoqAydm/b7zSW5DseNhSXIoH3Je28KO5rQbfrrQXV0zkIjNMvxVMKrcuvhbv1hn6WVmD9nqpkCuNa3e/p56AbCJAqqnbWdHJDbrd2pIHbGOYg9nUWkzoASk+W6ATTZAvnXi8+Cuk1xxyKoQjx3k9+J6W7190YsYYM5qUWJCpumLE8bIBeStJuqH+agJo26siTrzCzjyjyFsXCHZG/nH6XzDHYeGvQLW4bhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFPmI2U3vyCP1R/Wy5k3c7fDCROLyysdBryABRq9v7g=;
 b=uAR7ZOMs5C8qVAvLcxh/DYDY6bWcbftrevMdx7dAAhghIdKh8x9KU0eQY44z2QeQydVir+ID2hrmYTMhoL16gOm6F6RQgaR+Ddxg/LriUIIoc5AiEjnvmWWxWUuVHZbJBJ6uSdP11vyI/6YwI1gL5thI8FAnq86vYvL0nUTIJTdIhbpF5eOwd2UdcIVZ6n3N5s1raP+15Tj4mIN4nVMUstS0W2EhgaPhXjlFvchaej5ARycO/DqDlxXBi8lniSIikGtZbnSDQa8uIjoli9e1xhPO4uYz+2dhikfWj82oaUxW8qhCUExSRzJwWFfT5Yaf9OEdjnp39BXqYr+oOpAW7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFPmI2U3vyCP1R/Wy5k3c7fDCROLyysdBryABRq9v7g=;
 b=Jx9n4ZS0Rpcb6yQYapC88AJX3OrWw3YwiSQUAZPKgACQGB9mTjJgw77qiUUOXdVZsyFVhcDyv9t93ORdVTUaQViFLrm7dXhgZBkrg3X1Zbja64Q5fmuCTPZNJj2v3FguuKBxabtsBvQ4JQo547u97JZIXgJxRQ0LiWiJmJhkK3m6r+i74Bhj53OvSEuYdsjVxe0m4PVaDRuqUruRknuRRDXhnPzZUwV3Fu8CK8qCqkmcSM23NA3mJvady5pVFAJLh7DSLDW+CGl84Mp+qJNJcSScerF7hBIgYhwBmUaGGhJCS60UBbQcadIDFoVDju43/yTv1pGsoU7e42xj/VEf1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Sat, 25 Apr
 2026 21:15:36 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 21:15:36 +0000
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
Subject: [PATCH v12 13/22] gpu: nova-core: mm: Add page table walker for MMU
 v2/v3
Date: Sat, 25 Apr 2026 17:14:45 -0400
Message-Id: <20260425211454.174696-14-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425211454.174696-1-joelagnelf@nvidia.com>
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0058.namprd15.prod.outlook.com
 (2603:10b6:208:237::27) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: da5ef637-f733-48a4-fe1c-08dea30fcb20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MuPwhYaFACX9stICfmXA5lSiCBc0i7Wly11HadPlYPQheKvRsmjMEEdzEq/eusNJRH93dcVpSF38PzcQvOuI9V7c/OePoMr4bMj3DSIe3GYY7zLtyjEXmQK3cMYBot7R4tdsTbDaJZ7+P3We0RktauMIFjAU9iNuxZVo04Pmre7hyuGJuZa0tlVK4N7N0xxYKah3vk2FRl99h53o1fCvIsl7OJ1tt2BN2ogoBP1hHKwqm091fa7mKA0jGCfnIJTO6rhWZo6iaM9xbraolFZUN8qbJFA8rYkiWSZU4+kSM5sIdCYIdKbTnRsIQaKiAd+W1OegibWK0Szkznt21AJDEmgU5t3LWVtWwOXQ54Zh4AiB0gJ4t9Q+oo1sjxpO3IF7BSjMJkjtIQ8dvD2NfMQelNHle/MwZdJXPHo8RqXRInzPkmXDwef/6b1ONkhU02nF6fO9rGIOGwgBNHv2FwzYagiW9MdXHsuOTt6dTfc72G7t3HyHtM1xYN2vb8F3lCDVgCyIkUkIWmHmdkkwPCR+eWQ8+69EAKjyzxzupYZ51Y7QX1jVmRVICmH/abO5urh8d1P2kiA21tO6yl2KGZR0HzodHdvaNinp6sd51TyjoH2YHBE9eBewGL+wu9mbksvdHq3HfHx8dEmqI7Q9p9xagwxnZVuKS1tiEa1F8CtEGPXT0b5HqVzYZlza2Y+cmjy9wOknR0xvnAYQreua/yjg8u8+NwEi6UvT7bA4SIyjRBw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z4VjZFZKKsww5/P5vBM0tYKSZb3vK/V3+V4dp4WG3Lcx3lmvLVlPoQMRkAIz?=
 =?us-ascii?Q?ukN7Q1z0NNvtzO/IzT1PS/RSKrjgB/RAbxKARjl+0p34WvKj8Bvm3xNdeJV2?=
 =?us-ascii?Q?yaMICiW0qSaqMg35BiFy98OThOaEMzaiAbOi1hzaE1/+pQBVhcVf0+j2JHP7?=
 =?us-ascii?Q?gq4QOGCJCzgExsVZdx5ZE7GdT+PuE4wOIWNnfRnZe3X2qS0BYFQShCBEJl1k?=
 =?us-ascii?Q?PkTLP+xTTwSoHyS9ESUd/FXfjODUByJkrmH8C+VOmO5BFHifbki2fNncnnom?=
 =?us-ascii?Q?XaxAUiHRN2ghxTiJtDblADKIPVmtSoN8tkWDzUzwCxdUIJl743aKEwzHAC6h?=
 =?us-ascii?Q?XxI6ngTM/gOxgxGDWZqnXiR1s0SN2N/ofGiVMs1pZ+YTOUiDiv0mVfeKIgfO?=
 =?us-ascii?Q?Spm4Drd1fL3oMk1iZDAtqtsja4T9J3SIwzkuw7V5CNB9fGeTL4q5eWrcU6w5?=
 =?us-ascii?Q?Em9AhDLq1bOyr7Zp6Aj1+TNmqnhMXhPjiHYS5/faTy1Bmi5X4bXkxZKQXMmT?=
 =?us-ascii?Q?sR61PCNumB/MB9zS/o0DS4TaD5Q8/6stuCCF/26Fj+3Am+nPTKTLgDPkIZ83?=
 =?us-ascii?Q?/vZe6qVvus+U3mUCeWE2TZhQ1TBd7UPDyAQnuzKh5JPBky2jENOIfNdI2Zul?=
 =?us-ascii?Q?4556cZpJwO1lo+860Kcv7KxTtyfR61crCvurAHPz3jz2gwub3vQpn1+7gRDi?=
 =?us-ascii?Q?rFJHNTF7Pp70MxoLAWTald33vzGWLWUAGyvG3vJfcStjCJdePnDDVkmrAx9x?=
 =?us-ascii?Q?fIhtt/Ubfe3B6MBy9cWHg+dGGmzA5isqKinD9jHIwnKLL07ki+eHwlKbvM1A?=
 =?us-ascii?Q?Wkn8Qj+GMEvKep2u4tc/vkfxj++wOqoxiUEBvh4dTf9GvbShhVhtgddGl21g?=
 =?us-ascii?Q?NUofV1Y7QSethR266g8+C6+lM18cVSYLEvgLk0OXwxOnXxIcFVgKHNlRvGMT?=
 =?us-ascii?Q?MAB8Ut1hbRyAUpdQ5lbabYImcR2T0lBDu4JgedUGkx/Tkm1qwZhW5YAIFP0s?=
 =?us-ascii?Q?Qg6nOejMh2i7Y0yperyxxVssTouNHesZTos+pZoCBry8vmuw3EPZwjzI75Ae?=
 =?us-ascii?Q?SaE6+JcrfD88K3vILw68D7GH8b6xsSWsGKiOylGmqhuyji9Gmtm+IsrETECL?=
 =?us-ascii?Q?Lk2K3VnAzZEV1SUTyZ87+qsQ7f3/SLATmi0XaqVlIkkos+ng+j4PNclspITI?=
 =?us-ascii?Q?o87Q4INVhmVy9f1D5ATt0Nx2LqOJyTf17dUOiX9AwpBHgq4OWYcUUrGH/eQB?=
 =?us-ascii?Q?uvFhbGPVGzpQ2Z1gXMR1I3zqhvdRwMumIj00gheGAIOz0N4aWvgOcSAIuo6y?=
 =?us-ascii?Q?k4yZ5HrfyP9WWAaLldZeXctfDbYGlKB9tsq39bJ1ZaV1QLalxKHQ1uMjktbs?=
 =?us-ascii?Q?DdmpsAMa4t38TOZd6eYEUEfl/EtOZba2VEKdR5nxXdVflttsNlLas2EvyIHV?=
 =?us-ascii?Q?oPxi2dJfeUszIvgqT6BQSQGHtiBE59/rxicPitk31TiGPCyzWuf6c+FBj1LM?=
 =?us-ascii?Q?K2dnuA7uA1+KMhciwxGPsqSqFtClysuE7aeGEb7qDPG2o3BoLIcVPddZWBI+?=
 =?us-ascii?Q?1iktxcacwNkQKDALs/al+Q+Fu+BifWtTo9nGiqqGouSdbNYOF0EhZcbcO5se?=
 =?us-ascii?Q?wXAhsp84Dwya2Ytzi2J/TKnYA6zCDupvVGzxGR1T7E9B6jGmHMeEySvmJPQl?=
 =?us-ascii?Q?n0Vi3/x4c76SMLOQ1z0B+ZiMPbHBJWVsozJtAgmX7zT7+8rRI0xlcPRXeDOq?=
 =?us-ascii?Q?pHDrYji43g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5ef637-f733-48a4-fe1c-08dea30fcb20
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:15:36.2398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOTK6G3v/Y8x8Z7V79JLEbVa1PUV9JRFvYkQG4bddjae/oLffdzMWUCoEPrpmUJKJltm70P3hPUH+SifHXEEVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8358
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

Cc: Nikola Djukic <ndjukic@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/mm/pagetable.rs      |   1 +
 drivers/gpu/nova-core/mm/pagetable/walk.rs | 258 +++++++++++++++++++++
 2 files changed, 259 insertions(+)
 create mode 100644 drivers/gpu/nova-core/mm/pagetable/walk.rs

diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-core/mm/pagetable.rs
index 764b9e71ae41..b7e0e8e02905 100644
--- a/drivers/gpu/nova-core/mm/pagetable.rs
+++ b/drivers/gpu/nova-core/mm/pagetable.rs
@@ -10,6 +10,7 @@
 
 pub(super) mod ver2;
 pub(super) mod ver3;
+pub(super) mod walk;
 
 use kernel::num::Bounded;
 
diff --git a/drivers/gpu/nova-core/mm/pagetable/walk.rs b/drivers/gpu/nova-core/mm/pagetable/walk.rs
new file mode 100644
index 000000000000..e400b8a203be
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
+        VramAddress::new(table.raw_u64() + index * entry_size)
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

