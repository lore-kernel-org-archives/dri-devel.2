Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9A5C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 991D110E46E;
	Tue,  7 Jul 2026 07:22:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="K+lbbwxk";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011024.outbound.protection.outlook.com
 [40.93.194.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CD2210E46E
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:22:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgHXs/U9FBw8IjBorf5rcF1kiDmF63+xIbxXixLlowcUjMbNkIXKh7STJojh5LESo93SEGZe5e0VL6iU82tr4JyERxI+zuaV8v+nV1W8g5F8YyMDr8j1q6NB35BBW5mgiVXh4o1LJiGvzny8AaqSLg6OCyU7i7WM3lBep/2BDfknG+eWptfNfl+J/+ZwqsyJPWKKnTPTEULb4KEzSpHtMD2CiJS6sJ7JS1QsS7yXB+3sh1zvcQ/UIeYwnsfjwtimeZjZEfQs/LH7IHaQicrybh1TGfYo9qjyAbYf3jOOo79LREGpQL+Pdoah10vsPHUoJDzs0dGZ0R4t6lyozJ2B+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9CWUdgOdkNLiWAhu+bxQ5VHNtP04g9fqeDFSrmEg5JM=;
 b=DBkQP0l+StpcsnnfDbsJnoLO6kH7In5jjcIKZjuyBp069nSFv4YScNOBknIHHuZaycDFxD+a1xv8OTalp1dDG5lroi/R7sn/xD8mz5l8vAqQ8uPAMObHBNI60KGT9xd94S3DXXd+maVwX+fzGDe4+UiNSI7AesG63pCzTao+vpXbem38Ud5AnvK6jYWC5oN786ppcZPG/zQdxJkovqSKe8k1FnhNrQPMOzs5jZFvoolYjPmW2GExG9NeORBB0maQcNBPNCgiyHmygdR/dYR72L1Wk17n7Ix3R+tdMpF5TaBobZByezMKapDg+cke7SXY8yYMvo4HfcfGvfNj+/w91Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CWUdgOdkNLiWAhu+bxQ5VHNtP04g9fqeDFSrmEg5JM=;
 b=K+lbbwxkhPtuImhxai/Yqkuc2jbqWcK5YuTEEoHMfBRm6v5KqLcatQMpxpQYwHhf5vS148WDj74ATr/76akB15ch8MsniMoRPVfRQbDIxO+Ersgu4+Jnbz5Fa7ROCXwD0YA1fm1PFMycA7K39DcMpJ4MpiESOjyN38kjf7fB2st8aKZlsX8QpjpY4lJXF/igE2jqqavQyFSB8/JXi9bj0B2/m2blHwLLhlZfvUmUICsowhROmUs1U1IGzrcVZ1z0l/2yAF9ZT1u1OrBjKxpUqeRiGKnjpJ1DvDjG1O5XXvdI1r9/GEDAgt70UB6uDRretDV/TXh1OaydVS86A34sDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 07:22:10 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 07:22:10 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 07 Jul 2026 16:21:37 +0900
Subject: [PATCH v5 04/13] gpu: nova-core: gsp: pass GspBootContext to
 unload methods
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-nova-bootcontext-v5-4-ecad9346387f@nvidia.com>
References: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
In-Reply-To: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0367.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: bc69232d-22dd-4744-7a45-08dedbf87576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10070799003|18002099003|921020|22082099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: 9+0aV7u88svJ0wScO+5zxYLDxoQtoCphRfqDK0ahnCa64G9V9F2gh9ctW9sryZu2llppTalo45aKudtRIOphessJX71u5gc2ybVtt1NG+v+CzgdsI24xDuoDd2yRo/PM8sed82vb+CN6rh5/6dLcl4FHs6mDOxzNgxHzLjiyafQmeZtt8idhSjvJO7RoV4HFS6cito+NestmcYdKagPcaRKkwKXmBQd25LAeky/6cfY7Xt0EtrHJlIitQG2CQHiYIgMfzfexCF0DqgTzLXAjXHPR+9pa9FtkxkY7uphIgMMmjdihAi1lhfb0fviI4dQiydZ+OJ0xMxWJueLUaVn9GJAhsSTy1pypxkeb2FVIbewyLri81PX3ha4pGHBOhF+Z/1i40Uiyumb6ZUs6nmiowH38Vyx8MyT8t8vRTLkazMbwVck/MOFO4VrD84lzfVqmpJLFDEEh8TLl2LYQJMB6H4P+ZdJmDhBaCXywjrXKVEPDWi5eaeoSaZw0mYxy9cpGCIoqkSv13U7oBEo499Y7O6kAOPmERXTkW5Y6FiUG+ZREpOadIdGFZlkdZTsqJTqPvNSJ0UVhZsKBFMRQ9Sspr2JxDbGzcLy2UxTRiaGdT37aUgffkJ9f5d3QLBHMlDBufJ0CT6YhAJZxbCGaVeIzWOBEUNNVFOJNNT/TtZvX7W8BXvvaw4aSZeOQRMnPcat2CoOAEg+jBE1tjTj8gmP/pQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10070799003)(18002099003)(921020)(22082099003)(11063799006)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3RIUlpqUVIyZGN0N04rMFZKTDRlRmg1Y3FBVFUxeGpFbnR0UTNiblk0ZGxq?=
 =?utf-8?B?US9pNVFlcEYzcFhodURXZktyZVRmK3RjaFRLL205U1RDaDdhWGtBdUx3aDRm?=
 =?utf-8?B?TkY0aWtHcmIzaTVkdWo1bW1FZ281SXNLK3hKRVQ3U1FqMGFTRnVQdFhGY0Vx?=
 =?utf-8?B?d3BlN1VsdUNwdlhmRTJLTzhUT2pCeWVwdWhIaWRIUitaUkVYTEFuaGkyaDZm?=
 =?utf-8?B?OWJ0eGRuQXJaMm9sSXd1T0M1U293eDFmbDVIOVVTZVpBUEp3OEF4ZVJzT0I5?=
 =?utf-8?B?ajFzRWdmUlZVWndqYkZVT24rNERydjF4aWdUVGdoMUZGZ1VKV3pqQTdjMURM?=
 =?utf-8?B?aWlKczZya21aN3RIQlRpU1JWcDBxUTRvb3hzVnJiR1kvQ1BvZFdjTWVGL2dm?=
 =?utf-8?B?dGd1ZDY4YjhIellzd09zYzU2c0VPWTQvYVpQaENwV1hRVHhWeW5IOURCdmJU?=
 =?utf-8?B?aFBDUzFPUm1uSW1uOFVTQmZXM0NNUUFyRUJOL1N5b3VxU2FrVkxGTzZwekh0?=
 =?utf-8?B?TnBXTzRDNzZRR3pKaE5LWHdqaFFrL0w5WEtyV25QQnJleWw3dm1Rck1tMUli?=
 =?utf-8?B?NWx2QXUrVmEvRGdTNi9aSDhwN3poL2ovK0h6bDk0c0lqVldPS0VkdlpoLzlq?=
 =?utf-8?B?VWFBM2xPbzVoR0hVVUIzYTZ5WWQ2THZqWWVUZVNaR21FSG02RWhmc21venh6?=
 =?utf-8?B?L3d5a29DVGYwN1ZUVkozT0RTeExpOXNVV2dKMEJGakJPdlNsaVFMdzM3Nm1y?=
 =?utf-8?B?NDAzNHk3Y3Ewb3lhTnlueDEzU1NxcCsrV0VwLzhhNmN1ZXA1WTBFdFRDbmNn?=
 =?utf-8?B?aGNBMnNvcnltWjE3N1M0cVRQaHFYSGgzczZMUU9IQktReUZQbll0ekxWKzBv?=
 =?utf-8?B?Wnk4S3RPelVRT1htTDd6VloraEFKYzJUYWd5Y0lPZTdjcm04VGhYY1l5NnhK?=
 =?utf-8?B?clQ4YitmMndrdXdSeXpxNVgzYUF0WTJGNlpDNlVpY0c3SHRMMHZTUUVKc1lQ?=
 =?utf-8?B?ZEJzWWZkdUR5RlBFb2dFd3RtN0NvS0EzVVRlVVlSZFRtZ002ZlJPeTVLanI1?=
 =?utf-8?B?aWRPVk92cjhDNTl5SC9LZFFOdDdxS2hJckNwK09Fc2dvcHMyNXl1SldQSFR5?=
 =?utf-8?B?NGR3bjdwWGQ5Rjg0VjQ5bVBYaDNVbXN1MUN5ZzVYcGJKaTNCdjc1Wng4Y3VF?=
 =?utf-8?B?c1Fza3ZIT0dpem1oQlpKQ25kSVh4Zm5MLzZUajN6Qm9YQXpycTVWalFneVMr?=
 =?utf-8?B?SXB4QzVTQWp2WGNnRFgwUDdaRWthWmZFRm00Qm02Q0REenAzYTlNbzA0ekJa?=
 =?utf-8?B?WHJrQ2Z4OVVzKzVLcmZtRi9iR2Jkcy9DeEYyUWFLTXBjdjFsMUYvUVhEV3pB?=
 =?utf-8?B?a29oMkcxTHhRZjJiekprTFVHSnMza3BTRjJLNUdUcHRja3JYaUlBdnhZRzlP?=
 =?utf-8?B?S2taalp4YVd3QWJhQ0pUY1c3aUZDMThtaDdUZGZRSzlrNVhtUnZ1aTVyRndW?=
 =?utf-8?B?K2hLbUF4eVQyQ0xCcjBrcDdtWTh3VWRCMVp1ZFJBOUJrellmd3pZK1NuN3Ew?=
 =?utf-8?B?Y1BQY1FyK1NIR2VkRjIxSjNrZGlUWDRCSE5oSFJxb1E1MGppWXEyUjBFSjFT?=
 =?utf-8?B?N2FyTkNCdmRPOENqeTFhbnorNE9ieVM4R2JxZUNmdm1wTEhmQmxja2FwV2c4?=
 =?utf-8?B?cTJGL1VjL0NYbUlHWGZEQkp4eWRKbjBIMGx2L2c3MVNpK015bTZaYmI3Qjcz?=
 =?utf-8?B?RWRmNmlraTVwQnhGYkdFWmJESUNTa1lEL2NCTGdTN1d2WTNYUlRXWW5LV1B5?=
 =?utf-8?B?aHpjakdUMTZyeWFBTGptSVQ0VG0yU0E4cU1aKytJV3d3N0NmRlVrRnlvOFQ4?=
 =?utf-8?B?V1JoOFdNemRJUHkrbHY4RWYvZStzMVhsUW81TmE0RDZISmRzN01HaXRMT1dj?=
 =?utf-8?B?cDVJYlhJNm1KZXlDZGdXaFdxYXBSdkZvd2c4d1FFUW1YeFBpdVM3SlZQcVpH?=
 =?utf-8?B?NnBqS2VqTlg1YTR1bWFqZ0xucytkQ3grZytHWkhLd3hES2kvMHdzYTl2UUVh?=
 =?utf-8?B?dHdMYjBvd3N4dTNJZG4zcFkyRE1pYUN4WlpTeHNhZnJydXRnZVQ4Ymt6KzRw?=
 =?utf-8?B?ZlQ4Uk9vbnNBU0lNTTNZWHVhWVpucld4c0R4QlV0UUlBM3pYSldveFEzTDVC?=
 =?utf-8?B?aU5ONGZMcEJ4ejBZdHAzS3MyeEViRmp1ODFmbldDWHFTUStRdzQ2SGxwdUdZ?=
 =?utf-8?B?b2Q1K21oV1VRRE1oRGV0SWVCUlNHSWJQbUFYS2FkY1BGNDFJM0ZRZ295bWZK?=
 =?utf-8?B?M1BuanBNMWcrYXdlVkVWRHpiOGRSRmFtNk1DWFpyYlQ3czlBa0t6MGRQdm5I?=
 =?utf-8?Q?1iOYPEKtrliXFvjmeIicQ/3RTiSUa5cCyr7Cv+ILLL0sp?=
X-MS-Exchange-AntiSpam-MessageData-1: fbTGamrpnkT9lQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc69232d-22dd-4744-7a45-08dedbf87576
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 07:22:10.3681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6RXr6AzoxfZTPlGNbYsxOifwrbJbAXjPDx0bTbPtM+yODFT6T3FdqHrU/ma2uwiP/VFqYSUPRTgKSKsyTLWaqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
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

`GspBootContext` contains the resources required to boot the GSP. As it
turns out, this is also the context required for unloading it.

Reflect that fact by replacing the arguments of `Gsp::unload` and
`UnloadBundle::run` with the `GspBootContext`. This symmetry between
`Gsp::boot` and `Gsp::unload` will also be convenient when we want to
make these methods generic over the boot context corresponding to the
boot method used.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs           | 19 ++++++++++++++++---
 drivers/gpu/nova-core/gsp/boot.rs      | 28 +++++++++++++---------------
 drivers/gpu/nova-core/gsp/hal.rs       | 15 +--------------
 drivers/gpu/nova-core/gsp/hal/gh100.rs | 17 ++++-------------
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 23 +++++++++++------------
 5 files changed, 45 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 43c3f4f8df71..32bfa0be2357 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -269,7 +269,9 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 #[pin_data(PinnedDrop)]
 struct GspResources<'gpu> {
     /// Device owning the GPU.
-    device: &'gpu device::Device<device::Bound>,
+    device: &'gpu pci::Device<device::Bound>,
+    /// Details about the chipset.
+    spec: Spec,
     /// MMIO mapping of PCI BAR 0.
     bar: Bar0<'gpu>,
     /// GSP falcon instance, used for GSP boot up and cleanup.
@@ -312,7 +314,16 @@ fn drop(self: Pin<&mut Self>) {
             .gsp
             .as_ref()
             .get_ref()
-            .unload(device, bar, &*this.gsp_falcon, &*this.sec2_falcon, bundle)
+            .unload(
+                GspBootContext {
+                    pdev: device,
+                    bar,
+                    chipset: this.spec.chipset,
+                    gsp_falcon: &*this.gsp_falcon,
+                    sec2_falcon: &*this.sec2_falcon,
+                },
+                bundle,
+            )
             .inspect_err(|e| dev_err!(device, "failed to unload GSP: {:?}\n", e));
     }
 }
@@ -344,7 +355,9 @@ pub(crate) fn new(
             sysmem_flush: SysmemFlush::register(pdev.as_ref(), bar, spec.chipset)?,
 
             gsp_resources <- try_pin_init!(GspResources {
-                device: pdev.as_ref(),
+                device: pdev,
+
+                spec: *spec,
 
                 bar,
 
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 536f2e341c01..75054424a951 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -3,7 +3,6 @@
 
 use kernel::{
     bits,
-    device,
     dma::Coherent,
     io::poll::read_poll_timeout,
     prelude::*,
@@ -15,7 +14,6 @@
     driver::Bar0,
     falcon::{
         gsp::Gsp,
-        sec2::Sec2,
         Falcon, //
     },
     fb::FbLayout,
@@ -47,7 +45,6 @@ pub(crate) fn boot(
         let bar = ctx.bar;
         let chipset = ctx.chipset;
         let gsp_falcon = ctx.gsp_falcon;
-        let sec2_falcon = ctx.sec2_falcon;
         let dev = pdev.as_ref();
         let hal = super::hal::gsp_hal(chipset);
 
@@ -61,9 +58,11 @@ pub(crate) fn boot(
         // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
         let unload_bundle = hal.boot(&self, &ctx, &fb_layout, &wpr_meta)?;
 
-        let unload_guard = ScopeGuard::new_with_data(unload_bundle, |unload_bundle| {
-            let _ = self.unload(dev, bar, gsp_falcon, sec2_falcon, unload_bundle);
-        });
+        let unload_guard =
+            ScopeGuard::new_with_data((ctx, unload_bundle), |(ctx, unload_bundle)| {
+                let _ = self.unload(ctx, unload_bundle);
+            });
+        let ctx = &unload_guard.0;
 
         gsp_falcon.write_os_version(gsp_fw.bootloader.app_version);
 
@@ -82,12 +81,12 @@ pub(crate) fn boot(
         self.cmdq
             .send_command_no_wait(bar, commands::SetRegistry::new())?;
 
-        hal.post_boot(&self, &ctx, &gsp_fw)?;
+        hal.post_boot(&self, ctx, &gsp_fw)?;
 
         // Wait until GSP is fully initialized.
         commands::wait_gsp_init_done(&self.cmdq)?;
 
-        Ok(unload_guard.dismiss())
+        Ok(unload_guard.dismiss().1)
     }
 
     /// Shut down the GSP and wait until it is offline.
@@ -116,17 +115,16 @@ fn shutdown_gsp(
     /// This stops all activity on the GSP.
     pub(crate) fn unload(
         &self,
-        dev: &device::Device<device::Bound>,
-        bar: Bar0<'_>,
-        gsp_falcon: &Falcon<'_, Gsp>,
-        sec2_falcon: &Falcon<'_, Sec2>,
+        ctx: super::GspBootContext<'_>,
         unload_bundle: Option<super::UnloadBundle>,
     ) -> Result {
+        let dev = ctx.dev();
+
         // Shut down the GSP. Keep going even in case of error.
         let mut res = Self::shutdown_gsp(
             &self.cmdq,
-            bar,
-            gsp_falcon,
+            ctx.bar,
+            ctx.gsp_falcon,
             commands::PowerStateLevel::Level0,
         )
         .inspect_err(|e| dev_err!(dev, "GSP shutdown failed: {:?}\n", e));
@@ -136,7 +134,7 @@ pub(crate) fn unload(
             res = res.and(
                 unload_bundle
                     .0
-                    .run(dev, bar, gsp_falcon, sec2_falcon)
+                    .run(&ctx)
                     .inspect_err(|e| dev_err!(dev, "Unload bundle failed: {:?}\n", e)),
             );
         } else {
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index 851d1f24c137..849ca224085b 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -5,18 +5,11 @@
 mod tu102;
 
 use kernel::{
-    device,
     dma::Coherent,
     prelude::*, //
 };
 
 use crate::{
-    driver::Bar0,
-    falcon::{
-        gsp::Gsp as GspEngine,
-        sec2::Sec2,
-        Falcon, //
-    },
     fb::FbLayout,
     firmware::gsp::GspFirmware,
     gpu::{
@@ -37,13 +30,7 @@
 /// required for unloading is prepared at load time, and stored here until it needs to be run.
 pub(super) trait UnloadBundle: Send {
     /// Performs the steps required to properly reset the GSP after it has been stopped.
-    fn run(
-        &self,
-        dev: &device::Device<device::Bound>,
-        bar: Bar0<'_>,
-        gsp_falcon: &Falcon<'_, GspEngine>,
-        sec2_falcon: &Falcon<'_, Sec2>,
-    ) -> Result;
+    fn run(&self, ctx: &GspBootContext<'_>) -> Result;
 }
 
 /// Trait implemented by GSP HALs.
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 18c889f9f413..aabef45202f7 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -11,10 +11,8 @@
 };
 
 use crate::{
-    driver::Bar0,
     falcon::{
         gsp::Gsp as GspEngine,
-        sec2::Sec2,
         Falcon, //
     },
     fb::FbLayout,
@@ -116,22 +114,16 @@ fn wait_for_gsp_lockdown_release(
 struct FspUnloadBundle;
 
 impl UnloadBundle for FspUnloadBundle {
-    fn run(
-        &self,
-        dev: &device::Device<device::Bound>,
-        _bar: Bar0<'_>,
-        gsp_falcon: &Falcon<'_, GspEngine>,
-        _sec2_falcon: &Falcon<'_, Sec2>,
-    ) -> Result {
+    fn run(&self, ctx: &GspBootContext<'_>) -> Result {
         // GSP falcon does most of the work of resetting, so just wait for it to finish.
         read_poll_timeout(
-            || Ok(gsp_falcon.is_riscv_active()),
+            || Ok(ctx.gsp_falcon.is_riscv_active()),
             |&active| !active,
             Delta::from_millis(10),
             Delta::from_secs(5),
         )
         .map(|_| ())
-        .inspect_err(|_| dev_err!(dev, "GSP falcon failed to halt\n"))
+        .inspect_err(|_| dev_err!(ctx.dev(), "GSP falcon failed to halt\n"))
     }
 }
 
@@ -153,7 +145,6 @@ fn boot(
         let bar = ctx.bar;
         let chipset = ctx.chipset;
         let gsp_falcon = ctx.gsp_falcon;
-        let sec2_falcon = ctx.sec2_falcon;
 
         let unload_bundle = crate::gsp::UnloadBundle(
             KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>
@@ -182,7 +173,7 @@ fn boot(
             Ok(()) => Ok(Some(unload_bundle)),
             Err(e) => {
                 // Wait for the GSP RISC-V core to halt in case of error.
-                let _ = unload_bundle.0.run(dev, bar, gsp_falcon, sec2_falcon);
+                let _ = unload_bundle.0.run(ctx);
                 Err(e)
             }
         }
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index f78e2489f5a6..c0956fb1c9cf 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -121,18 +121,15 @@ fn build(
 }
 
 impl UnloadBundle for Sec2UnloadBundle {
-    fn run(
-        &self,
-        dev: &device::Device<device::Bound>,
-        bar: Bar0<'_>,
-        gsp_falcon: &Falcon<'_, GspEngine>,
-        sec2_falcon: &Falcon<'_, Sec2>,
-    ) -> Result {
+    fn run(&self, ctx: &GspBootContext<'_>) -> Result {
+        let dev = ctx.dev();
+        let bar = ctx.bar;
+
         // Run FWSEC-SB to reset the GSP falcon to its pre-libos state.
         // Log errors but keep going if it fails.
         let fwsec_sb_res = self
             .fwsec_sb
-            .run(dev, bar, gsp_falcon)
+            .run(dev, bar, ctx.gsp_falcon)
             .inspect_err(|e| dev_err!(dev, "FWSEC-SB failed to run: {:?}\n", e));
 
         // Remove WPR2 region if set.
@@ -142,12 +139,14 @@ fn run(
                 return Ok(());
             }
 
-            sec2_falcon.reset()?;
-            sec2_falcon.load(&self.booter_unloader)?;
+            ctx.sec2_falcon.reset()?;
+            ctx.sec2_falcon.load(&self.booter_unloader)?;
 
             // Sentinel value to confirm that Booter Unloader has run.
             const MAILBOX_SENTINEL: u32 = 0xff;
-            let (mbox0, _) = sec2_falcon.boot(Some(MAILBOX_SENTINEL), Some(MAILBOX_SENTINEL))?;
+            let (mbox0, _) = ctx
+                .sec2_falcon
+                .boot(Some(MAILBOX_SENTINEL), Some(MAILBOX_SENTINEL))?;
             if mbox0 != 0 {
                 dev_err!(dev, "Booter Unloader returned error 0x{:x}\n", mbox0);
                 return Err(EINVAL);
@@ -293,7 +292,7 @@ fn boot(
         // Run the unload bundle to try and recover the GSP if an error occurs.
         let unload_guard = ScopeGuard::new_with_data(unload_bundle, |unload_bundle| {
             if let Some(unload_bundle) = unload_bundle {
-                let _ = unload_bundle.0.run(dev, bar, gsp_falcon, sec2_falcon);
+                let _ = unload_bundle.0.run(ctx);
             }
         });
 

-- 
2.55.0

