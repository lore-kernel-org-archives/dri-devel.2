Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F325C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 05:35:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E979310E748;
	Mon,  6 Jul 2026 05:35:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="J97SWVPD";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012034.outbound.protection.outlook.com
 [40.107.200.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D22510E745
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 05:35:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3N6ldpinwI18Yuy7TfkhLBSt6t6njxNgfsPXYU78wCBHld2EtKdndKVAHNXNTTAV2vh5ii771NL/ejJ9ofsjqlnAwdWeexL9IQ4hofO44OsBrFmbBI0hG1I9EcDeVfbv4OSQQ1WKUh7do558xNuG+qsz6bZ812vNJP0abx5GrAusnu65IBBNT0jZGJYTK2fQ3t/V0K0TPMtcLs5w/w7hNSMbU5hkyWwnpGrtkuCGMZEuPLn/GhhpfPQNrMSknWoUee7A5lPpkQJp2V0XS6I8q/WJ8s4ZKK1F0YojrLOW/pOShG7OZddoTf46xge1JkczI+SYHE+F+CymnEaBaPzJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/4czS5YqrQHQ7aBJLVlLN/bdu296qcS0JXCFJ18owA=;
 b=uwIHfTN2zMPoAtH63Nd4rgogj8sJtrDpXO2MhHZ5NEpZ9PahH1dVib70puGtVyJuDDjchkGTipZwcgnuhxKZL1KN+mSXgOEhviJNzotF5ytzPOr/aL0Ug/h/sS36rE2iOAjFuzkY2nLAGszGcSKrICe70l6WFQxGimb8dr+aFGwp3gxkkTIeazyG6VHfLhMo0MjJVQgbk9KyMzfUHOExargBBRV0XM9P5j+POgs1NtIJEHwjA236j5AOLAEwIizC7LA7YShNKhbyKdjNnkGS/R9sp/8Lawz5Ic8YTVcVMFxmRO6sc05HrYmX6mJRLY2vH4qT/aWTJY143wEQuD9+ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/4czS5YqrQHQ7aBJLVlLN/bdu296qcS0JXCFJ18owA=;
 b=J97SWVPDnfrQG95QhjiNoR7MaZNZqx8OVyw6E8mBnSLKkm9uPsPH5omN4D3KuhB3le5b5DFutxipSluISsUY6j9FSIYeOZ0pUykd9boyMxz+MFRote0U7tm5mtOfao2v1IRvQlN1A2+3ShVr3ptFay4JJwFDtgDEhYCzs6ONch8CA+w0MG81vFK0DwSY9pnLE/cDye8+cdNqyJ3SbJU5Wc4faz83HIlLgUHMf7tbcKucWsBh1jBbJRAC/Z6F85gcsiM69cHj1ediiU538ISnf0tRzYu969RSH/HecBkePPEwmPQ6U2WuLyP7xxzgICBTwmfQ0lLjdW6kHoC6czmjPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Mon, 6 Jul 2026 05:34:57 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 05:34:57 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu@lists.linux.dev
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH 3/4] drm: nova: Add GETPARAM parameter to read the GPU chipset
Date: Mon,  6 Jul 2026 15:34:11 +1000
Message-ID: <20260706053413.154135-4-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706053413.154135-1-apopple@nvidia.com>
References: <20260706053413.154135-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0042.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fd::13) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 4390cfc9-fe4a-4993-b969-08dedb2050d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 2TU7QQ3z19e9Vk3MImUdXH2Albmxh/QNU+I6V+37UKMk2V+wC8A1/LsD0mz274Ol0ZISujL/hrg6trBzaHiYzlz5XzMJpZRDxscDKrjd9UZmve+rFHVZd975T/6ThyvLwKBYQz2JvyxF//qMqjSsfXMBBbTKes9UR3P3Tk5Mc+I84Fiicv7fgZ/g6Qn7mQmUtit8xgHPCF+to1UUNBDTaRkhgswnaYHHLC+FJK69EH2USnhzSSJUa0J8OsMcvHaBJR9VxGFPzoR7CXJRuljxsFNmCY4dQmJP9iu3K8WQZ14WPqT2wc0kseZquHyR/JJ/YlvLVW44hgjxR7MM2IuL8xMCBdYjMGNuS1yK5VlXdgjGS22eVTZnrNKZe/gKbxAjKRfo2SpRuCMmMvb2fqKqk/Sdk+xB+6diXnNTjiVieO3czwr/Yh2LBsDO1ynPmIWXNqihjZlrC1gpUB7EgmmLskQEpZEKTnEi0WQZW1m24tLNbYrxibUfn9ObUAMxWWVMhCzRrlOc4EDUPj4iCjt0Gb7z0BdSVaPu+WAOSvMVwcliosBJTPrNnqqlJx82eaVlAsolxv3QgbAyHG+2b2q0nxjwG4bw+4/6TM1cOS23eZyiPUHqYveomQj6nwQH1NMNWst2C0QWDQVywDiDRPF9EyS+T/HPPavnfDeG7KAvpCU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SMkj3gfbCZiKHgxdxCjXvNN651zlLjiNiKrq8j+twzzuagXVA6XUKA4JvVZ9?=
 =?us-ascii?Q?s/AJzcsL4mmgxM/iWMXoKF4IL7xEeHIxSduyMdLUQF+64fnTsvh3zOhDV/sv?=
 =?us-ascii?Q?qeAZMOW1u2tgfPOHpm33md2FuStwHod00H4cqGMWwbT/NqSLF4Bn8YFXIGAa?=
 =?us-ascii?Q?kn4PLUmey0njiV6xwOtOqYKknNXNKwe7FLd1dAr4PH4dnAwFRN7st/n0ysps?=
 =?us-ascii?Q?MDoJJu4VXwoL4//u9zzX8QiVVLo+sbtBaWV4AVAc5ojAnnIahHRquXneZiu6?=
 =?us-ascii?Q?ArfVrdAbSxzT3OH67CwmUd//g4HPz3RhcptosHwvxPUtcTfsaaEIuW4PS03m?=
 =?us-ascii?Q?N+tYepC3YsfCK/LnQgrhWEE+MJ5Jzo4M8StXVbLrAzb7ZOIOH+UehfcSGLYm?=
 =?us-ascii?Q?jEGD/M6cKDCQS9rGxJomMTjldmWYSFT0PxNMS0A1P8SQiGgA6gIdk4ufiVb/?=
 =?us-ascii?Q?k+eJM/C2LZjxPhovYEq/TzZ1W3xb6ofKHJvkx7i2eXf8ndy8AfbCKWttAEua?=
 =?us-ascii?Q?Llqht0xD4qvP37EVko6H4f7gUahhw79FcbAtZIyOlwuG3jIGTogLiDeFAiDI?=
 =?us-ascii?Q?MHOUb/W4Yenw+eIUkUyxH+pT+IhceNhT8IaqUTRiEh52PHT8dYaI8DILjhAt?=
 =?us-ascii?Q?WSE+JDK+CTqLheEdrxEJEvRCgcSLIV9P84OAR9PZtzOoQ/gSNO6GAWjFldLw?=
 =?us-ascii?Q?erEWv6thPC7SN3Vt0+eUR6X/xMId+iECVkes/Hf4BmttDCGpkHN6KzNxVLmH?=
 =?us-ascii?Q?q8jvEhTLREZgEwbO+jgqG70pn933IRezq7GU07LkIuFFjh6P9Li1oQzi2Lqj?=
 =?us-ascii?Q?V3JbQfyZjvMTwi+QPpu8Qp7+cZzoiMVRSDHVH53zglnbEOpmmHeE7tNYB7qn?=
 =?us-ascii?Q?ATUCcAh1nmFQJBMCTtVUrCGIODiFx+PFqomMJtVXv04FUSPJJPi4BNEgIVi0?=
 =?us-ascii?Q?KmDRvzJIoj/HySKTwcKlu3ruYRfCkiVP80UUDLPjr3JU6gawd4cGrwh0EC7H?=
 =?us-ascii?Q?iJso2VGK0Cb0IZeuI9CDHsXyZRbXOyvzJgcPaA0po2Wp427IPimlC1njkIlo?=
 =?us-ascii?Q?Ipd6tMdPNNV+yeCKJ73H/VohcUfsI9Hv7yao1bhzvhmBFFjJv3DYUYEehsBe?=
 =?us-ascii?Q?0fIgfhzG4HvN02ExRdAEiy4rQAvK15BFEjWjvSZtt1x0vcwaLcf6iF/whCLC?=
 =?us-ascii?Q?WJrKTptRt+2f8funzai6BxzFhGotItwu97Y+ozDQTVAbifNkchqlSbnJraRw?=
 =?us-ascii?Q?Q8YeviyKlr0q5coyAAUEGYWZzJhF4NvRToRyzXMBf27llP50RvpSVHAaiDui?=
 =?us-ascii?Q?S55EQOnMXvdkK4oimeozgoY2xORNOwEkNbmVdzl/sVLHjQQsOOTAfHfPpjlA?=
 =?us-ascii?Q?1WigOpO1hHJMw4Pb2D5kCh/NJB0OY41YYKYDeFy/ky6pFaF0wnZbTqkt2/bK?=
 =?us-ascii?Q?Keq5HOlhMDE++4r7OflO0hGIBKldzs0OKn2W4OnAErrGcUDrYzfobipqM/qX?=
 =?us-ascii?Q?rz8AbOw2OtrXXRI6lXdTzic9Qx/zkgVRmAr5as3JDg6xWdjuJtMQyAqNOufF?=
 =?us-ascii?Q?Quq/oh1NdP1AjtBKawKH17i7bQGuZtpYQ1CLNuy/WdBAdEN2BGTmpLClSNwl?=
 =?us-ascii?Q?Xf+b5bfunyhmJwXKb7RdszaFBbOwZi5W3eGlgJI1q8+PCRKTRh6nUXc1LN+k?=
 =?us-ascii?Q?crErSxSaaIjuWZIIqYEVwq8MlBBWWwaSoIpHwBxm/vh4E4jF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4390cfc9-fe4a-4993-b969-08dedb2050d0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 05:34:57.7844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbiU9BVkoqn0ueHFxe04iirK/Em2ihfaQzInTxAnbOZ/ESEMvhbBvv6b22G/nKdiTcTuX43rp4IvrfFHltq5VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714
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
 drivers/gpu/drm/nova/driver.rs |  1 -
 drivers/gpu/drm/nova/file.rs   |  3 ++-
 drivers/gpu/nova-core/api.rs   |  7 ++++++-
 drivers/gpu/nova-core/gpu.rs   | 10 +++++-----
 include/uapi/drm/nova_drm.h    |  7 +++++++
 5 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index 3ae719540e4d..42f8845ed6b4 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -31,7 +31,6 @@ pub(crate) struct Nova<'bound> {
 
 /// DRM registration data, accessible from ioctl handlers via the registration guard.
 pub(crate) struct DrmRegData<'bound> {
-    #[allow(dead_code)]
     pub(crate) api: Pin<&'bound NovaCoreApi<'bound>>,
 }
 
diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index 855b6ffe696f..e573be34bb96 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -29,7 +29,7 @@ impl File {
     /// IOCTL: get_param: Query GPU / driver metadata.
     pub(crate) fn get_param(
         dev: &NovaDevice<Registered>,
-        _reg_data: &DrmRegData<'_>,
+        reg_data: &DrmRegData<'_>,
         getparam: &mut uapi::drm_nova_getparam,
         _file: &drm::File<File>,
     ) -> Result<u32> {
@@ -38,6 +38,7 @@ pub(crate) fn get_param(
 
         let value = match getparam.param as u32 {
             uapi::NOVA_GETPARAM_VRAM_BAR_SIZE => pdev.resource_len(1)?,
+            uapi::NOVA_GETPARAM_GPU_CHIPSET => reg_data.api.chipset() as u64,
             _ => return Err(EINVAL),
         };
 
diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
index 68ba8bda800a..14ca26e257d3 100644
--- a/drivers/gpu/nova-core/api.rs
+++ b/drivers/gpu/nova-core/api.rs
@@ -12,11 +12,11 @@
     types::CovariantForLt, //
 };
 
+use crate::gpu::Chipset;
 use crate::gpu::Gpu;
 
 /// API handle for the auxiliary bus child drivers to interact with nova-core.
 pub struct NovaCoreApi<'bound> {
-    #[allow(dead_code)]
     pub(crate) gpu: Pin<&'bound Gpu<'bound>>,
 }
 
@@ -26,4 +26,9 @@ impl NovaCoreApi<'_> {
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

