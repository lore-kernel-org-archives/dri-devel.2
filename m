Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD51C79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EF6810EE7B;
	Wed,  9 Sep 2026 04:00:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="FUAA+dc2";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DF4E10EE78
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:00:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsJjmNy60QU75s2yWqjgrEoNm1TKxeXy+XcaI0aSrCslrKtEQHsqasQiCBfmGmY8ebOxHymPKa0eq08twcSidFcgH8nvzMvw4hyc3R0KaPnn3XzcsuqgVnWkP0c0HMujj3Jdu+caaDGVIrSjrO3SPfM2oQ+bnz47s0TuHuJvBnRi2piSdMkC15IJCWrPklQCSwAaNcH/fWQnIg+dMkpTqKV+YJ1WXHvhfKHTqwjhdIuRUlqw8jsnTlxEMshodRq70fu8eQzmh5lIWgemLjdxAv3UK0qelT3HQGjmOcIMVhfZcKoc/yQh5d9hjwcEKkGdTTqX9mo9OMVV0XmxIP689w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYwS/DY3xF9WwS5trYXkgbt/9bKHvMuSbyCswNXh5os=;
 b=pfZrooE2Qsr9vtfXnPolFHtnoby47B1tmFgymUD8lv3WE2+FwzXp9csQVibUBtHL2nXbCKRSgN9EvbjQ4tTyFUdsnMbEghPTohEqtGNletQhvbNPctkbDfcLEIsPH4dWaiuM7aqirCUAuazK7bwHTjmIrwxkJKGuuR0XfxRH7OWFinfIhsMNuLkupdbBzsHrH43muuPjpzyEBOHrxD1Ug7VSzKQQPN7YK/y+R49hUWq3yJN2kzHSsdslkCJX1/rxZc9i3gc42u6+hw0jRheD1fi9krDxzoYC5pohAJofqSCiKgo4vFHHuKJ8dIMMKXHf7JCmttZKCstjsPgY4XGM2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYwS/DY3xF9WwS5trYXkgbt/9bKHvMuSbyCswNXh5os=;
 b=FUAA+dc2brroVMAbbXVk5OUMj6grcFrr4Z8tDB4xU/r8rSTtvJSlGFdfD2eWvgX5QKXogmSLpbswnQjljoK4SbJjm+l5VWLDQLJ8eWbzTW7jvFPvGszoE71Trk83uY1s+8LIQgDI4DUxX5qCTtTQN8pGO9pyc3Yg3oz75ijVUzxtHC/rhujm9CM0/RfuyEcI1swNDbODsrlYoHFOwrM1cv3fkyzOXOGisst5UZJ1zJrRI1SS85LnXhFIxDq92K9MkMDWqxnKz5TsxNOZa6U9dmqLZb7wN7ixOn4VLRTMbBD3PeBA4yawxL9M6xVO4t50FT/KuoOpMAvqJW8wDmATdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA3PR12MB699018.namprd12.prod.outlook.com (2603:10b6:806:510::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 04:00:02 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 04:00:02 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 09 Sep 2026 12:59:40 +0900
Subject: [PATCH 02/16] gpu: nova-core: mm: Add buddy allocator and TLB to GpuMm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-mmrebase-v1-2-8dd5d4225d2e@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::13) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA3PR12MB699018:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a25cc5a-e013-40f0-5a33-08df0e26d320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10070799003|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GxyAn0VvxK33vH4wuHVpYH80yCpdg88g3gARD9DC4BztR3WDxpnH/fgLaqvwwKM9H5FQH1IfX9V/nxEwFzQsJGY1o9hI1W6UB3jGqOMHHtBcK+1zln4FT26MVIgLUs02mTYIYAFZ6wKTVTi1jcqi9o3cn16C70HqRvrEDAdqznl8kZ2f9a+w7XTF40pQ7ubH9Jr2XFkLFw5sAMR6R19EFFxDGJsjunkheL1MQbRmdAg9qnkEHqZcGCo8J2/BX4q99zsQzPGI98Vkc1tY/HGr+Fcipq780ndzg+07cSr+0tTYPDnsdCqNAoKJgkaE5SqYuU/KNtEJNR3fB6ntvsc71OgZoDF89YjDBrd7iz8hLWYgt7+BnIJzBothcHUVvaZOWCaNEyAaoVyw5cmH046CqGoMlOONA3XVrq9rl3zvRAvhXgjmyeDlhRmtOxfiESHnWnrH2THlO49A6PMRDORtxltBAkUaB+VpEvT5RugubIr4ahCVW57Hz5QGFhkTZOlVT6NZHn+LLiIhDZU633lH3T91bnY6haBU5gtuCAPTG20Am4WLOIqGhJ27pU3DfdRkHWRQaa9ndsOT4SD4KDqFTEQGmI/r0eQRlV2c3LnP38/YfwrmUw5xORxRBS7Xgn9gTOWVeC6GAOo54LasyoqcO5hTM71rRfT156Er5DKM7XU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVNoSUVMRlI2SFQ0akhKaDlZUFFyaWxCb3lMSlpnb0d1ZWFYZ2tVVm54ckx6?=
 =?utf-8?B?bGRqeXNiSDU0dEkya1hsdXFjV295eUNNOWNteFpFNlIvQjZwc2cyUWZpWjQw?=
 =?utf-8?B?ZmhxUWxXWXZubnBXMThtQmRmcGcxcncrOXBqY3dOVUFIR3B5Yy9HNXJmTEtB?=
 =?utf-8?B?T0pxM1JhMHVOTStNNWFXUE5TK2R2WUQ2ZEQ1NkVnQ0xNSGxXSEhEVTI3T1o5?=
 =?utf-8?B?ajZvV3lXN21sN2VQTDdDME1DbnI0a0RCUFZWYzJkQ25zaUs1aGVsOXNXR1lz?=
 =?utf-8?B?UDdlR3psQVYrYmZvMlhSU1VacW9DT0F1LzAyMUZsS0RlSjZRVXhpZDBYaEVT?=
 =?utf-8?B?VmxGZXZ0MElaMWx3cGp1b0lnTUliVUE5MUthWE96L0hQYlkreitFTEdqdzQ3?=
 =?utf-8?B?RFE2SGxqVEMwbjd5WHhwRGlvTXBjVnF1RXJ2U0JteXJsWkVLRFFkNU9NQS9y?=
 =?utf-8?B?eG9qbXZoNE92ZlkxMGxNd3FWeGhmT1BDbkJFNXZramFnS1NuanU4RmNPc1Fr?=
 =?utf-8?B?NGZHK2plVmZPUlNRL0U5NHJoY3pwS3dxTDNvam5LQnVEU3lFWlNxRXlvVTdM?=
 =?utf-8?B?OGhnT2VLb3Uzc2R1Y0ZWZ3czVlN4YTB2VkUrclRnU29ITzZhVEZBTWt4Y0hO?=
 =?utf-8?B?ei9XQ2liSGoxbDNWVzZHUkZzZ2k2Wk1MYzRURXNidkVSSmV5MjFJUE85VFdS?=
 =?utf-8?B?TUVURWdDd1VjazhPRDdMcG0rMytEaFRteWlMNk01eFlGQlpjSEE4ajhEMmF0?=
 =?utf-8?B?TUhucW8vUWlkR1lIWktZUzJuQ01SRWxxKzdkUlBGVXhtalFKbFFwcVYxYlZu?=
 =?utf-8?B?ckx1Ty9kaEo1V21XcFE0d3lwcHhUaFRFTnlBY2V2cGg5SHBaMGtiNTl6bkUv?=
 =?utf-8?B?eHd3K2x3K09sbnJnU2xVSUJGL2dZOTQ3bVpBRHYvZU9SU1YvY3FoUWY3Y2Z2?=
 =?utf-8?B?WEZzcFFLRnR1aU9qZ3luenU5S1B3SWdjTFVQNkR2UVR2TDFTcCt0OGUxenNP?=
 =?utf-8?B?SExsTVJZd01DdFhxdjgreWlYcmZhTVpmVS9WSitNL3h1VkFLVTQzK011TTg0?=
 =?utf-8?B?WUF2elZlRlRIdTZjWWpiS0F5RS94dzJDR1hEUVdWR3Z3M0lUT2FPc3BkTUli?=
 =?utf-8?B?OXdFWW9ucytQVWxNckd2TStla21iQ1lIMng3eEptS1hiRkZYMkM0TE4rYk9H?=
 =?utf-8?B?Y2kwaiswSVZzU2Fmc0hpcjVZcHJtWWhFY1Q3TEhxdG1pUDlCTUFJQW5hSzNt?=
 =?utf-8?B?NlhlTklRQW9QZmVMTWlHNGpXYUdnVVpCUkdmSXhuTWdEMklWblRUNno1ZWk3?=
 =?utf-8?B?ckEwcUMyZzZDYTFDZXlmTndjeXFHa2JUUTlQNUdqK0NxMXdGdSs3VloxYVhO?=
 =?utf-8?B?ekNQdWJyMnU2cDAyUFZjQzBrN1VOaG1rU1ptdVR5MVZ3YStQOWpUcWRwWUxE?=
 =?utf-8?B?S1BOMm1zQ3gzcnVDZHBoaVhGa2pIVFNxaTREbjR2L1c3MWRTRG96ZXB3Z3dq?=
 =?utf-8?B?amFjK1J2dUtXSlJ1R0QxQ0RCTWx0aTVQTDlEZVdKV2M2KzhjVjV1QXQxNk5P?=
 =?utf-8?B?NkpvS2JjZWZjY1RuU3I3cU5HYVA0NFNGYlhJeC9YL05ZU3N6aUNteGlsbVc4?=
 =?utf-8?B?ZjN2VjE1YTlTckE0VlExbmJmekJXUDNVQnc3K0VIbTlNODBRK1F4UzF2Q0ZQ?=
 =?utf-8?B?dkdsNmY3ZlMwYy9yVUUxMDdxMVRsM1Ezd0xWem9McjJHYlQ3YS91Q215YXVa?=
 =?utf-8?B?d24vcWdyZVkxVDBuQWdEMXdDYnNNdUpSNGczbUlVV0R5K1JYM1M3bWQ5VDll?=
 =?utf-8?B?VzlxVkE0TUpMbHR1UWN6L3kxSFM2eGh0aWx5NTlJL0V4dHpRbThDQ3FSNk0r?=
 =?utf-8?B?enI4bUowM3QvOStaOEFBWUY5MzI0ejB1eFRxODI4cmxHaWFBdUpVOWpFaU9P?=
 =?utf-8?B?RWFFa0JjVlVNVHA4cVVmbytGY3FiSnJhMVo1NUZNbVE0N0dmSEEvMExCdVNz?=
 =?utf-8?B?bVZnRHFuamM4R1BrUTdyT2FmcFIwSTJvOFRwQzJhVzRRaVVhVEJ3U2QxRlZI?=
 =?utf-8?B?L3BIdU43eEExVDBDTGo0S0lURDBQSS9nWFg3Wml4emtQOGdJWkczWFRTRkcz?=
 =?utf-8?B?UG0rZlkyZG9iVS9EeHp2WE9FRXlSM29BQktQRG1qM2puUEIvNHg4b3JWc2pU?=
 =?utf-8?B?LzVwSi9OVXZVMS9VNXNyTWc0dUJucEVUVDk3eERHTnRNQXA5cWN1U2E3TlVE?=
 =?utf-8?B?N204elhrWjJ3Q0wzOURJYSs2V1A4eTJIOE5ib1FQZFBBd0lMTHZLcDM1UWx3?=
 =?utf-8?B?VlhibkZBSDZXZnMxZ2h6dWM4djc1Lyt4aytWUnM0a3dRdGIvS2R4Q3BHVGl3?=
 =?utf-8?Q?qpomWDJ9ALQvI8Ooy7F5IJulEridfMDh4ld8tpfPEr4bE?=
X-MS-Exchange-AntiSpam-MessageData-1: VpkF6NdJhSWObQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a25cc5a-e013-40f0-5a33-08df0e26d320
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 04:00:02.5784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+NtzZLQEJIQcMz/VJ/gXC10umqFnLgzofvN3nL+TVhLs9O0/Av2Q5dpQSR0vpOExMdKTkkqMZIbIxms9pREUQ==
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

Extend GpuMm with the remaining two memory-management components:

- Buddy allocator for VRAM allocation.
- TLB manager for translation buffer operations.

PRAMIN was added in an earlier commit; this completes the centralized
ownership model with accessor methods for each component.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[ecourtney: rebase GpuMm for borrowed BAR0, pin Tlb, write regs directly]
[ecourtney: size the buddy from the first usable FB region, drop dev_info]
[ecourtney: update for the VramAddress raw API and typed register base]
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/Kconfig   |   1 +
 drivers/gpu/nova-core/gpu.rs    |  27 +++++++--
 drivers/gpu/nova-core/mm.rs     |  24 ++++++++
 drivers/gpu/nova-core/mm/tlb.rs | 120 ++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/regs.rs   |  68 +++++++++++++++++++++++
 5 files changed, 234 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/nova-core/Kconfig b/drivers/gpu/nova-core/Kconfig
index cb7f0b00f796..1934f17baa8b 100644
--- a/drivers/gpu/nova-core/Kconfig
+++ b/drivers/gpu/nova-core/Kconfig
@@ -5,6 +5,7 @@ config NOVA_CORE
 	depends on RUST
 	depends on !CPU_BIG_ENDIAN
 	select AUXILIARY_BUS
+	select GPU_BUDDY
 	select RUST_FW_LOADER_ABSTRACTIONS
 	default n
 	help
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index a52a3d4d86af..b797472279d3 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -6,11 +6,16 @@
     device,
     dma::Device,
     fmt,
+    gpu::buddy::GpuBuddyParams,
     io::Io,
     num::Bounded,
     pci,
     prelude::*,
-    sizes::SizeConstants, //
+    ptr::Alignment,
+    sizes::{
+        SizeConstants,
+        SZ_4K, //
+    },
 };
 
 use crate::{
@@ -422,11 +427,21 @@ pub(crate) fn new<'a>(
             },
 
             // Create GPU memory manager owning memory management resources.
-            mm: GpuMm::new(
-                bar,
-                gsp_resources.spec.chipset,
-                VramAddress::from_raw(gsp_static_info.total_fb_end),
-            )?,
+            mm: {
+                let usable_vram = gsp_static_info.usable_fb_regions.first().ok_or(ENODEV)?;
+                let buddy_params = GpuBuddyParams {
+                    base_offset: usable_vram.start,
+                    size: usable_vram.end - usable_vram.start,
+                    chunk_size: Alignment::new::<SZ_4K>(),
+                };
+
+                GpuMm::new(
+                    bar,
+                    gsp_resources.spec.chipset,
+                    buddy_params,
+                    VramAddress::from_raw(gsp_static_info.total_fb_end),
+                )?
+            },
         })
     }
 
diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 4234ba4d596a..202bb8f8ebed 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -40,6 +40,10 @@ macro_rules! impl_pfn_bounded {
 use kernel::{
     bitfield,
     fmt,
+    gpu::buddy::{
+        GpuBuddy,
+        GpuBuddyParams, //
+    },
     num::Bounded,
     prelude::*,
     ptr::{
@@ -54,16 +58,23 @@ macro_rules! impl_pfn_bounded {
     gpu::Chipset, //
 };
 
+pub(crate) use tlb::Tlb;
+
 mod hal;
 mod pramin;
 mod regs;
+pub(super) mod tlb;
 
 /// GPU Memory Manager - owns all core MM components.
 ///
 /// Provides centralized ownership of memory management resources:
+/// - [`GpuBuddy`] allocator for VRAM page table allocation.
 /// - [`pramin::Pramin`] for direct VRAM access.
+/// - [`Tlb`] manager for translation buffer flush operations.
 pub(crate) struct GpuMm<'gpu> {
+    buddy: GpuBuddy,
     pramin: pramin::Pramin<'gpu>,
+    tlb: Pin<KBox<Tlb<'gpu>>>,
 }
 
 impl<'gpu> GpuMm<'gpu> {
@@ -71,6 +82,7 @@ impl<'gpu> GpuMm<'gpu> {
     pub(crate) fn new(
         bar: Bar0<'gpu>,
         chipset: Chipset,
+        buddy_params: GpuBuddyParams,
         total_fb_end: VramAddress,
     ) -> Result<Self> {
         // PRAMIN covers all physical VRAM (including GSP-reserved areas
@@ -78,14 +90,26 @@ pub(crate) fn new(
         let vram_region = VramAddress::ZERO..total_fb_end;
 
         Ok(Self {
+            buddy: GpuBuddy::new(buddy_params)?,
             pramin: pramin::Pramin::new(bar, chipset, vram_region)?,
+            tlb: KBox::pin_init(Tlb::new(bar), GFP_KERNEL)?,
         })
     }
 
+    /// Access the [`GpuBuddy`] allocator.
+    pub(crate) fn buddy(&self) -> &GpuBuddy {
+        &self.buddy
+    }
+
     /// Access the [`pramin::Pramin`].
     fn pramin_mut(&mut self) -> &mut pramin::Pramin<'gpu> {
         &mut self.pramin
     }
+
+    /// Access the [`Tlb`] manager.
+    pub(crate) fn tlb(&self) -> &Tlb<'gpu> {
+        self.tlb.as_ref().get_ref()
+    }
 }
 
 /// Page size in bytes (4 KiB).
diff --git a/drivers/gpu/nova-core/mm/tlb.rs b/drivers/gpu/nova-core/mm/tlb.rs
new file mode 100644
index 000000000000..cc862e8159a1
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/tlb.rs
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! TLB (Translation Lookaside Buffer) flush support for GPU MMU.
+//!
+//! After modifying page table entries, the GPU's TLB must be flushed to
+//! ensure the new mappings take effect. This module provides TLB flush
+//! functionality for virtual memory managers.
+//!
+//! # Examples
+//!
+//! ```ignore
+//! use crate::mm::tlb::Tlb;
+//!
+//! fn page_table_update(tlb: &Tlb, pdb_addr: VramAddress) -> Result<()> {
+//!     // ... modify page tables ...
+//!
+//!     // Flush TLB to make changes visible (polls for completion).
+//!     tlb.flush(pdb_addr)?;
+//!
+//!     Ok(())
+//! }
+//! ```
+
+use kernel::{
+    io::poll::read_poll_timeout,
+    io::Io,
+    new_mutex,
+    prelude::*,
+    sync::Mutex,
+    time::Delta, //
+};
+
+use crate::{
+    bounded_enum,
+    driver::Bar0,
+    mm::VramAddress,
+    regs, //
+};
+
+bounded_enum! {
+    /// TLB invalidation acknowledgment scope.
+    ///
+    /// Controls how far the hardware waits for the invalidation to propagate
+    /// before clearing the `trigger` bit of `NV_TLB_FLUSH_CTRL`.
+    #[derive(Debug, Copy, Clone, PartialEq, Eq)]
+    pub(crate) enum TlbAckMode with TryFrom<Bounded<u32, 2>> {
+        /// Fire-and-forget: no acknowledgment required.
+        None = 0,
+        /// Wait for acknowledgment from all consumers, including remote GPUs
+        /// reachable over NVLink.
+        ///
+        /// Globally is strictly required only during unmap or permission
+        /// tightening, because the backing memory may be reassigned after the
+        /// flush returns and a stale TLB entry could let the GPU access freed
+        /// memory. For new mapping or relaxing permissions, a stale entry would
+        /// merely cause a redundant fault and retry, so [`TlbAckMode::None`]
+        /// would suffice.
+        Globally = 1,
+        /// Wait for acknowledgment from consumers within the local NVLink
+        /// fabric node only; skip cross-node ack.
+        Intranode = 2,
+    }
+}
+
+/// TLB manager for GPU translation buffer operations.
+#[pin_data]
+pub(crate) struct Tlb<'gpu> {
+    bar: Bar0<'gpu>,
+    /// TLB flush serialization lock: This lock is designed to be acquired during
+    /// the DMA fence signalling critical path. It should NEVER be held across any
+    /// reclaimable CPU memory allocations because the memory reclaim path can
+    /// call `dma_fence_wait()` (when implemented), which would deadlock if lock held.
+    #[pin]
+    lock: Mutex<()>,
+}
+
+impl<'gpu> Tlb<'gpu> {
+    /// Create a new TLB manager.
+    pub(super) fn new(bar: Bar0<'gpu>) -> impl PinInit<Self> {
+        pin_init!(Self {
+            bar,
+            lock <- new_mutex!((), "tlb_flush"),
+        })
+    }
+
+    /// Flush the GPU TLB for a specific page directory base.
+    ///
+    /// This invalidates all TLB entries associated with the given PDB address.
+    /// Must be called after modifying page table entries to ensure the GPU sees
+    /// the updated mappings.
+    pub(super) fn flush(&self, pdb_addr: VramAddress) -> Result {
+        let _guard = self.lock.lock();
+
+        // Write PDB address.
+        self.bar.write_reg(regs::NV_TLB_FLUSH_PDB_LO::from_pdb_addr(
+            pdb_addr.into_raw(),
+        ));
+        self.bar.write_reg(regs::NV_TLB_FLUSH_PDB_HI::from_pdb_addr(
+            pdb_addr.into_raw(),
+        ));
+
+        // Trigger flush.
+        self.bar.write_reg(
+            regs::NV_TLB_FLUSH_CTRL::zeroed()
+                .with_all_va(true)
+                .with_ack(TlbAckMode::None)
+                .with_trigger(true),
+        );
+
+        // Poll for completion.
+        read_poll_timeout(
+            || Ok(self.bar.read(regs::NV_TLB_FLUSH_CTRL)),
+            |ctrl: &regs::NV_TLB_FLUSH_CTRL| !ctrl.trigger(),
+            Delta::ZERO,
+            Delta::from_secs(2),
+        )?;
+
+        Ok(())
+    }
+}
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index bf1f3a97c632..9978fb2803b0 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -10,6 +10,7 @@
     sizes::SizeConstants,
     time, //
 };
+use pin_init::Zeroable;
 
 use crate::{
     driver::NovaRegisters,
@@ -26,6 +27,7 @@
         PFalconRegisters,
         PeregrineCoreSelect, //
     },
+    mm::tlb::TlbAckMode, //
 };
 
 // PBUS
@@ -471,3 +473,69 @@ pub(crate) mod gb202 {
         }
     }
 }
+
+// MMU TLB
+
+register! {
+    base: NovaRegisters;
+
+    /// TLB flush register: PDB address lower bits.
+    pub(crate) NV_TLB_FLUSH_PDB_LO(u32) @ 0x00b830a0 {
+        /// PDB address bits [39:8].
+        31:0    pdb_lo => u32;
+    }
+
+    /// TLB flush register: PDB address higher bits.
+    pub(crate) NV_TLB_FLUSH_PDB_HI(u32) @ 0x00b830a4 {
+        /// PDB address bits [47:40].
+        7:0     pdb_hi => u8;
+    }
+
+    /// TLB flush control register.
+    pub(crate) NV_TLB_FLUSH_CTRL(u32) @ 0x00b830b0 {
+        /// Invalidate every VA in the PDB selected by `NV_TLB_FLUSH_PDB_LO/HI`.
+        0:0     all_va => bool;
+        /// Invalidate TLBs for all PDBs (ignores `NV_TLB_FLUSH_PDB_LO/HI`).
+        1:1     all_pdb => bool;
+        /// Restrict the flush to the HUB MMU's TLBs; skip broadcasting to the
+        /// per-GPC L2 TLBs.
+        ///
+        /// The GPU MMU has a two-level TLB hierarchy:
+        /// 1. The *HUB MMU* sits at the top and serves memory requests from
+        ///    "host-side" engines: the host/channel interface, copy engines,
+        ///    display, and BAR1/BAR2 accesses.
+        /// 2. Each GPC (Graphics Processing Cluster — the block that houses
+        ///    shader cores / SMs) has its own L2 TLB that serves requests from
+        ///    the compute and graphics engines inside the cluster.
+        ///
+        /// When set, only the HUB TLBs are invalidated. This is a performance
+        /// optimization for flushes that only affect HUB-side mappings (e.g.
+        /// BAR1/BAR2 windows), where fanning the invalidation out to every
+        /// GPC's L2 TLB would be wasted work. Must be false when flushing
+        /// mappings that may be cached by compute/graphics engines.
+        2:2     hubtlb_only => bool;
+        /// Invalidation acknowledgment scope. See [`TlbAckMode`] for details.
+        8:7     ack ?=> TlbAckMode;
+        /// Write 1 to kick off the flush. Hardware clears this bit when the
+        /// flush completes; reads as 1 while the flush is in progress.
+        31:31   trigger => bool;
+    }
+}
+
+impl NV_TLB_FLUSH_PDB_LO {
+    /// Create a register value from a PDB address.
+    ///
+    /// Extracts bits [39:8] of the address and shifts it right by 8 bits.
+    pub(crate) fn from_pdb_addr(addr: u64) -> Self {
+        Self::zeroed().with_pdb_lo(((addr >> 8) & 0xFFFF_FFFF) as u32)
+    }
+}
+
+impl NV_TLB_FLUSH_PDB_HI {
+    /// Create a register value from a PDB address.
+    ///
+    /// Extracts bits [47:40] of the address and shifts it right by 40 bits.
+    pub(crate) fn from_pdb_addr(addr: u64) -> Self {
+        Self::zeroed().with_pdb_hi(((addr >> 40) & 0xFF) as u8)
+    }
+}

-- 
2.55.0

