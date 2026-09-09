Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC54FC79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:00:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BAF810EE8C;
	Wed,  9 Sep 2026 04:00:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="d9a39H7A";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010023.outbound.protection.outlook.com
 [40.93.198.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8598710EE8A
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:00:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDJ5j1Ew4qjqZ9C9/aq0oc3rktN2vuwbtACIXbMdAS2ujkycz8WR9vkHYau2mv/Ecs+jlRpj2kX6fZQoSBr+zY1/ZNgu3aliw7sM2LdCPxi9XkpKmkqqoOvceFf9OgaviJWRbMcxz5FIFONkhiRqldx/UQ1VCYZJRZW9gjd0KkdkIsOYfCmNHw+XcBbWOWUW+bY5bxYwdYdFxHfznJATxUiYDiOVRBVMwcr4e0QbwGZVxuh5MT801umU5FWEnGMKrWnEwFMDaK1mLoVWXmvmMDOgV7x1lfSd3CF097JN/5f3lk6tpMDWEoKcWjpZTjFUoFaDoga4wy+Cp4qf2AOhgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ge1rr+fDkU8vZvZvm2ZD4imc4OicC9I6WSnqFT3xFT8=;
 b=PIUZtWW98DxbjZIp8/s0xCaU1SgMIvhRW1j/xE3tCEflIjnJzCtU1JqIKMeaoszIFrMECzrI8MxplUjkVcuCd/PwTJiWd8cUfZZmKO8oNMJyvrle7ZmdUz3Zu2SUoSjU0vXwitPXJtQW5PQLPyiGavomwacwWdd12pNJVc/MdXfmwS582fvtDTHbcNs8QTcE8zsPNVV4YwC+0uc8/7ngnQQ+2uc4qDEpE52ZQfwgWQqpcMZ/WkDyzRWL9+GP4eiI6E428xV3M4VlRVRW8RnA8Zt1anQA1D7CBAhpubQDNP7yv3n46yfNHVRy2LHmm7/J4p+kJFgiQRsveA2/Ke3h0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ge1rr+fDkU8vZvZvm2ZD4imc4OicC9I6WSnqFT3xFT8=;
 b=d9a39H7AxOYAGRxZ/VSwDO6CTtL/DGx3GVIpq+RoGC6D4O6uDaZIaXAohrcH2L9Z3/H5bzSVf92rUOMCqF22k8wGVk5xJBcBKjcwevuOQOrUOzZpJjQKJ6GigIxwkoDHG5GJ9PGb1y24nn35cfrKI1fbQ14nJZAmsPAuXb6p7VYRi+I96dOjGIVHWa3m2TEnx8QgaRpmpmADpogbfCg0l9+XMw+SmNbFbI7hzuSFLducRVZDZ8cgN1xX26vIJNHb7bZAC0VTpwWEAgv8mlZahuevIdV/yf2O68mGOWLtrERCFYmYs3TEEJr/YYNPR6bhWa1pVCkFJeBqSRlnIbbVtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA3PR12MB699018.namprd12.prod.outlook.com (2603:10b6:806:510::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 04:00:38 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 04:00:38 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 09 Sep 2026 12:59:50 +0900
Subject: [PATCH 12/16] gpu: nova-core: mm: Add virtual address range
 tracking to VMM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-mmrebase-v1-12-8dd5d4225d2e@nvidia.com>
References: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
In-Reply-To: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYWP286CA0003.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::22) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA3PR12MB699018:EE_
X-MS-Office365-Filtering-Correlation-Id: f615b77c-b541-48e2-f173-08df0e26e8a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10070799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: flC2NY0w7+x6HFQYe1hnW76S1EuUAelx2uFFbyP+Iawbvw7414q54oDZ0NoOxmLA0qtcPO606/ixA6uo1qUECPkISS2akK1TaySBPTS0OD9LNJarsRYA+CcFWSCU+BtpvBSCtq5Uz1fkfp27jgTOWdCVAB1Y+nobWQjcgZZcgMM5BpeHcs0HVFEO+x3AAR3GQBPQLVxZnGQmcjA4LJKnTRamaCqjD8oX377zjRWl3MMj4JKwkdTR15G8pN2Gf3AKzrTVXabnP+sdN+tcUR+DZfrC1AFYoh0ZE4+fDranYst5dZ7YuOfE/rcXZ3Gb6evB07hj39XoEtJX7p0BHlJr1XwPjnopEy6W1YRuvXKSH9Z9CUyD6McS1fQj2+AqfcMeUJ4lBw2WTmUUvmhC5avdCzNhc8jfmDC2w0E/FKMPIrh7/gM8gNsfafx8KOKi0nJOo0WQYAl49p3VLkWd58i7YN8WkhE1Jo7DnU2dzTCQfNmG0mKFf4pZl3J/2FrMujtg6xZHQa08vG75uFxtcbTA/Uxwy0klcFA0j8e7mmNEue+WPLUhETKS4r9NR5dhGrOqVOT2YBbB7evqy9QON2FrzcdrLfW4DPp5DkWplzDfW6Itx//VqGzi0ko9f/eKQpo3Lsi/GQW19c0hosqtb1pZJFpepfjms8OAZ3rm63eqboY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXlpVUE0bktTOXhwRVBDVXp3VGpUM3Vvb0dzVHpDNXV1d1JpYWtWTjFwbmdG?=
 =?utf-8?B?OTFubE1VMzdrU2tRSXlzWmRhMm1Yekp5Q1MzbnJwMnZWMWt1Yll2SzQ0NlBS?=
 =?utf-8?B?eU5ReHRhUlpMVWkwbVRJRkY1RjU3MThiYkpVNmZNSFY5MlhacUF4MEV2Qk9q?=
 =?utf-8?B?WDlZZytyOUo4SnI0T2hzN1dMTnVyWWJWRnZ4eU5ET3c4cTZCdVI4NkF0MElk?=
 =?utf-8?B?M05wTldqdDMxZlhnMG0rUHBkV1ZtdWhuVkFSUE1TVVloT3FBVWRiWER2RS9y?=
 =?utf-8?B?Yk0rVm43dXB0ckVzank1MnZZTGN4b3MwZ05uSEhLdm1NcWJxNHhCOWZmaHJr?=
 =?utf-8?B?dlkzT3U2YzU0UlRWaXNjTnVDaEx6cDdoYnYwMkNIcUM4Y1I2V2VFcUxBZUpX?=
 =?utf-8?B?QWd4QktMenZxRk9zZWdrcGZsTzNncVY1MWxyR0tveVUzL0dlaUg2cUlVYlFX?=
 =?utf-8?B?M24xTXFCZDA5V01wS1kwdVF5ZDdVWCtndDVaMmlPU2c4WjBJemY1K1prZ0k2?=
 =?utf-8?B?UHk3MmNJYXU0Z093NDY2YmR3TTR1bStJbS9idFRpanU0NWFqcy96cm1CeDRI?=
 =?utf-8?B?bnZmR2ZNUnhSMTdiTUxjTS9OeGxZSmJDNE8wQXNUUGFyYlZLYmNTV25oTnd6?=
 =?utf-8?B?ZzJRbGNzOWc0aVplekN2RGhpbkJ6d1RlNE8vb0RyNlFiakdsd3hvdEhQS2lS?=
 =?utf-8?B?QWh4QldWMWV3eGtFd05xK01QMFpVVTRpS0NBQlMxN1UxTU4rVE1GVXpnK3Ir?=
 =?utf-8?B?cTRkalh0Y0xmczhaZE1vTFRndEZjb3BVOGp5QWZBUWFKV2hoT2p2SEFtVStF?=
 =?utf-8?B?OHMzbjUxaXcxZ0QyaW9uVFhKWnFmTmJ0TEIxc0hweGI0Z1hoTHFhelZHRjRn?=
 =?utf-8?B?RVl6dE5VK1NGOC9nR0NDMXNMRTNBNnNReGhJdUd5RVE0QjR1cmJmblY4Z0Vr?=
 =?utf-8?B?NGgzMFJ1ZzFwZUxXNTUwRkovcDdiS1lDUHB0SzVQYitQMzZEVTZFdWw3N2dM?=
 =?utf-8?B?RHBhMVUxUWFiTVpNZUJMa2VsNExyemwwMTVwa1NaeE5qeGVDWnlNejFTRFcz?=
 =?utf-8?B?a0lyOHN4U0pmS1YyUmJsMS9qUisycnAvWGRvcUdML0JGQzVDVy9TdWdEaVV6?=
 =?utf-8?B?M0lEYzY1Z0YramlIVjdHdFo3elBxN2RpUDRZZnBVTEdjTlFZYWhJWGk5MWc4?=
 =?utf-8?B?OFh6cHNrQTAwbzZKNlFQTG5tRW9xSFNFaThIak1DeTg1YVd2ZGw3MitYL0hL?=
 =?utf-8?B?QWtoa29qTHkvNEVWcmFjZUtwVzh4d3FQa1FITm9pVEVDcS93bzJ4ZzcxRWU3?=
 =?utf-8?B?ckJOUFpDUVJKM3RTL1hNbWdRWHF3L2VMMkxhVmRuMUMxWEcvZW5WdG5XSmI5?=
 =?utf-8?B?YjhjOUpKdTd0K0lhNDZnQkJybW9aRHNwNEdhUXNtT25aSFE2L0JtLzRiV0Js?=
 =?utf-8?B?UXdQWkdlcFBENUlQamo0YW9ONnVLd3NQL3laa1paZXEwMzVkU1A1SzMwVUI0?=
 =?utf-8?B?dDhjK2JPVm1jdERUd2phTy8razFKeURjRFJhODdkT1ZQbEJyNDBVU25CS2RO?=
 =?utf-8?B?OVRvekRreCtNNlpNV1JWNVh1NnljemR5ZGp1QWMyQ0VWc25TeDlHczdpd2dC?=
 =?utf-8?B?Uy9WYjAzSmw4NEcxMDFKSExDL002T0FrSzh3UGVYeFVveHpvYld6Y3NEbGxY?=
 =?utf-8?B?M25NWEsxNEZDdkQ4S3V1cTJWM0JWZXdUWE5yVlVvQVVqN2NUTWxIZkdkd1Bs?=
 =?utf-8?B?WVpyZzNHYitCeDd5MVpGWnF3RVBNM2dCNzh3OWdLcHFkb0xIMW5PSWtLRjhT?=
 =?utf-8?B?c05xeC8wbElvZGtPOEtaaUxublJOa2RvQzZodGlnUGIzVFEzcC9weWl3U2l2?=
 =?utf-8?B?L2JNQno5MVQya0h4ak85VS9mcDZKZ1lpRFFYSm8wQzlxMmx5cHR0Y2hZMzlz?=
 =?utf-8?B?TVA4NTY4aWlJUXd0VU94MXFwektSd2dlZkFKNDNMaytRQXM1ME41VWNGaHpN?=
 =?utf-8?B?TFZFaTFRT2VxSkRxYU0wYmxEamZKR0ZBQjZzKzJTdnRwT1Z3aGVVTmVIWm95?=
 =?utf-8?B?SkFYZFJhSXUzdlNyQzQwWjRCWUZMZmhzVUlXMWF1VkFoSm9Lenl1Mk5JYWhC?=
 =?utf-8?B?Z0tMSzRhOTRaNFNhaDBqaU1qNDl4a05JeGdYSXZITnZhLzFxUHJ6L1RiYm9H?=
 =?utf-8?B?RndPTTI0aFhvQUFIT1NCa0J3K2NTS2x2L0NSL3RwMDZWM3VWcjZ6Y24va2cz?=
 =?utf-8?B?ZFhodzdiKzEwRjZ2YTFLTHVQTWptM3VyWFdWUWlRVEFiSFhCZjdjeHpxUm1x?=
 =?utf-8?B?YzlZUTBJenJXc2RQaDlzaUxIbXZsYVJsZFNSV2E0eUU1eW51S3Z3bUcxNXh4?=
 =?utf-8?Q?whfXAvllwcFGnmmB6jjUUgrnOF2FUP8RdfmqMSHuy2G1d?=
X-MS-Exchange-AntiSpam-MessageData-1: Bydp41r+w95Y7Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f615b77c-b541-48e2-f173-08df0e26e8a5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 04:00:38.5757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: miBzYIdV7ycWLr8PpUqdPcACO2lSd/i/PafgiXnhfysgOefq4qyFgMybDicUljHQF0G8cinb3ngNY0VGLfRCVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB699018
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

From: Joel Fernandes <joelagnelf@nvidia.com>

Add virtual address range tracking to the VMM using a maple tree
allocator. This enables contiguous virtual address range allocation
for mappings.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/mm/vmm.rs | 83 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 74 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/nova-core/mm/vmm.rs b/drivers/gpu/nova-core/mm/vmm.rs
index a7911efb65a0..0bcae29db4f2 100644
--- a/drivers/gpu/nova-core/mm/vmm.rs
+++ b/drivers/gpu/nova-core/mm/vmm.rs
@@ -8,18 +8,27 @@
 
 use kernel::{
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
@@ -34,18 +43,74 @@ pub(crate) struct Vmm {
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
     pub(super) fn read_mapping(&self, mm: &mut GpuMm<'_>, vfn: Vfn) -> Result<Option<Pfn>> {
         let walker = PtWalk::new(self.pdb_addr, self.mmu_version);

-- 
2.55.0

