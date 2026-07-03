Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADC8C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 06:45:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1F7810E585;
	Fri,  3 Jul 2026 06:45:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="UKaU9S1m";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6131D10E585
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 06:45:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flumdvpCMAl9L2Za7+Nfo5R8Q4EXkH+EQUA7Vx0A6tuGlOodDydHWmgiRvOdgOCALu87Zd7FreQpHHa8kGxvBri3ZodeCxQc7gvSno9D5D2C5nxv/E6A16ffMMSd3NvBZTSKZRncjyViCuV1OESEUux6YS+6nVBdqtt3eixqS9CZ0kgUHjE4xl5BBZcahcy/JSsGUdjbNVynjokpDN3kQOP2JRFJ3Ni2kPdC1OmZbXxeG/qVY+IPRooKZe6ZCGB5RZZtn5qvnrjfEx1gS253DhtxAAoodAQ0UK7mymh+6gtY5xMCnh50P2Q2O4KebJrVNJVBA6mnBTMoLsHmFVO4Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVpiZ+V6EIihj4jtxmELm5Lbltx7Fbq6PAzUjqPRDuQ=;
 b=XqxXhwg6wQ/IJDm+TOeRposnYi75mi1CAf78vEMMmpJgHj1el8Y+AuDwEobLvXQf3e2y1xTWDoHcTlYjDjJGHWtNsg6URAWzj6rnHTa8RbOEgPECUAjPI4a0xlFXXYxu6fZ5b4Gb/pQ4MUI7U4LS2oxaod+nT41j5cEh6nONFDTo7s62VOLhDR4XvI5fjktL2XTCkHIFVhcxsNONxNCevr10/F4XiJHq2O06h4NuqWlRcM/Ohh3S/f0vMezNdYrU59tvZu5u1/+xeEfJUL0zGLjPmd51t3SsbXDfoQ+dICiPBvN+HWSCU/DhRYWYwbzPUrarNrKbKZps7LrijjQiFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVpiZ+V6EIihj4jtxmELm5Lbltx7Fbq6PAzUjqPRDuQ=;
 b=UKaU9S1mZ/EhSqtKTZ3WwLuBU+d4kgs77phFjTif/QLGRVSCjf6fMr5wJMINAGhxkv4vy9OoEhAM+GHEzoYS3XWGcSP94rsbnrztZTT8ukdAW5ewLDDlHz7auHA+i5EDZbSPxMs7ojmYpbZtyFHNXo9iDP5oEzu5nbsqWrkvPRLccvDGMbBOtuEMPuwI1+kqxK20wS+LiC37AY2uLC6AzGYblxzVQ78umS3kO8jwTux32+B0Gt+y2nl/5yWcHAZqjDn5JvofPedHrOBO/9mpqaLEW6madd+P7SjeEIeymxZWm33JjfWpd+ovH1pvS0k8jKorty+jwWR5U4s93gtwPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 06:45:48 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 06:45:48 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu@lists.linux.dev
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [RFC 2/3] drm: nova: Add GETPARAM parameter to read the GPU chipset
Date: Fri,  3 Jul 2026 16:45:25 +1000
Message-ID: <20260703064526.3630668-3-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703064526.3630668-1-apopple@nvidia.com>
References: <20260703064526.3630668-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0122.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:209::15) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SA1PR12MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f3a1848-fcd2-4bb3-d3f2-08ded8ceb6fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|11062099010|18002099003|22082099003|7136999003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: xKvwbu7ZPlhjOzyMwkVCpWt+H1C5kCIHmRQD/cq4wmaqLl79s4Rqf6gnS2UwIQRQAOG0pUPsjBIlXfPZXZtiWVCbgYLPme5ZAhpwuZdpVLByWyE7ddn73qStT7wcv/zx6Qweuco8hCXthammpS0nGDTaa7H4j50I/pM0GdIdFvjapCmyBT4VgvBtoDozmgJ0JyigGj0AcrUhzpg2We4a2eFiwGBHeRqEjkMOQeNwTy49XJOGqakMgtFYO1BlToBvITUjG9DdiB3mdazYVRuVNuCsc/AXNqKhrD0cBohyuwoBfwdyfLVcktRnCiOLY0aCCJDAn5Vl20mpIdWv87cGskuSLdZAzikO+mXT71NO75ld9TBoGDN5kscgo2jpLJyJDivBUeDfpmk6wvNCZH/jNPhZjidm2/BfA5sr7nz7WPIzW85GESnUf8tkyNE19iXmbQOsQwkFYK6n4W4Kc9gyEnmfW54ugO2InBECwF+o1UgyM4bCt9R5+YBe97sAH1fjnwi+fkoCa1F88yPiKFp7qjRvWJZqMdqTyfmYHbj6Sqd1GJpU/hkTqw+c/yGvIVoEcsC/lV6CwJNLF6tEVkdC4xZdcKesc7VGGl3VoeBtO9oMgvVPR6DWvK5Njm+AOptBFvrZMxcjq6UqV6Z1x2xEtSvOqNNkADF87uq7HwNTVVE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(11062099010)(18002099003)(22082099003)(7136999003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N3OwPxIfBy+oujes+wcep6joPR8t2Nf2/AQrMkHt+ROkBEf73vAZv4SD88xx?=
 =?us-ascii?Q?UjGVHtc3qAndhGsKjFMrbiST1XET353OvZmIp2FllZyieg8fhSZ7jAk4bYUI?=
 =?us-ascii?Q?KSBmdomSRj5IsOpibhfIwAI9MN7+T/x9M9Bdllo3uIombyNUzLED0XX4DXGq?=
 =?us-ascii?Q?x9NOz6JPO2r40OyQO/gVSi8rM2MCT7v2M+DpLmaGIEQkpsf03XCTKPWFQmiE?=
 =?us-ascii?Q?3YGDHNReN8Ky6rLjhge0tKkhOXZ2ZA1YYlMCnMIn7+E9rbyM9hv+tG7GQ7gK?=
 =?us-ascii?Q?E3ZsTCkZybnaZHzJsKrIDtskQd5NSQTNvl6lhYRLRVSChKXnBUxwOEjz9jf/?=
 =?us-ascii?Q?nx7fQwcSFrUUkvAPvtTV+JQevuE/fg4W9B5bonas+8fYsUVJGFK96bcg1T/L?=
 =?us-ascii?Q?I2Q09Nx9UwNB7pJPJ0nuC2N0JquWrL+Zo8ohZp8CQpgq3yvjQcssPuG6O+1c?=
 =?us-ascii?Q?f3YNKAXtMHVxhhKbiPXFsJCqKMK64/Blq1d6/apPKzdRI5wbU4PRz4j+zNVZ?=
 =?us-ascii?Q?FTTjIvEPp3v9FbbKzVrmlBPh3VTx0eIN77dFdKU5PXCbymh/vPxO9CfIvmRS?=
 =?us-ascii?Q?wBeWGusESaaUq9JOCKHoUklhvWVY+eqjnU/mMaOAbNvOBPBdYOrsCEyOa6yw?=
 =?us-ascii?Q?s2/9lf2PbywMSglZenoRU1SjRQrFhduI9bBxswSZKM3Dq8xV2ku1ITUVSYER?=
 =?us-ascii?Q?vOll1/0cs3n0DPOjdvRsh0xd/JO5IJAQIsmxJEH3FjyY5a7Ura7g03f+OFVz?=
 =?us-ascii?Q?rMQyhWykxKMBVPQHFXKQDKxhrnqlx/KlRKIK0J6MEj3T+5LUwco2DWaK9uLy?=
 =?us-ascii?Q?TF6x3fCmk+2AcRkcgHYEXgEqI6+Ypb219tWFssynuOcVqRpVrm1ziYr9LNVH?=
 =?us-ascii?Q?SpgElxP9HPeMMAlT4X2jYIoEtzdKrahLemxx+7nbx1PUl1apiGm6Wg+xLU5I?=
 =?us-ascii?Q?0vwvJQW6Z1YmGIftftWxE1gBHEjdXxxqppgdAZWtPqj2SnYta3pPjGX2fpbZ?=
 =?us-ascii?Q?MMFbTvVxwz+1vF0bf0dMUuIt6TTdS4fzUs2qDr3dPPl0mcxJ4zAK9yK2sGhj?=
 =?us-ascii?Q?nR5/t5VVpUs0ayfFImY6Ir/9UT3n5dOIMcc+P+3etJUwYkWOVCpCjW3xIXzt?=
 =?us-ascii?Q?zZV3x78fUJup5gRrmnwt9Ea2m5rOV2aPYfx7yJLLz/9W2+B+6O16bsoSGaRG?=
 =?us-ascii?Q?+yzG8SVPcEEODHzgecXU4PefLGHKH8MJnf0nn9oAgnkdAl0ca2sd+174c//U?=
 =?us-ascii?Q?EYBFa/3CeKxbssbvAfszzHo/d98FGriZzAiCK+0fG6eX/P0KUDldn5DX1FjX?=
 =?us-ascii?Q?kX4jb+3iofb0c5kvQAUnyodmd/5g9WurU073lTZPS9nYR7X+6dtWf/GAzXwc?=
 =?us-ascii?Q?p2j89KIDfPgfjDtty5WwrQr8REkZukTMbueV9/65XrAKX5CfMiizUCmqA/54?=
 =?us-ascii?Q?4LJRgSSEFWG2XxHFW5qfHn78dlYNqiGDQHvAVte7l6oSuujBXfiwHKuSNRNw?=
 =?us-ascii?Q?qqJXP3lmmiG6Jw8OmZcDWBKO66J7Ehto8TcxvpXhfKiL8QGePg87d7QVLLg1?=
 =?us-ascii?Q?AwAbjbAqLhzjeMhq+U6pm/ygggz/F46zQfYYtO/CUgxZzwkaJPTFs4jLV3f0?=
 =?us-ascii?Q?PhoYO0cy5DaqGzDmSw4PLcge4rL6zhe85o//q8Yd2mN6Z3rxU3Qs9EYROkWR?=
 =?us-ascii?Q?952icE8RUZouT8dx7bEhRNVWn2C+OyziLyZ5/DVHjPwC2bsnXO633LHhPtqj?=
 =?us-ascii?Q?FeIs6fcraA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3a1848-fcd2-4bb3-d3f2-08ded8ceb6fa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 06:45:48.0382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6oQqqSEhVksHipTr2zbh0zUucZqd8bM3P1oVVRA+/s7YGdlAN3Ba0mgQFdqFGdtXxs1Ya8jeJcMXlkPL7XB/MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5637
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

One of the first things a user needs to know about a GPU is its chipset,
so add an ioctl to return that.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 drivers/gpu/drm/nova/file.rs     |  5 +++++
 drivers/gpu/nova-core/auxdata.rs | 10 +++++++++-
 drivers/gpu/nova-core/driver.rs  |  2 +-
 drivers/gpu/nova-core/gpu.rs     | 10 +++++-----
 include/uapi/drm/nova_drm.h      |  7 +++++++
 5 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index 298c02bacb4b..8147dfb366d8 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -16,6 +16,9 @@
     uapi,
 };
 
+use kernel::types::ForLt;
+use nova_core::auxdata::AuxData;
+
 pub(crate) struct File;
 
 impl drm::file::DriverFile for File {
@@ -36,9 +39,11 @@ pub(crate) fn get_param(
     ) -> Result<u32> {
         let adev: &auxiliary::Device<Bound> = dev.as_ref();
         let pdev: &pci::Device<Bound> = adev.parent().try_into()?;
+        let data = adev.registration_data::<ForLt!(AuxData<'_>)>()?;
 
         let value = match getparam.param as u32 {
             uapi::NOVA_GETPARAM_VRAM_BAR_SIZE => pdev.resource_len(1)?,
+            uapi::NOVA_GETPARAM_GPU_CHIPSET => data.chipset() as u64,
             _ => return Err(EINVAL),
         };
 
diff --git a/drivers/gpu/nova-core/auxdata.rs b/drivers/gpu/nova-core/auxdata.rs
index 266b5ce4ee89..cd8a3511293b 100644
--- a/drivers/gpu/nova-core/auxdata.rs
+++ b/drivers/gpu/nova-core/auxdata.rs
@@ -3,10 +3,18 @@
 //! Nova-core auxbus data. Contains all the methods used by the auxbus drivers
 //! to interact with nova-core.
 
+use crate::gpu::Chipset;
 use crate::gpu::Gpu;
 
 /// Auxiliary bus registration data. Used by the auxbus drivers to call methods on
 /// the GPU.
 pub struct AuxData<'bound> {
-    pub(crate) _gpu: &'bound Gpu<'bound>,
+    pub(crate) gpu: &'bound Gpu<'bound>,
+}
+
+impl AuxData<'_> {
+    /// Returns the chipset of this GPU.
+    pub fn chipset(&self) -> Chipset {
+        self.gpu.spec.chipset
+    }
 }
diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index ad232ca11833..193e87ac624e 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -112,7 +112,7 @@ fn probe<'bound>(
                             // (`try_pin_init!()` initializes fields in declaration order), lives at
                             // a pinned stable address, and is dropped after `_reg` (struct field
                             // drop order).
-                            _gpu: &*core::ptr::from_ref(&this.as_ref().gpu),
+                            gpu: &*core::ptr::from_ref(&this.as_ref().gpu),
                         },
                     )?
                 },
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 43c3f4f8df71..d4a71a1be6f1 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -38,7 +38,7 @@ macro_rules! define_chipset {
     {
         /// Enum representation of the GPU chipset.
         #[derive(fmt::Debug, Copy, Clone, PartialOrd, Ord, PartialEq, Eq)]
-        pub(crate) enum Chipset {
+        pub enum Chipset {
             $($variant = $value),*,
         }
 
@@ -114,7 +114,7 @@ fn try_from(value: u32) -> Result<Self, Self::Error> {
 });
 
 impl Chipset {
-    pub(crate) const fn arch(self) -> Architecture {
+    pub const fn arch(self) -> Architecture {
         match self {
             Self::TU102 | Self::TU104 | Self::TU106 | Self::TU117 | Self::TU116 => {
                 Architecture::Turing
@@ -172,7 +172,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 bounded_enum! {
     /// Enum representation of the GPU generation.
     #[derive(fmt::Debug, Copy, Clone)]
-    pub(crate) enum Architecture with TryFrom<Bounded<u32, 6>> {
+    pub enum Architecture with TryFrom<Bounded<u32, 6>> {
         Turing = 0x16,
         Ampere = 0x17,
         Hopper = 0x18,
@@ -206,7 +206,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 /// Structure holding a basic description of the GPU: `Chipset` and `Revision`.
 #[derive(Clone, Copy)]
 pub(crate) struct Spec {
-    chipset: Chipset,
+    pub(crate) chipset: Chipset,
     revision: Revision,
 }
 
@@ -286,7 +286,7 @@ struct GspResources<'gpu> {
 /// Structure holding the resources required to operate the GPU.
 #[pin_data]
 pub(crate) struct Gpu<'gpu> {
-    spec: Spec,
+    pub(crate) spec: Spec,
     /// Static GPU information as provided by the GSP.
     gsp_static_info: GetGspStaticInfoReply,
     /// GSP and its resources.
diff --git a/include/uapi/drm/nova_drm.h b/include/uapi/drm/nova_drm.h
index 3ca90ed9d2bb..63440f5dca9b 100644
--- a/include/uapi/drm/nova_drm.h
+++ b/include/uapi/drm/nova_drm.h
@@ -25,6 +25,13 @@ extern "C" {
  */
 #define NOVA_GETPARAM_VRAM_BAR_SIZE	0x1
 
+/*
+ * NOVA_GETPARAM_GPU_CHIPSET
+ *
+ * Query the GPU chipset architecture/implementation.
+ */
+#define NOVA_GETPARAM_GPU_CHIPSET	0x2
+
 /**
  * struct drm_nova_getparam - query GPU and driver metadata
  */
-- 
2.54.0

