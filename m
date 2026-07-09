Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32865C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:56:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9235510F3BE;
	Thu,  9 Jul 2026 06:56:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZKLBixPC";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B28AE10F3BE
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:56:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivfBwcybnDCNVk1dihUp4xp2ruUR6+WJjUhXGrUXRg/KwpnaXwDGgw3lC/BY4W/bWyatAylXNzgTS5TcMWVo/KmAXJoUFkGPxpwtGtkMCgTf54jym2bygSfNq+ptjwA91mnwIfgPaiio9givlRy67sVnWefP9S6gm5Z1nSGo1ThYDmWVrczRvrChKy2ZYFPJhCb8naKT/VYPt48hqJBpDbF5Yyw39+JG5b0huyU7puY3XjONfoy+asMZsreKoYKQTBQig64X32AKwVK39W9OCV4eH1N6U2eP3AmyXm/aTg3wamwW8Cce4o5aNqAGMB6gzmSzwzqyyUM5t3zLdISbaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4VMeKpURwdqn8BZbdo+dCNQCnSaCzGZ+e+YmtVYQX4=;
 b=rWcvPGd2bYkl5Ktts+Exs/0dFx3cd+zt5H5/E+Oh3F+vUmCy1mpU2Y4TBYLdopAlcTBDWNwtU2G0f5l9dol8JRBB/zrkEQFo+/xvygmir3279cQzDkXD4rchR0l5DKKBqGSWBWGcMsJdQNOSLIQVGjFTBwmrUVt2mX2Rz7caARumdMc6C5rwGA3Y3Kq90uSYpxoWvdYJV6kotbwaO3YvF3BseV/J8TULv8naGgxWniZjSCqHo0jpgua4RBjiMk+wY1W6j0X8pWK58d8o8mQ96ERwliJg1TczoHerFrb7wQ6poen3NIOQ0DwebpRpZ/mXLhvdgiRbMsENFYtBpqX4yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4VMeKpURwdqn8BZbdo+dCNQCnSaCzGZ+e+YmtVYQX4=;
 b=ZKLBixPCPAKqs7U5rZCCBeZj36458Y2SZIavtG1+LM57wf4fmAjQIngz1weyyV1IAsrt1CiAVtXnITtCHbeAMVNCJMKHYK5H8ihHlU8B6H3sO/8H2hYNAk/72n6aKdC0EZBJRfeJwF2AcSbmAJDov3VH50Kyxu1tcE84yqGRateNEqVE+DbDYUDFCHxang/7qqF5FiaEUXg8Nw3w+38C2+X2HmOhOrt4+//75gLYj+Aj4c2RGSYDnhDTLRUzy3xp0n6XOE+4MNZZeRrq4V5W4jatg0NzfaZpWVHR5tHsIqhSlefQulpRKCUfD8wmhdqCnaaMY03Hifbqk8GLREOp7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 06:56:50 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 06:56:50 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 09 Jul 2026 15:52:57 +0900
Subject: [PATCH v6 04/13] gpu: nova-core: gsp: pass GspBootContext to
 unload methods
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-nova-bootcontext-v6-4-520cbf8b9b50@nvidia.com>
References: <20260709-nova-bootcontext-v6-0-520cbf8b9b50@nvidia.com>
In-Reply-To: <20260709-nova-bootcontext-v6-0-520cbf8b9b50@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0102.jpnprd01.prod.outlook.com
 (2603:1096:405:378::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: 27734423-48b5-49e7-5f3c-08dedd873f6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|10070799003|1800799024|3023799007|11063799006|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9PVKjRE+1ATslXSjtA6lV+6JNpVyoqXQKXs0JVMU7MAYVho2s56mXAkKC8eGY+PypA9kPD4vuoYFI/5Seects/1ndvHrwYpTE59suh9PuzTtI28Hd6I+N1NCHFhRrdv6q+Alb6UvWqxerAVKjUBos2zxfMlRyToEhVJ9id2gNAMFo8eaW0HmdJuXkYAv0xp+mhMoUFWhPGAUN9M3TzJMzMMn7vLfXgTUetzuiTsjlvya/WnEX+mMpxNyccOD7ZPTvqxfpFqxCp/xfDl16xeD4S9QKmI8MVwgERr6/Wsdp57lD8kceCD1aE4vI1ZZLlBl/ZfwLy23TOGNXBWKWUPGE4cjlllV0LqTC6BNsf+UPJl/ihowdKynCTA9I7GqmHLcocR+asmaIjHh9iUNnS7z3OqxY7OzQ2mAg3tWvGmMg9dnU4mL5CwcRiOCn+akMCENWVqJOBtnN0SOPy2zMeuUo/y17NHCxYriaaU6e2RfRM6Pz+DI2/yPlZIm0n3tVv2ZkRF/r4YQYE4rQr6rbbArexcTdKFj3mh9P7+o5nvH15A6JaXAA4PT662wETEKgASMs/zZoj+n2d8Jau9gWVKVD7U6rR+4p8OGa0uGhRHwswE9IGTXquk7WunrKv+YHtzRRU76y6OhjEAQ3ZBWXru+xcaYtbKPvFNqldIFJPcRJeRbXBTH7gl62sjD1I7uoD4b3fOexphVS93BOC3Er6Kzew==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(10070799003)(1800799024)(3023799007)(11063799006)(56012099006)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zytscm5PRzNFQ0I3OEhLcC9rZ0NWeDFMb3NOMGc3cmZydmZTQUtFNUZVU09h?=
 =?utf-8?B?M3ViNGwwYjUvdEhpL2NRQlF2SUM0ZUtSZ2cxd1VoR0FRMFhENTFTRVFSMjND?=
 =?utf-8?B?S1dmR1lQY2d2UHBXWGxwa2crdytyVGRRQzBIcURLbVBWMFhKL2krQmVQeW5I?=
 =?utf-8?B?bGlhbGl5QkdDb0d5SWp4NFBRSjdiSFJpR0pHWjZMaEFHRFlZYXpZQlZLWmx5?=
 =?utf-8?B?YmQxT3NwcTNjclVUazlrVmxtZVI5NXloek5uZGllYnVLVFpGZHJQbXRpalFJ?=
 =?utf-8?B?dGg2NktrMjdnQk8yNnZIa3RkN201N2RuVDh5SHJvYThJU2hPUWJlclpwQVFN?=
 =?utf-8?B?MktjNmRLSjZ0aXZaK0NybThTR1MyOWlzeWprQXJ2VlRDcTdFLzQ3bHZCbkhu?=
 =?utf-8?B?YUh1SHg5MzhBSkdzd0RiQ1o0emcxUjhsdTdWZnNRT2JGSjFSWGxReXdWbUx1?=
 =?utf-8?B?YmVWVU44cHlLVVQ1Q3c2d21zdVE3RkN6SldnR2xVaXUyRnk2dlMxd2c1bjlh?=
 =?utf-8?B?RE8yY3NMT1Y3enRZOUJzdHMrQzNMQ0NCMWd5TFk3T0dVZ1YxS3ZXRUlVZnZF?=
 =?utf-8?B?eUxpVG5zTW8xN0tHV256RW5ldHBNcVJENkJOZVFaTWY3R0Y1eVA1VFBQcVdl?=
 =?utf-8?B?WmJyM0paQXhWUDltUHR1YmJrU3hLTjlGSXZpNTBrWjZEU3JiU0FLSTQxNkgw?=
 =?utf-8?B?V2tvZ0w1ck5mSTdSOVFHeUlUOWtWVHRFblg0NDdvRjd4V2JkZEdWOENyY1Bl?=
 =?utf-8?B?MWg4bVpsMXRNeUJhVmYrSUJIWUtMalV2TENJS3VwUjB4eFFIMUFRd3AwSENV?=
 =?utf-8?B?d29pL04ydTBiQk1nZkNpVEd5SndVN2x1SW5FQkt3V2FOa0JjQ2lzMUEvQlk4?=
 =?utf-8?B?dDVrK3h3dkxIcHdzSUhtZHZqblZOa1RWZ2NtS3hXb1NSdng0TkNIaHFWLzZM?=
 =?utf-8?B?Mkg0TXZId0M5V0xyWGMyODlLVW1Ia3JmanBTejBCUUVpaUY5M0FKUnlNVWNw?=
 =?utf-8?B?RHhVYWd6U2JnWTdGeWtBcmw5M0NWSUdDNW5rUkJnZ2g0MHNQL0g1OEpkNjlF?=
 =?utf-8?B?WkZjQUdmck9CQW1ya1E5eFhBWHdUeUFKT0VNZXc4S2F5NTc0VTMzMktjRzVL?=
 =?utf-8?B?Umt4U2lHWDhQUjZDUTRwSjY3cXVUSTVabk5Obm12N3g1cE1aUTNhZVB0TCs0?=
 =?utf-8?B?eVFKcVpvcGdvMVAyY0prSmxyQ3I4SmcxWVpmL1Nvb2s0cGNkMXFtL0l4dGdm?=
 =?utf-8?B?aHFwMHJnZEtNMmtQWDNpdXJqeWtnT25BZnU4Sm8rUitqUzI2KytpL09qa2hn?=
 =?utf-8?B?WVNwL0R6anEvS3JPTC8vV0VzUlpEV29mZDFJSHpuWHJ0VmFJSDRMUXRjdGhm?=
 =?utf-8?B?MVlzZGxVRXVaSUNSSk5ZUksvVFNaVExHU2hxcnE1RVNvMDJlSjlBOVJTWTBX?=
 =?utf-8?B?NkNGZzNiblNjWGE5aFZEZEJjT2J4anlGT2JmKzdORklzSlkzcWcxQ2tnOS9T?=
 =?utf-8?B?TWxGT2grazIzdnNId01jK0paanVYTXhVelY2VmtSMHVNNndLalRqbjZSdU9l?=
 =?utf-8?B?QU1Qc2dBQ1FGNnJIZ1pKQnlvL1JtM25pU05ycWUzbElNdE9EQUdOVVVVdlhH?=
 =?utf-8?B?MWlDWCtSYStrRWllUEFCZE51OUFqL0t1emtESExlbjE5eEdZWXhkREFhV0pk?=
 =?utf-8?B?VkNEY2YvWHlndTFYL1YxTXRtWGVnSm9KSXY2NEI0dFg0emFrTzNPVU9ySURr?=
 =?utf-8?B?K21ta1N0MjA1K00zNVpFMkJpWHArNkR4dXVUNHNORXppWkk3OUxzZk5aa1FV?=
 =?utf-8?B?OUY4SkFwT0pnS2pzNENwZHRRTllPY25QbTZvZC8rYnBsd2tPdHNCRjZsamha?=
 =?utf-8?B?RktUZkhaVk82NE02SUMxSEdpN1NEbElTK3hEV29NdU1lRXlsNFRiTE15M0dJ?=
 =?utf-8?B?c21TWFNTanZSTyt1VGU0UGRXMHYzWGRZQ3dSc0E0bFVHb3VPNVBkMGRxVTl0?=
 =?utf-8?B?bWZpZFdJTUtlaHBhVWw2bEQzRDV3ZVlCY2JiQXp3VFJmRnpMREtSc2tJR3J1?=
 =?utf-8?B?angwblh0T3QyTHNPVm9VMU5YOE9XU0t1NmVuRVlHM2R4UFcwRjFBaTlFdWRj?=
 =?utf-8?B?cnNDQ2NONWlIMXVReFdDbTJZYTEzZTAvSFNMcVBUWWhkQ2laUFcwclpwU3Bj?=
 =?utf-8?B?dUhqdUZoZmtGN1ZjZDVVcjZKNUwxUzlxTFkrWDQyWnpUVDNET0FNUE9XU3Ey?=
 =?utf-8?B?Rmt4eDZlbkRMQjJWQWpGNDJJNEgyaXp1a1haNDNjaDVZUnFPYUZzSWk1eWxL?=
 =?utf-8?B?OGVSY1VvdlRzYnJvNHpxWnRXQ0h1bVVTenF2Y0lVcjNNT3pRMmpZMTV6b2ZT?=
 =?utf-8?Q?3lJgqb5z+cKHK3O08kakbcpd1Kw5MHAJfwRRYUA8iaEw3?=
X-MS-Exchange-AntiSpam-MessageData-1: lTDXLsoCzOq73g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27734423-48b5-49e7-5f3c-08dedd873f6d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:56:49.8845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgdc3L853FLaViyrTZlH3nQ0Ac9frLwKNN6/cG44phsE9LQbD/M1PMvpEMXhl8+MyHLAq70OA0ieD7WqJ2m+2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9668
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
index f62079709b6f..a23219a79355 100644
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
             .send_command_no_wait(bar, commands::SetRegistry::new()?)?;
 
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
index 5a39d087c904..b991f160abcc 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -12,10 +12,8 @@
 };
 
 use crate::{
-    driver::Bar0,
     falcon::{
         gsp::Gsp as GspEngine,
-        sec2::Sec2,
         Falcon, //
     },
     fb::FbLayout,
@@ -117,22 +115,16 @@ fn wait_for_gsp_lockdown_release(
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
 
@@ -154,7 +146,6 @@ fn boot(
         let bar = ctx.bar;
         let chipset = ctx.chipset;
         let gsp_falcon = ctx.gsp_falcon;
-        let sec2_falcon = ctx.sec2_falcon;
 
         let unload_bundle = crate::gsp::UnloadBundle(
             KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>
@@ -174,7 +165,7 @@ fn boot(
         // to make sure that boot args are kept alive until halt, in case they are still being
         // accessed.
         let unload_guard = ScopeGuard::new_with_data(unload_bundle, |unload_bundle| {
-            let _ = unload_bundle.0.run(dev, bar, gsp_falcon, sec2_falcon);
+            let _ = unload_bundle.0.run(ctx);
         });
 
         fsp.boot_fmc(dev, fb_layout, &args)?;
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

