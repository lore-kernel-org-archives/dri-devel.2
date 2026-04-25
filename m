Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9A7FF8863
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 21:16:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75F5810E49D;
	Sat, 25 Apr 2026 21:16:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="GyM4Y7xM";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011056.outbound.protection.outlook.com [52.101.62.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B64C10E495
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:15:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVc8tN3nSMVhcD50JwMd5B38VrY28N5Jccb960elkAT5hORRvMFUrktEVXxnLRtl+nbeV/n7HAHYux20IbdWtLCC1xQVLMX/TyHyQNTLEF7Ist5QaJjhplyeHwfuek6XmJP7FsAH4nJzrEKuT3QqsRZpv8wj5a5YXtzAzJvX+769RYtXQh6cxfSUPOQF/Hom+/DATNgzSz2n3uOoNO1d21BQdIC31H1YscIqB1CwH8NjOo3CEFDqZ6ezUYWhD81K2YcYGfzkPMIfvcrEUsXKzXhs29pELHhQxFBHjxn3fppScXo5so2/Ljf11a/oror9y6r9RXRWpCNdPT4344i/sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyUS6/+oW6v0MLCUlSC5LRZXzNEN/+lk2DCmusIvBbM=;
 b=U6MV7KQsTyGY+q/EcMKTMVMbjRNvCjMGArSQ3/wV0AkS002Dz/hmFaQx8hNRUxDSpCZuDP3Q18USEf3jNUH5NwyyY66UoRt2UpE32r68ZGgZJ/E1wMdsRy7OWHvoL7XXLeQuthc8E6bs83JkYWg6AILrjYX8aXUTRXFbzKyqjavtdQFySeUiJod9ZSFk8QHx19NRBFtspGarDyYtfwRkYhvOUoqdHWhJx1ZnSW2imoGFUQXGHO58CmjG7u9TSmqtYlS7ZB/UFi9e61di2jJiPVcKiSWu3VzoH80PcTGja8OAFKMm4YO/4wyMXUNM/iCeIjAyKUc0hmnurXVKsKQQzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyUS6/+oW6v0MLCUlSC5LRZXzNEN/+lk2DCmusIvBbM=;
 b=GyM4Y7xMp7OysVdfn893GBOQiqc+Pxa4OUoH2gJvOD13yYFUwuPz6wZX5slSSYADZA5bSsak9zbE4te94khY3Ezjb2JMeLxEyKNbd9Ux2qrYqV9gYNP9vm8bw/aF2Mdv9mRZxyEh+2gQht95iJ0I3XFqKBWs8uptgYq8rrNIyidvhomzFqPvggiCRXgPpU0oGCaeQdZZ8Mp0K7MYeYnru6mwGz/fnBo8WvXlM3HMckvWPxhBLO7cmmn4N7yt+rdDt3/6VNlWGMC9g1v9ddBFvAAmStYN7t8g/n3wjnKpG9xivYKnBmW0v752Eot/0pepxXyHqel7H/KUxaWqm59glA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Sat, 25 Apr
 2026 21:15:43 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 21:15:43 +0000
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
Subject: [PATCH v12 16/22] gpu: nova-core: mm: Add multi-page mapping API to
 VMM
Date: Sat, 25 Apr 2026 17:14:48 -0400
Message-Id: <20260425211454.174696-17-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425211454.174696-1-joelagnelf@nvidia.com>
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:930:1c::18) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c1ab8a-ff3b-4ad1-9ecd-08dea30fcf49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JH+xcCSEXEC533uiY7CjSmY1W1s5C03p0jinBTfNWCFIDzmq1OI7mAfEdmEAIXj1ZCkw6vA+RPEwBVoqyAquEz6tP/lhTvFx50CFPCnsb1MtwRgAWW/5I/teuYmU6H42+4XBOtqVeDkZL2B6FU3WfFsHB3uAMFFyCFsaGtXGo8cD2t0LZrh+rsY7lHBM16uU2+WNjIIJCPibKRcZzkdA5He7yZBRlWhb0IIBxPqYjHU9/nojzZKBTifpipbY8Op42ZZHf3HpVnrlBnAQoy+7L66ruHUZK0z/C3QL4I9KpWRJ2CLlq9cVgi0N1+L2Y6BiUOeHKUATtLAmCmFyHhITt8ApTnahVwFirrjgdR+hdNc3r9BCy1JdxW9kK0yiROYE/1mnLIs3E/nuC5hc//H6HBWHkqgoLXtzWCqM6tzwvfm49rk3fDzptWRBZjGOdQsC+N23XT7hPm76DtWSd2+3HN1BVnyPe5Nct0SeVmLiXRFijaxZ+rXD0Is97baNFYPL8Y9FmzdlziOXyFU2xtuRwdvkQdwo2hvzfB+Pb7XiUt7m3z5ZGzS7D+fGkvwMAHW/Vw40ZH+H9sqKQgMcyR7MJBEcvVIyC6BZhVbKUwIGJPZdfmcUA7TCqRmQjyWm5ql1Lhv8w3J9KaF1UjeVoGw95Uv9QT9xbklGhMFgYorNQQC4uvajYh1R79dSmtwLxrL87QiDOP9Pzv3M7iDX9zxAnj+iLBOtlFPcP2+o/EQWUGM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AJlBZ6XRf/A1MWrS5XdMeDaqJivkEKL2GrTLj4JFz9mOeOKFIni2a4NoSNeX?=
 =?us-ascii?Q?DW/3P8oD2JQgkvLu8F8RGy9lI4t9bsKwgYdR9QCnuBP23lGrkVMpoqJP5oL4?=
 =?us-ascii?Q?ekgD/Of4xnDM2J8Qd7efPnM83YIjpVflq0810yQnMdIQfNrSnE8SRSsTtsTH?=
 =?us-ascii?Q?uVWU4wBrLpLcy92qN08q1bRvotQpXjvPhbCdStLtaGEG8gPjN24++xv68ns7?=
 =?us-ascii?Q?vscxqUZ5RQF1VXH7y4YO0xJY8bmJnIhzAR7h2sKn8gUVwGjcsevbnuTOW5PM?=
 =?us-ascii?Q?JWGHkbIIKVTR9s7Nq58dYXVEDRReXpWgs/pGT8gmpd/wX5y3TR0haPUXshOL?=
 =?us-ascii?Q?R43qLLD8TDmSIS8eY9xx7XM3Y4vgzTjiKQM1C18qRlMOCA5Z41HaXLfyHuYe?=
 =?us-ascii?Q?Q6T+GR9voThODqnwWlUr3RkOHbJgiaVre0a0iTw2zLNgJQHGoh37ynZSWP3x?=
 =?us-ascii?Q?tm5bQDy/E+HVKoz54pz+ZhOoFZ/Emyvdw4nBE35RmdtFcRAAKl/oJccJlac0?=
 =?us-ascii?Q?eo8XsP4W25VEcoX6f8FLudOjSLFQNNIMRTgCfWPVO2ehAyIsAuUoBsa9julX?=
 =?us-ascii?Q?FY+fkQyScJ5wS/yTfBCQJXILPpgRGr0PNYZm2sWZSeWfCi2mbaKSq8XYBkZa?=
 =?us-ascii?Q?zmwCvIM3nSw6UvtzJsJlL7htB2Xf+jtrNhOmparjtJaS9KZlmt2IRMCFhyv7?=
 =?us-ascii?Q?QgBN+4ggZtM7k7J/gnhfHnSdlupk3/O3ILFkHw4rK7kweN58k7PSHp/FmBGz?=
 =?us-ascii?Q?ocYFUf7ztLxRrGBU4lDan3pgIdkFoWvfWUn0ulKjr3vZ4fH0r66wqcr96QSl?=
 =?us-ascii?Q?iKcwSOV+TBe/jt0VYvWr8efY1AMo4vNBMD6uxbrUY0APP3/IyM5v8Yd3iI0d?=
 =?us-ascii?Q?d1D1OF2wwpQ6i34zJg+Hl+bVhPkAxTqCjOtQ5Za3HwFEIo//CUPTRDt5QQ1p?=
 =?us-ascii?Q?gmSuYI/HJBBaUS1wML+kN41ENEk/bNXU6iE6W/aHuRupfMDhhOW6Q7kAiLYx?=
 =?us-ascii?Q?J9o1udVGUKiKLtBiurV0P+omcIS6NRuKvbbFha/7tDINxr8DDZ12/XLo5Ncu?=
 =?us-ascii?Q?ih4GAgShdqq/SXAPVkViChlyZbfbJpx8diUyaJH6iqXJbv0evWK67zrmGAVk?=
 =?us-ascii?Q?4BaoLcpzdqkr9s+fuf9FZDUulMX6WA2D8S4ygySbX9GR1gvMWv1+TZV77qma?=
 =?us-ascii?Q?xNkUTmnzMbrahcoyrvgWiWFxHVAhGT1ZwQn5CLdBTvlX4o57DcV7E94N3dow?=
 =?us-ascii?Q?P+VeH2bH1c+z20mDc9ffPqzfZ7zS7rXcqNfXucRE+77LY2YTEyp0blLv3wMO?=
 =?us-ascii?Q?usDFUcv9J/Cg5/NPZiF1ubJHuQfbW099itVCWZXitHIPDwF/EeibjF+2I7d5?=
 =?us-ascii?Q?wtGBGeaUIsj0/YmWP/iCyGFjLAdv3ZfFoUqbXBogtyz9/+sDfNPXUqkYvJXA?=
 =?us-ascii?Q?MGhzu6Ey/RrucuWHUhGUrpFLY18qfZ/bBXtLhZPfSeLu1fGZV18rlwQhlZ+h?=
 =?us-ascii?Q?eNuhUbkkxWvBGIOr9DDDRtP/0Net2dRON3EPjsgNcXsuHWf2V84sFy2phnY0?=
 =?us-ascii?Q?03KL+zXjZxjDuLBjnPzWDNtcE7ae9OVAeL7XQWcOV4uM7OmaKkVVHcNdYHcQ?=
 =?us-ascii?Q?V9Qb/vvl9H5aOgioaOI/4CL2+wVuAZnfVD7b/FZGZ/rON6s5Cxq7lIQgvmIJ?=
 =?us-ascii?Q?0l1omTpkk6nMFwRiG4iLoVGerFe/jltctutnXZ9dbycl6U0WZw3s2al8VPcC?=
 =?us-ascii?Q?fL+gO1hgZw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c1ab8a-ff3b-4ad1-9ecd-08dea30fcf49
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:15:43.2901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+QJauymwo66gULfAUj/CbOIZxrjEjrXOqMN+xiVViIEMzgJobuUhZ/N7A9VUwo6e0yN39tQV4g+BRKSizeh8Q==
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

Add the page table mapping and unmapping API to the Virtual Memory
Manager, implementing a two-phase prepare/execute model suitable for
use both inside and outside the DMA fence signalling critical path.

Cc: Nikola Djukic <ndjukic@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/mm/pagetable.rs     |   1 +
 drivers/gpu/nova-core/mm/pagetable/map.rs | 355 ++++++++++++++++++++++
 drivers/gpu/nova-core/mm/vmm.rs           | 268 ++++++++++++++--
 3 files changed, 606 insertions(+), 18 deletions(-)
 create mode 100644 drivers/gpu/nova-core/mm/pagetable/map.rs

diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-core/mm/pagetable.rs
index b7e0e8e02905..4070070922a4 100644
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
index 000000000000..16af491472db
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/pagetable/map.rs
@@ -0,0 +1,355 @@
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
+        let base = page_vram.raw();
+        for off in (0..PAGE_SIZE).step_by(8) {
+            window.try_write64(base + off, 0)?;
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
+                let new_pde = M::Pde::new_vram(Pfn::from(page_vram));
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
+                    let pte = M::Pte::new_vram(pfn, writable);
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
+            install_mappings(dev, mm, pt_pages, page_table_allocs, vfn_start, pfns, writable)
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
index 81ae08ce1cd7..57269409147d 100644
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
     prelude::*,
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
@@ -70,20 +165,16 @@ pub(crate) fn new(
 
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
     fn alloc_vfn_range(
         &self,
         num_pages: usize,
@@ -128,11 +219,152 @@ pub(super) fn read_mapping(
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

