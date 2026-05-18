Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FC5CD4F52
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A594610E998;
	Mon, 18 May 2026 18:11:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="FBOIWqaR";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 209E610E990
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:11:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrfV0Z4EDtU6rDKnJAYEbdkfEM4bA9SJJ5osySk09GLWxLOJWq8KaYN/3unIB8XtapIml2b9TsEwr5oDbHVKBrpqMYLYVvuy5RyngxTg7Ep8XlvqHWYRkzEIjTUFlCfpR7X/7sBR9Ytacbe5JLhFMLPtDnoTC0dQMllXg34uJy6mQHfToFHhjor5MVsUEBn+8YDBAcolIdH1r5EYgYDELLG775CYN5IyadWmb9qe/CdlsSN5MIp+b8/FTZ5PuDApSD+lPMx3E318sSJyOeJfE2lUXijX8iwwGLOG9+YQdL+W9kTTQEPanUWbwHwJc8nHIaffVlOeSHEH1QMs7J3l6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4XKVkRE21sFrDAsnT3lQOMvMBscVD7WXMMfZgM5fk4=;
 b=PyS3dQrj5iwyWPkEynypEorPkjLRNhe303BSg0isQs3PDloDTXd8ERC9jsxKd/G2uyA9qbI3tlZI+rn/2zWUC7+yIPHRDKe3El6RzYef+2p0RdETqmKXHCYNCTWGVxLA9EI+u3E8xPSDEOaK5fXEAl1V8XyuFmSu2CKnUXvhZXYDRhTDYoL2JDJDM6228SWCKq4Zz/621kyUgOqTHjOyiU/uQMOPKxxVc7qMnLBbUI8R1cHN7enyg40J5R9QCmlEHsvTM14djViS191YRuQkLrWPdfABVydKodIr1iYKvuQmMVEb2hiOYR3ZRB/Kxz/sjZM74no6yJjabYIwswSjrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4XKVkRE21sFrDAsnT3lQOMvMBscVD7WXMMfZgM5fk4=;
 b=FBOIWqaRwLRNGHPRSUFcJ51X7zpxy9vd9hGrcY9LNzDklnP94zBeEH8omloUkpyb2+gU52Dps/GBRr/JWvWrcAXCwIjlKeYXNsGWGLnWnY2IpM8px/fqjzNCzY+Nt92IFyLcHu+DNoMZqeq8sQOf4AufeUmK89ZMhynEJ3eYAZCckVlf9/CbzcHtjJKlAZRUJ5cGY98ld+ddlmBWY2jmEeaXp9DSVymdSCiKJLAIPIpWdKERUGgsjagPJCr11U7O+bKuF09Gus5zSVNN5AGbgVZ+kWdzmuv31Xn9y2jnoHt8vrNRWBxEZ5eANMgDV4CkchMO3uMW9/AY4zEuof/jXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH7PR12MB5952.namprd12.prod.outlook.com (2603:10b6:510:1db::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.23; Mon, 18 May 2026 18:11:48 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0025.012; Mon, 18 May 2026
 18:11:48 +0000
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
Subject: [PATCH v1 11/16] gpu: nova-core: mm: Add Virtual Memory Manager
Date: Mon, 18 May 2026 14:11:20 -0400
Message-Id: <20260518181126.2493572-12-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518181126.2493572-1-joelagnelf@nvidia.com>
References: <20260518181126.2493572-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0003.namprd08.prod.outlook.com
 (2603:10b6:208:239::8) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH7PR12MB5952:EE_
X-MS-Office365-Filtering-Correlation-Id: 804e5a29-e2ac-4e0a-77ae-08deb508ed1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|11063799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: NRycFC88+prnZorXdBq/nTC8uBn5reqqNhpStp0cmX8VE+xFLu+bOq5VDocZpAE5TMxHRuqwfDKctA7mY12AwYfa9YYCC0W5svRcKHclNdHTzfgXxm1gf94D+Nx3GfNsLnEewmhxaNLuX5Mh7EkPd0hEsrsgdZpOx6bAm9h9cKRf4tj46xxI7urAnSu6vh8Wrl7MkRJWTjMZYcb7Q1w7h6ZYeLyygIKZt9xwf03mhNrR8bzkvSDaskcyiIXqSoQFRkRYkmsxuYCKaDucJD+hSzxtavn1q8sNOi21fHPK3wiu1Rdr4KPAgPEOG1kK5JsTw3McFFb6gu8lwxs71TFtg0XTqYVkQal5bFCjc918zJ5a+tS9joAYf7YWVBD+RbxqEQt4T9w+D59QGfzMOxkqXFlqIoKV8uBqzUns7DibMmN/LQfnUDAGuyjNaX8FggaKf3BInZTqQpSbSk7V/QB1r4fEL7dBkVr7QZE7+GpjDZgdUFNrmt1WbJ81S4V6gUYYvhbYviiYAauXnl2qEbW2K+1p5kvy9SoujxFBrGrN5aCjUUjyNYlBmeUflvew+BWgMR1SQs/R35Sb+PgdJV0VOGi4w5QsqbDFq1awQoAtjQevBSJmWSQVFLKpurzSyQtl4r0bxCuHOEgZ7rIObCI3w/cmF4BmuOKgW+DwqcRakgovzmHCmoEa/n/lgsWuZgdz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(11063799003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8kYuyqz8aL5tVCQDIZUVYeYqpTCrM2knvmEsx+Xh7QMc8teidu2krjRypIT0?=
 =?us-ascii?Q?dqc7qT+DDIINboHQc/rbph0Ott5tsGhF0IQtJwbgW+kKAgvPDAz8U+ENWTdY?=
 =?us-ascii?Q?PPT2CAaCb78c+5hfHGW5IaSH7nfMYny5V9eRRCP7bmzmMc6+XJzxYP2hFllx?=
 =?us-ascii?Q?THwL/ianH1Vx7dQKkRWm2edoJPoPIcXJyLDraOwQL92R+NUoQcx+aj76hetT?=
 =?us-ascii?Q?7KCbAdHgMwLkvpadoliBi0mQMF2T+j0ZrgEEIPgoxwzj5lUvJn13Sb7R5KSE?=
 =?us-ascii?Q?4s0/pcQMFef8x2e4lvVV+g30IuA9tGE0h85VRFVq06UaK1UY/LTzshFUi3qF?=
 =?us-ascii?Q?DcKsp421T6F9ga1uoZ6fHhnWKm2jXwzBB86J718sKVB6B1b8ghfnmAigHhPu?=
 =?us-ascii?Q?CIawnTxmHfxfUiLoW9KxnKjABa18aSqDUNOn12Io78Qm3BevTZF6KMtgO4pM?=
 =?us-ascii?Q?FDw84WyFYfNNDB8X8dk6t5f6dHW+9V0hFdht7bIDLDqiZQKAtOdTKGKBWOKu?=
 =?us-ascii?Q?b0g6oDiucavW2Tk1NlYlOZTnUx5aBWnY6TS4SRFcLaSv47ROwXhpAosvlA2z?=
 =?us-ascii?Q?Rb9ugEl+2ycWLh9JnXva0lpZDU/YlMzvRw/j4AYliqMZosNj99mjov/4f8aa?=
 =?us-ascii?Q?N3OU4RgASyiTfRrkKUL9GmOUak3Z2IqkgYjEDUGPZ8s5YuuNg/f0HzNhZIhe?=
 =?us-ascii?Q?8VI2C0esAMrj+yVMWViBrV6VF6YgyUEOKIHZutI2gmuhZyxkd968AJngyPNy?=
 =?us-ascii?Q?Q7umzSc9Dwuc0v9+so49QwYFYH8FHEomfhC7Z0Dt1GmEPbK/qlMMbJ/o0rZT?=
 =?us-ascii?Q?8KaIfRXrsDd1Rynzx5LhboX2cT+mTrY+i+BDdQwHBtAZ+WvKL5aRGJY1GzW2?=
 =?us-ascii?Q?0k5xFzF3RITl22e7mceCx/X+00gR9Gu0cjHrw7f1cjt0EpQDmirhdtW5I/wo?=
 =?us-ascii?Q?1zjw3facyP9iYbrkD165+UWA9gQsye6oVoB0E14H39yPct7nOipNow6AuE0G?=
 =?us-ascii?Q?bW4jlffm/BEI/OMGKyx0i+V3iOvsKSw0id3PK3o2QpHZp+ICAws93PZ75C0d?=
 =?us-ascii?Q?4FL8nhETrqbY0ALxWyXa089mTpzk3dvrv3fnsAq2E0elVeJ90s/z+2H/5d/c?=
 =?us-ascii?Q?8rCHQuBHCVunMmbMFNT5BzOOLDNeKEkAaHygFltEbjeP4BrwidP08lGqr/bd?=
 =?us-ascii?Q?4Ja6/PQ1xCA1qtEkKsh5JxUFNFNELUPExOQuJvKRtXpaPSySA0EQlKHAwIKD?=
 =?us-ascii?Q?RksE9DOzJJdznX/vEE1hd4zroTfJZNNgLx9HrCDT7843rVDiIA4ni2gY533G?=
 =?us-ascii?Q?rMc4iYgg8yDfxzzjTsWYcvLRCz+qEaW/qQvoZxDjwYCFPvQOnaSYYwenGdXE?=
 =?us-ascii?Q?g4PU7pJ8fbwYcZJ7qsu4XHDin2kaC6NJtli+/iASIIEhWybS5GdOi2nRGBUK?=
 =?us-ascii?Q?TZW2w8aNC72Krjly5JrskMZFRlSjldmb0q3Ac+lrHP8I/6TUOIeokMTZm+5V?=
 =?us-ascii?Q?tQ3eDYNV9pCwiFLs6Ay7kbNhYU/sggNMa7svLzc1AHB4rt3aIb5SU7u3qcQo?=
 =?us-ascii?Q?oDYzSsSaXorGFuWnG6QJETLZ0afvg65rjkhd/ntC2o+Oxfus1/kRxIAWK04T?=
 =?us-ascii?Q?P+cO//pO8Y6yK2dUPbEhjG4s9y8A0LbFvw5e4SufCgSNkLJljL/OKWIkOub4?=
 =?us-ascii?Q?LixLkiCC0kLKM3PlX2GQgTIr2cXWWpiwFniVFPCH6I502IlUC7W8Zql0Vy7E?=
 =?us-ascii?Q?RqzDEg2dhg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 804e5a29-e2ac-4e0a-77ae-08deb508ed1a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:11:47.7700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+nRsZ8BZxR3OObS9eMBcMJX4vC2gspMDUgTzHspAlIFzf98+pTIX0w6r2L6Rs20NQ13negVsYl937slD+caYw==
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

Add the Virtual Memory Manager (VMM) infrastructure for GPU address
space management. Each Vmm instance manages a single address space
identified by its Page Directory Base (PDB) address, used for Channel,
BAR1 and BAR2 mappings.

Mapping APIs and virtual address range tracking are added in later
commits.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs     |  1 +
 drivers/gpu/nova-core/mm/vmm.rs | 64 +++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100644 drivers/gpu/nova-core/mm/vmm.rs

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 66cc33389159..502c7fdceba2 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -34,6 +34,7 @@ macro_rules! impl_pfn_bounded {
 pub(super) mod pagetable;
 pub(crate) mod pramin;
 pub(super) mod tlb;
+pub(super) mod vmm;
 
 use core::ops::Range;
 
diff --git a/drivers/gpu/nova-core/mm/vmm.rs b/drivers/gpu/nova-core/mm/vmm.rs
new file mode 100644
index 000000000000..3e18adc23b68
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/vmm.rs
@@ -0,0 +1,64 @@
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

