Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D13C44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 08:52:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E12E510E465;
	Thu,  9 Jul 2026 08:52:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="OETY2Zh9";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E0A10E465
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 08:52:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLPaJdClCu/VMmG9NZCqYqjbEff8mtHcS2y48VlDq9HaPqE38a2KlVE6LWwtkSIPHjbrxFELIww86uy36s4ojhSbMOprV1vHrIcw0lHnp/TB6sgWaabT5oPS3bvt2qjuoSPHuZchqJVVlXijcSth2ri9PaNjHywD0w+rBhKNXuqaNAyNpXzTqbZhC3fT2RFneeU336zVUK+f8PsWPgcX/SZx+952LRRLUOkUc8S6mp2NLsZCtm/T2m3iO/4ZTmLgMLF9ea2uPO+iM3gLHGGUhT/V5y5S6+pfHLnPsDYQvk5ijUJfKVKmiDQtWKxQY/zyUwPFc9UOPdGNQOvyogUDzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaHvqFLwdnZ7EisE/3MmWTT/+OWrLMg8LlO/yKqMn4k=;
 b=ZQf94PsydOScollDHYEKup1kzT0+c6+mKJfKOtQfw24zmENfAfEcw3tyc4XUmxNDFQRtgvmvji9J4qnGyBZPHDAoU85pTcVfMhUvGE44NryMto9HvSsexdpYXNHZDE4TtP5qla3W7dmpQR7NXwnDO7Et7Zmh2L21l5rTVTlYqQ7EfQ8rEEN4A5dEpaVnpxT2fYcizmw9uyiEQPuRGsRKiySYNtkWBVVezmBjU2O+WRomLwEoMKNh4nujKovlBgk1FT5BR7sqhOYYDQ6kEdQJB2T7hf+ym7kBM4H+FwO7NRMblhRek/FvZMvWHBGgUXA3rlJnrF3rbfR+becP9Qs1zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaHvqFLwdnZ7EisE/3MmWTT/+OWrLMg8LlO/yKqMn4k=;
 b=OETY2Zh9Y/44qTPGYIhpZYTc5o5sQwMGPu3Ye94shEwA5TCbxfdC63iuYibOSncItpDvWh/0cel+ezt3nw3Q9ux/+lP1BBcJ71HTtNIZbXtYetU1pA/7qmnYdmrj9KL8AdgwIUbrYwiqfA9HHBM02fr08ulftBr2V5IXwxSt1M7Lm8RKw5EWwankyVqYSSrsLFGT2UP2cK1/e4FrCXnGAyGdEPaYUDBMhMtAvjOB8hQt7VwrUO3rl1Nf/hTj+rk5fDNjJ82VZRCzt2Wg8m1rG+K3ZpDVzyAMw4OjqMsc6Q5W5afEBSz/kU0MIjtPCTq+sqhpuM0wixRKaeyM6twMYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DSVPR12MB999283.namprd12.prod.outlook.com (2603:10b6:8:41c::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.15; Thu, 9 Jul 2026 08:52:28 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 08:52:28 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu@lists.linux.dev
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v2 3/5] drm: nova: Add GETPARAM parameter to read the GPU
 chipset
Date: Thu,  9 Jul 2026 18:52:02 +1000
Message-ID: <20260709085204.565159-4-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709085204.565159-1-apopple@nvidia.com>
References: <20260709085204.565159-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0036.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:206::13) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DSVPR12MB999283:EE_
X-MS-Office365-Filtering-Correlation-Id: 588bf940-ac3a-470c-9416-08dedd976785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: G/ZcxJD0jkWEkHB3vRnr/iF7/wi/fR0m2/WSExjvMTAJfnGiFzx4R3oWk4AZYMp0ol1tkSPvG5bk7zWehXnIw/p5jZq3PFmNafyok/fT2/b6DklefGsZ5YDwENkcVAzEwxIAY/ss2Ox7NEis1pipXxEln/xurKaNo+2AfO8K9bpBKmpO38h1KE68gD2CgfijUNEF68KSl2P60O9TljwuKj6LmPltAt7D+WMmIuZ6dnCgwhlvhF6oGNKXklShhXwnyGpkYPRJo8lH4/GwEBa4TaJH43VT0yM0qSPVGqP2Evo2bm1CQgxovCFQyecOgHLB1+cxb7aWIJXSOmMek69yuaw7GucfuMxTgnHcddIfk6azeDtqNLxITa/yEwO0e8ZbOufDlVnLigh6DDos5vJL2bp+bibK4ynGKtw3v5/G5CpQ825MOBdKhlo73VROwVddTWOtB7/bTiwRayHQ+BiZcft5Aps+xExRcQQM/4Ry9bcM0yDpxZWT7ePowcWeFRMwsurEIGwCsyYFKRvz5sVnprrLbgue7aCJQeLSDRMXdr/Js0ntdP+oLiLJQsQbQZmSLu0IWUmj8RF916kRf28b1RnHinfJLkjgB5oYQZ2G4h5N+piTvT63AsKs6V444U8tASEYB383WSTiNAjvcWdcTAjduradGScq0FJn9VLICGQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ttJTiElcS2uTBtTwi5WdpdAIBXdL35LMbJV+siumqcCPgXIZicZtkQs/PTtA?=
 =?us-ascii?Q?bIdO86gWZ1157a/DehqmfUSqThbqpkEjYEzoGot2lEkrBW7vuOSHGdX21A4s?=
 =?us-ascii?Q?7/Pjr9RlAOy4a7kt8napJJqGkGp7J894k5L34npu4TVELRdTaFp5zo3SC+mb?=
 =?us-ascii?Q?kAEe4lxAbWbcLbD4e2bhk+iM1lD1nP/gT440phj6lRwYM4jS3735Brf38Epn?=
 =?us-ascii?Q?TuegFL1bpmqp6wMLXQAesszJBNUSDSghsKl+XFsqQdZK0puFFt0KKkvBhSWe?=
 =?us-ascii?Q?+HznrAQSnkFPsN/M3Eq0YYHgpxOlV+oeYR3iTuZzXZ6rcPcwpuiPcMhVT198?=
 =?us-ascii?Q?seLsyw1CCljZlAdvqnzmIGVBuiaGUpr1HAjHJzggEhOEF+UnCEXxoTcAZw2g?=
 =?us-ascii?Q?zjkuIwK1Y1hvXbJOKjre834v2M9jmQ/wc53yRVUdlbmrwgNfO/k6+KmILKAY?=
 =?us-ascii?Q?s+I66KhZO0PaNc4mORYOm7op+KaylKamdi+MTFpnwP33oYJ84dyKmvC0vPL3?=
 =?us-ascii?Q?ybQOdpeXk2/EYzAbDF2Bevw2IIcRAoUxqsT4GYTwiY5mK0mQ77m4B8ij2PGK?=
 =?us-ascii?Q?XHvg1XcoNRX7VnNd9lOTb+u/St4aIHhn94CDLCmRrgrhDg2MAv7KUAqgsbp3?=
 =?us-ascii?Q?tjuaasOBhRSreytguNDLE9qxwr8WHGFNYwyuZ4uaFWrm4JMtP31DzojR28+F?=
 =?us-ascii?Q?FDPYonRwKDYrt8NL9o1nhh9egobiJwqoaRFHa0uBUtuer2t5/S/09kLVGUuh?=
 =?us-ascii?Q?V/jityjmFwvfJj+WCo1lg0JRfhSUvfqWIwAqDryjKaD+SpvEY5dxA+tygF99?=
 =?us-ascii?Q?IYGmgxIAtrXbRRlfuKlt1Ub7vEhf038wKsdVxDW5btkp/T25Wkrgm4NAQH6o?=
 =?us-ascii?Q?AJytKe8tLZ42TTikbFOrLZrmpBAidAIIdH1IFNPDeupT6GA+B1dpWyTS9Lu4?=
 =?us-ascii?Q?QF8EyxwarMctcYWIjCUKiITzw1xFO3Y50GQnXU9iE4IKglnvyQoTTD1jpZWr?=
 =?us-ascii?Q?Cz0zbunUPQhi/gee8ps/5V6IgtOKF36AZjWvLO1sZVTuCJG2/paVPR1miEQn?=
 =?us-ascii?Q?zdyaLjlhGbK7qdtzQsFxCFehaC4q/u9cxBjcYbF9uCv1kdYuPUiO6nLsdS6F?=
 =?us-ascii?Q?wySuAft34CRxX0cUXYr4EVKxg0I4KakYJVQc9pw0vOxZaWJkXmZuQVybPIpq?=
 =?us-ascii?Q?Lf0o05C6cItCoXJZQaQhpPhj8uuz4FqovOM4Gl9LH5vQcQRlFKJDKHTEVri/?=
 =?us-ascii?Q?Ut1teu9u7SEp/Ou1xKaqkZ7gtnsLD/XXVcSaW6qHLkg6IobuckG4lxbhE8mB?=
 =?us-ascii?Q?95DXWEfRU8etGZWfr6NYg/JWO2W16mdoq9bM266Ptyr8TBG+3eLIPBwAdOpF?=
 =?us-ascii?Q?iErFsdnXi+11TbiCxf+HGpdpOgVCXdkgxi/Ntw4KbIRu5n1zWG+rgDhO+8Q/?=
 =?us-ascii?Q?tbf95uL/UW524udL0HaLY/76zkDy+vIa4UrByAq07Oy+al9j2lbNlQsqau60?=
 =?us-ascii?Q?olRHfSyHGahMqwk2buXj9rAQirXdaUsDclhd86mwCOyXEwCCL2h8f1ka3kLf?=
 =?us-ascii?Q?naFIsfh1Ahuh6uxjWCwAck2TcPkkaHMhzRbhol4Sp85umiKzyT3wWutej2qJ?=
 =?us-ascii?Q?C+xKzRwg00Ybt/Naq1l8glYBb5pM+jRxV/us6wMTsU7c812eFduOGqdCI9Q+?=
 =?us-ascii?Q?PfiHvFnZZIVD4ghJ/x4LeR3md4lmsowwVMaMSfzGoqtzEugv30Ws1D9UWDrS?=
 =?us-ascii?Q?3LyOOkrbow=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 588bf940-ac3a-470c-9416-08dedd976785
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 08:52:28.1622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNfKO0NlLcTNeiF159AYUNQH8Q1RSdIF+esN++4wmiZmPhSaFQTv5gfkinvFDWM3DS3zBE6I6uhd673jU7g9wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999283
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

Changes since v1:

 - Vertical import
 - Use a single enum for chipset values
---
 drivers/gpu/drm/nova/driver.rs |  1 -
 drivers/gpu/drm/nova/file.rs   |  3 +-
 drivers/gpu/nova-core/api.rs   | 11 ++++--
 drivers/gpu/nova-core/gpu.rs   | 65 +++++++++++++++++-----------------
 include/uapi/drm/nova_drm.h    | 40 +++++++++++++++++++++
 5 files changed, 84 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index 0204d1cee6a5..42f8845ed6b4 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -31,7 +31,6 @@ pub(crate) struct Nova<'bound> {
 
 /// DRM registration data, accessible from ioctl handlers via the registration guard.
 pub(crate) struct DrmRegData<'bound> {
-    #[expect(unused)]
     pub(crate) api: Pin<&'bound NovaCoreApi<'bound>>,
 }
 
diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index 1156df51c533..1e5364c619ed 100644
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
+            uapi::NOVA_GETPARAM_GPU_CHIPSET => reg_data.api.chipset() as u64,
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
index 43c3f4f8df71..1f4c5f3aa8ea 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -10,7 +10,8 @@
     num::Bounded,
     pci,
     prelude::*,
-    sizes::SizeConstants, //
+    sizes::SizeConstants,
+    uapi, //
 };
 
 use crate::{
@@ -34,12 +35,12 @@
 mod hal;
 
 macro_rules! define_chipset {
-    ({ $($variant:ident = $value:expr),* $(,)* }) =>
+    ({ $($variant:ident = $value:path),* $(,)* }) =>
     {
         /// Enum representation of the GPU chipset.
         #[derive(fmt::Debug, Copy, Clone, PartialOrd, Ord, PartialEq, Eq)]
-        pub(crate) enum Chipset {
-            $($variant = $value),*,
+        pub enum Chipset {
+            $($variant = $value as isize),*,
         }
 
         impl Chipset {
@@ -82,39 +83,39 @@ fn try_from(value: u32) -> Result<Self, Self::Error> {
 
 define_chipset!({
     // Turing
-    TU102 = 0x162,
-    TU104 = 0x164,
-    TU106 = 0x166,
-    TU117 = 0x167,
-    TU116 = 0x168,
+    TU102 = uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_TU102,
+    TU104 = uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_TU104,
+    TU106 = uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_TU106,
+    TU117 = uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_TU117,
+    TU116 = uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_TU116,
     // Ampere
-    GA100 = 0x170,
-    GA102 = 0x172,
-    GA103 = 0x173,
-    GA104 = 0x174,
-    GA106 = 0x176,
-    GA107 = 0x177,
+    GA100 = uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_GA100,
+    GA102 = uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_GA102,
+    GA103 = uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_GA103,
+    GA104 = uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_GA104,
+    GA106 = uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_GA106,
+    GA107 = uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_GA107,
     // Hopper
-    GH100 = 0x180,
+    GH100 = uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_GH100,
     // Ada
-    AD102 = 0x192,
-    AD103 = 0x193,
-    AD104 = 0x194,
-    AD106 = 0x196,
-    AD107 = 0x197,
+    AD102 = uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_AD102,
+    AD103 = uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_AD103,
+    AD104 = uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_AD104,
+    AD106 = uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_AD106,
+    AD107 = uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_AD107,
     // Blackwell GB10x
-    GB100 = 0x1a0,
-    GB102 = 0x1a2,
+    GB100 = uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_GB100,
+    GB102 = uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_GB102,
     // Blackwell GB20x
-    GB202 = 0x1b2,
-    GB203 = 0x1b3,
-    GB205 = 0x1b5,
-    GB206 = 0x1b6,
-    GB207 = 0x1b7,
+    GB202 = uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_GB202,
+    GB203 = uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_GB203,
+    GB205 = uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_GB205,
+    GB206 = uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_GB206,
+    GB207 = uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_GB207,
 });
 
 impl Chipset {
-    pub(crate) const fn arch(self) -> Architecture {
+    pub const fn arch(self) -> Architecture {
         match self {
             Self::TU102 | Self::TU104 | Self::TU106 | Self::TU117 | Self::TU116 => {
                 Architecture::Turing
@@ -172,7 +173,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 bounded_enum! {
     /// Enum representation of the GPU generation.
     #[derive(fmt::Debug, Copy, Clone)]
-    pub(crate) enum Architecture with TryFrom<Bounded<u32, 6>> {
+    pub enum Architecture with TryFrom<Bounded<u32, 6>> {
         Turing = 0x16,
         Ampere = 0x17,
         Hopper = 0x18,
@@ -206,7 +207,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 /// Structure holding a basic description of the GPU: `Chipset` and `Revision`.
 #[derive(Clone, Copy)]
 pub(crate) struct Spec {
-    chipset: Chipset,
+    pub(crate) chipset: Chipset,
     revision: Revision,
 }
 
@@ -286,7 +287,7 @@ struct GspResources<'gpu> {
 /// Structure holding the resources required to operate the GPU.
 #[pin_data]
 pub(crate) struct Gpu<'gpu> {
-    spec: Spec,
+    pub(crate) spec: Spec,
     /// Static GPU information as provided by the GSP.
     gsp_static_info: GetGspStaticInfoReply,
     /// GSP and its resources.
diff --git a/include/uapi/drm/nova_drm.h b/include/uapi/drm/nova_drm.h
index 3ca90ed9d2bb..0382a4a70640 100644
--- a/include/uapi/drm/nova_drm.h
+++ b/include/uapi/drm/nova_drm.h
@@ -25,6 +25,46 @@ extern "C" {
  */
 #define NOVA_GETPARAM_VRAM_BAR_SIZE	0x1
 
+/*
+ * NOVA_GETPARAM_GPU_CHIPSET
+ *
+ * Query the GPU chipset architecture/implementation.
+ */
+#define NOVA_GETPARAM_GPU_CHIPSET	0x2
+
+enum drm_nova_chipset {
+	/* Turing */
+	NOVA_DRM_CHIPSET_TU102 = 0x162,
+	NOVA_DRM_CHIPSET_TU104 = 0x164,
+	NOVA_DRM_CHIPSET_TU106 = 0x166,
+	NOVA_DRM_CHIPSET_TU117 = 0x167,
+	NOVA_DRM_CHIPSET_TU116 = 0x168,
+	/* Ampere */
+	NOVA_DRM_CHIPSET_GA100 = 0x170,
+	NOVA_DRM_CHIPSET_GA102 = 0x172,
+	NOVA_DRM_CHIPSET_GA103 = 0x173,
+	NOVA_DRM_CHIPSET_GA104 = 0x174,
+	NOVA_DRM_CHIPSET_GA106 = 0x176,
+	NOVA_DRM_CHIPSET_GA107 = 0x177,
+	/* Hopper */
+	NOVA_DRM_CHIPSET_GH100 = 0x180,
+	/* Ada */
+	NOVA_DRM_CHIPSET_AD102 = 0x192,
+	NOVA_DRM_CHIPSET_AD103 = 0x193,
+	NOVA_DRM_CHIPSET_AD104 = 0x194,
+	NOVA_DRM_CHIPSET_AD106 = 0x196,
+	NOVA_DRM_CHIPSET_AD107 = 0x197,
+	/* Blackwell GB10x */
+	NOVA_DRM_CHIPSET_GB100 = 0x1a0,
+	NOVA_DRM_CHIPSET_GB102 = 0x1a2,
+	/* Blackwell GB20x */
+	NOVA_DRM_CHIPSET_GB202 = 0x1b2,
+	NOVA_DRM_CHIPSET_GB203 = 0x1b3,
+	NOVA_DRM_CHIPSET_GB205 = 0x1b5,
+	NOVA_DRM_CHIPSET_GB206 = 0x1b6,
+	NOVA_DRM_CHIPSET_GB207 = 0x1b7,
+};
+
 /**
  * struct drm_nova_getparam - query GPU and driver metadata
  */
-- 
2.54.0

