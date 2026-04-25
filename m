Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B3BFF8863
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 21:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2478310E48D;
	Sat, 25 Apr 2026 21:15:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="NREzSkJm";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8F7310E489
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:15:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKKSwZS/zXLQMPWbBeU3ikFmg1kzkHlrBZr/3uEIsSJRXPV1U5dTwZ5nief6BIr4pg5Vn0SFh4kgF9FkQo/VbAgN5syasiDivR0mnB+Clv2U/8YR0U8p06swh5TwShMc4uE44RsHnza78bl33Qa/ysggjgd8ItObailbUbR+QlXTRvFIvZj/OBfO8+VJ54jQVfuyu0uNFM5YjWLCxW8rLo6Ntwz2tirRCCTHQ6hciWwq2Wtk5QJn+v538t5kCkiekdaaOOLX5ZfiTjHYBywnkmyStuXwFop13UKQAR8bx3qPR9zIQgqqeUlGTLw0GMYdN99uNhI8J+iX1TrhH2DzDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sV+sgJe6PzEvIhedZw/zP6hgl6cnkCZwRoQ/iqwGsU=;
 b=gBJYL1nPvhaQZfflK+nnfVcqzSCu/EBWN98H73CgY7ESroHMXpt8McBnKR8SoPwq+tUIMAKHuU5NwZiNXAlVbtrk86eoagWKVnnUmrtyCFKqry89MJAk1uoKDHCOaBvgP1LNMMu7nVm3q8cOLqWByY8UMvgHi/kw3SMtEl1LR9PCBFPegLQnfrk0Lp2EWHLQLNIyJMrot1eRPXbNZIfD0n0LZIqt9wv9KXn/ZCCEp1ZDfNZ4mxFTWDYXk0dXB1x2FttySFhPkHDYUGee8ZklR1/rUAvo2558SiT8WwAnFj1wiFQF/tciuqf6rwKJ2PddYOnohGwaQn+6q04hdoEq1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sV+sgJe6PzEvIhedZw/zP6hgl6cnkCZwRoQ/iqwGsU=;
 b=NREzSkJmFuzP5kvmdmQyxUSy/D/+iB6thGCWe3iOmLyVHAb2cxDgJ5lGZbKG8Fk9RAf2ah2MdPCC6Tg5K3WQSquwRLaYqjfxOwKRAC1hJ9/NUCxQHYBRoXKJAm+D4rm1J8+Fsr7U0NfFEQzXcjLR8jQZCmEFJN08yWZ50ty4BunDzwQeJKhgha+g1QGpb5sgSeoHWeUEsnhtChSOK2OGGB65VFuIEZroBOpfQcBAL4nPWhyq2VvM68E0tsYSukf2esxxlmBMBeJ9t6tHLtyawgsvMH0iCL2vghyN23Hsww7YkdZxJWmPbGO29bkfuvcE89DLqQpfscC+ZYtYnvrzFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Sat, 25 Apr
 2026 21:15:20 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 21:15:20 +0000
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
Subject: [PATCH v12 06/22] gpu: nova-core: mm: Add common memory management
 types
Date: Sat, 25 Apr 2026 17:14:38 -0400
Message-Id: <20260425211454.174696-7-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425211454.174696-1-joelagnelf@nvidia.com>
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::28) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: 631b1f71-7ade-42c3-89d8-08dea30fc1b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5ouQF/zSbnOck+I2Q+i1Cbs936bpEVVCsXevr6bZRx38zWyJbvvG98/L1450JQilKNZpmTedf0od81uH+Zqja18o5RawvsCDL/A0I4Av57YHMh8QfW7yyju9uOfJ9HMItYv6t0d79RPaD53plpi+mD4qK6HWhFSCLA5LjnWk4GmU/ddKEIzhVvs9m//BVn3Hxble2OHrKQWaUQko2opRxZUtVzpTsGwU2Y7n/+92M3Jg/d4Rn/Yb+m/zhXag/cjGOz/ZCduLQQzF1arOt2MBqPwkWF1uIpTrEB5kYCAPzt7g4jYlAWWGH7ynH5fdUG15EKbqNtKW6gK06ECjGEoeyZXn5JI/YGxHXcboY9cxSjWXwRPaaPDyPPpkVkthqYzm5bCMMWsbBCN1cxhzvcIps9sggK5zHNsgaYDUyuR/HVfCSJI4sVnVjPij0oqcKfBnkJuWq/VBHCypxpW3cXt4qICdgRc/2l992wiDwfkBaK95sASCJKIvb9xmHX911oO1HPEvMM2BLggu06CYYAM7Q7c6Xqbkopt7KZxhvVUxnhirYSiByYQKYlH9fmiQkhupJN/V+Q8w8DXHBXRsGN3H2PehZEySH+tI5t3UyIXeiUs8zmh2zO1Ikpgm3qeIq2hSnrkAplkvsjAvG5rlpwtwfyeg9hEH36S4ytTPYexmxPuU2KSyqtPaPTu0gQU8VY1lVYFnaI6DEYCaMCcbaCIgPdwRSqxrIVIL54wNqInHLN4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E8KvmU7NzDOfPHlalmUmWUemm3qvmEG+vrR0dvdo3mS53GLCXqiv0x7ZcHVd?=
 =?us-ascii?Q?CJs0IPk3g6XQC4xE8QF9tSUF1g3FEl3ilzKG8ZnlMSQJaacpGfVn6WsoJ9P9?=
 =?us-ascii?Q?4HhYyWwCXrUPUTt2hhl7gM7ix+UTd1eV/sK4dACYg/cghC+gm9F1+zfAaT5i?=
 =?us-ascii?Q?F6pQjLBvu70h7j38nkigZRIgrp8BvX+eKWd1y42t5XCnl68YMPjF/B0UfBVf?=
 =?us-ascii?Q?Plh2BlrfW3LSqFC6wPOctqDaT3edzncmK2jq94Zg2u4wnb9y7D+TY4e0nXGr?=
 =?us-ascii?Q?JK5QI7P2Y9MdoEUdbsOQPD/g6YtgnmUhLSFxvfxCTkPHBNl7/XaHWJN/SBfo?=
 =?us-ascii?Q?+L1GhFXXZFvfhbAu1nMLV6rLsdrAlUn5BYROVybO39RnmUBY8zhVswH2nn0d?=
 =?us-ascii?Q?H1JWMnpIWr/fRtvUdFcwcPNrnbi+qi/GgczNdtPR+fhpN+ulodU+1t9xYsrO?=
 =?us-ascii?Q?/R7Z3FPr+G/KZ4Q+TI54Ve8dRHlLVEV/TpCaG5TlNBYy3h+OqaKIr8bLi7uC?=
 =?us-ascii?Q?QHxKoA3qP9w5iO9ajHEE0choLLOJ+BeMYG5Nv5a0z9GgG2azpxpW4KTpCy6E?=
 =?us-ascii?Q?BUvzwzS7oEXLZi4qMl0QSx6BsKw4YAv5yB66IVdQ9HhSZnJVMeKXPd4kXNV4?=
 =?us-ascii?Q?Wf0HiDFM10jnpCaWEmNthEfiO44VzPxRdwXg9sJzamEqtiVjK53u8JnGLzOZ?=
 =?us-ascii?Q?qR0BJvp9Uf3tcmydma2yn4AAwPM9ElCvmyvacabH8Sm6cZ2WjEGCMVhy2QQA?=
 =?us-ascii?Q?ZSbZZb/m3c0AFxoGJ6b3LeK+OuT2J/BxcdshLV/jU6f1VjGVlNTeG8bHKuaO?=
 =?us-ascii?Q?kNuu/qtJnVnsfrztr9CQkCwpCy61yF5H+qMth8QB1vPXTOKbE2yH2AlKcp86?=
 =?us-ascii?Q?mYCQoSsuojQhverxJCW4gvP2wVeOThDeU+ed6lHvQXOTX597P+JIrltdMUa6?=
 =?us-ascii?Q?nXbtyYJwIMNObECZrc2+rupCAexgN7Q5L0S8iOXABS8YD0LB8iWxJtPxsiyD?=
 =?us-ascii?Q?ca/bJqc5k1C1CmpR2qkAjzv+NcFCSPK7lTH0Rhbxs+L3Q5Mxeq6TAVAhoP0I?=
 =?us-ascii?Q?71vj7PMVvjaslIpVj5XtAsQLEZfsooW6nlYnNQ9otfw0shqAJgOHwyZExNDA?=
 =?us-ascii?Q?tSqd6otODy/PWhXqIHeql6+siJmNukZzj7MvTXeuYveHlOpzAg8Vq+UNYonA?=
 =?us-ascii?Q?78jeth5tXSEWLjjEQfGDIWe+gcw1nzce7LrHBkB54yBiJ+4DHYfyRq3ZCLze?=
 =?us-ascii?Q?8Kif3C/6dD4dkw1pEcfUKMycBsMww9RHJXO23Sw1XUrZZ0DyRl+WGzUw9rUq?=
 =?us-ascii?Q?PrjRai7ZwRSvmsCJ1C3gUN8RrOuhDPNkuHopSWCsHbpfW6TqXdrbCTFITur9?=
 =?us-ascii?Q?HNNHUoWIgcrDjH7ol/FwbwWAmowheFcnjP6wIx3s3fVlMiWD5RKAoCsbBpCT?=
 =?us-ascii?Q?s52nRZ7oaaMJWUSgEczBVr9dU/s2JeDds1ZKwa9uDVv27eKBTdmdQoTiKVEn?=
 =?us-ascii?Q?2lvqXHAsFUWNWmcT899rCxt5BxSg66oS+Aae8nWvKTD9pCSUuZ+exaKU9i9R?=
 =?us-ascii?Q?ixtv+DzI/5TljGAgxh4jqHvve+fCnvKija/pm7sj8pqT42lLwr75cu/5aVww?=
 =?us-ascii?Q?MK8ACKGYA+kXjD4F3Jg8B3TYHDAr11cdvA8stAJrQPc4dEafO7WE+ykbhFT6?=
 =?us-ascii?Q?EJq55r9UZQqaCCePBt/8/eWJqOKp9zaZIoiIyahVNuUOPW6j8tNSJBAAwQ4k?=
 =?us-ascii?Q?3R1c4FNXuA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631b1f71-7ade-42c3-89d8-08dea30fc1b7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:15:20.5153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQEVPvebKuVON1m8JAmmql6mS81K5wjUhKu8X80sz9JW0cFEYTG4Odk/O3bw0bbvFixMLFOl19+OWnawhKmx+Q==
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

Add foundational types for GPU memory management. These types are used
throughout the nova memory management subsystem for page table
operations, address translation, and memory allocation.

Cc: Nikola Djukic <ndjukic@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs | 193 ++++++++++++++++++++++++++++++++++++
 1 file changed, 193 insertions(+)

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 7a5dd4220c67..23e731bd7d22 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -2,4 +2,197 @@
 
 //! Memory management subsystems for nova-core.
 
+#![expect(dead_code)]
+
+/// Implements `From` conversions between a frame-number type ([`Pfn`] or [`Vfn`])
+/// and `Bounded<u64, N>` for bitfield interop.
+///
+/// Each MMU version module should invoke this for the specific bit widths used by that version's
+/// PTE/PDE bitfield definitions.
+macro_rules! impl_frame_number_bounded {
+    ($type:ty, $bits:literal) => {
+        impl From<Bounded<u64, $bits>> for $type {
+            fn from(val: Bounded<u64, $bits>) -> Self {
+                Self::new(val.get())
+            }
+        }
+
+        impl From<$type> for Bounded<u64, $bits> {
+            fn from(v: $type) -> Self {
+                Bounded::from_expr(v.raw() & ::kernel::bits::genmask_u64(0..=($bits - 1)))
+            }
+        }
+    };
+}
+
+/// Implements `From` conversions between [`Pfn`] and `Bounded<u64, N>` for bitfield interop.
+macro_rules! impl_pfn_bounded {
+    ($bits:literal) => {
+        impl_frame_number_bounded!(Pfn, $bits);
+    };
+}
+
 pub(crate) mod pramin;
+
+use kernel::{
+    bitfield,
+    num::Bounded,
+    prelude::*,
+    sizes::SZ_4K, //
+};
+
+use crate::num::u64_as_usize;
+
+/// Page size in bytes (4 KiB).
+pub(crate) const PAGE_SIZE: usize = SZ_4K;
+
+bitfield! {
+    /// Physical VRAM address in GPU video memory.
+    pub(crate) struct VramAddress(u64) {
+        /// Offset within 4KB page.
+        11:0    offset;
+        /// Physical frame number.
+        63:12   frame_number => Pfn;
+    }
+}
+
+impl VramAddress {
+    /// Create a new VRAM address from a raw value.
+    pub(crate) const fn new(addr: u64) -> Self {
+        Self::from_raw(addr)
+    }
+
+    /// Get the raw address value as `usize` (useful for MMIO offsets).
+    pub(crate) const fn raw(&self) -> usize {
+        u64_as_usize(self.into_raw())
+    }
+
+    /// Get the raw address value as `u64`.
+    pub(crate) const fn raw_u64(&self) -> u64 {
+        self.into_raw()
+    }
+}
+
+impl PartialOrd for VramAddress {
+    fn partial_cmp(&self, other: &Self) -> Option<core::cmp::Ordering> {
+        Some(self.cmp(other))
+    }
+}
+
+impl Ord for VramAddress {
+    fn cmp(&self, other: &Self) -> core::cmp::Ordering {
+        self.into_raw().cmp(&other.into_raw())
+    }
+}
+
+impl From<Pfn> for VramAddress {
+    fn from(pfn: Pfn) -> Self {
+        Self::zeroed().with_frame_number(pfn)
+    }
+}
+
+bitfield! {
+    /// Virtual address in GPU address space.
+    pub(crate) struct VirtualAddress(u64) {
+        /// Offset within 4KB page.
+        11:0    offset;
+        /// Virtual frame number.
+        63:12   frame_number => Vfn;
+    }
+}
+
+impl VirtualAddress {
+    /// Create a new virtual address from a raw value.
+    pub(crate) const fn new(addr: u64) -> Self {
+        Self::from_raw(addr)
+    }
+
+    /// Get the raw address value as `u64`.
+    pub(crate) const fn raw_u64(&self) -> u64 {
+        self.into_raw()
+    }
+}
+
+impl From<Vfn> for VirtualAddress {
+    fn from(vfn: Vfn) -> Self {
+        Self::zeroed().with_frame_number(vfn)
+    }
+}
+
+/// Physical Frame Number.
+///
+/// Represents a physical page in VRAM.
+#[repr(transparent)]
+#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
+pub(crate) struct Pfn(u64);
+
+impl Pfn {
+    /// Create a new PFN from a frame number.
+    pub(crate) const fn new(frame_number: u64) -> Self {
+        Self(frame_number)
+    }
+
+    /// Get the raw frame number.
+    pub(crate) const fn raw(self) -> u64 {
+        self.0
+    }
+}
+
+impl From<VramAddress> for Pfn {
+    fn from(addr: VramAddress) -> Self {
+        addr.frame_number()
+    }
+}
+
+impl From<u64> for Pfn {
+    fn from(val: u64) -> Self {
+        Self(val)
+    }
+}
+
+impl From<Pfn> for u64 {
+    fn from(pfn: Pfn) -> Self {
+        pfn.0
+    }
+}
+
+impl_pfn_bounded!(52);
+
+/// Virtual Frame Number.
+///
+/// Represents a virtual page in GPU address space.
+#[repr(transparent)]
+#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
+pub(crate) struct Vfn(u64);
+
+impl Vfn {
+    /// Create a new VFN from a frame number.
+    pub(crate) const fn new(frame_number: u64) -> Self {
+        Self(frame_number)
+    }
+
+    /// Get the raw frame number.
+    pub(crate) const fn raw(self) -> u64 {
+        self.0
+    }
+}
+
+impl From<VirtualAddress> for Vfn {
+    fn from(addr: VirtualAddress) -> Self {
+        addr.frame_number()
+    }
+}
+
+impl From<u64> for Vfn {
+    fn from(val: u64) -> Self {
+        Self(val)
+    }
+}
+
+impl From<Vfn> for u64 {
+    fn from(vfn: Vfn) -> Self {
+        vfn.0
+    }
+}
+
+impl_frame_number_bounded!(Vfn, 52);
-- 
2.34.1

