Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9CC107BCCD
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01DEF10ECD8;
	Fri, 13 Mar 2026 16:55:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="K5QzNQeL";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010047.outbound.protection.outlook.com
 [40.93.198.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2069B10ECCB;
 Fri, 13 Mar 2026 16:55:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbfU6r0DHD6qt2KlN+U9cqP1QZsXpEDqVZxRgVC+w1eBzWnl9/qu+WzD2DVBx2bsYTUZvtt51N+NrJqz/j4Z9P5EDuYwKc8HMFOUf0W8NfXW/Q/cwWt79LJvC3OWuipEHQdZkCEp+ZPsOcF8zFFyy5GyVBZ8zU88m+53ISu9wa9YR4DQzarfE0TZfUFP/wzUVKUxFvYjOmlB2rEQX3kGa1Nl8kEfGGrAcVeooGXHL3kuWrdTYnTW+HzpiiW0U6R/L2AmOCLsGaOo4gZHoOTGIOni6hcISavdEcRt/Xjvow93JtzibYg8TfepbN5LxoZE4biX8ukNBj2UuT9iThp3fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSCjkibyvSidEFplonC2xfchRYGecOWy8jRM7Z/AgwE=;
 b=E4NhWWR0skH1d+db7pWA/LvqtrsyS78KfUgRf90IBtXUmVyHpLT9mf7BQE2Ih98DcxnvLkSVwkrtl2il2BXsEam0TIWxzZtVp9z3GmRQh9ouZ4spNbt8bCFv4/Ll7Hm6X9Us2gNH+Vbsx9iWJXZ/jlNORN2gBcMvJmfIbTDoM0+SQmLb5ppzieF39UwS3dzlmZfX+IXD19ghlIX2iXYSmQNT1PwcnyN6bP1Erl5prIAXpd9OTLaB2s07Xv1/2upm/CdJLeL2cwgH1hdnJVUpw5KGpOdJEvbaCBY75gPBQXDqjcc3tG1ImjCa0Dtf04c488oZ7UdYNLux+YQyXzAhAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSCjkibyvSidEFplonC2xfchRYGecOWy8jRM7Z/AgwE=;
 b=K5QzNQeLkLUQLdp+/AtAjYl9hRrveo0OmBp06M/MjBNyrJUbLI8143ItlQ72ZRaS8gIc7zboRj0aykWtxF3DIeXCrm0LbbgTlL228QlpTH+uApKfEWFneky2mSq1KPP1YjhhpSiwYDIAiASvWQ+xpRWnpFYpoa383BDJvKfzCTQX9zkB/tgWAsTadk6CUwVVA78NwMsyt5dlneUfw0YdYwHuOvcuj2QS3YkjlJVd5m/xEGPaUPyuqRNHek5GSwkFSjLXyf8vhxpC/txlDm39hgN8cPMdSfv8SkTA/khbliitH1XW8+NGUBoHDHTq9wuuh4J2Mo4cJ5hIiFSWMJeszQ==
Received: from BL1PR13CA0289.namprd13.prod.outlook.com (2603:10b6:208:2bc::24)
 by CH2PR12MB4118.namprd12.prod.outlook.com (2603:10b6:610:a4::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Fri, 13 Mar
 2026 16:55:01 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::f6) by BL1PR13CA0289.outlook.office365.com
 (2603:10b6:208:2bc::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.15 via Frontend Transport; Fri,
 13 Mar 2026 16:54:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 16:55:01 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 09:54:44 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 09:54:44 -0700
Received: from inno-dell.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 09:54:35 -0700
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
Subject: [RFC v2 06/10] gpu: nova-core: introduce vgpu_support module param
Date: Fri, 13 Mar 2026 18:53:30 +0200
Message-ID: <20260313165336.935771-7-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313165336.935771-1-zhiw@nvidia.com>
References: <20260313165336.935771-1-zhiw@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|CH2PR12MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 92775313-6cc8-4883-30ca-08de81214463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: b+KiFx5qkrIM7bnoPOrnpW6AkHmoHCD4RoL1evA2h+VTliJ2g0/doHTH0EC0u6rS7sZlJAfNcP6T4RdHz8+j7pagSec6eYFM+9mmuna/xlpOALoywrR8kVOMR8lVJNLliiWt1uoPvhxJdyutRixyXZbhbZ50QJ3OTNyyoZCMOEhHz0danjULRoa3+fC6FhcXM37A8p1VcDC+Yl7XsSB+FLXFgA5CScSaUJu4gNR6O7uwSSmmHupajbY7XN9QhnHcLd8b8yyrOcyHWVzQve5IMQKVdT/LblcCAUCNePoZQNWsG86UC86LAnxXOVa7k1KSFlqg0TXNGnK0z1fNKMxIlEiN+1JIBDfVon5hsKFPl5eGwWEU3VuBPgufR2TDnTgQn/EqvwAcy2xxm3O75wjSmxUdXXwM5eUmOYTzP3PJnxAhlgte+BdqgtBXS+F+Wy3vSBwIfvEIG8jwK4ns+nBamP7msHsN5QYb7bt5xIpdp2ppv8vwPZ41w5Id2e5HADLj6sDGBkBkxFTdK4N6qGWZ+q+T/747RRg9sd1gbcfuxhG4k9fglFYpHOIyQFcBDJ1+EvtwAZEJdHkuzfbG4IHnwocmb32ueFIBrJjwDnd7ZWXarjcEKL6+ew5etYAlCQ4Ymu45wniHl9Z8Rd7ZspaSeuephOjH/w0ea1O/VHXdPTAkWLOzHdbj/qVMdbHi+dhKYKP9ZZemsyEcXPJ2OMV7t+RnMMfDqdjxIu9nMFkysbD1sedKFl3dR8+lxhRfXu/NTW0ViDCCuRmBetMS+hyW0g==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C1SoDb+6OsqeuIOvRpv89273nBGiFgFs9JU5zBAJx3iYvOJBEl3grrD+uK3Ss+yBxDK06rMynJNrfFRs4q75fhmWo6RrHY2KdpnBFwAQB4aWUz3WncVDsO0Hyop4jaNDH8m18FKJ8/jVbxpBZ/ocaz8jZFnQYN4JpZmIt5MQ5WKmg511Ph/WPlNSg/eiHUFhoyuPcnrxsl4FkIoF5pSAvU8b5NDUZKcFDjUiyzmHnAKNw/qK9/6uJP950ezul9Dy8y/Vp0pW81WLv39QaoLwHIXp3VpGnYR7OB8yBD7Ld1j8LqIGJXQQEWEmQ0gvo45JxG1xf0q5F7HFH+d7U6LZx17uqjQGZJ8ldu7ihbqiMmwbUK7gGd03dbFy7jtMEI6dB/vlLi6D3ExHZPYHISK3oEW6LfF0RxkqXRAC6xbtQKfFpoTUgbgBqNQe6HZC69/B
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 16:55:01.2517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92775313-6cc8-4883-30ca-08de81214463
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118
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

Introduce a kernel module param to set vGPU support in nova-core.

vgpu_support = 1 (default): automatic

The driver automatically enables or disables vGPU support based on if the
GPU advertises SRIOV caps.

vgpu_support = 0: disabled

Explicitly disables vGPU support. The driver will not enable vGPU support
regardless.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs       | 37 +++++++++++++++++--
 drivers/gpu/nova-core/gsp.rs       | 25 +++++++++++++
 drivers/gpu/nova-core/gsp/boot.rs  | 59 +++++++++++++++++-------------
 drivers/gpu/nova-core/nova_core.rs | 15 ++++++++
 drivers/gpu/nova-core/vgpu.rs      | 37 +++++++++++++++++++
 5 files changed, 143 insertions(+), 30 deletions(-)
 create mode 100644 drivers/gpu/nova-core/vgpu.rs

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index e9d07750fafe..e1c16e1b9ec4 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -23,8 +23,12 @@
     fb::SysmemFlush,
     fsp::FspCotVersion,
     gfw,
-    gsp::Gsp,
+    gsp::{
+        Gsp,
+        GspBootContext, //
+    },
     regs,
+    vgpu::Vgpu, //
 };
 
 macro_rules! define_chipset {
@@ -180,6 +184,16 @@ pub(crate) enum Architecture {
 }
 
 impl Architecture {
+    /// Whether this architecture uses SEC2 for GSP boot (vs FSP Chain of Trust).
+    pub(crate) const fn uses_sec2_boot(&self) -> bool {
+        matches!(self, Self::Turing | Self::Ampere | Self::Ada)
+    }
+
+    /// Whether this architecture supports vGPU.
+    pub(crate) const fn supports_vgpu(&self) -> bool {
+        matches!(self, Self::Ada | Self::Blackwell)
+    }
+
     /// Returns the DMA mask supported by this architecture.
     ///
     /// Hopper and Blackwell support 52-bit DMA addresses, while earlier architectures
@@ -313,7 +327,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 pub(crate) struct Gpu {
     spec: Spec,
     /// MMIO mapping of PCI BAR 0
-    bar: Arc<Devres<Bar0>>,
+    pub bar: Arc<Devres<Bar0>>,
     /// System memory page required for flushing all pending GPU-side memory writes done through
     /// PCIE into system memory, via sysmembar (A GPU-initiated HW memory-barrier operation).
     sysmem_flush: SysmemFlush,
@@ -323,7 +337,8 @@ pub(crate) struct Gpu {
     sec2_falcon: Falcon<Sec2Falcon>,
     /// GSP runtime data. Temporarily an empty placeholder.
     #[pin]
-    gsp: Gsp,
+    pub(crate) gsp: Gsp,
+    vgpu: Vgpu,
 }
 
 impl Gpu {
@@ -351,6 +366,8 @@ pub(crate) fn new<'a>(
                     }
                 },
 
+                vgpu: Vgpu::new(pdev, chipset)?,
+
                 sysmem_flush: SysmemFlush::register(pdev.as_ref(), bar, chipset)?,
 
                 gsp_falcon: Falcon::new(
@@ -363,7 +380,19 @@ pub(crate) fn new<'a>(
 
                 gsp <- Gsp::new(pdev),
 
-                _: { gsp.boot(pdev, bar, chipset, gsp_falcon, sec2_falcon)? },
+                _: {
+                    let mut ctx = GspBootContext {
+                        pdev,
+                        bar,
+                        chipset,
+                        gsp_falcon,
+                        sec2_falcon,
+                        fsp_falcon: None,
+                        vgpu_requested: vgpu.vgpu_requested,
+                    };
+                    gsp.boot(&mut ctx)?;
+                    vgpu.vgpu_enabled = ctx.vgpu_requested;
+                },
 
                 bar: devres_bar,
                 spec,
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 1756ab4732e7..9435c7430dfe 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -31,6 +31,14 @@
 };
 
 use crate::{
+    driver::Bar0,
+    falcon::{
+        fsp::Fsp as FspFalcon,
+        gsp::Gsp as GspFalcon,
+        sec2::Sec2 as Sec2Falcon,
+        Falcon, //
+    },
+    gpu::Chipset,
     gsp::cmdq::Cmdq,
     gsp::fw::{
         GspArgumentsPadded,
@@ -45,6 +53,23 @@
 /// Number of GSP pages to use in a RM log buffer.
 const RM_LOG_BUFFER_NUM_PAGES: usize = 0x10;
 
+/// Common context for the GSP boot process.
+pub(crate) struct GspBootContext<'a> {
+    pub(crate) pdev: &'a pci::Device<device::Bound>,
+    pub(crate) bar: &'a Bar0,
+    pub(crate) chipset: Chipset,
+    pub(crate) gsp_falcon: &'a Falcon<GspFalcon>,
+    pub(crate) sec2_falcon: &'a Falcon<Sec2Falcon>,
+    pub(crate) fsp_falcon: Option<Falcon<FspFalcon>>,
+    pub(crate) vgpu_requested: bool,
+}
+
+impl GspBootContext<'_> {
+    pub(crate) fn dev(&self) -> &device::Device<device::Bound> {
+        self.pdev.as_ref()
+    }
+}
+
 /// Array of page table entries, as understood by the GSP bootloader.
 #[repr(C)]
 struct PteArray<const NUM_ENTRIES: usize>([u64; NUM_ENTRIES]);
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index b2037ecb9a7f..4238df5c8104 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -5,7 +5,6 @@
     dma::Coherent,
     io::poll::read_poll_timeout,
     io_write,
-    pci,
     prelude::*,
     time::Delta, //
 };
@@ -36,12 +35,10 @@
     },
     fsp::{
         FmcBootArgs,
-        Fsp, //
-    },
-    gpu::{
-        Architecture,
-        Chipset, //
+        Fsp,
+        VgpuMode, //
     },
+    gpu::Chipset,
     gsp::{
         commands,
         fw::LibosMemoryRegionInitArgument,
@@ -98,7 +95,7 @@ fn lockdown_released(&self, bar: &Bar0, fmc_boot_params_addr: u64) -> bool {
             return true;
         }
 
-        let hwcfg2 = regs::NV_PFALCON_FALCON_HWCFG2::read(bar, &crate::falcon::gsp::Gsp::ID);
+        let hwcfg2 = regs::NV_PFALCON_FALCON_HWCFG2::read(bar, &Gsp::ID);
         !hwcfg2.riscv_br_priv_lockdown()
     }
 }
@@ -255,9 +252,8 @@ fn boot_via_fsp(
         gsp_falcon: &Falcon<Gsp>,
         wpr_meta: &Coherent<GspFwWprMeta>,
         libos: &Coherent<[LibosMemoryRegionInitArgument]>,
+        fsp_falcon: &Falcon<FspEngine>,
     ) -> Result {
-        let fsp_falcon = Falcon::<FspEngine>::new(dev, chipset)?;
-
         Fsp::wait_secure_boot(dev, bar, chipset.arch())?;
 
         let fsp_fw = FspFirmware::new(dev, chipset, FIRMWARE_VERSION)?;
@@ -275,7 +271,7 @@ fn boot_via_fsp(
             &signatures,
         )?;
 
-        Fsp::boot_fmc(dev, bar, &fsp_falcon, &args)?;
+        Fsp::boot_fmc(dev, bar, fsp_falcon, &args)?;
 
         let fmc_boot_params_addr = args.boot_params_dma_handle();
         Self::wait_for_gsp_lockdown_release(dev, bar, gsp_falcon, fmc_boot_params_addr)?;
@@ -320,18 +316,31 @@ fn wait_for_gsp_lockdown_release(
     /// Upon return, the GSP is up and running, and its runtime object given as return value.
     pub(crate) fn boot(
         self: Pin<&mut Self>,
-        pdev: &pci::Device<device::Bound>,
-        bar: &Bar0,
-        chipset: Chipset,
-        gsp_falcon: &Falcon<Gsp>,
-        sec2_falcon: &Falcon<Sec2>,
+        ctx: &mut super::GspBootContext<'_>,
     ) -> Result {
-        let dev = pdev.as_ref();
-        let uses_sec2 = matches!(
-            chipset.arch(),
-            Architecture::Turing | Architecture::Ampere | Architecture::Ada
-        );
+        let bar = ctx.bar;
+        let chipset = ctx.chipset;
+        let arch = chipset.arch();
+        let pdev = ctx.pdev;
+        let gsp_falcon = ctx.gsp_falcon;
+        let sec2_falcon = ctx.sec2_falcon;
+
+        // For FSP-based architectures (Blackwell), refine the vGPU request
+        // by reading the PRC knob from FSP - only keep the request if the
+        // hardware knob is set.
+        //
+        // SEC2-based architectures (Ada) keep the initial request as-is
+        // (module parameter + SR-IOV, already filtered by Vgpu::new).
+        if !arch.uses_sec2_boot() {
+            let fsp_falcon = Falcon::<FspEngine>::new(ctx.dev(), chipset)?;
+            Fsp::wait_secure_boot(ctx.dev(), bar, arch)?;
+            let vgpu_mode = Fsp::read_vgpu_mode(ctx.dev(), bar, &fsp_falcon)?;
+            dev_dbg!(ctx.dev(), "vGPU mode: {:?}\n", vgpu_mode);
+            ctx.fsp_falcon = Some(fsp_falcon);
+            ctx.vgpu_requested &= vgpu_mode == VgpuMode::Enabled;
+        }
 
+        let dev = ctx.dev();
         let gsp_fw = KBox::pin_init(GspFirmware::new(dev, chipset, FIRMWARE_VERSION), GFP_KERNEL)?;
 
         let fb_layout = FbLayout::new(chipset, bar, &gsp_fw)?;
@@ -341,7 +350,7 @@ pub(crate) fn boot(
         io_write!(wpr_meta, , GspFwWprMeta::new(&gsp_fw, &fb_layout));
 
         // Architecture-specific boot path
-        if uses_sec2 {
+        if arch.uses_sec2_boot() {
             // SEC2 path: send commands before GSP reset/boot (original order).
             self.cmdq
                 .send_command_no_wait(bar, commands::SetSystemInfo::new(pdev, chipset))?;
@@ -366,6 +375,7 @@ pub(crate) fn boot(
                 gsp_falcon,
                 &wpr_meta,
                 &self.libos,
+                ctx.fsp_falcon.as_ref().ok_or(ENODEV)?,
             )?;
         }
 
@@ -383,10 +393,7 @@ pub(crate) fn boot(
         dev_dbg!(dev, "RISC-V active? {}\n", gsp_falcon.is_riscv_active(bar));
 
         // For FSP path, send commands after GSP becomes active.
-        if matches!(
-            chipset.arch(),
-            Architecture::Hopper | Architecture::Blackwell
-        ) {
+        if !arch.uses_sec2_boot() {
             self.cmdq
                 .send_command_no_wait(bar, commands::SetSystemInfo::new(pdev, chipset))?;
             self.cmdq
@@ -394,7 +401,7 @@ pub(crate) fn boot(
         }
 
         // SEC2-based architectures need to run the GSP sequencer
-        if uses_sec2 {
+        if arch.uses_sec2_boot() {
             let libos_handle = self.libos.dma_handle();
             let seq_params = GspSequencerParams {
                 bootloader_app_version: gsp_fw.bootloader.app_version,
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index c554ec544ddd..bccdbb412dd0 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -27,6 +27,7 @@
 mod regs;
 mod sbuffer;
 mod vbios;
+mod vgpu;
 
 pub(crate) const MODULE_NAME: &core::ffi::CStr = <LocalModule as kernel::ModuleMetadata>::NAME;
 
@@ -75,6 +76,20 @@ fn init(module: &'static kernel::ThisModule) -> impl PinInit<Self, Error> {
     description: "Nova Core GPU driver",
     license: "GPL v2",
     firmware: [],
+    params: {
+        // vgpu_support = 1 (default): automatic
+        //
+        // The driver automatically enables or disables vGPU support based on if the GPU
+        // advertises SRIOV caps.
+        //
+        // vgpu_support = 0: disabled
+        //
+        // Explicitly disables vGPU support. The driver will not enable vGPU support regardless.
+        vgpu_support: u32 {
+            default: 1,
+            description: "Enable vGPU support - (1 = auto (default), 0 = disable)",
+        },
+    },
 }
 
 kernel::module_firmware!(firmware::ModInfoBuilder);
diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
new file mode 100644
index 000000000000..d35081a088cf
--- /dev/null
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use kernel::{
+    device,
+    pci,
+    prelude::*, //
+};
+
+use crate::{
+    gpu::Chipset,
+    module_parameters, //
+};
+
+pub(crate) struct Vgpu {
+    pub(crate) vgpu_requested: bool,
+    pub(crate) vgpu_enabled: bool,
+    pub total_vfs: u16,
+}
+
+impl Vgpu {
+    pub(crate) fn new(pdev: &pci::Device<device::Bound>, chipset: Chipset) -> Result<Vgpu> {
+        let total_vfs = if chipset.arch().supports_vgpu() {
+            match *module_parameters::vgpu_support.value() {
+                0 => 0,
+                _ => pdev.sriov_get_totalvfs().unwrap_or(0),
+            }
+        } else {
+            0
+        };
+
+        Ok(Vgpu {
+            vgpu_requested: total_vfs > 0,
+            vgpu_enabled: false,
+            total_vfs,
+        })
+    }
+}
-- 
2.51.0

