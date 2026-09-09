Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678F4C79FB5
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C31210EEEF;
	Wed,  9 Sep 2026 06:46:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="KKRH7kzm";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65CA810EEEF
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 06:46:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4pRjNMqGQTPm61G+0uYnFHDnK1tyAPlRLW8ZqpF4FgiIjsocCe9V9Y/SHXB5EJ+H6nrVl2G1xxADM29on2VEn+LJvScfeytyUqTw4MG51e3/YHw+GkuMfNxGzoF5aBGctwv1JmbVw6sPAXIyLiV/Quq9F4y/Sr97PdETThsoQCRQ2u7PP2a1lbh6ORfO4oQiINIJMr5+Phdk6BYzvI3imFPSfYPkI/NZCxl3T7XODroII5PpBLKWPALhiAfugHl7uSluIFKjza7dH49+jzXMpIl45FqKDQU0MnR5kK3vbzTkDoHuX9qSK85GxoZRD6gUXlBhysCIg0K9sZqB9nLUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kxo/en7VUEldr3mI7k370GfU200/lTyjP4LqTtSTYAM=;
 b=GQ6tP70eljRNLy5Afq+rrSxr9Hl9ksoipH0kg6W8zDK5pYr1xZQ5b8inZc8wa8Sxtaqnlhn65UFRLt0kSmml60q7fuZOECxDUtX0UdaaS/8wzGVJhJrsanW2fPE8KenluCfUHU4Qn01y4muhg4d9jNV3rCkw8DF6a2yLyjmuOFQRRn6efdsRYplW9yHu9giFfNu0LuZ/Mj8MDUb25sfUp2cgJmqe9DS+0tP7be2EdhyMCLMAEihLnpeHeGvh1HLWkuI4khu25NJcxgymptZmOKpNrF0XVEyiHfzruCG/MzUhQpfY9X06vi3mXIJOUTDhSmrnW+/avYy5mvytqxTMUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kxo/en7VUEldr3mI7k370GfU200/lTyjP4LqTtSTYAM=;
 b=KKRH7kzmkvImm67W+EWTvngDtEjbtUT22g2p0xkpHo90IRaDmsJi0b8TLb6R1oHGaeHebF716D7V9C+/bs87nBvtEuSAxdmhKdF8Ygftj2W3Z8uSs51DRUjKnda6ot6omaA4S7R6Nhh/S8iyIgU6uzPYcDTDUxW1lnQMny5R75FIkNcvnTE1aMxKswrcqK19trAz8rNpDXCWsqnZKS/wLq77nxFWThyUudJnFq0N1GQ1IQy6kBERQfPEDn/d9rTgLOtE4da4px91BCqOvPp2D+Q+dUN79nRI7zmpNOp2S0s20FsezlwUgkMDIXf0RxvbxJZBRPuWmLMKX7brZI/tAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 06:45:58 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 06:45:58 +0000
From: Alistair Popple <apopple@nvidia.com>
To: rust-for-linux@vger.kernel.org,
	nova-gpu <nova-gpu@lists.linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>,
 M Henning <mhenning@darkrefraction.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v6 08/13] drm: nova: Add usable VRAM size to GPU info
Date: Wed,  9 Sep 2026 16:45:01 +1000
Message-ID: <20260909064506.910162-9-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260909064506.910162-1-apopple@nvidia.com>
References: <20260909064506.910162-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0162.ausprd01.prod.outlook.com
 (2603:10c6:10:1ba::20) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|IA0PR12MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 44af8012-9b5b-4957-23da-08df0e3e017f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|1800799024|56012099006|10067099003|11063799006|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BNjes4gTVl6E5qwCZsfNCIMJjsqH88VIPYrv3z+fEyvfOG92OhDpSIgMF8rjszMPdsqjMqmRzzMbVKyFSpSNDVa6oAk4JuUIKy/5LlwI01z3R3b6lXGV0ftLu8ytXnDdhafuJpSBaIkp+NcnnaI6G8BkHAhsWsZRCX3/+pcGq397fQtH+k9QJ77tgsLzAZaspc6YopRVpaNPwTl9ZpBPXXSHFpaMG4lYWOCHZGaEylZfCwIwDrWa8JLWRxXhyg32M4jxFH8Z29KxMyMHMemDpGYkAdflBmN+IRKocJXnwkQUhSlcwf6Mc1FT/3IeKv5XZmkYj1NtT6aAecr6W9WZJBvFqhJeYCb1g6wD6j+y/L6P32+0rfvyXquTti0cAf3CKhRhTrq1UrUpGrERq9COxBAVdKSQ6XIdNu3AzMM6nqZDFquGYtB928Mq4SEpO4ZiJtd6tU+NCAWNzR97yOMFcBkaa3439QYuR/vK0G9c+N4e5iyfZaRhKAlVRHa1mVGnnjXrJDuBWraa9fRinaaMnJqy/TeM1sBQIok3o61r+ZorORQDZPSyf3lIS3hBHfO0V0k2Vd9ouLvb7Vkz9RdHo7nH5cQuc4JBN7SJV8W7pikSInN7noIdEcl8LBCg5x3cgWGTr22WqHIvC6JrBWWIv53Kom32rYUXTMn6K4/JZ5o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(6133799003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uMCjLtXucCH/UM3gbdzEKcTl0x/Mj6LR251DqPg8w8KtvqxxZi31/E0xLSX/?=
 =?us-ascii?Q?5jW1uIhWTsJbkAKRVVIPYxBfwbwFKM5TBHQkeVkHKV8DmHx/tibxmFcbXSNv?=
 =?us-ascii?Q?q8+INyK1Qpc3VmG7k8q8rzQv/KNfsOOk2mH2aXW3HcXXNFVWr9Vdubusfi2W?=
 =?us-ascii?Q?DBY/fBWdVeizRYOXkFQN3Gt6gGEgPb4juzZxJXMlm6SPyFmYvKfwBP9lniSm?=
 =?us-ascii?Q?gaLH4yw/IozEOsHIDz6MRereCjNPUzzd6zH0/hROe6zJIY+jHnudcC0OVuwM?=
 =?us-ascii?Q?kmqGSKSvo4nEhVXvFmRbHpPpDSAjZhrhhdKs0hM8BBGuH+a5M/ZZnpd/UtsZ?=
 =?us-ascii?Q?tuMcUTU4RHiqTYu/alVGXXxi/u2O/5OOw3vnDbgeyoIIs05TW0laQHEhvZ5B?=
 =?us-ascii?Q?Yq5wRP8JMICj83YaUo2zbvP4xusNfmTHTjo5agSNwtOyDdAr10z/hyaOmpuw?=
 =?us-ascii?Q?1EcUE0VfLCL6k+S4AT12/dVXa9Qhlvf9bv4U2vo48cfQPoaRsv22un9aMrBp?=
 =?us-ascii?Q?w7DrwD2+QWpwQ4rSNYmUgSDrduJnupRDVfN5e5CvdT2sLI/Ms48HAErH7jAE?=
 =?us-ascii?Q?0/rsSGJAR4DzTpdQb3ll3KJzsYTCl7DwHlndJqlB94gn0zaVUArcqSCh7T6K?=
 =?us-ascii?Q?dn0Jagphmg13pw+wVbq8BeQBCat95nl/0hJUcWgcLBD8sbZvLqsP4vqP2uJ6?=
 =?us-ascii?Q?rw5JqBWgaBTUqtspsq2wsnwY72JrBX86HMw6wyl7FW+cAznTvfOaTYnR+X1Q?=
 =?us-ascii?Q?ZNgtfeDYqjFWciRoExWEHhNUUipabHnQVzE3hvV0esKo1lizJUaTpVMzA4Hq?=
 =?us-ascii?Q?EL3wThuWnlMjKTLBHQVTa3TfllKAkRnFSpkhLk0TAQngQlP8BIGcf+HQc2fd?=
 =?us-ascii?Q?I1yMraNAG40XyC0CXquHraZ05WZ7a4hK7TfTFcGcjz3NMUYqpwyGDkmGHnjN?=
 =?us-ascii?Q?9cj+YWsK/4w51cOr2grbnAuC+ID20Z16fA7a38MLVkyjQfkRPlZT144C7cg+?=
 =?us-ascii?Q?YzNN+xYrXArm5TKVlgzvjLHfy61Mqqd+4zj938qJsAXadJVa+gbs6rHmL7qa?=
 =?us-ascii?Q?r6gps/h4UMk67xfKDv3Wue91JS6RlrsYEqIaL9BG6Qtd6fPO+1j4pglFKuOb?=
 =?us-ascii?Q?Oh3IC5fB+5ir+/KMiqPFMC6HsNkw7AcHMV1hUQYv3MnPxrenB/OFtqhGVlRr?=
 =?us-ascii?Q?Y6R1pVIxgH1fXiIeS2YXyNchF1D3FhgLf3u0KAfIRYKAVS8+glm+sUVWUTp8?=
 =?us-ascii?Q?plYfHUR9k95L3vNy7od+dgUK3Ur8FxOrrOmJusq52peADDlq8J4XoByYSmTw?=
 =?us-ascii?Q?YnQfgtYuEevEcy/rTt7VTTSMsuja8uc1fNraSAnVcQ148wYWPQOYIR6RBcTJ?=
 =?us-ascii?Q?jULD9cJ94NG7JM8nuXQY0fUD/RmUaV4g/0Q9tPQNi24rFcB/XpvgMW3mHDBA?=
 =?us-ascii?Q?GTl6GezQifv4kO9Qfjf+qrJVEPl5giBrMtuX19RRFlYBb8oPfZhbhM82Lm+3?=
 =?us-ascii?Q?7Hquggp4nQXsxq4+oDHj7LTLAuJe/iV+Oznm3Trf6LbKEtmCF0O0uOEVrVZz?=
 =?us-ascii?Q?qLq8ulAqH2ZT4cXvpOY1BCws8Z3vv9mnyjZUAR35MJYzvN9IMpj4S2xo2z49?=
 =?us-ascii?Q?2Qaneq0dA+bCY7uSJCzj7qkflhu80eTimNLS7jFUfrYMhBHsO/lted+4W/bC?=
 =?us-ascii?Q?T33p3H4y8zzdXenPOHQfgom0QaF0L8c4CcZfzd4dCsJPX2xjqwvq0zeRSQ5Z?=
 =?us-ascii?Q?qnRTM/o/8A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44af8012-9b5b-4957-23da-08df0e3e017f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 06:45:58.7400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfRsGV397DI/+0cm8yRz7yBaaZYYmXQSEX0Ta8VPTc1Tte2JbVvlc+rqcIY8Js07duU/JBD8ofr0hIDt/H7vmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7697
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

Add a field to the GPU info structure containing the total usable
framebuffer size. The usable framebuffer excludes GSP carveouts and
other protected regions, so it may differ from the BAR size and total
physical VRAM.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v5:

 - Expose the GSP static info through a NovaCoreApi::gsp_static_info()
   accessor and read the VRAM size from it rather than adding a
   forwarding method, as suggested by Danilo

Changes since v3:

 - Partially new for v4 - previously a separate scalar GETPARAM
   parameter
---
 drivers/gpu/drm/nova/file.rs          |  2 ++
 drivers/gpu/nova-core/api.rs          |  6 ++++++
 drivers/gpu/nova-core/gpu.rs          |  6 ++----
 drivers/gpu/nova-core/gsp/commands.rs | 10 +++++++++-
 include/uapi/drm/nova_drm.h           |  6 ++++++
 5 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index 4a65bec0fbce..d0ab3df6bcd2 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -38,10 +38,12 @@ impl GpuInfo {
     /// another documented default instead.
     fn new(reg_data: &DrmRegData<'_>) -> Result<Self> {
         let spec = reg_data.api.with(|api| api.get_ref().spec());
+        let gsp_static_info = reg_data.api.with(|api| api.get_ref().gsp_static_info());
 
         let info = uapi::drm_nova_info_gpu {
             architecture: spec.chipset.arch() as u32,
             chipid: spec.chipset as u32,
+            vram_size: gsp_static_info.vram_size(),
         };
         Ok(Self(info))
     }
diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
index 876451dcc051..64f9ea442278 100644
--- a/drivers/gpu/nova-core/api.rs
+++ b/drivers/gpu/nova-core/api.rs
@@ -15,6 +15,7 @@
 pub use crate::gpu::Spec;
 
 use crate::gpu::Gpu;
+use crate::gsp::commands::GetGspStaticInfoReply;
 
 /// API handle for the auxiliary bus child drivers to interact with nova-core.
 pub struct NovaCoreApi<'bound> {
@@ -28,6 +29,11 @@ pub fn of(adev: &auxiliary::Device<Bound>) -> Result<NovaCoreApiHandle<'_>> {
         NovaCoreApiHandle::of(adev)
     }
 
+    /// Returns the GPU [`GetGspStaticInfoReply`].
+    pub fn gsp_static_info(&self) -> &GetGspStaticInfoReply {
+        &self.gpu.gsp_static_info
+    }
+
     /// Returns the GPU [`Spec`].
     pub fn spec(&self) -> &Spec {
         &self.gpu.spec
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 91db64dcaea7..b9fba3a79b1e 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -301,7 +301,7 @@ struct GspResources<'gpu> {
 pub(crate) struct Gpu<'gpu> {
     pub(crate) spec: Spec,
     /// Static GPU information as provided by the GSP.
-    gsp_static_info: GetGspStaticInfoReply,
+    pub(crate) gsp_static_info: GetGspStaticInfoReply,
     /// GSP and its resources.
     #[pin]
     gsp_resources: GspResources<'gpu>,
@@ -422,9 +422,7 @@ pub(crate) fn new<'a>(
                     dev_dbg!(
                         dev,
                         "Total usable VRAM: {} MiB\n",
-                        info.usable_fb_regions.iter().fold(0u64, |res, region| res
-                            .saturating_add(region.end - region.start))
-                            / u64::SZ_1M
+                        info.vram_size() / u64::SZ_1M
                     );
                 }
 
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index ffc25fd8c47b..5c1f9d296198 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -212,7 +212,7 @@ fn init(&self) -> impl Init<Self::Command, Self::InitError> {
 }
 
 /// The reply from the GSP to the [`GetGspStaticInfo`] command.
-pub(crate) struct GetGspStaticInfoReply {
+pub struct GetGspStaticInfoReply {
     gpu_name: [u8; 64],
     /// Usable FB (VRAM) regions for driver memory allocation.
     pub(crate) usable_fb_regions: KVec<Range<u64>>,
@@ -261,6 +261,14 @@ pub(crate) fn gpu_name(&self) -> core::result::Result<&str, GpuNameError> {
             .to_str()
             .map_err(GpuNameError::InvalidUtf8)
     }
+
+    /// Returns the total usable VRAM size in bytes, i.e. the summed lengths of all usable FB
+    /// regions.
+    pub fn vram_size(&self) -> u64 {
+        self.usable_fb_regions.iter().fold(0, |size, region| {
+            size.saturating_add(region.end - region.start)
+        })
+    }
 }
 
 pub(crate) use fw::commands::PowerStateLevel;
diff --git a/include/uapi/drm/nova_drm.h b/include/uapi/drm/nova_drm.h
index 26a5e7ca5425..946bd4bf8fbd 100644
--- a/include/uapi/drm/nova_drm.h
+++ b/include/uapi/drm/nova_drm.h
@@ -180,6 +180,12 @@ struct drm_nova_info_gpu {
 	 * currently known chips.
 	 */
 	__u32 chipid;
+
+	/**
+	 * @vram_size: Amount of usable FB, excluding GSP carveouts and protected
+	 * regions.
+	 */
+	__u64 vram_size;
 };
 
 #define DRM_NOVA_GETPARAM		0x00
-- 
2.54.0

