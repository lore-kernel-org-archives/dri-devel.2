Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD18DFF885A
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 21:15:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71BED10E494;
	Sat, 25 Apr 2026 21:15:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="L8jRe/JK";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B801110E490
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:15:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8cl9eobGK5kBKY0dkIaRB11oVAxt+5E9q4a3L2v5tAafFYgfChxikKecvsXL0RCrX43AdewKog+L95yhdIYAQq1vSX0awhmAqHHBwHuRdDs7A6iBdQGQiMKtWOJW/K3adg0Rf0Tz7trBloz8OSAd2G7wWXpCCY0o5Ryr4rcTDVK/cQbz560gXGNDwu7i9nYFaX+uf7lBC3ssAWFuhgNr6zCpqD4yR3ApkQMeppYzQL0qFFTLkKyjh9p2gqO8kidNpVEVTBsQPNbeHwrUNxxwGbflv5AnFvUkw36+e0Xd9XLMNLjSg0AxqB+ZkGu/GCmoQ039LBw5nyBJZbZPus2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHiqYyukB7IYwju0UCr7wJE23bdFctu9mFUsJdbnSn0=;
 b=kwoVtwnNxn7ZHlDI50nwWU90yEssk53zyiCM7mrlNlf9N/K5KvqHdluBmLWaL5eLuIA92WvPtoxedLAuyfCeOM9knsnNWezYHpY9vw2faZmfWx8UJPDzNsU01CzG19sUAO9P4EzOX2ffzm+UHwLhDPXZVCKjMMvu6MbdoaC2w2zu5bB76nsTQZGydyIBf9NsqsA+ubBRdB96RIMdgasTRjidFj5vQvIIH7tb9GKCV9eqio48yB6zKxX4JQWr2RMseHUKi2XzDVw10KdmpXW+c4b6IF/CXRCKjAlwNS4+QvSrhVHJGv/Y6a61SmnSE9j45QYBgX+Uz9DS39M6/hEQAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHiqYyukB7IYwju0UCr7wJE23bdFctu9mFUsJdbnSn0=;
 b=L8jRe/JKZv1jUE1u/WDsXj5bwtSdGSnFBvdx+p7pwGCMauGJNp38nK69bECfbTxaFGOWYnucUGrCYjYUnuL30S1VF+6ufjk4ee322FZuuYyTdRLCAq7G861Fnx70ng1Q3/CUaXjjE5ArtKgwLIvENPqYwcanlU//ou2UEoiWqgVt/yL2ymLYFr9I5sRrozLRpIX6FFc241MbTp3QYKkAa9s5fh5nsekVfv5a8xRHivXv5DS/EvbNGqKcuvZUHIUNPKXcQwfhQ2XLL6a3/hjSyA1mTFaZjx8ouevL/niKgp39l9Km7imgp9leUVDMJzm74KFb0kapzcGrFzU+ig2jSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Sat, 25 Apr
 2026 21:15:34 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 21:15:34 +0000
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
Subject: [PATCH v12 12/22] gpu: nova-core: mm: Add page table entry operation
 traits
Date: Sat, 25 Apr 2026 17:14:44 -0400
Message-Id: <20260425211454.174696-13-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425211454.174696-1-joelagnelf@nvidia.com>
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0061.namprd15.prod.outlook.com
 (2603:10b6:208:237::30) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: 8787abb6-929f-4d2d-acbe-08dea30fc9db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mQtu4ZZ9z+xLLm33h4xZdsBOLy70JRbEdIFXF+lfxtTRyF4/1lH91SF2PK1IUJNhesBjTxVKiNwdTfSGRK1pDxlXDs6nv4A6DCYiLcucnbWeZ8IsTAi5qmpJPJtj7mT38Lhe3psIMPdokSru5D1o8Do8gbK5+ui8RLtRwkt4KeyLgUdPacGd6XDh3VRJrffkYzff0fgGeC/A0NIJAO1x5274fE56OZNt549YhsRss7RjdDi/dNMHRo2LovD90TMviFU42TcsvNJKHYJI2amWcOhz977PWLVLmPhTc0/jVXqRPW8QQzwjIcGxbS9uGyTYxc0m0hSXJmZchcXcwQQAvl+vXOgiQhK4uYRBjmEMPPef80FJcUzHRH8WLBesfFONBu9Sfy6Y+Xe4VrOb0sAKifbFdgAyddpHs/gU0roz8yphAHy5NNFGEkS9ygAmOxFLwzyyU8NDJ03/smniyvVKMNTX+vqfm2ttYWZyHaVllZ30OrTNTVSx6o57pQgSBH+/flDdCmKFNM8vPHCYjqJhyxke50sRnJ+LkuBN+AWnisD2HL8HQFwVhYRSjPWu1x3cWIzcLjH0HYy/lIa2SAk33szX3dkMUyFwz3fb14GAOMGW1+TyBi88cmwVWpbjkIuQXfCyb95+n2UGFedyiGgqPV8Yops1+o/s5KWWX0zuTf7u8ICxoMR1WSAd/tGPv+JGm2WcLph1oPQ5I3r7Tr4kWgqD+mAboNOvm6vinPCHnhA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?59JWagG/iCXC0sZ0wtpVfDKVnejNTPnEOwQmSx7IykN7E/29z6W3BxHyAXeP?=
 =?us-ascii?Q?GXEhNTUUgho4sZVa+9acQYJELtyC+8O6cnOmVSqlJy9rlnAbDX5R0DMcXMbT?=
 =?us-ascii?Q?UcwUbKb+JMjZm/xSeGQ00bAExN5FmVj0267Y8saEzctNAzYhQfSuG778ZgbG?=
 =?us-ascii?Q?YvWrvfe0jmgFmvHAFBukJ7yrd6ZsX+/7mAg/DUZ/pyvW1+gOC0v/g6DRGC2A?=
 =?us-ascii?Q?I8wGgpOsM7xfG6v3lNy7Mn9zSn+SEH0Riwimyn7JV1SlDcJSssZoz47ofrU+?=
 =?us-ascii?Q?tg4hUi8UDp47hMECCDbUIbPpGhjZjEaUqqj4QYCydO9kUSXb3VzG+iPO1KBX?=
 =?us-ascii?Q?fIkhG8puSF6Hkmi9diuRwuREBnD/lKpAC8gPYE1J7NcXYZy3yD5Ltchz8/vL?=
 =?us-ascii?Q?wVPcDl758kPI9hqR7hgleUfyBh9n8yL2IdYX2uLuUX7SxDbgqe0YO/QOX6uF?=
 =?us-ascii?Q?jt6RKt9xLuA1X7TQ2g8a508hbYhzL0tqWlGra8xYfjufQSyywgxRxuFToekA?=
 =?us-ascii?Q?XAnB75fJ24GZ1vz9Og39Vu9PXQZB9RJFWDOFZrRk2CUhanq0+lUriddbeY9G?=
 =?us-ascii?Q?rbEgEnV9PtcckuzBBrc+LZJ/aSJoGJD2Jo5j6fjvhZ3YCiowuw89XiK2IZjQ?=
 =?us-ascii?Q?cx4Kxs6t7xj6QKIfxV/fyivKdThLafM3W7PoArzGu6djCcLn/++q7IQJ+WaQ?=
 =?us-ascii?Q?+pIPmNo7hX8pryEc4NqmEYLLZoInD3Hbh6GJrQpMJC96TDKV20/vTBPKTK7D?=
 =?us-ascii?Q?0ZeF+lU23DZ7g+ppAepb1yCzhKBrJz9Vim43fC5qI1uKJwnIxoQ6wgsyJP76?=
 =?us-ascii?Q?YUx2FzLKX2G06ZACHuw8qLGcCyWCIDOmcIcuiTZcnVf/VivfNB13euVLex/V?=
 =?us-ascii?Q?07qOJYr0gGunH4i0rOtcCNaLr0C46gvkwzNqiA4W1f57hSx3Xe4PZ76vksrQ?=
 =?us-ascii?Q?L4SE89ALQ+vOjHBIXMO0kkPkKEdgTiZl8SQ7poq5AxVuKfWDxi5ApILlDL8l?=
 =?us-ascii?Q?IEUeZiuWnXS5VEfQJkx5tfj+rjxipqN1BL/sDxcqKmAz+2Jk5qHheCNHCFVN?=
 =?us-ascii?Q?10g7IovPRoMIqJhMIN+VMMsWbBihUd3s0UQFznUmxsGEt0z2fXrUE3qcgVcj?=
 =?us-ascii?Q?jN0+uf5LXHYKBjhS89B67RrUrNMpd73nsVDkc3q9yFoZsxZbyq66Qhy8wuNM?=
 =?us-ascii?Q?9mDrGAqXUypJ4kVMaVmHI+yxjbMLv4DVn+/QipWdFBc6DrVhWEGx1yB3k+ve?=
 =?us-ascii?Q?Dfq2cTa8KlUVNTcLkpgUi2j9ZNWAjSKgMsyqg7hcCazeJ/ehTwig3lm80FRe?=
 =?us-ascii?Q?Sh3PHFxtfW9ZBV1eDYG0raaeWYS+GztBG545Z/tEASfAaGsmBaquV8Wp1dDn?=
 =?us-ascii?Q?Jz2EXN8Cg1UuJE6SiwZPyLNC5AvqqvErGJKxpO2vZP9m96nlz+aDDQDSEwaR?=
 =?us-ascii?Q?yeBE+74zXTY1C1wgCja0v5PNsqNse7Mo0e+/JjfSbkSxrtOjtPoHpvRliUUQ?=
 =?us-ascii?Q?OUcNbU/iDaBVt4LXZmjC7atU3WHTGnbF9uCmFSSZuLONe3WkIox9ehAuS6Yt?=
 =?us-ascii?Q?5V25HXenGTrCuUahKoCPS2J46qQPN+75S6CZvc1DrOglLCwd+6D2LCaQFKbv?=
 =?us-ascii?Q?z8KQhvLY21wrAPv6hY/psfHrvVeCeT9cxHRFA0iuH6SwP+DsbBh7jSRoUJqH?=
 =?us-ascii?Q?8rLtcdsbtZpa0V9W46hNY4hU7NfkG2xwHbaXlqjMy8pfMqUXq7v6jeacXuyM?=
 =?us-ascii?Q?/surikJVPA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8787abb6-929f-4d2d-acbe-08dea30fc9db
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:15:34.2138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2MZ5tpIS5EE31hArcq7wBpT9dfwj2Mx088MS+61PP7ZYOv56lgXMK5ZcO8PHdfwBv56G90MwaLNzR6iBlYcxw==
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

Introduce trait-based abstractions for GPU page table entries: PteOps,
PdeOps, and DualPdeOps, along with the MmuConfig trait that ties them
together with version-specific constants.

Refactor the ver2 and ver3 page-table modules to implement these traits
and expose the shared entry/PDE/PTE operations uniformly.

Dispatch happens at compile time through the MmuV2 and MmuV3 marker
structs, so version-specific code is selected without runtime overhead
and without wrapper enums.

This enables version-agnostic page table operations while keeping
version-specific implementation details encapsulated in the ver2 and
ver3 modules.

Cc: Nikola Djukic <ndjukic@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/mm/pagetable.rs      | 223 +++++++++++++++++++++
 drivers/gpu/nova-core/mm/pagetable/ver2.rs | 150 ++++++++------
 drivers/gpu/nova-core/mm/pagetable/ver3.rs | 120 +++++++----
 3 files changed, 396 insertions(+), 97 deletions(-)

diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-core/mm/pagetable.rs
index 9897818b3b07..764b9e71ae41 100644
--- a/drivers/gpu/nova-core/mm/pagetable.rs
+++ b/drivers/gpu/nova-core/mm/pagetable.rs
@@ -14,6 +14,13 @@
 use kernel::num::Bounded;
 
 use crate::gpu::Architecture;
+use crate::mm::{
+    pramin,
+    Pfn,
+    VirtualAddress,
+    VramAddress, //
+};
+use kernel::prelude::*;
 
 /// Extracts the page table index at a given level from a virtual address.
 pub(super) trait VaLevelIndex {
@@ -86,6 +93,222 @@ pub(super) const fn as_index(&self) -> u64 {
     }
 }
 
+// Trait abstractions for page table operations.
+
+/// Operations on Page Table Entries (`PTE`s).
+pub(super) trait PteOps: Copy + core::fmt::Debug {
+    /// Create a `PTE` from a raw `u64` value.
+    fn new(val: u64) -> Self;
+
+    /// Create an invalid `PTE`.
+    fn invalid() -> Self;
+
+    /// Create a valid `PTE` for video memory.
+    fn new_vram(pfn: Pfn, writable: bool) -> Self;
+
+    /// Check if this `PTE` is valid.
+    fn is_valid(&self) -> bool;
+
+    /// Get the physical frame number.
+    fn frame_number(&self) -> Pfn;
+
+    /// Get the raw `u64` value.
+    fn raw_u64(&self) -> u64;
+
+    /// Read a `PTE` from VRAM.
+    fn read(window: &mut pramin::PraminWindow<'_>, addr: VramAddress) -> Result<Self> {
+        let val = window.try_read64(addr.raw())?;
+        Ok(Self::new(val))
+    }
+
+    /// Write this `PTE` to VRAM.
+    fn write(&self, window: &mut pramin::PraminWindow<'_>, addr: VramAddress) -> Result {
+        window.try_write64(addr.raw(), self.raw_u64())
+    }
+}
+
+/// Operations on Page Directory Entries (`PDE`s).
+pub(super) trait PdeOps: Copy + core::fmt::Debug {
+    /// Create a `PDE` from a raw `u64` value.
+    fn new(val: u64) -> Self;
+
+    /// Create a valid `PDE` pointing to a page table in video memory.
+    fn new_vram(table_pfn: Pfn) -> Self;
+
+    /// Create an invalid `PDE`.
+    fn invalid() -> Self;
+
+    /// Check if this `PDE` is valid.
+    fn is_valid(&self) -> bool;
+
+    /// Get the memory aperture of this `PDE`.
+    fn aperture(&self) -> AperturePde;
+
+    /// Get the VRAM address of the page table.
+    fn table_vram_address(&self) -> VramAddress;
+
+    /// Get the raw `u64` value.
+    fn raw_u64(&self) -> u64;
+
+    /// Read a `PDE` from VRAM.
+    fn read(window: &mut pramin::PraminWindow<'_>, addr: VramAddress) -> Result<Self> {
+        let val = window.try_read64(addr.raw())?;
+        Ok(Self::new(val))
+    }
+
+    /// Write this `PDE` to VRAM.
+    fn write(&self, window: &mut pramin::PraminWindow<'_>, addr: VramAddress) -> Result {
+        window.try_write64(addr.raw(), self.raw_u64())
+    }
+
+    /// Check if this `PDE` is valid and points to video memory.
+    fn is_valid_vram(&self) -> bool {
+        self.is_valid() && self.aperture() == AperturePde::VideoMemory
+    }
+}
+
+/// Operations on Dual Page Directory Entries (128-bit `DualPde`s).
+pub(super) trait DualPdeOps: Copy + core::fmt::Debug {
+    /// Create a `DualPde` from raw 128-bit value (two `u64`s).
+    fn new(big: u64, small: u64) -> Self;
+
+    /// Create a `DualPde` with only the small page table pointer set.
+    fn new_small(table_pfn: Pfn) -> Self;
+
+    /// Check if the small page table pointer is valid.
+    fn has_small(&self) -> bool;
+
+    /// Get the small page table VRAM address.
+    fn small_vram_address(&self) -> VramAddress;
+
+    /// Get the raw `u64` value of the big PDE.
+    fn big_raw_u64(&self) -> u64;
+
+    /// Get the raw `u64` value of the small PDE.
+    fn small_raw_u64(&self) -> u64;
+
+    /// Read a dual PDE (128-bit) from VRAM.
+    fn read(window: &mut pramin::PraminWindow<'_>, addr: VramAddress) -> Result<Self> {
+        let lo = window.try_read64(addr.raw())?;
+        let hi = window.try_read64(addr.raw() + 8)?;
+        Ok(Self::new(lo, hi))
+    }
+
+    /// Write this dual PDE (128-bit) to VRAM.
+    fn write(&self, window: &mut pramin::PraminWindow<'_>, addr: VramAddress) -> Result {
+        window.try_write64(addr.raw(), self.big_raw_u64())?;
+        window.try_write64(addr.raw() + 8, self.small_raw_u64())
+    }
+}
+
+/// MMU configuration trait -- encodes version-specific constants and types.
+pub(super) trait MmuConfig: 'static {
+    /// Page Table Entry type.
+    type Pte: PteOps;
+    /// Page Directory Entry type.
+    type Pde: PdeOps;
+    /// Dual Page Directory Entry type (128-bit).
+    type DualPde: DualPdeOps;
+
+    /// PDE levels (excluding PTE level) for page table walking.
+    const PDE_LEVELS: &'static [PageTableLevel];
+    /// PTE level for this MMU version.
+    const PTE_LEVEL: PageTableLevel;
+    /// Dual PDE level (128-bit entries) for this MMU version.
+    const DUAL_PDE_LEVEL: PageTableLevel;
+
+    /// Get the number of entries per page table page for a given level.
+    fn entries_per_page(level: PageTableLevel) -> usize;
+
+    /// Extract the page table index at `level` from `va`.
+    fn level_index(va: VirtualAddress, level: u64) -> u64;
+
+    /// Get the entry size in bytes for a given level.
+    fn entry_size(level: PageTableLevel) -> usize {
+        if level == Self::DUAL_PDE_LEVEL {
+            16 // 128-bit dual PDE
+        } else {
+            8 // 64-bit PDE/PTE
+        }
+    }
+
+    /// Compute upper bound on page table pages needed for `num_virt_pages`.
+    ///
+    /// Walks from PTE level up through PDE levels, accumulating the tree.
+    fn pt_pages_upper_bound(num_virt_pages: usize) -> usize {
+        let mut total = 0;
+
+        // PTE pages at the leaf level.
+        let pte_epp = Self::entries_per_page(Self::PTE_LEVEL);
+        let mut pages_at_level = num_virt_pages.div_ceil(pte_epp);
+        total += pages_at_level;
+
+        // Walk PDE levels bottom-up (reverse of PDE_LEVELS).
+        for &level in Self::PDE_LEVELS.iter().rev() {
+            let epp = Self::entries_per_page(level);
+
+            // How many pages at this level do we need to point to
+            // the previous pages_at_level?
+            pages_at_level = pages_at_level.div_ceil(epp);
+            total += pages_at_level;
+        }
+
+        total
+    }
+}
+
+/// Marker struct for MMU v2 (Turing/Ampere/Ada).
+pub(super) struct MmuV2;
+
+impl MmuConfig for MmuV2 {
+    type Pte = ver2::Pte;
+    type Pde = ver2::Pde;
+    type DualPde = ver2::DualPde;
+
+    const PDE_LEVELS: &'static [PageTableLevel] = ver2::PDE_LEVELS;
+    const PTE_LEVEL: PageTableLevel = ver2::PTE_LEVEL;
+    const DUAL_PDE_LEVEL: PageTableLevel = ver2::DUAL_PDE_LEVEL;
+
+    fn entries_per_page(level: PageTableLevel) -> usize {
+        // TODO: Calculate these values from the bitfield dynamically
+        // instead of hardcoding them.
+        match level {
+            PageTableLevel::Pdb => 4,  // PD3 root: bits [48:47] = 2 bits
+            PageTableLevel::L3 => 256, // PD0 dual: bits [28:21] = 8 bits
+            _ => 512,                  // PD2, PD1, PT: 9 bits each
+        }
+    }
+
+    fn level_index(va: VirtualAddress, level: u64) -> u64 {
+        ver2::VirtualAddressV2::new(va).level_index(level)
+    }
+}
+
+/// Marker struct for MMU v3 (Hopper and later).
+pub(super) struct MmuV3;
+
+impl MmuConfig for MmuV3 {
+    type Pte = ver3::Pte;
+    type Pde = ver3::Pde;
+    type DualPde = ver3::DualPde;
+
+    const PDE_LEVELS: &'static [PageTableLevel] = ver3::PDE_LEVELS;
+    const PTE_LEVEL: PageTableLevel = ver3::PTE_LEVEL;
+    const DUAL_PDE_LEVEL: PageTableLevel = ver3::DUAL_PDE_LEVEL;
+
+    fn entries_per_page(level: PageTableLevel) -> usize {
+        match level {
+            PageTableLevel::Pdb => 2,  // PDE4 root: bit [56] = 1 bit, 2 entries
+            PageTableLevel::L4 => 256, // PDE0 dual: bits [28:21] = 8 bits
+            _ => 512,                  // PDE3, PDE2, PDE1, PT: 9 bits each
+        }
+    }
+
+    fn level_index(va: VirtualAddress, level: u64) -> u64 {
+        ver3::VirtualAddressV3::new(va).level_index(level)
+    }
+}
+
 /// Memory aperture for Page Table Entries (`PTE`s).
 ///
 /// Determines which memory region the `PTE` points to.
diff --git a/drivers/gpu/nova-core/mm/pagetable/ver2.rs b/drivers/gpu/nova-core/mm/pagetable/ver2.rs
index 419ca0e11cd6..66fd8c763146 100644
--- a/drivers/gpu/nova-core/mm/pagetable/ver2.rs
+++ b/drivers/gpu/nova-core/mm/pagetable/ver2.rs
@@ -16,7 +16,10 @@
 use super::{
     AperturePde,
     AperturePte,
+    DualPdeOps,
     PageTableLevel,
+    PdeOps,
+    PteOps,
     VaLevelIndex, //
 };
 use crate::mm::{
@@ -116,12 +119,12 @@ pub(in crate::mm) struct Pte(u64) {
 
 impl Pte {
     /// Create a `PTE` from a `u64` value.
-    pub(super) fn new(val: u64) -> Self {
+    pub(super) fn new_raw(val: u64) -> Self {
         Self::from_raw(val)
     }
 
     /// Create a valid `PTE` for video memory.
-    pub(super) fn new_vram(pfn: Pfn, writable: bool) -> Self {
+    fn new_vram_inner(pfn: Pfn, writable: bool) -> Self {
         Self::zeroed()
             .with_valid(true)
             .with_aperture(AperturePte::VideoMemory)
@@ -129,21 +132,37 @@ pub(super) fn new_vram(pfn: Pfn, writable: bool) -> Self {
             .with_read_only(!writable)
     }
 
-    /// Create an invalid `PTE`.
-    pub(super) fn invalid() -> Self {
-        Self::zeroed()
-    }
-
     /// Get the frame number based on aperture type.
-    pub(super) fn frame_number(&self) -> Pfn {
+    fn frame_number_by_aperture(&self) -> Pfn {
         match self.aperture() {
             AperturePte::VideoMemory => self.frame_number_vid(),
             _ => self.frame_number_sys(),
         }
     }
+}
 
-    /// Get the raw `u64` value.
-    pub(super) fn raw_u64(&self) -> u64 {
+impl PteOps for Pte {
+    fn new(val: u64) -> Self {
+        Self::from_raw(val)
+    }
+
+    fn invalid() -> Self {
+        Self::zeroed()
+    }
+
+    fn new_vram(pfn: Pfn, writable: bool) -> Self {
+        Self::new_vram_inner(pfn, writable)
+    }
+
+    fn is_valid(&self) -> bool {
+        self.valid().into_bool()
+    }
+
+    fn frame_number(&self) -> Pfn {
+        self.frame_number_by_aperture()
+    }
+
+    fn raw_u64(&self) -> u64 {
         self.into_raw()
     }
 }
@@ -171,30 +190,18 @@ pub(in crate::mm) struct Pde(u64) {
 
 impl Pde {
     /// Create a `PDE` from a `u64` value.
-    pub(super) fn new(val: u64) -> Self {
+    pub(super) fn new_raw(val: u64) -> Self {
         Self::from_raw(val)
     }
 
     /// Create a valid `PDE` pointing to a page table in video memory.
-    pub(super) fn new_vram(table_pfn: Pfn) -> Self {
+    fn new_vram_inner(table_pfn: Pfn) -> Self {
         Self::zeroed()
             .with_valid_inverted(false) // 0 = valid
             .with_aperture(AperturePde::VideoMemory)
             .with_table_frame_vid(table_pfn)
     }
 
-    /// Create an invalid `PDE`.
-    pub(super) fn invalid() -> Self {
-        Self::zeroed()
-            .with_valid_inverted(true)
-            .with_aperture(AperturePde::Invalid)
-    }
-
-    /// Check if this `PDE` is valid.
-    pub(super) fn is_valid(&self) -> bool {
-        !self.valid_inverted().into_bool() && self.aperture() != AperturePde::Invalid
-    }
-
     /// Get the table frame number based on aperture type.
     fn table_frame(&self) -> Pfn {
         match self.aperture() {
@@ -202,19 +209,42 @@ fn table_frame(&self) -> Pfn {
             _ => self.table_frame_sys(),
         }
     }
+}
 
-    /// Get the `VRAM` address of the page table.
-    pub(super) fn table_vram_address(&self) -> VramAddress {
+impl PdeOps for Pde {
+    fn new(val: u64) -> Self {
+        Self::from_raw(val)
+    }
+
+    fn new_vram(table_pfn: Pfn) -> Self {
+        Self::new_vram_inner(table_pfn)
+    }
+
+    fn invalid() -> Self {
+        Self::zeroed()
+            .with_valid_inverted(true)
+            .with_aperture(AperturePde::Invalid)
+    }
+
+    fn is_valid(&self) -> bool {
+        !self.valid_inverted().into_bool() && self.aperture() != AperturePde::Invalid
+    }
+
+    fn aperture(&self) -> AperturePde {
+        // Delegate to bitfield getter (takes self by value, Copy).
+        Pde::aperture(*self)
+    }
+
+    fn table_vram_address(&self) -> VramAddress {
         debug_assert!(
-            self.aperture() == AperturePde::VideoMemory,
+            Pde::aperture(*self) == AperturePde::VideoMemory,
             "table_vram_address called on non-VRAM PDE (aperture: {:?})",
-            self.aperture()
+            Pde::aperture(*self)
         );
         VramAddress::from(self.table_frame_vid())
     }
 
-    /// Get the raw `u64` value of the `PDE`.
-    pub(super) fn raw_u64(&self) -> u64 {
+    fn raw_u64(&self) -> u64 {
         self.into_raw()
     }
 }
@@ -232,35 +262,9 @@ pub(in crate::mm) struct DualPde {
 }
 
 impl DualPde {
-    /// Create a dual `PDE` from raw 128-bit value (two `u64`s).
-    pub(super) fn new(big: u64, small: u64) -> Self {
-        Self {
-            big: Pde::new(big),
-            small: Pde::new(small),
-        }
-    }
-
-    /// Create a dual `PDE` with only the small page table pointer set.
-    ///
-    /// Note: The big (LPT) portion is set to 0, not `Pde::invalid()`.
-    /// According to hardware documentation, clearing bit 0 of the 128-bit
-    /// entry makes the PDE behave as a "normal" PDE. Using `Pde::invalid()`
-    /// would set bit 0 (valid_inverted), which breaks page table walking.
-    pub(super) fn new_small(table_pfn: Pfn) -> Self {
-        Self {
-            big: Pde::new(0),
-            small: Pde::new_vram(table_pfn),
-        }
-    }
-
-    /// Check if the small page table pointer is valid.
-    pub(super) fn has_small(&self) -> bool {
-        self.small.is_valid()
-    }
-
     /// Check if the big page table pointer is valid.
     fn has_big(&self) -> bool {
-        self.big.is_valid()
+        PdeOps::is_valid(&self.big)
     }
 
     /// Get the small page table `Pfn`.
@@ -268,3 +272,35 @@ fn small_pfn(&self) -> Pfn {
         self.small.table_frame()
     }
 }
+
+impl DualPdeOps for DualPde {
+    fn new(big: u64, small: u64) -> Self {
+        Self {
+            big: PdeOps::new(big),
+            small: PdeOps::new(small),
+        }
+    }
+
+    fn new_small(table_pfn: Pfn) -> Self {
+        Self {
+            big: PdeOps::new(0),
+            small: PdeOps::new_vram(table_pfn),
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
+        PdeOps::raw_u64(&self.big)
+    }
+
+    fn small_raw_u64(&self) -> u64 {
+        PdeOps::raw_u64(&self.small)
+    }
+}
diff --git a/drivers/gpu/nova-core/mm/pagetable/ver3.rs b/drivers/gpu/nova-core/mm/pagetable/ver3.rs
index 2f9e762c4667..1c52013e498d 100644
--- a/drivers/gpu/nova-core/mm/pagetable/ver3.rs
+++ b/drivers/gpu/nova-core/mm/pagetable/ver3.rs
@@ -25,7 +25,10 @@
 use super::{
     AperturePde,
     AperturePte,
+    DualPdeOps,
     PageTableLevel,
+    PdeOps,
+    PteOps,
     VaLevelIndex, //
 };
 use crate::mm::{
@@ -194,12 +197,12 @@ pub(in crate::mm) struct Pte(u64) {
 
 impl Pte {
     /// Create a PTE from a `u64` value.
-    pub(super) fn new(val: u64) -> Self {
+    pub(super) fn new_raw(val: u64) -> Self {
         Self::from_raw(val)
     }
 
     /// Create a valid PTE for video memory.
-    pub(super) fn new_vram(frame: Pfn, writable: bool) -> Self {
+    fn new_vram_inner(frame: Pfn, writable: bool) -> Self {
         let pcf = if writable { PtePcf::rw() } else { PtePcf::ro() };
         Self::zeroed()
             .with_valid(true)
@@ -207,14 +210,30 @@ pub(super) fn new_vram(frame: Pfn, writable: bool) -> Self {
             .with_pcf(pcf)
             .with_frame_number(frame)
     }
+}
 
-    /// Create an invalid PTE.
-    pub(super) fn invalid() -> Self {
+impl PteOps for Pte {
+    fn new(val: u64) -> Self {
+        Self::from_raw(val)
+    }
+
+    fn invalid() -> Self {
         Self::zeroed()
     }
 
-    /// Get the raw `u64` value.
-    pub(super) fn raw_u64(&self) -> u64 {
+    fn new_vram(pfn: Pfn, writable: bool) -> Self {
+        Self::new_vram_inner(pfn, writable)
+    }
+
+    fn is_valid(&self) -> bool {
+        self.valid().into_bool()
+    }
+
+    fn frame_number(&self) -> Pfn {
+        Pte::frame_number(*self)
+    }
+
+    fn raw_u64(&self) -> u64 {
         self.into_raw()
     }
 }
@@ -237,40 +256,50 @@ pub(in crate::mm) struct Pde(u64) {
 
 impl Pde {
     /// Create a PDE from a `u64` value.
-    pub(super) fn new(val: u64) -> Self {
+    pub(super) fn new_raw(val: u64) -> Self {
         Self::from_raw(val)
     }
 
     /// Create a valid PDE pointing to a page table in video memory.
-    pub(super) fn new_vram(table_pfn: Pfn) -> Self {
+    fn new_vram_inner(table_pfn: Pfn) -> Self {
         Self::zeroed()
             .with_is_pte(false)
             .with_aperture(AperturePde::VideoMemory)
             .with_table_frame(table_pfn)
     }
+}
 
-    /// Create an invalid PDE.
-    pub(super) fn invalid() -> Self {
+impl PdeOps for Pde {
+    fn new(val: u64) -> Self {
+        Self::from_raw(val)
+    }
+
+    fn new_vram(table_pfn: Pfn) -> Self {
+        Self::new_vram_inner(table_pfn)
+    }
+
+    fn invalid() -> Self {
         Self::zeroed().with_aperture(AperturePde::Invalid)
     }
 
-    /// Check if this PDE is valid.
-    pub(super) fn is_valid(&self) -> bool {
-        self.aperture() != AperturePde::Invalid
+    fn is_valid(&self) -> bool {
+        Pde::aperture(*self) != AperturePde::Invalid
     }
 
-    /// Get the VRAM address of the page table.
-    pub(super) fn table_vram_address(&self) -> VramAddress {
+    fn aperture(&self) -> AperturePde {
+        Pde::aperture(*self)
+    }
+
+    fn table_vram_address(&self) -> VramAddress {
         debug_assert!(
-            self.aperture() == AperturePde::VideoMemory,
+            Pde::aperture(*self) == AperturePde::VideoMemory,
             "table_vram_address called on non-VRAM PDE (aperture: {:?})",
-            self.aperture()
+            Pde::aperture(*self)
         );
         VramAddress::from(self.table_frame())
     }
 
-    /// Get the raw `u64` value.
-    pub(super) fn raw_u64(&self) -> u64 {
+    fn raw_u64(&self) -> u64 {
         self.into_raw()
     }
 }
@@ -363,29 +392,40 @@ pub(in crate::mm) struct DualPde {
 unsafe impl Zeroable for DualPde {}
 
 impl DualPde {
-    /// Create a dual PDE from raw 128-bit value (two `u64`s).
-    pub(super) fn new(big: u64, small: u64) -> Self {
-        Self {
-            big: DualPdeBig::new(big),
-            small: Pde::new(small),
-        }
-    }
-
-    /// Create a dual PDE with only the small page table pointer set.
-    pub(super) fn new_small(table_pfn: Pfn) -> Self {
-        Self {
-            big: DualPdeBig::invalid(),
-            small: Pde::new_vram(table_pfn),
-        }
-    }
-
-    /// Check if the small page table pointer is valid.
-    pub(super) fn has_small(&self) -> bool {
-        self.small.is_valid()
-    }
-
     /// Check if the big page table pointer is valid.
     fn has_big(&self) -> bool {
         self.big.is_valid()
     }
 }
+
+impl DualPdeOps for DualPde {
+    fn new(big: u64, small: u64) -> Self {
+        Self {
+            big: DualPdeBig::new(big),
+            small: PdeOps::new(small),
+        }
+    }
+
+    fn new_small(table_pfn: Pfn) -> Self {
+        Self {
+            big: DualPdeBig::invalid(),
+            small: PdeOps::new_vram(table_pfn),
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
+        self.big.raw_u64()
+    }
+
+    fn small_raw_u64(&self) -> u64 {
+        PdeOps::raw_u64(&self.small)
+    }
+}
-- 
2.34.1

