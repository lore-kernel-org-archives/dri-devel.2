Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCD1CD4F50
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30F5710E993;
	Mon, 18 May 2026 18:11:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="KDlH6UnE";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EBA110E993
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:11:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJobzu0qW9O9nPsk8ZPQP8O1x7zfryZKKyRSyEv/y+Q8ltS2aZWVyV4KUT5z3XIP794ztfnF8qWgLLDTM5JmS6Q3LEt9BLse7LMku9IsMzqJCSz82BoJw3hcq+vq2cSDZvS8oV9KhhnWCSB+Iy+xdgQ+VF80w1Pm5dshE/FYFkZtRqddhTeuiHtLqif7pjmuuH0eFaXyZrHh2TgOUh95pM+JhomhrR1aCTxO+GhNsf0EGHMgMmf4nTtZY40ov8Piab0olHZJOagbaVzyYlynYNR9KJpk0rJSN9rrTHbEF70/I2164IbwO/eP1IgzkGL2bBz7nj6qoM2i7mgxdQBdNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6S2KH6w/zrdv19rnKvwHd6ZzEwVaekAWzZXQJtGYmo=;
 b=X4qwwZT2sU5QdGNyh69sFGEWEL7KZnyohX3DhmbWvZqh8GAn6nqBWXVpn84tw+5JTtzg3p/nbjew7NYQkmYBRRMpqGuN0C71RD7QX9NYU3yiLcYqgSVO3X/1PgejX8oU1F65vZU9YIWbhGtmSBCJlr9lU3dV3iK2AhvUQxygytaSH0yF7G89pDsGFo40VI5+9SVpLb0GyDU8MJ4NtqZoUmPl6jXjMmkjq3RG7V3C2MepiM5GJxnEGmbqLd9Cc9iw96xepXGCHxuSwMhxmTqDCtYxzVgKuic/yXgtzAyW0XL86pI8p29YLNczitO3k3E0l4UuqcwUNBlQKAyCXtop6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6S2KH6w/zrdv19rnKvwHd6ZzEwVaekAWzZXQJtGYmo=;
 b=KDlH6UnEsbeaFmLBFrvrLhGiUAn1WGKqHHGJgEc1RCVjnyGykr7Trp5LppcNFkzfAn1FYDBF0jydXPLmyWdSOQVpX1zDNqeQpSU1jB/X1zX1b2aP+hMFLj33LxafbvLozp3ARr38st5+HLp+HIG1PxIgYwkZ/h6niuzoK4RbQew/paqm325fZrZxKZLoXKsmLqFcqswZQNNOf2oJXOqzki90b1DeAMdyJJQiO7dN/kDtWiyd6DP6POaZhXdETg8aoI7+nI8aW8aDcJ7Vd3HRI81B7mLPyVrmSVMa4KmtOHyN3vCL9/+cf4D/pZ+V2e8E/lKxjv8wnLEBGfeLfwgt8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CH3PR12MB8727.namprd12.prod.outlook.com (2603:10b6:610:173::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 18:11:49 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0025.012; Mon, 18 May 2026
 18:11:49 +0000
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
Subject: [PATCH v1 12/16] gpu: nova-core: mm: Add virtual address range
 tracking to VMM
Date: Mon, 18 May 2026 14:11:21 -0400
Message-Id: <20260518181126.2493572-13-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518181126.2493572-1-joelagnelf@nvidia.com>
References: <20260518181126.2493572-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0018.namprd08.prod.outlook.com
 (2603:10b6:208:239::23) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CH3PR12MB8727:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e3ffa0-f8b6-4448-cf93-08deb508ee01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|11063799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: rhrSqQ6pNLuA+N/elYjjaWcFmZB39NhsQ3eClrPCaT33BbHjBl+dz0L2AjrJWD5YB9ajbDX7KjYgMp2PopJ27i8aQi9vJhamV48+eT3rWQo2+nPFUHrcVm/GFoq+26kZQ/fYQTT3ukx8Ch1+NG8goiElz+S3LkfuV5boH090T6lkU/lBKpcz9QA6koVcumeijSqkVNExdKdekWBGuQkYUramO4GQBZ+xMIvdUYvVHtncz6VJjkxm33SThHRCD9Tgl42KYreXq1drmLTKMXojBhCmHEIyJ5QIdBdEYBCveI0b1BNtPrHde75p6cjyk49nwTzYLm2EIJKD1zFux/IK5/gyzYaaq1u5e39t/ZGMvWWTu6/WfQVseEkPSREGp34x714r3ctqAjtNi+kZGdH7uUNNcFiSMb+2TGcjnzAzdcC3lkLhZWwIJXZ4josMhcD22YtN/e16Yfvrak5V68BtHoDCM3Baz6tQ+NTkFtKXRgtoOQzFQy8YGIXmUDifbUBmHeGPcgH55ZEPiUrHoAQPXitRfbJS3MsvXX0d0v3hIE1PYGf1dcSn0bu/pVuQo/XRimfYQ7fwUu+ajOQ7AmiFL0FiEGX7jjEyq4m3LwMuSb8dHF2ISAqtR3trFzRxnjtd3SJeexVkb0vLdWp/RwNJK61qnZ7Jb5lw2jQVOJHw0mMW5K56NDac+wnW1jFPiPmr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(11063799003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qPgVESmApfI6xfFkpc7/tgseDEcbUjxgGYh5aSSmbc7bRSEwyWlWD0eawffP?=
 =?us-ascii?Q?D0AKkkW/Fuq72kUMvLvu/qixy6hhfb4zknA6/egzhiynF+9HNBwV2C1rf2ui?=
 =?us-ascii?Q?Hj1OiFAvVjoTo9s50V2Es6t2QQioL9yaS59bhl/VFmKYhTbxc87yIBDuROvR?=
 =?us-ascii?Q?JZdMAFzEX8M+iDUCiOqJyxWz3GdmCrvnAygmTUjufP7NTWytk8q06VlGqHyp?=
 =?us-ascii?Q?gWDSM37wmBnzyKvay8ikKD7MTQTcmbyLznvVw6znN6thAMJJbC5n4OslfKCe?=
 =?us-ascii?Q?1TEAeEf5+l7dDImqEI19RyLEY3PCdcewMH8reITXgHi/ADlCuIHNyn5goGWK?=
 =?us-ascii?Q?cLmEqi+w57QG5UIQBZPFn+9bzvRQyCzkfR1tvlhq5J3gcajsXrnlaHy15tRX?=
 =?us-ascii?Q?xMUXwW9US0u2grO9t812KT1MjQ7KIPwVMVxg7z/vb5tnYoUzM/QJgO8LAw3d?=
 =?us-ascii?Q?5ZLBEdqi1J24UiGK7+PchYqRoQT6XPmpTtWDq6BzJN9kqi/JRaPvPkXGoT5Y?=
 =?us-ascii?Q?FduT5lFBw6JDhkzQUopQyWuOzLJfMACGDSLo87xvi0MtE+quTMSpbumFr6mY?=
 =?us-ascii?Q?ZFCZ4T46I6x1vuODXGWaw9NFG0HunG2Ndr2Or7BcaSEopOZTu10xxttveJAL?=
 =?us-ascii?Q?hNo1gWRmL81x07FNRkFvVCm+YCTThajBrbNXjLbYHsciZbvHDBgaLnJY8TFh?=
 =?us-ascii?Q?5MTwMtUr0hzbsK9sGfNgFQc4ATjic4sG4z00Q/5O+xOPJevc005XW5JK490q?=
 =?us-ascii?Q?b9zS3Yl93rytM7hKL804k+63kOUPgUPfmdZeR6WE/2A07yAz3kfaVO3MSRPW?=
 =?us-ascii?Q?aGqCpVFmuP33F4Q7Ajk6yun/fVbXfMxK7HZ9vLtHgjcNhz2IFPkHGpn/LYXx?=
 =?us-ascii?Q?r+5/VEJ6yycVURyj9jKMBrx8StRXKpCgNLcdt4VwzgsIo7gME5Z7XZOL+E1e?=
 =?us-ascii?Q?2KlVBzWVxgQMVE4VFD0+GxSU7tJFKFr0oc2dA1vO9pgP7hzMKhw9AfD+KzSs?=
 =?us-ascii?Q?q7R48uDIt3pDMq1v+5NYtUh4OHXEJpTKnX7/W5NEFXqxRgud/L3RslctMSAo?=
 =?us-ascii?Q?PdDR8FGzdIcYzWTo1xJCX5HQDIuvHWM2B1AlXOgkZf9hFS2j77eK2EXXkDDg?=
 =?us-ascii?Q?482edjzon+hOERVIpfuXwmF07YfaeMUX1nG+IkGvBqHO7Sj3Z+lbtH/dn6JG?=
 =?us-ascii?Q?IrWD+gnThJ3decrxc1FxHOH15q9elw777okCh/MVkJtnAJMq0P2EYf0dFG81?=
 =?us-ascii?Q?xjXwYQUv9af4B1EcPWM49JaYBnJiV7kMxDkyqTKCTO9OwF7kmzjHAHiNOHKn?=
 =?us-ascii?Q?bn6vZMlgWsiboWgTBSduXvAKmikhIRQPJ59ItUmAX57wLgT34VBI5Vj4m1Ui?=
 =?us-ascii?Q?yJP88bXjtp18Hc9R/GZuIj+t8VJLaIaJgKgd1dLugA57DftIJBCrpcXGu7bI?=
 =?us-ascii?Q?xW5cGWebdLlnASKIWkOen5jv9zwcszbLI6mmrTBHpo1V+eNK5zaS20tYuYZL?=
 =?us-ascii?Q?Ve+ggEenuKWDs/J3oHOTCo811egdD7ueC+LdMN4uZmUTU2oHAJ8RcJVB2YxV?=
 =?us-ascii?Q?RShFPzDPNiV9Ntvhwk7G6JZPfhbwyuP2nVAkzme1+gjAKor8OeTaJ0kAvdhY?=
 =?us-ascii?Q?Mdv9K9m7LxIs1z6IeEi0y447dEiX+uOQNHlMhl9oT7O0il8JQk7+dKQ1eR6/?=
 =?us-ascii?Q?+dCXdNOEGv0xs7RmbWwUB+odn+Rv0eFY4cYF/4yKyH+ksspzYUwVaN8n7XWn?=
 =?us-ascii?Q?3i4F4cFqbA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e3ffa0-f8b6-4448-cf93-08deb508ee01
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:11:49.2068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b6TwrnKoWZyK/cVR02GZlethQUi6xbU4RuM7xWo/BWBDxSS6iQpQ0Ifs7qYWxb3CvVu3kZVwtMbYu2kXIx/2Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8727
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

Add virtual address range tracking to the VMM using a maple tree
allocator. This enables contiguous virtual address range allocation
for mappings.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/mm/vmm.rs | 83 +++++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/nova-core/mm/vmm.rs b/drivers/gpu/nova-core/mm/vmm.rs
index 3e18adc23b68..05ff77c5f888 100644
--- a/drivers/gpu/nova-core/mm/vmm.rs
+++ b/drivers/gpu/nova-core/mm/vmm.rs
@@ -9,18 +9,27 @@
 use kernel::{
     device,
     gpu::buddy::AllocatedBlocks,
+    maple_tree::MapleTreeAlloc,
     prelude::*, //
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
@@ -35,18 +44,74 @@ pub(crate) struct Vmm {
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
+    fn alloc_vfn_range(&self, num_pages: usize, va_range: Option<Range<u64>>) -> Result<Vfn> {
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

