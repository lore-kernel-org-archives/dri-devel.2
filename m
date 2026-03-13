Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19D0107BCCC
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:55:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 489E710ECDF;
	Fri, 13 Mar 2026 16:55:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="FS4dGcAQ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2F6910ECDF;
 Fri, 13 Mar 2026 16:55:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9IV3WPXkiaMSWkWfJnCHFwT7xlGyxxA1QE5Zyy+dLRzj40QhJOFCxZoqApiRRgDySh0vQQ5W6xGBaDtULEomUo7ENBEzjq7FrtlcdTmR+0rrW+CQ4rnpPUiPCbLeOPoGxkwbN8FxcqL0bw9IhIB0u3xTY33phWRXcJwErX8BtHsHfLGtSRGVTMLeOGrczCYxStWhnOA2N8+lV7axx597ZuU/dJLdRQazvj5of86FNQK0dtVRH8nROht6F6cwaC8k6VkE7zNFEB8tmAhhW61s2CZWXJIBcmg23qf/7GhpMtsRMtS0xBsDRFpNev6KPkspZc1c5GoFzqPvzZ+Ptd+gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rd+TTPooTN/qLNu/i2xHB8fotrSWosIXnjQTTFQ9H8Y=;
 b=i7BtpNlQk7CL6kgFvvgcCOaMpaDodiXMt/B7b0SNFAbdm1/KcbWZ+y1+8y0dWCgLxwk1T6DNY5ikszb23QO2+REBYNU5AaZBZJ7HikVzZvoODdYW3Nx28jPiTpGM5JN0vKpzaEDJ5n+TnPzQbEUXPUBAhdhq4cQBnfuNC8L8C29Yy3CBlsb8c81UpT2v8ag7pijix4PCZjFZgXFbdi18SkCqjIMQ7k/FBDQawPW0MZv1nRb/UL9VDNTs7uyP79YzzDQwAZD2H6mY9q9IJMFZXSRxnsUcpCj9A0yqlW/5iu9qEcdWQ4Me6GDmLVK5bCuU5xEZm+saunZyEt9iyJvVcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rd+TTPooTN/qLNu/i2xHB8fotrSWosIXnjQTTFQ9H8Y=;
 b=FS4dGcAQZqbRV9pfyOw8CBnaJzfOBLehi93GQpjRbzjz4yIs7X+N+FCb1Ue7U+pNTZtuzsRuhhZTev+VDs3CJ4OsoH6PKbBA3HuL2oRpx2MUJKvrS+xUX+miafvPPD6iSjGxnpwI0AfIulbv5VjYTiHnPQhNCGlYYaEQOg9dC/M7FfTlgz4kce9TPkPZ0hIstqBeAmwIvwLbABi7d3vNvuSXSWXtAVlngI94fDh0Dj1DraWrno51feLgVV7jbB2wvlmfj3rfu9qO5yA8UGSlAT0bE3ssQyvXN12BxCx00QybbkxmQuFzGUeyCueCe8WCsHXuqx1TAS3bG1KLe8falw==
Received: from CH0P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::24)
 by SJ0PR12MB6968.namprd12.prod.outlook.com (2603:10b6:a03:47b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.7; Fri, 13 Mar
 2026 16:55:35 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:610:11c:cafe::82) by CH0P221CA0023.outlook.office365.com
 (2603:10b6:610:11c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Fri,
 13 Mar 2026 16:55:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.1 via Frontend Transport; Fri, 13 Mar 2026 16:55:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 09:55:10 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 09:55:10 -0700
Received: from inno-dell.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 09:55:01 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <dakr@kernel.org>, <aliceryhl@google.com>, <acourbot@nvidia.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <lossin@kernel.org>,
 <gary@garyguo.net>
CC: <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <jhubbard@nvidia.com>,
 <gjuvekar@nvidia.com>, <joelagnelf@nvidia.com>, <zhiwang@kernel.org>, "Zhi
 Wang" <zhiw@nvidia.com>
Subject: [RFC v2 09/10] gpu: nova-core: reserve a larger GSP WPR2 heap when
 vGPU is enabled
Date: Fri, 13 Mar 2026 18:53:33 +0200
Message-ID: <20260313165336.935771-10-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313165336.935771-1-zhiw@nvidia.com>
References: <20260313165336.935771-1-zhiw@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|SJ0PR12MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: e6354f59-ef8c-4929-14fe-08de8121574e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|36860700016|82310400026|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: O8Rwa+wy6Xo/8lWf4j8PdSkWijbC08JYpweN39q4ag8k/lLO5HDKrFbAPBwDs8VK3WYjPlTSXGn3kKAYejlLdDycsMn/Z8FdMd5l1vPoH1A0byBT3AaxMaA7Eie+U0YN1lSTtlK3qqIZTS4vs0/F82CbTnTNisaHI67gLg81JcMc8zmAzhfdCMfVfL7LF6rXVrQmYYsoKLy9BLoIIfIlii590wril/P6BE/c1kFLLUz/ZRolcGKJuOw2Qad6Z3orEia6BPH1VLIyqq9eZi14lWDmcHyqmDYCYuTiM8zDF42OgYCnyRcf/wle4BbbZnJTa1Ga8fF3N6Fhq/P8WBA/ndz7ebx6FH++xC98f4mkNzVRMwc36g45V5N0j7pR2ALUdpeHdMoBL1XyW2Ath8nZzY4j35yii6esb8f/lkuOs5LJQtsA9wHK3AFWuLscvvLlmLhuy9W5VSY4IMz8FGFxfHuponE9zdcgVbHGoVNY++V6twyJAvf2Amjrokqt7r1zMEseFGlxpbRhE6xlHFbjQI5Ojj/VdzbzI9OQu/LkNS4GwKHZZKTdrfjJgm6DKldLsqymlxNBH5J+BCdoZVGfDCkpg0H2gFevHyd097Wl3ic4ksDujAhRrAc+Ln9TP1wHCt6OhPbEIE1oqUrVtNMDhRT1zWn65TvynRujvsBEF7+6OiKWiDYXRWHvEXseTXs+SRG+RFqTXWzSzGiC07/pHCzs74s7hsMj1bJdQFowUeQ75iSZ0PC7EyVrVSDD8HuP8rE88V8C4CT+i6PJADfidw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(36860700016)(82310400026)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 13rPJPq7mGPWknydETCI0P8eEo0gDAqjHnFPUmysqxxylgrMCA/WKXLcklnc23/cxSRm8Q6mgzkNVxKWZ4y9O0zVUsndjyrleJ/iMLTimFeqYy/Dhkbnzp3UYvuevkd1ZqyzrwVElCasucT7YNIRKk27o/mGsyGIhnAlS70bQbk1d7OPJfX1Bd8W45A8pJTSnCVJP+WUVGA7lvi913r8bWrp7AJ0CUhGcUbH9dGYRqoiANENtSUbEyb3kA+A5+b1yHgpACde9cSszm8SdIgcaEVzomiAWlgjn0KgSPaij4n+OM5ww2NzU+KpMMAT0qaN8FLkeUyc0LK5TyIl6oMKxPYMh/3sfg6c6xmn3zcwf8h4ItBCdAHTOkG7DBoPIxAqpcFsgJT5jKI90ywLrYl57Bd0DwWBZpDN8ZgyUugTkif2kbRIoYLzKxXq3qp3dl7N
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 16:55:33.0293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6354f59-ef8c-4929-14fe-08de8121574e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6968
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

To support the maximum vGPUs on devices that support vGPU, a larger
WPR2 heap size is required. On Ada with vGPU supported, the size should
be set to at least 581MB.

When vGPU support is enabled:
  - Reserve a larger WPR2 heap size of 581MB.
  - Set vf_partition_count to MAX_PARTITIONS_WITH_GFID_32VM (32) to
    support the maximum number of virtual functions in the WPR2 meta,
    or MAX_PARTITIONS_WITH_GFID (48) when total VFs exceeds 32.

When vGPU support is not enabled, the original heap size calculation and
partition count of 0 are preserved.

Cc: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/gpu/nova-core/fb.rs                   | 21 +++++++++++++++----
 drivers/gpu/nova-core/gpu.rs                  | 13 +++++++++++-
 drivers/gpu/nova-core/gsp.rs                  |  7 ++++++-
 drivers/gpu/nova-core/gsp/boot.rs             |  2 +-
 drivers/gpu/nova-core/gsp/fw.rs               |  6 ++++++
 .../gpu/nova-core/gsp/fw/r570_144/bindings.rs |  4 ++++
 drivers/gpu/nova-core/vgpu.rs                 |  2 +-
 7 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 1a84a15581a4..2228b6b08699 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -181,7 +181,15 @@ pub(crate) struct FbLayout {
 
 impl FbLayout {
     /// Computes the FB layout for `chipset` required to run the `gsp_fw` GSP firmware.
-    pub(crate) fn new(chipset: Chipset, bar: &Bar0, gsp_fw: &GspFirmware) -> Result<Self> {
+    ///
+    /// When `vf_partition_count` is non-zero, a larger WPR2 heap is reserved to support
+    /// vGPU virtual functions: 1370 MiB for 48 partitions, 581 MiB for 32 or fewer.
+    pub(crate) fn new(
+        chipset: Chipset,
+        bar: &Bar0,
+        gsp_fw: &GspFirmware,
+        vf_partition_count: u8,
+    ) -> Result<Self> {
         let hal = hal::fb_hal(chipset);
 
         let fb = {
@@ -243,8 +251,13 @@ pub(crate) fn new(chipset: Chipset, bar: &Bar0, gsp_fw: &GspFirmware) -> Result<
 
         let wpr2_heap = {
             const WPR2_HEAP_DOWN_ALIGN: Alignment = Alignment::new::<SZ_1M>();
-            let wpr2_heap_size =
-                gsp::LibosParams::from_chipset(chipset).wpr_heap_size(chipset, fb.end)?;
+            let wpr2_heap_size = if vf_partition_count == 0 {
+                gsp::LibosParams::from_chipset(chipset).wpr_heap_size(chipset, fb.end)?
+            } else if vf_partition_count > gsp::MAX_PARTITIONS_WITH_GFID_32VM {
+                gsp::GSP_FW_HEAP_SIZE_VGPU_48VMS
+            } else {
+                gsp::GSP_FW_HEAP_SIZE_VGPU_DEFAULT
+            };
             let wpr2_heap_addr = (elf.start - wpr2_heap_size).align_down(WPR2_HEAP_DOWN_ALIGN);
 
             FbRange(wpr2_heap_addr..(elf.start).align_down(WPR2_HEAP_DOWN_ALIGN))
@@ -272,7 +285,7 @@ pub(crate) fn new(chipset: Chipset, bar: &Bar0, gsp_fw: &GspFirmware) -> Result<
             wpr2_heap,
             wpr2,
             heap,
-            vf_partition_count: 0,
+            vf_partition_count,
         })
     }
 }
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index e1c16e1b9ec4..e254ddca0fa4 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -25,7 +25,9 @@
     gfw,
     gsp::{
         Gsp,
-        GspBootContext, //
+        GspBootContext,
+        MAX_PARTITIONS_WITH_GFID,
+        MAX_PARTITIONS_WITH_GFID_32VM, //
     },
     regs,
     vgpu::Vgpu, //
@@ -389,6 +391,15 @@ pub(crate) fn new<'a>(
                         sec2_falcon,
                         fsp_falcon: None,
                         vgpu_requested: vgpu.vgpu_requested,
+                        vf_partition_count: if vgpu.vgpu_requested {
+                            if vgpu.total_vfs > u16::from(MAX_PARTITIONS_WITH_GFID_32VM) {
+                                MAX_PARTITIONS_WITH_GFID
+                            } else {
+                                MAX_PARTITIONS_WITH_GFID_32VM
+                            }
+                        } else {
+                            0
+                        },
                     };
                     gsp.boot(&mut ctx)?;
                     vgpu.vgpu_enabled = ctx.vgpu_requested;
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 9435c7430dfe..528f37e581c7 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -26,8 +26,12 @@
 mod sequencer;
 
 pub(crate) use fw::{
+    GSP_FW_HEAP_SIZE_VGPU_48VMS,
+    GSP_FW_HEAP_SIZE_VGPU_DEFAULT,
     GspFwWprMeta,
-    LibosParams, //
+    LibosParams,
+    MAX_PARTITIONS_WITH_GFID,
+    MAX_PARTITIONS_WITH_GFID_32VM, //
 };
 
 use crate::{
@@ -62,6 +66,7 @@ pub(crate) struct GspBootContext<'a> {
     pub(crate) sec2_falcon: &'a Falcon<Sec2Falcon>,
     pub(crate) fsp_falcon: Option<Falcon<FspFalcon>>,
     pub(crate) vgpu_requested: bool,
+    pub(crate) vf_partition_count: u8,
 }
 
 impl GspBootContext<'_> {
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index ed8729041d46..86b7a7aa8f5a 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -346,7 +346,7 @@ pub(crate) fn boot(
         let dev = ctx.dev();
         let gsp_fw = KBox::pin_init(GspFirmware::new(dev, chipset, FIRMWARE_VERSION), GFP_KERNEL)?;
 
-        let fb_layout = FbLayout::new(chipset, bar, &gsp_fw)?;
+        let fb_layout = FbLayout::new(chipset, bar, &gsp_fw, ctx.vf_partition_count)?;
         dev_dbg!(dev, "{:#x?}\n", fb_layout);
 
         let wpr_meta = Coherent::<GspFwWprMeta>::zeroed(dev, GFP_KERNEL)?;
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index ca01ac3af9c6..b46ab6b921e3 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -454,6 +454,12 @@ enum GspFwHeapParams {}
 /// Minimum required alignment for the GSP heap.
 const GSP_HEAP_ALIGNMENT: Alignment = Alignment::new::<{ 1 << 20 }>();
 
+// vGPU constants from the bindings, re-exported for use by fb.rs and gpu.rs.
+pub(crate) const GSP_FW_HEAP_SIZE_VGPU_DEFAULT: u64 = bindings::GSP_FW_HEAP_SIZE_VGPU_DEFAULT as u64;
+pub(crate) const GSP_FW_HEAP_SIZE_VGPU_48VMS: u64 = bindings::GSP_FW_HEAP_SIZE_VGPU_48VMS as u64;
+pub(crate) const MAX_PARTITIONS_WITH_GFID: u8 = bindings::MAX_PARTITIONS_WITH_GFID;
+pub(crate) const MAX_PARTITIONS_WITH_GFID_32VM: u8 = bindings::MAX_PARTITIONS_WITH_GFID_32VM;
+
 // These constants override the generated bindings for architecture-specific heap sizing.
 // See Open RM: kgspCalculateGspFwHeapSize and related functions.
 //
diff --git a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
index 354ee2cfa295..1273152266ad 100644
--- a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
+++ b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
@@ -40,6 +40,10 @@ fn fmt(&self, fmt: &mut ::core::fmt::Formatter<'_>) -> ::core::fmt::Result {
 pub const GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MAX_MB: u32 = 256;
 pub const GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS3_BAREMETAL_MIN_MB: u32 = 88;
 pub const GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS3_BAREMETAL_MAX_MB: u32 = 280;
+pub const GSP_FW_HEAP_SIZE_VGPU_DEFAULT: u32 = 581 << 20;
+pub const GSP_FW_HEAP_SIZE_VGPU_48VMS: u32 = 1370 << 20;
+pub const MAX_PARTITIONS_WITH_GFID: u8 = 48;
+pub const MAX_PARTITIONS_WITH_GFID_32VM: u8 = 32;
 pub const GSP_FW_WPR_META_REVISION: u32 = 1;
 pub const GSP_FW_WPR_META_MAGIC: i64 = -2577556379034558285;
 pub const REGISTRY_TABLE_ENTRY_TYPE_DWORD: u32 = 1;
diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index d35081a088cf..5736eaa79654 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -14,7 +14,7 @@
 pub(crate) struct Vgpu {
     pub(crate) vgpu_requested: bool,
     pub(crate) vgpu_enabled: bool,
-    pub total_vfs: u16,
+    pub(crate) total_vfs: u16,
 }
 
 impl Vgpu {
-- 
2.51.0

