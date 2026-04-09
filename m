Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B6DEA3C5F
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 12:15:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1457010E7E0;
	Thu,  9 Apr 2026 12:15:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="QcxtWVUw";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F69510E7E2
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 12:15:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVFqkkMbbtBuydTTp+n3ntC7+GmwEsdOmBMjgH4det8CQBEHPe98pVOHUW7yHcX8k4z5cHEz3clR/NpbWK6YkOF3hvRbCS5Vtqg4axuXf3NMpGYxc2grPfFTR6iFH1qwfoSRzHv5cFIyIL80ywbZRJuwg8u2d0a6ahyzIT6pNLQyOCIeJdl9dLkLkFsxEfwP0M0RmSg2zXokW5zlsZhx8PDBJaIcBYX/DB6c2BeLlckwXw+/cQoixDZjG1vtt4jG25RbLjMEupyvLuxzdFxAH1IibfYUGfc8rLBbQzNlDiX5AGp0TzZjsu1QLy3hCqpha+8aoqrElMvg/zH5ddsrmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPhyitW1em2vIvcTnxNrtD4eo3IrQLtcb3a+VYoMPqM=;
 b=Anlm0CZ48cA6EiGVAfQoUDGmtcX/X1MAktnT6+rd8WcYGnIQCRQSaL+7xTlB8xu3O/HPjtKmdchkx2Q2xaJ6vF1WPyjlylVaB5eg9qGkFaPuuvme1EXg1e94HeE5QCTTs+BAGG0EBRfe5N8Ha0DbsGv+oESlG08kx3ogy9q3VlM8ocKrlE2UfjhYDixSfbzlWXZxlZAjUiMyl27t1uFV/fAwgTYhES+HLGIhBd6quIAVcWtN5wTjHDeQDfPSWrL45OI/QLZiCpHCRPXJShamzj6H0IwsF6oAXOL8nJ74rbgTUEwE0zMhkS1EHh+oUnfpCh/MVRoJMXOp6kqQyDJqdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPhyitW1em2vIvcTnxNrtD4eo3IrQLtcb3a+VYoMPqM=;
 b=QcxtWVUwqa9Ww+MlLRE5MrWWHKo4B8qbqwdh9iVQZQLvP/cKX2uKP0qW7/IfrZ1INlob4imgFaq0WwIPCnYv3ZIIQousfm38DrPjc/mGJFT2T54XcjPiStShmtaWYQ/GqbY+97lF7OQTEXDfqSFu0iz3WQ1eb8Nls4IbmpkOIFzp5MPyw1BXF2+fs5LhHK+xUeKzsGhegXAWdySe8GgLKERwrlYwuiuvp81X2agqpGePARQ6B8t2lqLr7cyHP8NbVL/i78p0UpsShO1ExweuWGQAnhD9SDRMhks1KKb8H50lP7O4K3dfuPupteqLcOgD33t+bZ4YVhkpmRCrbdLthA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Thu, 9 Apr
 2026 12:15:31 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 12:15:31 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 09 Apr 2026 21:15:02 +0900
Subject: [PATCH] gpu: nova-core: fb: make sure to unregister SysmemFlush on
 boot failure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-fix-systemflush-v1-1-a1d6c968f17c@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NWw6CMBQFt0Lut03agi11K4aPPm6lRkB7wWgIe
 7eKn5PMmbMCYU5IcKpWyPhMlKaxgDhU4Hs7XpClUBgkl4o33LCYXozeNOMQbwv1LKBSwRte69Z
 CWd0zFuVXPHc70+Ku6Odv5m9kfCzlat41cJaQ+WkY0nyqrLa85c41slbo8Ki1U1qrYBoehBbaC
 BmjCgG6bfsA8LgvCb8AAAA=
X-Change-ID: 20260409-fix-systemflush-de66dc90378a
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: DU7P190CA0016.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::6) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SN7PR12MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: bb30accc-ba72-498b-af3c-08de9631b16f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 33l6xpwVi13Qn9sgUtlItVijTUX09R1EI2v4jZnl3cOb/Kd/GH23Yk1nP0NlJmlojFTAvibYCOy7iChMGQ8s2vXhPeJb4J21lSJ2HiNRSzVH2wXmsFSXjzaaj7gsJCFtTUdmEJ5eG90qAf7VygJOGva2w6evOpxfgodqBcr4XiO+fh7mYw53Ysoq7BaXlZ7n7HiK6HqwGuzU3RCKZUPOWMJIP9JtP5qzHU2ttBeWmwSW9Sn01cOztfQpYrDVey1T+InpsySCNZVon3yaWqGfHwjg6cFPz7dE6GfzFLD6CUG5mXHdLY4eHWAKAjy8t9cF/KP7TAXB4MBI0O/Ty3K8rojyPRb9xuv6FlVw2UMvvv1VrVVSzdx4msZYSBvZGcPJDDYUNXDtobtFNrG5FvFKtm0Vgj6AlVL8VUXHJb/AJNqkWKWpSonnltcyOZk3jQ/KyDX7yKNdp1HO2UcNwuTBy2n9KCVHjYxVRUEEfmW0Lri5toIS5MZ/5H04JnI1Mu+oABSweIJfQtw2NlwQMn8ZjH2aOxrE7JD5ZMujsSgJTa1wU4JXPUu4CmWISojGYzkTkWz+htcdDrlWNFscVmkRrQpsqdc0Ok+CGgfBDyCKg961HNSjdRByr2tQYzU+A7fw+ofiinFVPO+E/xbABdcHIX6b7QIZKc6wldAmoVuAn3TjWd26D8+nDqQ3F9hSDewhgougXTAXk5LUhq+/hbyyTEt6nzeWca9V/YbqSMJaihE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2UzZ0o3WDN4ZWduQWJmYTlBbTJNc0FST3A1L3doVTdTamlMTXY4a05hNFlC?=
 =?utf-8?B?bGhpVytaK3E0WHd6c0lqT3lqL2hsdGl0RWRCdWRjUkJ3WXA5SVJGNCtYL3Fs?=
 =?utf-8?B?c2pzMWlYRjRUVEpzMUs2UVFwYVlBeGtJWEdXTEVHM3lMQjNKNG5qZDhFTmFS?=
 =?utf-8?B?Qmp2MVp3OEpOK25uaGN0aEc1YVhlQmMzYnBBUFh4L21KQ0RFbzc3c0pnN3or?=
 =?utf-8?B?UlIrRGMvZ2hhQTBpQ0dFcnlSMFpDUUtJU1FpT2VsYk9yM1BRUzFvbDBvbjVn?=
 =?utf-8?B?aTBuWUo2b3RCRVlGeitXK0ZVeU1zTUhwcTR5NldxR1pKdHh3eFZrTzdEL29s?=
 =?utf-8?B?cm9ab2orSXIzLzBBbDkzVktJRm52cGNjMVhRYmp3aHd0VnJQTUNJYXg2UHRu?=
 =?utf-8?B?V25BQmhIOFhrTGdSVTFSUlNSQVN5S0hrYk1ITlFzNGh0ODBGQTJYV2VSUkpN?=
 =?utf-8?B?TGhDcmRaYTNuaTBWZ0xVYW9CTkVaaXJXY2swTVRXV0E4L1JpVDhTdFRJUENX?=
 =?utf-8?B?cEEzNWxoZ0hJWSsyOUhXNG9XQWJXQlVWdnVxbHFUcGliVURJZHJYQVFFVkJz?=
 =?utf-8?B?NkxVRU5yZ1RoVzlSYWE4R21EUWNzVkFQVTZCVkxRWk14eFYxMFNYNG1QeG5B?=
 =?utf-8?B?OW9LRythWHh3alB4eDE5S3BweGFWOGVhazBNZG95TDJ3Y0tPY3p6K2UyUFV5?=
 =?utf-8?B?Q1ZRWEdQT01zWjZFYW5YYzNUaUQ0UkRkem1ZMGJIdnlGaVMwZEozRTAwSjly?=
 =?utf-8?B?clFsaENPVE5CeS8xRGtzNE00RWNpZGFYc0xGSUg2eStVYjhseVVPcFFjeXN5?=
 =?utf-8?B?Z0ZwdVBwWjRmQUtjSDFzMFB5WCs2ZXc2Y2pURWZkdDAxNC9YdEdIVzlQSkdu?=
 =?utf-8?B?djVwMzdBb2FJWFpGSmFiSnJ3VS8zcjZ3VEN2UEpsQ3FVblMvWWJscUZoT2xQ?=
 =?utf-8?B?ckFJelJzVDJHRERyTUFlbXdBS0w0NEV3ckxKMGFEVnRpc3RGOEljNW1sWUVt?=
 =?utf-8?B?cFQzNTlQN0dPckJHWWRoSUF5eFdlSGFCNmxKcmtxR2dKWmFJUnZweUd1SXNk?=
 =?utf-8?B?TUFJYnY2dU9JSmlPaWRJZ0hBeFFGU0hnbHFYb1NKckVoL0hTT3htNnhoSmRO?=
 =?utf-8?B?THJrSjBabWNLZXAyNUtlRlpDMXNXSlhnUGx3WGNQY0RmMVdJalhSYUtzNW5s?=
 =?utf-8?B?NmhNdTNrODJJUzN2enhSRm16UFMyUDB0bEsrM1dyLzNVWlF1VTNmUkFGV1U3?=
 =?utf-8?B?R0RyRnhxYkhOVlRaZlA0UVpjKzFzQUFSSGJ3bVVZTTNkK2JZSGNBeVAvbmRz?=
 =?utf-8?B?T3ZvbE1ZbS9TdFlTbndSTnpubnpRaFZjN1pmajVvWGpuSyt4bFp1RkMwSytT?=
 =?utf-8?B?R3VjQVVGbEpVM3BSeHFBejhNeVg3SlNNSEJGSXNVS2tKT2RZTGlJNFQwQWU0?=
 =?utf-8?B?UHdwT3N6SjY2bTFoL0VUNlEyTkxvZ2wrVWpiNUdXMzFwcGFCVE91TUVTc0Rr?=
 =?utf-8?B?WjAzMThTUnhtZURYbWx5REdoNExxMXB5TzVCdEJtejZkWmdKazdYc3FzQjIw?=
 =?utf-8?B?ME9jcEJzNGY3SzN4WkpYalBIdlMzOS9hc2NFRzRxeTJGVHR1TVlwMThEdStk?=
 =?utf-8?B?b3BvYW05VDZsR2VLaVc5cWhXV2toVnhFWWc5QTdwSVROTEl3WkdZU3V2V3p1?=
 =?utf-8?B?aklRNldhd2NyMFVKei9Rd212cmxuczY1RlJUMFhZVmVGeHFYNXlENVBzdnRv?=
 =?utf-8?B?a0FJRkVmWFNXd3pleGxtb0dCMWhMQzR0NW5PUHBDVEUrNWxuRWhJZktQTnNn?=
 =?utf-8?B?YkFpSHR6bGNXM0dlV1FudW9KL1ZHSGUrZ3JKaVdkY1czQW5LVVBJRTkwaFUw?=
 =?utf-8?B?YW9XUTlWYktidDVOTzAyTzVFUGREbTRRQkw5T0dkU09NOUd5a2tZaUlYMTky?=
 =?utf-8?B?WnFxdFJVaDhQTnJ6WlRlRjU0ejRudk4zNzFNN0VjNEw0TEtLTVh0eDNGM0Iy?=
 =?utf-8?B?enMrY01XTk1UUGxGZGttdU1oaC81TWJGYk1pM0hGa3VZQ0RUSWRVWkY4UVVo?=
 =?utf-8?B?eDlmVlo3WkxYSTlhWFV5NFJUYjNHb01pSmtvYzNsb2c4WFNkcXFkSDd3N2hh?=
 =?utf-8?B?aC9aTWlHbmpxa0I0OVhLczRWUFNIdWQ0Nmw2WUMzcXNFY1ZqSzVsZDQ0UXJI?=
 =?utf-8?B?RFhRaElhZzYwVFFnZi80NHZpc0krLzFBSHg5VkNqdk1VMTJVYUxKVDJ5eFBN?=
 =?utf-8?B?RHNYZ3dTMWVUc1J6T21mUmFIdithMEFMeWVubHVlOW5WNWRvVzlZOElFL1hx?=
 =?utf-8?B?bFU1eTZKVUNtWnE3Sk5ZRXhEbnNycWpTQXV0azNhQmJqOFhXanZCWkFFY0kw?=
 =?utf-8?Q?W3+y2aIeUkeF6jYoga+L57PSLRb3Gb+lbkjGrrKqtt/Yl?=
X-MS-Exchange-AntiSpam-MessageData-1: 2EFwxCpTt+XQMQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb30accc-ba72-498b-af3c-08de9631b16f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 12:15:30.9607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eqm5eE/XuW+hsIbOm/nL6RlaYdpu4Ldx9oLbLA1XuGNedirudyb25ml/O7Au8b6Nn1XPppVc3wIdsd+jZfSDgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8131
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

Current `Gpu::new` will not unregister SysmemFlush if something fails
after it is created, since it needs manual unregistering. Add a `Drop`
implementation which will clean it up in that case. Maintain the manual
unregister path because it can stay infallible, unlike the Drop path
which depends on revocable access. In the case that `Gpu::new` fails the
access is guaranteed to succeed, however.

Fixes: 6554ad65b589 ("gpu: nova-core: register sysmem flush page")
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/fb.rs  | 29 ++++++++++++++++++++---------
 drivers/gpu/nova-core/gpu.rs |  7 ++++++-
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index bdd5eed760e1..edfbdc9a2512 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -7,6 +7,7 @@
 
 use kernel::{
     device,
+    devres::Devres,
     dma::CoherentHandle,
     fmt,
     io::Io,
@@ -16,7 +17,10 @@
         Alignment, //
     },
     sizes::*,
-    sync::aref::ARef, //
+    sync::{
+        aref::ARef,
+        Arc, //
+    },
 };
 
 use crate::{
@@ -46,12 +50,14 @@
 /// Because of this, the sysmem flush memory page must be registered as early as possible during
 /// driver initialization, and before any falcon is reset.
 ///
-/// Users are responsible for manually calling [`Self::unregister`] before dropping this object,
-/// otherwise the GPU might still use it even after it has been freed.
+/// Users should call [`Self::unregister`] before unloading to ensure unregistering is infallible.
+/// [`Drop`] performs a best-effort fallback using revocable BAR access.
 pub(crate) struct SysmemFlush {
     /// Chipset we are operating on.
     chipset: Chipset,
     device: ARef<device::Device>,
+    /// MMIO mapping of PCI BAR 0.
+    bar: Arc<Devres<Bar0>>,
     /// Keep the page alive as long as we need it.
     page: CoherentHandle,
 }
@@ -60,6 +66,7 @@ impl SysmemFlush {
     /// Allocate a memory page and register it as the sysmem flush page.
     pub(crate) fn register(
         dev: &device::Device<device::Bound>,
+        devres_bar: Arc<Devres<Bar0>>,
         bar: &Bar0,
         chipset: Chipset,
     ) -> Result<Self> {
@@ -70,18 +77,17 @@ pub(crate) fn register(
         Ok(Self {
             chipset,
             device: dev.into(),
+            bar: devres_bar,
             page,
         })
     }
 
     /// Unregister the managed sysmem flush page.
-    ///
-    /// In order to gracefully tear down the GPU, users must make sure to call this method before
-    /// dropping the object.
     pub(crate) fn unregister(&self, bar: &Bar0) {
         let hal = hal::fb_hal(self.chipset);
+        let registered_dma_handle = hal.read_sysmem_flush_page(bar);
 
-        if hal.read_sysmem_flush_page(bar) == self.page.dma_handle() {
+        if registered_dma_handle == self.page.dma_handle() {
             let _ = hal.write_sysmem_flush_page(bar, 0).inspect_err(|e| {
                 dev_warn!(
                     &self.device,
@@ -89,8 +95,7 @@ pub(crate) fn unregister(&self, bar: &Bar0) {
                     e
                 )
             });
-        } else {
-            // Another page has been registered after us for some reason - warn as this is a bug.
+        } else if registered_dma_handle != 0 {
             dev_warn!(
                 &self.device,
                 "attempt to unregister a sysmem flush page that is not active\n"
@@ -99,6 +104,12 @@ pub(crate) fn unregister(&self, bar: &Bar0) {
     }
 }
 
+impl Drop for SysmemFlush {
+    fn drop(&mut self) {
+        let _ = self.bar.try_access_with(|bar| self.unregister(bar));
+    }
+}
+
 pub(crate) struct FbRange(Range<u64>);
 
 impl FbRange {
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 0f6fe9a1b955..5bad5a055b3b 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -257,7 +257,12 @@ pub(crate) fn new<'a>(
                     .inspect_err(|_| dev_err!(pdev, "GFW boot did not complete\n"))?;
             },
 
-            sysmem_flush: SysmemFlush::register(pdev.as_ref(), bar, spec.chipset)?,
+            sysmem_flush: SysmemFlush::register(
+                pdev.as_ref(),
+                devres_bar.clone(),
+                bar,
+                spec.chipset,
+            )?,
 
             gsp_falcon: Falcon::new(
                 pdev.as_ref(),

---
base-commit: a7a080bb4236ebe577b6776d940d1717912ff6dd
change-id: 20260409-fix-systemflush-de66dc90378a

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

