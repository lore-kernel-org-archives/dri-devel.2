Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36574C79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9159010EE86;
	Wed,  9 Sep 2026 04:00:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="iFHhCpm5";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013067.outbound.protection.outlook.com
 [40.93.196.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A600E10EE85
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:00:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTge47NSiFqEcvJQdxeX0SpzIOf1pQoy3Y9jwOL1qeUFVAqWJzZP6N0hIVKFv+mI9GBtdY8CPLrYl4laTGbOcfChn1QRUdHVsYs6Y7Q/+KA2C7CpgWvK8sF4YLYWwm85SHTFO1rl2rkdJyCyP0LVrY7rmNrZV2k/3fo8u5dZ+UPCYUEAGrRYMZlysG+XskQWvGbMHig1oVgsjqbc67jFwkjZqOLdUp0bxL2B8fZ373oKkGnb88qoPDTNoy9hLvjs9z+md48G/l95XyGahhBzODwV+mwUyvio6xDZRCkNpVdvK9Ds67OCT8Vp0Iaploii6ZQIj15TvBGvUmBR7WBHpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kizmvt1KnkEGoqPZTjaTWb+I01TygJEhuaRv89eWZw=;
 b=jsa2pfKaT/tVp4P+IutcwIq0Pdk9c5bPs8KMlRWAq2giD/W3iWTTtHyeSa+ISsvgoUT85KS7YtWkD6MriqDa3R/EVBRbVFNlPn8nXswtGwDBulp547HGKlPY9Jc89hW6SgpxKS2+SWR3f+8l2uR0VjCDmYKDHd1ekB/C5ra8k5+kH9Z6+SK8433cBAKPJdIAOa/82T4hEj3O9n5uEB1zAo+wn1P0TzY2WKzCtSYqUYACdovqrxvVIfy/SEd+Gna2Un11K8snu0gqufbNw9McI2T2v0deYgXH6ArDvVXwunual/wTosT7f6+pXjVYGrFHeHTm+sNUhTP3invErjnf7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kizmvt1KnkEGoqPZTjaTWb+I01TygJEhuaRv89eWZw=;
 b=iFHhCpm5Q5/hIJ0PsStlS5BDvToQ0eDu17H4+1KuLi+rZwjfWIBnIcV6N3DOrgAugMUoRxvwohN6Yfzaf7Qpjm4AIK9C5UGQmWMNnhmGbNzsAaBRVtDwUD1GNlKR2OWi43WcQIpMsjMqAk5cePkdJxM5CN5Ss5LRc8FBNrCqTpUfD5RdNBUheDZuhl3vVu/EykNtiQEQAty2fifDcuVFseDn06euN+H8rTl8XgwOp/mS7CjJVNHp5ahR0DfDfzZmSMkxVgebaQNhW5ip0UC/QzI2KgC3qm879jcKO05C5V0VDSwiajWdpnL46jI8kS4NVGC9DvwP4pWrRvbw3ml7rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA3PR12MB699018.namprd12.prod.outlook.com (2603:10b6:806:510::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 04:00:27 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 04:00:27 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 09 Sep 2026 12:59:47 +0900
Subject: [PATCH 09/16] gpu: nova-core: mm: pagetable: Add MmuConfig trait
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-mmrebase-v1-9-8dd5d4225d2e@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0031.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::17) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA3PR12MB699018:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b91019-44fe-4927-aee4-08df0e26e22d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10070799003|6133799003|3023799007|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VGjJO7cC/ArUeO75MJ5SnzPyRZSxPzSKIPO5QpGeZmfE6PcnVz9Z4PBCWas3oKDwnRbOg74dRnUOuwgbLgft4d9SWFbHufiRjHvulSX1sYZH/Z+g1cio1Xim9IFOhtkUtIMUum9IZF6vBUFQlDkHza4OGpvUf/h2MkdUMQdQnkabCoN/uZfQ0p2S2DLlWA45aXIJfHWzl+Ql/v21u7b9MBxNDTXyPHLduOAnoPGNDbDT0jnT/Jfbm8P9B1618VVV408AoZ4utdxwBVjlxApkab65+pHRHKEtZZUrCoki2cyTGKww7HETTYvNWlbrHeEHzqEicBdvGPy2t9AQK0dVM2b/ZeDnqGhOloCIgFPMmYjJP+1GTnI9dvUWN5R8PWRW3YaV8WQLIOcLvJUJhxziJRAVECr76qWmwIkxMjEuielUw9U8likvrCnKyftWGfmLFoRF/a2Fz0B0/IXLo3SQC2NV58qeT+Txwc25wS1CuAK7dDjFlRCIPRJh5lOTMuegD03Qvq2UhFW8xF1HA8hpC83QbuZ/H8CvN1z4JwWaHdaYLoeWeQEaV1MPD69jbPO8i22jEps2oez5M2uNIrjaELJCqIk56qq9YKFRZdXfoiuzGjPc+KIyvY2/NZgRwq6k6AKHGs81P78FP2T6b54DjM/kVCo6rHTXkdE7nV7VXa8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(6133799003)(3023799007)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXltdDV0MCtNVGtYWE81c2lVaDlCdUJ1UitjWEEwNnhBTWcyVXUyVERpTWsr?=
 =?utf-8?B?cjNDUmwyZnVYdFFpZUw2T2tkZ1JCcFJneEV6T3A4MGpFdllQSW1iREJWK09Q?=
 =?utf-8?B?VnhRMUlmVjJ5b2haa0RUbjhCNmJjb09FLzkrYXBRSWI0WjBYQVdiaGZLSUMy?=
 =?utf-8?B?QlpHU0tUVjArZHBxMSs5MlhiUlJCMTRXY3Z0cnplOEZKbmhmUWh4ajQxK0tI?=
 =?utf-8?B?d21FWUZHZUdmclcyR1hCMG45WG9uK2w0MUxHb1l3a08yY25PMjhNUUdMSjQv?=
 =?utf-8?B?UWxzaW1vT09jSDZUOUJybnl2ZkRERzRka2EvMnFGd0I4TXVwQzUydlNZaXZW?=
 =?utf-8?B?QzJKVi9mbVpvV3VRUzM5blN5QWZqNVhWNjgrSHh2dGJYUTFGTDVVMyt0a3Ft?=
 =?utf-8?B?MjB2aG01cGNCYUlKejduYndLY25Bb0c2VkVGb05KbC9sZ1VyM2NiRDV1QmU3?=
 =?utf-8?B?WmtNdXhEbzNwc2xGZitqdzFLZUNlSEpzb3YzUzBjeE41YkdsODQwWGVDNlFa?=
 =?utf-8?B?VFV0ZlF1THA1YUt4L3djT0dmQ0tSUFNSdUtKVWJCNGtSanR6Sk96RWRwVzdr?=
 =?utf-8?B?RW1Ed05vZ3d3aEFjcHpsQ280S1pFUTZSNE5FK0VRbUptZVhRR0pNbkhkTGRG?=
 =?utf-8?B?VzJiZVNobGFJT2RBTUR0SkJUcXg5U3lVbVRmWUJKVmpuczdqQ3hyZTU0VThX?=
 =?utf-8?B?Y1ZBU2pZays3N1NMKzZKK0lBTjZMS2hIM2o2TEVtdllwci9WYmhWNU9VY0t1?=
 =?utf-8?B?eHIwNHpDdm9UUDlDaXk1QlFLYlloNStvNmVtZTVqWXJaVDlBa3FZTHFsY0Nt?=
 =?utf-8?B?ek1GSUVJYlBRbEJMYk93b0JhbVJXb0Y0aWVZTWxFNU9CLytOa2g5Z1lZS044?=
 =?utf-8?B?RGE5V25CU3dZZEVwTEFvZjBlbjFZN0xYSEFWRGw4YUxjbkhIbGpyWFRXajcw?=
 =?utf-8?B?NVFNK3hEd1gxWWZaQWZjVHQ1N3VMd3VtTG1TYTZDajN1SWFZMHI0cXh0MkZ2?=
 =?utf-8?B?OXhrS2FyU0NydmlTNkNYWkpMRFFqVzZJZUZWMlM0azg3S2xpcGR5V3NnQVVY?=
 =?utf-8?B?NUllQW4vOU5jQTNUcFBGK2dpWHRQangyNFVTMmEvNFFWRVpsV2MvY21jWjZ4?=
 =?utf-8?B?N00zbzBBNmFGVHdZdzNKR1VaR1p3YkkyY1AybFIxT3I5blJNNkh2aGlDVlRZ?=
 =?utf-8?B?bGsyMWJMVjFXdnd2NS9URUxtYmZ0Nm01djR1dU8zOGw3SlRsaGQ1cnBSS2FY?=
 =?utf-8?B?c3VtZWNES1NRY0MvSGMvRm5oeEtqT1VXYTVVdCtjRGx4djcxb2lPYlp1cjJK?=
 =?utf-8?B?TGxMRzVvdUh1ZE02c3prY2xacXV4a0JSeCs0NlIzWWRzS3crVWxRUUVDY2ox?=
 =?utf-8?B?bXhXMDFaSTR0OVkyd2Q2S3ZzcnpYSXhNSi9OTHdZblRkcEsxTWJwS0w4Ukxz?=
 =?utf-8?B?ZFJTSjVld053YjBYbWxWRU15K0ZVUFlVYXc3TXU4bXVFbGJxdk0rcEZsT0RC?=
 =?utf-8?B?R2RhRUkyYlRNZEhrSStGWFdHTVBtSWEzRHhlZ2plUENsYWZxWnBBQlNtdEVX?=
 =?utf-8?B?WkV2RWxRdkJCSTdhUkVOLy9UdTlyMGhFUmtIV0RWTEZZTElqTXE1OU13Q1lT?=
 =?utf-8?B?VEMybWJ2LzFyTWpZaFNZdVFBUUVkRWlINzRnMGZUSzg1TDZsR2tTWnE5S2wx?=
 =?utf-8?B?QXk4R0k4dGFpU21GV0NyRTZldTVQZ3gxL0pTL1MzMlNrOHBlMFRrUGMyRSt2?=
 =?utf-8?B?OG5uNUo1OVJTbWxqN1hEZ3o2QTI5a1BMU2ZyMWhBRDY5WXptTEVMR3BBZ1M3?=
 =?utf-8?B?SE0zQlVra0hFalh4NTlJRnJ0eE9tZTdDenk0VVBjS3BkSG9wUFhacjU0aWxJ?=
 =?utf-8?B?Q0R1NFJsZlJWQVRpbXZTYncwMTFNZ1JFRkdtZXk3RVc1UDRzTWJWSXJLcU1t?=
 =?utf-8?B?d1JaMWRkVFlOOXF0aG9Idlo2cW02UUFMbDFtM2FvL2M1dTZOTFhSTERFMjlX?=
 =?utf-8?B?ZUVsMmhIUGp6TStTQ2p2b2dCNjFPS3JZYnNFYk12Ti95c0RNbENoZ3BiMFh3?=
 =?utf-8?B?bVpZTUcxN3FJVHljYzRpbTlJQ3dEM0ZBYTZha3hRK3cyeURob2Nya05hdW9B?=
 =?utf-8?B?Z0dtbEl5eS8vamFKV2MxazJJbHhwY0lab3o4SVpiblh3UmpsTVprMUVIUWlM?=
 =?utf-8?B?b3FXbTJoZnUyeFIxUURtejRYK09KdHR4RnVFdDBIQnllZCt1SVRTb1ljZXpL?=
 =?utf-8?B?dnhSSklyd0dVc29haHFnZC9WUFhGR2FRdE9vcmwxK0NXNmxUQnRreEFUUlpB?=
 =?utf-8?B?RU5NOUhKZXFIUitVMEtDYVBzSTJaQzB4T2FBODJMOEhRdzhiYzh6SjlhWk01?=
 =?utf-8?Q?aa21PrrJYA5aS25uJ8GP+6XQ9oedcLybjgGfAoiY6qX6H?=
X-MS-Exchange-AntiSpam-MessageData-1: pr9J+9vpvj+jnw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b91019-44fe-4927-aee4-08df0e26e22d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 04:00:27.7138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuhDFzcl4FMVTB0xayumV7I0Z1WFpYx/PpnZwjxTSG6wpMaI1sux49sjMop8OraJUOqKUjhcWBjzzWyo5uL/yQ==
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

Introduce `MmuConfig`, the trait that ties the entry-operation traits
(`PteOps`, `PdeOps`, `DualPdeOps`) together with the version-specific
constants and helpers.

`MmuV2` and `MmuV3` are zero-sized marker structs that implement
`MmuConfig` for Turing/Ampere/Ada and Hopper/Blackwell respectively.
Dispatch is fully resolved at compile time through these markers, so
version-specific code is selected without runtime overhead and without
wrapper enums.

This enables version-agnostic page-table operations while keeping
version-specific implementation details encapsulated in the `ver2` and
`ver3` modules.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/mm/pagetable.rs | 109 ++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-core/mm/pagetable.rs
index 128bfc0d277a..d88499ed3d56 100644
--- a/drivers/gpu/nova-core/mm/pagetable.rs
+++ b/drivers/gpu/nova-core/mm/pagetable.rs
@@ -21,6 +21,7 @@
 use crate::mm::{
     pramin,
     Pfn,
+    VirtualAddress,
     VramAddress, //
 };
 
@@ -213,6 +214,114 @@ fn write(&self, pramin: &mut pramin::Pramin<'_>, addr: VramAddress) -> Result {
     }
 }
 
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

-- 
2.55.0

