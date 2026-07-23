Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6DCC531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 06:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D23AF10EF93;
	Thu, 23 Jul 2026 06:31:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="iN6OnsOM";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A6BC10EFBA
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 06:31:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zw7HcebP4WoTV60vCPNqJswqJUlhJcZ17PD91c3vZYAvQ7JMiz04Rb3SU/vEDWyqhSa6NrtR4LAB6M8d7Pe7rLLoYqXV3BOuTxszgRBrSa5F9E+ksUfca20xYomFiEFmAIBfJVBcrEcbluIFanp4BGBtO8La0fTjGFf3tEZh+58SeUzSeQ9F2z8VP1gFBV52uAtWZtNpoy/sFTAx/+mYDXQYbzIye3A4xKmSp8togOMPltHHN0/18zHYtr32LJdJbgje8kH19weUtzNIQpnNugPx6Epdqql0HGSgBlOZl7nddrydLLmRtCjsambyUprVlSbrwZHokS3A/rFDIYQQ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zLwfCnKNnWuKJsCfDN5TLP3FDK/LTDHwdW23VW99U0=;
 b=WygTO2+bDyksBn1q3RPxt4E4Buxn1jXq1vjdwPQosRfW6vIO8hTqskLHi95WOht5Fa5szEvkv9JO9p6YbdZosMlyW/JopFGuUe2U7VHGLqYx97NGEK9aMivHIuWSJ0mHpKh4sFQaR7umiBcJMywX28yXpNzxn1Okn2+6IqXkKDapMcnHXkOI6ypmnCcxJI8+MT/hRi+AljhkxTW5ppBJlNoBK1TCcr/qDtLbFKKe6ueRg+1EKGpVe89TmK8GAmkZcCi+TG3xOYmRyU7zmKFXh4KVNVjdKeLmam/eYhdWNMf9FihfrvZ9GYIWJcT5fmFlZnz3jSY80grje7SbbBRW2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zLwfCnKNnWuKJsCfDN5TLP3FDK/LTDHwdW23VW99U0=;
 b=iN6OnsOMPLb53sQJRDmt+I1QcGTlS1l79qvi3eVgKuZ19dSormovLyHghXBCoUtB/RX4jEe4kJnu4Nu3CP7fYSHmDWKe3a9j7YA3JfGpQNLcn3S6MNiPtYW+9sNUgk95QJkfYlZvqvNCEV+6M1b7m0YyrIAaau+ZKM0fIe9ya1i/4APqHC5G6nIzoU0d7L47A72OhM1Zcp/ZLao+83k4GMUMit5SibReuA8eZ8h7yRIIqjiad/9KwtEj1lJLxamjXS03OZMa8Wurqzu/U6E7NtvBIb4665WWhHpp3HOwwvAU4Q8/urCbHI+5TYrPayNwm5tNOycrXRKU1KRzNblqhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH1PPF0316D269B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::604)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 06:31:27 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 06:31:27 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu@lists.linux.dev
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v3 6/7] drm: nova: Use nova-core to read VRAM_BAR_SIZE
 parameter
Date: Thu, 23 Jul 2026 16:30:44 +1000
Message-ID: <20260723063046.1265791-7-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723063046.1265791-1-apopple@nvidia.com>
References: <20260723063046.1265791-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0028.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:202::14) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH1PPF0316D269B:EE_
X-MS-Office365-Filtering-Correlation-Id: c8936e9e-c104-413e-f1fb-08dee884060d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fhJjEjv2Rl18RMvVVRh5p5OX+7RKljBTB6URwTpHgQc4EbwXiJ/ulb5cmz4F+Fom8SP8RrxQI0CfSMyf4PnsGM4fb5e3Iax4LWDPv8JPMW6xgRS2rX6XwnZIMUdlgoU4WJdBUMp3K9JV8ukoczY7W9/ztEjQRAcT1eVuxA6bYQdvsUrovqlOsS0TZO+O5PlnOsEvOEhYG0dm0gSrLo1HePnzcVNftXJEA5nnJrv+PZBriixcf4lrDsfhFybCSfXeYO6IIbNWZdKLsHoQ5KwodvtO5V3efNMQGbdlwmrNsNX9RBA0llfO41S+TfsxcGc0TS+CL1Reujba8T/X69tkTnoZYB9tL2XRJAxYkMOBS4gWcAPPv9qvQbyeWCIGNjY3UMlhwJnTv1E6x/FhMDYiSoicYfQs1OY30OCQTAsx5D4fRA56cpIED5P7+jLUfCQ3tgMYTFWY6hg0DIN4M+2aug44lcatMW2yV9PjOcGU2XBvHUeUv+2p9Lv8fb3VB18amXXwfbc3hSla2Bx8HjjpTEh0gOiEe8xKKp8dVFxUIxwV/k4qA7vG6G4VMg+fF9imQGUA5M72GBbMprnyikQJ2CYfAruT5euPvIgJnpdwmUrltPR5aqfW6B5FoGq2cPfrURarSdaiK/su2PTL3FutsBQ3ABu3xo5pDmeGBJ/HPOY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JjQx2KLjeYpB+RMw3EZIW1x0PQojsp9Nz+uwNZjJ57AYA2SMe0xGVMFEg1Eu?=
 =?us-ascii?Q?sjOOBaA98H3//QJMxoxdGHLB6HpLBuay+vB2DisrjTvFj3TBxxfyq30mD7mC?=
 =?us-ascii?Q?ggCmrVUDeTiVO5JwDpqmtWnKRFpMh7sgumvX1f/mqexSV6Vi/wdpjyA+Az/t?=
 =?us-ascii?Q?dqEqsTtkmltXztukegtbkBALMvK4juDCerdv1LsJkDB9vVYLibru2tiF5zf2?=
 =?us-ascii?Q?TQbRxkVl8yrZgSGNqvZiv2uheW2/2hJlKLwuGUqGsky3ujZkhmnOczynEsK4?=
 =?us-ascii?Q?XiS6rHSFB1f78/NT2ZHmYC9BVJDAvEDXX5wSWSru24PkioP0WNe+Piy7Xjrh?=
 =?us-ascii?Q?Ce0Fu9S8d+JuXxOTAGgynVuQumXmcaHJympXF2WDpe7sAteUtmapwy24/S3O?=
 =?us-ascii?Q?aA97H1uJ9PQYHz/4dAkv2pD3V4IK/WSzZRhe6TxRW8oft1P9Fs1f+IK1AOyH?=
 =?us-ascii?Q?5l3QxlvC5ndh8VdKYb1lRzM7BmNoxpatw9omx44t9qqm4PLHyUL/gsc4InzO?=
 =?us-ascii?Q?CCSArrNFbmP7YnexY3xlfTxJOubFCEHfMupyz6u93Cf/D3eaaaZC1YwA/tSn?=
 =?us-ascii?Q?xkcELfg8k3r++u07QBw8YOQESlnbn1xQsm6d+agPAcO23UqfPntQpmmMyANx?=
 =?us-ascii?Q?H7vJ5M3Aq7qr0oxwHZhXEyeGQsqrnhfOJ3Ysyu7f5eNZ3XCCS2n8EPbwZXA9?=
 =?us-ascii?Q?Cu1H0EAQssufBHezhjyzcCJMD7y+B0Qj377vCiMyQuLGmVT7EQEeZw0rHaBC?=
 =?us-ascii?Q?94XNpXmmONxhDf4PJntqLJM3Bcgl93m6DtzQfbDH+r5hdbt5dQ6f8NXvfMfC?=
 =?us-ascii?Q?mYLI4x7N0O6oEcnVYjY6rMFx2bCBqRQqhSkYqlovx6V4L5G1jdzj59nOf/Hu?=
 =?us-ascii?Q?dJQ2fq+bPpvWGqxJgCB3uTz70AXOMvpuelBkkq0wCuALqD9piAwjjOn1QIaX?=
 =?us-ascii?Q?nQD9zTdWDHZGnQDz3Ewf9l0TwrW5A+ML7oYT6VJIHUz7IKWbcDVM4TcBlFst?=
 =?us-ascii?Q?nrVocrZZLaJ3xH6ZaMHYRqCmlr2A5Ik4RROKobY0bnFecGOMtD/MzcTfZb9e?=
 =?us-ascii?Q?yb05F2fQh6i23/BWxxWlGZjrIAI0TvaED+kZeE4lI8Tb+vRQVhZDY46Swnoi?=
 =?us-ascii?Q?SWEuQcdMtZEXRUp5uxSwqzDj13uVW44KaNQ9s7JJ6thEp3j3If1g/d35y++a?=
 =?us-ascii?Q?bDnREqn0GRcV94aDfX5d2kpYCwfj90GUDAIuoYoIUWK3TivWrCrlmN8FOIb+?=
 =?us-ascii?Q?qE406cDnmoXUeEtko3ocliy8bpBlMt8QduCnIFpq/AwXv4pbJgiAQ7/BLmQo?=
 =?us-ascii?Q?SzJEUyA/xvklKaZfqYRTEGHaAiteJPMgOdnJn7NIHxjW+kt1t1hZRNDg615B?=
 =?us-ascii?Q?/gHzC83xVabKvG297BJn2yxPS2oXdj9vsk6m8+pJiFOwTSD2sPZy7AVmxUA9?=
 =?us-ascii?Q?JTG1O34eNoptK6YM9YgCkYqmPqxd95r2XBeQMze/yJxSK9WfyE6wd2fHSsY9?=
 =?us-ascii?Q?ACjGgORS3qqaPbjUUqoJyLfc1PLKt1R9xIC+4cBv2n7PqYSoq0RBfOwGKGhe?=
 =?us-ascii?Q?OI+v6xnQrxJK/iz+29KSAA680EFkdQpdA3NVTp1UhgjbkBBRxzJUErXsBPvM?=
 =?us-ascii?Q?nYuoyxLbLn/XP3rSgzaxUpqnajpFel5A40liNLiNkR6GBQXcKJNOhOVxJbVM?=
 =?us-ascii?Q?FawkdMK0Kn2Xh6WDuC1dw++9lh+U5vYEWbq8HvNJi8MRmCp6UF9ClBlbmmfU?=
 =?us-ascii?Q?ez17keyPCw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8936e9e-c104-413e-f1fb-08dee884060d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 06:31:26.9332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUb72bWjAG8vc1ZHaGn58FU0ZbZnnqaY84f0IF8Yac84P0hze32VUIAIm7JrW+ss/2jCEGsCN/GyxY7ByS3JfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0316D269B
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

Currently nova-drm reads the VRAM BAR size directly from the PCIe device
which requires trying to cast the parent device into a PCIe device. This
obviously requires the parent device to actually be a PCIe bus device.
Whilst that is true today it may not always be the case, and there
is no reason to make this assumption now that NovaCoreApi can hold a
reference to the bound PCIe device.

So convert nova-drm to using nova-core to obtain the VRAM_BAR_SIZE
parameter.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes from v2:

 - Update nova-core API to use bar1_size() instead of vram_bar_size() as
   this is used internally throughout our chip HW.
---
 drivers/gpu/drm/nova/file.rs    | 10 ++--------
 drivers/gpu/nova-core/api.rs    |  8 ++++++++
 drivers/gpu/nova-core/driver.rs |  2 +-
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index 8c02be4f15bf..d65630079237 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -8,14 +8,11 @@
 use crate::gem::NovaObject;
 use kernel::{
     alloc::flags::*,
-    auxiliary,
-    device::Bound,
     drm::{
         self,
         gem::BaseObject,
         Registered, //
     },
-    pci,
     prelude::*,
     uapi,
 };
@@ -33,16 +30,13 @@ fn open(_dev: &NovaDevice) -> Result<Pin<KBox<Self>>> {
 impl File {
     /// IOCTL: get_param: Query GPU / driver metadata.
     pub(crate) fn get_param(
-        dev: &NovaDevice<Registered>,
+        _dev: &NovaDevice<Registered>,
         reg_data: &DrmRegData<'_>,
         getparam: &mut uapi::drm_nova_getparam,
         _file: &drm::File<File>,
     ) -> Result<u32> {
-        let adev: &auxiliary::Device<Bound> = dev.as_ref();
-        let pdev: &pci::Device<Bound> = adev.parent().try_into()?;
-
         let value = match getparam.param as u32 {
-            uapi::NOVA_GETPARAM_VRAM_BAR_SIZE => pdev.resource_len(1)?,
+            uapi::NOVA_GETPARAM_VRAM_BAR_SIZE => reg_data.api.bar1_size()?,
             uapi::NOVA_GETPARAM_GPU_CHIPID => reg_data.api.chipset() as u64,
             uapi::NOVA_GETPARAM_VRAM_SIZE => reg_data.api.vram_size(),
             _ => return Err(EINVAL),
diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
index f025df90dc5d..9e2a5ba7c269 100644
--- a/drivers/gpu/nova-core/api.rs
+++ b/drivers/gpu/nova-core/api.rs
@@ -8,6 +8,7 @@
 use kernel::{
     auxiliary,
     device::Bound,
+    pci,
     prelude::*,
     types::CovariantForLt, //
 };
@@ -20,6 +21,7 @@
 /// API handle for the auxiliary bus child drivers to interact with nova-core.
 pub struct NovaCoreApi<'bound> {
     pub(crate) gpu: Pin<&'bound Gpu<'bound>>,
+    pub(crate) pdev: &'bound pci::Device<Bound>,
 }
 
 impl NovaCoreApi<'_> {
@@ -34,6 +36,12 @@ pub fn chipset(&self) -> Chipset {
         self.gpu.spec.chipset
     }
 
+    /// Returns the size of the PCIe BAR used for accessing VRAM, typically
+    /// BAR1.
+    pub fn bar1_size(&self) -> Result<u64> {
+        self.pdev.resource_len(1)
+    }
+
     /// Returns the total usable VRAM size of this GPU in bytes.
     pub fn vram_size(&self) -> u64 {
         self.gpu.gsp_static_info.vram_size()
diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 435aa917d3e7..175275fd7961 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -113,7 +113,7 @@ fn probe<'bound>(
                             // never recycles IDs.
                             AUXILIARY_ID_COUNTER.fetch_add(1, Relaxed),
                             crate::MODULE_NAME,
-                            NovaCoreApi { gpu },
+                            NovaCoreApi { gpu, pdev },
                         )?
                     }
                 },
-- 
2.54.0

