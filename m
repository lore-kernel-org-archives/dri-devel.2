Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002DFFF8864
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 21:15:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2330E10E491;
	Sat, 25 Apr 2026 21:15:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="NHj8LG/D";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011052.outbound.protection.outlook.com [52.101.57.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42CF410E48A
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:15:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPRFvv70jauQgznI6O6azgts1GId2sIeqJ5qDaMtlJaY26nHbns7CE6n+CH+CU6GF/QtW1pGZHuH/jaA62VLHBUWERpSRgYwJaAh4oP70wyTmYcR2cAXEDpshd5tgYcFZpxZ7MaNFtibLhXrykeV5DV6MAMKxbzp8/W2vlS9lX3LHQ25kKQ0D9I4PvEvHO33+L+D40gCI9xsHTxp5pGUxiN87DGvr8ztkThVzB18LgPdTOpkgsUjMGXmEzZe/6ruYyinFgmRMe1/CzGc/ryErCCj1mfm8bLD+wxFvgSWqy0Z6MFS608VqV2k868i5xSxlq7lyanTe3fjF37OSeVkPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iA1wUw71hQ616JkD3hhxEHGwtgltSdIBcceHVl2nBZk=;
 b=dObOwu/XgAAE8GyqMXqKDTy2QL9/+qpiHtwYwDbOjbc3MiOxJcuDXqjmky/4sTzPGr5Ek4n/jf2T6cBddOzt4GeDC14jYl0Omwn0ajez/o16TrAbor/6FRUV8u5ON/MQwqXypiCsXpCsjmnxsgC+Unmaqjy7RIQ6GpJx+/zu1SiR9pyVlBv7gmgyYYJ9H3Lhmu2FALcpYm+x+B+z9A9TegsJ3N67S2I/nNnZfglwGVY/munySLAj1RJyp2CyLDGoXtZuzo+voCpg7ctkG3cTRiA+yCES2IN/LTx+AsnqUdyUU3rDzgiRuInV5oBk+UohWoSLZM2PP0UekdXlpAjz5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iA1wUw71hQ616JkD3hhxEHGwtgltSdIBcceHVl2nBZk=;
 b=NHj8LG/DjmH2FbIDT5hRNPQq93KaZ9A0XbjeRkCPz7YiNoiTwdxdp1A500sg7R030BQs2iK/4ajd3nEyRHl8xNSfrsX4kqShA7j1c2TCCa4AsCgyJczr9V3HGjlEuK6i9Pk7rM/F4FCu+iu4hCGXyrQ9euHw3Snc0VdFil4Hph2LHA1qAn8ao1txofki13Vsq/Siylb53EvSg7aHFwy6xlSWf51S2fa/zXDooDjZtamva3j5WjROpJ6bi9+hHJ+n6zqRCLm0bGvP+28aKdSI8knxMq+GQ2qJ5INMCALWQxnH79FoXGlHMWgPAMiEi37tKx1HRZPOzGbpq6KN6YuSvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Sat, 25 Apr
 2026 21:15:27 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 21:15:27 +0000
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
Subject: [PATCH v12 09/22] gpu: nova-core: mm: Add common types for all page
 table formats
Date: Sat, 25 Apr 2026 17:14:41 -0400
Message-Id: <20260425211454.174696-10-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425211454.174696-1-joelagnelf@nvidia.com>
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:b::24) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: e88e21fc-6fc4-48d0-a837-08dea30fc5cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: J/YBpcaIsxsDnRmyV4psNdTmSFhYvN/qouIAr4GzeHC/rHjl1zhaHdxpMkNg7Ze+xopfYa0Zx0+EeIdfPhdOD8ooEBXTHiRooqOjNWNW1lCfwPjm0JYZEOgn/dpd8MVIfBf0mO2WiVru0mpGUzvj6Y4Cw+IsvdHNlKJhaHddNT/zbVgFC4IQbXhZVU1R5jD4Q4ajgyHClrME43aguQ0LogR5FH3/JK5UT83uI9FWF0/b7nfTHKluJ9tw45V3YXCWzVH5RXwVudaT6Bfbazfgv/6TwCHni/C0qr2XidXp25OhGaLaEoN9g7h+qDFURk3Nj7mclsqW+H044PdRrFXyO3VUT7oWjlmMGaNlwOE1cK3l2Xc2SUTusA1N/lBS7L+M6weGTJK0gYBns8hiNNIbWkpXjNaZ+lOsyLMm8o6L0dP2Yy5iHsuMHmSr8dJ7p0jS9kd8nMDp+HXhYoLx0tMuHMnO1a8NqfQmMsZHejO9azsAX7Qtc7e8HorqmLt6emxKnhMnlNGdmi5WCtfwtBSa6vPXLafXCdHBv0nNwIVeimNjD0PSpV6LtDObbp/bDe7nww/3INubow+xKyBHMzKLNjZNMAzltKy0RoD78mN/UYUCuoONyzb3kmex+inZC7dQhh3ZPxOQLLVYA/AdfNvXdTWLhkp5DTDDZ0QuuJZh71pwhvntUh1bpJhZJCS0iyZLZxdl3yjV1NsHnf/GLF1xp9qdNOA/RGsrIA2vHzEFSto=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AyfNUsh9pUQV0F2G2JrIKRfiQfwIFn+aS2NyoUmx3AEsV+FIghniIktLNB6h?=
 =?us-ascii?Q?wKbQbL0/RfuUjGxYkTZjNfUeqQ88iRqrrAMIrRNQC+kY7aplwE2GV9+s2zNb?=
 =?us-ascii?Q?CfknaDhoGBGl/wrKUC0NvzIjgpMtA99kPbxYuWnhwIMbhu2O1a9uJZLJSsOF?=
 =?us-ascii?Q?o9LdB5I6agmwKKNqYJxMK9cq2d/aspIGGLqvPxw4FJADDBdroXjjUbduOTjD?=
 =?us-ascii?Q?WLZT4LXtF02gM90tDf+oerKJDTdtSZhmsPbIDkLgczHT6UC5VFJre/B7+XIk?=
 =?us-ascii?Q?48MUwVAKenCRKhNmywa/qt/Uk/hH7B4jV6XANZoPpRoTaZuct2Ss9NUskMFB?=
 =?us-ascii?Q?YpSiRQdPsHScGfAxOqx9zxjF7eEOmir02Jcg9MJxEe8Ocl0J00Idkwo2bqAR?=
 =?us-ascii?Q?XSqxVSD1WtdV+Oi8RPLp7z1fQe8GMpA8qa1+3UKkNd9z02Gc/DbR0GeBvdZd?=
 =?us-ascii?Q?wcwWdgyi9MwYJ7oVSOr0l+fkpolwRcSxOV3dbkAvHQOOFQh/hNpTO4O6+Tz7?=
 =?us-ascii?Q?lgY0e48QTeCRXRoMo+0R1FYlXkrK/ep4zFDcerLzkFzy/vwcQz3Dn2nakgBc?=
 =?us-ascii?Q?21E3+1zOAz+1aJ+0yhVCD1o4DOgrHk3nGoCa7QZs5dhkiwm5UryMzbQKflp9?=
 =?us-ascii?Q?gFu7Uou+FgovzIK6VR7+wiuzvpjvVEaqvH3K19saFmqIjUrljOOJw6so+IlP?=
 =?us-ascii?Q?3MIKTJXZN+VVv8jcdaQMs2Wwq+pdf0em1UtfUWVRzgKA7ggTYZPgXM7in6JH?=
 =?us-ascii?Q?8cgYv9HIFIv444pO3tuiM9B4eQXGCkbz9ndxnQLLiqZ9lU6d6nApC6Qdy45B?=
 =?us-ascii?Q?u9nhOjv6lE9ljNYpM0l1QRx3N+YzsRu7jxTwFaLS6qgViXCQq/M9q/TJ1MO8?=
 =?us-ascii?Q?ldI5JlrN5ad2xs3a1oSO2IJrQmVRKaWx8dfbvAfctlOzO6Xd1TSbr42rdWrF?=
 =?us-ascii?Q?XK89svbo6WbsG15l9P2UUgA45Q/ff62L4t5yimOfhHYbBQCAp6ZNYnj+yAct?=
 =?us-ascii?Q?8vBaxvcH0vr0vMUm235eNyMeBH0lyQR79bzqcYDjs1FS9RHfphCuC6xgbE/f?=
 =?us-ascii?Q?KPlpHlxS6hlpSmRctCMq3iv0aJNlrOvsVnuKJXT96LxsgfEEEUMbyYzXmklq?=
 =?us-ascii?Q?3FbeW1RcgSTTgCugWhYdD7nPrmVYCgtqWv23GrZmPWLiAFs0aTKOoTXjeORO?=
 =?us-ascii?Q?pz93bP5vwA3MVapT/RSWlU0lPg2MxcBxryOTiVuCupb+8U8vyufIjE3zg63N?=
 =?us-ascii?Q?A1B2/FRvJEiGQ6EAvYjvDDOBF4AY+J4RruuoiAm1fIikE/8394kVTu0P8dcu?=
 =?us-ascii?Q?WMF/vU5P1vjMwLsPjeNypL9d871wTBfPyJoUM00kk5O0XmM424WOug/fc9KA?=
 =?us-ascii?Q?FnrlNgC8y0tyCaXlWNC2qPt9MRpnlFTbxcmgeojqnHINHPSSpsXEtu81bbo8?=
 =?us-ascii?Q?K4bQaY7WVPjk181Y9GE6B1VOgjGMw2WEP0a8sFrKnNbf/Y3rY1X8yqxoYeTV?=
 =?us-ascii?Q?sV78TIIy2rZNKaRxQxe7VZuNvMvLrddzrfxLAw9iXcODJDDoxLvnbIBLLyX6?=
 =?us-ascii?Q?FTMP4wSlXiaDOSkV1ROhWmUDya3gbkgCQ2M1N7TY9mCDNmWPXarLnlzEsBgO?=
 =?us-ascii?Q?xpop/vxYijR8MjxTzb5aF2mYZ4v0aINW1BwtNcGg4N3O/B2KN+GDRcOytDNd?=
 =?us-ascii?Q?lYh8BHzeLp3i2aJTxq6Wh8RlTboFF1g/HyFNCm/Rmbc/rsIemUVVZt4wR81R?=
 =?us-ascii?Q?CshSvn6Q1g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88e21fc-6fc4-48d0-a837-08dea30fc5cd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:15:27.2784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxUiSwEo4Ml3CYOfdsqQCEuFQ7fPcdWWZ5MUc7/EWHNZUD7zgpe9mKvggWprQE7Tm+kW3ZsV5IUzq+q3o8y5Jg==
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

Add common page table types shared between MMU v2 and v3. These types
are hardware-agnostic and used by both MMU versions.

Cc: Nikola Djukic <ndjukic@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs           |   1 +
 drivers/gpu/nova-core/mm/pagetable.rs | 157 ++++++++++++++++++++++++++
 2 files changed, 158 insertions(+)
 create mode 100644 drivers/gpu/nova-core/mm/pagetable.rs

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 8b8a86980bb6..045e35c92b78 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -32,6 +32,7 @@ macro_rules! impl_pfn_bounded {
     };
 }
 
+pub(super) mod pagetable;
 pub(crate) mod pramin;
 pub(super) mod tlb;
 
diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-core/mm/pagetable.rs
new file mode 100644
index 000000000000..637ff43ea83a
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/pagetable.rs
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Common page table types shared between MMU v2 and v3.
+//!
+//! This module provides foundational types used by both MMU versions:
+//! - Page table level hierarchy
+//! - Memory aperture types for PDEs and PTEs
+
+#![expect(dead_code)]
+
+use kernel::num::Bounded;
+
+use crate::gpu::Architecture;
+
+/// Extracts the page table index at a given level from a virtual address.
+pub(super) trait VaLevelIndex {
+    /// Return the page table index at `level` for this virtual address.
+    fn level_index(&self, level: u64) -> u64;
+}
+
+/// MMU version enumeration.
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+pub(crate) enum MmuVersion {
+    /// MMU v2 for Turing/Ampere/Ada.
+    V2,
+    /// MMU v3 for Hopper and later.
+    V3,
+}
+
+impl From<Architecture> for MmuVersion {
+    fn from(arch: Architecture) -> Self {
+        match arch {
+            Architecture::Turing | Architecture::Ampere | Architecture::Ada => Self::V2,
+            // In the future, uncomment the following to support V3.
+            // _ => Self::V3,
+        }
+    }
+}
+
+/// Page Table Level hierarchy for MMU v2/v3.
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+pub(super) enum PageTableLevel {
+    /// Level 0 - Page Directory Base (root).
+    Pdb,
+    /// Level 1 - Intermediate page directory.
+    L1,
+    /// Level 2 - Intermediate page directory.
+    L2,
+    /// Level 3 - Intermediate page directory or dual PDE (version-dependent).
+    L3,
+    /// Level 4 - PTE level for v2, intermediate page directory for v3.
+    L4,
+    /// Level 5 - PTE level used for MMU v3 only.
+    L5,
+}
+
+impl PageTableLevel {
+    /// Number of entries per page table (512 for 4KB pages).
+    pub(super) const ENTRIES_PER_TABLE: usize = 512;
+
+    /// Get the next level in the hierarchy.
+    pub(super) const fn next(&self) -> Option<PageTableLevel> {
+        match self {
+            Self::Pdb => Some(Self::L1),
+            Self::L1 => Some(Self::L2),
+            Self::L2 => Some(Self::L3),
+            Self::L3 => Some(Self::L4),
+            Self::L4 => Some(Self::L5),
+            Self::L5 => None,
+        }
+    }
+
+    /// Convert level to index.
+    pub(super) const fn as_index(&self) -> u64 {
+        match self {
+            Self::Pdb => 0,
+            Self::L1 => 1,
+            Self::L2 => 2,
+            Self::L3 => 3,
+            Self::L4 => 4,
+            Self::L5 => 5,
+        }
+    }
+}
+
+/// Memory aperture for Page Table Entries (`PTE`s).
+///
+/// Determines which memory region the `PTE` points to.
+#[repr(u8)]
+#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
+pub(super) enum AperturePte {
+    /// Local video memory (VRAM).
+    #[default]
+    VideoMemory = 0,
+    /// Peer GPU's video memory.
+    PeerMemory = 1,
+    /// System memory with cache coherence.
+    SystemCoherent = 2,
+    /// System memory without cache coherence.
+    SystemNonCoherent = 3,
+}
+
+// TODO[FPRI]: Replace with `#[derive(FromPrimitive)]` when available.
+impl From<Bounded<u64, 2>> for AperturePte {
+    fn from(val: Bounded<u64, 2>) -> Self {
+        match *val {
+            0 => Self::VideoMemory,
+            1 => Self::PeerMemory,
+            2 => Self::SystemCoherent,
+            3 => Self::SystemNonCoherent,
+            _ => Self::VideoMemory,
+        }
+    }
+}
+
+// TODO[FPRI]: Replace with `#[derive(ToPrimitive)]` when available.
+impl From<AperturePte> for Bounded<u64, 2> {
+    fn from(val: AperturePte) -> Self {
+        Bounded::from_expr(val as u64 & 0x3)
+    }
+}
+
+/// Memory aperture for Page Directory Entries (`PDE`s).
+///
+/// Note: For `PDE`s, `Invalid` (0) means the entry is not valid.
+#[repr(u8)]
+#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
+pub(super) enum AperturePde {
+    /// Invalid/unused entry.
+    #[default]
+    Invalid = 0,
+    /// Page table is in video memory.
+    VideoMemory = 1,
+    /// Page table is in system memory with coherence.
+    SystemCoherent = 2,
+    /// Page table is in system memory without coherence.
+    SystemNonCoherent = 3,
+}
+
+// TODO[FPRI]: Replace with `#[derive(FromPrimitive)]` when available.
+impl From<Bounded<u64, 2>> for AperturePde {
+    fn from(val: Bounded<u64, 2>) -> Self {
+        match *val {
+            1 => Self::VideoMemory,
+            2 => Self::SystemCoherent,
+            3 => Self::SystemNonCoherent,
+            _ => Self::Invalid,
+        }
+    }
+}
+
+// TODO[FPRI]: Replace with `#[derive(ToPrimitive)]` when available.
+impl From<AperturePde> for Bounded<u64, 2> {
+    fn from(val: AperturePde) -> Self {
+        Bounded::from_expr(val as u64 & 0x3)
+    }
+}
-- 
2.34.1

