Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78350FF885C
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 21:15:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6294410E497;
	Sat, 25 Apr 2026 21:15:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="J42OyTMU";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E27810E48E
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:15:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtSPpkbKL54ibhaxZRJtcoND40jyuKAmmtzFN1kA7fb6YGnwSAhkSoNSSJrwbkdrwhwiFlxqmlcYuBhiYiufiiTqdjX81tCu++rxFEe+M9MDnUipE9R/cmMae9JKIcdRqJ0zUpit/WUhRm2TpFkKsrUD5rn4BZfoE5jLKC/r6F6GcklsWkAcJim2M81FzaIU4PfAZkuhsZeJMbM0CGU7ZLq+O5b8MrVpR8AkL4d6A/LPhgdtlUq4mpWzVT6iZtQwpiqQ4Ps8S9x8jXlCb4Ty5LM+nNmF3b8VgvkUdLMI0QqFXMSo3zkui03hiJlr/0srwIwjbDzLvtaf3wORs0oiOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhZFmcTZkol0RLLsdaEm0BTZwWzqpfM73urIMKeUYhA=;
 b=sWvKbBoDmy7n6zaHHmivMAqHZQl0ZWzAxeNLCD8mCG+n0t0lPhnvZ7TI7GpdJhUCxfeeTJI5Q27pm5LzVK6zfGlGUazdWGghW6oeEhSysC5iaG39THtDuLszjpfcBuQLqx3/xlAOHb1tUVzjGEC/BDajTpcY/3BRbd8mwDOw7bPbKPoRw3kR8+Ayj7/ER2RnwLSMu9K+opMxv/dmX/OyhmNhX/gdfeSo5SBXLRhd0Fl3yTQ29Z/hq5hF4iSCvUyWHeIzjPhNBW5wjYuK0fcCuRtEExYxf6wGM4Fnhquh2E6n1SiL6vy9SOZsHvCkI+PDDubUuw6ryjSbw4pZ1gLKxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhZFmcTZkol0RLLsdaEm0BTZwWzqpfM73urIMKeUYhA=;
 b=J42OyTMU5NhjSjtgeVj54SYkoI0BdegNrs+zYIUzIRgxaaWFaZt2L38Vqxda1GWsHEtp9sEF2NDH6n6eO6exidB6tkKwnKAIV/pz+gIhsmuTdsxPNWy+6SY6zvPjyR4WNt1e09Ot+aRfjHN3Hu4PlUkGitQYUMvwPu0t1L9dGE2YX7iIghLuvbfLOdg3lANZj5mqvYP4kXG4NnSp/RGKr1PJYcahBrpI88QhV1rbrXLPnkrDAZbijQSp3d3xry5VRIuklHDPxto2UmXbhyP94q/Ye2gQQ/IlZgXBEmv/GTRoEAiTJdrfC0wuhz6Zjs02OEFO0mEoI+0hqAAIMtLS1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Sat, 25 Apr
 2026 21:15:38 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 21:15:38 +0000
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
Subject: [PATCH v12 14/22] gpu: nova-core: mm: Add Virtual Memory Manager
Date: Sat, 25 Apr 2026 17:14:46 -0400
Message-Id: <20260425211454.174696-15-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425211454.174696-1-joelagnelf@nvidia.com>
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYZPR11CA0010.namprd11.prod.outlook.com
 (2603:10b6:930:8d::26) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: 548bc75b-35e1-43a8-6fa5-08dea30fcc9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YDlVG6alXtPMG7q8S9iBzP4vPHoYivRSOHwu9iZmSa14sXagHu86qOGgX4VtnaQ/cJtVtBJZsfi1yFR+vyYSm3yxX09IUMn06Lge13XOdNx5fDlSpwa5UQS1Co0RS6QR3E7zeMnocVidPXz30I5oubwG1WXGtuutOVmw6FW8pNV+dIxIEqRT/7zSDQmYgosHYL4rIOI45QF1W85bxsGHRNDUMKTz7VQ2CyHvYVR2D+h/rRGf09c0QEmR73nDWd0vXGzShXnAP5EvWbJROdKCNS7VOLzCmAJRlp0NMUFwTO29ggGhhGsYEP5eIr/TtbLWwbOSaYwvl38SaqLHPB2dc1d4eOHFrbn3c+5qyaIKKgReH9O6FRdKOVb0rZ1xPqq/k/KHS5yAU4aRegzmggzZfVHGySfTMzbNxtD2VtIlT7BliAK7PyiyQ9/ybUXzIm8mZ+c5u0e/izG5RM28KoWnUI7cXukJYV/ANrvVo1mPkecY6Fv3QGBskaKd3/Q+Dqc9FqQy5OpnsYXHlE9bgTamxGejo55XbGFHZLYo3UoOEf006PgIAMuKVPBUETYpWPKnPO4dF1dd6T1dfE+9jWDZ6PlIeESBaNi/h+deSZZLT/NkyueEUYTIekxhnGddqwEgd4glhtlKTWwc7r5xBPzAbIhaeId5oRCtFds0VOB6LMvEHc7slwIbvwhhsNLwLBIiwPFy+OwmFdoReOXWSTkPlvuguPTMgqJDVCqWq76VKW4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HIbH7rwv2x1T4v6yfKQJZvHBvhomXzTFE4ICQzJNv85ftOc5goMJNRbAbuxf?=
 =?us-ascii?Q?KQKQVTf3YzOtbqdlmKc07uqEgzVdsfeMsAJhhRAdledOzpBlnInkI0m690EB?=
 =?us-ascii?Q?BMaJE+rjvQDnHsX7+l30L/F5sm3xqkGnqz8WQAZhCShnhMb9hmCQW3rv+aTO?=
 =?us-ascii?Q?rM3noj+MXPcC/3WZW9c+9gjz7eufwYQPioX9rCPAAxiRytZHeJIeAHscoO72?=
 =?us-ascii?Q?0qEEfeoogWk3flCiOrB0tPNQfK0Ci5HZyx1PpeFFyIO8i96+iz45Wd3+dcOq?=
 =?us-ascii?Q?HhStb255xDQkJSiLfbKCgseREx14qVQntwMylEDdYEs4XWT+tzMUGKiMwpY0?=
 =?us-ascii?Q?RaAi2EkQfPeEG45SLRjoeNQ796oHU1UwhLzIoNT92OvevPTUI4xYExxACuPz?=
 =?us-ascii?Q?OFOH6NPVlePA5LEesrjsMf4lGG09lRiTvBwpBqsPS7MyMNXJisqGu61qSZSX?=
 =?us-ascii?Q?A6dtEzjiTURSu9eszlg/og+29NxevfUnVMLlxbUH43bpF+bylc/aggo9QRhJ?=
 =?us-ascii?Q?GFoS8YCYd+FHSRfStKgkNk6TtkWoX2YvJYeYLEvn8YNA57zHAVwyU6LWpBOr?=
 =?us-ascii?Q?dg2N5nwB4pUMif7GL5cfYIO01atM2LjlWBV6Q53wfuH7aHAJaEvx0/XmFz59?=
 =?us-ascii?Q?kjqG0jT4Hk+j5Sz3d/XgWjv3l/DSzb7gOwksAYRwcfD3Srw3i33K9GKDijJt?=
 =?us-ascii?Q?JJB49lSIBwoaKmAhJBWRzh4nnw7oB08BOT40tieowGaDQ/g8gsTo+COkKPSn?=
 =?us-ascii?Q?hdzCWPvYN2z1PuU6VCaYHp78fZjkoV+aiX3emHd15JeAOp3Hl4OVQ7sHNOte?=
 =?us-ascii?Q?uKwSyTtbvpwVzg1wLDe0bzNPJ3/GC/s5uehLDS1bVPAHgQ/IBuoNEkGQk4pi?=
 =?us-ascii?Q?sOrTrYI1dkkFfg/kiMJ22mCYdGlo6OvE1Z6hMY6g3NSFK3jo59V+0zHhefgG?=
 =?us-ascii?Q?8YGly4jRmEVV9VMaxPqEYNYNNiOKgGIZ7V7M3w01hiCyKZwf9xGDJw3fJLt4?=
 =?us-ascii?Q?Mj89j0IwlBbNkCMOUTMkNBRycQ/4D/WPMgoRwgGKYDyURCzCd4bvjs23/NX7?=
 =?us-ascii?Q?hUonTlN4dpH4cgq920hnzBPEDHknK5ZzljJwp234E1QvA2o9160wWv/rWyKj?=
 =?us-ascii?Q?5kxmxYESQFWPUoLrrKLN10qEYTBJFNRV5iBsVVpPa8WB58cVO6TB82hqMtJn?=
 =?us-ascii?Q?4uOs3EW+jJMbo7wU+sc+rmlb/14OSdzTYCUcljVBM0YTDFVd1SGFHQhZc9CF?=
 =?us-ascii?Q?ZfowjNmBZzBUOZbW2uN634ys8ucReNb8ZxcDQGuBvWAJ7580Qns2tqSLQJxr?=
 =?us-ascii?Q?g4ETNko0+zCvdMhnhqX5FqJW0V+QuksVMHYyrAoun9vQXru1LFCdWxrDYr+3?=
 =?us-ascii?Q?QgnkR57dXKoWC9JqCTwMx8+Ug36znyTaci8GYYxYA2y0sZdEEvXjD4FsyTR3?=
 =?us-ascii?Q?E2JnRXX03zozr4WyI0lnHnZTM4mXE42/BRlmTaDDOZt1v7TrVoYgV2GfZ0BK?=
 =?us-ascii?Q?FnUK/X0Fw6MuWA2Wfw2zw72hHNvq56AJSmKWJr3ShLQEKUnw+MUzgpAxGvV/?=
 =?us-ascii?Q?mlsdXZ7tp6zRJ0KHaF9WnYB8Q5lFBQXunyZjyxW6rCg5tRqeI+vyQscvdRYb?=
 =?us-ascii?Q?3k8N7ebiZFNEqb7C2aH2aBBped1zMRsBgCtWczX0wP2zAFfcBPZs8IhOP+d4?=
 =?us-ascii?Q?Va3C0R6cIUQzDiqzlY9Dw+FcSTrNp0l9qJjYzPSduxfJR7yMGAhVOI5wC2WF?=
 =?us-ascii?Q?fTyKU9RCAQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 548bc75b-35e1-43a8-6fa5-08dea30fcc9c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:15:38.7143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5E/eURd9p73RLwLpKDgKUDjiEjKyTXxlBaY7yjaxh9nWQ/CFbMng8YZMiu802WVzuPi8CRwMyNFSTcGSWGDzw==
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

Add the Virtual Memory Manager (VMM) infrastructure for GPU address
space management. Each Vmm instance manages a single address space
identified by its Page Directory Base (PDB) address, used for Channel,
BAR1 and BAR2 mappings.

Mapping APIs and virtual address range tracking are added in later
commits.

Cc: Nikola Djukic <ndjukic@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs     |  1 +
 drivers/gpu/nova-core/mm/vmm.rs | 69 +++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 drivers/gpu/nova-core/mm/vmm.rs

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 045e35c92b78..88d0b436de4e 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -35,6 +35,7 @@ macro_rules! impl_pfn_bounded {
 pub(super) mod pagetable;
 pub(crate) mod pramin;
 pub(super) mod tlb;
+pub(super) mod vmm;
 
 use kernel::{
     bitfield,
diff --git a/drivers/gpu/nova-core/mm/vmm.rs b/drivers/gpu/nova-core/mm/vmm.rs
new file mode 100644
index 000000000000..7a2ab2acaa9b
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/vmm.rs
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Virtual Memory Manager for NVIDIA GPU page table management.
+//!
+//! The [`Vmm`] provides high-level page mapping and unmapping operations for GPU
+//! virtual address spaces (Channels, BAR1, BAR2). It wraps the page table walker
+//! and handles TLB flushing after modifications.
+
+use kernel::{
+    device,
+    gpu::buddy::AllocatedBlocks,
+    prelude::*, //
+};
+
+use crate::mm::{
+    pagetable::{
+        walk::{PtWalk, WalkResult},
+        MmuVersion, //
+    },
+    GpuMm,
+    Pfn,
+    Vfn,
+    VramAddress, //
+};
+
+/// Virtual Memory Manager for a GPU address space.
+///
+/// Each [`Vmm`] instance manages a single address space identified by its Page
+/// Directory Base (`PDB`) address. The [`Vmm`] is used for Channel, BAR1 and
+/// BAR2 mappings.
+pub(crate) struct Vmm {
+    /// Page Directory Base address for this address space.
+    pdb_addr: VramAddress,
+    /// MMU version used for page table layout.
+    mmu_version: MmuVersion,
+    /// Page table allocations required for mappings.
+    page_table_allocs: KVec<Pin<KBox<AllocatedBlocks>>>,
+}
+
+impl Vmm {
+    /// Create a new [`Vmm`] for the given Page Directory Base address.
+    pub(crate) fn new(pdb_addr: VramAddress, mmu_version: MmuVersion) -> Result<Self> {
+        // Only MMU v2 is supported for now.
+        if mmu_version != MmuVersion::V2 {
+            return Err(ENOTSUPP);
+        }
+
+        Ok(Self {
+            pdb_addr,
+            mmu_version,
+            page_table_allocs: KVec::new(),
+        })
+    }
+
+    /// Read the [`Pfn`] for a mapped [`Vfn`] if one is mapped.
+    pub(super) fn read_mapping(
+        &self,
+        dev: &device::Device<device::Bound>,
+        mm: &GpuMm,
+        vfn: Vfn,
+    ) -> Result<Option<Pfn>> {
+        let walker = PtWalk::new(self.pdb_addr, self.mmu_version);
+
+        match walker.walk_to_pte(dev, mm, vfn)? {
+            WalkResult::Mapped { pfn, .. } => Ok(Some(pfn)),
+            WalkResult::Unmapped { .. } | WalkResult::PageTableMissing => Ok(None),
+        }
+    }
+}
-- 
2.34.1

