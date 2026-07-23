Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCF3C4453E
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 06:31:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7C5010EF8C;
	Thu, 23 Jul 2026 06:31:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="FyBSLRae";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011018.outbound.protection.outlook.com [40.107.208.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A675510EF85
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 06:31:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjPm9ZO77zLOjTBElZdKwBjvet/Jkx78UwWyu0s1+y0p7gdTw/1/sOmk149WDok/X2Y7Ecw3SUbm3Q2KyFrg0/9Q92m7TSyQXxSsoopObP0RpGHBH/WjGUDoRwMnM57NOH6qhWDdqMUZxg+0Qzo+vCRbDaCTNz8266eeglr8GGb2py6InJ5cw+5jnvTDW8XrzSeCAXTijUNSAxjOhIbjqm2nWp8C61/+6Srt2+flj1RUDDcq55oAyoSSDKNS2n0+lIU/h9uAI2tD50J8oy5Dji8+Ua9V/9AgRRAXDXMr/pQ+gRXtjy9hd0+yacsAM8wDNSMX+iQJ4ORhXf0sIxu59w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mf3z677hwN+3niIQ84hu4w839jKckA/Ce2BGmsn9buY=;
 b=jPOFOgeV7Qo/SYMbOp2nAvARXwemVzY8xqCtqrVRtzh2CK8mIGGU89rETkDpYTy9+Dyx+1/nNUd87kf4iKrqVByFXk6tzTCMa98EilAUKxaIyPhb2ac1PummAlQx0FODHGsAYcNrOGziveLgx0quUJQdA0Fdd4MkR/edeJb77TMTxwYp+EFEvETKoGfq5ZHLrXSkDDOMNzixX6d6/CbEE78VpzNdncTgGOvFDeVp7jseWPy6aX+KfOTfjYgyaHV5yoA/Oq0iFSdtcbbcmzn+xy9N2jeskqezPL5ywFqGlfrn/kw/ZrFtnCVYrmlxmeuhhaQK8FyCMqvPp0+4zPkIUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mf3z677hwN+3niIQ84hu4w839jKckA/Ce2BGmsn9buY=;
 b=FyBSLRaeeo2qtdVXXntHYFyX92QSW6eCsoMUNsqSf/0rpgrATzO5oLNtjKwjPBEeHeOIfbGtB8sDt5o6ZNW2zpIXcliNsbXF8MRF4A+0AYsXOMXAC1U2d9E7C0BSlxtMekGKsrSEen70b434eQeLjO8gTlfGaJlno5yRKYOKSGvXPE0eKAMeVj8mJmgse2/lnzN0hnMUXhmfxXMoZ+uStfoNlW7kuf2+vPywyyDpoCQMv0KuVTe44u4pDLUsV908ZkARvit8CdrB9ka369EoRVPbGB15RBq1hrbMnuZcDXnFiUYJxaRBi4ntwTi1onfx9SNgaYCGvqDD9+tzrDAjtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH1PPF0316D269B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::604)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 06:31:17 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 06:31:17 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu@lists.linux.dev
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v3 4/7] drm: nova: Add GETPARAM parameter to read the GPU
 chipid
Date: Thu, 23 Jul 2026 16:30:42 +1000
Message-ID: <20260723063046.1265791-5-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723063046.1265791-1-apopple@nvidia.com>
References: <20260723063046.1265791-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0017.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:202::6) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH1PPF0316D269B:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa1a48d-5edd-4127-afa4-08dee884006d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QzWwnHL0ckyEOpxTOy8VCEYivioftny549eOs0vBcxaXqPmHDSws2l0Rm+WnpQyIcLee3tlBZGcz91MxWYBIWlRM5loiCnx21NWa2kbnT053xnUHIOQpCHoF+edCYirtNEVkV3U2OZwblbnJV050loDgLk28fi6EeDsA6E7VXjecEbDSbJva56uM6gGQr2F8MT5XN36jw6WgRtiG69Y9xvRK0ahFiFhJ1G2Spe29CJQA0ZGjy4VbzSWAMwX9iLYgvibNcJE4vMzm1P3A2C5BuoQU0P0873QIv6xiWunUdodRe0SulvKeUYYspL330rzUA5PhJd1ziX4p23qdA2qKy+2ALEIX+tjYE0ExrfgIbjl2sY9yibEMnxKLmxKwZbUnGfYh3Hsb3gO/Zg3RpW6dM808o7xCm5FH21k6v6IJWrFNflaNkIHHjqmkPR1ge2Z76CUQRczEavL5292Nrgx6063XV2eWNt+fy6sIRU6IlrNCtArpxhvRakqm1TKQr2FIqsVI/fMqTeRHYFlPyfizozEGiL1qTHVYz5dlcs5BayIuD7GFEVasy6bOzPW7uIa2GDxGwjQ3fSHukJRBDWBv2laxAoPXe49eUVoFGpN3TDfXMrM42hNp/OiIGFOD2omjPbzPCo266lFt2Qu1qNawo3m56YAwwOWoq6TPRm+GMQo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ptg1sh0SygAq7rL34GGrGsTLURbUWuS2Ek6MdhiEhw36izPPJ7nHaasQ4eS/?=
 =?us-ascii?Q?FP76iEwGBhyQp+IrX33uzGv3z+sYRxovTMy0dg548rn2l6JZXc/kM/tYppwZ?=
 =?us-ascii?Q?BAlswWh4NR1a6imP3lab6bVfaglnEQhBD3m8yJdMLzotdl4FvYzthTQYXmWm?=
 =?us-ascii?Q?pVHAGzyyZb34AByljlaAJdUSHsm0z1IU4SHcNO1xBJlFOqkYewAWbtzIC3nv?=
 =?us-ascii?Q?GJL0u0w25o8ZNNbRnmF85cV/aaS+0nts7ppODbalyeg/3KXNRBky1Ao8N/nZ?=
 =?us-ascii?Q?NxlJsp7wI5iddNBdb375Q9ytUFIDj8MxzjyU3x+2rCVsmCNw/s7ziOWFGAde?=
 =?us-ascii?Q?jjuYL/AadPwaDy/hZOsgWftj4umua1L1GAz01Coiei1pBiY6lu0SatTc3S1d?=
 =?us-ascii?Q?Rb8iP79Ra14PtQqkk8npQObjzP9X+luSyIDpLuGcDhbvsEV0+oswNisbYkww?=
 =?us-ascii?Q?JO9fNZsGlg5rhWHBRWPRtu7NKsxxuKqE0uqfM6N+blU/STQUQWX4XQeqGeHS?=
 =?us-ascii?Q?hGt7haKhl59J54+hiyVoyS5KruhmdIwMb6miy+OG46dVQhX/wTZ9LUEK1H76?=
 =?us-ascii?Q?6ZEtLa7/MBTtoCRJqyhGcHgqcugSQi//7a0NvxrKuuuP5l+2eORof+1Kl+2H?=
 =?us-ascii?Q?9YKyg6BJX22uqUrvCV434vO5XcPG+SESpfG9soCfNXfDKIKPkBUqtrc+m3gx?=
 =?us-ascii?Q?P/GTo+p7Vcb/Kq6eCFUagJd7JpigN9v7EhxIRgTNp0gyA+fIvExi2Jl3KzBU?=
 =?us-ascii?Q?w+Ey0XrXVMBPtIOO3oZWx6x9aLFcommXH0ZZTPwHiFfi8Umz+A5eqBviVSOC?=
 =?us-ascii?Q?MwH2whuq3wwmaVzLt3tpS9SPyBvCljH7PQ4F84KjV67M2x0FbWXc4oF7/Ldm?=
 =?us-ascii?Q?DSNAulp7pYVjeGg5Hb+4EQ5y/KyCSV1hxu80Qiq+ixfeRVz/gs3ohPlfbBp+?=
 =?us-ascii?Q?LMSCpf9TNnrBlCbhBcB9Pnq+2zIB+Um2g8v9SlEWDFbML9tdI94/w/iZzyUC?=
 =?us-ascii?Q?SCi8tjYp0ncxgaTuZs7nM2PZ0j6PRRd18Ofn8HBMbSnnIMAaiuUyaAO3kHB4?=
 =?us-ascii?Q?mwTt/k8jmPEjiJVTXNfUEeVUqRVk6q/kZhaUXfF3Av/uLHiAdacQ92f4aH4Z?=
 =?us-ascii?Q?1+Q8BN6EIMeoDOhsjEqfn5eyD5dJpaWhc553WkXaQeqjKVhyQXWzPSXXldeW?=
 =?us-ascii?Q?qiodmZ0jHT38GfCf7Jji2tL9dL+wxabELRoqm45jaBu4SelNxDK/rcjHOv0q?=
 =?us-ascii?Q?Hn2Ne7LBdE34F3IM3/wGL38EjUHbbr5eYX7r+Lg1i0ZaEmLZoXy8PdRofNX1?=
 =?us-ascii?Q?Lt+8SDdTSMKpnKc4ph/PyXFdjfFRxFw0dvxQbsCq/K51Hfkr8RItlR/SKjJu?=
 =?us-ascii?Q?3Uey7SnMMUaxhdfY6Pvq0UUjObZni/OCZC26alowuv8Xyx2bYkYPC/SMrELC?=
 =?us-ascii?Q?80DkKw8HNTiPsyglNyOVNVgxYaWr4NA1zV0RFdvOttKJ+EWhKqmCQmMoQls9?=
 =?us-ascii?Q?Y6lLgRLYW9KA6MHjFnN7YzekoEdFwaEQuzRbYILwI5I9WWbxlLG9LvpdgGug?=
 =?us-ascii?Q?9jh0fxkxsd4kUVev6UhV/+I27bcQdUXLngKMAFh0JXZ+5xX3EatYzDjFbgtW?=
 =?us-ascii?Q?LtznEt7cb46kbDAVhHahbprfMte/nZxFdJU0xhIHIhFKu7H5D74r3tIspscT?=
 =?us-ascii?Q?nxg3iiPAUizMNVZza+jL/Zcr/7z2tI8WiEngo9YVGS5iVExQvTvqyvk9AjFv?=
 =?us-ascii?Q?DwJShteAiw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa1a48d-5edd-4127-afa4-08dee884006d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 06:31:17.5351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JVKXFjbWpcrnJTKa7i1HM5XO3GVTSMWqj2ORh6CGPBieQrBrAwKvxRUXBTL/2CiRiL2rTq3o3m7vJmCrNdFPA==
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

One of the first things a user needs to know about a GPU is its chipid,
so add a GETPARAM parameter to return that.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v2:

 - Split out enum definition into its own patch
 - Change uAPI to use chipid rather than chipset

Changes since v1:

 - Vertical import
 - Use a single enum for chipset values
---
 drivers/gpu/drm/nova/driver.rs |  1 -
 drivers/gpu/drm/nova/file.rs   |  3 ++-
 drivers/gpu/nova-core/api.rs   | 11 +++++++++--
 drivers/gpu/nova-core/gpu.rs   | 10 +++++-----
 include/uapi/drm/nova_drm.h    |  7 +++++++
 5 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index 632137d1c6d7..f144417b29c9 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -32,7 +32,6 @@ pub(crate) struct Nova<'bound> {
 
 /// DRM registration data, accessible from ioctl handlers via the registration guard.
 pub(crate) struct DrmRegData<'bound> {
-    #[expect(unused)]
     pub(crate) api: Pin<&'bound NovaCoreApi<'bound>>,
 }
 
diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index 1156df51c533..855f23877734 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -34,7 +34,7 @@ impl File {
     /// IOCTL: get_param: Query GPU / driver metadata.
     pub(crate) fn get_param(
         dev: &NovaDevice<Registered>,
-        _reg_data: &DrmRegData<'_>,
+        reg_data: &DrmRegData<'_>,
         getparam: &mut uapi::drm_nova_getparam,
         _file: &drm::File<File>,
     ) -> Result<u32> {
@@ -43,6 +43,7 @@ pub(crate) fn get_param(
 
         let value = match getparam.param as u32 {
             uapi::NOVA_GETPARAM_VRAM_BAR_SIZE => pdev.resource_len(1)?,
+            uapi::NOVA_GETPARAM_GPU_CHIPID => reg_data.api.chipset() as u64,
             _ => return Err(EINVAL),
         };
 
diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
index 610cfc01111e..09da0b4e9103 100644
--- a/drivers/gpu/nova-core/api.rs
+++ b/drivers/gpu/nova-core/api.rs
@@ -12,11 +12,13 @@
     types::CovariantForLt, //
 };
 
-use crate::gpu::Gpu;
+use crate::gpu::{
+    Chipset,
+    Gpu, //
+};
 
 /// API handle for the auxiliary bus child drivers to interact with nova-core.
 pub struct NovaCoreApi<'bound> {
-    #[expect(unused)]
     pub(crate) gpu: Pin<&'bound Gpu<'bound>>,
 }
 
@@ -26,4 +28,9 @@ impl NovaCoreApi<'_> {
     pub fn of(adev: &auxiliary::Device<Bound>) -> Result<Pin<&NovaCoreApi<'_>>> {
         adev.registration_data::<CovariantForLt!(NovaCoreApi<'_>)>()
     }
+
+    /// Returns the chipset of this GPU.
+    pub fn chipset(&self) -> Chipset {
+        self.gpu.spec.chipset
+    }
 }
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 738a590e753b..264fe4e65b3f 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -41,7 +41,7 @@ macro_rules! define_chipset {
         ::kernel::macros::paste!(
         /// Enum representation of the GPU chipset.
         #[derive(fmt::Debug, Copy, Clone, PartialOrd, Ord, PartialEq, Eq)]
-        pub(crate) enum Chipset {
+        pub enum Chipset {
             $($variant = uapi::[<drm_nova_chipid_NOVA_DRM_CHIPID_ $variant:upper>] as isize),*,
         }
 
@@ -119,7 +119,7 @@ fn try_from(value: u32) -> Result<Self, Self::Error> {
 });
 
 impl Chipset {
-    pub(crate) const fn arch(self) -> Architecture {
+    pub const fn arch(self) -> Architecture {
         match self {
             Self::TU102 | Self::TU104 | Self::TU106 | Self::TU117 | Self::TU116 => {
                 Architecture::Turing
@@ -161,7 +161,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 bounded_enum! {
     /// Enum representation of the GPU generation.
     #[derive(fmt::Debug, Copy, Clone)]
-    pub(crate) enum Architecture with TryFrom<Bounded<u32, 6>> {
+    pub enum Architecture with TryFrom<Bounded<u32, 6>> {
         Turing = 0x16,
         Ampere = 0x17,
         Hopper = 0x18,
@@ -195,7 +195,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 /// Structure holding a basic description of the GPU: `Chipset` and `Revision`.
 #[derive(Clone, Copy)]
 pub(crate) struct Spec {
-    chipset: Chipset,
+    pub(crate) chipset: Chipset,
     revision: Revision,
 }
 
@@ -281,7 +281,7 @@ struct GspResources<'gpu> {
 /// Structure holding the resources required to operate the GPU.
 #[pin_data]
 pub(crate) struct Gpu<'gpu> {
-    spec: Spec,
+    pub(crate) spec: Spec,
     /// Static GPU information as provided by the GSP.
     gsp_static_info: GetGspStaticInfoReply,
     /// GSP and its resources.
diff --git a/include/uapi/drm/nova_drm.h b/include/uapi/drm/nova_drm.h
index cb13fba6b952..c655302a40fd 100644
--- a/include/uapi/drm/nova_drm.h
+++ b/include/uapi/drm/nova_drm.h
@@ -25,6 +25,13 @@ extern "C" {
  */
 #define NOVA_GETPARAM_VRAM_BAR_SIZE	0x1
 
+/*
+ * NOVA_GETPARAM_GPU_CHIPID
+ *
+ * Query the GPU chipid (architecture/implementation).
+ */
+#define NOVA_GETPARAM_GPU_CHIPID	0x2
+
 enum drm_nova_chipid {
 	/* Turing */
 	NOVA_DRM_CHIPID_TU102 = 0x162,
-- 
2.54.0

