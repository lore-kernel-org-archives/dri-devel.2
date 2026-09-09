Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1F1C79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EAAE10EE84;
	Wed,  9 Sep 2026 04:00:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="TZykc5+F";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010012.outbound.protection.outlook.com [52.101.61.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E762110EE82
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:00:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4V2DCm1zd5L9vWUemU/VSyv+peIgMhZ1xbSfBQgScyCjYh1LLyuH4XXIuMTJHKTtu0KiJiUuY9Eak55du5GtiBD5DQ21quxouLmEnmTUfqFLhprT/jqworVXZfiJVPwBiWMAnmWOS2jpbvWz7NwdhNKo597SFzgRtR2A3IDO9pMysCBYkxPbx1CcJ1ve7GA/Bxkwtjs1CQkz8oMnDQV4MUNu7exLLLbv85tafPUmUfTCv+O0FLz8QAH2fAzJoXoyPny+WryoW+ZFPCUn29Yqg54jKcs5E7rD36gQheUENm5/45t1TdZjDtZrefr+by30umOJzfDyfHD7mHwsfbtXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5K5IdJkFyZm7uxVc/dlhsh4UAnBWNtHKqqpSwd32m0=;
 b=IUHKrWQk+XgVFSZqFp9mZOZeCxQwpL9CFQcUlEwU32spt+fGCGBttIN1l7RfTWoJVO8p11nXy4soSGWqfYRQvKvBZQX3tVu/o4b0eAzO8X1p9E70os8HaDoQF5fYfrIYmuZ5mR3Sc/8WMEHz/a7p6RF6hxImCwi3LVHtS57bGZaoC4oBDXx/u5csJdaXcftzh+v5xwbJ9Dhmjl6CVB8XfWsWcC6vZzn743tyOU/vVV+Q8nakjr2QQPLy+tLW8ZzuLuw7bL4WBdqAmRqJOkCyNAOPPeiNDiZvkUYZx4+Dn2HdF54ZFLxsUgh97vg8euLJ4yPAhvyzJEOjRPKq3+H4YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5K5IdJkFyZm7uxVc/dlhsh4UAnBWNtHKqqpSwd32m0=;
 b=TZykc5+FTC1WzpXl83dWssD74AS0gx901KGSuFDGFooHTzlekqowXWaA9G9J/oBBtsJI8g3pRrDuwamE8hO+OHhvGOoEz2xzs2swaggKa7hAbECIn8cmprpp7F/nqXGevD6Io8n8FmiYeYANP73LXg2i1p+QUiIbwkiGMOnLbMQlE7z7GhCNVSw2SLFSMVo+3pxsObLl5kIXnH17V9G4yTRqYdZBBWx3Wdm5KJ1fQFAKP1CRpyU1GcCnRU03kC4OQ7P9JAhjXnR5W5wu30cLjIyse6zNIJM33a1RRbwYZ59I+qZaLC1vntOd/oAmovqwqAOjddKdFAchKZMOccXodA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA3PR12MB699018.namprd12.prod.outlook.com (2603:10b6:806:510::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 04:00:20 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 04:00:20 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 09 Sep 2026 12:59:45 +0900
Subject: [PATCH 07/16] gpu: nova-core: mm: Add MMU v2 page table types
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-mmrebase-v1-7-8dd5d4225d2e@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0099.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::15) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA3PR12MB699018:EE_
X-MS-Office365-Filtering-Correlation-Id: 09c2ac75-72c4-45c8-2397-08df0e26de16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10070799003|10067099003|11063799006|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: l8q5xr0QvthHGCKOkWkFYfMOn9tNO13t/sRRY4i1kWYx2u1qTg+UIn/JlZfgVnsBA+iGvyKi3neBARTBX5zXpwXgRlNzV23ho/H/6oWx/nCgex9TuKo0NrbnpFdJKuE5zkUqXaF4RamuE9PkBeaQI3fFy7W71oGmCl6h0cr5fnr2xwFSCnk8NsdXMey+mb3QyIdW0OkHCOsCX8/SE/MLHBn48XkwUsJWkpVaDYIAvFjMhV1Nv7wN7RueigiyBS2s5v+q5FBGdk+oDNN3rnKhU5wJ6JhyNz3kun87Gbu+uAqm19xykdzgOFvag5l5aQB/U+VYr7kgVzbzpbJ5I0my3uTLo6s7AIGhVW78iJZfRYDFYxaUj3yvvv18cRGRZ/uuLsU6FVwEGiASXvaRZ34BgpLKtTbEytNA5xaFAPfKAgu0X6lRH5wwlBhaCDRZXyGcM/b9zPRQudV2S3VvneW4wWcAzlf8pTuXh7lrzvKCQqsOBy2tXTs72zpNF+1sEd4l7cEbvUqvTxAE89SG/Z1uhknu78kCWLBdJkqLgev3hkGnn8dlcgyXjLSkxnTA6JabTXLVEhzNVSaT1veYmkx5VQeGE2Yk7vgGIoji5nrp/XhMJReFaOyk8ifLI1CfCA1yxZc1dVWbnmpoBJv82p4lrtgMbagpM1CMYB4wmkIrjDM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(10067099003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3l5dTA0cXBkTGNEZTltcHkzN1pSa0RjRXo0NjNhalFQL0NkTCs2M0F5SG9L?=
 =?utf-8?B?V1ZXN0h0Vm9QVVpad052bU5OSElIYmVoUFMweU9IQmhZNXFRRHh2SVQxWFZE?=
 =?utf-8?B?WUE5ZS90QjMyZ05iS1dDb0VUYVhmQnJZQXBZYklVTW5aSkxkM0NMTEZsZzBv?=
 =?utf-8?B?VkNyM0tPanNNem15bnpLVW4rU3A0eW94bkdYajRKMFFnaWliZlpFVzRTK0py?=
 =?utf-8?B?TWFaV1hFZURhNE5lUjlRb0UzVEdPWEZUaGpGUkhmTFlXN2NIbDZJbFk3ZjIw?=
 =?utf-8?B?Z3ZrN1RoZFFTbGJOdEJXZ25aWmltVmFFUzZsUTJ1S2VxZHdHWHdjaENwaGlW?=
 =?utf-8?B?M2VnRkZWQjVaQm9WTXV4Y1kwL0NDdWtTeElrT1FsbEpLWlNtN3RudHhyaGFE?=
 =?utf-8?B?b3dPR21lOTlXQVFGNnFyKzhBMEFWOXlSOEZzQUNwZ2ZGYUdVR0ZsNyt6cTRx?=
 =?utf-8?B?aEcySVZkNkhsaGtQTko1Wm40Q0oxR1UzQmNoVDlUSS8rS0J6SFNNanVlWnlL?=
 =?utf-8?B?d1lFSkZQdWoxVG1mckVISnFPUWJoK0prZnV6L1U4cnlWa0t3NVNxcDJkZHpR?=
 =?utf-8?B?b2pQSzlDelNpenppMG54dld6RTFSQmJJbkFxLzZwYmh6a0dIUVVyYW5GbGxU?=
 =?utf-8?B?RS9wc3psZDdGS1FEYVpHbkFtWUlpOEJNRFJKbjF0WDRPYUQyamF0N0g3eS9E?=
 =?utf-8?B?eFpSMk9iUEV2a2FnL0RFbjVicTVKVlVqa0hkM1ZoZEVwN1FIRnNFUXBmTHJC?=
 =?utf-8?B?R2pUMVdsc053c250WkMvcGVOMk5BNzBMVS92NGY5NmtqZGtEVTlPSm1rUlVC?=
 =?utf-8?B?M1dMdmRENXBPLzdkYnlIWjNtREdjaFkrc2ZqZEFXeHkvZEsrOWNpYmFNbHdN?=
 =?utf-8?B?anlSNGdtMTJDclMxaVVNU3kvUHRURHVyazBHVWlxNWlaSzNIS0RRMXNCSVVH?=
 =?utf-8?B?bXJSd1g2dzljSStjZXhURkVaa3pvVzRWVFdPRDVNaU1yeWpIamNBR3dORWpB?=
 =?utf-8?B?Tnk1Q25jYlpxRnM2S3dNVWg2dUgxQS80R2pHUnRHVTFBTlhTYmlYdS9FdWpu?=
 =?utf-8?B?VENjdzc3eGEyWHpPUlM2Q0xQcExTUkJ6bWU3NGY5RFRWdHJOa3hMTk8wNDZN?=
 =?utf-8?B?NTF1TWN1NzFhQzlLcnJmN3FHVXFqcTg4WVgvc0pleTM5cW9kRzlOQTRrZzhU?=
 =?utf-8?B?RmFOZDNBQ1hmMXA1UlBwcm9uVTZKQkFDSkg3aHJYQVdHdGZiQUZlbW1lY0F1?=
 =?utf-8?B?eDAwRmhiSWtvOS8xNk5qT0FoM0IrWkRsVTlrV2x1WWpVQ0dodERHSTRXZlFt?=
 =?utf-8?B?TTVQRjJjRGRodnl1VGJsbHNVWXNhSDhwanZKcVUwWndqb3RWbUxaRENueEZF?=
 =?utf-8?B?cUQwTXl3Tk9QTWk1QUtiTHJicXp0MllhcGwwVU1ZTWFKcTRFV3hzUDYyakM2?=
 =?utf-8?B?U0J6M2NQZHZDQUgyUFR6N3Z6RGZMV2xGUURXR1JiQ096bjNsZ2IrUVdna3V2?=
 =?utf-8?B?SGVhY3M1eFZFMkZOb09pbkUyVnJJRjJlcm5HT1M3RnNTZFQwZmlhM0d4cTA5?=
 =?utf-8?B?ZHpGNVoySjFiUnJMT2tqS2RKaHQxNW9CUWhFYTBrVTRIM29Xam9XZ3dPb2dq?=
 =?utf-8?B?UzFzSllDdkJCclRuNWRHRXVidldIaVNDdTNVYkFTZSs3Q2M5QURsRXIvOWRw?=
 =?utf-8?B?S005TGhaRnJYaWdIMkIzdVM3cUx5S0srTTg4ZCtOczdKVkNGMjNETm5VVkll?=
 =?utf-8?B?TmptTklGVWMzUGdKcHloOEFkMkdLMFN0TitVNncxdU4yS0xKb2dXNWZOcXc1?=
 =?utf-8?B?Qm9tMnl1Ymlkano2SDQyYTVWTDZ1Q0lSVCtqRDJhN3c4czNuUTY1TWtoaDBP?=
 =?utf-8?B?a2htUlZYSDhxUmFwR0tmWkErNlJjdnZOZDlMemRPMlRYN3pzMmdzTnJSR0pP?=
 =?utf-8?B?dm1SeGNPdnZGa2lxdEtkWEZxZERSYkFheFBkWG15SHBmTFVZOEZoRVpwOUNS?=
 =?utf-8?B?WUtnYW5DMzBHaXJoODVWSkM5VEJEdytURTB4VWhESEJpRFdON1gxbkJ3TzRS?=
 =?utf-8?B?RnY4d3lCSVI2b0hGWGlIMi9odGJTMVhTbHlFTllUZjFheWhlUDBsQmRoQVp4?=
 =?utf-8?B?a3lmYUtTbzlTbmo4dmRjVlJMTUlYZXhpRjh1U1V3UW5kY1RITjJ5bnRBcmRy?=
 =?utf-8?B?cUJ1Vi9WQ1V1NVdUcHRWZVFLWkxrVk9MUmRsb1BzZ3h6MjNPUUxBK2JWa0tV?=
 =?utf-8?B?emoza0UvNWllbHkvOWRQUXpudmE3SmNKODhSK1h6WHpsUFlpR200MDFmWlZD?=
 =?utf-8?B?UEZGQXpURUFpUHBCN3oxTUVvdFRQRHZMKzFBaGxRWjJwTWlyN3V3RCtlREpB?=
 =?utf-8?Q?utzDg66waFsWsBNIP3penLyeQrfz8h8UNh30h/nsF3Zl+?=
X-MS-Exchange-AntiSpam-MessageData-1: RaSk+N0YhKeEdQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c2ac75-72c4-45c8-2397-08df0e26de16
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 04:00:20.8522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeoD2OJXSfZMQzoW7ReExe1YuRtYGsCnDT5LE0DnqjVudm/UzEZ2ROkSKsU3YXwVem5kY8EbSZjqYOMSAF2Umw==
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

Add page table entry and directory structures for MMU version 2 used by
Hopper and later GPUs. The `Pte`, `Pde`, and `DualPde` types each
implement the `PteOps`, `PdeOps`, and `DualPdeOps` traits introduced
earlier in the series, providing the version-agnostic API used by the
forthcoming page-table walker and mapper.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/mm/pagetable.rs      |   2 +
 drivers/gpu/nova-core/mm/pagetable/ver2.rs | 271 +++++++++++++++++++++++++++++
 2 files changed, 273 insertions(+)

diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-core/mm/pagetable.rs
index 550145d56e3d..df8e7e7d7327 100644
--- a/drivers/gpu/nova-core/mm/pagetable.rs
+++ b/drivers/gpu/nova-core/mm/pagetable.rs
@@ -8,6 +8,8 @@
 
 #![expect(dead_code)]
 
+pub(super) mod ver2;
+
 use kernel::{
     io::Io,
     num::Bounded,
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
2.55.0

