Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D5ACD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:11:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F6F710E98C;
	Mon, 18 May 2026 18:11:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ltFdllji";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010004.outbound.protection.outlook.com [52.101.61.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7477510E985
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:11:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8HvswNzoxR206HgOMKyASMoKgddMi1xxNm0R4GyDtzQQwE2Tbf0DIhEU9xONeu/FY1zsEJsV4JqMySIOMSdUeqFXpU78TcEwkU8OVpB8qX9VSRf45WADJJ+nxDAR6STbfn7X7TDNb64TQ2MvRISJf8n2uftR2Q9Qqe3X3ojK3apL+4QEqF1i5r9tIKJsgeDcbciZrqZusYNslyZQWqALzgJIOyYfpwo3Pi02wotvdsyiEjnWlSnp3tw4XdevJ5Zka1rgtJaslW170iLIJuAqBI3iemW54BjhzJWPgmrKWLEVyyyObSR/X/DCgXpWdoW098D/fAWQbrk1vZPZczM5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mwa2rNJL29lXh1BHhAvVWteeSw6ld3bSP6D+rejburc=;
 b=Hmb3jpuP8IHTBlyztY+54lEXRimu5Bn7GbpNORWyWxOfwhKwtrzQGfseZNIq1zwTGhta1kef6knJhPojuQIaZrqoOZpMRN/634z+WpujQh2gLGgA1EW7wdnQD6ZKhFZ75Lzb1AmtgAaMlEf7Jmkk+ZK8+XCteYIx0auh4Mb3BTB7U423F9c/ywOnc4r1zzrdMmBJE5GpIo2xo2d0Ayg9J/8faeL/vclC2bPvDQa86IDpcrPr+8YSzn/dlvA17cfTXDS0+i8FhXEIG4KA4ogKMdC6NRYDPV3SgNx+KSnTt7yyFl3ssQsXdbKHTTmt42+x34WZ7x7y85tjNT88knk5dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mwa2rNJL29lXh1BHhAvVWteeSw6ld3bSP6D+rejburc=;
 b=ltFdlljiwLYmSmdO5JPSYvp5KWsvtj0s96mRpSKZ+wsbT6OusJFqFz/V5N1wECV637yqBkeuhwATs3EvKx9qC6hwVKrnulIJ2P+mdeB9TCVlIA7NrwQboX6ybybF7rafF6+aVNIubitv1SdR5R6NoBVvFnfRU2PXyyznnIm9VXrF77ca+6b4w9DHBLVVS36AyI9JMzLT3MqqINFtPBasmy/+2LeJJx9d51uvtgRLBV1iQfBy9sfM/JD526D6D0VA4fAAtsoA7GP66J7uKyrzJqNtGyQmI0GR6KnUv8fBgbWNMmuAW8NVmnZ5jLoutCgqBRamYtYgPkV7XxZF75T/Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 18:11:35 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0025.012; Mon, 18 May 2026
 18:11:35 +0000
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
Subject: [PATCH v1 03/16] gpu: nova-core: mm: Add common types for all page
 table formats
Date: Mon, 18 May 2026 14:11:12 -0400
Message-Id: <20260518181126.2493572-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518181126.2493572-1-joelagnelf@nvidia.com>
References: <20260518181126.2493572-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::11) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BY5PR12MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: d9fece1d-7aed-4232-e21f-08deb508e5b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: EKI3oyUcJlAuOdsJvYF+xA2pXBUthQBsu0niVgHWpBe58ii+UEAUWCz/mV+nluukDjgH9k1EhTlUvb8qFWtSFY19Qdi+lKNWX+iAL5KjjoCPxGtdb81PY9Hr81IOR/4FcCrrSNm3jSBCDfFKaRNAGEDtKPFsqgwE0riWO32TRsSDa1S7QHacWyZx63n72gOJc0n0CvV4Wk5eTv+ss2gyiThOKdVBSujKFqNgONNYqmzZxbb8dKMWlUDaMcH9MOIOpvJAtnDA3DFlEMBQQt+CPDlnCUYB+PZt6wCjmBC1N/Ads/f/CLDRkQLjxuEGmlSWQt8GMDuslHyML+jHcFAR59sHAjhBDK0pqeYPpqm2Nl0CDhs1wikm7MGm5nCTDG9vhe4VDmsFCJMiIOy/g22eIrkPOKc9i6S5SqbvEXATXG3uhjE6lBFbKWXgyOROJxoCySVq7XNvpr+S15GboOfkDX+h6/mbUcYTN+JokSIGE/5+wAe9HhAsOxC6+sR9/uC7kyNfzIpnBrTGYHDKbi+6kaAkt3mcsjTOJxCOaym76gz9y6fcRizCbCxFZv0nu6AkRUWn4ni4ZZf8LdnHOZP0a0OlN86rWequ1wym9YPSzqlTSFEhHzK4FoXEcmzulX14vMvUl6hZIfREMihvjlFlBIIYsUw9ah+FGHUZvkpz8qgd0dlhoQ61zzn22nxrwiH6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?71qWwbr+G6YCOCKhYyKkKcB8BUlu4xZJip7M3pESh+wFXEXRab/5nRyDfu70?=
 =?us-ascii?Q?DCpCE3un1vUnAuc85/ew0buQ9tBjRwMswWr4waet7ElkxqEsQT36lrHhY15w?=
 =?us-ascii?Q?wQUIFagP66mOdVNHoiZ1kBTA5FETImQLhsYHXE5i6q8szl31p2krtT+frgbk?=
 =?us-ascii?Q?U1st4hZofMTst5Q1HogQO+KT3sMABITAsrI2HRQrpVVQos0hVvi2CcdzefmY?=
 =?us-ascii?Q?vXZtQM0zhfGBJU1k7xKH/vjBUgC0TKoSbtxLZK5hdwry+Bhi+630cbcGNtis?=
 =?us-ascii?Q?2JP8H8UrhIJQTLaQuj/yNVC58S3bPs9z9bcLn57bAhwZdBwH5KvRmBH3TVL9?=
 =?us-ascii?Q?oLyLgenO3IscWERO2YG9hZK5u9M6m7BNsDZEkyLBGuUr42IT+YJB7so+q76H?=
 =?us-ascii?Q?DDEDNE4SNwQAaCibZZRnKn53Hv1tNaoYbTRfjs2RSTskawnJ6o+IESWPdh2W?=
 =?us-ascii?Q?CrMCE2jPKWE1KEsK1lhd0rcv9WUsn77dWB37rdj95TrMC6LrJXfQY9nne3uT?=
 =?us-ascii?Q?qHD5NHRFxrXsuKmu9KTIIhjXlBoIRqAuHQ1HrZkBDTq77Vr+PJg1cArmk3Qz?=
 =?us-ascii?Q?c3rsqKN0dsUM06cWss0KBJ57h05n7+rkmJvmj6kLsK6triGH2zvL6s/txmY7?=
 =?us-ascii?Q?OioSq+TP7Gq10AYR24qNRaIUhQRMv6CTS5tBEDgRz9bIt7ElyFfr7qEsx4t/?=
 =?us-ascii?Q?7Pc60XiPZB88ilSTz30BHWfAcDpXRbQAXkSogWD3pUc7AGOyzLcQ4xC8wkpM?=
 =?us-ascii?Q?UgWc3LUSbaFK2CtRqEjNNB+G0Ix18uCweYCxjhVVPMm5REp2loZTb7i7Orfm?=
 =?us-ascii?Q?44bcgDdJzgh5kEqQSZQ4r3UKLh+pT0TWRzCXWhYHdE8DNQuTCjnNWZy1y6x/?=
 =?us-ascii?Q?Hs2u1LuZPAXger5nFZFqq2XIOg6SDABozDLsPEgu09GjzgUDfa2t3kTOWZop?=
 =?us-ascii?Q?WKS5okz5eNqzUbQNMsHBXEVVMSydIP2Wm+HgJRKMtShLp0KvfTg9eOeidcIY?=
 =?us-ascii?Q?uNIiiANw9mLSdVl1IFIB7kkqH+GNk9dtyp/5xz/tQifCMWkBY8UOA8krd97s?=
 =?us-ascii?Q?Vz1P6y6KZmv7awhJZtiKRIgs5Zq9AWK1F2elk791A/PqiLaXuxsXk9k0ERsJ?=
 =?us-ascii?Q?UFYLzsdShHqYFAgmvKlImaSQ3ZEBzsmo3Nwf/D6rDyprIkQftK38utm7IWRw?=
 =?us-ascii?Q?eWxHngUJjk9EUgxvJvigSv95rJdcmPFt91tLq3gtdCWSP89MBu/hM7XgWvSL?=
 =?us-ascii?Q?SgEgZGEQlhho1Ui/s7qApkDt/IdJ3p99a3jCOCvDco/9H+AcF8AIXm2+kWoA?=
 =?us-ascii?Q?0+aE1BRuYRljd7waf5hNbWyB/x1sVVpK7KlnTyrCqVR8/F2hSg/mpdMw8Aeb?=
 =?us-ascii?Q?R6JyhkIKnWn338aFghCw3+4bxC9dZN9GLewVs1uXZcPUXSHQCQqCKePCJPFC?=
 =?us-ascii?Q?B0rm0jr0zyLJkUdYF3F2Lt9GNHsLb2XreKljnBiGHLe+csdth3xlCoth3kzt?=
 =?us-ascii?Q?w5rQDlAt1mM0FgKcrj7jhPN29tdh53SQZjloDpOJI1PO4MaqILnNPzBj6fvp?=
 =?us-ascii?Q?YHT3Ib5fZ/MitBcf6nCiNXUKOFWbOcoJPSLsDdll6bBaSGIxtye1YrQmiNU7?=
 =?us-ascii?Q?GZguNvgvFSp8mMpAH/Sj/7YrW7ZH0dIsqXJth9QR27eQLjS8+uU/xJKDxPAn?=
 =?us-ascii?Q?Pz3+uVUx47BNbhWX8Q+5a+H60jjD+HthPDIl51vAkn8vFEdfmV/lk/CoYpW6?=
 =?us-ascii?Q?+xiZrBDbiQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fece1d-7aed-4232-e21f-08deb508e5b8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:11:35.2902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6I9wesY9jxqGUymVkgdR1efGKhgiQNvpXM9l4rk4IKpQSeFp/SZnJAZC2Pw2QbAdJe3Ot3on+oVmDoff8oyN1A==
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

Add common page table types shared between MMU v2 and v3. These types
are hardware-agnostic and used by both MMU versions.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs           |   1 +
 drivers/gpu/nova-core/mm/pagetable.rs | 158 ++++++++++++++++++++++++++
 2 files changed, 159 insertions(+)
 create mode 100644 drivers/gpu/nova-core/mm/pagetable.rs

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index ea415a88b221..66cc33389159 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -31,6 +31,7 @@ macro_rules! impl_pfn_bounded {
     };
 }
 
+pub(super) mod pagetable;
 pub(crate) mod pramin;
 pub(super) mod tlb;
 
diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-core/mm/pagetable.rs
new file mode 100644
index 000000000000..ed0f3d731c63
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/pagetable.rs
@@ -0,0 +1,158 @@
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
+            Architecture::Hopper | Architecture::BlackwellGB10x | Architecture::BlackwellGB20x => {
+                Self::V3
+            }
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

