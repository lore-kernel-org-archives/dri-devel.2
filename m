Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAECDCD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:42:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E66210F5FC;
	Fri, 19 Jun 2026 13:42:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="N5A9UpzZ";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D23D910F5FB
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 13:42:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlsZ1sM5tFq5zL7od7CeyHO79lv0kNTGKQtF3xacfA/bEbBwEwFezdYKs6kdIKMrZKhoc4YFAqXZi2injgFoQCfNCo0kDO9uirRL3KXZOrVihLkaEiSu4SIRUl3iyCeCRX5n+Lt1OSA/TEwzEfLmojehJVZhVozXXKh2Pm/F6AJXqf/hhnlqW/g2RpDCMXlVcQB67t3v4Vc75v5OMWnl6mltag71nPc1MySJWZyqqnUneLcD4PtWSPptGwQKUNAwrUAYh0gqQ2GLPsiNFpfjyYLQAGFaQyLjW4AUQOVmIKlQXVbC5JTBXMfKiVOIbU7WtZlN+DmKF/bzdeEH+HYi2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sb9SWnLaYGHDNXlJbwJrpHMV0Sd+XpMAxF6Khwj6JxY=;
 b=hb5Z+DkV5yFIkVlKUCW/mEq/HRAqlPKNZT4iAWlv4U9ruRTGHVsLgdkphy0+VaDVaOv/tk50VRUhlzBN36S76n1TCOsvlnUdFXdkk/LJIJZZY2AIWdbdZBy8iDu42yhUwDfn0AWIM/pav9iGvbSmeJTXKm7CD9tWBmb/4EyW7x11G8BZG+El0YlWcwIennrjsc0IqGIgl4lHX770EnzNB/Aax1E+EMkgJTYRFq8MjDWeoWoytAZayZA+rLvPFGV9haKUtT7d9urEY9QOHPdqhk9D8x3CmT7rnqFDUDwnlqXpZg7mESqLEKuks/a9har/zmpAtuNUxmBNTgt4Wq79xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sb9SWnLaYGHDNXlJbwJrpHMV0Sd+XpMAxF6Khwj6JxY=;
 b=N5A9UpzZf8XxmuHHGK6OxmCM4T4RBIQEv8ql13w6SQ02J43pMlHKNtDz+jXYQdpfsYbbOYtMcvaE9p0Fk644kZnJQb94Yfgo+Wg9XUWpNeobeuJ5VDTf0wWXyRPtJfzZd6wZr/f530Pav+0wY2nGkWjP2rqVTwHq2vguaagayxdfx0l4FPQdxI8fA2U1Xy7Z0faOskpsx3iA0t2xZj9s8yR8SIUkLYrCAIFCUzbQoSnIbLzi40ntz7aLcivekTzZevISBLe0uYgDEyWY/IFyAqL6WscjJC8siEDx5VWEEZWOlHrDAB8BTwaQMR9pQoNVoBUjzQt9ckuErJESQTf4Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Fri, 19 Jun
 2026 13:42:51 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 13:42:51 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 19 Jun 2026 22:42:21 +0900
Subject: [PATCH 6/6] gpu: nova-core: gsp: make unload take GspBootContext
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-nova-bootcontext-v1-6-45193cd0a2e5@nvidia.com>
References: <20260619-nova-bootcontext-v1-0-45193cd0a2e5@nvidia.com>
In-Reply-To: <20260619-nova-bootcontext-v1-0-45193cd0a2e5@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P286CA0065.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ec26a6-d2a6-4556-0b46-08dece08a832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|23010399003|1800799024|376014|3023799007|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: DLYffcBoXDQL4TDl/qf3RFe/5I8aveJutST+X5x49OShGQjPhsWut+uuTcn03Jvq6DSRkVCbv7OVmsGvRdHV+RL64a5jT77TKShbNcgFJy2MLc3AFL597IU4GhC7FtshxofAHAAKsOZHr20wi0ec43yhWkpgrbQO2IS1TqcCjjVnxiPGmh1G5/f5bpRNb2QDpCe0iQC+A88sjLbP4GiFRfOriTomUd/wmtV14X/3h85EKW33ByqasVuu+5K/m+Ny9AKPJVTeITmmUpUikoYbz36gn5TR97cfqW4lR4hSrxcpzGhGi8hVBAIH7dAW3Vf6tJ+U2DJg8xvv+zK2mlrEztxDGR8uPnnawUROwl0kUsSNySdWBqUaFjucmmxHdl/cMgCgKbYATPLCXMjUPOE3G6M3UlJI06aD3QZUY8et760RDckmUD25T1apVWDw4+hiclA/HHIfMb3xcTFVv+VtTC+1H8GJkIhzSv8sE/cGzNIJQ59dAa1prJjFrSwHTviJIqnTfMkLzo57Ze39pDwRbdm1e9Hdj1zkesqnkHjvjZzwPikQCw8flT+8f0mZ++8M3J2joK0oMOvrmAWCPSLkOd+2ZCKmMmq2CQQQcMPggXos7E9uH3VPv2Nuo67hagxtF5E36sqJPysO0/JEeVfC6a8/KtCPrpB/8aTYKyfiHdc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(23010399003)(1800799024)(376014)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0pJN0FnQUk0Skh4NFpEZjRiWm9rU0hFcUE2UjRKUjc4U1JpeGhDdTJFTmZZ?=
 =?utf-8?B?VFBQTFRsWWtQejFtWmJSRS9RMzFMVVV5d05DSml4a1d1T3F4VWl2MSs3ZDJ2?=
 =?utf-8?B?RWFBdjRFOHMxdUdMTmExTlE3RGhicHgwQ3hUK1RUNi9vZG0zbm9qTlQ1SG00?=
 =?utf-8?B?anRUMEEyaGFKbDNSNFlqR0ZjNUcwRy92eTZueTByVytSRWRmTDJST2gvaG9G?=
 =?utf-8?B?ZisrdDBpQktVYUIyREMyZThtTGxhV0JxWEhiWnIwazFhTmFwSCt2TWN5MUlZ?=
 =?utf-8?B?UktWQTFURTlzdHRJcXRNR2tqYVZ4RStjbmJlQjBueHFSbXJ6TmkrSHhKdjhF?=
 =?utf-8?B?YzNHL095aDNtSzIwNnlYL0xlNXpkR2gxMXlxWndiSFljZVI3R0FlUFJzRlBq?=
 =?utf-8?B?NmpDaXc4R3dnOWhKTHFPczFQTVRja0pKYjNHNThtbSt0NHIwZzJxZGl6SjRK?=
 =?utf-8?B?c3ZIdGc1a3QvbERhWk1ZTG1iMWxnN0l3Sy9aK1l4Q01SYnFnYzFyb1JQbmlZ?=
 =?utf-8?B?V0VrSitNc1U1cGlPOTYrcEpvaVhyL2RXTGNMMlhaY0QwWjNnakViUFFjMnlx?=
 =?utf-8?B?UmF3VHV2OU5nRzFPM3NrN3g2RmJXblcyWWVTV3BGWDJTSis1NWxIVHkyV3RJ?=
 =?utf-8?B?bHl4U25TSUlBYW9OMGtoUElOdWZlZ09PWFJIOHVrYUJ3MVcvdkJ6dW1CeGRw?=
 =?utf-8?B?ZW5qN1U4UEhicXRGU010ajljVjlRRzVPZ3Y2WGlRcmxZZUJxU1VsWEExRnEy?=
 =?utf-8?B?VlVOVExobnhyMFZOMTlNTEoxQUVNUmtBRnBGN056NjRFUWJVRnBiaG1ZUktJ?=
 =?utf-8?B?YnNlQ2k2ZHZ6SFZTS0VBLzZZMk9qckdwM2JPMk95MFdUeWhPMnVId245TFd2?=
 =?utf-8?B?ZHJjd2U4WksvTHVNRFBzeHNSZlJVOXB3WTdDTjVpazdzQldtUEZaNjVSQURm?=
 =?utf-8?B?NW5XeFBjeENjRVFHakRuMUxBd2xXUi82MDEyQWlVUnlEQkdqbzAzQmwvT0hs?=
 =?utf-8?B?TFhsL0NHRHhXTHJZZnVnRXVJUlR6RjQrT0lXNlFpWEx6d3U5ZzJ0NGNoOERj?=
 =?utf-8?B?bVQ4eHp4ODJzTEdrOHZaRWVmajF3VkdPUC9DeUh6Vjl4d2JIUyt6TDBNbUtF?=
 =?utf-8?B?MGZSZUVjbFhnTEl5N0pqSUtFOVdWMXI0N2phb0xMUTZaZTVVbHJEamRRUGh4?=
 =?utf-8?B?N3ZXdmhrc201ZXgvNFdDSWMvUDJBRFVXa3htQlNJRklHenc4dzlwcG9iQkdj?=
 =?utf-8?B?UTZEc29Gc213dlVHNnExbk8yYW1halhUSXdBS2k5TzQwVUhIMFVRYXFlUDEz?=
 =?utf-8?B?MjBXUU43UzRYdm5yOGJzZENwZkVGRHJDWXB1cm9MWmFRdGR1VXBwUS8yUmNF?=
 =?utf-8?B?aXlGM1JTN3BxRitlWmNhTnc1ZjVQVHhDUHdIZlEwSS85enAxc256cmFDTklE?=
 =?utf-8?B?Sk5vb29sWk41bGFtVWRGRThhUWFTeHBEdFdqOVUwTTFIaVN0ZURqa3pFQyt2?=
 =?utf-8?B?MWZrRnRnVWk4NkxCSWY4L3kwTkMwTkRDSzd4d2ZDOCtZaE9oQjM4QmhHQ1Ez?=
 =?utf-8?B?clBWZkRMY0hpbmwxT2FBUjZMb1BzY3FFeFV6YTF1UURETUlldDlQOWNGeFdI?=
 =?utf-8?B?cis2dmZYbWlUZmJ1djlaSERxQUk4cUlLci9hNmJHVGFVblg0cmlWUU03dnAz?=
 =?utf-8?B?RmtNdDkyQWxkODc2VEpWNzRLYnZFVXM1eXNTMEZYc284VmxvbksvR2d5MzN3?=
 =?utf-8?B?UlhaSlcrNDlsait2bTJORmhIK25GQy9qdUVFWWx3VlhUM2RqdGo1NnBCajZY?=
 =?utf-8?B?dGFPUDlSOHRXbjNReGFtdkxpek5hc0djL1M3RWRRQkRuWTh4YUpRVDJTbVpT?=
 =?utf-8?B?V0c1L1ovL1F5dVZuOWs0NFdUUC84alFqanNSdFZpd3BTbzc1Uys3RUZFQVF0?=
 =?utf-8?B?SnFuNU5PeGcwT0wxMUk5djNKYS9LWmxUNjJzTWN0cjM0RjMxVVJ2bjZlVFFV?=
 =?utf-8?B?TnlYeW9PRk02ZWF1RmNPSjh1dFcxQ052aDdMaDV3Kyt3REdUaEtDb1c5dzRo?=
 =?utf-8?B?U3VzN0hQY05JVW1OelZXTitSNU8yb1hybUk1aWZwLy9QZGdxQ2pMbWViSWJ4?=
 =?utf-8?B?Zkx1NGZDK2IzVC9EcmgyWUZ0TEFrSFVUUDZDYTNKTi9XS1FhM1VOUnc0YlpP?=
 =?utf-8?B?dGJEWlo1eFU3ckFXYm5tZHJLbGtIV0huUzEwUkhUR2syaldQYmpLZDJpQmQ1?=
 =?utf-8?B?ZWdnQ2pTaG5SZVpaUWZvNWQvWTh2MjJYejNCK3hhSlZKejhtbzg2NHdPWlg1?=
 =?utf-8?B?cnhoT3V1RlNXY0p6SHZJLzFnTG1sZ3g2ZStVVVV5bmJsdVNvQ0xaNGQxN29z?=
 =?utf-8?Q?D+UAEBagoC7ex1TBe1sUa6zxi8p5LItrnUlPojaDtwVtI?=
X-MS-Exchange-AntiSpam-MessageData-1: ZSIQM3/glMgLgg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ec26a6-d2a6-4556-0b46-08dece08a832
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:42:51.1605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNIlR/VcByrlmZtH3tbvEBj6jHFJ7AC0KQaR8shxr6as3TvfV+RLn+AVtHTFuywkzjyJ/qxOOR9kjGdz+fvMdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367
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

Reflect that fact by replacing the arguments of `Gsp::unload` with the
`GspBootContext`. This symmetry between `Gsp::boot` and `Gsp::unload`
will also be convenient when we want to make these methods generic
over the boot context corresponding to the boot method used.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs           | 19 ++++++++++++++++---
 drivers/gpu/nova-core/gsp/boot.rs      | 17 +++++++----------
 drivers/gpu/nova-core/gsp/hal.rs       | 15 +--------------
 drivers/gpu/nova-core/gsp/hal/gh100.rs | 13 +++----------
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 20 +++++++++-----------
 5 files changed, 36 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 42dabcc1b3e4..24976484c87a 100644
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
index 3f11eaec26c7..336ad23c96f9 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -3,7 +3,6 @@
 
 use kernel::{
     bits,
-    device,
     dma::Coherent,
     io::poll::read_poll_timeout,
     prelude::*,
@@ -14,7 +13,6 @@
     driver::Bar0,
     falcon::{
         gsp::Gsp,
-        sec2::Sec2,
         Falcon, //
     },
     fb::FbLayout,
@@ -102,7 +100,7 @@ pub(crate) fn boot(
                 dev_err!(dev, "GSP boot failed with error {:?}\n", e);
 
                 // Ignore errors during unload; we will return the error that happened during boot.
-                let _ = self.unload(dev, bar, gsp_falcon, ctx.sec2_falcon, unload_bundle);
+                let _ = self.unload(ctx, unload_bundle);
 
                 Err(e)
             }
@@ -136,17 +134,16 @@ fn shutdown_gsp(
     /// This stops all activity on the GSP.
     pub(crate) fn unload(
         &self,
-        dev: &device::Device<device::Bound>,
-        bar: Bar0<'_>,
-        gsp_falcon: &Falcon<Gsp>,
-        sec2_falcon: &Falcon<Sec2>,
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
@@ -156,7 +153,7 @@ pub(crate) fn unload(
             res = res.and(
                 unload_bundle
                     .0
-                    .run(dev, bar, gsp_falcon, sec2_falcon)
+                    .run(&ctx)
                     .inspect_err(|e| dev_err!(dev, "Unload bundle failed: {:?}\n", e)),
             );
         } else {
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index 00e39cc1fbde..113d445239b9 100644
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
-        gsp_falcon: &Falcon<GspEngine>,
-        sec2_falcon: &Falcon<Sec2>,
-    ) -> Result;
+    fn run(&self, ctx: &GspBootContext<'_>) -> Result;
 }
 
 /// Trait implemented by GSP HALs.
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 58cef3859d49..3ef87fd668de 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -14,7 +14,6 @@
     driver::Bar0,
     falcon::{
         gsp::Gsp as GspEngine,
-        sec2::Sec2,
         Falcon, //
     },
     fb::FbLayout,
@@ -122,22 +121,16 @@ fn wait_for_gsp_lockdown_release(
 struct FspUnloadBundle;
 
 impl UnloadBundle for FspUnloadBundle {
-    fn run(
-        &self,
-        dev: &device::Device<device::Bound>,
-        bar: Bar0<'_>,
-        gsp_falcon: &Falcon<GspEngine>,
-        _sec2_falcon: &Falcon<Sec2>,
-    ) -> Result {
+    fn run(&self, ctx: &GspBootContext<'_>) -> Result {
         // GSP falcon does most of the work of resetting, so just wait for it to finish.
         read_poll_timeout(
-            || Ok(gsp_falcon.is_riscv_active(bar)),
+            || Ok(ctx.gsp_falcon.is_riscv_active(ctx.bar)),
             |&active| !active,
             Delta::from_millis(10),
             Delta::from_secs(5),
         )
         .map(|_| ())
-        .inspect_err(|_| dev_err!(dev, "GSP falcon failed to halt\n"))
+        .inspect_err(|_| dev_err!(ctx.dev(), "GSP falcon failed to halt\n"))
     }
 }
 
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 4cc140d08370..93ff8a154100 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -123,18 +123,15 @@ fn build(
 }
 
 impl UnloadBundle for Sec2UnloadBundle {
-    fn run(
-        &self,
-        dev: &device::Device<device::Bound>,
-        bar: Bar0<'_>,
-        gsp_falcon: &Falcon<GspEngine>,
-        sec2_falcon: &Falcon<Sec2>,
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
@@ -144,13 +141,14 @@ fn run(
                 return Ok(());
             }
 
-            sec2_falcon.reset(bar)?;
-            sec2_falcon.load(dev, bar, &self.booter_unloader)?;
+            ctx.sec2_falcon.reset(bar)?;
+            ctx.sec2_falcon.load(dev, bar, &self.booter_unloader)?;
 
             // Sentinel value to confirm that Booter Unloader has run.
             const MAILBOX_SENTINEL: u32 = 0xff;
             let (mbox0, _) =
-                sec2_falcon.boot(bar, Some(MAILBOX_SENTINEL), Some(MAILBOX_SENTINEL))?;
+                ctx.sec2_falcon
+                    .boot(bar, Some(MAILBOX_SENTINEL), Some(MAILBOX_SENTINEL))?;
             if mbox0 != 0 {
                 dev_err!(dev, "Booter Unloader returned error 0x{:x}\n", mbox0);
                 return Err(EINVAL);

-- 
2.54.0

