Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA25ACD4F50
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:12:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E1D710E99A;
	Mon, 18 May 2026 18:12:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="WAzUgYD8";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010036.outbound.protection.outlook.com
 [52.101.193.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F29310E98F
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:11:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzlwCD2zw82Zk6I7W1qYlDqQQ+d0fuj32nv1opnfV6cGZRoCqD1IHVbjMjakVWDxB3pItSyqH8IEG5L7oduPs1NMbOVSyHm4wiqY+agiE7QLxdKA74hxZSdBxvTbOH8DfYw6q4/d1ZbiSj/xYL25muZtHmKbEo+s82BYqU3Jq5HV5CEj5zocgJf0O5p7uCYA4JH+IGYgaBFTOSACb0o5EwIkvRF0SEnvdT5k3gzBWMOvvk6wFVCkg0ly92fEOiHUp3ASyVeUKJ1lE5vzkYeWYXwWb6Afw0N7fZXovUOR5cl4+a5XtkXnSreqyW/a96lRlW6Ep06aNoHIh7uHFTLjUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9phWLi4TJQ6+Fm7LabXlSekaCih8z2f8T9FOKSB43wo=;
 b=KAE1sKQAALgcalaUfJ//msJzAdrpg12VCuryYjcZBGksGR8goHUj6rsKF0Bvd061ATZWeAouyH2x+he0cpdjHHu7hHDMGXAMMF3nCjQ3SGXuSFyf2w9ZltG8HaPA3ChOFCmlhh+K8B4H/Ypdte7GPPwxOJgK7IJYMvTcPQLnqne+mXezUyMeN+Qi6hnSTj1CTj2MOHfLsObNS3oArryzCsnq8wS2VdFqM5+0xpoaB6HVh6mS4UUN0zWd9o2ymVmRB3jiQ/mCJOThNvu81SHFxDlTDmyGysPLZC6jeLTeNnLysa1KU1wPN0KgA0NM2WoS3t7vBAIGF541spoOw4JVWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9phWLi4TJQ6+Fm7LabXlSekaCih8z2f8T9FOKSB43wo=;
 b=WAzUgYD8sbzN+SWcrPLfhIT2lOHWheD2TVCIpw/2L2Ur65nEG9YhR0z310EkKzGz8zcM9hvyTpK9SHQrFOBxWWE3K/M7U38zqjHkIfzfl/6u6v8F4s3ddDgFGgSf/OpYFY50VaHrUVO1veDph+sHpuJ/RO404qxNkeYLSRmPc9XZk3hBRFUaRjAK3wvWNH5WZa6Iu9hPz6yWz+pATHl729pmCTFJWPzRFU5may1IE9GyrSzUAIVmtmT9O0l9tQdT8f1xzjmQyZAKDzfzKP7ajVnYJdJ16Sfi7CJCo84h9sCW8Bj+4VzM9hK4G0QaLSYOHKaJB1CD5yb/wiaojMGZYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 18:11:41 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0025.012; Mon, 18 May 2026
 18:11:41 +0000
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
Subject: [PATCH v1 07/16] gpu: nova-core: mm: Add MMU v2 page table types
Date: Mon, 18 May 2026 14:11:16 -0400
Message-Id: <20260518181126.2493572-8-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518181126.2493572-1-joelagnelf@nvidia.com>
References: <20260518181126.2493572-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0972.namprd03.prod.outlook.com
 (2603:10b6:408:109::17) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BY5PR12MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f232143-c2b4-4d22-7165-08deb508e955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: /ecqR5lyuDYLACB62DYFhdnGBR+QK5A9Jw97rufvxeaKWrLBXucCZDwccKdyGcWjBItkURPgnap/AjMRCcQXCLPXOGCZAJChHf0YSg4ZxtAmWouwOi5/ro9JlytkpUvXJtqhvXNzUSL53bReZhfIm1LRUbf1xyaryqYlhS5eW1om07/TVCEVR0jN+QbZQpFKTzIS2AF0gqvhNxvwnCFmEXTgl4i01iHoeVnUxaaNVJAk99Rv5vXIf8Nj9jDbdATpHZYziSjZoCsEiXiMjIKlIz3H4eQq12k8EFFALJd94xPzd+T5vseEhil+nMreMNyyjT1YHxM+Fksc58ul3Mkm0yY77s9Bldpoc7jk6RagfWtSX1e3XPOiYVFqSlFP04D6z1eelhgxMrdvqqdlAf8g0KXHLry9CqdD3nKFOBsEetP+7dhnielT3rjj1v1QtDWWBO59w6l64BTUw+JE7K4IAc+mwWfVD+cH9g41I/1AhLMeaULRz9M0c0Gtc4flhy90grS0UifiXplzNX/vd50GlC/8ogN9xISm8WvPN6zHxKgLsQrSB/gLIQ4GGXyfnbMOMNKCIPZfavdQId9BLIbaS0DayvxngyilEny29c8iTheA+bkZ6qugXQIAv9TFdkloykysccHa6wjsCdaRkSD++cf8XUayq3rAP2bC3F9oMWTXLDLD2L2r1SSu1R6+kgcE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iFV8BRCPy4YOk+Ema4RpNKEEv0upa37YNS+BH3Mk0VaqMGwvE8A0ntOe4pGm?=
 =?us-ascii?Q?k5sqK2wXafNLEz16zfBpSyXyEp7KEC+5W0W5lo8dHroP6s6m4biKl8uPvbal?=
 =?us-ascii?Q?GkYAvb6pCFdD/82OW3MwsNX15x14C5KSgrMHUxrRiVK+xivENlMLk6tp3ZUS?=
 =?us-ascii?Q?gwkpUzGk7X9hckLULjNONNOHPSr+5lynr7fKPXh538g+LU773TMBifnXX7py?=
 =?us-ascii?Q?TtvhhHs8iOqfWFHcZpcUBrAhCIFZHTHDOqjekV+0Ubj5kw39UKJTFCehYrYq?=
 =?us-ascii?Q?HQkjsL3FvKaSZgByxmx7gkD5jDTIAToBwzzVgRTqeX3c4VfI6OGNp+xUres3?=
 =?us-ascii?Q?SllRfwlepZaopk4pT5o11Du8iQFSVaqK91Axm+08owUKhWQNY2vRT5qqrFe+?=
 =?us-ascii?Q?HOJZWtOqaf953WXp+gs6pvI+57nSj/M2s+pl/M/LfszgPd8oG+72lzDCMCMK?=
 =?us-ascii?Q?qMRdZslG13RN1OLE9RXsCalYvj6oIH8R5nP7uBZyE6+EFNilNNe1LOq0rnbm?=
 =?us-ascii?Q?nVbK5oY4Lne+TOu/Ap8sIdm3PZ0VDWe4xaQ+iZGKiHfrdKc30lg5hwTi/eYn?=
 =?us-ascii?Q?KSJGsV3NHDL65d4qoZPPlvszQE4ufS87WcnhuTc1EsdV1oVMR9LYGm9iemFl?=
 =?us-ascii?Q?C2wJaSLazZ/MN4ZTDYX9k3IE2X6G4jI1p+HH8ImW0jgszc/QXtivyVpZkBHy?=
 =?us-ascii?Q?2mhsxIcyDDOzFKAA9/lO/cZRCv5Q7baQXGC678NOiGcOwNeyfM+zJFwQzGSp?=
 =?us-ascii?Q?Dn3w7I6RD37yiVY0y2BO7kMujxteBvjRq5gyP5L36N8woZdD4mRWxFS6DjGl?=
 =?us-ascii?Q?N3fWr69OmaBGbElV52S/EMJ3AK1V9kcqs2iBdfrd21zjyio8AisGmZz9YMuj?=
 =?us-ascii?Q?OWv4bR8hwSGFCbqQu0qwmuUwmhF8ZjpjFFHoMG0EjmtEOx56xqChBQR0g61b?=
 =?us-ascii?Q?V6n0bbrKCkujdPdKvtLf32nKgSP3EGsGp9ogYIWhnte0hCHPV8PZhUMhq/YB?=
 =?us-ascii?Q?zX/Ksr94WkNzu9RG6x3Wb3ASKiGXqz96Bv6zJlQhH9Lzenyg2vQiFoGBjgYZ?=
 =?us-ascii?Q?Tpos8CZ4tWTmm1mvw7CLO3AhO3cGRpGaQyhbduYdEgKLXx7VsahlG3Q0FT4k?=
 =?us-ascii?Q?6m5+Kk+9yoIORvPMv5BX47nihRV6ck6cq2hwnhi8h8Pg210KTwhwEDTV04xn?=
 =?us-ascii?Q?zpt7MtfXQC2ofZWk8+F47xd7Axgk5VUHybtln7//lNyY5SZz+3Zc4vtLSxdO?=
 =?us-ascii?Q?eeZo0T+y7vvA3m12zrUJG/6o5t3GiCecT0Q45F+FNxr/h7p/FFq6F7Lq4qf2?=
 =?us-ascii?Q?46aaZ2CBa+M/syj+iVPmU0CrYRJJy1OPNSRqhneuVCKM9HcHQmKL6Q78GMZ5?=
 =?us-ascii?Q?6ebJRwWJPJbA9Gh61xmh9RcurSg4iwkC67KIVX+5hg+ORY+8ELh25umak488?=
 =?us-ascii?Q?CFrwg/5HZjuqzClZvWf1FbRQ6ZYbpgjDIP5crU+y5yEYVDo8fjx5OJuVrdfs?=
 =?us-ascii?Q?WhyfQ1XOTDsoXJrmO+ZKZrRm3xEqFzVkDjrs+MZ73XuyH5YzOYnn2M9nKmwh?=
 =?us-ascii?Q?hdHiv8+lB58hq+MxlwrHOU3w5zmZ+KmZkhHOAhPqIGZl/GXz+Fv/uUvDthIw?=
 =?us-ascii?Q?VOie/nVv3/uXEEjRVSxJIyni79eqF6tdst4luS9QD5yG9kEgyxUCBwEt/17X?=
 =?us-ascii?Q?X/MbrVen9/VvZu9Rok3a/ZHfA/ysvBjiJ5yKeIdGV0wf2cts8XL8re6axqKP?=
 =?us-ascii?Q?dXPLJr3AQA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f232143-c2b4-4d22-7165-08deb508e955
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:11:41.3670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6RVEncwJ78JDyYyss/KgZfZGLIiQ0bi07JHvzf5vSlFZDVUIAPK1juigxHrJP9uUv/xu/gjZsf4QCy0f18Oyg==
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

Add page table entry and directory structures for MMU version 2 used by
Hopper and later GPUs. The `Pte`, `Pde`, and `DualPde` types each
implement the `PteOps`, `PdeOps`, and `DualPdeOps` traits introduced
earlier in the series, providing the version-agnostic API used by the
forthcoming page-table walker and mapper.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/mm/pagetable.rs      |   2 +
 drivers/gpu/nova-core/mm/pagetable/ver2.rs | 271 +++++++++++++++++++++
 2 files changed, 273 insertions(+)
 create mode 100644 drivers/gpu/nova-core/mm/pagetable/ver2.rs

diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-core/mm/pagetable.rs
index 7ea090024d91..df041fc89390 100644
--- a/drivers/gpu/nova-core/mm/pagetable.rs
+++ b/drivers/gpu/nova-core/mm/pagetable.rs
@@ -8,6 +8,8 @@
 
 #![expect(dead_code)]
 
+pub(super) mod ver2;
+
 use kernel::prelude::*;
 
 use kernel::num::Bounded;
diff --git a/drivers/gpu/nova-core/mm/pagetable/ver2.rs b/drivers/gpu/nova-core/mm/pagetable/ver2.rs
new file mode 100644
index 000000000000..089e5cc2bfc3
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/pagetable/ver2.rs
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! MMU v2 page table types for Turing, Ampere and Ada GPUs.
+//!
+//! This module defines MMU version 2 specific types (Turing, Ampere and Ada GPUs).
+//!
+//! Bit field layouts derived from the NVIDIA OpenRM documentation:
+//! `open-gpu-kernel-modules/src/common/inc/swref/published/turing/tu102/dev_mmu.h`
+
+#![allow(dead_code)]
+
+use kernel::bitfield;
+use kernel::num::Bounded;
+use pin_init::Zeroable;
+
+use super::{
+    AperturePde,
+    AperturePte,
+    DualPdeOps,
+    PageTableLevel,
+    PdeOps,
+    PteOps,
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
+        Self::from_raw(va.into_raw())
+    }
+}
+
+impl VaLevelIndex for VirtualAddressV2 {
+    fn level_index(&self, level: u64) -> u64 {
+        match level {
+            0 => *self.pde3_idx(),
+            1 => *self.pde2_idx(),
+            2 => *self.pde1_idx(),
+            3 => *self.pde0_idx(),
+            4 => *self.pt_idx(),
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
+impl PteOps for Pte {
+    fn from_raw(val: u64) -> Self {
+        Self::from_raw(val)
+    }
+
+    fn invalid() -> Self {
+        Self::zeroed()
+    }
+
+    fn new(aperture: AperturePte, pfn: Pfn, writable: bool) -> Self {
+        let base = Self::zeroed()
+            .with_valid(true)
+            .with_aperture(aperture)
+            .with_read_only(!writable);
+        match aperture {
+            AperturePte::VideoMemory => base.with_frame_number_vid(pfn),
+            // Sysmem PTEs use VOL=1 to bypass L2 for cache coherency.
+            AperturePte::SystemCoherent => base.with_frame_number_sys(pfn).with_volatile(true),
+            AperturePte::PeerMemory | AperturePte::SystemNonCoherent => {
+                kernel::pr_warn!("MMU v2 PTE aperture {:?} not supported\n", aperture);
+                Self::invalid()
+            }
+        }
+    }
+
+    fn is_valid(&self) -> bool {
+        self.valid().into_bool()
+    }
+
+    fn frame_number(&self) -> Pfn {
+        match self.aperture() {
+            AperturePte::VideoMemory => self.frame_number_vid(),
+            _ => self.frame_number_sys(),
+        }
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
+impl PdeOps for Pde {
+    fn from_raw(val: u64) -> Self {
+        Self::from_raw(val)
+    }
+
+    fn new(aperture: AperturePde, table_pfn: Pfn) -> Self {
+        let base = Self::zeroed()
+            .with_valid_inverted(false) // 0 = valid
+            .with_aperture(aperture);
+        match aperture {
+            AperturePde::VideoMemory => base.with_table_frame_vid(table_pfn),
+            // Sysmem PTEs use VOL=1 to bypass L2 for cache coherency.
+            AperturePde::SystemCoherent => base.with_table_frame_sys(table_pfn).with_volatile(true),
+            AperturePde::Invalid | AperturePde::SystemNonCoherent => {
+                kernel::pr_warn!("MMU v2 PDE aperture {:?} not supported\n", aperture);
+                Self::invalid()
+            }
+        }
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
+        Pde::aperture(*self)
+    }
+
+    fn table_vram_address(&self) -> VramAddress {
+        debug_assert!(
+            Pde::aperture(*self) == AperturePde::VideoMemory,
+            "table_vram_address called on non-VRAM PDE (aperture: {:?})",
+            Pde::aperture(*self)
+        );
+        VramAddress::from(self.table_frame_vid())
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
+    /// Check if the big page table pointer is valid.
+    fn has_big(&self) -> bool {
+        PdeOps::is_valid(&self.big)
+    }
+}
+
+impl DualPdeOps for DualPde {
+    fn from_raw(big: u64, small: u64) -> Self {
+        Self {
+            big: PdeOps::from_raw(big),
+            small: PdeOps::from_raw(small),
+        }
+    }
+
+    fn new_small(table_pfn: Pfn) -> Self {
+        Self {
+            big: PdeOps::from_raw(0),
+            small: PdeOps::new(AperturePde::VideoMemory, table_pfn),
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
+        self.big.into_raw()
+    }
+
+    fn small_raw_u64(&self) -> u64 {
+        self.small.into_raw()
+    }
+}
-- 
2.34.1

