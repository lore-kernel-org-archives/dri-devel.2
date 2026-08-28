Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1844BC61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 03:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5909410F212;
	Fri, 28 Aug 2026 03:36:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="cCp2Yypl";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81F1B10F20F
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 03:36:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k49k+kuNzinNf/5Iq+Iq33K2iv2a6nvfpPqOZ7fOuY4sFiQtZXd8E8OUep9TkUle6h2eFeTgOaz+pPtyIUhPS8Zs3t507g6Etq/MGoyaoWgofU5DWc+Jm3AjUfuxtUcOyi42cqwQCjJytLjQ676NP4GI8r8ItX870HQ8OBfNFzGajQmssKd7PT0D/GA9sF0G/hXS3XWVnmqXEZEuNY5PzI5HIL4lilNxcpT6oYIDU8t/aj0ligsZRQ3hWHhM6VwPFH6d2aBV/86xOGZjEBh381NxRAed6wDFy5RHRskiPHakiEiVfcnPNhFneN3CTAJzicGYFs8j9Phygo+oiSuwOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYZWzB60iLOyfvgW5NbbsCRPGNUKLwYlMrG6yt++lfw=;
 b=jtL+TUn9i/Xlx+i2+F/stQ2AsyAZQ9y/WQRwEkqdJ7Com8XPiupWJU/OvmdaCsaMCPBr1Hl1t7DhTFPWFLn+oGaE/Mo6ULliCl5cdNTujpgF52nV77Yoej2I4HSbc6Yu15m9sI3uZv4RZv7n+E+iMIP0MU558jH0uCOV2+4LYLskzK1GWknnns4yLVVMlxUZErWB8dEtSIpANt1U2Ym5HhZYo3b0+3d5J47dFFlB2xthY6nLaigynuvFdpD5OB7eG4YD/R8YQ9BsJRiCkFX7DGka4E0AD7AjNf2I/k4rU7ZK7vtnxQqkh5Fkj0r9dPt35zRmgF+ilB6J4Ttbv3ixBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYZWzB60iLOyfvgW5NbbsCRPGNUKLwYlMrG6yt++lfw=;
 b=cCp2YyplJ8PUMu+laAyy8fEB2ZhVZ2f7wNPNPCnyM16MXxqlbGbth0GbVr+6DmeB3CI1NQrUFhp9ZadQ8wU/3C4h4o2Njfpk0/oIRND6VBDfGmtNLspjMX+187qztieBo60TdeQQQy5CfPTzxOH1jRi/hxTCEOLOGMIL+P49D3JmLsag42Ha2BFzXoHpY/Pt0uAcE/TA6KNyWgCt3aNOOjtJWn+4FjBMnWMUB6uBSENx+UtSodfRIDpwLSCGlIk+8WL5CIUWsC06FAiGBZi2CIEvulO3UeHFILbpJbiMg0AtivCp/okTBmVPjiYKQTzhTKsftcK051loNhkXNtXr2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 28 Aug
 2026 03:36:16 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 03:36:16 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu <nova-gpu@lists.linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>,
 M Henning <mhenning@darkrefraction.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH v5 05/11] drm: nova: Add an info ioctl
Date: Fri, 28 Aug 2026 13:35:25 +1000
Message-ID: <20260828033531.1117754-6-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260828033531.1117754-1-apopple@nvidia.com>
References: <20260828033531.1117754-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0014.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fb::19) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|SA1PR12MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b7597c-b2bc-4235-1ac7-08df04b5842d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|23010399003|6133799003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XsEi0N6kNqaVyyWy1eQdTjLN/pLq+nuuYwe6wdFe05Tg0DEX6tlnFmTO2XoCC8oCd2T5E2eU/wMIM/xiK6DIZNDpwmUB0qd5VYs0BX7BDp18Zexl5pr8EkSxUgK7Mlx5+LGb1Ww60ZKvcwwCG/zU5HpUCYCAvRyLD2T7beU0nLRQnRm816GKAdajZ1otfWwbUJX2opvgTY1SLjMg2g8BnwXX/Pi5AekUv7Lz5x16iWKVM8bN3wHowcfcXqxeObuEZiz6jG0VSB5a5QAJddb0p1QnxcdTUDN0OPYok68RF5BELHwvaCjx5k4pfvpIO5O+rs9u+iocSALkJQ0xJV6fW/aTosJ3Ia3ZO/anZA52joCdcmv3CNBNe3lPIKKd7wVVdKNLE0hRFChm65yIv05WqJsmUiH2Akzlj/amFBd7VtY5TYdtv9MVmfNGNLT1qrmQs3Qoj6+GsyXCiGQFc81l6g4i9xemow4Xgs7mj7JJGBbLLEVJDuYaGGgdJu0Fd9XH3MtwkkjSP08UKfzMx//jNvloCpgUKFkE34bJYZEHY+nsbKG4pImqM59mmwYpeKD1+GVt9TeP90ExtQGH9X9ktJHoaY/I1O3Q0MdnEJJbAfT96K/NvtQ2KomoGi4hc9I+Cl7Wq1ZaxuDGIWAYfsTp6AxmA+uJHSW+ehR8kEEtOu4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(6133799003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5yf5Na/122lVWMw+W1EqMcdeWia21vN4MToS+k5ZETJ1gePntcYeOKcgBvri?=
 =?us-ascii?Q?WnGWbsLYGxEJOLhAHczJHhH2FJDdQYq3tWZkBDuJPITHVdSsPePFZsI6BGuj?=
 =?us-ascii?Q?4Jh5O538ZOzcGfIDuh7u2Tb3fo3wNwKylfW3nIo2GwZcIgzxIysiO/Xzljx/?=
 =?us-ascii?Q?MFZF5VLYXrmvFM/tFHpWfmfyTli68uH2sUnZ7jeIM+/Auzg1sQnN8U68tgrc?=
 =?us-ascii?Q?q7UA4vrpNfy+SJlMICEXMFN2pN1jWJxAVh4TfJzgD686yNlrkAIMlpNSi1LL?=
 =?us-ascii?Q?Pt0KI02ZrV2NvkpTK4vyez4lEShKAhBWzip5SvOOInj25evo2KzU/QYsISSd?=
 =?us-ascii?Q?H/el45qo/A0ctF7LQls7BjaNUYQSutlcrDADBJJO51784q6hjaKjMX4vR6gd?=
 =?us-ascii?Q?5YTe9pYMzc7CaJ0MTy6JExRfUakdBpxC4lHZ3URdDMPB4tCHMNEmyNCmzKu4?=
 =?us-ascii?Q?4PjOBSSIostqt5o3XSDg9nk/sz1jFoY8HJ413DtOY4cH4UZP0jHTMyduvtd5?=
 =?us-ascii?Q?1muPBBxxDPvX2HSbRwqgDkC9Wos1IxzbX4abXDa0I58DfgRTg8kDtNCjF+le?=
 =?us-ascii?Q?U9qMbldEtnFnaDRUf3Gi7lalIkS4Fy7ipS06BgnlQG3o5guaDZyxOV59cIv6?=
 =?us-ascii?Q?8DUWEy1F8TNiuq0VrxAKY0x6GJ/AkJdgcL/pNvsAozysb4IQjdnlUi3hQNfd?=
 =?us-ascii?Q?DW/7fg4H+ZvDR8t4+V/eXdTVtzjnEzVbGjQWxqMFN/Xbq2a7g+oCJzE+dPTF?=
 =?us-ascii?Q?BGFjbYRHTHZ4SZBtuusngxRQnnhoH0z588oTQo8F1c/Li6mSqY5kMmZsFAkk?=
 =?us-ascii?Q?XxDQ/Be0Y/rrhJ8RmFR5gFxEAUmDd7FUJoJjuTcZ79Su2Kw9HTSab2d1lknY?=
 =?us-ascii?Q?J6p/aVUkzqwq++d2jk/5Z4fGVzlx8lfVLLAs8z0c0k0TYsl2S8tEyF/ud6z2?=
 =?us-ascii?Q?eo7CHaLHIkOgxHCsCyaHJJV+2Yyzg7hyk5WKVIbB45eSz6ST594MgrHNVTMY?=
 =?us-ascii?Q?RpWyRp83VEk8A1aMew4jySsrwJxwA9ClF1ZwL8KsEXLKxKTCHnNvlErPL3Nb?=
 =?us-ascii?Q?uN/seqZUndTEI2N7aOJ5BMxtGiltE+IWBan5OasTz0/l4HmTQ6RBYb/WFSiP?=
 =?us-ascii?Q?gx0QJ4ARddTEokwNFt8GGU3by/4KXd2BNuaP8Q9Dm4vR+AnuazhMtPVfnq9e?=
 =?us-ascii?Q?38hULcDgt6W3jqhBTseVA6LntEKGaiEY0LemEw3xyIOk0loS7ZygjTOiemLs?=
 =?us-ascii?Q?sovikvp0nCnEdwpAGufZ+GalFRU/SsfiGKaiuN0NGpaYK8enjOrWifytMKkw?=
 =?us-ascii?Q?E/FQrt2VizE62qhZkRsF94zfs5zvVDKe+o7Q5mlkhP4JFx/2lDBbbEgaQYOV?=
 =?us-ascii?Q?XvWmFtkttY4rjkCq81bMxA9piKHjntJFp4H7JjtrOhQ/sj9qByeinRtv+Bqx?=
 =?us-ascii?Q?KWySyyBrYlpKz89mK8BEbWKusIxBH9PkZy3vN7SP3T18C7KHqpVymu7LYvE9?=
 =?us-ascii?Q?dAXaBi+51Qh1xFSwwb3mHVpSBqDldOFjObUbMR2EoLCz44l/ffA6RR8y5lg7?=
 =?us-ascii?Q?zFHg/oiiTDMPDiI8GKD1Ee6UlZkj1+UOxOMXhy92lv232HgVOdR/eUAtBhDh?=
 =?us-ascii?Q?mgIq/oeUOwigyigMG+9XSdz6j9BiddUdShxXHRmzlmDTMFSGFRTUxoUd1zmQ?=
 =?us-ascii?Q?u+W1Nv7Npdb+LaNaK6wLvEivmJomFqOOw2BJ899zwsipKjITSk0VVz4h9EKa?=
 =?us-ascii?Q?96nYX7R11w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b7597c-b2bc-4235-1ac7-08df04b5842d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 03:36:16.4076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWB23lhCPVi0SJzaaNAx6pQWqkCbIbAo/MxWM3V6xEvrRFljYsELPiJpvDjl1Qt/e4+8MruWsLLIreRFhhlvig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6919
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

Add an extensible info ioctl and use it to report basic GPU information.
One of the first things userspace needs to know about a GPU is its
architecture and implementation, so add that as the first field in the
GPU info result.

The ioctl selects an information type by ID and writes the result through
a sized userspace buffer. The kernel truncates results to the supplied
size, allowing information structures to grow and new logical information
groups to be added without introducing new ioctls.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v4:

 - Add a new info ioctl interface as suggested by Danilo

Changes since v3:

 - New for v4 - chipid was previously returned as a GETPARAM parameter
---
 drivers/gpu/drm/nova/driver.rs |  2 +-
 drivers/gpu/drm/nova/file.rs   | 57 ++++++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/api.rs   | 15 +++++++--
 drivers/gpu/nova-core/gpu.rs   |  9 ++++--
 include/uapi/drm/nova_drm.h    | 49 +++++++++++++++++++++++++++++
 5 files changed, 127 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index 632137d1c6d7..38f82a7e1738 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -32,7 +32,6 @@ pub(crate) struct Nova<'bound> {
 
 /// DRM registration data, accessible from ioctl handlers via the registration guard.
 pub(crate) struct DrmRegData<'bound> {
-    #[expect(unused)]
     pub(crate) api: Pin<&'bound NovaCoreApi<'bound>>,
 }
 
@@ -98,5 +97,6 @@ impl drm::Driver for NovaDriver {
         (NOVA_GETPARAM, drm_nova_getparam, ioctl::RENDER_ALLOW, File::get_param),
         (NOVA_GEM_CREATE, drm_nova_gem_create, ioctl::AUTH | ioctl::RENDER_ALLOW, File::gem_create),
         (NOVA_GEM_INFO, drm_nova_gem_info, ioctl::AUTH | ioctl::RENDER_ALLOW, File::gem_info),
+        (NOVA_INFO, drm_nova_info, ioctl::RENDER_ALLOW, File::info),
     }
 }
diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index 1156df51c533..097bf607485c 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -17,11 +17,45 @@
     },
     pci,
     prelude::*,
+    transmute::AsBytes,
+    uaccess::UserSlice,
     uapi,
 };
 
 pub(crate) struct File;
 
+/// GPU information returned to userspace.
+///
+/// # Invariants
+///
+/// - The layout of this type is identical to `struct drm_nova_gpu_info`.
+/// - All bytes in the value are initialized.
+#[repr(transparent)]
+struct GpuInfo(uapi::drm_nova_gpu_info);
+
+impl GpuInfo {
+    fn new(reg_data: &DrmRegData<'_>) -> Self {
+        Self(uapi::drm_nova_gpu_info {
+            architecture: reg_data.api.architecture(),
+            implementation: reg_data.api.implementation(),
+        })
+    }
+}
+
+// SAFETY: `GpuInfo` has no implicit padding, kernel pointers, or interior
+// mutability, and all of its fields are initialized before it is written to
+// userspace.
+unsafe impl AsBytes for GpuInfo {}
+
+fn write_info<T: AsBytes>(info: &mut uapi::drm_nova_info, value: &T) -> Result {
+    let mut writer =
+        UserSlice::new(UserPtr::from_addr(info.data as usize), info.size as usize).writer();
+
+    info.size = writer.write_truncated(value)? as u32;
+
+    Ok(())
+}
+
 impl drm::file::DriverFile for File {
     type Driver = NovaDriver;
 
@@ -78,4 +112,27 @@ pub(crate) fn gem_info(
 
         Ok(0)
     }
+
+    /// IOCTL: info: Query device information.
+    pub(crate) fn info(
+        _dev: &NovaDevice<Registered>,
+        reg_data: &DrmRegData<'_>,
+        info: &mut uapi::drm_nova_info,
+        _file: &drm::File<File>,
+    ) -> Result<u32> {
+        if info.data == 0 {
+            info.size = match info.id {
+                uapi::DRM_NOVA_INFO_GPU => size_of::<GpuInfo>() as u32,
+                _ => return Err(EINVAL),
+            };
+            return Ok(0);
+        }
+
+        match info.id {
+            uapi::DRM_NOVA_INFO_GPU => write_info(info, &GpuInfo::new(reg_data))?,
+            _ => return Err(EINVAL),
+        }
+
+        Ok(0)
+    }
 }
diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
index 610cfc01111e..cff730a38c1d 100644
--- a/drivers/gpu/nova-core/api.rs
+++ b/drivers/gpu/nova-core/api.rs
@@ -12,11 +12,12 @@
     types::CovariantForLt, //
 };
 
-use crate::gpu::Gpu;
+use crate::gpu::{
+    Gpu, //
+};
 
 /// API handle for the auxiliary bus child drivers to interact with nova-core.
 pub struct NovaCoreApi<'bound> {
-    #[expect(unused)]
     pub(crate) gpu: Pin<&'bound Gpu<'bound>>,
 }
 
@@ -26,4 +27,14 @@ impl NovaCoreApi<'_> {
     pub fn of(adev: &auxiliary::Device<Bound>) -> Result<Pin<&NovaCoreApi<'_>>> {
         adev.registration_data::<CovariantForLt!(NovaCoreApi<'_>)>()
     }
+
+    /// Returns the architecture identifier of this GPU.
+    pub fn architecture(&self) -> u32 {
+        self.gpu.spec.chipset.arch() as u32
+    }
+
+    /// Returns the implementation identifier of this GPU.
+    pub fn implementation(&self) -> u32 {
+        self.gpu.spec.chipset.implementation()
+    }
 }
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 0c12ef145981..740466af268d 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -138,6 +138,11 @@ pub(crate) const fn arch(self) -> Architecture {
         }
     }
 
+    /// Returns the implementation identifier of this chipset.
+    pub(crate) const fn implementation(self) -> u32 {
+        self as u32 & 0xf
+    }
+
     /// Returns the address range of the PCI config mirror space.
     pub(crate) fn pci_config_mirror_range(self) -> Range<u32> {
         hal::gpu_hal(self).pci_config_mirror_range()
@@ -198,7 +203,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 /// Structure holding a basic description of the GPU: `Chipset` and `Revision`.
 #[derive(Clone, Copy)]
 pub(crate) struct Spec {
-    chipset: Chipset,
+    pub(crate) chipset: Chipset,
     revision: Revision,
 }
 
@@ -286,7 +291,7 @@ struct GspResources<'gpu> {
 /// Structure holding the resources required to operate the GPU.
 #[pin_data]
 pub(crate) struct Gpu<'gpu> {
-    spec: Spec,
+    pub(crate) spec: Spec,
     /// Static GPU information as provided by the GSP.
     gsp_static_info: GetGspStaticInfoReply,
     /// GSP and its resources.
diff --git a/include/uapi/drm/nova_drm.h b/include/uapi/drm/nova_drm.h
index f0dcbca1908d..300285b520a3 100644
--- a/include/uapi/drm/nova_drm.h
+++ b/include/uapi/drm/nova_drm.h
@@ -92,9 +92,56 @@ struct drm_nova_gem_info {
 	__u64 size;
 };
 
+/**
+ * struct drm_nova_info - query device information
+ */
+struct drm_nova_info {
+	/**
+	 * @id: The identifier of the information to query.
+	 */
+	__u32 id;
+
+	/**
+	 * @size: The amount of space allocated by userspace at @data. The kernel
+	 * will return the number of bytes it wrote.
+	 */
+	__u32 size;
+
+	/**
+	 * @data: Pointer to the userspace buffer into which the queried
+	 * information will be written.
+	 */
+	__u64 data;
+};
+
+/**
+ * DRM_NOVA_INFO_GPU
+ *
+ * Query GPU information. The result is returned in a
+ * &struct drm_nova_gpu_info.
+ */
+#define DRM_NOVA_INFO_GPU		0x00
+
+/**
+ * struct drm_nova_gpu_info - GPU information
+ */
+struct drm_nova_gpu_info {
+	/**
+	 * @architecture: GPU architecture identifier. See
+	 * &enum drm_nova_architecture for currently known architectures.
+	 */
+	__u32 architecture;
+
+	/**
+	 * @implementation: GPU implementation identifier.
+	 */
+	__u32 implementation;
+};
+
 #define DRM_NOVA_GETPARAM		0x00
 #define DRM_NOVA_GEM_CREATE		0x01
 #define DRM_NOVA_GEM_INFO		0x02
+#define DRM_NOVA_INFO			0x03
 
 /* Note: this is an enum so that it can be resolved by Rust bindgen. */
 enum {
@@ -104,6 +151,8 @@ enum {
 						   struct drm_nova_gem_create),
 	DRM_IOCTL_NOVA_GEM_INFO		= DRM_IOWR(DRM_COMMAND_BASE + DRM_NOVA_GEM_INFO,
 						   struct drm_nova_gem_info),
+	DRM_IOCTL_NOVA_INFO		= DRM_IOWR(DRM_COMMAND_BASE + DRM_NOVA_INFO,
+						   struct drm_nova_info),
 };
 
 #if defined(__cplusplus)
-- 
2.54.0

