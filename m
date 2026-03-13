Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3170D107BCCC
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9220510ECE3;
	Fri, 13 Mar 2026 16:55:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="pqxOVcQu";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011048.outbound.protection.outlook.com [52.101.52.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E44C10ECE3;
 Fri, 13 Mar 2026 16:55:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6FCAGYpn773j4oo3M7AIDIBIdRQOLDGcHX6VJ75L2tL8Z89ItOeUEQqBxeDGqf9N66olIijZSk8gCrPD+SnzSslNEoF/SEyny8IxgLvR+9mR/5+tA6lWBkZWH17hiudPFU2eHzkf15IIOcFEal18bex/DGmJbzH43ekqvbs0xuTpsFtKbcuemyDgcxsZBjM1twWIxUAt4q1EwjXFu2eJdGPBtmTAZV+jOIncoD1J7FJtcq4f8djudL8BDCl4oiPNf6YgyBUpSvvySYQXN7QFgJY1vGXV2/AI1gYoQ0mNH7xUsiucZ9dngjaiS60iGrMyChOsuBUtNORFDCwB8efzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3osiK4Zolhz5ftILD32zzS01mINaDbRtk5g7n/sjTg=;
 b=E/VZFd9dVT9zU/Ft6hv4XO/Bay8h2A2YrSdiwjnMq1TQuSChbeAv0TlS8hY4OkLboN0/3KcAjGVRZU2T1jGhH3T8S1LpKmIt2UY3GG6TDmcv9nzqAko22cpKudS+E3QP+uMADvmPrwoD1IDqk9ZPUaXNffoS4488fJT90op9KIsI/JxubpiemRwjujqwcumwrcTflLUyLphdi3WU9Um8WSsJRIywX+aAe79II/pmymm9ijJNueXSeqmHQ6EmC9xy99l0QYRK4z99h2SCYFexxpXtCGo4PYasqiK7cKXEE7TlSGFVbAANUt8n+IRvGCpggZwdxizbMjAw8LLvja6/hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3osiK4Zolhz5ftILD32zzS01mINaDbRtk5g7n/sjTg=;
 b=pqxOVcQuf3vQ9svlE+DNTXHqVYvX65jGF1u9dYx6iREJzBLA9duz/iXYMCVHcRxZk7Jma5Fe4tSMAZdGGyYZd9iOShOrHmEhJhcofKJNA4DrYNxF4PJnHVGqCcriY2Mzmm3OhxjQfcSDeC0J1bsOkBheVEovHK3sxoTUFuvqIhnjlvlR44e/5C11ptwqIHZRPtzn1TPW96sEdnw+L03lCSjN4YPlBSpshijRFB54Hxqizn5nldcd80HDon7arZoL9muj1K791/1DhhO8K219IYBmii0GgyPVokVmsEXKo/HIIPu/dk5L8omu9UOmdGl2cfjvDFGVWnCWTL3e679ffQ==
Received: from CH0P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::23)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 16:55:42 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:610:11c:cafe::9e) by CH0P221CA0007.outlook.office365.com
 (2603:10b6:610:11c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Fri,
 13 Mar 2026 16:55:42 +0000
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
 15.20.9723.1 via Frontend Transport; Fri, 13 Mar 2026 16:55:42 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 09:55:19 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 09:55:18 -0700
Received: from inno-dell.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 09:55:10 -0700
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
 Wang" <zhiw@nvidia.com>, Dirk Behme <dirk.behme@gmail.com>
Subject: [RFC v2 10/10] gpu: nova-core: load the scrubber ucode when vGPU
 support is enabled
Date: Fri, 13 Mar 2026 18:53:34 +0200
Message-ID: <20260313165336.935771-11-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313165336.935771-1-zhiw@nvidia.com>
References: <20260313165336.935771-1-zhiw@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: 00364ea4-9949-4385-10e2-08de81215cc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fjmkrd+QlqDcYX8Y7J0CBo4QNnoia4sWLIw9/ksTCxQOwSJnBgF26oM+PpM8w1Ql65mpnuwzvgZgXODGe8fOOThrKOMLjjxlYwv/OeDHQgoJj5NYQJrXBw0b/saYbsIltDJZxyEf4lJGik98OmODZpwwIt+cec8Y/KaHO2FwXpQwSg6tG3FZqhWchq5OGYwQYntHPlaO2qSxYEpU7CGx7afENLOtg7xX1bZjsDMKMSQ8bztPu8ossmcugL64neWHgWFvdOGDoR/eXZ3/pWvWi5W7SrVai7EYOAnnbkznqKU8zLcaJw8F4D81YS+cmuMCUtzIAn3FgUpKuDtdvyQEjKcc+3mbv+hrJm7TI34FNMacotGVKp9uSvO8DZeIOB0/MtVlXYp7vTL3pcyG9CNFjre2u3Youu7ijgrS+CBGx55ClDrGc2GIiJHNbIObdoCe+2c6eo8pLvDJUh4l09bXM34iGopRXGJMKCzqeKbL9rHnd/k4bDRq6FPRY5apHlMpcbm+P5btpYPOiaV4dfJhpQOUnDOwWYo13EPVFTMRdJnbA+8HZx2weTWqOnNhl6XUy6vKizjQex/wRSyBV67f3APEsmG3ppqt5jBdlDggYfaFlPbbNivVK0+30Il0+qI2QTu/Qeobu85DSvZLY3ww6OCQ1OyQ+hhtSm5lvHSZTrO7WuKWm/Lt0zCr/4ppLZdxtH3c08aisJxT+zIgLUM5IJhkok4/A2yyxMOjMEl7I8jogX3Sct38cJeDoyHOEDm2TCOW3UaWxJ2bxRm16e+aUQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cNzyz0mzf/geGPs1lxybHfH5TggKDDOpkiAnLHYPoQZHpHpLBg7vY6GV9WSgdgZtcANasQzLQbBR6Nl7aNQ4p3QwFebZ/szDUm7s1xLrYdCSCre3nK/R6b1QgH0fuEw3IMc9JgHdwwtcJb1kIekGAmlVvW3cMCQRZqk3xizZ7ii376xuKUSBYJmrvYYpxr59Y66+Xc+gnKHfFeKXpLodBmLVb/uQHnR3tTOR3rL2XR6PgKBKgc4e0XzXulTprRvUTMrjFT0uFYZ+1r96uQfJCyG8mpZRt5XkEPtLKWdL3jr1bOMOI/lzqARPHFNJ3D8wyp7/weGgjhIddwezMNfLjcwanggbJB750XhWUWRUkcB9Y153K2LePhTU/tB+sUihMxi0rz94FjS4AP1t8u7FQsTeaPVBZnJZG5u/XQ4UHHHeWB/Kz5l23px8N6q1hA+k
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 16:55:42.1963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00364ea4-9949-4385-10e2-08de81215cc7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
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

To support the maximum vGPUs on the device that support vGPU, a larger
WPR2 heap size is required. By setting the WPR2 heap size larger than
256MB the scrubber ucode image is required to scrub the FB memory before
any other ucode image is executed.

If not, the GSP firmware hangs when booting.

When the WPR2 heap exceeds 256MB, execute the scrubber ucode image to
scrub the FB memory before executing any other ucode images.

Cc: Dirk Behme <dirk.behme@gmail.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/gpu/nova-core/firmware.rs        |  3 +-
 drivers/gpu/nova-core/firmware/booter.rs |  2 +
 drivers/gpu/nova-core/gsp/boot.rs        | 53 ++++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw.rs          |  2 +-
 drivers/gpu/nova-core/regs.rs            | 12 ++++++
 5 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware.rs b/drivers/gpu/nova-core/firmware.rs
index ab5889fa6a56..d13615864198 100644
--- a/drivers/gpu/nova-core/firmware.rs
+++ b/drivers/gpu/nova-core/firmware.rs
@@ -437,7 +437,8 @@ const fn make_entry_chipset(self, chipset: gpu::Chipset) -> Self {
             .make_entry_file(name, "booter_load")
             .make_entry_file(name, "booter_unload")
             .make_entry_file(name, "bootloader")
-            .make_entry_file(name, "gsp");
+            .make_entry_file(name, "gsp")
+            .make_entry_file(name, "scrubber");
 
         if chipset.needs_fwsec_bootloader() {
             this.make_entry_file(name, "gen_bootloader")
diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-core/firmware/booter.rs
index 04a887bea888..8642957923a2 100644
--- a/drivers/gpu/nova-core/firmware/booter.rs
+++ b/drivers/gpu/nova-core/firmware/booter.rs
@@ -284,6 +284,7 @@ fn new_booter(data: &[u8]) -> Result<Self> {
 
 #[derive(Copy, Clone, Debug, PartialEq)]
 pub(crate) enum BooterKind {
+    Scrubber,
     Loader,
     #[expect(unused)]
     Unloader,
@@ -301,6 +302,7 @@ pub(crate) fn new(
         bar: &Bar0,
     ) -> Result<Self> {
         let fw_name = match kind {
+            BooterKind::Scrubber => "scrubber",
             BooterKind::Loader => "booter_load",
             BooterKind::Unloader => "booter_unload",
         };
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 86b7a7aa8f5a..8f6e2536db1c 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -6,6 +6,7 @@
     io::poll::read_poll_timeout,
     io_write,
     prelude::*,
+    sizes::SZ_256M_U64,
     time::Delta, //
 };
 
@@ -188,6 +189,49 @@ fn run_fwsec_frts(
         }
     }
 
+    /// Load and execute the scrubber ucode via SEC2 to scrub FB memory.
+    ///
+    /// This is required when the WPR2 heap exceeds 256MB (which happens when
+    /// vGPU is enabled). Without scrubbing, GSP firmware will hang during boot.
+    fn run_scrubber(ctx: &super::GspBootContext<'_>) -> Result {
+        let dev = ctx.dev();
+        let bar = ctx.bar;
+
+        let scrubber = BooterFirmware::new(
+            dev,
+            BooterKind::Scrubber,
+            ctx.chipset,
+            FIRMWARE_VERSION,
+            ctx.sec2_falcon,
+            bar,
+        )?;
+
+        ctx.sec2_falcon.reset(bar)?;
+        ctx.sec2_falcon.load(dev, bar, &scrubber)?;
+
+        let (mbox0, mbox1) = ctx.sec2_falcon.boot(bar, None, None)?;
+        dev_dbg!(
+            dev,
+            "Scrubber SEC2 MBOX0: {:#x}, MBOX1: {:#x}\n",
+            mbox0,
+            mbox1
+        );
+
+        // Poll for scrubber completion via BSI_SECURE_SCRATCH_15.
+        read_poll_timeout(
+            || Ok(regs::NV_PGC6_BSI_SECURE_SCRATCH_15::read(bar)),
+            |val| val.scrubber_completed(),
+            Delta::from_millis(10),
+            Delta::from_secs(2),
+        )
+        .inspect_err(|_| {
+            dev_err!(dev, "Scrubber did not complete in time\n");
+        })?;
+
+        dev_dbg!(dev, "Scrubber completed successfully\n");
+        Ok(())
+    }
+
     fn run_booter(
         dev: &device::Device<device::Bound>,
         bar: &Bar0,
@@ -221,11 +265,19 @@ fn boot_via_sec2(
         fb_layout: &FbLayout,
         libos: &Coherent<[LibosMemoryRegionInitArgument]>,
         wpr_meta: &Coherent<GspFwWprMeta>,
+        ctx: &super::GspBootContext<'_>,
     ) -> Result {
         // Run FWSEC-FRTS to set up the WPR2 region
         let bios = Vbios::new(dev, bar)?;
         Self::run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_layout)?;
 
+        // When the WPR2 heap exceeds 256MB (e.g. when vGPU is enabled), the
+        // scrubber ucode must scrub FB memory before any other ucode images
+        // execute — without this, GSP firmware hangs during boot.
+        if fb_layout.wpr2_heap.len() > SZ_256M_U64 {
+            Self::run_scrubber(ctx)?;
+        }
+
         // Reset and boot GSP before SEC2
         gsp_falcon.reset(bar)?;
         let libos_handle = libos.dma_handle();
@@ -375,6 +427,7 @@ pub(crate) fn boot(
                 &fb_layout,
                 &self.libos,
                 &wpr_meta,
+                ctx,
             )?;
         } else {
             Self::boot_via_fsp(
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index b46ab6b921e3..30d82501faba 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -7,7 +7,7 @@
 // Alias to avoid repeating the version number with every use.
 use r570_144 as bindings;
 
-use core::ops::Range;
+use core::{fmt, ops::Range};
 
 use kernel::{
     device,
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 8d424dd23a5a..5692114c710c 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -216,6 +216,18 @@ pub(crate) fn higher_bound(self) -> u64 {
     26:26   boot_stage_3_handoff as bool;
 });
 
+// BSI secure scratch 15: scrubber handoff status.
+register!(NV_PGC6_BSI_SECURE_SCRATCH_15 @ 0x001180fc {
+    31:29   scrubber_handoff as u8;
+});
+
+impl NV_PGC6_BSI_SECURE_SCRATCH_15 {
+    /// Returns `true` if scrubber has completed.
+    pub(crate) fn scrubber_completed(self) -> bool {
+        self.scrubber_handoff() >= 0x3
+    }
+}
+
 // Privilege level mask register. It dictates whether the host CPU has privilege to access the
 // `PGC6_AON_SECURE_SCRATCH_GROUP_05` register (which it needs to read GFW_BOOT).
 register!(NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_PRIV_LEVEL_MASK @ 0x00118128,
-- 
2.51.0

