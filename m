Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21E5C79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:01:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E9F110E07F;
	Wed,  9 Sep 2026 04:01:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="WMy4+7US";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011026.outbound.protection.outlook.com
 [40.93.194.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E96C10E07F
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:01:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCqcc+G1lK/MEIZ9opPECl94QK9QxD3ambM9HgN6TEq+gRAtItMk8qn2/FC0n9dt6mHY6J3NLoRFcTZ30UcpCGAiC0bdq1xdeHRfXxnSYwaBFO7/W1HW3datqUzTEnum/uKB9F48SKX+HpPYwDM3uaPAbgboJ8WmxUixGQuvam64yrUl0dNu96xsgsnokj2dRV5MNTdTyB+gpFu8iB0ykLaL2rU/su67HoYhJ7fub8Qo53ospFYRGYlT1zMXoflnkY64ulMbVVQj0uN0vonOsdGZ5URgJ2LheS/BdaBjKVCFQCiE+4sZQq4usrqAvQupna5rriMSfEUbuKdYesrH4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDSARerljZgu1Ih5Jw3k4TvWtnU+WAE2s2Akt6NMglE=;
 b=rEkLqXvotCu4y+yCCVJs+5ZudvttnZxIwWTLlmLGkR//gvTc1AxByE+euP711sKhyY3TDrzazO6CrmhHd7r2T17rACgdvVA2y7H6nuT9XnVF2IYNAOG6kpOla8htk9b+bYQK01h/GVM4gPXHRZ19rIQBitgBjUEL6SmahLPjfIVHsAe6xZs5LZGM0zNyKs4jpgSDuaC0dn7Ej0N4kqMb9gSGP5e+bo0TzsTsypl4qww3ON3IdZVoIOYOiX+RxBAW2ihqzbwNwowWc+diSSI4vArzSQay5MxBq2Fz0MaFQqpMwDCj76SYoAItf3CC63502dug6hRMZLb/Jj1lz+ay7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDSARerljZgu1Ih5Jw3k4TvWtnU+WAE2s2Akt6NMglE=;
 b=WMy4+7USY9jMix3B54HSp3HkUABF5bAPaTTmsJNusGUYTq/QOazo0/n8ETGn5vyGfY+05QHPIQCivb3wOf259LXHXIus6Gzw+zGsjFN6GSt1X6oxspkPWKx4jWh5Ob7ZxV0q6sNjXJtLT50fhDcbpbe2SQyyW6z6+6FLONCiIyMSGvmIIyqyUW1BSb5zy6cIbROArmjCO+FBwt4QpWPKTKk3mFXK/yiQdDJf4R9CP6d1RK4tXtxJePgelbuHvLv+SbEW9hwCAreM7mLQh/0RUo8m3bDwtRdmnVUPHePY1O0yMQkb0CnT95e3b2R3IG6hN2kzoHerGh4b/5wAF2bpTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS0PR12MB8070.namprd12.prod.outlook.com (2603:10b6:8:dc::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.7; Wed, 9 Sep 2026 04:00:53 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 04:00:53 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 09 Sep 2026 12:59:54 +0900
Subject: [PATCH 16/16] gpu: nova-core: mm: Add BAR1 memory management
 self-tests
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-mmrebase-v1-16-8dd5d4225d2e@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0111.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::10) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS0PR12MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: 3517869c-18c6-4a08-94e5-08df0e26f1a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|10070799003|376014|366016|10067099003|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 44msYEh8j5g6IBxV0+3nxM3AwQT2kbj3He138hwh90/ZATarfIyP0kCO46t0KMZRLyWyld2Qv9vWSUgERerWSiINDH0uI3Rw6BMkkWPk4qyMBoRTQZKP/ArMONiVSdKOyuxWECya+3ryKo4IewnZJHsjIiL2NFb997cKbsMPQwMAwCHzcMkOhsmYa9wU1Qb+Dvo8Sy2j+rSaGUCe/9AjuRvLbfWj1DA0m1fELHnKQ19cEUfq0dBIITUEU0Mu3p5S+7l3mm32fRqRraY6LhOhqIjK4d1od5Lbuj/YrQiC/RLF+3wrQDUqYqKXL58rqKDtP+T5OyDce7gorSs6F91MSafpNWSG+L4rqM6jLRl2wCixHOyWkNAVtxUYzaUxThKpViSDrEFZdtAvDM4b3FXNrRvqclyuheT62Z7NUsi1Wqa+JGmc9Vb7ZecPZhCltFO5BAY8YmrffIVZM/5TBzm8dj3Ohz7dSzJPwQePspNx14AHET51Q+apBpSOqXBkYPlD/do2+X4fMyY0EJ0/qZB/nuB80nKo27qur/EvURXrAhsV6pAWvwm8dDUWW4lEd8tcaW/hyY3bTY0lnjkERnrCqOEH5Fl7TJICxr4AEilZWrahJEDZWEFQcDG3cGSgdxftiVkeByBtYdqXVdvqBMVmjedbQ/bpv9US5eAsBfumC7o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(10070799003)(376014)(366016)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDdkUnhkMGRHbnBHdkE4SXhMR1M2VFloZ0RVaktCL0tRQ1lFOUtLVlQxYkNW?=
 =?utf-8?B?Q2lxeFd1QndNenNvemxQWVRDQmo0SmRVLzZIUS80TFYzNEZ2UjNid1FEN2V2?=
 =?utf-8?B?RHFqNmEzSnl0VGh1SWtwSzFXakIra1gxZUZDa05XM08veFJrNDl4L3c2N1Bp?=
 =?utf-8?B?MThickt3QVU3dC9XRStwbGVkV2ZFa05TQTkrVlN3S2krdmhTdWVaMGpFTEJk?=
 =?utf-8?B?a3hHbmtqNmllME15OEZRalBUTU1VL1o0eDFVQnk2NUUzcGpyaStnNFBlUmQv?=
 =?utf-8?B?UmdFMmE1RXExSmoxV1B1T1I5OTM5OXdiQ3VEQUJTVjJWdTZFcDE5UWRtSTNQ?=
 =?utf-8?B?R09SaEJEWloxclloWG1xZ21sL1IrMzJCYUVtL1NZNC8xQUIvaXZvaURoWStI?=
 =?utf-8?B?cGVQZXFIZXlZcWczQWk2M0RZZGtDYTQwWXVhWGloRy9INWVRbloyUmloVnFv?=
 =?utf-8?B?VXZvbTdFMXpuSWdLRkFpcVN6cXVxcFh2K1hzdEFvT3NRTktvS3NReWpUZ3dx?=
 =?utf-8?B?V054ODZyQ2ExTGY5L3h2eTM4OFEzeVo3RTBDVEVvS1o2WmJ6UFRFcisrRzR2?=
 =?utf-8?B?d2ljNmNkeFBzQTBvSzFLaGUrVUY5RW5HdldpZDlUanYzeTZEVE56N3pXQ0wy?=
 =?utf-8?B?bE9tTFkwaWRjMlgxNXhWR09MMDJPa3NEWlB2TjA0ZktmMWVqeDlWVUNYckRl?=
 =?utf-8?B?bTlLVFQ1dzFGM3J4ZU1ZUktCWC8xSXZLTm12bnhQam5XN1R0ejlZY01lUWxx?=
 =?utf-8?B?dzFBb1FHV1dKdkNYVzBma3FrL09BQk53a0xqRFZWTzk2VGl3Y2dpdHNzZCtS?=
 =?utf-8?B?WHFuTGJxOTllQlYzUlE3Vzc1ZVZta0J2b1R2R1hCbysyU3Z0d3pYVlJhajAw?=
 =?utf-8?B?Sy9tSzRsZ3RaNzBOb1ZpdFZJajFVRUpvWXZLVGZydWZuY2NJbGQxQjhvNGsy?=
 =?utf-8?B?L3pZVHhOZ0tKQzZTcEdMc2NObDlkOVZKbHdSalpxZVM3QkUzam1OTDVIbkVB?=
 =?utf-8?B?S2NBdHhpcEFDSDIwYmU0Y0xCWW96bnpmM0M1Y2lPc0YrMnZRWDNaKzQ1NTNJ?=
 =?utf-8?B?MitleDVrVytVYmRXc1FVUXBqcWNKVUxMcUNiaDg2YXVKS250RGgrbG9ySVFH?=
 =?utf-8?B?TUdCUTRPU3lQQ2R6RGdlQzVTeEh4OERldnFKSDh6VEZSWDRhUXR2Yk1BTlZi?=
 =?utf-8?B?ZkI4WDkxN2lpV1R6NEt5bmhMT3hCNytOV2Rva2oyRkJneEhLcnA1QkpyNmJ5?=
 =?utf-8?B?bmVoS1VDSGVZVllpWTEyVFM5N2syOEx4VTBWZUhjUjFPOGdsZ3krTG5yVkp5?=
 =?utf-8?B?c1V1MUN6YTM1Z0dOS2Y5b2Q2V0tBNThwZDlhaVczOGJBeWdLWTU3R3VRRlJH?=
 =?utf-8?B?SGNWR0RGc1dTUFRDU29tS2w4MllTOE5VMTFYVElGcGNhbnVtY3VKVjFMQ0Zj?=
 =?utf-8?B?T3kwVUJLc01ZM1dNaUM1N0xLVTIzNXpTYVhGVEVCV0lXUitGOGZNTlNPZVJ6?=
 =?utf-8?B?MlZ3SFFVK3BqRGo3YkpXNWt2ZE9VY2RBNForNURGZW1Rb0EzSlVwOXlQS0Jy?=
 =?utf-8?B?aC9kREhkVmVSdHQ2K1hUSDFxRFlDUC9lSVAvbVJwSmw0MUJWS0JCNnNYa2Va?=
 =?utf-8?B?N1cxZ3lqNXpBN0hUL01SNXBnWUFtTklxR1BNK2U0K05yaWwrNWNsYW1KME9i?=
 =?utf-8?B?aWRRTDNIQWNpb25lYnBNMjF4TTJVdzZEMXUyV2ZWRTBhR1h6U3FaSFlITXRE?=
 =?utf-8?B?T1JJVVlwTzRyL0FiS3J0dGVwM09hUlovejVtRDc4UUQ2TjYraFMxZUlIQTZQ?=
 =?utf-8?B?aE1SVE0wUUNyampJMXdhd3FTT200VEtzTWp0aEJuTXVSVDRvSkVmY3ZsSWZL?=
 =?utf-8?B?eldYUXdhM1ZscjRBNW11bm9na25QZERmWndPUVlTMFIxOW53U3ZEbWs0VkYr?=
 =?utf-8?B?ejVoWHVPL2dZV1Y3VlptVEJtZ1UvQWJ3RVdSOHhITlVCemlDclg1VFg3VURu?=
 =?utf-8?B?ZFZZZWg3dTI3VC9mcFdTU055TVcwbm44T3VhM2VXZmh4c3NtRVVYbDVjUUU2?=
 =?utf-8?B?QVJlWERyY2hidHIwYXh5UWtKNE0wZEhTZlFQaXc4eDdrTVRzM0pndG1LazN5?=
 =?utf-8?B?L2o1eGxEdFZvakdSdDFKM2RPYWR0TFRlT0p6dVYrWldiWm1SeEU4NXJqOG1n?=
 =?utf-8?B?ZzNiNUtWd0p5akNqN0xqRm9hTGFGbkFjRXI3OVZBVkM4UytRSGdyR3JRWHhx?=
 =?utf-8?B?QzU5NUdWZUI5b01sQ3NXOTY5SUU0SndVcE9ZdmtaZ2E3Ym8yYlFGSm1vd1h5?=
 =?utf-8?B?WHVhSFVtVm45QmFsL29aY1huK0g5UWtIRCtZMm5rT3FOc2w3akVENjRMWWV1?=
 =?utf-8?Q?vEgOKZwoBYzseqMm2Az6EH3h+rpdHQyPDXMTcqhBnLV1S?=
X-MS-Exchange-AntiSpam-MessageData-1: xM2IBFIuKQwXqg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3517869c-18c6-4a08-94e5-08df0e26f1a1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 04:00:53.6493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+mX+zZ/uY3cEm0eggrJBWCBpEE2cY5E1ut2swDWXXPfSkSjKv6TpKqVgQhiAhUq1JZfP4m2aAGYPkCeRCnUqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8070
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

Add self-tests for BAR1 access during driver probe when
CONFIG_NOVA_CORE_SELFTESTS is enabled (default disabled). This results in
testing the Vmm, GPU buddy allocator and BAR1 region all of which should
function correctly for the tests to pass.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[ecourtney: use existing self-test runner and CONFIG_NOVA_CORE_SELFTESTS]
[ecourtney: update for mutable GpuMm, PRAMIN views and VramAddress raw API]
[ecourtney: restore the conditional dead_code expect]
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs          |   9 +-
 drivers/gpu/nova-core/mm.rs           |  12 +-
 drivers/gpu/nova-core/mm/bar_user.rs  | 251 ++++++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/mm/pagetable.rs |  24 ++++
 drivers/gpu/nova-core/mm/vmm.rs       |   1 +
 5 files changed, 293 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index f72a92e045e5..f5bdfdea803a 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -482,7 +482,14 @@ pub(crate) fn run_selftests(self: Pin<&mut Self>, pdev: &pci::Device<device::Bou
         let dev = pdev.as_ref();
         let regions = &this.gsp_static_info.usable_fb_regions;
 
-        if let Err(err) = crate::mm::selftest::run(dev, this.mm, regions) {
+        if let Err(err) = crate::mm::selftest::run(
+            dev,
+            this.mm,
+            regions,
+            this.bar_user,
+            this.gsp_static_info.bar1_pde_base,
+            this.spec.chipset,
+        ) {
             dev_err!(dev, "self-tests failed: {:?}\n", err);
         }
     }
diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index e04497256519..a5bc4042577b 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -3,7 +3,7 @@
 
 //! Memory management subsystems.
 
-#![expect(dead_code)]
+#![cfg_attr(not(CONFIG_NOVA_CORE_SELFTESTS), expect(dead_code))]
 
 /// Implements `From` conversions between a frame-number type and `Bounded<u64, N>`.
 ///
@@ -202,6 +202,7 @@ pub(crate) struct VirtualAddress(u64) {
 
 impl VirtualAddress {
     /// Create a new virtual address from a raw value.
+    #[expect(dead_code)]
     pub(crate) const fn new(addr: u64) -> Self {
         Self::from_raw(addr)
     }
@@ -297,7 +298,8 @@ pub(crate) mod selftest {
 
     use kernel::{
         device,
-        sizes::SizeConstants, //
+        sizes::SizeConstants,
+        sync::Arc, //
     };
 
     use super::*;
@@ -307,6 +309,9 @@ pub(crate) fn run(
         dev: &device::Device<device::Bound>,
         mm: &mut GpuMm<'_>,
         usable_fb_regions: &[Range<u64>],
+        bar_user: &Arc<bar_user::BarUser<'_>>,
+        bar1_pdb: u64,
+        chipset: Chipset,
     ) -> Result {
         // VRAM span the self-tests are free to overwrite, from the chosen test base.
         const SELFTEST_SPAN: u64 = u64::SZ_64M;
@@ -325,6 +330,7 @@ pub(crate) fn run(
             return Ok(());
         };
 
-        pramin::selftest::run(dev, mm.pramin_mut(), VramAddress::from_raw(base))
+        pramin::selftest::run(dev, mm.pramin_mut(), VramAddress::from_raw(base))?;
+        bar_user::run_self_test(dev, mm, bar_user, bar1_pdb, chipset)
     }
 }
diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core/mm/bar_user.rs
index ef1d8e6f8c9c..1bef01d147ad 100644
--- a/drivers/gpu/nova-core/mm/bar_user.rs
+++ b/drivers/gpu/nova-core/mm/bar_user.rs
@@ -31,6 +31,9 @@
     num::IntoSafeCast,
 };
 
+#[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
+use kernel::device;
+
 /// BAR1 user interface for virtual memory mappings.
 ///
 /// Owns the [`Vmm`] for the BAR1 address space.
@@ -84,6 +87,7 @@ pub(crate) struct BarUserAccess<'gpu> {
     mapped: Option<MappedRange>,
 }
 
+#[expect(dead_code)]
 impl BarUserAccess<'_> {
     /// Tear down the BAR1 mapping.
     pub(crate) fn release(mut self, mm: &mut GpuMm<'_>) -> Result {
@@ -169,3 +173,250 @@ fn drop(&mut self) {
         // identifying the leaked VA range.
     }
 }
+
+/// Run MM subsystem self-tests during probe.
+///
+/// Tests page table infrastructure and `BAR1` MMIO access using the `BAR1`
+/// address space. Uses the `GpuMm`'s buddy allocator to allocate page tables
+/// and test pages as needed.
+#[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
+pub(crate) fn run_self_test(
+    dev: &device::Device<device::Bound>,
+    mm: &mut GpuMm<'_>,
+    bar_user: &Arc<BarUser<'_>>,
+    bar1_pdb: u64,
+    chipset: Chipset,
+) -> Result {
+    use kernel::gpu::buddy::{
+        GpuBuddyAllocFlags,
+        GpuBuddyAllocMode, //
+    };
+    use kernel::ptr::Alignment;
+    use kernel::sizes::{
+        SZ_16K,
+        SZ_32K,
+        SZ_4K,
+        SZ_64K, //
+    };
+
+    // Test patterns.
+    const PATTERN_PRAMIN: u32 = 0xDEAD_BEEF;
+    const PATTERN_BAR1: u32 = 0xCAFE_BABE;
+
+    let bar1 = bar_user.bar1;
+    dev_info!(dev, "MM: Starting self-test...\n");
+
+    let pdb_addr = VramAddress::from_raw(bar1_pdb);
+
+    // Check if initial page tables are in VRAM.
+    if crate::mm::pagetable::check_pdb_valid(mm.pramin_mut(), pdb_addr, chipset).is_err() {
+        dev_info!(dev, "MM: Self-test SKIPPED - no valid VRAM page tables\n");
+        return Ok(());
+    }
+
+    // Set up a test page from the buddy allocator.
+    let test_page_blocks = KBox::pin_init(
+        mm.buddy().alloc_blocks(
+            GpuBuddyAllocMode::Simple,
+            SZ_4K.into_safe_cast(),
+            Alignment::new::<SZ_4K>(),
+            GpuBuddyAllocFlags::default(),
+        ),
+        GFP_KERNEL,
+    )?;
+    let test_vram_offset = test_page_blocks.iter().next().ok_or(ENOMEM)?.offset();
+    let test_vram = VramAddress::from_raw(test_vram_offset);
+    let test_pfn = Pfn::from(test_vram);
+
+    // Create a VMM of size 64K to track virtual memory mappings.
+    let mut vmm = Vmm::new(pdb_addr, chipset.mmu_version(), SZ_64K.into_safe_cast())?;
+
+    // Create a test mapping.
+    let mapped = vmm.map_pages(mm, &[test_pfn], None, true)?;
+    let test_vfn = mapped.vfn_start;
+
+    // Pre-compute test addresses for the PRAMIN to BAR1 read test.
+    let vfn_offset: usize = test_vfn.raw().into_safe_cast();
+    let bar1_base_offset = vfn_offset.checked_mul(PAGE_SIZE).ok_or(EOVERFLOW)?;
+    let bar1_read_offset: usize = bar1_base_offset + 0x100;
+    let vram_read_addr = test_vram + 0x100;
+
+    // Test 1: Write via PRAMIN, read via BAR1.
+    mm.pramin_mut()
+        .window_at::<u32>(vram_read_addr)?
+        .view()
+        .write_val(PATTERN_PRAMIN);
+
+    // Read back via BAR1 aperture.
+    let bar1_value = bar1.try_read32(bar1_read_offset)?;
+
+    let test1_passed = if bar1_value == PATTERN_PRAMIN {
+        true
+    } else {
+        dev_err!(
+            dev,
+            "MM: Test 1 FAILED - Expected {:#010x}, got {:#010x}\n",
+            PATTERN_PRAMIN,
+            bar1_value
+        );
+        false
+    };
+
+    // Cleanup - invalidate PTE.
+    vmm.unmap_pages(mm, mapped)?;
+
+    // Test 2: Two-phase prepare/execute API.
+    let prepared = vmm.prepare_map(mm, 1, None)?;
+    let mapped2 = vmm.execute_map(mm, prepared, &[test_pfn], true)?;
+    let readback = vmm.read_mapping(mm, mapped2.vfn_start)?;
+    let test2_passed = if readback == Some(test_pfn) {
+        true
+    } else {
+        dev_err!(dev, "MM: Test 2 FAILED - Two-phase map readback mismatch\n");
+        false
+    };
+    vmm.unmap_pages(mm, mapped2)?;
+
+    // Test 3: Range-constrained allocation with a hole — exercises block.size()-driven
+    // BAR1 mapping. A 4K hole is punched at base+16K, then a single 32K allocation
+    // is requested within [base, base+36K). The buddy allocator must split around the
+    // hole, returning multiple blocks (expected: {16K, 4K, 8K, 4K} = 32K total).
+    // Each block is mapped into BAR1 and verified via PRAMIN read-back.
+    //
+    // Address layout (base = 0x10000):
+    //   [    16K    ] [HOLE 4K] [4K] [ 8K ] [4K]
+    //   0x10000       0x14000  0x15000 0x16000 0x18000 0x19000
+    let range_base: u64 = SZ_64K.into_safe_cast();
+    let sz_4k: u64 = SZ_4K.into_safe_cast();
+    let sz_16k: u64 = SZ_16K.into_safe_cast();
+    let sz_32k_4k: u64 = (SZ_32K + SZ_4K).into_safe_cast();
+
+    // Punch a 4K hole at base+16K so the subsequent 32K allocation must split.
+    let _hole = KBox::pin_init(
+        mm.buddy().alloc_blocks(
+            GpuBuddyAllocMode::Range(range_base + sz_16k..range_base + sz_16k + sz_4k),
+            SZ_4K.into_safe_cast(),
+            Alignment::new::<SZ_4K>(),
+            GpuBuddyAllocFlags::default(),
+        ),
+        GFP_KERNEL,
+    )?;
+
+    // Allocate 32K within [base, base+36K). The hole forces the allocator to return
+    // split blocks whose sizes are determined by buddy alignment.
+    let blocks = KBox::pin_init(
+        mm.buddy().alloc_blocks(
+            GpuBuddyAllocMode::Range(range_base..range_base + sz_32k_4k),
+            SZ_32K.into_safe_cast(),
+            Alignment::new::<SZ_4K>(),
+            GpuBuddyAllocFlags::default(),
+        ),
+        GFP_KERNEL,
+    )?;
+
+    let mut test3_passed = true;
+    let mut total_size = 0usize;
+
+    for block in blocks.iter() {
+        total_size += IntoSafeCast::<usize>::into_safe_cast(block.size());
+
+        // Map all pages of this block.
+        let page_size: u64 = PAGE_SIZE.into_safe_cast();
+        let num_pages: usize = (block.size() / page_size).into_safe_cast();
+
+        let mut pfns = KVec::new();
+        for j in 0..num_pages {
+            let j_u64: u64 = j.into_safe_cast();
+            pfns.push(
+                Pfn::from(VramAddress::from_raw(
+                    block.offset() + j_u64.checked_mul(page_size).ok_or(EOVERFLOW)?,
+                )),
+                GFP_KERNEL,
+            )?;
+        }
+
+        let mapped = vmm.map_pages(mm, &pfns, None, true)?;
+        let bar1_base_vfn: usize = mapped.vfn_start.raw().into_safe_cast();
+        let bar1_base = bar1_base_vfn.checked_mul(PAGE_SIZE).ok_or(EOVERFLOW)?;
+
+        for j in 0..num_pages {
+            let page_bar1_off = bar1_base + j * PAGE_SIZE;
+            let j_u64: u64 = j.into_safe_cast();
+            let page_phys = block.offset()
+                + j_u64
+                    .checked_mul(PAGE_SIZE.into_safe_cast())
+                    .ok_or(EOVERFLOW)?;
+
+            bar1.try_write32(PATTERN_BAR1, page_bar1_off)?;
+
+            let pramin_val = mm
+                .pramin_mut()
+                .window_at::<u32>(VramAddress::from_raw(page_phys))?
+                .view()
+                .read_val();
+
+            if pramin_val != PATTERN_BAR1 {
+                dev_err!(
+                    dev,
+                    "MM: Test 3 FAILED block offset {:#x} page {} (val={:#x})\n",
+                    block.offset(),
+                    j,
+                    pramin_val
+                );
+                test3_passed = false;
+            }
+        }
+
+        vmm.unmap_pages(mm, mapped)?;
+    }
+
+    // Verify aggregate: all returned block sizes must sum to allocation size.
+    if total_size != SZ_32K {
+        dev_err!(
+            dev,
+            "MM: Test 3 FAILED - total size {} != expected {}\n",
+            total_size,
+            SZ_32K
+        );
+        test3_passed = false;
+    }
+
+    // Release Tests 1-3's Vmm before Test 4 constructs a fresh BarUser on
+    // the same PDB.
+    drop(vmm);
+
+    // Test 4: Exercise `BarUser::map()` end-to-end.
+    let bar_user = Arc::pin_init(
+        BarUser::new(pdb_addr, chipset, SZ_64K.into_safe_cast(), bar1)?,
+        GFP_KERNEL,
+    )?;
+    let access = bar_user.map(mm, &[test_pfn], true)?;
+
+    // Write pattern via PRAMIN, read via BarUserAccess.
+    mm.pramin_mut()
+        .window_at::<u32>(test_vram)?
+        .view()
+        .write_val(PATTERN_BAR1);
+
+    let readback = access.try_read32(0)?;
+    let test4_passed = if readback == PATTERN_BAR1 {
+        true
+    } else {
+        dev_err!(
+            dev,
+            "MM: Test 4 FAILED - Expected {:#010x}, got {:#010x}\n",
+            PATTERN_BAR1,
+            readback
+        );
+        false
+    };
+    access.release(mm)?;
+
+    if test1_passed && test2_passed && test3_passed && test4_passed {
+        dev_info!(dev, "MM: All self-tests PASSED\n");
+        Ok(())
+    } else {
+        dev_err!(dev, "MM: Self-tests FAILED\n");
+        Err(EIO)
+    }
+}
diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-core/mm/pagetable.rs
index ffc69fbdb067..de2f8ea5aeef 100644
--- a/drivers/gpu/nova-core/mm/pagetable.rs
+++ b/drivers/gpu/nova-core/mm/pagetable.rs
@@ -396,3 +396,27 @@ fn from(val: AperturePde) -> Self {
         Bounded::from_expr(val as u64 & 0x3)
     }
 }
+
+/// Check if the PDB has valid, VRAM-backed page tables.
+#[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
+fn check_pdb_inner<M: MmuConfig>(pramin: &mut pramin::Pramin<'_>, pdb_addr: VramAddress) -> Result {
+    let raw = pramin.window_at::<u64>(pdb_addr)?.view().read_val();
+
+    if !M::Pde::from_raw(raw).is_valid_vram() {
+        return Err(ENOENT);
+    }
+    Ok(())
+}
+
+/// Check if the PDB has valid, VRAM-backed page tables, dispatching by MMU version.
+#[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
+pub(super) fn check_pdb_valid(
+    pramin: &mut pramin::Pramin<'_>,
+    pdb_addr: VramAddress,
+    chipset: crate::gpu::Chipset,
+) -> Result {
+    match MmuVersion::from(chipset.arch()) {
+        MmuVersion::V2 => check_pdb_inner::<MmuV2>(pramin, pdb_addr),
+        MmuVersion::V3 => check_pdb_inner::<MmuV3>(pramin, pdb_addr),
+    }
+}
diff --git a/drivers/gpu/nova-core/mm/vmm.rs b/drivers/gpu/nova-core/mm/vmm.rs
index 411710d03f7a..51b500a27233 100644
--- a/drivers/gpu/nova-core/mm/vmm.rs
+++ b/drivers/gpu/nova-core/mm/vmm.rs
@@ -126,6 +126,7 @@ fn drop(&mut self) {
 /// Directory Base (`PDB`) address. Used for Channel, BAR1 and BAR2 mappings.
 pub(crate) struct Vmm {
     /// Page Directory Base address for this address space.
+    #[expect(dead_code)]
     pdb_addr: VramAddress,
     /// Page table walker for reading existing mappings.
     pt_walk: PtWalk,

-- 
2.55.0

