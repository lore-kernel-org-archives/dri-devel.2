Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17767FF885A
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 21:15:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5871810E490;
	Sat, 25 Apr 2026 21:15:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="QTskZMrk";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011022.outbound.protection.outlook.com [52.101.62.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C98A10E492
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:15:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZ1HFRUw2mbfU4d38VrsNhx1xfP18exv9dBLsoTo+jA3T2hKYFYxfmtfDUCYoHqBFrmJ9KpwBjd7ZRVXWSBGuYaZhKhLipblbZrOQDCcnvAfqi2oCb2F57ZlAss7joGiBs2rSNHlTZU50iA+qnIv7md5314eLm6e9fR73VRYkJ1cNSX/qNEEGcEFxkYs5N9vyAQIJuDjetwl5lpSPc3fAEvyr+PnsJSJgAs9sLtSLOYVKmegjUHG8L3RVTb5ExgvKWEuzTxwIkrB18ANqTv6w7FXugnReUpfgFKYxRvGqEUOgwrMZQpmWhdsf5F82ZgAD6jjpOjZB+ctvhkpm/TNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqPz6tsrxhlZeCzcrTYa+E9Y14lHQAlG4xm4aMwUXtw=;
 b=xNpyfXrs67I94Sb9Sd/6gWmZkLsQGRv5yj1RUlQ8wZqcW4WFU+aX8K6HeAwjmhr4sI/5XvOb3G4meaRUZ7vBBAanYwhX7DhZICN3Gc2YisJNG8Nv9D/05TmH/tU5k5/rTCLOhzUhhq2Ec5BviyTxZUH1KEl14PPh4/M7Labo7v3LIqvr+gBFGfZqMUMk6nsmUjS7GDVqxMIf6ZoGcBJMPylrX+LBKH40lMzO3pjZMZbd4HQsaQn2VUFxgzCfR+7y1Zsw551hAx1vcTc4lFFbQvdl3ginxDy3om6foWMvMhlgaxjfh+0byTu2kSQvCgRnmbyioFynR0o/khTivOqs/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqPz6tsrxhlZeCzcrTYa+E9Y14lHQAlG4xm4aMwUXtw=;
 b=QTskZMrkRrNTd8bGVVwnhdzisLHP4W2srQfyI/vJ+vjGYc7XqjDQzQE7jRyn/pZDBiSLb9BcPveSa0gW2Vgxcfp0CTeHQjEU5oUfWl9pLZ1kGEGvYckJyh8vVY3rlL7d0SN/M2Qe24B8dy0vbj2IxRF9WAz8dFj54K2+ZsFKncX5pNDMzBP6S7my5G4aHWYBvfUWfHMm4UeYfivAhoyA4Xe9OFJz6UyX/T43zvtBSRauVdrXiO29ftHCbL2aXLhuBFQpYYnT+O7YBDL8JuxGQMT4uBHfJxTzlTmM53PGjuKaMWPyTInbHIl1rpW0blGFwcXp00X+iqjN8Dwd1jhAxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Sat, 25 Apr
 2026 21:15:29 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 21:15:29 +0000
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
Subject: [PATCH v12 10/22] gpu: nova-core: mm: Add MMU v2 page table types
Date: Sat, 25 Apr 2026 17:14:42 -0400
Message-Id: <20260425211454.174696-11-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425211454.174696-1-joelagnelf@nvidia.com>
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:930:4f::12) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: 3823bb6d-bfba-4141-97e6-08dea30fc720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5N60g3eDg42jZQkQ4OZgw77dAKufv/xKl7HYffnM/sPBgAlwJGsGafChfzsAcHMvl4K0Ujd+rdn/xNOx92zLjTcFyqt2AfGuIy5iCsHxRlUSaFP9wCQHFWGgGur7w3u18TJuE1ufGHfq1l+60Dndk6EWphvTfRxUUXsKJeM0pskBfidaQkxCpY5gjDwJjgCUg8PVDSivvkosLwugqH+/QlYJY8K6kkTbAK4E3heV5T9xCJKkqz4buKS1sYzoFGM0Tp1SF245eUZuK6b9eGfpdeRRMpFkqHWedoxLcfOjVrktwJCpAAm6qoRafJA2ZBMX1DUf2hAyVNtrBnQ30Kl6BdofCBeW+ZvnyFiWnYtk7QF39dToTHIVQDR1puz5LZ0ud+i2ZPuUOk5tQRcs/tIauOKGsAL5WH9rTvkKNdndulehdMrV8mzr0fLA68y3d6ieCdI753wx3MAgur61wAYpp/UwYmDxwraDZ6W9TzUJHuJXNvcyIgAM/q04QGFs7GE7diRArqbZy96Yr67OuAl1y6CgL5tozlCOJ/AItSbcClTC01DGDIqJDZh8yUG/KjBIgge+ch0VawWy6TySsN9mihRwG58jlC1v3qetVb3c2a7HhfhoqQirhnf79zfqStBGwNq61+68rzBzRNnO8sbF+h9aLwkRFfmmDFk/upuno8gluo66WgNpC4qGE3rm7h8tXLkpo56TndrGLeO0hFicdjtVweIYgBY3U2dlR+cOv8s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QofgBtKHIpQkpgwp+MlsGpH8qu5audPBS/sb0cK8ektIopsD6Xn6TaTw1lvB?=
 =?us-ascii?Q?+TgJjDSQeneifg8VbuqN/Jq1okPYRBKw8byX/DUhQ6F7to/ocmLhusvHeIo/?=
 =?us-ascii?Q?4ulLYa+pABX1xZxMAatVLKsDO6Kv9j0EyE9wx4yVHHn3he7vX3k8xXz1VqyO?=
 =?us-ascii?Q?hWc2OY2/SQvhOU8nq+obJoUUraiX+R3VvXsxRiAl77pKF5OaPaAiVw2bLFmH?=
 =?us-ascii?Q?pp95gXUJYIFsjVMeZhW67WjmcfNGnjxWczsY+HDb2TdBO5i/WwUnzSGpFlwS?=
 =?us-ascii?Q?eLFJP2MnRiepLjK/Uf1fUC5fWvoPRX/lB29BSPg1h5u8VHavNMv+0+Zkcgfr?=
 =?us-ascii?Q?eAvrGWjQxODj7MSwAFwqtPHckXQsqmHUJK3gTj1HSeq9F34yhEVu0S7z0cqn?=
 =?us-ascii?Q?/SHFjY/+CmNnalSDQ8VWfprARffgsDe8gOcDgekV3xkv1ZvZqAeDz7RTQTDJ?=
 =?us-ascii?Q?wYcFaPlBvUFJymZKBVbzJ9sZRlN0pFRJ/W8IaShoVZihFHBJ2zz6O1U9Vntl?=
 =?us-ascii?Q?qE6d0dZnQQ0feXXBlcpNwxt9CVh4rg02p9iIKzhodZ50YzlwpAcJyfrhyCCv?=
 =?us-ascii?Q?yeWGFGTTR5TvXRTySu7VZlgTjPHSW6N4HRCggJbQRl/xMxD98JEYsDpRP31F?=
 =?us-ascii?Q?Zmy0f7N21+XZr2CFBeQ6MpXdfyPF6wc+WuJus2yhiIa0F4eEHFlfpp/9Z4iC?=
 =?us-ascii?Q?CJUsxUtBkrbn6uCYUARmOtnpiBCUy/yj5ZBqVK27u4FmMhEBxpedpAyWM6GR?=
 =?us-ascii?Q?fVRuu5l2TJ11fcNi05/I11/OJeoCRn46KHVyMFd/AZ1QLMo+hEs3UqI/pO6P?=
 =?us-ascii?Q?TI1PlbSP1rkCOb+H428Jonoai/G+gRlUFwhet2uK4Mf2hqWeNBFmyZDufjDs?=
 =?us-ascii?Q?HjtmF0BLEGsaM7y5AEcem72FsW4FE7xVskq2dq0vwJl9sAAGg3xSdBa37nxC?=
 =?us-ascii?Q?t7K7cM9qizQcAujtMHmnrDpfvBIWsql381of/5mGSMyqdehikQOjMcfqjbJo?=
 =?us-ascii?Q?7dAM+8vqKv3ITieBdPczaUSUg2e5AtyOd1rDdfXdC5vGLbx/PGU2aJJsmk9+?=
 =?us-ascii?Q?AyU/keHwxCipu/0LE2g5RQQ/+mLJNPHbP326W9dwwoKbG6e6hlGztTh139yM?=
 =?us-ascii?Q?mKyxceG4Dq3EYCw7gzjkkNwMSr9gA7KZ+HYjUtNREjkDfqmSxoRreMX1TdWZ?=
 =?us-ascii?Q?eAuQNF6YQwS5LbWLWmWtb/cQ/X3m0GY2ugEPhxORXBJtF2Qx99zs0McKSwkx?=
 =?us-ascii?Q?blRQoVufFEH3gdUZ1b2tQ+JLXSVc3vKJylr7bra8nEYq/VhrMAMCxFStWtz7?=
 =?us-ascii?Q?ElNkn4ZU9/XqrGpI98FuKiAcB7nnfTCmqOAMrb0caBrMslr3xMcs5u3Bt+bj?=
 =?us-ascii?Q?4lumS2snN6S9Ltbng1KpU30ld4xo6x8gKhc7pqEscLWxhf2SZ05lW3LymOuH?=
 =?us-ascii?Q?TmBhdIwy1huW6wKYpwYuMnSyna7c7wSZWAg0zJL+F+HnphFFNeQRpKj2+j4U?=
 =?us-ascii?Q?qAxCteYDsZXTa5FjDtkyl7BrK+mGhbA50FwmsbTzOrQ2i6WNhENDw7Y5ffPO?=
 =?us-ascii?Q?3Pc7RBVXghfmFAUi/QamWsYl8C1gRRCHBalF85z/fLugRBO8AKl8+KfIOVY0?=
 =?us-ascii?Q?7fg5vnWa6SG9m6MWlrAiOObzWEP2JAQl4uLI25i2mu87bGHn3MjMY/l+1dkq?=
 =?us-ascii?Q?cg0Us7aWw40y3APy1tJyhNIXeVvdxaNGQXXYCdksXC7nC88llXrX4+zqTzK/?=
 =?us-ascii?Q?O+RqtUMcgw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3823bb6d-bfba-4141-97e6-08dea30fc720
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:15:29.5186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1M7+1RjS5cPdE2U5JiW3cVUZl3HIMsr5KRF0YBcW1LKlBQJosHlHt0QqDr6HVJdnVIB5HU3vbGVNjA9uBJrMg==
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

Add page table entry and directory structures for MMU version 2
used by Turing/Ampere/Ada GPUs.

Cc: Nikola Djukic <ndjukic@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/mm/pagetable.rs      |   2 +
 drivers/gpu/nova-core/mm/pagetable/ver2.rs | 270 +++++++++++++++++++++
 2 files changed, 272 insertions(+)
 create mode 100644 drivers/gpu/nova-core/mm/pagetable/ver2.rs

diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-core/mm/pagetable.rs
index 637ff43ea83a..f6b184c9b8c8 100644
--- a/drivers/gpu/nova-core/mm/pagetable.rs
+++ b/drivers/gpu/nova-core/mm/pagetable.rs
@@ -8,6 +8,8 @@
 
 #![expect(dead_code)]
 
+pub(super) mod ver2;
+
 use kernel::num::Bounded;
 
 use crate::gpu::Architecture;
diff --git a/drivers/gpu/nova-core/mm/pagetable/ver2.rs b/drivers/gpu/nova-core/mm/pagetable/ver2.rs
new file mode 100644
index 000000000000..203dc5d9fdf6
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/pagetable/ver2.rs
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! MMU v2 page table types for Turing, Ampere and Ada GPUs.
+//!
+//! This module defines MMU version 2 specific types (Turing, Ampere and Ada GPUs).
+//!
+//! Bit field layouts derived from the NVIDIA OpenRM documentation:
+//! `open-gpu-kernel-modules/src/common/inc/swref/published/turing/tu102/dev_mmu.h`
+
+#![expect(dead_code)]
+
+use kernel::bitfield;
+use kernel::num::Bounded;
+use pin_init::Zeroable;
+
+use super::{
+    AperturePde,
+    AperturePte,
+    PageTableLevel,
+    VaLevelIndex, //
+};
+use crate::mm::{
+    Pfn,
+    VirtualAddress,
+    VramAddress, //
+};
+
+// Bounded to version 2 Pfn bitfield conversions:
+// 25 bits for video memory frame numbers (bits 32:8).
+impl_pfn_bounded!(25);
+// 46 bits for system memory frame numbers (bits 53:8).
+impl_pfn_bounded!(46);
+
+bitfield! {
+    /// MMU v2 49-bit virtual address layout.
+    pub(super) struct VirtualAddressV2(u64) {
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
+        /// PDE3 index [48:47].
+        48:47   pde3_idx;
+    }
+}
+
+impl VirtualAddressV2 {
+    /// Create a [`VirtualAddressV2`] from a [`VirtualAddress`].
+    pub(super) fn new(va: VirtualAddress) -> Self {
+        Self::from_raw(va.raw_u64())
+    }
+}
+
+impl VaLevelIndex for VirtualAddressV2 {
+    fn level_index(&self, level: u64) -> u64 {
+        match level {
+            0 => self.pde3_idx(),
+            1 => self.pde2_idx(),
+            2 => self.pde1_idx(),
+            3 => self.pde0_idx(),
+            4 => self.pt_idx(),
+            _ => 0,
+        }
+    }
+}
+
+/// `PDE` levels for MMU v2 (5-level hierarchy: `PDB` -> `L1` -> `L2` -> `L3` -> `L4`).
+pub(super) const PDE_LEVELS: &[PageTableLevel] = &[
+    PageTableLevel::Pdb,
+    PageTableLevel::L1,
+    PageTableLevel::L2,
+    PageTableLevel::L3,
+];
+
+/// `PTE` level for MMU v2.
+pub(super) const PTE_LEVEL: PageTableLevel = PageTableLevel::L4;
+
+/// Dual `PDE` level for MMU v2 (128-bit entries).
+pub(super) const DUAL_PDE_LEVEL: PageTableLevel = PageTableLevel::L3;
+
+// Page Table Entry (PTE) for MMU v2 - 64-bit entry at level 4.
+bitfield! {
+    /// Page Table Entry for MMU v2.
+    pub(in crate::mm) struct Pte(u64) {
+        /// Entry is valid.
+        0:0     valid;
+        /// Memory aperture type.
+        2:1     aperture => AperturePte;
+        /// Volatile (bypass L2 cache).
+        3:3     volatile;
+        /// Encryption enabled (Confidential Computing).
+        4:4     encrypted;
+        /// Privileged access only.
+        5:5     privilege;
+        /// Write protection.
+        6:6     read_only;
+        /// Atomic operations disabled.
+        7:7     atomic_disable;
+        /// Frame number for system memory.
+        53:8    frame_number_sys => Pfn;
+        /// Frame number for video memory.
+        32:8    frame_number_vid => Pfn;
+        /// Peer GPU ID for peer memory (0-7).
+        35:33   peer_id;
+        /// Compression tag line bits.
+        53:36   comptagline;
+        /// Surface kind/format.
+        63:56   kind;
+    }
+}
+
+impl Pte {
+    /// Create a `PTE` from a `u64` value.
+    pub(super) fn new(val: u64) -> Self {
+        Self::from_raw(val)
+    }
+
+    /// Create a valid `PTE` for video memory.
+    pub(super) fn new_vram(pfn: Pfn, writable: bool) -> Self {
+        Self::zeroed()
+            .with_valid(true)
+            .with_aperture(AperturePte::VideoMemory)
+            .with_frame_number_vid(pfn)
+            .with_read_only(!writable)
+    }
+
+    /// Create an invalid `PTE`.
+    pub(super) fn invalid() -> Self {
+        Self::zeroed()
+    }
+
+    /// Get the frame number based on aperture type.
+    pub(super) fn frame_number(&self) -> Pfn {
+        match self.aperture() {
+            AperturePte::VideoMemory => self.frame_number_vid(),
+            _ => self.frame_number_sys(),
+        }
+    }
+
+    /// Get the raw `u64` value.
+    pub(super) fn raw_u64(&self) -> u64 {
+        self.into_raw()
+    }
+}
+
+// Page Directory Entry (PDE) for MMU v2 - 64-bit entry at levels 0-2.
+bitfield! {
+    /// Page Directory Entry for MMU v2.
+    pub(in crate::mm) struct Pde(u64) {
+        /// Valid bit (inverted logic).
+        0:0     valid_inverted;
+        /// Memory aperture type.
+        2:1     aperture => AperturePde;
+        /// Volatile (bypass L2 cache).
+        3:3     volatile;
+        /// Disable Address Translation Services.
+        5:5     no_ats;
+        /// Table frame number for system memory.
+        53:8    table_frame_sys => Pfn;
+        /// Table frame number for video memory.
+        32:8    table_frame_vid => Pfn;
+        /// Peer GPU ID (0-7).
+        35:33   peer_id;
+    }
+}
+
+impl Pde {
+    /// Create a `PDE` from a `u64` value.
+    pub(super) fn new(val: u64) -> Self {
+        Self::from_raw(val)
+    }
+
+    /// Create a valid `PDE` pointing to a page table in video memory.
+    pub(super) fn new_vram(table_pfn: Pfn) -> Self {
+        Self::zeroed()
+            .with_valid_inverted(false) // 0 = valid
+            .with_aperture(AperturePde::VideoMemory)
+            .with_table_frame_vid(table_pfn)
+    }
+
+    /// Create an invalid `PDE`.
+    pub(super) fn invalid() -> Self {
+        Self::zeroed()
+            .with_valid_inverted(true)
+            .with_aperture(AperturePde::Invalid)
+    }
+
+    /// Check if this `PDE` is valid.
+    pub(super) fn is_valid(&self) -> bool {
+        !self.valid_inverted().into_bool() && self.aperture() != AperturePde::Invalid
+    }
+
+    /// Get the table frame number based on aperture type.
+    fn table_frame(&self) -> Pfn {
+        match self.aperture() {
+            AperturePde::VideoMemory => self.table_frame_vid(),
+            _ => self.table_frame_sys(),
+        }
+    }
+
+    /// Get the `VRAM` address of the page table.
+    pub(super) fn table_vram_address(&self) -> VramAddress {
+        debug_assert!(
+            self.aperture() == AperturePde::VideoMemory,
+            "table_vram_address called on non-VRAM PDE (aperture: {:?})",
+            self.aperture()
+        );
+        VramAddress::from(self.table_frame_vid())
+    }
+
+    /// Get the raw `u64` value of the `PDE`.
+    pub(super) fn raw_u64(&self) -> u64 {
+        self.into_raw()
+    }
+}
+
+/// Dual `PDE` at Level 3 - 128-bit entry of Large/Small Page Table pointers.
+///
+/// The dual `PDE` supports both large (64KB) and small (4KB) page tables.
+#[repr(C)]
+#[derive(Debug, Clone, Copy)]
+pub(in crate::mm) struct DualPde {
+    /// Large/Big Page Table pointer (lower 64 bits).
+    pub(super) big: Pde,
+    /// Small Page Table pointer (upper 64 bits).
+    pub(super) small: Pde,
+}
+
+impl DualPde {
+    /// Create a dual `PDE` from raw 128-bit value (two `u64`s).
+    pub(super) fn new(big: u64, small: u64) -> Self {
+        Self {
+            big: Pde::new(big),
+            small: Pde::new(small),
+        }
+    }
+
+    /// Create a dual `PDE` with only the small page table pointer set.
+    ///
+    /// Note: The big (LPT) portion is set to 0, not `Pde::invalid()`.
+    /// According to hardware documentation, clearing bit 0 of the 128-bit
+    /// entry makes the PDE behave as a "normal" PDE. Using `Pde::invalid()`
+    /// would set bit 0 (valid_inverted), which breaks page table walking.
+    pub(super) fn new_small(table_pfn: Pfn) -> Self {
+        Self {
+            big: Pde::new(0),
+            small: Pde::new_vram(table_pfn),
+        }
+    }
+
+    /// Check if the small page table pointer is valid.
+    pub(super) fn has_small(&self) -> bool {
+        self.small.is_valid()
+    }
+
+    /// Check if the big page table pointer is valid.
+    fn has_big(&self) -> bool {
+        self.big.is_valid()
+    }
+
+    /// Get the small page table `Pfn`.
+    fn small_pfn(&self) -> Pfn {
+        self.small.table_frame()
+    }
+}
-- 
2.34.1

