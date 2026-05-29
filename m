Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C31BCD6E49
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 07:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03F6A10FA17;
	Fri, 29 May 2026 07:34:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VWn7rAKd";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011051.outbound.protection.outlook.com [52.101.52.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FC2B10FA16
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 07:34:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUZTfTlBAXj4z3giog3ezHlX59eZVg5BbnmgRmFAOxqPk68lKndASdoBQ4194tQesFdQLVEtkd778obN/269DdGJl9AyAVtgbJzY43db7Co/Riz3kacFJBe6d8hFgtIHydeQjq1vVBK4/jND8xrJmE/6tFPyV+h8BqO6p8mRRPODM4JRYSVtwd0QpuGnt6y3Z2YcVQb1FTprLtCWnBFVAOxPLw141X5qX2RMa/DEepRw7XZ/LVRoRFrgK+KTqrTugK0zGI8U/xtapQItBWQ9ezURZrZJuEqeFRtzJCut7cPrCe+KGgL+djiABDODmYQltyUG9px42D2oYS8JSg/7Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZE+5ojSoUd1hFYGILpmlPDQC9m7/1quJg3LoZFDDmFg=;
 b=jZMcQwzSU+CuwBD2NRghrCYQTaQKLBKsN3/Nb1PBKLU1xBjRMCp1MyL1ae3Ow0T+yfXxqh1kwv4Zt9Dg61tIw3NqFXPzIahiiNP7OwAa+0ROkSpuCKYrFmIvxyOg3UBbPAybhpuZoJpcank8jvJn/YlKORJb8qvSy2Q3dLoLQkthhFROitlkGh42nIueI1D4rWUiVNmhSFdLNpHzopH9Fve1ZcaDYndji7c3TwvlNmRFc85DULLMVa6mqG6WZAzJc8vfCWlm6xy7CJbdDaxjm/V4KPvpyGNSjbE+t/i+TnL4ScjmLnu1qHi+JtV7AXUKPaODI/Z+Ayl8gywmhqesEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZE+5ojSoUd1hFYGILpmlPDQC9m7/1quJg3LoZFDDmFg=;
 b=VWn7rAKd1WL/GrFzjgRuZYNkjMcATxgYHFudhgRub3GnGXkoBKGO0Lch8ZY5H/Q+aYGXlt9dDOugJOWOUylANkT5T8M5ZoJwR5JK/PyiUSN+6v4vP0x0/A1Yeam2AGzkS/1fxJR77o290FEVDis1nZgRKUYY5he2UdsUDisEIHG5/T7m45QNIK18xnLYt4v5XZ92pmh48a0C4zzqZ5triV9dN0rYaT9gK1aHRK20U2fimMgIZiG5U1KuNnhz46dAA0yGLYimrYhLxtOsU9ECjacuhOc3776hDQz5R385bm8zKj+UTxqoapdl2FfVhzU0brtL10LhFbf94oYBhuG3lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Fri, 29 May
 2026 07:34:08 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0071.010; Fri, 29 May 2026
 07:34:08 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 29 May 2026 16:33:42 +0900
Subject: [PATCH v7 2/4] gpu: nova-core: send UNLOADING_GUEST_DRIVER GSP
 command upon unloading
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-nova-unload-v7-2-678f39209e00@nvidia.com>
References: <20260529-nova-unload-v7-0-678f39209e00@nvidia.com>
In-Reply-To: <20260529-nova-unload-v7-0-678f39209e00@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0325.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f89f2e-1ee7-4b96-e08a-08debd54ab51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|18002099003|22082099003|11063799006|56012099006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: NIHooNwPiivn+VewCo5agcyMRoCYQkceOcudUs1itAaZf+TEykNQnRZLBu4Qwq2HuoZCWPUVGQC0cHyJZsXVH1MKTO+4J/kpuSNy5heDBLXMt4M8vG0PA5ydoMtzhYwhm9LVtEHbCvnAVI/kgwoSeUKayjSGrCEggW9v2r1qaBzFZNNjZw6X9mRqUx/eo3Xmf9flIQkFX/uxIXR4qzl6zLX1Fc58t9+hImeZ80PQ2RO/9nyJxIpxqvNFt6s/G3GI0+OEeUIPhuq13wkyFz5m4B9I4oILITZwm0AQ/L+y+Yb3H4ax93KbGblmbjyKJkp3+ogfy3WUU2+1y7LlmVFuPBMt7PURQo5tqW7dyz0JoAucDGRk0mjetBQ6aeoY7JN5UVZeTjN0TFoXW/qW34wRXbbrn0owR6SVfdHo/5AdS/dIz6TVHcq/qt+pdjzm5t/kVt49/toF5b9EPjxytAQOl0j9FVF/l8jOl166LhkHHv0NdhLbmZ4e9gmWY9vlTe/q70Ho9YtdMJ7oNISCyIUCG8IF7ZBtuILECFpq74/tEJ9C6xk7eYfgT1iHaJXaDKUQAaZnP75BM8z9dPelMIn8fNitQ6lu9i0PuCjut8jXm+dK3jxV362Oc/xP+wKNdsSu0KqmOUi4M7MS8ut4Ho3NbTHAwiEUi7T/LyUmEWvqHU2VzYco8KTUSTaVoX9ImMq0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUNJUWlLSitQN1IxNkREeUYvUURnS3lHcnRWVDJZckhlUkgwMFdRUHFlb1Rk?=
 =?utf-8?B?Qkh6VjVvbnlEWHpxa0g0UE01dFVRWnM4RURnZkFTUnBhSjJBcmxWMzZZWTZ0?=
 =?utf-8?B?RktnUXk4cFdDQ3czWUlBV2ttUmNxS0NzNG5PQ1pVbzRvZHBZTmJnbis5cXNL?=
 =?utf-8?B?WmpXdGI0MEVZY0d4aER2d1RNV0lrZEQ1TjBlditjbC9DSEhjN215em5jSkF6?=
 =?utf-8?B?dmZsd2x4Tkl5akJkdk13QzZSQjZMY0RXM3pjUVdVZm5reUNFRmYxUnpXcDZj?=
 =?utf-8?B?Q3krY2pOTUZCbkRmdjYzMlpkSWViNktFZFRyYWJQeEtYbEZyVlNNZ3g2QTJi?=
 =?utf-8?B?MnJHMW5oS2lsYzFObUNTQ2JRWldET1VVQzVwMVREUGhmeVJiV2NIM3UxSm1v?=
 =?utf-8?B?UFFNMzNoSnY4dnI1UFVZUmVvOXlQN2xic0NQT2M2Sys1YjBnQWc2dDdOdDRV?=
 =?utf-8?B?cVA1NHVxVUFaMVZxMnMxOU1yUFYrUXUxOTZGQ2drMHZKSVFhUjdDd2JpQzBB?=
 =?utf-8?B?UjJIS2JTZVpDdWZqbEJtNjJKUSt4WFQvTHI0NnI5V1F4ZVA3QXBaejNmQlc0?=
 =?utf-8?B?QklhbUlRT0l0WmcxdkxzNGl6eXNzdHFkR0hNeWF6aGhYRVJWTE1acmlPcnla?=
 =?utf-8?B?K0ZDdjdRNnc3bXZSeWpMRGNwZnB0SmI1OXMrb1BydXI1MVA3MEo1a1hKNUIy?=
 =?utf-8?B?T3dueGdNTEpGSTZTeVo4b2ZzS0doUGhrKzBnNjNrYXZ5eEZtOTBhMHZrd0w1?=
 =?utf-8?B?NGJkUUFKWnZTVE1MM2tYa0xoUUJGNkFudWlXdmUxNWt5QTZTbFc5VVhYTkFr?=
 =?utf-8?B?Ym9kWG1saE1uN3VmVFAwNEhDUUhNRUxMbDBodzROK2h5OW00eVNyMFRWWU5u?=
 =?utf-8?B?NTJMc2wyN0ZGY25USFlsV216cS9XQ0d1M05hUlZ6N2padURLaTZ3VlQ2cXVP?=
 =?utf-8?B?b1JxMm04ZmtDUXNwazVuQ3ZXRWQrQjhSZzhJMVNVWkkyY05kZTRRSFpmeHZn?=
 =?utf-8?B?bk85OW5mTlpBejA1d0R0VWVpOHIzbGI4NGt4Tzh1NkhmTlU0UCt4UmIvNG1u?=
 =?utf-8?B?RXViaElTOWc1SmtYdjA4aFlwYjdsK1pzSEQxYWYwNFhZU3VYZFJHRWFGaXFF?=
 =?utf-8?B?cThDcjU5S01JT3FZWk1pSmhTOFhGc3V4WUhzYWJoS1p1dlZPT0dYMVdyR1hS?=
 =?utf-8?B?QkhRcW1oVDZ0NkhoZmhYMnJoVElaak5wNEoxejlkY2Uzemg3bFhCbm12TFhu?=
 =?utf-8?B?UHB2MmxyblZwWlIzNzdMdzBlbDFIMEdJY1lmY0M1Nnl2WENvNmNsODlCU01D?=
 =?utf-8?B?dkE2RDdja1diRWY5OTZ4NERuL1IrT204MG1SVUllYlJ2OTA2b2pjRmQwVDlh?=
 =?utf-8?B?c0JQY0NFODBUNGZSU3IzZ2o0MDBZRytxZjVOTStybXFoeEFSZHVRK3F4MXZG?=
 =?utf-8?B?RXgwV2JlVkJIS0VqaEpPMmdBanVGOVZGdnBNUWhuL0hWaFk3cHVqRkxQc3Bz?=
 =?utf-8?B?U1MwcnRHME9zbWZMcEs5YWt6RHpEOWxLVGMrd2MrSkJFOWg2STJjeFBqcFMv?=
 =?utf-8?B?eTR1NWlFUEZDTmErNC9zUVZCd0g5eUxuaG1DcDBKRkZlY0h2QVg4VzJlYjU2?=
 =?utf-8?B?aXpnTzZxbzNOblRTa3lxdDdjVFhvdDNiSUJhQmQrMHFVTXE5bFU2My9kYWgy?=
 =?utf-8?B?YnVIb0ZXMEZrNFJ6Y09YQm9oa01rMktIU1pLWGpGb3ZWbysrMStBNVJNcnI4?=
 =?utf-8?B?S3UyZGlBNWpZRW8zTFFibDJzWkVBMm5qTzd4ZFJSWWdRRm1DNFVhcmZ4c0F4?=
 =?utf-8?B?a21MMmR2ejRaaHZHL1d1bHU3T0g1Z09Cb0tmdzJZbkYrMzg1MFJkWTJIUXc5?=
 =?utf-8?B?V1BSRVNCTlJ0ZGUrVG1Dd0E0b2hSK3ViOUhaT05udmJKL1ZBWHpvTXUzQ3pm?=
 =?utf-8?B?L25BYW1yaEJtWnRVMGpsSnZBRFpmOHJjbUNRT1lzQ2ZZNEtCanZqZGtMZ2FX?=
 =?utf-8?B?RVpnQUhydWJxWnpFV3hoSEN2TUdTM0JEOWxUTXJZQ2h2a3FDOUhLakxNK1gw?=
 =?utf-8?B?NlpEaFVkVTBSNkErZjhtRmtsNTJNZ0hTSFBab2pLdmoreWpLaWlub2lUY1pG?=
 =?utf-8?B?MWc1RFRPQkJDb20yeHRaWFduUE15aU42RGFhazFIb3dMWk5LcDJEWnFlN21Y?=
 =?utf-8?B?MEE1UlpIK2dsb3RkN2orNFhFWndrT05jd2lCUGJLQjZPSlNtdEtWUVhzekhO?=
 =?utf-8?B?NnBueTVySmY1YWViMmZDaWhvejBFUFFZSXJpMnU4eDhwK0FLT2N1WFREdkZZ?=
 =?utf-8?B?WmFzZW1nbzMzZFpQNDF0VHVKNmUzS0JhYnRJbUc4bXpxZDdvK2N2MlVMeWpK?=
 =?utf-8?Q?3ERIGQZ6kRDW1WNyF1iDQSUgb1jZt3RQkpj91DXigJ6/l?=
X-MS-Exchange-AntiSpam-MessageData-1: hRritfizi5r+pA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f89f2e-1ee7-4b96-e08a-08debd54ab51
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 07:34:08.4014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGEaX7FrCTshZWU0xgxoMCRR6WcZmE2lDpxG3x9hjlhr5kYNsw+ej+aQu1DUOJ9uD0xqXdA0/708xcKio27Xsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
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

Fix this by sending the `UNLOADING_GUEST_DRIVER` GSP command when the
`Gpu` is dropped. This stops the GSP and lets us proceed with the rest
of the unbind sequence in a later patch.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Co-developed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs                      | 21 ++++++++++-
 drivers/gpu/nova-core/gsp/boot.rs                 | 45 +++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/commands.rs             | 43 ++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw.rs                   |  4 ++
 drivers/gpu/nova-core/gsp/fw/commands.rs          | 45 +++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs | 11 ++++++
 6 files changed, 168 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index cf134cab49cd..011d504830e4 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -243,8 +243,10 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 }
 
 /// Structure holding the resources required to operate the GPU.
-#[pin_data]
+#[pin_data(PinnedDrop)]
 pub(crate) struct Gpu<'gpu> {
+    /// Device owning the GPU.
+    device: &'gpu device::Device<device::Bound>,
     spec: Spec,
     /// MMIO mapping of PCI BAR 0.
     bar: &'gpu Bar0,
@@ -266,6 +268,7 @@ pub(crate) fn new(
         bar: &'gpu Bar0,
     ) -> impl PinInit<Self, Error> + 'gpu {
         try_pin_init!(Self {
+            device: pdev.as_ref(),
             spec: Spec::new(pdev.as_ref(), bar).inspect(|spec| {
                 dev_info!(pdev,"NVIDIA ({})\n", spec);
             })?,
@@ -294,3 +297,19 @@ pub(crate) fn new(
         })
     }
 }
+
+#[pinned_drop]
+impl PinnedDrop for Gpu<'_> {
+    fn drop(self: Pin<&mut Self>) {
+        let this = self.project();
+        let device = *this.device;
+        let bar = *this.bar;
+
+        let _ = this
+            .gsp
+            .as_ref()
+            .get_ref()
+            .unload(device, bar, &*this.gsp_falcon)
+            .inspect_err(|e| dev_err!(device, "failed to unload GSP: {:?}\n", e));
+    }
+}
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 1bd9f21fc443..adc66809ce83 100644
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
@@ -23,6 +25,7 @@
     },
     gpu::Chipset,
     gsp::{
+        cmdq::Cmdq,
         commands,
         GspFwWprMeta, //
     },
@@ -97,4 +100,46 @@ pub(crate) fn boot(
 
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
index ac9cef312b10..3a365455d10c 100644
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
index db46276430be..42985d446bae 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
 use kernel::{
     device,
@@ -129,3 +130,47 @@ unsafe impl AsBytes for GspStaticConfigInfo {}
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

