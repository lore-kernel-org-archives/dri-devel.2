Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E6A107BCCD
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68C5E10ECDD;
	Fri, 13 Mar 2026 16:55:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ARVjj9rp";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010013.outbound.protection.outlook.com
 [52.101.193.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4482D10ECE6;
 Fri, 13 Mar 2026 16:55:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2mIa3UaL0sKzLoWU/90AbhcHpMeNXfWCz6gGXhIlShDRB0X0q6Zc11yOsRpMiWQhuH2eNh/vKKAbRK3e7cyzyL4GA7aJYWIKTEzWH+f86aRbjZ50RWyX+fnP45lQWPwhFxs26B+Bf+Qronk2vzoWb9Frs6tpvUMxRO++9ZX7SUow5Dp95o9i8XQA/0xQS0wok3U8/eHwjUxUFobPHH2SUOpOQulzJc4vIPewIrJ/6ZEbhyOUuZPSt0HVgfQ/Rp4cAQZ23U5X8F6lRoA7L4aPk5eYutvzvnwjl8viLZdf0WdcJcYxLWEz5UDGBZV+GCKsixTkv05hc6yKLsyqpigJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOT/IqB2U49qriXf/LWpNchhiNXKu2qhuwRaO+UPQMI=;
 b=FTwDwDpSaiwZHZteYMIsNUBgSdk25dlY+ki6ZJ+4vhyrGr+uNP7m7cb5D+zJorskKYn1UjhBSrVU5OMBVaV2jAVzFA8y3yk9Fnn68jT5gbfWRhaWWzzYYHgMNA1eRohXU6/u2SeCyn58x/Y/CfyzLxXdqTKDpQMadisN99cm/CzLj1QdyMgddgmEmFdZ1Ix6YDlj+/FbLKJKkNUm1LpI+b7IjTxc0qmJo6v0qx9SKRT1JC7kT8VyHbfIMINA1yTLHg+jw5LCn41LwXdrgHNuGnnoOFoPrI3IYNDMys8WsrK0EgzIolQRt1x2GDJDoNW9kQ3NhwDFjnD8s3mFrzXHOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOT/IqB2U49qriXf/LWpNchhiNXKu2qhuwRaO+UPQMI=;
 b=ARVjj9rpM2U3A8LhZ7/CyqyqDetOKcdUOvtfV3/lLzYi1ne2a8IgJxe1HC5pVrtaW1qnwQ5K8+hVYXA751R+0tOHIW031v2WSJgFFJ5IDSzk5WNiFwdWrzI/mkQptNHbAhr41lVYOCiFemo9RH4PoSzKrrMKY6xHbUeCjhqfFZr03nU7GDnvxdof+oUjU+vRckfvMvJzCfyzfFmGKP05kNGo65dnl4iOTOMFGwswKtLnI2TodcDoHhdwWCjNu0TvZQI8/NgHHQSLZeeBnwT9EDrWzpgv2KrVVfx9vdKLAPs5e7qylSor4Sy2e6+nHx263vB8cxF0jskdskrRf7oP5Q==
Received: from DS7PR06CA0015.namprd06.prod.outlook.com (2603:10b6:8:2a::26) by
 DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.5; Fri, 13 Mar 2026 16:55:18 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:8:2a:cafe::b5) by DS7PR06CA0015.outlook.office365.com
 (2603:10b6:8:2a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Fri,
 13 Mar 2026 16:55:18 +0000
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
 15.20.9723.1 via Frontend Transport; Fri, 13 Mar 2026 16:55:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 09:55:01 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 09:55:01 -0700
Received: from inno-dell.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 09:54:52 -0700
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
 Wang" <zhiw@nvidia.com>, Timur Tabi <ttabi@nvidia.com>
Subject: [RFC v2 08/10] gpu: nova-core: set RMSetSriovMode when NVIDIA vGPU is
 enabled
Date: Fri, 13 Mar 2026 18:53:32 +0200
Message-ID: <20260313165336.935771-9-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313165336.935771-1-zhiw@nvidia.com>
References: <20260313165336.935771-1-zhiw@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|DS0PR12MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: 462867a3-442e-4605-2f74-08de81214e5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|7416014|1800799024|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +VoqM8T/en04dmyVRoesx/1VuvmvxwjbDpuDL5vQHF7K53ru3MnvAMxkE00Adb1VjMUrnMuhHLdvGgPzI/L9No5GsMV539RPcBmX6Cx2OgCSCw2fJHO0yQHhYa3i6dErirCftY7ahlnhKRi8jcv95G4TwF4r1nddlrEBBx32pxzs7ZmGPStfsUPWA4Q8iEcs1Yik1UQM1Mut7kA4u4PzQ2t2OBDHEXMDid4LrcM1tLb3GUsXCQNXp+5jegldiRgGbCrFhr4HkqHC7Hsp0m40/ZjjU9hDNFrVw3CPT7PDW8AUJvsoty7H+GGQQ8v6R4RlDcgyPKI2s3DN3DCaN0+reT+1BALRmZj2YMt+5S/75WrtfIUvQSsT+CnPwEmrQLgmct7QIxyh8QsTJAj6ru40yrihzpo7ipsgPd9xIca5/mLsJkA2T0RbE596n1u5q6KmwpI/zA/3op42CS61FzV4E96ksQgKaFtoJ3061bUJFxJ+bXcHHQmCvxeZVHBnQhvc07bheL8xpcKbuqowvLutPkpU8PFjtjQzPlOO9aMw9cPK65EoKp2OhCRYALx7KnDYymEFLm3pDD2fauiGMw5pnhvB5gjggzcJ7wsHbrpu7fxpsGFN42QyNtwhYSUf2+Rr3aEPgNuvGO2orqgtGp4F1epoZP0l8gALXkEMSKZzNKq4gh27zvRutm1Vnjo9b2JjIj4sU27VC17Jfgv13wWJR2p5uIPiCosYA4IJfhANlvMpkkn28B2oUPLtfY0LBPC6gGMCVgz2QkflryvK0KkwjA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nLAssFBLjCqYvpgg3z7IMVsm90YoVEWo4tK6+bqZi19eg799lgm25g2lpd9eKLCgTF/R3iJivA67JaADkTBmk6oyghSyG6pPZQ2q2i4XpfnqGFGwoqCdBwZi4s7Ov1sXFWQWR9D+cVhlO/03jIKgeZLik9n792YBQzp1ybShLm5rKSDphaydZmo6TAXOYDCnjZEmkC+2QyIdp/390iGbRdW+TQMVIoLGdfHpL/nT9TEFNm/nZkFKomL8YLIfIrULNAOJZwU+QWdRercXfWzKSVlIWie1G7NF+IhTLLIYYxs97Ln/0z1w1sHVIsqiR/1OWV0kAjD8PNXquynR0PHeEd4XhBsnGEkLE+pPSyEz36VXVKgODrhTi/5bMUpOyyLO6n5TjUkmDzCLXa/jupMoa//V9wZOLqP4U6CTVWsCyhpDPKdslWp7PqPsRCGnd0B8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 16:55:17.9976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 462867a3-442e-4605-2f74-08de81214e5a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7900
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

The registry object "RMSetSriovMode" is required to be set when vGPU is
enabled.

Set "RMSetSriovMode" to 1 when nova-core is loading the GSP firmware and
initialize the GSP registry objects, if vGPU is enabled.

Cc: Timur Tabi <ttabi@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/gpu/nova-core/gsp/boot.rs     |  4 +-
 drivers/gpu/nova-core/gsp/commands.rs | 89 +++++++++++++++++----------
 drivers/gpu/nova-core/gsp/fw.rs       | 44 +++++++++++++
 3 files changed, 104 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 921d5e892f8a..ed8729041d46 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -364,7 +364,7 @@ pub(crate) fn boot(
             self.cmdq
                 .send_command_no_wait(bar, commands::SetSystemInfo::new(pdev, chipset, vf_info))?;
             self.cmdq
-                .send_command_no_wait(bar, commands::SetRegistry::new())?;
+                .send_command_no_wait(bar, commands::SetRegistry::new(ctx.vgpu_requested)?)?;
 
             Self::boot_via_sec2(
                 dev,
@@ -406,7 +406,7 @@ pub(crate) fn boot(
             self.cmdq
                 .send_command_no_wait(bar, commands::SetSystemInfo::new(pdev, chipset, vf_info))?;
             self.cmdq
-                .send_command_no_wait(bar, commands::SetRegistry::new())?;
+                .send_command_no_wait(bar, commands::SetRegistry::new(ctx.vgpu_requested)?)?;
         }
 
         // SEC2-based architectures need to run the GSP sequencer
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 0445d05990e7..c96580d0f433 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -75,38 +75,62 @@ struct RegistryEntry {
 }
 
 /// The `SetRegistry` command.
+///
+/// Registry entries are built dynamically at runtime based on the current
+/// configuration (e.g. whether vGPU is enabled).
 pub(crate) struct SetRegistry {
-    entries: [RegistryEntry; Self::NUM_ENTRIES],
+    entries: KVec<RegistryEntry>,
 }
 
 impl SetRegistry {
-    // For now we hard-code the registry entries. Future work will allow others to
-    // be added as module parameters.
-    const NUM_ENTRIES: usize = 3;
-
-    /// Creates a new `SetRegistry` command, using a set of hardcoded entries.
-    pub(crate) fn new() -> Self {
-        Self {
-            entries: [
-                // RMSecBusResetEnable - enables PCI secondary bus reset
-                RegistryEntry {
-                    key: "RMSecBusResetEnable",
-                    value: 1,
-                },
-                // RMForcePcieConfigSave - forces GSP-RM to preserve PCI configuration registers on
-                // any PCI reset.
-                RegistryEntry {
-                    key: "RMForcePcieConfigSave",
-                    value: 1,
-                },
-                // RMDevidCheckIgnore - allows GSP-RM to boot even if the PCI dev ID is not found
-                // in the internal product name database.
+    /// Creates a new `SetRegistry` command.
+    ///
+    /// The base set of registry entries is always included. Additional entries
+    /// are appended dynamically based on runtime conditions (e.g. vGPU).
+    pub(crate) fn new(vgpu_requested: bool) -> Result<Self> {
+        let mut entries = KVec::new();
+
+        // RMSecBusResetEnable - enables PCI secondary bus reset
+        entries.push(
+            RegistryEntry {
+                key: "RMSecBusResetEnable",
+                value: 1,
+            },
+            GFP_KERNEL,
+        )?;
+
+        // RMForcePcieConfigSave - forces GSP-RM to preserve PCI configuration registers on
+        // any PCI reset.
+        entries.push(
+            RegistryEntry {
+                key: "RMForcePcieConfigSave",
+                value: 1,
+            },
+            GFP_KERNEL,
+        )?;
+
+        // RMDevidCheckIgnore - allows GSP-RM to boot even if the PCI dev ID is not found
+        // in the internal product name database.
+        entries.push(
+            RegistryEntry {
+                key: "RMDevidCheckIgnore",
+                value: 1,
+            },
+            GFP_KERNEL,
+        )?;
+
+        // RMSetSriovMode - required when vGPU is enabled.
+        if vgpu_requested {
+            entries.push(
                 RegistryEntry {
-                    key: "RMDevidCheckIgnore",
+                    key: "RMSetSriovMode",
                     value: 1,
                 },
-            ],
+                GFP_KERNEL,
+            )?;
         }
+
+        Ok(Self { entries })
     }
 }
 
@@ -117,28 +141,31 @@ impl CommandToGsp for SetRegistry {
     type InitError = Infallible;
 
     fn init(&self) -> impl Init<Self::Command, Self::InitError> {
-        PackedRegistryTable::init(Self::NUM_ENTRIES as u32, self.variable_payload_len() as u32)
+        PackedRegistryTable::init(
+            self.entries.len() as u32,
+            self.variable_payload_len() as u32,
+        )
     }
 
     fn variable_payload_len(&self) -> usize {
         let mut key_size = 0;
-        for i in 0..Self::NUM_ENTRIES {
-            key_size += self.entries[i].key.len() + 1; // +1 for NULL terminator
+        for entry in self.entries.iter() {
+            key_size += entry.key.len() + 1; // +1 for NULL terminator
         }
-        Self::NUM_ENTRIES * size_of::<PackedRegistryEntry>() + key_size
+        self.entries.len() * size_of::<PackedRegistryEntry>() + key_size
     }
 
     fn init_variable_payload(
         &self,
         dst: &mut SBufferIter<core::array::IntoIter<&mut [u8], 2>>,
     ) -> Result {
-        let string_data_start_offset =
-            size_of::<PackedRegistryTable>() + Self::NUM_ENTRIES * size_of::<PackedRegistryEntry>();
+        let string_data_start_offset = size_of::<PackedRegistryTable>()
+            + self.entries.len() * size_of::<PackedRegistryEntry>();
 
         // Array for string data.
         let mut string_data = KVec::new();
 
-        for entry in self.entries.iter().take(Self::NUM_ENTRIES) {
+        for entry in self.entries.iter() {
             dst.write_all(
                 PackedRegistryEntry::new(
                     (string_data_start_offset + string_data.len()) as u32,
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 6d56b9b920fb..ca01ac3af9c6 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -664,9 +664,50 @@ pub(crate) enum MsgFunction {
     OsErrorLog = bindings::NV_VGPU_MSG_EVENT_OS_ERROR_LOG,
     PostEvent = bindings::NV_VGPU_MSG_EVENT_POST_EVENT,
     RcTriggered = bindings::NV_VGPU_MSG_EVENT_RC_TRIGGERED,
+    GpuacctPerfmonUtilSamples = bindings::NV_VGPU_MSG_EVENT_GPUACCT_PERFMON_UTIL_SAMPLES,
     UcodeLibOsPrint = bindings::NV_VGPU_MSG_EVENT_UCODE_LIBOS_PRINT,
 }
 
+impl fmt::Display for MsgFunction {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        match self {
+            // Common function codes
+            MsgFunction::Nop => write!(f, "NOP"),
+            MsgFunction::SetGuestSystemInfo => write!(f, "SET_GUEST_SYSTEM_INFO"),
+            MsgFunction::AllocRoot => write!(f, "ALLOC_ROOT"),
+            MsgFunction::AllocDevice => write!(f, "ALLOC_DEVICE"),
+            MsgFunction::AllocMemory => write!(f, "ALLOC_MEMORY"),
+            MsgFunction::AllocCtxDma => write!(f, "ALLOC_CTX_DMA"),
+            MsgFunction::AllocChannelDma => write!(f, "ALLOC_CHANNEL_DMA"),
+            MsgFunction::MapMemory => write!(f, "MAP_MEMORY"),
+            MsgFunction::BindCtxDma => write!(f, "BIND_CTX_DMA"),
+            MsgFunction::AllocObject => write!(f, "ALLOC_OBJECT"),
+            MsgFunction::Free => write!(f, "FREE"),
+            MsgFunction::Log => write!(f, "LOG"),
+            MsgFunction::GetGspStaticInfo => write!(f, "GET_GSP_STATIC_INFO"),
+            MsgFunction::SetRegistry => write!(f, "SET_REGISTRY"),
+            MsgFunction::GspSetSystemInfo => write!(f, "GSP_SET_SYSTEM_INFO"),
+            MsgFunction::GspInitPostObjGpu => write!(f, "GSP_INIT_POST_OBJGPU"),
+            MsgFunction::GspRmControl => write!(f, "GSP_RM_CONTROL"),
+            MsgFunction::GetStaticInfo => write!(f, "GET_STATIC_INFO"),
+
+            // Event codes
+            MsgFunction::GpuacctPerfmonUtilSamples => write!(f, "GPUACCT_PERFMON_UTIL_SAMPLES"),
+            MsgFunction::GspInitDone => write!(f, "INIT_DONE"),
+            MsgFunction::GspRunCpuSequencer => write!(f, "RUN_CPU_SEQUENCER"),
+            MsgFunction::PostEvent => write!(f, "POST_EVENT"),
+            MsgFunction::RcTriggered => write!(f, "RC_TRIGGERED"),
+            MsgFunction::MmuFaultQueued => write!(f, "MMU_FAULT_QUEUED"),
+            MsgFunction::OsErrorLog => write!(f, "OS_ERROR_LOG"),
+            MsgFunction::GspPostNoCat => write!(f, "NOCAT"),
+            MsgFunction::GspLockdownNotice => write!(f, "LOCKDOWN_NOTICE"),
+            MsgFunction::ContinuationRecord => write!(f, "CONTINUATION_RECORD"),
+            MsgFunction::UcodeLibOsPrint => write!(f, "LIBOS_PRINT"),
+        }
+    }
+}
+
+
 impl TryFrom<u32> for MsgFunction {
     type Error = kernel::error::Error;
 
@@ -709,6 +750,9 @@ fn try_from(value: u32) -> Result<MsgFunction> {
             bindings::NV_VGPU_MSG_EVENT_OS_ERROR_LOG => Ok(MsgFunction::OsErrorLog),
             bindings::NV_VGPU_MSG_EVENT_POST_EVENT => Ok(MsgFunction::PostEvent),
             bindings::NV_VGPU_MSG_EVENT_RC_TRIGGERED => Ok(MsgFunction::RcTriggered),
+            bindings::NV_VGPU_MSG_EVENT_GPUACCT_PERFMON_UTIL_SAMPLES => {
+                Ok(MsgFunction::GpuacctPerfmonUtilSamples)
+            }
             bindings::NV_VGPU_MSG_EVENT_UCODE_LIBOS_PRINT => Ok(MsgFunction::UcodeLibOsPrint),
             _ => Err(EINVAL),
         }
-- 
2.51.0

