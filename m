Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE99FF885A
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 21:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8332010E496;
	Sat, 25 Apr 2026 21:16:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="KWF3rHGw";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011015.outbound.protection.outlook.com
 [40.93.194.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8767F10E496
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:15:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+rbI0c1YbVLGjSEzw+zuobPB+pU//bizD8IZViyNj3b8RPdXlTAxvYcXrC/SFOyqnpvAObBcqOZ4UloXTBGWki8BkxcrnQcM3geS3jgubr5JGSvwZkizLuh1ALR7WFw4a5QOPCKc5dFNzUtzo/LjYNYnfnS7gR/vKhfrvqDwIpes8HBrGiQCaTOSxHmIXZSb/xCvJPD8bN5FZwGATlL+2o426MfY4UzIWzZnyNF8JyfnseaSG3nm9uW7I6iW2C2bPYA+tFX05HLU8dCw0SzgUXfEj7lPYMwuaxT/6c4KLw0NzzczQFiIF6P6rwvKWU/ITDM5eOzt++G8H8l2id7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTxAbb20E9XGeOsT7WvzLc2cxjknHQ/eVyCvPQsn7A8=;
 b=KGg/ONjqWhZDLvAIQkqjrdmaa2uUe5yScGiYa11ZCrRcxExF2q/jmAn7D+8CazrRjzc8CY899QMVChOVblhi3M0VPedIMVd0XFIIXCF5540bhj1nhYmcexcEWKn2mRYVHJHPio0e0qQs9zqYFoEoXP9o30mSWvCz8fiBfE27C+9MeD0zBIGEU8ch5GfRaD4iBHHRaAHFcKs+dhzY0HlvCGTSkaRg/Yb0WH46jeNzN6H5OiY8/ySwO143xAe2zJfeRB7qK4U2lqW03t39/533Cx/4YROS4hq1s/3iQzI//aXYzeM5gvySPdVILOsnUBKsGqrvTdoDQVOkmzWpaUzTvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTxAbb20E9XGeOsT7WvzLc2cxjknHQ/eVyCvPQsn7A8=;
 b=KWF3rHGwdLELzrao5O9Tz8bG+YafJ2m/3pcbEZIsHx6+eveLrDCzaiLaGUhe3f2NXlPQEMEJu9S+saZzIpzRSsn5/DpuHgQyjfW1Shxv+Z/AcmhSWcPz9+quEFiVqYvlo3TnUX8XErPBW+8sd3Bu5AzzovL/uaH/6plnpT1N4nxIL1MtMNjFskeaHflRBvElLX52I6pLykd3N5RWYCzL6Tt7X36Z2OnIB8QXTxpisZiHn3VVySB309g39qE5cbuy4XMCXi41BMiBChZglHW33Y/vd+U5PQxzdxwjn+FrLCwkzpcmJPWAV3F/8GGf+6abOPxeEwKfWpojBj1VdH5yBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Sat, 25 Apr
 2026 21:15:41 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 21:15:41 +0000
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
Subject: [PATCH v12 15/22] gpu: nova-core: mm: Add virtual address range
 tracking to VMM
Date: Sat, 25 Apr 2026 17:14:47 -0400
Message-Id: <20260425211454.174696-16-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425211454.174696-1-joelagnelf@nvidia.com>
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0242.namprd15.prod.outlook.com
 (2603:10b6:930:66::18) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: bae8dcaa-c15a-4243-cd44-08dea30fcdf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZkYIBgAagLTcRb68jzi1OjBmoNs0DHNafUzitkCbIbNhzaqnKDDhgPdJtEcY9XyAiR8/eSKVdh1+MoCUJYjLAHEagBdQKORfetbmVJvSqmaq+XlfQ/2QrajEOW3rDXpr/XKRL64QBJ/S1ZAU13p5/hi9dF8fT+hh5bJuiyIVt8/e4KaoFRnlHsBG3Cm2QvOFl9hmfS8O9sUPr4iikGvqP23j/1M/681bD8M4t7SzbyA954KCVHQWi+5tQvpH4J3AbqYHoYi2wVoSeOazEy0o6zUig+p1445ctiV7xWQQDhdu4F4ey/TRMmQ/Li6805EJwjwQgFjODiIgu8Mo/IShhkbgR/V52bwqGAH78adaelE4Dv5u70zEPOtdArjiGWrRUTWZgvKSMJdTn6QAEVwhU091UjllpNZyv+r4BTDj2z79cWhHEISdnZVO/gNSt7mWYx/eMUUnPlJJZMSvYqD/OrzT2iQtK44HsXTjv7mRy6VZt0BSphwFx46JdORLVJ9pC1TLVoct1LZGiWLGOfhvFCg23AHMYSTed/QlNJqQmG9H9shJYQWorWY03CPQ8g/LuBn0E+JWZAfTW+gXKjdRuFzab4gFLh5U55u5cqaP8SfUHr1GubW1d+9qUNDqFE+CLJwvriZZE1+4bSDp1H0KVrzUCWszaLsnX+9NMphQ1PbgvIGMkaXnlfl9vURvZkbxntCfj/aOzDBB52z/IOTcyzCyNSo7hfbLTfON79dcyPc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vH6U85vruhGwKzWn2MmtVzuSh/Vzxhr+9RQMpiDlMbizhpd/ozZ1mbfU7+9/?=
 =?us-ascii?Q?fnsIwDaBMLQdlGVVYxUXu3/XunHt4t8YDVT3Y1oWoxKPanXLz2MeSg6a41Yp?=
 =?us-ascii?Q?MppaD4zDmDY5Zf3fZS0VTSIxFQpZoh2SwqdNmNaRim8LhFtJFjJ7db8MuNZp?=
 =?us-ascii?Q?FZPuHRNXlo7n0gElrm3vlAIMixZhSLzomLMnMZXgKmYgImrWKqryJ1HG6gzH?=
 =?us-ascii?Q?/4+1YvRgSXPvbTOOuckKQidSqvRW78pjlcsoNjufQWUnv/Ox2pMTbmodMomi?=
 =?us-ascii?Q?2Bxoh899AFi7IjXeIbxr/8Irt3VFOaMWsL+W4QPWb7BlS3xLM8f3Bmqoje/2?=
 =?us-ascii?Q?HWhU9sJX7ssLtZTH2OX99TRu4EbksPWVLzcVqcFPIm9jh9aeI8of8ZjfIOUF?=
 =?us-ascii?Q?NHb89yhAXQ+6ZqPUoF4M68ru/2ijmgNhuvffNV0EbxWmhF5PhPjzfj6xQ8M6?=
 =?us-ascii?Q?9tBntyxlDCxlPQWp5OryifCPe+PX+vJv4VohZTFHRmsqq+uzJkQlniL/Cp9W?=
 =?us-ascii?Q?nCst8/FwSbPP/BWB7qaZBdgY3ZyEcxUTssFB642dG7WKf7NrFX3l5IA36ZrE?=
 =?us-ascii?Q?Q0MsDcHx33hJ3Oqor4xpOOBQAjYaAYOF+RCInTGItZ9zHiUaUxd4PLJYSg+2?=
 =?us-ascii?Q?uJdddkxXYRrhO7IrI32NZI88Bc2JGUolasp/qTlzFqzi4nm8dqKLnckNsAYR?=
 =?us-ascii?Q?LAGe+zxZLNtDwTzTdZPD8bC2EtkZZq8ixp9V9T+4nEgdgZqYCai2X/T8wBWK?=
 =?us-ascii?Q?LCEWLMuVLIUBrQRJrwuWOe0K1BxnA2pVnSBzN2ldOBKMPwtlcAeVYEN56eBZ?=
 =?us-ascii?Q?znh0anBdWbva2Aa45gwKfJmanihmhHfaFYn1NiMwVelpAO10KwjoQ1C2atat?=
 =?us-ascii?Q?381BiACXkfugEaSimjaDhe4FxS0JqHyMNJ0e+CVfwqSbMhMImX2/xJhGhwuC?=
 =?us-ascii?Q?lzeCaSghEsy1GWKp5x1s0YRFdzS/xg3o6AX4dmmJ15+zdpAzNydtpHJPeS/U?=
 =?us-ascii?Q?P3kf6WkdmSxUeoYIWs92KnQh2U3v3Q0n70PoD7eBz3kkXWhZ0POMqkiR9YL/?=
 =?us-ascii?Q?uIo8ANPT06fd3qz8Jp4pSRNTip0glQrhVb6ta/E8lce0a6/N+UQ74uiJcfuN?=
 =?us-ascii?Q?k7Z7Swh92cEtTU3x9qRCNlurO0GpNjmwkNOk/yVT0UxljSHQQGLZs1fY8UwT?=
 =?us-ascii?Q?LdJvNhJ4BCZRYaREL8yenqFBZypfBJ11FPHBHx4OjG5+aoS5PYIG3lEKsswf?=
 =?us-ascii?Q?eSChCfK++Cnt+Kr4wztScPS4nDR3LZXrVURrJI/OLsFPO9FI2yClNhCr1Yan?=
 =?us-ascii?Q?eMzt2PPUKvyn5RIepM/yStu5LouE9ao1n3l56g4Lbe57Q6LDkGf4cXF94vmF?=
 =?us-ascii?Q?vME/nvoXqa71vPIw9yKRGp0B8xk50aJtw+Hefw042gvjgwpMnFIFHS78eDxA?=
 =?us-ascii?Q?d/d4tTSdN7caMR4VwfJGO0baslaC5jTIff6JSOjyGjyyeQ3YvY+jgognsbls?=
 =?us-ascii?Q?6tDTQPSVrlnq0++AWNh4tmWIJ1SvHeqv90IbI0/okK2ks9JuXIxCRGigd0yY?=
 =?us-ascii?Q?NeJzVeOa8VXHMr9TD2++oRGh7xIPekqhHHT/LfrBEdkwMA0cJQO5liEGHmDX?=
 =?us-ascii?Q?pN2Ge4Lj5ULtXROESZ2tv7C9091EUhDZMQC5H3sv1r5HzuFGZ4Kwz49Ao/ID?=
 =?us-ascii?Q?pIN9vatpuJDia/tcrUsCM5Uj99Wfjx9SdWsNj49el4Ro/6sl1LXSQngFZ9oW?=
 =?us-ascii?Q?ygol2Inv0g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae8dcaa-c15a-4243-cd44-08dea30fcdf4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:15:41.0085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AdVUMPSL90qshBYe6EzAWomTCgv05awNOZd5fV85JWn4iZYOlyiWEGejP0GwJPLOTSWjyu4p8mSffm519+QIzQ==
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

Add virtual address range tracking to the VMM using a buddy allocator.
This enables contiguous virtual address range allocation for mappings.

Cc: Nikola Djukic <ndjukic@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/mm/vmm.rs | 89 +++++++++++++++++++++++++++++----
 1 file changed, 79 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/nova-core/mm/vmm.rs b/drivers/gpu/nova-core/mm/vmm.rs
index 7a2ab2acaa9b..81ae08ce1cd7 100644
--- a/drivers/gpu/nova-core/mm/vmm.rs
+++ b/drivers/gpu/nova-core/mm/vmm.rs
@@ -9,18 +9,27 @@
 use kernel::{
     device,
     gpu::buddy::AllocatedBlocks,
-    prelude::*, //
+    maple_tree::MapleTreeAlloc,
+    prelude::*,
 };
 
-use crate::mm::{
-    pagetable::{
-        walk::{PtWalk, WalkResult},
-        MmuVersion, //
+use core::ops::Range;
+
+use crate::{
+    mm::{
+        pagetable::{
+            walk::{PtWalk, WalkResult},
+            MmuVersion, //
+        },
+        GpuMm,
+        Pfn,
+        Vfn,
+        VramAddress,
+        PAGE_SIZE, //
+    },
+    num::{
+        IntoSafeCast, //
     },
-    GpuMm,
-    Pfn,
-    Vfn,
-    VramAddress, //
 };
 
 /// Virtual Memory Manager for a GPU address space.
@@ -35,23 +44,83 @@ pub(crate) struct Vmm {
     mmu_version: MmuVersion,
     /// Page table allocations required for mappings.
     page_table_allocs: KVec<Pin<KBox<AllocatedBlocks>>>,
+    /// Maple tree allocator for virtual address range tracking.
+    virt_alloc: Pin<KBox<MapleTreeAlloc<()>>>,
+    /// Total number of pages in the virtual address space.
+    va_pages: usize,
 }
 
 impl Vmm {
     /// Create a new [`Vmm`] for the given Page Directory Base address.
-    pub(crate) fn new(pdb_addr: VramAddress, mmu_version: MmuVersion) -> Result<Self> {
+    ///
+    /// The [`Vmm`] will manage a virtual address space of `va_size` bytes.
+    pub(crate) fn new(
+        pdb_addr: VramAddress,
+        mmu_version: MmuVersion,
+        va_size: u64,
+    ) -> Result<Self> {
         // Only MMU v2 is supported for now.
         if mmu_version != MmuVersion::V2 {
             return Err(ENOTSUPP);
         }
 
+        let page_size: u64 = PAGE_SIZE.into_safe_cast();
+        let va_pages: usize = (va_size / page_size).into_safe_cast();
+        let virt_alloc = KBox::pin_init(MapleTreeAlloc::<()>::new(), GFP_KERNEL)?;
+
         Ok(Self {
             pdb_addr,
             mmu_version,
             page_table_allocs: KVec::new(),
+            virt_alloc,
+            va_pages,
         })
     }
 
+    /// Allocate a contiguous virtual frame number range.
+    ///
+    /// # Arguments
+    ///
+    /// - `num_pages`: Number of pages to allocate.
+    /// - `va_range`: `None` = allocate anywhere, `Some(range)` = constrain allocation to the given
+    ///   range.
+    fn alloc_vfn_range(
+        &self,
+        num_pages: usize,
+        va_range: Option<Range<u64>>,
+    ) -> Result<Vfn> {
+        let page_size: u64 = PAGE_SIZE.into_safe_cast();
+
+        let start_vfn = match va_range {
+            Some(r) => {
+                let num_pages_u64: u64 = num_pages.into_safe_cast();
+                let size = num_pages_u64.checked_mul(page_size).ok_or(EOVERFLOW)?;
+                let range_size = r.end.checked_sub(r.start).ok_or(EOVERFLOW)?;
+                if range_size != size {
+                    return Err(EINVAL);
+                }
+                let start_vfn: usize = (r.start / page_size).into_safe_cast();
+                let end_vfn: usize = (r.end / page_size).into_safe_cast();
+                self.virt_alloc
+                    .insert_range(start_vfn..end_vfn, (), GFP_KERNEL)?;
+                start_vfn
+            }
+            None => self
+                .virt_alloc
+                .alloc_range(num_pages, (), ..self.va_pages, GFP_KERNEL)?,
+        };
+
+        Ok(Vfn::new(start_vfn.into_safe_cast()))
+    }
+
+    /// Free a virtual frame number range back to the maple tree.
+    fn free_vfn(&self, vfn: Vfn) {
+        let vfn_index: usize = vfn.raw().into_safe_cast();
+        if self.virt_alloc.erase(vfn_index).is_none() {
+            kernel::pr_warn!("free_vfn: VFN {} not found in maple tree\n", vfn_index);
+        }
+    }
+
     /// Read the [`Pfn`] for a mapped [`Vfn`] if one is mapped.
     pub(super) fn read_mapping(
         &self,
-- 
2.34.1

