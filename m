Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E9560A2617
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WW1tkTVv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92B6610F62C;
	Tue, 24 Nov 2026 14:07:25 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010022.outbound.protection.outlook.com [52.101.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B379910F62C
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:07:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfZ3uQnyKVdndhVijsvZviV2G7JJe1JBxGN9MoSDP1B1KkC6ovb7GUBUqBAohZCYaOyhW9cIXJ7Bsx43UY3FYcdEakMofn2/B7x7gBrm/yLQJFmAh/QCVwDqmp6yI/IZ/4jh9fPAoDVGw9oTuxSssBDSyU5jEfUBD/F3+GgQJY21S4QIBeZmI0dX8M2SR8ltfPGnW4Q4hpgVon4q8ueCTNCRwfTRFa6To51SPvjrKIjKVpQ9F+lbANghaMpn3YOJpLQtyL5fq1BEzI/aG6GYvb7FZEUxAml7o8BLQ0ZtbEijQWMoUdos3+UezNvboh/S9ujG9q8gPmN50laZdVQ4wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYxhVmhvk+vtXk/D723ammLSJbCYgAhA1JSyM9TYk9U=;
 b=gSinJrKCm9XbWKxtqjVMT4XMK26D5zMW5VjGVaVrr3jsLGTXiqi1nTx7ANqW63YqegvtCr5UIRI0fZyDcH6lWkEhw/JduIc22Z4GrKEXdXhWI9zMu5lkcHdFCIxrxR63Y4Euix3TSpk+fu9QCPbT3y/X4EgAqgYkgIYUeafiwlh2hdF1wU1jJ1j3VimGpOekNz+zsvIFs4OH2LN/Z36eFwsAmZBvrTX0wJn6ilgh69rMZNyeknEYk5ZuLHv2XLVyn+FQ5TWgIwiyn3Dzbf3C6z+GFy++94f7hjcPWJOgjSyvk8NB7aovKF6Ihh9RCQ4u6NDmyRpAUJ9Worgwi/ks3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYxhVmhvk+vtXk/D723ammLSJbCYgAhA1JSyM9TYk9U=;
 b=WW1tkTVv+KdC9xkTI7cT+93B+vuMK1UGyAJD33uvz4JX22DF3SW646EjYCgJUo7OdZZJPlxYkIdq2zVSrnrkMfypwUzv45YSLGnAdNetCPAIVpuVf5BPOBd7o7jEaZn+pgRAvqoE71Ka4/E1Yutm+BYocqJj4PPx8k8jy8QWLISDKVTWm0NxbeEs7KzYvQ/PHEipFDzSuhCv7k16qo4J3HfpBovqlqqLWyN5P5O+f9N/KOHLK6W+mgzGw4e+15GZ07S8iqt5qiNYErB3I5J43JzbqgChQC0aBUJ5WEGj+o0olOd0kTlhzo1ArYqWav8c14DtufKR+TMZ6xOurfpbXA==
Received: from PH7PR02CA0005.namprd02.prod.outlook.com (2603:10b6:510:33d::22)
 by PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 14:07:15 +0000
Received: from BY1PEPF0002695A.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::6f) by PH7PR02CA0005.outlook.office365.com
 (2603:10b6:510:33d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 14:07:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0002695A.mail.protection.outlook.com (10.167.244.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:07:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:06:54 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:06:41 -0800
From: Alok Kumar <alkumar@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
 <skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <jhubbard@nvidia.com>,
 <apopple@nvidia.com>, <joelagnelf@nvidia.com>, <ecourtney@nvidia.com>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>, <xinmengs@nvidia.com>
Subject: [PATCH v5 31/35] gpu: nova-core: vgpu: update the GSP plugin BME state
Date: Tue, 24 Nov 2026 19:29:27 +0530
Message-ID: <20261124135937.18583-32-alkumar@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124135937.18583-1-alkumar@nvidia.com>
References: <20261124135937.18583-1-alkumar@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695A:EE_|PH7PR12MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd09e73-5340-4080-7026-08df4a343e29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|7416014|261026121527099003|261022075727099003|261102123227099003|261021121427099003|261021123027099003|10067099003|11063799006|56012099006|261009223027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: AUhUKeYrmPYTzQdFIH7JZqOEuDwObNBEfW1BQ/dmRJYJfZ5+UFZrJgc3PDymCf2ghQCNeCpatujCdU/xWte3tGvsZ48C4fAURIIjIfmxS5p9TsMmpED8b0yDpDVEVpvNr5muma6/zfLoM6SCm098duD9VNzU+3aNUF855s1OKdVUPBkQ+Nyj53fKDL8FgKIu/76Vj9Gzg90WDBLTCkugD91ZOEZaHP/0E8wp09y4Y2Z6+6S21BYm0+1USVd9lz1rUNJkUuRFjq4UFHUNk92M6jlF2W8LYkNt/sVXPH7TZdEpz0MyRyb2Jy87pgXgCVnxHGi2EZtAPivN5uCMW1+lFnS2utQ8xxcsz0jlWL6o92Da3mCFuGZhgFUEYsqeGpqGbOUOD7p0e6GEYU7bnNSnqqYC/wU4d2JNhQ9FWnw79WTGrRLAh7TfKOhTLS5P3xn1cBns0sFAimDDYriX1SkPE0UG2VxW+KkSfWW88kIF6HhUmcJ1hC3chbfw6LTNacx/u1J/U3KgE0+dmrPNF7GIW9yhlYYC6dKT1FssSArhsJSqtoRmmQ8M4fdlTQBubW6B3AAvvzBuCDCAsfblOzZ7Bf10+NqL5QvpKyT5VWwwvJr31JPXy1hMKCjZN4/WfiUXpKI1vnLOL8zRfVAQeK/eP3vmMkjvk/hOqn/BzEo3H7Oj27AowIK7UPEWeYJ8kZd5bEWd7rXtz6zk46qE9HhNag==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(7416014)(261026121527099003)(261022075727099003)(261102123227099003)(261021121427099003)(261021123027099003)(10067099003)(11063799006)(56012099006)(261009223027099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d+NB95qrgp4VWVBUqTloI4Cp9pYorsaQECP+rehQqgEDUKnv+GTv44nGxlsDBvEIYSB9dfGmXc2tarshLBBusY452pUnTUYGTXKQA85YOuRk9Xf1YNXe9Xuaf3edtqD8XNV6nNBTQ1MO5lDbaR8UK7beEIfHs5iyAR3CFPoxf+2/8OdH6UpWP6EqfFxRO4xCEOwX9ez+Cu+IOEVEMbpeCefM3ln+tzJKo0cIYBrqWvyVcc37Ij4WYZruGLlAYLNI69iRrwoUsxurJ31oMrktUZ1DyMQnasktkDEEEu9vDPWIObjGfUgF7MvPsgFeKRdRYNWIJ3Wao4Z3cFUsH7dvHrceV479nFfgY6pcd7Pd98/8LXz3OUrXstj8KmlAvNVUGhvPZC/umC5+Ms6/Eatfq0rKrpYw+GaNkwpPaOVpZv5t1SLPy5mmrk17AKaCLxo6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:07:15.1305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd09e73-5340-4080-7026-08df4a343e29
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0002695A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Zhi Wang <zhiw@nvidia.com>

The vGPU manager reports the enabled bus-mastering state to the GSP plugin
after its initial configuration. The guest can then use the vGPU from now
on.

Add the BME state request and NVKV encoder, and send the enabled state
after configuration succeeds.

Co-developed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/vgpu/commands.rs    | 11 +++++++++++
 drivers/gpu/nova-core/vgpu/fw/commands.rs | 18 ++++++++++++++++++
 drivers/gpu/nova-core/vgpu/instance.rs    |  4 +++-
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/vgpu/commands.rs b/drivers/gpu/nova-core/vgpu/commands.rs
index 70fd35566822..d11f9af27ee0 100644
--- a/drivers/gpu/nova-core/vgpu/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/commands.rs
@@ -40,6 +40,7 @@
     vgpu::{
         fw::{
             commands::{
+                encode_plugin_set_bme,
                 AssignedVfVgpuType,
                 VgpuProperties,
                 VgpuPropertiesSchema, //
@@ -244,3 +245,13 @@ pub(super) fn send_plugin_config(
 ) -> Result {
     rpc.rpc_call_nvkv(dev, RpcMessage::SetupConfigParamsAndInit, config)
 }
+
+/// Update the bus-mastering state reported to the GSP plugin.
+pub(super) fn set_plugin_bme(
+    dev: &device::Device,
+    rpc: &mut PluginRpc<'_, '_>,
+    enable: bool,
+) -> Result {
+    let bme = encode_plugin_set_bme(enable)?;
+    rpc.rpc_call_nvkv(dev, RpcMessage::UpdateBmeState, &bme)
+}
diff --git a/drivers/gpu/nova-core/vgpu/fw/commands.rs b/drivers/gpu/nova-core/vgpu/fw/commands.rs
index c7ff27fcf6d7..10f1427bf355 100644
--- a/drivers/gpu/nova-core/vgpu/fw/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/fw/commands.rs
@@ -37,6 +37,7 @@
 pub(crate) enum RpcMessage {
     VersionNegotiation = bindings::MESSAGE_NV_VGPU_CPU_RPC_MSG_VERSION_NEGOTIATION,
     SetupConfigParamsAndInit = bindings::MESSAGE_NV_VGPU_CPU_RPC_MSG_SETUP_CONFIG_PARAMS_AND_INIT,
+    UpdateBmeState = bindings::MESSAGE_NV_VGPU_CPU_RPC_MSG_UPDATE_BME_STATE,
 }
 
 #[derive(Clone, Copy)]
@@ -329,6 +330,23 @@ pub(crate) fn encode_plugin_config_params(
     Ok(encoder.finish())
 }
 
+nvkv_encode! {
+    struct PluginSetBmeRequest {
+        bme_enable: Key<bool, 0x0100, u32>,
+    }
+}
+
+/// Encodes a plugin BME state update using the typed NVKV schema.
+pub(crate) fn encode_plugin_set_bme(enable: bool) -> Result<KVVec<u64>> {
+    let request = PluginSetBmeRequest {
+        bme_enable: enable.into(),
+    };
+
+    let mut encoder = Encoder::new();
+    request.encode(&mut encoder)?;
+    Ok(encoder.finish())
+}
+
 // TODO: extract from bindings
 #[repr(C)]
 #[derive(FromBytes, IntoBytes)]
diff --git a/drivers/gpu/nova-core/vgpu/instance.rs b/drivers/gpu/nova-core/vgpu/instance.rs
index af1b43533a77..59d7014d7f69 100644
--- a/drivers/gpu/nova-core/vgpu/instance.rs
+++ b/drivers/gpu/nova-core/vgpu/instance.rs
@@ -35,7 +35,8 @@
         send_bootload,
         send_cleanup,
         send_plugin_config,
-        send_shutdown, //
+        send_shutdown,
+        set_plugin_bme, //
     },
     fw::commands::{
         encode_plugin_config_params,
@@ -167,6 +168,7 @@ fn activate(&mut self, vgpu: &VgpuManagerInner<'gpu>) -> Result {
         self.plugin_rpc.init_rpc()?;
         negotiate_plugin_version(dev, &mut self.plugin_rpc)?;
         self.configure_plugin(dev)?;
+        set_plugin_bme(dev, &mut self.plugin_rpc, true)?;
 
         Ok(())
     }
-- 
2.53.0

