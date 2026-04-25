Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19857FF8863
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 21:15:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBEC810E48F;
	Sat, 25 Apr 2026 21:15:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="sOo2wfT8";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012061.outbound.protection.outlook.com
 [40.93.195.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92EE210E490
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:15:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/OVYINQEVCLE/744CtBfYVI36k7/ptOIA3Ci+5w8rL7uU1mj8p1KjvpF8voTKpAML3um1VoBrPImESf7hXsPlwEbcsgt/uO8ijZO7WuS/PPb9EoNw8T44ISkDs7IrPUTkARJdhtJNLnNKaDZbgtDgLgHYEz0nffFbqft6OWHXyz986MFssMSAB89cGK98nwYoigYrnKtt43IlmxQnnlnE3qq368j+VXc9XFkc/dObhbBbhMbhfusnQYbSag6/r2g//mau5s/EpNWZrfqmJg1cjgV5CPxr8IuxhxnZSvkvLk+vDJv8deIPG2kGg/lsALmjOFp4VM90dyKX3qAqiqzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrUKnw6RjKQem1uyYfPEVJR5TOmEAutuo5zzB6/2ZEo=;
 b=wVjQ1Q4ox0nOD363+gUG17ZMjn5GQZVdERsNrzOBN9nIlURxjemdw6zlNOns7/JwsKm8mTAAo4CH7mmhSgk2YbI2wYGOVf/dA7IXL32PVBbdqwwWutdyI33b4BwtlSNGoapdwnHJMJV5XAYDXR7USOxURbtsA+a4dA9m66GrphHJbxt2AcQ98uIgPMgSjZHBjYnDhZqv5F0blLF2ZXNPzXesZVHFq8yJImQHZtDwLA6r6s26pHUrnzAIPe4ei5k7n5hlf01IhQ69dF0bIqdpW3PC6nbLmNGTJYJiNjYeg9B1VfIkZd/naqNUrMacEt/Tz8haJr57qNel/5SHGYVrWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrUKnw6RjKQem1uyYfPEVJR5TOmEAutuo5zzB6/2ZEo=;
 b=sOo2wfT8u/tXoRJu/qCUmpv6xbGHbaoPrP/olqOpszslqCpTWdD8Z/K3Aw27F/4kKGNRuK/pcNPL1FVyMZtkeF4hhgGbuZB78qZwNePnwFwAENnvGWFwfjTVOFNc99lR76fZUpCgkmncVFP3/bFX2uKkhRrZyxYHfGkmvWXw1QMWT4T/5KfPK0idhwCWfa8NiNdxazHBbWftikkxY6INoaGm3mNMKupOuxdaJaiy48FfBrs30Zoj6FFQPdq+pT2AeGNSk8y4hnoH6LV5SORBoPMsC2JAHsqSG++lr3qDiNV3mGH4mKtUL/Vj2eLT8tptuP1abjgWezPoVFH7tUpX1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Sat, 25 Apr
 2026 21:15:32 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 21:15:32 +0000
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
Subject: [PATCH v12 11/22] gpu: nova-core: mm: Add MMU v3 page table types
Date: Sat, 25 Apr 2026 17:14:43 -0400
Message-Id: <20260425211454.174696-12-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425211454.174696-1-joelagnelf@nvidia.com>
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0093.namprd15.prod.outlook.com
 (2603:10b6:930:7::21) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: c6969a5b-4bcc-4261-a69f-08dea30fc887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: g3TGASNMWOh0IvDZdw5UX8f2uCaJUMsP0ii+Iy6nxC8M9IBIR6fCYrr1kUu1ngKM9/mBhZD1BmZm45aIu512nLSWEPYybpw8ZCBVkDljH15+cFJ2xJyhJc/Ta1oBEDgDHkSDJidNTD8LbV74Xp5t6qC5z718B3qYqy1noJx/I+ztXm8aeB6ED2XDvwAFIU4woid9PGSRr9HZzodgiRat7C6i0PXvE9zM+zSgwUhHZFXR4x/WOhHVmQMlVSnKLCYHxAxZgcfzszPpYYJgYycDxmI+Kn0AJA6AxlJ5Czrh00NpSh1rU1xYT51w8xVDnNruLe2ar2n1uOH4ffd2WsBEiELWG09eZnLrxD3jEYdSTpoS84dCYOZA6kf+R1bKYEQlQujtfVycTU0dLY7n9Anpf765L3MDxzGc0oliJC1BBHx44S7+cGjT7q5dWtcIHqMLHZGjxeNTg71Uq+0aAkiKeO3RnmCqq0LauL6DORlhGPVWbV3uQCwOWK4Z4XkKystFv6/swdP2kRC+UIGGjOjJDIuPinrjV6/J0XCxOPS0AU1COlPSClK6674G7z04bLc8+TtmENz94DOZ0yrlayEt/pQf+VYuA/YP0eq7faR7QaLWdvYYuupynJSs042nRvRfOsvwohJxPdHsTcoZExH8QxrhMjkFPLAOjVMNnpjIxTn9GUum7q31ch2zzUdDr5GpcwN0QvY+NA5gxO99M1K9oUoKt3eNxiv0UcOHibYK3bI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zL3Fc/bUlaa9NqOfU2bRAQRLZxoL4mvXIx5RHob5xqYp6zFgaC2zdpg/Cyi9?=
 =?us-ascii?Q?PUw1kjJLarzXq05/i0bUvDg7SbxSy2yFZnx3zyVjh72BAWIKpJ3XPtvVkhu/?=
 =?us-ascii?Q?r4GlfSlwScisngy6sXq24NUqhycvWzYEAaDNMP0O+fG6EcPFn2fa3U3rcC8P?=
 =?us-ascii?Q?rpArhuHNAvEsIB5dRtuDhk+lUtkQbRwbbEofxqgBXqGnIY/N1viTkHCdq9zK?=
 =?us-ascii?Q?hKRnbOWTNzrlMeqZYWUIQrublJ+WTdgz5o0cvlfNVDkOr5iIrm0BFA1z0Ls7?=
 =?us-ascii?Q?5Q6VFj4vVXnEo8Rv4uNzXOI+GOpBOv7B7yLNxqOAjzpuPibtCadoVu6nQGjf?=
 =?us-ascii?Q?N4D0AWNtxzTF4lIXT/fc/HFz8OvR4mdSZwXQPkQCRCMW1dlfv/mjH8WWIjO+?=
 =?us-ascii?Q?ypjtApZ6sLTzAhiCan9c2mDK39HLZKP51H9SvLWv1ALZjPU0mdJiqjuZsgAB?=
 =?us-ascii?Q?cvrVyYt+hHYKT7mk6NmltO8QE+8YxFYHzyaf+3mn6ZKX5NAZgsng16edbtUJ?=
 =?us-ascii?Q?EQkM9LhhCTrYbljQ3JAsh6AtXiLnVVf4egHtazW3EMSLjHjsFeoKgVwmgQXp?=
 =?us-ascii?Q?gG9Z/ORgQ1aXNOsvWdzQuvb5Tnn1Z9ye+c1vh0o/hqKJQNhhffWq6ccArwN0?=
 =?us-ascii?Q?hpIBcRmux3NTZKmbpWXVi3Ch/IWevaaYJJbbcPVGCRd2TK/De5aedpM5Aqjf?=
 =?us-ascii?Q?FsX0XM7a5BjfcBXUUQxmIg0a+ioeLqtSMJ+HTclduObsDr4zUvIdrzZloUae?=
 =?us-ascii?Q?X2RhjK6m+4IQV1lGmh0XdO8oSL7pr5CwWIbVWVQgfPtyVj7drU1jsW+uLEe3?=
 =?us-ascii?Q?y9GlZcykCMR1ymiqwARQkHMimTREeeaqM8jOSUVZw08RcII9AmaT/EGF4N/E?=
 =?us-ascii?Q?GJI+gdNWD6ptN/3n1IC/LPGh4htcKC5iUITeXy8Tw1eCEoyv9AZBr+x1QMxe?=
 =?us-ascii?Q?qGawOPJJomH6xTNbyhfER2ZcbssjBXD18et4+BYnRXuNfaeJk6/Uea8wQJYw?=
 =?us-ascii?Q?pKup1KuLOKT5SBb3OKztFuB0tRi9oadY3W7qllzwgtCnmFvlxUMEzEKmYvsE?=
 =?us-ascii?Q?xqfYwM/gftyUEw/g6DyUFnjHSAtGCkx27Dl6BSGDJP21WMfjHyiTqQIIvsiQ?=
 =?us-ascii?Q?ZX7t27BkYS6FtL3kJiPxFGiHXVd3v09MicZ/7+fjWon9o7eqLxeCdhaReeex?=
 =?us-ascii?Q?7FceMe/2wV9CzCFH5ifAaxKxf/eLaDBfjOG+TGHVSJp1R38DxX9C+Vk9B8Ep?=
 =?us-ascii?Q?sPMcL5RX2gVYsfDx2MWx8G+mZFlruw5laH3Wo1IpLIUxlsSK1zNGBIGPnZgp?=
 =?us-ascii?Q?/J2okeuxYtPfRQT6Vab3CySNNXZi6d/V5d/SuYuecQ7KzyELS78vVuAubPjV?=
 =?us-ascii?Q?z/fFc25/J+VrScqLBp1WN/ic98n56ZvlalfMkkPiaS31lWUMubKJ6GVrRTwL?=
 =?us-ascii?Q?I8o/bDST7bRw8bU67M2gODMQY2wRZOvDt7wuvd8UForOuofvmj54He77X/Jk?=
 =?us-ascii?Q?w4nvOkb4TuvrCHjBkJ0psqO3+dhfyLD9bUPu4cRQffPv1NtEdh5wz7caHpcE?=
 =?us-ascii?Q?ly3VzCMcFK2RblLiYDiRSeMGaR8yEFmuH34pVveoxrwQ88+SIJuSBWAs49Ow?=
 =?us-ascii?Q?EumT2qyivyhHThV4qY+mHhQC9hUqCL20/fqljwGgYe89ID1OYZOetXA40Beu?=
 =?us-ascii?Q?qsLcnxLn+6o5BPLLZBE6ZjNPiz1n0JnVS0Krlcf+3zp4rn0C0diFerLUT7qp?=
 =?us-ascii?Q?mkkIyE44TQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6969a5b-4bcc-4261-a69f-08dea30fc887
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:15:31.9578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gEDqrw5Gy0IDtKuCVZHxMayyiBlSRp9rTJWukJGIUwZzGdLC0kFz8muqxAUcd60kH/nwVAYuSDOWHZKIoGFhTQ==
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

Add page table entry and directory structures for MMU version 3
used by Hopper and later GPUs.

Cc: Nikola Djukic <ndjukic@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/mm/pagetable.rs      |   1 +
 drivers/gpu/nova-core/mm/pagetable/ver2.rs |  10 +-
 drivers/gpu/nova-core/mm/pagetable/ver3.rs | 391 +++++++++++++++++++++
 3 files changed, 397 insertions(+), 5 deletions(-)
 create mode 100644 drivers/gpu/nova-core/mm/pagetable/ver3.rs

diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-core/mm/pagetable.rs
index f6b184c9b8c8..9897818b3b07 100644
--- a/drivers/gpu/nova-core/mm/pagetable.rs
+++ b/drivers/gpu/nova-core/mm/pagetable.rs
@@ -9,6 +9,7 @@
 #![expect(dead_code)]
 
 pub(super) mod ver2;
+pub(super) mod ver3;
 
 use kernel::num::Bounded;
 
diff --git a/drivers/gpu/nova-core/mm/pagetable/ver2.rs b/drivers/gpu/nova-core/mm/pagetable/ver2.rs
index 203dc5d9fdf6..419ca0e11cd6 100644
--- a/drivers/gpu/nova-core/mm/pagetable/ver2.rs
+++ b/drivers/gpu/nova-core/mm/pagetable/ver2.rs
@@ -59,11 +59,11 @@ pub(super) fn new(va: VirtualAddress) -> Self {
 impl VaLevelIndex for VirtualAddressV2 {
     fn level_index(&self, level: u64) -> u64 {
         match level {
-            0 => self.pde3_idx(),
-            1 => self.pde2_idx(),
-            2 => self.pde1_idx(),
-            3 => self.pde0_idx(),
-            4 => self.pt_idx(),
+            0 => self.pde3_idx().get(),
+            1 => self.pde2_idx().get(),
+            2 => self.pde1_idx().get(),
+            3 => self.pde0_idx().get(),
+            4 => self.pt_idx().get(),
             _ => 0,
         }
     }
diff --git a/drivers/gpu/nova-core/mm/pagetable/ver3.rs b/drivers/gpu/nova-core/mm/pagetable/ver3.rs
new file mode 100644
index 000000000000..2f9e762c4667
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/pagetable/ver3.rs
@@ -0,0 +1,391 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! MMU v3 page table types for Hopper and later GPUs.
+//!
+//! This module defines MMU version 3 specific types (Hopper and later GPUs).
+//!
+//! Key differences from MMU v2:
+//! - Unified 40-bit address field for all apertures (v2 had separate sys/vid fields).
+//! - PCF (Page Classification Field) replaces separate privilege/RO/atomic/cache bits.
+//! - KIND field is 4 bits (not 8).
+//! - IS_PTE bit in PDE to support large pages directly.
+//! - No COMPTAGLINE field (compression handled differently in v3).
+//! - No separate ENCRYPTED bit.
+//!
+//! Bit field layouts derived from the NVIDIA OpenRM documentation:
+//! `open-gpu-kernel-modules/src/common/inc/swref/published/hopper/gh100/dev_mmu.h`
+
+#![expect(dead_code)]
+
+use kernel::bitfield;
+use kernel::num::Bounded;
+use kernel::prelude::*;
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
+// Bounded to version 3 Pfn conversion.
+impl_pfn_bounded!(40);
+
+bitfield! {
+    /// MMU v3 57-bit virtual address layout.
+    pub(super) struct VirtualAddressV3(u64) {
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
+        /// PDE3 index [55:47].
+        55:47   pde3_idx;
+        /// PDE4 index [56].
+        56:56   pde4_idx;
+    }
+}
+
+impl VirtualAddressV3 {
+    /// Create a [`VirtualAddressV3`] from a [`VirtualAddress`].
+    pub(super) fn new(va: VirtualAddress) -> Self {
+        Self::from_raw(va.raw_u64())
+    }
+}
+
+impl VaLevelIndex for VirtualAddressV3 {
+    fn level_index(&self, level: u64) -> u64 {
+        match level {
+            0 => self.pde4_idx().get(),
+            1 => self.pde3_idx().get(),
+            2 => self.pde2_idx().get(),
+            3 => self.pde1_idx().get(),
+            4 => self.pde0_idx().get(),
+            5 => self.pt_idx().get(),
+            _ => 0,
+        }
+    }
+}
+
+/// PDE levels for MMU v3 (6-level hierarchy).
+pub(super) const PDE_LEVELS: &[PageTableLevel] = &[
+    PageTableLevel::Pdb,
+    PageTableLevel::L1,
+    PageTableLevel::L2,
+    PageTableLevel::L3,
+    PageTableLevel::L4,
+];
+
+/// PTE level for MMU v3.
+pub(super) const PTE_LEVEL: PageTableLevel = PageTableLevel::L5;
+
+/// Dual PDE level for MMU v3 (128-bit entries).
+pub(super) const DUAL_PDE_LEVEL: PageTableLevel = PageTableLevel::L4;
+
+bitfield! {
+    /// Page Classification Field for PTEs (5 bits) in MMU v3.
+    pub(in crate::mm) struct PtePcf(u8) {
+        /// Bypass L2 cache (0=cached, 1=bypass).
+        0:0     uncached;
+        /// Access counting disabled (0=enabled, 1=disabled).
+        1:1     acd;
+        /// Read-only access (0=read-write, 1=read-only).
+        2:2     read_only;
+        /// Atomics disabled (0=enabled, 1=disabled).
+        3:3     no_atomic;
+        /// Privileged access only (0=regular, 1=privileged).
+        4:4     privileged;
+    }
+}
+
+impl PtePcf {
+    /// Create PCF for read-write mapping (cached, no atomics, regular mode).
+    fn rw() -> Self {
+        Self::zeroed().with_no_atomic(true)
+    }
+
+    /// Create PCF for read-only mapping (cached, no atomics, regular mode).
+    fn ro() -> Self {
+        Self::zeroed().with_read_only(true).with_no_atomic(true)
+    }
+
+    /// Get the raw `u8` value.
+    fn raw_u8(&self) -> u8 {
+        self.into_raw()
+    }
+}
+
+impl From<Bounded<u64, 5>> for PtePcf {
+    fn from(val: Bounded<u64, 5>) -> Self {
+        Self::from_raw(u8::from(val))
+    }
+}
+
+impl From<PtePcf> for Bounded<u64, 5> {
+    fn from(pcf: PtePcf) -> Self {
+        Bounded::from_expr(u64::from(pcf.into_raw()) & 0x1F)
+    }
+}
+
+bitfield! {
+    /// Page Classification Field for PDEs (3 bits) in MMU v3.
+    ///
+    /// Controls Address Translation Services (ATS) and caching.
+    pub(in crate::mm) struct PdePcf(u8) {
+        /// Bypass L2 cache (0=cached, 1=bypass).
+        0:0     uncached;
+        /// ATS disabled (0=enabled, 1=disabled).
+        1:1     no_ats;
+    }
+}
+
+impl PdePcf {
+    /// Create PCF for cached mapping with ATS enabled (default).
+    fn cached() -> Self {
+        Self::zeroed()
+    }
+
+    /// Get the raw `u8` value.
+    fn raw_u8(&self) -> u8 {
+        self.into_raw()
+    }
+}
+
+impl From<Bounded<u64, 3>> for PdePcf {
+    fn from(val: Bounded<u64, 3>) -> Self {
+        Self::from_raw(u8::from(val))
+    }
+}
+
+impl From<PdePcf> for Bounded<u64, 3> {
+    fn from(pcf: PdePcf) -> Self {
+        Bounded::from_expr(u64::from(pcf.into_raw()) & 0x7)
+    }
+}
+
+bitfield! {
+    /// Page Table Entry for MMU v3.
+    pub(in crate::mm) struct Pte(u64) {
+        /// Entry is valid.
+        0:0     valid;
+        /// Memory aperture type.
+        2:1     aperture => AperturePte;
+        /// Page Classification Field.
+        7:3     pcf => PtePcf;
+        /// Surface kind (4 bits, 0x0=pitch, 0xF=invalid).
+        11:8    kind;
+        /// Physical frame number (for all apertures).
+        51:12   frame_number => Pfn;
+        /// Peer GPU ID for peer memory (0-7).
+        63:61   peer_id;
+    }
+}
+
+impl Pte {
+    /// Create a PTE from a `u64` value.
+    pub(super) fn new(val: u64) -> Self {
+        Self::from_raw(val)
+    }
+
+    /// Create a valid PTE for video memory.
+    pub(super) fn new_vram(frame: Pfn, writable: bool) -> Self {
+        let pcf = if writable { PtePcf::rw() } else { PtePcf::ro() };
+        Self::zeroed()
+            .with_valid(true)
+            .with_aperture(AperturePte::VideoMemory)
+            .with_pcf(pcf)
+            .with_frame_number(frame)
+    }
+
+    /// Create an invalid PTE.
+    pub(super) fn invalid() -> Self {
+        Self::zeroed()
+    }
+
+    /// Get the raw `u64` value.
+    pub(super) fn raw_u64(&self) -> u64 {
+        self.into_raw()
+    }
+}
+
+bitfield! {
+    /// Page Directory Entry for MMU v3 (Hopper+).
+    ///
+    /// Note: v3 uses a unified 40-bit address field (v2 had separate sys/vid address fields).
+    pub(in crate::mm) struct Pde(u64) {
+        /// Entry is a PTE (0=PDE, 1=large page PTE).
+        0:0     is_pte;
+        /// Memory aperture type.
+        2:1     aperture => AperturePde;
+        /// Page Classification Field (3 bits for PDE).
+        5:3     pcf => PdePcf;
+        /// Table frame number (40-bit unified address).
+        51:12   table_frame => Pfn;
+    }
+}
+
+impl Pde {
+    /// Create a PDE from a `u64` value.
+    pub(super) fn new(val: u64) -> Self {
+        Self::from_raw(val)
+    }
+
+    /// Create a valid PDE pointing to a page table in video memory.
+    pub(super) fn new_vram(table_pfn: Pfn) -> Self {
+        Self::zeroed()
+            .with_is_pte(false)
+            .with_aperture(AperturePde::VideoMemory)
+            .with_table_frame(table_pfn)
+    }
+
+    /// Create an invalid PDE.
+    pub(super) fn invalid() -> Self {
+        Self::zeroed().with_aperture(AperturePde::Invalid)
+    }
+
+    /// Check if this PDE is valid.
+    pub(super) fn is_valid(&self) -> bool {
+        self.aperture() != AperturePde::Invalid
+    }
+
+    /// Get the VRAM address of the page table.
+    pub(super) fn table_vram_address(&self) -> VramAddress {
+        debug_assert!(
+            self.aperture() == AperturePde::VideoMemory,
+            "table_vram_address called on non-VRAM PDE (aperture: {:?})",
+            self.aperture()
+        );
+        VramAddress::from(self.table_frame())
+    }
+
+    /// Get the raw `u64` value.
+    pub(super) fn raw_u64(&self) -> u64 {
+        self.into_raw()
+    }
+}
+
+bitfield! {
+    /// Big Page Table pointer in Dual PDE (MMU v3).
+    ///
+    /// 64-bit lower word of the 128-bit Dual PDE.
+    pub(super) struct DualPdeBig(u64) {
+        /// Entry is a PTE (for large pages).
+        0:0     is_pte;
+        /// Memory aperture type.
+        2:1     aperture => AperturePde;
+        /// Page Classification Field.
+        5:3     pcf => PdePcf;
+        /// Table frame (table address 256-byte aligned).
+        51:8    table_frame;
+    }
+}
+
+impl DualPdeBig {
+    /// Create a big page table pointer from a `u64` value.
+    fn new(val: u64) -> Self {
+        Self::from_raw(val)
+    }
+
+    /// Create an invalid big page table pointer.
+    fn invalid() -> Self {
+        Self::zeroed().with_aperture(AperturePde::Invalid)
+    }
+
+    /// Create a valid big PDE pointing to a page table in video memory.
+    fn new_vram(table_addr: VramAddress) -> Result<Self> {
+        // Big page table addresses must be 256-byte aligned (shift 8).
+        if table_addr.raw_u64() & 0xFF != 0 {
+            return Err(EINVAL);
+        }
+
+        let table_frame = Bounded::from_expr(table_addr.raw_u64() >> 8);
+        Ok(Self::zeroed()
+            .with_is_pte(false)
+            .with_aperture(AperturePde::VideoMemory)
+            .with_table_frame(table_frame))
+    }
+
+    /// Check if this big PDE is valid.
+    fn is_valid(&self) -> bool {
+        self.aperture() != AperturePde::Invalid
+    }
+
+    /// Get the VRAM address of the big page table.
+    fn table_vram_address(&self) -> VramAddress {
+        debug_assert!(
+            self.aperture() == AperturePde::VideoMemory,
+            "table_vram_address called on non-VRAM DualPdeBig (aperture: {:?})",
+            self.aperture()
+        );
+        VramAddress::new(self.table_frame().get() << 8)
+    }
+
+    /// Get the raw `u64` value.
+    pub(super) fn raw_u64(&self) -> u64 {
+        self.into_raw()
+    }
+}
+
+/// Dual PDE at Level 4 for MMU v3 - 128-bit entry.
+///
+/// Contains both big (64KB) and small (4KB) page table pointers:
+/// - Lower 64 bits: Big Page Table pointer.
+/// - Upper 64 bits: Small Page Table pointer.
+///
+/// ## Note
+///
+/// The big and small page table pointers have different address layouts:
+/// - Big address = field value << 8 (256-byte alignment).
+/// - Small address = field value << 12 (4KB alignment).
+///
+/// This is why `DualPdeBig` is a separate type from `Pde`.
+#[repr(C)]
+#[derive(Debug, Clone, Copy)]
+pub(in crate::mm) struct DualPde {
+    /// Big Page Table pointer.
+    pub(super) big: DualPdeBig,
+    /// Small Page Table pointer.
+    pub(super) small: Pde,
+}
+
+// SAFETY: Both `DualPdeBig` and `Pde` fields are `Zeroable` (bitfield types are Zeroable).
+unsafe impl Zeroable for DualPde {}
+
+impl DualPde {
+    /// Create a dual PDE from raw 128-bit value (two `u64`s).
+    pub(super) fn new(big: u64, small: u64) -> Self {
+        Self {
+            big: DualPdeBig::new(big),
+            small: Pde::new(small),
+        }
+    }
+
+    /// Create a dual PDE with only the small page table pointer set.
+    pub(super) fn new_small(table_pfn: Pfn) -> Self {
+        Self {
+            big: DualPdeBig::invalid(),
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
+}
-- 
2.34.1

