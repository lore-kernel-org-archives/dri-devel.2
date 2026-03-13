Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DF2107BCCD
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 972CE10ECE5;
	Fri, 13 Mar 2026 16:55:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="sY+fUPV1";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010013.outbound.protection.outlook.com [52.101.46.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AD6610ECE8;
 Fri, 13 Mar 2026 16:55:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTXiJLJxcd6ABAbUBhOIZ31i6Tl5UPqQYuPpEkWmMsVmQnpUMsZ/OYqugsaH/gibMWZ3hp1i9XABsLpn3hF7owH2Ik0NsiBZ0edBWKt+HE17j11npPVREG5JVDFfOJuQmsNGfsAH06/zT+5MJUEcXZGOANF3Dekvi4AO2MIUhVQa7IHRguXysqScsBFKBxXiAKkSpYgALA3bBFDicxWpGF/xbvgiEyxVVVO6Se+/7UnMf99DryM0SyQlm/MJUUHaM/5dOFR5STpxKdUT1PjeIxnVvrcQEqIonnGE+Ah9gZo9MEU4TX5RiBH+uvRNImHqElTb+g927Nm3z7Fl3sL0jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anNYyBoHdGTkUApfbTAwOvgbGUmxZno/X9GoijWzJys=;
 b=n1gWzT2TG0wcFQW7loJ1njWVko2EssAgETlrk0b2/3eS4voEPkr+f8Y+4mRSVb87RX+pGX2sjVpCMEmhyEYaru2HpzlgnNRHAyXdu6iSGiu4i8xhiPn/6JMp2FtcBU4bWNTvjxztmiDiqdgwWalntIV8tdciqLw4ufYQhreLAPl+RnEjJYIYXpfMhhFNr7tdaDLunXPgcHH+7N5qDLWfhjGWlcXbT3URS0v8jz7aHKZ46LeaXAFdJs3gsNpSiKtxhADSoFIdQRlevpyp0ok7N5ye9xnsNyOepMtgITwsVEPf2LkB4CSK5gqjODYNYngvYb5E/DmSAAJl+IJ37CzaXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anNYyBoHdGTkUApfbTAwOvgbGUmxZno/X9GoijWzJys=;
 b=sY+fUPV1iBjBwUJsWRVsS4545lOPb9AOlZ4TBAA4Mh6SoLCwlA+c0kD+lhzzU7pQSRS108wGmdH9Eannxiyx7CZ9v0vJja4S8+3y12puZ8IciEbN/gU72aX4V+lQ8gU86Q21getelOumK4JFTytY4+/ogM6wV096P36DU4gx+ajc7dkUztZTSpqoFw2Zw7DiF1/eZZwxCdRJmtRPjDoDfAz9hoFcZzQIg2tBA6PGzCrVIsf40elU5t2Con0pfS53Po3pmCw2w4+FcVPl2FLYmsNmE9FNTty6ZmoTxYp99zFvYIathwwOo1ruUikf2mXhfp4SbY9oHt0iUorGlhLPZQ==
Received: from CH2PR15CA0017.namprd15.prod.outlook.com (2603:10b6:610:51::27)
 by DS0PR12MB7509.namprd12.prod.outlook.com (2603:10b6:8:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 16:55:13 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:51:cafe::33) by CH2PR15CA0017.outlook.office365.com
 (2603:10b6:610:51::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.29 via Frontend
 Transport; Fri, 13 Mar 2026 16:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.1 via Frontend Transport; Fri, 13 Mar 2026 16:55:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 09:54:52 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 09:54:52 -0700
Received: from inno-dell.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 09:54:44 -0700
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
Subject: [RFC v2 07/10] gpu: nova-core: populate GSP_VF_INFO when vGPU is
 enabled
Date: Fri, 13 Mar 2026 18:53:31 +0200
Message-ID: <20260313165336.935771-8-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313165336.935771-1-zhiw@nvidia.com>
References: <20260313165336.935771-1-zhiw@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|DS0PR12MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 960908f6-bf3f-454b-dfbc-08de81214b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: LplhOsrknlEoYEYKRSivi+YOda4+vAd+mvy3Y2NDvKwUPDEyox11stquzFUsF+C/JR1Cu90/nwB/07Gz4AcXBI1cY82fOGUL0mZz47Kt06pHGc7wOqP8rhnMEyIOVxNNQqC7+24iIMucqoYCECHgHKELT/tNQ5cLIIFQIOR+PTE2PjNaH2XlEpMeOuomYrc/rEHZ/HX3xCWg8T0M+C+BGBvF5O8C54vzZ+kvSDm2wg3AAO+h7+yTWHKSiENWApfr6JLNu7TviOgVncoKaEDp9KCLWne5vGy0yhyZ4MRJDpxwXj8NFgsxmOWlGXmoa2Oeyzgi8h3LTU12jvKhNE+JPJ0KhzqZlzPPFPL1jyYd+WstCI1UWrt6wOUM+hdYpuAeGgHCOYlcoASKXVJMVTdMGIA827oXxE3LVFi9T9Lu/j34ZDePzqaCly+MPXlav0ByQlMisA0ZRwP2/tgEcjUKx/qmZ/vgOvvZSdm7LIXsKQ+0jCKfZxyo6ITVDypTAAyCtVfp0gXb8YlcjIUIJe2tdsm2MRRug5N+ZNu/j55JfzS4kC6iivkdLRTxp378hPRub1SGwkeq3qrp+/TFdrcb++cKltw65t9Jlwfwo/JlcinfHOELfU8ZLCY6MB6gEdJsetyCY6F4l7WVbdGbPYbvKPvcsM6yeRUsYcEYnZxdAdBrmNIUgE1hCzTs3IXF1r9BA4mjmZ3lj7/wZq7CtMS3vDwBoyQmDHxkXXpoQ1FszRH2CpSVPJeafojUDHX264ndDO06gdtxsJHHobFBvnig1w==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qhwZ9JNKn9RLH9MQ6YZ6BsViwkqA2TFEnkE38dUnT3CfF1rwbobL+uikf7Qu++fR5/euMPDYlWylyKw2piTd36yBKxpOvs02VbUk3h8hPdGJ7RLjflmvIOZT7DnJPWn2/dS01QKdEYqF5k5NLobZjuxwPZR/2DKrzRu6ptiffPbzB/guN4UuHBxTUYGVTAIAI5S/fv/9VXzq09yElxWvmJm7iGbIL91t+7P8aQgqU1RIWPH7wGxzoi7NjRpLOnek4sCaZLPgM4WFjPfeaKU8cdJZoyKOmx0ETtf+eWplLhYuxZWd3fOG4z382Tbfx8nCwHDTf4DLsxGI+gPT0fgmbXqgVPlwz8wb+hnquYb+xU7dbQNW6yxtmJWNwRi3N2bsT7uLyLHwH/VNnz5xSzFo5d5sRMwwAIKJdWFEhiQxJUS78dM64zfZIEMhwhYc+VpC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 16:55:12.6552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 960908f6-bf3f-454b-dfbc-08de81214b28
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7509
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

GSP firmware needs to know the VF BAR offsets to correctly calculate the
VF events.

The VF BAR information is stored in GSP_VF_INFO, which needs to be
initialized and uploaded together with the GSP_SYSTEM_INFO.

Populate GSP_VF_INFO when nova-core uploads the GSP_SYSTEM_INFO if NVIDIA
vGPU is enabled.

Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/gpu/nova-core/gsp/boot.rs        | 15 ++++++++--
 drivers/gpu/nova-core/gsp/commands.rs    | 16 ++++++++--
 drivers/gpu/nova-core/gsp/fw.rs          | 38 ++++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw/commands.rs | 12 +++++++-
 4 files changed, 74 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 4238df5c8104..921d5e892f8a 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -41,7 +41,10 @@
     gpu::Chipset,
     gsp::{
         commands,
-        fw::LibosMemoryRegionInitArgument,
+        fw::{
+            GspVfInfo,
+            LibosMemoryRegionInitArgument, //
+        },
         sequencer::{
             GspSequencer,
             GspSequencerParams, //
@@ -349,11 +352,17 @@ pub(crate) fn boot(
         let wpr_meta = Coherent::<GspFwWprMeta>::zeroed(dev, GFP_KERNEL)?;
         io_write!(wpr_meta, , GspFwWprMeta::new(&gsp_fw, &fb_layout));
 
+        let vf_info = if ctx.vgpu_requested {
+            Some(GspVfInfo::new(ctx.pdev)?)
+        } else {
+            None
+        };
+
         // Architecture-specific boot path
         if arch.uses_sec2_boot() {
             // SEC2 path: send commands before GSP reset/boot (original order).
             self.cmdq
-                .send_command_no_wait(bar, commands::SetSystemInfo::new(pdev, chipset))?;
+                .send_command_no_wait(bar, commands::SetSystemInfo::new(pdev, chipset, vf_info))?;
             self.cmdq
                 .send_command_no_wait(bar, commands::SetRegistry::new())?;
 
@@ -395,7 +404,7 @@ pub(crate) fn boot(
         // For FSP path, send commands after GSP becomes active.
         if !arch.uses_sec2_boot() {
             self.cmdq
-                .send_command_no_wait(bar, commands::SetSystemInfo::new(pdev, chipset))?;
+                .send_command_no_wait(bar, commands::SetSystemInfo::new(pdev, chipset, vf_info))?;
             self.cmdq
                 .send_command_no_wait(bar, commands::SetRegistry::new())?;
         }
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index d31ee782ff8b..0445d05990e7 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -29,6 +29,7 @@
         },
         fw::{
             commands::*,
+            GspVfInfo,
             MsgFunction, //
         },
     },
@@ -39,12 +40,21 @@
 pub(crate) struct SetSystemInfo<'a> {
     pdev: &'a pci::Device<device::Bound>,
     chipset: Chipset,
+    vf_info: Option<GspVfInfo>,
 }
 
 impl<'a> SetSystemInfo<'a> {
     /// Creates a new `GspSetSystemInfo` command using the parameters of `pdev`.
-    pub(crate) fn new(pdev: &'a pci::Device<device::Bound>, chipset: Chipset) -> Self {
-        Self { pdev, chipset }
+    pub(crate) fn new(
+        pdev: &'a pci::Device<device::Bound>,
+        chipset: Chipset,
+        vf_info: Option<GspVfInfo>,
+    ) -> Self {
+        Self {
+            pdev,
+            chipset,
+            vf_info,
+        }
     }
 }
 
@@ -55,7 +65,7 @@ impl<'a> CommandToGsp for SetSystemInfo<'a> {
     type InitError = Error;
 
     fn init(&self) -> impl Init<Self::Command, Self::InitError> {
-        GspSetSystemInfo::init(self.pdev, self.chipset)
+        GspSetSystemInfo::init(self.pdev, self.chipset, self.vf_info)
     }
 }
 
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index e5f8db74a677..6d56b9b920fb 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -10,7 +10,9 @@
 use core::ops::Range;
 
 use kernel::{
+    device,
     dma::Coherent,
+    pci,
     prelude::*,
     ptr::{
         Alignable,
@@ -1309,3 +1311,39 @@ fn new(cmdq: &Cmdq) -> Self {
         })
     }
 }
+
+/// VF information — `gspVFInfo` in `GspSetSystemInfo`.
+///
+/// Populated from the PCI SR-IOV extended capability when vGPU support
+/// is enabled.
+#[derive(Clone, Copy, Zeroable)]
+#[repr(transparent)]
+pub(crate) struct GspVfInfo(pub(crate) bindings::GSP_VF_INFO);
+
+impl GspVfInfo {
+    /// Reads SR-IOV capability data from the PCI extended configuration
+    /// space and builds the VF information required by GSP firmware.
+    pub(crate) fn new(pdev: &pci::Device<device::Bound>) -> Result<GspVfInfo> {
+        let total_vfs = pdev.sriov_get_totalvfs()?;
+
+        let cfg = pdev.config_space_extended()?;
+        let sriov = pci::ExtSriovCapability::find(&cfg)?;
+
+        Ok(GspVfInfo(bindings::GSP_VF_INFO {
+            totalVFs: u32::from(total_vfs),
+            firstVFOffset: u32::from(kernel::io_read!(sriov, .vf_offset)),
+            FirstVFBar0Address: u64::from(kernel::io_read!(sriov, .vf_bar[0]?)),
+            b64bitBar1: u8::from(sriov.vf_bar_is_64bit(1)?),
+            FirstVFBar1Address: sriov.read_vf_bar64_addr(1)?,
+            b64bitBar2: u8::from(sriov.vf_bar_is_64bit(3)?),
+            FirstVFBar2Address: sriov.read_vf_bar64_addr(3)?,
+            ..Zeroable::zeroed()
+        }))
+    }
+}
+
+// SAFETY: Padding is explicit and does not contain uninitialized data.
+unsafe impl AsBytes for GspVfInfo {}
+
+// SAFETY: This struct only contains integer types for which all bit patterns are valid.
+unsafe impl FromBytes for GspVfInfo {}
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index c9822fcbc499..3edd451e531b 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -15,7 +15,10 @@
         Architecture,
         Chipset, //
     },
-    gsp::GSP_PAGE_SIZE, //
+    gsp::{
+        fw::GspVfInfo,
+        GSP_PAGE_SIZE, //
+    },
 };
 
 use super::bindings;
@@ -33,6 +36,7 @@ impl GspSetSystemInfo {
     pub(crate) fn init<'a>(
         dev: &'a pci::Device<device::Bound>,
         chipset: Chipset,
+        vf_info: Option<GspVfInfo>,
     ) -> impl Init<Self, Error> + 'a {
         type InnerGspSystemInfo = bindings::GspSystemInfo;
         let init_inner = try_init!(InnerGspSystemInfo {
@@ -57,6 +61,12 @@ pub(crate) fn init<'a>(
             bIsPrimary: 0,
             bPreserveVideoMemoryAllocations: 0,
             ..Zeroable::init_zeroed()
+        })
+        .chain(move |si| {
+            if let Some(vf) = vf_info {
+                si.gspVFInfo = vf.0;
+            }
+            Ok(())
         });
 
         try_init!(GspSetSystemInfo {
-- 
2.51.0

