Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806A8CD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 13:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDE9310F32D;
	Thu, 21 May 2026 13:51:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="N/dt5DPR";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010039.outbound.protection.outlook.com [52.101.61.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9B7310F32C
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 13:51:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgmPbuV1TMPnh8BtWKyhnhgKTtIyQsFfmLsuXDSm/tzS9ZobP/rgtmLrrCSozSIJkc1/2jIzzvr9hXy93S5tvOUJqFNCgZ94PQa2xc50G3B7G8QUlipRgkGgAr7f3vZsrk4o03vMW2Q+Ii78Ad4F62XBL4+/TEF7jnK3BikuaIC9oR5hn6+OaUJJQu7AUQaHOIsLzDHfcTaD0zXjMKOegYmpFmHRoE3hcPVdXsuTdmbR9R2LFmWxmZU7YPrnmGhyvBIhzPwiH7AcAFhnV7vIughnfvInlFBrpafUFO4AcNr64yqfzVN+PsJYYAfXzxzdRtgRg6X8Idz+S/73DxQXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hW7tynBiKle9bC5NatF+YwYoLRAZArXfplnZbQl928w=;
 b=lS0cEOr5/tRG5i7qdd+glrZSeldi6hHiMCpY5oTk3SXq1Pt71fIPiRRKuE7Z7wnuopym9Ar3U4zFXNCzV37W5ibZwHAOwaJ5JY7QpcqkEYU4P+0zYdKZqxjxjBoezZlrPQPVBeQPmOQ4C8qKgV13pT8L3kZe/6vefK4GO2O00sQd05fSJJu9uI3a7UEylqsdHLSCTaD+yUBLpVaRUkkgcxImMBLbxnVcJkdT1NLPfxNP/0HyeUoNWOfLNU8emJ6ChfVqWJGemKpPXOQmcopCXSFtfFQcunIr8EJWrN61e1L6Fvgf10IgSzOj+DzI+KTf9amd9uTM0eLw99C1q8p6tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hW7tynBiKle9bC5NatF+YwYoLRAZArXfplnZbQl928w=;
 b=N/dt5DPRF9NmEDvGRjKX5jo2Otty9OSEa5zZG/ZZ4daKZl7633MXiWUjZr43hgfGBWx8zDeiTIbF7ZEGIMmJ4hN2hfo3YLYxFULYQmKDaVa/4S2BtDbZRk572svRV9Tq24oy8qVBR15wxMxqDdvHu97pb87UW9mkyP8E9ElUDkvdyTJPwoqSU3rI9VX6/cmFo51qBu7KmlY64r7vwfnWbmKRGEVyW7C7fNtuqzfgZDm39nGAlE/rDKbxvaYBwB3QZNfennBO308bC+SiOfAK1VFWb1SjquqOvpBt2/8mdh7hhZR+zH2nJxah1z1daT74hxaNFsV7Q2s282348yh/EA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Thu, 21 May
 2026 13:51:10 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 13:51:10 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 21 May 2026 22:50:50 +0900
Subject: [PATCH v6 3/7] gpu: nova-core: send UNLOADING_GUEST_DRIVER GSP
 command upon unloading
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-nova-unload-v6-3-65f581c812c9@nvidia.com>
References: <20260521-nova-unload-v6-0-65f581c812c9@nvidia.com>
In-Reply-To: <20260521-nova-unload-v6-0-65f581c812c9@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P301CA0039.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN0PR12MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: 94038767-e136-4e55-d586-08deb7400392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|3023799007|56012099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 9UB7uOttpSBNhumLu8NBl4TUtBxiXBSQea+FBRp18GLqaNEfRew+DS4O5NJgxTDSlkm6nAJUNaug7SweuHx9X3uDH7rSTDYn3g91SzINrVgCr9qtOxwx1LX4QfsAXjHdbsyIRShp60e/cCCc+OvHy9lHYOAiUXp/nW7yjK2XrTJpMaeWW61HnaWKOfuo5GAHMk6OtK7FG6sItfYcGK8/o/o36ZjJvY4KHkJ+wJaVL0fyCdnvxNUWxSquEmkkucnHQzJBo/a2POhNviyhb44y72U4u87chOevMdpSjMUSeaU2ohmjWWHdhjuFhJ95UVtpzuhRGR83nlHK/0p3osoevFBjCvMV4JLPXt3nj/Bg+RzyvxXncPTDkCqSqK79aUi6sNrdENG091A4Lbbt6ec7lQeBl8/X87CNbjYO6pf+7MtnOxtTrp2IZEQ8SS0pFJEQ9u6EojeijePBrNOaqrOOgS/hViWgjeFzUPza2J+LpsMGlbAd5tkgWT+IQ2qvtBO3IL5hZL04rJsyQbtZaB7gOGEh53HJdJg0I54xtLbIpCR2bk7PE1zW6P7cwjBp2WgizMGzfhpeoGfFo7kbze2e/GzP+Df2yFnvx46aoeVJ8Sb+OkBp+K4nB5A/kJoPNvc/TQPOVjBTQokKR88WqNo6bNSMlCSctRhMmXt5MkAHVk9REbYm2nTwSuEThxxayVQk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(3023799007)(56012099003)(18002099003)(22082099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDZtY0V5VU8rMDZ1SE5pVkMvQSs5NDZzS1k4L2IvMVdIaDNNSWlJajNuRGR0?=
 =?utf-8?B?SGtNQTduRGVLUFA0WVBCVkF2Q2poTEIrN3VBWWZZRHo5YkdFYXhYREk2QkpK?=
 =?utf-8?B?TnlpWXpqNjd3SldrcFVwOEp2a0tEMW9yY3Zpd2ppQjduNEJ5MWdCM1JOTmox?=
 =?utf-8?B?NlI0bWFFT0R5VklYWFpCc3hsZHVKUWg4TDBEZkJ5d0pkRXdEZm1MeEVIOVJU?=
 =?utf-8?B?UmtPVVRRWFc0bVk2d2VhYldLMHlpd09rUzBrdklZY3poVGNQUUUxOENQYllQ?=
 =?utf-8?B?MzFBTWltRy9ubG1mdUYvWGplWnpDY3BKdS9ZM3NrdGNWdEhEd1BMZWV3VnM2?=
 =?utf-8?B?bkVjSnlJa2ZoWmNjd2dvTXlDTjdKc1VYNDlGYzZCanNjV01tTFdydXNnb3ZT?=
 =?utf-8?B?TGkrNFFTVXg5RTRXR2tsbzc4T3MyUHhXcm43R25ZNS9ZUWtlNEtkRXFPNCtL?=
 =?utf-8?B?VytpYjRxZ3FZU3M3c3FMd3N1dlVLcGwxQm1reHZjb3Z3TFZreCtSNFUySHlY?=
 =?utf-8?B?ZE53bmhiQVkybURnamdmRGxlVDZpVCtsbGRkVHJHc1E0U0tXTmN2dllWajgz?=
 =?utf-8?B?c1Blc0pBNy9RZWdxNXZnUlBONkNkMTEzZE4zOGtOeXJQbks5WjQ2WmV0ZFBw?=
 =?utf-8?B?RTVoNm9qTVBGcmZDb3ArVjZqM3VUeGY3a1p1YkhZM3U2LzUxZnBlR1dpUVZy?=
 =?utf-8?B?THdmT0JNYTZudWlsSTlmRVJiNk1oMHI4UlpsdXcrcldtYTFWYnh1a2J2VitM?=
 =?utf-8?B?WUZPUFI2amRKOFlhMTRVQmNzNFJnSFE1alhKNG9LZCsxeFl3cUZDVnh5LzdL?=
 =?utf-8?B?aEg4dWlMQmhURHJ5ZWhIdU1mUWZ4S1JaUjNzbXJmV1BNSWt4d3JocVVKYjlD?=
 =?utf-8?B?UVh5QitDRkZrUG5ZV2pSMm13Rm1xQlVSamNTU0NnZ29sSkh6RmxPQkw2dEk1?=
 =?utf-8?B?TmxHOHBoR1ZiR29GTERPRHFVd25MSCtka1BKc200RWRuVmUyMnVHRzdWS2U2?=
 =?utf-8?B?OXlxRFdKOW9SaDV5QWxLLzJSTFY2YUdST2RwVDNQSmZ0N2RBdC9jUTBsK3N4?=
 =?utf-8?B?K0tJTGtMRkNjUHJLWWhnTUMzUktuc05Icm5CaGJGM2VNQTJrMG5lTE5DdjRi?=
 =?utf-8?B?VUxHbnA2Y1JSRVl2Tkd4SXVVS3d4aTVrTFJOZnBNNVlmVmVhTDR3VlplRE9Y?=
 =?utf-8?B?aW5wZE1QaFFZYlVhRnFhR1ZCazB4dTYwTXM5OVNYMVdEaTlvVUVWQ3FUcHdS?=
 =?utf-8?B?VldkTnRkRVdZMDlMT0NzelBtVmVoS1ppdGtvSVlCb0N3eEx0SEdqWVQ2TC83?=
 =?utf-8?B?aWhxUDRSUk10TmFpVUQ3QUJpUVQxam9sZXU2SGI4OXg5WmhJbTB1RlVxN2k5?=
 =?utf-8?B?QkNkai9XQklPNDErL3dsV2tWclRsd3YvRFlLVHNpY1dnUVBCMEsvWU5KODV3?=
 =?utf-8?B?Q2drUDRXRHRkUXI4d01SUEdtLy9ybmxQaWcvdnpxdW5nZzgrSW5RY1RZOU9X?=
 =?utf-8?B?NHZhemZqQTV2Q1lIUTVlbGQrUUNFVXIyOVIxMi9WNGhjVzVTVk1ocUhZSndC?=
 =?utf-8?B?VUEzQi9TWTJFbU5QWGVXcFYvd0dzc1lxZFFQWjl5U3NjaFU3QmFjSFpVS1Zp?=
 =?utf-8?B?YWE5OHcrZm1FQ2pkdExwZk1GbFNLQ0dRSXdRUGk1d0E1WjV2QXErTzMzYTd5?=
 =?utf-8?B?M3ltaXNwUFdBTSs2Q0dPTExEZ1lUbUFVTFhxSVhvTEx1VmNDT1BaeHJmVVIw?=
 =?utf-8?B?bS9mV2lnNnAwc3NlMDFMd21nUkRuaEdUVjhxZGpKT1dSK1d5WTNSUStLUW9N?=
 =?utf-8?B?YloraWF5YmMvRUpraWhWWWNEL0tKNmZwOWF1SzVTUkNyR3dSNFE5WTJkeTF5?=
 =?utf-8?B?anhOSFlNOEs1Y3c1dlg2TC9BSE40cEVkTDhVVEpiL09nd3BGZzJMOHoyTVpq?=
 =?utf-8?B?R2w0a05ST0RUMWJ2N2Nib3JXdjkvRGJFb2JBSlZTRDVzYUJyWVFIVjBreXE3?=
 =?utf-8?B?ZEJCUll0YyttMG9NV2s3b2tNMDdPWUdvdlpvZ1V4ZnVERU1Hb3F2ZXBFdzJO?=
 =?utf-8?B?cW80MkJqZnp1K3FWbHFQcTBHUlJoRXI1c2tEdnNvckswN3BRbTA1dHBwZFJ6?=
 =?utf-8?B?UWVnWGI3WElNZHRYWG9QM0daK1ptTUZJcnczUHZQWUhkTlE5NXYrVGwxd0xt?=
 =?utf-8?B?Wnd3eW1YU1NGbk5xZnpsNVNUQ01QOTkxaWxzNThBMmRadHpvMDM5QTJhdEZh?=
 =?utf-8?B?S3NHbW9oL21XTWgzODNRcDcwRFdKTGpLSmhPV1B5Rmc1a05RMDdGSGtJa3lC?=
 =?utf-8?B?VmlDODZSNTZDOGt3cS9kb3k2ZHhTSXVnZ3BLM3NVZ1VyZHloWGVFNmJ3WTMw?=
 =?utf-8?Q?3zdXakwfNuR7CiYU2QheDiV+Lo0/uguhvzbWHHIChx8Wl?=
X-MS-Exchange-AntiSpam-MessageData-1: GlllTr4rrMqRsg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94038767-e136-4e55-d586-08deb7400392
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 13:51:10.0611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8rtmaDI3rDLhGQZKHOkpptmUtsSP5bYq7MCXvIJJ66HTJYjs8pPXC1uH9ep3XWo+fVaw3o1gx4ij3H7DgXgmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905
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

Currently, the GSP is left running after the driver is unbound. This is
not great for several reasons, notably that it can still access shared
memory areas that the kernel will now reclaim (especially problematic on
setups without an IOMMU).

Fix this by sending the `UNLOADING_GUEST_DRIVER` GSP command when
unbinding. This stops the GSP and lets us proceed with the rest of the
unbind sequence in a later patch.

We make use of the `pci::Driver::unbind()` hook as we need access to the
device in order to properly unbind.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs                   |  7 ++++
 drivers/gpu/nova-core/gpu.rs                      |  7 ++++
 drivers/gpu/nova-core/gsp/boot.rs                 | 45 +++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/commands.rs             | 43 ++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw.rs                   |  4 ++
 drivers/gpu/nova-core/gsp/fw/commands.rs          | 45 +++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs | 11 ++++++
 7 files changed, 162 insertions(+)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 6571a8c59d09..ced1d38d206a 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -114,4 +114,11 @@ fn probe<'bound>(
             }))
         })
     }
+
+    fn unbind<'bound>(
+        dev: &'bound pci::Device<kernel::device::Core>,
+        this: Pin<&'bound Self::Data<'bound>>,
+    ) {
+        this.gpu.unbind(dev)
+    }
 }
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 4c329ab40955..75fe1bdb80fe 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -293,4 +293,11 @@ pub(crate) fn new(
             _: { gsp.boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falcon)? },
         })
     }
+
+    pub(crate) fn unbind(&self, pdev: &'bound pci::Device<device::Core>) {
+        let _ = self
+            .gsp
+            .unload(pdev.as_ref(), self.bar, &self.gsp_falcon)
+            .inspect_err(|e| dev_err!(pdev, "failed to unload GSP: {:?}\n", e));
+    }
 }
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index e838d61bef50..c123080148f1 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
 use kernel::{
+    bits,
     device,
     dma::Coherent,
     io::poll::read_poll_timeout,
@@ -36,6 +38,7 @@
         Chipset, //
     },
     gsp::{
+        cmdq::Cmdq,
         commands,
         sequencer::{
             GspSequencer,
@@ -251,4 +254,46 @@ pub(crate) fn boot(
 
         Ok(())
     }
+
+    /// Shut down the GSP and wait until it is offline.
+    fn shutdown_gsp(
+        cmdq: &Cmdq,
+        bar: &Bar0,
+        gsp_falcon: &Falcon<Gsp>,
+        mode: commands::PowerStateLevel,
+    ) -> Result<()> {
+        // Command to shut the GSP down.
+        cmdq.send_command(bar, commands::UnloadingGuestDriver::new(mode))?;
+
+        // Wait until GSP signals it is suspended.
+        const LIBOS_INTERRUPT_PROCESSOR_SUSPENDED: u32 = bits::bit_u32(31);
+        read_poll_timeout(
+            || Ok(gsp_falcon.read_mailbox0(bar)),
+            |&mb0| mb0 & LIBOS_INTERRUPT_PROCESSOR_SUSPENDED != 0,
+            Delta::from_millis(10),
+            Delta::from_secs(5),
+        )
+        .map(|_| ())
+    }
+
+    /// Attempts to unload the GSP firmware.
+    ///
+    /// This stops all activity on the GSP.
+    pub(crate) fn unload(
+        &self,
+        dev: &device::Device<device::Bound>,
+        bar: &Bar0,
+        gsp_falcon: &Falcon<Gsp>,
+    ) -> Result {
+        // Shut down the GSP.
+        Self::shutdown_gsp(
+            &self.cmdq,
+            bar,
+            gsp_falcon,
+            commands::PowerStateLevel::Level0,
+        )
+        .inspect_err(|e| dev_err!(dev, "Unload guest driver failed: {:?}\n", e))?;
+
+        Ok(())
+    }
 }
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index cc8df448ff39..1ab1f972249f 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -232,3 +232,46 @@ pub(crate) fn gpu_name(&self) -> core::result::Result<&str, GpuNameError> {
             .map_err(GpuNameError::InvalidUtf8)
     }
 }
+
+pub(crate) use fw::commands::PowerStateLevel;
+
+/// The `UnloadingGuestDriver` command, used to shut down the GSP.
+///
+/// Only used within the `gsp` module.
+pub(super) struct UnloadingGuestDriver {
+    level: PowerStateLevel,
+}
+
+impl UnloadingGuestDriver {
+    /// Creates a new `UnloadingGuestDriver` command for the given [`PowerStateLevel`].
+    pub(super) fn new(level: PowerStateLevel) -> Self {
+        Self { level }
+    }
+}
+
+impl CommandToGsp for UnloadingGuestDriver {
+    const FUNCTION: MsgFunction = MsgFunction::UnloadingGuestDriver;
+    type Command = fw::commands::UnloadingGuestDriver;
+    type Reply = UnloadingGuestDriverReply;
+    type InitError = Infallible;
+
+    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
+        fw::commands::UnloadingGuestDriver::new(self.level)
+    }
+}
+
+/// The reply from the GSP to the [`UnloadingGuestDriver`] command.
+pub(super) struct UnloadingGuestDriverReply;
+
+impl MessageFromGsp for UnloadingGuestDriverReply {
+    const FUNCTION: MsgFunction = MsgFunction::UnloadingGuestDriver;
+    type InitError = Infallible;
+    type Message = ();
+
+    fn read(
+        _msg: &Self::Message,
+        _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
+    ) -> Result<Self, Self::InitError> {
+        Ok(UnloadingGuestDriverReply)
+    }
+}
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 3245793bbe42..33c9f5860771 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -279,6 +279,7 @@ pub(crate) enum MsgFunction {
     Nop = bindings::NV_VGPU_MSG_FUNCTION_NOP,
     SetGuestSystemInfo = bindings::NV_VGPU_MSG_FUNCTION_SET_GUEST_SYSTEM_INFO,
     SetRegistry = bindings::NV_VGPU_MSG_FUNCTION_SET_REGISTRY,
+    UnloadingGuestDriver = bindings::NV_VGPU_MSG_FUNCTION_UNLOADING_GUEST_DRIVER,
 
     // Event codes
     GspInitDone = bindings::NV_VGPU_MSG_EVENT_GSP_INIT_DONE,
@@ -323,6 +324,9 @@ fn try_from(value: u32) -> Result<MsgFunction> {
                 Ok(MsgFunction::SetGuestSystemInfo)
             }
             bindings::NV_VGPU_MSG_FUNCTION_SET_REGISTRY => Ok(MsgFunction::SetRegistry),
+            bindings::NV_VGPU_MSG_FUNCTION_UNLOADING_GUEST_DRIVER => {
+                Ok(MsgFunction::UnloadingGuestDriver)
+            }
 
             // Event codes
             bindings::NV_VGPU_MSG_EVENT_GSP_INIT_DONE => Ok(MsgFunction::GspInitDone),
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index d3ef7ecdd73e..00e54361839a 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
 use kernel::{
     device,
@@ -131,3 +132,47 @@ unsafe impl AsBytes for GspStaticConfigInfo {}
 // SAFETY: This struct only contains integer types for which all bit patterns
 // are valid.
 unsafe impl FromBytes for GspStaticConfigInfo {}
+
+/// Power level requested to the [`UnloadingGuestDriver`] command.
+#[derive(Clone, Copy, Debug, PartialEq, Eq)]
+#[repr(u32)]
+#[expect(unused)]
+pub(crate) enum PowerStateLevel {
+    /// Full unload.
+    Level0 = bindings::NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_0,
+    /// S3 (suspend to RAM).
+    Level3 = bindings::NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_3,
+    /// Hibernate (suspend to disk).
+    Level7 = bindings::NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_7,
+}
+
+impl PowerStateLevel {
+    /// Returns `true` if this state represents a power management transition, i.e. some GPU state
+    /// must survive it (as opposed to a full unload).
+    pub(crate) fn is_power_transition(self) -> bool {
+        self != PowerStateLevel::Level0
+    }
+}
+
+/// Payload of the `UnloadingGuestDriver` command and message.
+#[repr(transparent)]
+#[derive(Clone, Copy, Debug, Zeroable)]
+pub(crate) struct UnloadingGuestDriver(bindings::rpc_unloading_guest_driver_v1F_07);
+
+impl UnloadingGuestDriver {
+    pub(crate) fn new(level: PowerStateLevel) -> Self {
+        Self(bindings::rpc_unloading_guest_driver_v1F_07 {
+            bInPMTransition: u8::from(level.is_power_transition()),
+            bGc6Entering: 0,
+            newLevel: level as u32,
+            ..Zeroable::zeroed()
+        })
+    }
+}
+
+// SAFETY: Padding is explicit and will not contain uninitialized data.
+unsafe impl AsBytes for UnloadingGuestDriver {}
+
+// SAFETY: This struct only contains integer types for which all bit patterns
+// are valid.
+unsafe impl FromBytes for UnloadingGuestDriver {}
diff --git a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
index 334e8be5fde8..f82ed097b283 100644
--- a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
+++ b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
@@ -30,6 +30,9 @@ fn fmt(&self, fmt: &mut ::core::fmt::Formatter<'_>) -> ::core::fmt::Result {
         fmt.write_str("__IncompleteArrayField")
     }
 }
+pub const NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_0: u32 = 0;
+pub const NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_3: u32 = 3;
+pub const NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_7: u32 = 7;
 pub const NV_VGPU_MSG_SIGNATURE_VALID: u32 = 1129337430;
 pub const GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS2: u32 = 0;
 pub const GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS3_BAREMETAL: u32 = 23068672;
@@ -880,6 +883,14 @@ fn default() -> Self {
     }
 }
 #[repr(C)]
+#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+pub struct rpc_unloading_guest_driver_v1F_07 {
+    pub bInPMTransition: u8_,
+    pub bGc6Entering: u8_,
+    pub __bindgen_padding_0: [u8; 2usize],
+    pub newLevel: u32_,
+}
+#[repr(C)]
 #[derive(Debug, Default, MaybeZeroable)]
 pub struct rpc_run_cpu_sequencer_v17_00 {
     pub bufferSizeDWord: u32_,

-- 
2.54.0

