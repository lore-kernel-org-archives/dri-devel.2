Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1802C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 08:52:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2F2510E43A;
	Thu,  9 Jul 2026 08:52:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ThNWfNim";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 833A110E43A
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 08:52:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQeayShuzyZcdoE9MQ5HigvqkeDSNlTRSt6GfXMKJsLpiMKS/lMJKz9lKJ5CTTyV49s3whWceLqVbJqLiO+pqvc3I+zhgy8ZH/RZRQ4MwU/qvApSmrAm3k8GT4RsYAjLw92ViGw5C4bDXpgqyDNCjnSNCIOJNDtyswOBQH4RNM1XwPRistg4KLFKIpOOxCWC3qlVaZUxZYKdaC66ozcJBshJQZ/fw/Dhc+h50WpliugIbaFlh7xhfl4lnPxFLAylN4Ajuz1D8+x/owjQqjIuySjf3TfMEDBiiE/6zTfIAxpc8kCjmnQGfmWae21Y3lU8jSjJLR9dbhkceeZVsiZhRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BS8DKNRgRdZrMnrwqXtR6zr9kFCAYaWSs/WN/eltBvA=;
 b=m8XBu9hs6wdFN/YHqd3mG32CyG+X4oIivKyaZX7SKVNQaVXjuRkQkWK9VTL0Rxaw73cWfNM0Oa28IlmAU1pNUMDMoAe/w/1JzrV+22c7U0XOJVwvAJZtgXITRBS7yiI313u7T8yW34Gvto+049vk1Q0713B+Uy48jYuqVAWWXy4z2OqPCc9oA+Ism+Fkq3ScPbVA7ps6tnDxSaFQY7TRJH4vhfb6UGCKD3JOqPj1lMJa72vxRRO6bwhLliSmCfso1pcDa8x2Qc6W7isLuZXXM8RMbbgZengeeo3fb+Z2pNA8I17/RHUufefZocUIYwSPukLKFCiQ0922dMnrFaSRUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BS8DKNRgRdZrMnrwqXtR6zr9kFCAYaWSs/WN/eltBvA=;
 b=ThNWfNimy9knmaY+bGU8RRxx4lrJp273PJWloRU+s0peogfZIsaAGfprVPQofPyUZolqvZ67C0j695/5wyn/Rd7VbP7myyVWbUZbcNcL51I9lagQj4rrQyMFeXR2CiizlG9oMc32Pp9k68yxW7mthb3PCo9ogEDEUuGemvA6md/5f+9o1oCkZ9BWMbs0CCeY5ACQgmPZs52s1Lsz0oodShz5jjOFHXDpusQKVLREJd+9n0XyBMeZaYe9LuRH3kSfy12C83f82/5mDif3SHPnlCUNh6CZy0U1onrM/J4yO6xDRtdJNDZTax0gGCoVHGOieZol7KBoTz+DDrd1pdHG7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DSVPR12MB999283.namprd12.prod.outlook.com (2603:10b6:8:41c::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.15; Thu, 9 Jul 2026 08:52:23 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 08:52:23 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu@lists.linux.dev
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v2 2/5] gpu: nova: Add DRM registration data
Date: Thu,  9 Jul 2026 18:52:01 +1000
Message-ID: <20260709085204.565159-3-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709085204.565159-1-apopple@nvidia.com>
References: <20260709085204.565159-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0104.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:204::19) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DSVPR12MB999283:EE_
X-MS-Office365-Filtering-Correlation-Id: 4656ccbd-27cd-4e26-024e-08dedd97646d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|11063799006|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: OUI3ZF1atyLAk7xw+pq/8j4Cpqix2X4xvtbuXPCBVDHoy+yEgVLQ8YBO43+aKYqqS6UqSwoMMfrTGT8NYKn1bdmcLvSncWt/5AZLQOu72m9RXkZoHdzKKCALhHxgsGEMAtusZhQPDXlSR9xyxDBIB4Qh07Du0gV2IvuHtOAGz0RIEfBDOGs0nqdyGfBVLJ3J41HeYgA9IZKxQ/I93QiJTJOSvbgXJY4A6Ha83+LSfIOzWkomQf0aNcQQWziGFxdbH4Wm7r49yYgrst3bFqjnf7M8KbjalIL3Jx+ekbf3tshUd1mVvTJzWsiNHOVeaf5qlMKvARyv7GQckOU37by5diHFNbnBgUoS2nKsLeq3V1cJXdVSTuNbD4EyeKs3Pho/I36X0J5cLqndGg/B8zBX7ce18KDFn+XD+7UlHWq3M9oQtcW7cP1JFTK1YZI3EtOgSeUncczU1j2h4lntnImQyhCjUyE/vKzH5R9uZocWNPdE6aW0Kv/m0iJR9O7p82to+t0waRH5zXxVYl73JBfz+HkOaBq2+ZRf/eK5+U8u/eIHX73PY9xHlOY5U6iGiuBd4bbxM4dsJB3oUcf3vOCl99zRkUzGrLqQijmNXjeODZ9XU6xmBSYnw5K5jL4sNXIChBRQ95BmilpFdtepn4UWcevd/ikwh9F4B9KvhCPLBy4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e5l2XxEaLHTIZoxiMNB3ZgoBoWHbVUbJUMEvs10jd4NW2DqnIlzmQ8weDNqC?=
 =?us-ascii?Q?Xp/Mf0FKNRqiFpmV4qEg9FibCCq0n6RlbZnu2NLLdCfh4T/kbToY/NdCA+xx?=
 =?us-ascii?Q?MjZbX65GseVZLAt3u4S6HuEzl4n4z+zbWckNx1OTEDMEdx7i221ra6YFXTYM?=
 =?us-ascii?Q?+GvCONWFOihZXL2F+/bgbNjGNO19gti7nTEPyuIqxyQIqpYQ68Xha2JEez0i?=
 =?us-ascii?Q?NnFR3KlgFy7I+NNcSvRGgwGrVJFegeIqk5UJrfKbSqAiiuz8SJokXFReu5zG?=
 =?us-ascii?Q?T5v6GM2qxy1smBCHZ9xVe5AMphJlnnvgXggjrPwvzp5GB+MZVh0qW1QZieSE?=
 =?us-ascii?Q?A2rPQ8bSeSg8pxlvqj1CSUpt3MlrZ61gsbDL1jw9b5qL9tVxbeKVzBE4V94x?=
 =?us-ascii?Q?wDEcssv3bMKT/vKIfHwwY7ptr4BmpezE0wl/w4cVuSi9VOtjC0S0DXxT+N+V?=
 =?us-ascii?Q?Ax1N9KPbrdU/ZdBPWu6mQjG2tKJ8Vu62tuYxtI36EHZ1Pu9lUdxGalEH2jPF?=
 =?us-ascii?Q?YBq1DNHR43oskfgYfDC09lNvQbBpIXTetOgb7dhjq/Et8agKHcBGhDXdRf3j?=
 =?us-ascii?Q?lxt+27sx70m/J3SaLuo/ElMoxVqI6QIFkHRQuhIKEFXaU9Et/HvwJmr7HdU/?=
 =?us-ascii?Q?LdWvScU4g3lI8uVc8beWlX0ek0NMz+27kBKzpvN3lDUGbG167B3sxezhwUNc?=
 =?us-ascii?Q?sKA+L5rtAOFKXmhoATJk4ggMT1+sON7Y9Z05zLWC+SFD6JpJUA81HbRmJko6?=
 =?us-ascii?Q?OVxqfHlcwfcfLMmXq8H5Ao2nSYVfp1t47YcRWj9dEzWtAakpOcET2pclLQ8f?=
 =?us-ascii?Q?vo0EjklqElz0lLLlD/bkdE/HjRbbvQbJoSUWh3egtVzhm69iRG63xBguX0PM?=
 =?us-ascii?Q?16MJ7xmVhnDPBnPJ+m1hzIytqzA1MBtVRUIsxMDzPQTd0guqQ9d+H4dGq2wP?=
 =?us-ascii?Q?0kQawq5rHhZ6BI41Lj0biWtKJ5fTb54kmZFPwPa9o7qNdm8aXH+lUGON5818?=
 =?us-ascii?Q?CElF1F9GX0mRfdqg33+3n05GnPN7HRoOInuhujWlhqnIHpMh4tlMGUrV70+T?=
 =?us-ascii?Q?oVFOu1j9IU3NL8/q5RXQ9N5rIZCiN20iddi25ghGwhsFAQkc4Kh423pvJtIW?=
 =?us-ascii?Q?ZqinpCNXeYoj9Ihs7a86yHOPbWc46yGNkljED7FkckOwI7x5/BS23o8V+iIt?=
 =?us-ascii?Q?1bf4jYH7S0Rx920qQSj3ufuPgnzR6i/WrHV7MepCJomstt+PQTVhE2NReZ1b?=
 =?us-ascii?Q?+UwEvdkhqNIOs5VjBwTavbsKgajYntWdBoaMJ7BTgw+AHySYPdzmZI1rhJQv?=
 =?us-ascii?Q?YGJPLvUQ66EMRQ50G/aL5S5Jj93KjcLnIWBj4+PpkU+QsDkjAIzmYP6uics/?=
 =?us-ascii?Q?TDmv9Fxx37fw3p77KC9lejQv/v2s1MY3WeI74IMFSpCfiOncn7pBcVaAKUFr?=
 =?us-ascii?Q?BM97JJh7z6g6WX4+2rgZMkZTsvbWgY7tkRlpWwfDuSGaQNkMUFTg9H49MHEm?=
 =?us-ascii?Q?lHEHvkQl7Y/g3Lj0BHGSSsUHPehhWi8FF1SSjomCs4Sz00b6RlwP0QpgyWC8?=
 =?us-ascii?Q?1HczcD1HDFU8Ep5QS2xwbBkDKB0BP8rIFYq0BNYV89nxvNh3CDOfOnEl4Hra?=
 =?us-ascii?Q?HJbNAFFwf1uy2RNFxKsLJzDGyfzluO3r9hATJm8MgdTwv4IAXvyCg2Ot02Fl?=
 =?us-ascii?Q?OChv3B9J7aji+juJLiO5a/ZuB8YEKsTqkD75oeUzwFYMCkvhTrSwXAlHdQcl?=
 =?us-ascii?Q?QhDLB27o1Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4656ccbd-27cd-4e26-024e-08dedd97646d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 08:52:22.9406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E0PQXQCqkGTgbtHm2jFVbmP4ClGcWfUCHfjLWg/8upeDzON4xB9wP9j+/JIAYxjcCDq1I1hsYtpyBBhWrapmdQ==
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

Currently the nova-drm stub driver doesn't really interact with a real
device, so it doesn't have any registration data and has no way to call
into nova-core.

To allow for this add a DrmRegData type which will hold a reference to
the NovaCoreApi associated with the auxbus device.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Suggested-by: Danilo Krummrich <dakr@kernel.org>

---

Changes from v1:

 - Drop unrelated device::Bound removal.
 - Switch exisiting import to vertical style.
 - s/allow(dead_code)/expect(unused)/
---
 drivers/gpu/drm/nova/driver.rs | 16 ++++++++++++++--
 drivers/gpu/drm/nova/file.rs   | 12 ++++++++----
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index 739690bc2db5..0204d1cee6a5 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
+use core::pin::Pin;
+
 use kernel::{
     auxiliary,
     device::{
@@ -17,6 +19,7 @@
 
 use crate::file::File;
 use crate::gem::NovaObject;
+use nova_core::api::NovaCoreApi;
 
 pub(crate) struct NovaDriver;
 
@@ -26,6 +29,12 @@ pub(crate) struct Nova<'bound> {
     _reg: drm::Registration<'bound, NovaDriver>,
 }
 
+/// DRM registration data, accessible from ioctl handlers via the registration guard.
+pub(crate) struct DrmRegData<'bound> {
+    #[expect(unused)]
+    pub(crate) api: Pin<&'bound NovaCoreApi<'bound>>,
+}
+
 /// Convienence type alias for the DRM device type for this driver
 pub(crate) type NovaDevice<Ctx = drm::Normal> = drm::Device<NovaDriver, Ctx>;
 
@@ -60,9 +69,12 @@ fn probe<'bound>(
         _info: &'bound Self::IdInfo,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
         let drm = drm::UnregisteredDevice::<Self>::new(adev, Ok(()))?;
+        let reg_data = DrmRegData {
+            api: NovaCoreApi::of(adev)?,
+        };
         // SAFETY: `reg` is stored in `Nova` and dropped when the driver is unbound; it is
         // never forgotten.
-        let reg = unsafe { drm::Registration::new(adev.as_ref(), drm, (), 0)? };
+        let reg = unsafe { drm::Registration::new(adev.as_ref(), drm, reg_data, 0)? };
 
         Ok(Nova {
             drm: reg.device().into(),
@@ -74,7 +86,7 @@ fn probe<'bound>(
 #[vtable]
 impl drm::Driver for NovaDriver {
     type Data = ();
-    type RegistrationData<'a> = ();
+    type RegistrationData<'a> = DrmRegData<'a>;
     type File = File;
     type Object = gem::Object<NovaObject>;
     type ParentDevice<Ctx: DeviceContext> = auxiliary::Device<Ctx>;
diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index 298c02bacb4b..1156df51c533 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -1,6 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use crate::driver::{NovaDevice, NovaDriver};
+use crate::driver::{
+    DrmRegData,
+    NovaDevice,
+    NovaDriver, //
+};
 use crate::gem::NovaObject;
 use kernel::{
     alloc::flags::*,
@@ -30,7 +34,7 @@ impl File {
     /// IOCTL: get_param: Query GPU / driver metadata.
     pub(crate) fn get_param(
         dev: &NovaDevice<Registered>,
-        _reg_data: &(),
+        _reg_data: &DrmRegData<'_>,
         getparam: &mut uapi::drm_nova_getparam,
         _file: &drm::File<File>,
     ) -> Result<u32> {
@@ -50,7 +54,7 @@ pub(crate) fn get_param(
     /// IOCTL: gem_create: Create a new DRM GEM object.
     pub(crate) fn gem_create(
         dev: &NovaDevice<Registered>,
-        _reg_data: &(),
+        _reg_data: &DrmRegData<'_>,
         req: &mut uapi::drm_nova_gem_create,
         file: &drm::File<File>,
     ) -> Result<u32> {
@@ -64,7 +68,7 @@ pub(crate) fn gem_create(
     /// IOCTL: gem_info: Query GEM metadata.
     pub(crate) fn gem_info(
         _dev: &NovaDevice<Registered>,
-        _reg_data: &(),
+        _reg_data: &DrmRegData<'_>,
         req: &mut uapi::drm_nova_gem_info,
         file: &drm::File<File>,
     ) -> Result<u32> {
-- 
2.54.0

