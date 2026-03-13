Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3BF107BCCD
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C4E810ECC7;
	Fri, 13 Mar 2026 16:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="PSd0g21q";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60EFB10ECC7;
 Fri, 13 Mar 2026 16:55:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJMomudU3j5A1Gr0kO7AllhWIe8az3XD9sG0elNr4Gyb01n1qJ7fUhgf2cltF/M2O9XWrhs03E2UG/RJR2CAYnb/jukxE+0+Xyp91dX7DM1kOs0beMHzxtuP6FCAnMfQf1JhbcQpIhCmHAMkN3LBB0WWlbSRf+K2ecLmpPgRvZHCbAGlCyj71zwkN6vXIuPsXXExqY2X4Jz8K5+eaAgWiJOFHvw0sXvRuB6uq8xztDhVt7+z0j+Cdkv6drF42zNe4D5X1i7lSjVmmfNWUVSRRjQNCQFinHceRhv28lSpsNvAt38ANEFTcrZYKelzifveTzcgu6F6lQwH1hfC/IVN8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMG0EDEliTyxdnO0ig+6b8VpmEngkzSMiBV93AzDTBA=;
 b=SB+kRpisMiHZ/TmVSqo177rtPbKQZqwMRAQwdZgXrIRY6XTsZDwndBhqm3sy0xaFutArilUZgz1BcX27LbwKO9Ib4SHtZdaSMt8wIpl+Ye8NjrXb5pW8XFQworQq28/avfXIaC2YEUKWXFrshY/4vBQYL3ucfT1cl0+1yy45x/NhnlIX64NwSr5J0CKefTQifbxVtE4X9auIocXwsbHrJ59V18MOpa/A+n8bAW/U/MZ+cB6C6HWFSwrmC1OBvTthdSTpMnY7njyeROxwTxv5g3qu0sLwBerpGrpBs8DgHIfudTB2Ode7+3ipiu4erJwDFF+mXj/mEDi+GnH69tML8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMG0EDEliTyxdnO0ig+6b8VpmEngkzSMiBV93AzDTBA=;
 b=PSd0g21ql2N1FJYKBMQ+udt3Jm1dSUNBQyZLRAn+e/vmBHkZgxNVVSimpL0/FAdnPdKxUaqtLFgudL1mw8ywyvXcAw/1zOuSmmSnuMyUh9tFxIURReclHO4IxAGWk9tbu/KsMZZWJ33ICka9PL1LLBF3WqfIWNqNceoINsloAACMuXh4sE8Utq8nc/Qkw7/v+XIvSAQc89K1QANsAsr9FDQlGMmzK0W9Wri2xd4vk+nq9zlyOGVP8rKyYYwPwFuPdB3NGxD/XAyH9dVtYY6DGbukPLV5PUAUOCJIzdcyDdmWG7ZIWUWUTjLcVZUwedNjfRUVaCDHZuNvu4uNFhmSvw==
Received: from DS7PR06CA0017.namprd06.prod.outlook.com (2603:10b6:8:2a::24) by
 DS7PR12MB9551.namprd12.prod.outlook.com (2603:10b6:8:24f::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.6; Fri, 13 Mar 2026 16:54:56 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:8:2a:cafe::28) by DS7PR06CA0017.outlook.office365.com
 (2603:10b6:8:2a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17 via Frontend Transport; Fri,
 13 Mar 2026 16:54:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.1 via Frontend Transport; Fri, 13 Mar 2026 16:54:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 09:54:35 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 09:54:34 -0700
Received: from inno-dell.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 09:54:26 -0700
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
Subject: [RFC v2 05/10] gpu: nova-core: add FSP and PRC protocol documentation
Date: Fri, 13 Mar 2026 18:53:29 +0200
Message-ID: <20260313165336.935771-6-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313165336.935771-1-zhiw@nvidia.com>
References: <20260313165336.935771-1-zhiw@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|DS7PR12MB9551:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8210e2-0226-43a4-05c6-08de812141ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|1800799024|36860700016|56012099003|18002099003|22082099003|7142099003;
X-Microsoft-Antispam-Message-Info: 7D4BHcNhn1GpnFgfvW7U+U8UIbUtmLJuqvcXU/K16gH9wdES1rAErcxylGgBE5l8gzWHfCz9iYJQ6q3QcmfrfoAyMJkiGcGLG+1aTDIbghOz/vW30Yh2ufhFJbhkdcns0TStd0NclVYyzppcelCA+yioTxUk3LNSbyvZyOBqqWwq6ByyJdVPMGSvK2E6AGbYYryLo7P+uQftq2bw2JQYBVo0CMtrlMv4wYiuxxy8f4Wm3/ohRYzx+GWmXu11iaj9XwBsIar9BUiWI3dJqIm2/waiWv836mgTiel4H0ozbkD6x+H17JaELKTOFIlyEYEZvldxpi8fYm9PzSE+cRfbGB9GySp1CZMM1SZygmEqBxXTpk/wW7+jHJdy85ROelR6JY8iDyp78UfREeFc2vJ+jzx2EpgIw3lDoDEBveFvZ55lTXe6M/vGFJJVKlYlVzcQaQZN0Suzcgm6T4DG4QUcwVdy7E+iFnnEnTKoYkl/VRQmuecp+ljmzYjna2v1Tew2UsItlmS+xdAjFVGuN13rFuJsrScHPgyncB570XEY1p9ikDNlgO/RoTy5loS/CB3d26q79dIY57TfTzAxyfYjuJlvhIr7LloImEwJoCjhUNWI/M+Lvxt6gjAzYs5qFAv4VKXgIEitx88PCYAUGh0iSb2PlXbx7me/3TXO/CDTSooXbQ07mZZqm/7AP8ZQMnYkckKKaF2jY0ffeuN0of2I0J0hp00RlOWGFzVUgPocKcIw+ZTvy5akIgxedfN5Xr13DhAJhKYLbOgO1Ohxe5NHRg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016)(56012099003)(18002099003)(22082099003)(7142099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jYGLDmgEdRPEAigZUWqlc3gT9GJrR7CzthXpqEj4aiCy69kPFPQ5WROq8FoGAJeafHAIgoQtZFJlBbcQgPGs2xpNbiftqhppXsAbax04b/6i8bCIc8jJJa4yFqT1F/JJS55/xN3TzTeP5I5Y/6PVmFb5jUckg/TNAK43pMNy4XwuB9ybD4VQJaeEKtqPMgITjgP/l2qyxo81+hcl69UEyvlcNgMfQCEmOtxQuSUZXYPLVXNqa/i2iS6sfC+Hg8tKn59/37+nc0op229miW96kbovaAZMMggshRlDIIUIqmLYsd+SUofcoZGwjSfbearwCAfWpw7AI6Hs1JVezvHzkmT3WksYgA2FsrJ9yMC9xRfxzlRp1Wokr2qL+3NX44K0dpeKSUUDwznohEaF3fmA3Hu4SeqgN89628EmhfgryX53jgULfw0jtgyw3VxuLpp3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 16:54:56.7183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8210e2-0226-43a4-05c6-08de812141ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9551
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

Add documentation for the Falcon Security Processor (FSP) interface
covering the simplified Hopper/Blackwell boot flow, the Chain of Trust
(COT) message protocol, the MCTP/NVDM message format, and the Product
Reconfiguration Control (PRC) protocol used to query device configuration
knobs such as vGPU mode.

Suggested-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 Documentation/gpu/nova/core/fsp.rst | 135 ++++++++++++++++++++++++++++
 Documentation/gpu/nova/index.rst    |   1 +
 2 files changed, 136 insertions(+)
 create mode 100644 Documentation/gpu/nova/core/fsp.rst

diff --git a/Documentation/gpu/nova/core/fsp.rst b/Documentation/gpu/nova/core/fsp.rst
new file mode 100644
index 000000000000..dedad680b20e
--- /dev/null
+++ b/Documentation/gpu/nova/core/fsp.rst
@@ -0,0 +1,135 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============================================
+FSP (Falcon Security Processor) and Secure Boot
+===============================================
+This document describes the role of the FSP in the GPU boot sequence on
+Hopper and Blackwell GPUs, It also provides a brief overview of the PRC
+(Product Reconfiguration Control) protocol used to query device
+configuration through FSP.
+
+What is FSP?
+============
+The Falcon Security Processor (FSP) is the GPU's Internal Root of Trust
+(IROT). It is a dedicated security processor that boots from immutable ROM
+(Boot ROM) inside the GPU and is responsible for establishing the Chain of
+Trust before any other firmware is allowed to run.
+
+FSP runs independently of the host CPU and starts executing as soon as the
+GPU is powered on. By the time the nova-core driver is loaded, FSP has
+already completed its own secure boot and is ready to accept commands from
+the driver.
+
+Simplified boot flow (Hopper/Blackwell)
+=======================================
+Starting with Hopper, the boot flow is significantly simplified compared to
+earlier GPU generations like Ampere.
+
+On an Ampere GPU, the boot verification chain involves multiple Falcon
+engines and multiple ucode stages (see falcon.rst for details)::
+
+     Hardware BROM (SEC2)
+          -> HS Booter (SEC2)
+               -> LS GSP-RM (GSP)
+
+The driver must extract ucode from VBIOS, manage SEC2 and GSP, and
+orchestrate the Booter to load GSP-RM. This involves FWSEC-FRTS, devinit,
+and the Booter stages.
+
+On Hopper/Blackwell GPUs, FSP replaces this multi-stage process with a
+single message-driven interface::
+
+     FSP (hardware root of trust, boots from ROM)
+          -> FMC (Falcon Microcontroller, verified by FSP)
+               -> GSP-RM (verified and loaded by FMC)
+
+The driver only needs to:
+
+1. Wait for FSP to complete its own secure boot (polling a scratch register).
+2. Send a Chain of Trust (COT) message to FSP with the FMC firmware location,
+   cryptographic signatures, and GSP boot parameters.
+3. FSP authenticates the FMC firmware and boots it, FMC in turn loads GSP-RM.
+
+There is no SEC2 involvement, no Booter ucode, and no FWSEC-FRTS stage. The
+entire secure boot is driven by a single FSP message exchange.
+
+Chain of Trust (COT) protocol
+=============================
+The Chain of Trust establishes a cryptographically enforced boot sequence,
+ensuring the GPU reaches a known, trusted state.
+
+The driver communicates with FSP using a message queue (Falcon MSGQ
+interface). Each message consists of an MCTP (Management Component Transport
+Protocol) transport header and an NVDM (NVIDIA Vendor Defined Message) header,
+followed by a protocol-specific payload.
+
+For Chain of Trust, the payload includes:
+
+- The system memory address of the FMC firmware image.
+- Cryptographic material: a SHA-384 hash, RSA-3K public key, and RSA-3K
+  signature extracted from the FMC ELF firmware.
+- FRTS (Firmware Runtime Services) region information (vidmem offset and size).
+- The system memory address of the GSP boot arguments structure.
+
+FSP verifies the signature against the provided public key and hash, and if
+verification succeeds, boots the FMC. The FMC then authenticates and launches
+GSP-RM.
+
+The message flow is::
+
+     nova-core                          FSP
+        |                                |
+        |  1. Poll scratch register      |
+        |  (wait for FSP boot complete)  |
+        |                                |
+        |  2. COT message  ------------> |
+        |     (FMC addr, signatures,     |
+        |      boot params)              |
+        |                                |
+        |                                |--- Verify FMC signature
+        |                                |--- Boot FMC
+        |                                |--- FMC loads GSP-RM
+        |                                |
+        |  3. COT response <------------ |
+        |     (success/error)            |
+        |                                |
+
+FSP message format
+==================
+All FSP messages share a common header format consisting of two 32-bit words:
+
+MCTP header (Management Component Transport Protocol):
+
+- Bit 31: SOM (Start of Message)
+- Bit 30: EOM (End of Message)
+- Bits 29:28: Packet sequence number
+- Bits 23:16: Source Endpoint ID
+
+NVDM header (NVIDIA Vendor Defined Message):
+
+- Bits 6:0: MCTP message type (0x7e = vendor-defined PCI)
+- Bits 23:8: PCI vendor ID (0x10de = NVIDIA)
+- Bits 31:24: NVDM type (0x14 = COT, 0x13 = PRC, 0x15 = FSP response)
+
+PRC (Product Reconfiguration Control) protocol
+===============================================
+PRC is an API system exposed through FSP's Management Partition that allows
+querying and modifying device configuration without firmware updates.
+
+Configuration parameters are called "knobs". Each knob has a unique object
+ID and controls a specific device behavior. Examples include vGPU mode, ECC
+enable, confidential computing mode, and NVLINK configuration.
+
+The nova-core driver uses PRC to read the vGPU mode knob (object ID 0x29)
+during early boot, before firmware loading, to determine whether the GPU
+should operate in vGPU mode.
+
+The PRC message format follows the same MCTP/NVDM header structure as COT,
+with NVDM type 0x13. The payload contains:
+
+- A sub-command (e.g., 0x0c for read).
+- Flags indicating which value to read (bit 0 = persistent, bit 1 = active).
+- The knob object ID.
+
+The response includes the common FSP response header (with error status)
+followed by the knob's 16-bit state value.
diff --git a/Documentation/gpu/nova/index.rst b/Documentation/gpu/nova/index.rst
index e39cb3163581..1783513cbd05 100644
--- a/Documentation/gpu/nova/index.rst
+++ b/Documentation/gpu/nova/index.rst
@@ -30,5 +30,6 @@ vGPU manager VFIO driver and the nova-drm driver.
    core/todo
    core/vbios
    core/devinit
+   core/fsp
    core/fwsec
    core/falcon
-- 
2.51.0

