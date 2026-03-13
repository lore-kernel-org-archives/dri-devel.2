Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D868107BCCD
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBBEC10ECCF;
	Fri, 13 Mar 2026 16:54:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ERMw6Z0a";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012062.outbound.protection.outlook.com
 [40.93.195.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F70210ECCF;
 Fri, 13 Mar 2026 16:54:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IENqiEsf7eHfMr2bbTURDnWnwZEjxGigbYFNWCUGG61GEVLG2Emm/ePSHYuPloW2H77VBDsKCBaCfERRxt1eeCSrqtt0oLo2+CxS3suL3rFzBjvqtEjdXggx66kLOWWABmn8zw6kltttmBFM1FbLj09OkZavTDXTCMpUE4eFQi7CDuDQdD/wvMqFSdAl+yyud0rLsO+TqvMo+Fe1qoKpOeCm4hk4e2EUqgNxPbybovzf83YpCd2O5w9ECep7p2ngnB3o3J3advWbcgAUz412fZ+7NQCHjEk6VL+voJ1EABfgVZ3ghAExZVHK18Fte5984CWtxYMKkyVvPLzeb3yBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYGuZBCSPheyjzoevHlLwSM5DAiBVW3XG0PR7uXV3no=;
 b=JjeQhrCvpZw4AouAE/96Ci8rdVOxHDc2QlDpNsQwl5YVl8ev2a44Mv+hn5bOTDfw1mYgV6EMNMRGKT8w5XNFFjtYJnDfdVoNILWrC3KieBYHHnTe4MgSvnG1pPkPGLoGtSU2hDfTj7AzjnY44bl7I3CKwW3dLBCRgddS7wwRiOS9CiIm/QaSXXFtiL/6yyQyXf7j3FeBkaws1i2895B1hlUZXCTRwxMPokYqbibCRSMBwmabzrlrG1V8T7rtO1eHziEK1nMfP9TMP20tqjZBBtynrFF3p3zmTyJiponB2tcEF9LZdWpeIJyBbF8Wl3TctDMeLbASuJ3z6JC7OLjHxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYGuZBCSPheyjzoevHlLwSM5DAiBVW3XG0PR7uXV3no=;
 b=ERMw6Z0a+UVUzKqiEgGfP/BXQlZ0ktvdb86XtK894/K8Wrr7CYEkRYs6dfH6RNQj0PsMmqJaEeTevZtkEWh9HpjLm3ZEdIh6EhiwxGh2vcVeA+btGVxxWHuNWiLkyExo8Zv0c7Q+U8SnpfQ20/x9oo2DF+atmDEQHx1Dgmi9qgKPl1nClOKrXbjz0Kpw4qy1jygE+qk0XPZqGpvMPW1GkxsoQ++cnjexcCIt+AVULGyiVaqtDeblSFiL1zy7egR5+GTdB+XdP7MJzXVZ4UDoQg1tTveCNmCpqXvgE4Iw6LBp0QFV4lN9byObakKCOt01fIKfYlqfQnFfYrCfS1xcyQ==
Received: from BLAPR05CA0001.namprd05.prod.outlook.com (2603:10b6:208:36e::6)
 by CY8PR12MB8195.namprd12.prod.outlook.com (2603:10b6:930:77::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 16:54:45 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::c8) by BLAPR05CA0001.outlook.office365.com
 (2603:10b6:208:36e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17 via Frontend Transport; Fri,
 13 Mar 2026 16:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 16:54:44 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 09:54:26 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 09:54:25 -0700
Received: from inno-dell.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 09:54:17 -0700
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
Subject: [RFC v2 04/10] gpu: nova-core: read vGPU mode from FSP via PRC
 protocol
Date: Fri, 13 Mar 2026 18:53:28 +0200
Message-ID: <20260313165336.935771-5-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313165336.935771-1-zhiw@nvidia.com>
References: <20260313165336.935771-1-zhiw@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|CY8PR12MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 028d2122-17bc-45df-f04a-08de81213aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|7416014|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ZuwZTB60SHd9EjbEIxktFnHfvS8/WqAd4XvbQlUOlVhkbR9HwXMuWB2+9dBHWfo1uOGvdaescfeD1VJOH7atR0W9Eggt88sa7ypbwP3mgdXyTD2rQZ/S0iZKOArC1yg/KCZAcq/sxrFkGyfO4dmdl5nUsmHmIivUje0y6INrNc55jRspz2ijGH6oINeO9SsctpLsSHqUf0McF4n5uh4wNAvdPJzvF7Fjq1oYeyNlaaZN3j/Gpyy/eB0JVYfmfTzVCKNG8MjFWQ44jVCwsJ9uCvTTKq8q8Ka8DATy7L89vtGuoaF2KcTUy3beDDDxMDDhCOXYHqdr0RJsjLkLAVG18uzqdYSdukpRoc2ojrDvpLcyTar2DoJlm/QfeIz6Z/LVHYitzftaKDlLQUUYtmSut397hG5j6JlfIbOIqCa6YDUoxwofNLv2AXgpMmFXtp3bVgGxBxc3UBOWoO+eAXZU+a2LnyVouop3H7JokIv7gUYenM0ig3cj/35jZD/8PIVYVK3TaefdxeqFPJXP2x7TxbtAXGLROoWg09DnoETDXj8w7e3Tu7mMaQDILtHxiSbtFQZ0XwIXgX+VDLGH90NAaxNFWTlRmSGFONOdRJwLvvKkMl1xtYz58fWfo02gO/EM537Z1dR0nXj4vB6ZWes6XUtjQrvK+PDlgHAbZVMmDXJA+u3WjhgmXyj4OAHKzPT9OwOJG5SbmQZ5QYlUXR/DdvozGFDp0EQUZNxAoEOAsTMAd2J5v5IPocHjGLbq9hc1f2VmBodk3R7nUdHBibiX/Q==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(7416014)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: THsrPl5pJ4V28/sC9EOA/HYd+pXg3+pRU6rbl7HHelSwxv2fNXihkORRTpzTV4r7hyhk/j8F7eR4IKeYLAnJgjeIDfpjyfGE5jeAeddt42qv1i1/GH8CtaA1+MLccUVfrHEp44kXSTiotvZyRL675hAvuZ4KDqxqioDxAK88adGxR7EvOmNPIjRhSZ9lCnOlNPj3H5pEWEUCPcJ5AzOHLLgQDgZ1s+B+pTpgTaJ5EVvO8SzaGqFuYRSCms9XZe+WK2knJ8DNxRgJf3CJTHCfvnkLOXHjJ81Pw264XYQ2+uCj1kNgXCC+pDMQHOFhRCGqtQS0eznW2CI90INFuhL9IByOKUXdN5fSRATsqnBtIJQvCiT5K/RUGqM+nTqB9BeDbt2J8HHB9ILieCVJ/TynZd7YA8NPWx3roo5SzNe49YZbBdd0bgKwRoxmJRMJrjVC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 16:54:44.9381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 028d2122-17bc-45df-f04a-08de81213aa7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8195
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

Add support for querying the vGPU mode configuration from FSP using
the PRC (Product Reconfiguration Control) protocol. PRC is an API
system exposed through FSP's Management Partition that allows querying
device configuration "knobs" without firmware updates.

Add a VgpuMode enum that validates the raw PRC response value,
returning an error for unexpected values.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/gpu/nova-core/fsp.rs  | 175 +++++++++++++++++++++++++++++++---
 drivers/gpu/nova-core/mctp.rs |   2 +
 2 files changed, 165 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index 69e48b655879..e342bbf733b3 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -23,12 +23,18 @@
     },
 };
 
-use crate::regs;
-
-use crate::mctp::{
-    MctpHeader,
-    NvdmHeader,
-    NvdmType, //
+use crate::{
+    driver::Bar0,
+    falcon::{
+        fsp::Fsp as FspEngine,
+        Falcon, //
+    },
+    mctp::{
+        MctpHeader,
+        NvdmHeader,
+        NvdmType, //
+    },
+    regs,
 };
 
 /// FSP Chain of Trust protocol version.
@@ -55,6 +61,23 @@ pub(crate) const fn raw(self) -> u16 {
 /// FSP secure boot completion timeout in milliseconds.
 const FSP_SECURE_BOOT_TIMEOUT_MS: i64 = 4000;
 
+/// PRC (Product Reconfiguration Control) protocol constants.
+///
+/// PRC is an API system exposed through FSP's Management Partition that allows
+/// querying and modifying device configuration "knobs" without firmware updates.
+/// Each knob is identified by a unique object ID and controls a specific device
+/// behavior (e.g., vGPU mode, ECC, confidential computing).
+mod prc {
+    /// Sub-command to read a PRC knob value.
+    pub(super) const SUBCMD_READ: u8 = 0x0c;
+
+    /// PRC object ID for vGPU mode configuration (knob ID 41).
+    pub(super) const OBJECT_VGPU_MODE: u8 = 0x29;
+
+    /// Request the active knob value (currently effective this boot).
+    pub(super) const FLAG_ACTIVE: u8 = 1 << 1;
+}
+
 /// GSP FMC initialization parameters.
 #[repr(C)]
 #[derive(Debug, Clone, Copy, Default)]
@@ -171,7 +194,61 @@ struct NvdmPayloadCommandResponse {
     error_code: u32,
 }
 
-/// NVDM (NVIDIA Device Management) COT (Chain of Trust) payload structure.
+// SAFETY: NvdmPayloadCommandResponse is a packed C struct with only integral fields.
+unsafe impl FromBytes for NvdmPayloadCommandResponse {}
+
+/// vGPU operating mode as reported by FSP via the PRC protocol.
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+pub(crate) enum VgpuMode {
+    /// vGPU support is disabled on this GPU.
+    Disabled = 0,
+    /// vGPU support is enabled on this GPU.
+    Enabled = 1,
+}
+
+impl TryFrom<u16> for VgpuMode {
+    type Error = kernel::error::Error;
+
+    fn try_from(value: u16) -> Result<Self> {
+        match value {
+            0 => Ok(VgpuMode::Disabled),
+            1 => Ok(VgpuMode::Enabled),
+            _ => Err(EINVAL),
+        }
+    }
+}
+
+/// PRC message payload.
+///
+/// Sent to FSP to query or modify a device configuration knob.
+/// The response includes the common FSP response header followed by
+/// a [`NvdmPayloadPrcResponse`] with the knob's current state value.
+#[repr(C, packed)]
+#[derive(Clone, Copy)]
+struct NvdmPayloadPrc {
+    sub_message_id: u8,
+    flags: u8,
+    object_id: u8,
+    reserved: u8,
+}
+
+// SAFETY: NvdmPayloadPrc is a packed C struct with only integral fields.
+unsafe impl AsBytes for NvdmPayloadPrc {}
+
+/// PRC response payload containing the knob state value.
+#[repr(C, packed)]
+#[derive(Clone, Copy)]
+struct NvdmPayloadPrcResponse {
+    value_low: u8,
+    value_high: u8,
+    reserved1: u8,
+    reserved2: u8,
+}
+
+// SAFETY: NvdmPayloadPrcResponse is a packed C struct with only integral fields.
+unsafe impl FromBytes for NvdmPayloadPrcResponse {}
+
+/// NVDM (NVIDIA Vendor Defined Message) COT (Chain of Trust) payload structure.
 /// This is the main message payload sent to FSP for Chain of Trust.
 #[repr(C, packed)]
 #[derive(Clone, Copy)]
@@ -224,6 +301,17 @@ struct FspCotMessage {
 // SAFETY: FspCotMessage is a packed C struct with only integral fields.
 unsafe impl AsBytes for FspCotMessage {}
 
+/// Complete FSP PRC message.
+#[repr(C, packed)]
+#[derive(Clone, Copy)]
+struct FspPrcMessage {
+    header: FspMessageHeader,
+    prc: NvdmPayloadPrc,
+}
+
+// SAFETY: FspPrcMessage is a packed C struct with only integral fields.
+unsafe impl AsBytes for FspPrcMessage {}
+
 /// Complete FSP response structure with MCTP and NVDM headers.
 #[repr(C, packed)]
 #[derive(Clone, Copy)]
@@ -235,6 +323,18 @@ struct FspResponse {
 // SAFETY: FspResponse is a packed C struct with only integral fields.
 unsafe impl FromBytes for FspResponse {}
 
+/// Complete FSP PRC response including the knob state payload.
+#[repr(C, packed)]
+#[derive(Clone, Copy)]
+struct FspPrcResponse {
+    header: FspMessageHeader,
+    response: NvdmPayloadCommandResponse,
+    prc_data: NvdmPayloadPrcResponse,
+}
+
+// SAFETY: FspPrcResponse is a packed C struct with only integral fields.
+unsafe impl FromBytes for FspPrcResponse {}
+
 /// Trait implemented by types representing a message to send to FSP.
 ///
 /// This provides [`Fsp::send_sync_fsp`] with the information it needs to send
@@ -305,17 +405,68 @@ pub(crate) fn boot_params_dma_handle(&self) -> u64 {
     }
 }
 
+impl MessageToFsp for FspPrcMessage {
+    const NVDM_TYPE: u32 = NvdmType::Prc as u32;
+}
+
 /// FSP interface for Hopper/Blackwell GPUs.
 pub(crate) struct Fsp;
 
 impl Fsp {
+    /// Read vGPU mode from FSP using the PRC protocol.
+    ///
+    /// Queries FSP's Management Partition for the active vGPU mode knob value.
+    /// Returns [`VgpuMode::Enabled`] if vGPU support is active on this GPU,
+    /// [`VgpuMode::Disabled`] otherwise.
+    pub(crate) fn read_vgpu_mode(
+        dev: &device::Device<device::Bound>,
+        bar: &Bar0,
+        fsp_falcon: &Falcon<FspEngine>,
+    ) -> Result<VgpuMode> {
+        let msg = KBox::new(
+            FspPrcMessage {
+                header: FspMessageHeader::new(NvdmType::Prc),
+                prc: NvdmPayloadPrc {
+                    sub_message_id: prc::SUBCMD_READ,
+                    flags: prc::FLAG_ACTIVE,
+                    object_id: prc::OBJECT_VGPU_MODE,
+                    reserved: 0,
+                },
+            },
+            GFP_KERNEL,
+        )?;
+
+        let response_buf = Self::send_sync_fsp(dev, bar, fsp_falcon, &*msg)?;
+
+        let prc_resp_size = core::mem::size_of::<FspPrcResponse>();
+        if response_buf.len() < prc_resp_size {
+            dev_err!(
+                dev,
+                "PRC response too small: {} bytes (expected {})\n",
+                response_buf.len(),
+                prc_resp_size
+            );
+            return Err(EIO);
+        }
+
+        let prc_response =
+            FspPrcResponse::from_bytes(&response_buf[..prc_resp_size]).ok_or(EIO)?;
+
+        let raw_value = u16::from(prc_response.prc_data.value_low)
+            | (u16::from(prc_response.prc_data.value_high) << 8);
+
+        VgpuMode::try_from(raw_value).inspect_err(|_| {
+            dev_err!(dev, "unexpected vGPU mode value: {:#x}\n", raw_value);
+        })
+    }
+
     /// Wait for FSP secure boot completion.
     ///
     /// Polls the thermal scratch register until FSP signals boot completion
     /// or timeout occurs.
     pub(crate) fn wait_secure_boot(
         dev: &device::Device<device::Bound>,
-        bar: &crate::driver::Bar0,
+        bar: &Bar0,
         arch: crate::gpu::Architecture,
     ) -> Result {
         debug_assert!(
@@ -403,8 +554,8 @@ pub(crate) fn extract_fmc_signatures(
     /// to FSP, and waits for the response.
     pub(crate) fn boot_fmc(
         dev: &device::Device<device::Bound>,
-        bar: &crate::driver::Bar0,
-        fsp_falcon: &crate::falcon::Falcon<crate::falcon::fsp::Fsp>,
+        bar: &Bar0,
+        fsp_falcon: &Falcon<FspEngine>,
         args: &FmcBootArgs<'_>,
     ) -> Result {
         dev_dbg!(dev, "Starting FSP boot sequence for {}\n", args.chipset);
@@ -457,8 +608,8 @@ pub(crate) fn boot_fmc(
     /// Returns the raw response buffer for protocol-specific parsing.
     fn send_sync_fsp<M>(
         dev: &device::Device<device::Bound>,
-        bar: &crate::driver::Bar0,
-        fsp_falcon: &crate::falcon::Falcon<crate::falcon::fsp::Fsp>,
+        bar: &Bar0,
+        fsp_falcon: &Falcon<FspEngine>,
         msg: &M,
     ) -> Result<KVec<u8>>
     where
diff --git a/drivers/gpu/nova-core/mctp.rs b/drivers/gpu/nova-core/mctp.rs
index c4e36a46fd69..5c53e156d482 100644
--- a/drivers/gpu/nova-core/mctp.rs
+++ b/drivers/gpu/nova-core/mctp.rs
@@ -10,6 +10,8 @@
 #[derive(Debug, Clone, Copy, PartialEq, Eq)]
 #[repr(u32)]
 pub(crate) enum NvdmType {
+    /// PRC (Product Reconfiguration Control) message.
+    Prc = 0x13,
     /// Chain of Trust boot message.
     Cot = 0x14,
     /// FSP command response.
-- 
2.51.0

