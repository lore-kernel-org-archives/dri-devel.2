Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AED1C79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9755E10EE89;
	Wed,  9 Sep 2026 04:00:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="PcHAgtV9";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30F0410EE89
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:00:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NC7+pRBw3alcPWj5ovLF0aK8nLed27Au1pP5Ah3A239M0PJ9SfAXIKXmFJLQbMsn3R21DMWqmWZsqhhk2nzN461cBkUhMupvM0361Tve3LIHscPk2SzlYTUUsVsj+U0/9W9Fcm1S4L+Dn0spBhkjp7m7BVQC6+gVppCvpnqahG5zi5gNOD2Dtiu3jKBsg1imKAYjiTotYyJxHorT4V6rDutAVHvjEsPyuC/qL4MTbKmoZg7pNGE91ppZCJgL/RtNTfVOx+dSeIvTS3ex7sprXCDF9r2YPrjoYEyEnVBacHhCZQ+X0iCUZfdfsuV8nivkzL3MOgn4Ss3ux9ieteZVEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxpLOGB5kyKzh+ei6U32cS450DmPV4hqpgm+qmKUhgE=;
 b=WCmy0zrTiID8awOIxeRQKTUG0ZoOCc92BwvYDpkAF3DTyuXrt7Y/lO64koQ0EeQvRWoj7I82CW/7PNxJYNHXQwQbb2k8dj+Px7r3k1UnNlkvsC3ZBbr/HRkF/w8j7kYL2HZM1CwzspyjB/n1uvU5dI8YrXc8FtK80mtMV+EZCse1sQXGpzqVakRLfXNmL3aUnpNwPDGUq5Ek0te9tF0ZXPX+4Tv/RzReF+c0DUIy4UTvYdQA2F1VYhP+B0WjCub2w0OaRgS7mKrKWnapPlOxpAXQMCOo+StUapDpWd0s1XKuM1l5sQ9MAVMVW0K201TNIqLbCi3WfgavGihPniXZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxpLOGB5kyKzh+ei6U32cS450DmPV4hqpgm+qmKUhgE=;
 b=PcHAgtV9u+0kUitE/1VZSlFL3lvZsKCkdCvp6XbRDVDz1efdbe7cH0Ehm0IJRs706HRFJhVrJZDeoMQSEtyKrdl7hhFDKGtARyjyk3qYG17XWmW7GXCNxdmA7tnuDytheKTWs86IqZzM6+FaPV2SkmDHGWSXR/awzxEFiDRKKyCeJ7Sf7gx4BmTg3MoC0GHs2Urcn7uHPy22LASkJGHhgatEvyODfukZBB+WDZlYNQcq6g/cj7y5Ad0wSrJgmgcxBi3KoxQhmIkimI+cu/FlPaD/F3Zi5mpXTqGxjod+EdQE5iab+ooCIWWDUj/am069co/Ivui1yv+tR0wBPumTIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA3PR12MB699018.namprd12.prod.outlook.com (2603:10b6:806:510::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 04:00:35 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 04:00:35 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 09 Sep 2026 12:59:49 +0900
Subject: [PATCH 11/16] gpu: nova-core: mm: Add Virtual Memory Manager
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-mmrebase-v1-11-8dd5d4225d2e@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0088.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::19) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA3PR12MB699018:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ef3e38-589d-4a54-217e-08df0e26e676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10070799003|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kvoX/ZtOMZ57RIqipKsMQY68JYbW+IpvAkHBMkr/i6EAw+VeXHLZohlJJXkc40kyvoApjcGOmmvc68loZQoFaI1OjuZ19+gH25uFPqSAzNiywlM5mfbjABlhjDXNf+Sqm928adLroF3EeTy/lReMA/KB0XP6yeCIKxICJ47FJPLWINpalpA9tCC3tWhn3XIDToFx0LZwn2XrX2gJA9QF/ZhIyOzhRO+DRuTOS9LUE+awYrO2irutKJnSe9K3OswLIfPp0Hl1AbXPVMv+M7SA6SoXa/GQ5oMKgfcuMlpDI4hgr/+un+3+Hi35ZW0trzCFAwNjMBb3CYYS15MSC1nb9QgJUyIzkCemRnoQOgjBIvTSp/AsqtrFtyzHvR7Gkn3/sI1J5Q+azh8zkshGSv3QryDMC3TSxHW1BbNvLzzlYd/iQvdAK7pXFkykoDr1ORYVeHvHnUHnnEtjGhvSYsDpxUpy3PMSG/1O/xL3+T7iOOmiwmcv6zv2BcAiLttdJPWLZpjHIKVQofJ653pXrND/GlVxCL1uCUDgkMTrRy1LS6TJYRa0jQL4MtlEutFCTgh6v+jI5kkvu9I9fvLqjs21Kryi848SRcYOIdcP7KadMLjupUbOcBXxrYQSlo2aKnAH2OUtgi4YpNDOyyRSvzOSMLD6FoJUQRUlD3mb5VaQKDI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDdHbnpKU3A0b3o4WGNRWU9QMm1jMUJrdmt0T1BMaGNQcXhsTTVnVWpVeXB2?=
 =?utf-8?B?YkxVYVJuZ2NLMTN0YURjNTNPQmZoYTJ5cUkyWXRkMnIwam96MVgreis2cXN6?=
 =?utf-8?B?Rnhkb1NtcWFvSExpOUFuY1Q3aXFJWUJqRlN4SS85TU50S1czVDNzNHBaaXh4?=
 =?utf-8?B?ZVFiaXd3K0RMVFVxa0o2d3FwczRoQUN3ZnEyQW5FQ0xNUTJjNVdaRC9BSC9F?=
 =?utf-8?B?aHc3SVJxV1ZCcUE0b2hJbTV6MXNaSWdJb1Z0UTl4OVFOaWJoeXhsUGJoQUds?=
 =?utf-8?B?Z283b0VZOVJXWTN2WUVnMFNqeHBkU3pVdWoyVXNvYkxKd2dVcG03ekJYOHFl?=
 =?utf-8?B?dkQvV0xCa0xTZnFCVzlCYmQ3T2s0ZGZPM0Q2bnQvRnFXOWRrdkNyRS85R0Y0?=
 =?utf-8?B?SHd5bVRsTmFRNnhYaXhUNi85QUNDYjhZWDlsN2RVQ2JLbHY2cFlOTEh3eERX?=
 =?utf-8?B?QWsrT1lCNDhLY1hIcWZmd0o5eGgwdFY2NHArSUdDcVhzazl1OU5HRHk5RW5q?=
 =?utf-8?B?aGowejhVc0dNTGhaSVVxZmg3N3R0S3J6bU5HWTk1RHpGUVpDa3VuVjVLd2p1?=
 =?utf-8?B?UnRPcVBDUmpJZ3VaRGx0N3JEeTBjTVNlOHg5WmJvNnRvb3BVeHVoQUE3bW5P?=
 =?utf-8?B?N0hXSXRBdUEzUURIQ1JzNlJjcFNJOXdkNHVWSElIaXpKYml5QTFFaFBhWGtH?=
 =?utf-8?B?bkRsYWFlWjdLVzMzL1dsNWNFWitZVFpiM2xSVUQ4TlVMOUtWdVFJYjBweTlV?=
 =?utf-8?B?cmZvSWNLSEZWZVJPODFOWTM5Q1hRWk9SZExTb2NuZzVXVEU2L1M0cGUreXEx?=
 =?utf-8?B?OUgyMHUxeStoQ3d1WlhhSUtxSUJkdmlsTlF1SzFSVU53K05hZUh1SUJ5QVRZ?=
 =?utf-8?B?QnlWTWttNDVINm5TcXdiMXRHL3JjSVNPNTUxaWkxTVkwWWRucWRaZURuOEcx?=
 =?utf-8?B?Q0tjYUZTdk0rSzJuMXFJcXE3Z2lGM1FYRVQ4WDVCV25HSFBOWmMxM05DalBR?=
 =?utf-8?B?c1JWdkhhd3lIMlNDM2xGb1NQZ3lUZ1RHQU9lZ1E4aGZibGJwVEhtQXpieDJE?=
 =?utf-8?B?V2ZBeS9RMFlRZENVTEJmTUVEVjJ0Zm81MUtUbkYrUEhhSUxOTmZmQ2NNYnZG?=
 =?utf-8?B?Uy9OekFpS2N4K1V6U1JUNVJNTm5vMlBZQ1lRZ29rZ2ZnajdOK1JhYmJOUlh3?=
 =?utf-8?B?MHlTbnF4bisySE9uMkdTNHNYMXd1bkFTRzJaNVZaSnQ5bjF4aE5FeWZBbHBH?=
 =?utf-8?B?UjVLSDlRb0RvNmtEN1Y5d2dKMVRtMnhFR1FTZnQwREJzQnhPeC9hYzdUcW1x?=
 =?utf-8?B?MFpCUlE0R2c0ZldqSWErRnVaTUZ1RUJtNjFwMmlWSkY0NHZ2ZytEWWxkWm1v?=
 =?utf-8?B?SW5lQ1h2V1o2NENQTDZNcmJNLytuU1FrVHk2RjhPRE5jVnkraS9LR3lJc0k2?=
 =?utf-8?B?Um1rdVQ2bU1EU3hjNjdYdUJnYlYvR2lsUTJnTmNHaGw4SktLVnZrOGhhc3FH?=
 =?utf-8?B?Rm1MYnVmTVVEVEppdVlFeS9uTndkc0VZMCt4NmpZYVdKUjFqUy9oclcvNmJT?=
 =?utf-8?B?QzZKdDV0SzJueHBlNy9kMkNVMnhVNEl0eGN5WlF3VWwvckpZL2J4QWZpUzVh?=
 =?utf-8?B?UzFua21ZeDRJVzF1eGorZk4yTGJpRmhtcnlwczUxNDFMdUdveTkzamFxazBu?=
 =?utf-8?B?OVRPZFd0SVNyVE81ZHJwUUdHMjNzdVM0V2JaQ0lET3FrYldmRGJsaUg2Qlgr?=
 =?utf-8?B?NEpzdEtCTjRMOWdSMC9lVE16TXp4SmdRbDRWdk1uNFpzZVhhTldmeHhSR25P?=
 =?utf-8?B?Y1JRdGJqZDBYaWUxMDAwZjRkT2N3TjJqTjl6VXZCenFyNUp2TTJ6YzVwWEgx?=
 =?utf-8?B?TlVzbGZiODF2MmdEY0pCb3BTSTNQeFRuZEwzczdpNWwvdDc5R01iamNSUGtV?=
 =?utf-8?B?bFdBckhJWFRlVEYyK1RCK3pLbU43ZW9ySExoZmVlQ1ZLMDVQMVlZZFdHK00w?=
 =?utf-8?B?NzRwY2RmYmN1MDgrTTQxRjZUVE1WNFhvdEJJUUsxUllhWFdmaUFGODNQV25v?=
 =?utf-8?B?UE5PUzI3VjJTaWpNQ1M2dzVWdjJ1R1F5WUhpV0JhY1FjNXBHQlRWN1RmQnBE?=
 =?utf-8?B?UUNiTm1hQ3hNK3l4a2QzWmIvRU9xM0pPNjh2SVVmeDJTMmhtampKSGN5OW95?=
 =?utf-8?B?TmhLN2hSNXQydzIyUCtTcld3ZVU3cWkzL1NibHZleWNHd2RGOUh1ZnlMQmRG?=
 =?utf-8?B?VWNjMXFpMlVHdEN1bnQyVy9ITkM2K29uZldUaVlCTENldjVPSUxraStiNXRr?=
 =?utf-8?B?cnA3V3RMeFJNMThhcWFmR3I3QmRrOGFsN1p1VDVRWC81UXdsZmZkd2xUaElT?=
 =?utf-8?Q?9VY29vBoiSaaGwybbTQBXMs4AP75TU3h3Kr4MKA9ik6TY?=
X-MS-Exchange-AntiSpam-MessageData-1: Ite3DYbrMO9P9A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ef3e38-589d-4a54-217e-08df0e26e676
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 04:00:34.8980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tngFR7jFsqChuY2OmldqlxUxHNTSjrFlkS0ReJpckVBtxjmv1q1BdA19U6TUIaUSD66T84zHXWqEl++wz+g0SQ==
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

Add the Virtual Memory Manager (VMM) infrastructure for GPU address
space management. Each Vmm instance manages a single address space
identified by its Page Directory Base (PDB) address, used for Channel,
BAR1 and BAR2 mappings.

Mapping APIs and virtual address range tracking are added in later
commits.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[ecourtney: pass mutable GpuMm to mapping lookup]
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs     |  1 +
 drivers/gpu/nova-core/mm/vmm.rs | 58 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 377cc9d44702..2cf37254fbb9 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -65,6 +65,7 @@ macro_rules! impl_pfn_bounded {
 mod pramin;
 mod regs;
 pub(super) mod tlb;
+pub(super) mod vmm;
 
 /// GPU Memory Manager - owns all core MM components.
 ///
diff --git a/drivers/gpu/nova-core/mm/vmm.rs b/drivers/gpu/nova-core/mm/vmm.rs
new file mode 100644
index 000000000000..a7911efb65a0
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/vmm.rs
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Virtual Memory Manager for NVIDIA GPU page table management.
+//!
+//! The [`Vmm`] provides high-level page mapping and unmapping operations for GPU
+//! virtual address spaces (Channels, BAR1, BAR2). It wraps the page table walker
+//! and handles TLB flushing after modifications.
+
+use kernel::{
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
+    pub(super) fn read_mapping(&self, mm: &mut GpuMm<'_>, vfn: Vfn) -> Result<Option<Pfn>> {
+        let walker = PtWalk::new(self.pdb_addr, self.mmu_version);
+
+        match walker.walk_to_pte(mm, vfn)? {
+            WalkResult::Mapped { pfn, .. } => Ok(Some(pfn)),
+            WalkResult::Unmapped { .. } | WalkResult::PageTableMissing => Ok(None),
+        }
+    }
+}

-- 
2.55.0

