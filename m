Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C343C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 05:34:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 731FD10E742;
	Mon,  6 Jul 2026 05:34:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="PhJb9F/7";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012060.outbound.protection.outlook.com
 [40.93.195.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5510A10E745
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 05:34:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbtTQuMonZEnbNtqrlP9LMsDIpI3URnLAoBxP/hv2oN/fhIMDdUyodiK9Xj65EzzYScFPaAPqfu6tD+Lrh38VJo3EAI6Qz1Fge//0iPJ5QQGcD4KXLgklBMyTRwGpNQkMSXpiVJDgK+DpM0+N4NrReRxtnVDsjhonwMy3LBhpIoZ6q4XOygjo0kruWObnAjzJYjq73sZSKCxu+5LKtCYnGiYKptqNH25X/wgslnRFI6OClu7d/YvoIgd0stuz8kP/SEfhljnp4+Us+OmJddEg0v72Zbif0tSL8mPl4cnOB8VMCn9dyf+e185HaAHwMhtAfFf6ZFRmQHvdrDiBw9iOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLAZXBavXag/SXWYsR1tZFJqcAChtS6OCBYHqR0gwa8=;
 b=JKtZidv9VeP+a1dJe4/WMUTMuvzdiZKApAIWZc79NdcM6ZgPTWkOXZko+7X0soszo+5zdTirHDs9/ik2B5fKoCznAHlig7RWre6xaU4cNBJBBcNZXZjxJwLprACobWkA1k8E7K+f15kdvn8yigzmQQqe2WSqLLhO5W4yGFdcqS+dceTRWU8DtPDBj3PVnWK1b6jyQ6wzbIT+6hETUzdtxdvdk7GBwPfG1TgP3DRVfTqOEOdQl5LSrjgrqIPm9j6Yxqp+hCGGO/gEGJTL2ZZEQA5jW9XuW8tVXkz+6VEcdDC2eNUuE3Nrw4VeKPGm2ioLOx7mL5Ol8hpXAAnS7S3dBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLAZXBavXag/SXWYsR1tZFJqcAChtS6OCBYHqR0gwa8=;
 b=PhJb9F/79XpJ7wcM5FehayCzYeABBdrJIWp8L79HEG8BTNoTMcHfetIWy3vbC1IKXNDaPwe8OAIMO6fZM7bZXNF7xaYdUoss97SaLqABem7FQvEiqfYxno4189LpmcB+E2eR/R+A/28jf7vkSSInrxF7ywjQRhjd+EHRKUHhJCjdteNVFTQCVEmnG1yEssrO9JTlUkrgAmooQuPVkhoYecPXCEYaHNR3S2f6BdXyBP3lYxgpQ81XJcH5lepOFfFjRowAw+flp1z78TNOff1ZIW19H3OX3N6gc1HK615lee1fMblbLsh8vG8on7IVIvxGmRbuAa6pVTIJrJ7vC5p25w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Mon, 6 Jul 2026 05:34:51 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 05:34:51 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu@lists.linux.dev
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH 2/4] gpu: nova: Add DRM registration data
Date: Mon,  6 Jul 2026 15:34:10 +1000
Message-ID: <20260706053413.154135-3-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706053413.154135-1-apopple@nvidia.com>
References: <20260706053413.154135-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0139.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:205::10) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a054f61-83c1-4771-1b1f-08dedb204d16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: eyxm+bCDzv14JUemkDzAkRtNKCOuHPxeCj3EwHzg0TS5P6ygXLUx6kCSqkKE0CH39Yfi32BgSyERFZAiCxxXUxyVCWT2mxSu9u5a5IIFTbqCPkf3KwxQ4+r7lt7cTuxeDViuiD8wMbDvrsVfrOCe9pcFlaA03hsgIoupmEXbbfPw82LMt4RMCSq4Z9SOt1uMSKeFNs0DG9IceG4LbiGgb0EaHWoMPJNAZ+k3JDYfT3w4Jnhj9+ihp3/c8z+6X3sZ0dgbWF5tf7J2mjzju3lXLWMu8rYUEZOt3FiR7WTxNmLV8YdWmiSXgn/yub7XCOaDnPSy/SShSAoFwujdhZeZnq3RmeS82WQtzI/X/YcbmoC+BzcReKdANxGuG2lYxFWVfxQGPFV8APyIllg8F3NCz3gdpX8Y1cWspbe/YvBr5XfxovhbTyIbwpcFUWYAG5EIzknnIEX/7r5m6X1bGeXU7FWGd1lnb/20qlIybyr1UFtlcWM+TvQujl/70RMLh/jvvJ9Ikuo7FiCmF2A8fG7JRTZJXSLLhhL22Qxwt0LouF4aVG10vUTKaOQBlZmNJtXBHIyAPxIXSYO5+YX4gsxuP4A/p5tTTTPYDoI8whJRLlFWMNFywsUJpsrsfU3aOhgTVUwHvIVEPkn6OhQEyOeyo2iy721H/5g34JaMtyfjALs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KUwzdPxaNOkEqyzUQ9lEI5+HGjKASyZth2vCeo6uRmzelDBecyCpLiVIYwoc?=
 =?us-ascii?Q?8VkH22D2pecFchR+wpUlzQEly1yNNlrB2llAIpxZbC+u8dZRXpubwxXqS8N2?=
 =?us-ascii?Q?yPnmPjHFjDEbGao/NyBUuvTMpOUobyfqBa0SteIFPbmVKCVbbKd3NbVpNKcY?=
 =?us-ascii?Q?Mh0x5J12DcEDWPlZeI+WVUeu9xlKLsViiXMKOuSD2dTJ8IKASuOmlkIcyYLX?=
 =?us-ascii?Q?Rar0Fq6Dq6c3QMLve3lmNHw04eab1Hj973hp8t5qd1PBps/qrHaNSMaB4e1X?=
 =?us-ascii?Q?iX6zqHC+36ztaVDkmWRJjCSQGT3EjeheohLpCvJhvxkeRzDBR7NQyPZLl8IK?=
 =?us-ascii?Q?+Ly8h7uHL3nv+0rBE8g0cCyqOwUnRUF/82VVMnEZoPwe+GrggkPItch3dQOy?=
 =?us-ascii?Q?AU6CGwa1SQ3uLVT0IUjkkkB/gVwuEE7z6R86n9Up7rrIkpdrW0r2oR9aGuDQ?=
 =?us-ascii?Q?ImR5+ClMmsKIamVvkoS9xSVsrkQjcG4qxKoKWsezCGzVVT0U6SU40MrEC0yv?=
 =?us-ascii?Q?/PrY8C0GRFV4SFhEDkH+vTZJe4E6ecTuER13Y+CDNYhOQMqgBMVjwi1spqBI?=
 =?us-ascii?Q?LuVUE2jszn9QgR5opCI7RCyTjOUQWNpmCH24DNwFDEGUEIycdkbC97yUbLB7?=
 =?us-ascii?Q?gCG6Eu+wkTN3SdqpRQ/mEvvfB61aZtAY6NYQuTcdaIt7i1Vamb50mqhOjWVu?=
 =?us-ascii?Q?ZKbawsVQDOYtGWQdbzxspaIZSl5ifLd3oYcymEh0WWtBwC65BffMruP5Vax8?=
 =?us-ascii?Q?Uw93GnJw+T0p/x4LlUwWmX4ISmgPo6vGNLC7od4unimwwkUrZ0uRVgwsJi0n?=
 =?us-ascii?Q?3h3ZZPQxj7KFoKU+/+08JbgRbidPovl6E0qaYY0q9PAc769eTuFbBUnqOe8S?=
 =?us-ascii?Q?8swJ5JG70/7ys8RVBrtWLYksQ42ie5k6MynV/c1vKKjy6z9uJzMpcaui+ka0?=
 =?us-ascii?Q?zL3BCKlyyZ1g59E0YCU1ht6r90ij/uAS/BMr4l9cp+T5asBArFPIWU+yH10l?=
 =?us-ascii?Q?3fuiDz00AYRFp/HWBgnyxR/oDiloVFEgYaiYLkdsfkQisriAkwZVCyuovI8c?=
 =?us-ascii?Q?3qhosr9haBp8H4ajrZ6slJb1CGTByZlDcUkRjKxim3a5+0B8QE2Nf0iMgdsF?=
 =?us-ascii?Q?DltJ0Jf6lwryUZtgtrwoE4tsAW6fPSn6MKPbJnREUJnQXcpHlEXCwyTAvyI6?=
 =?us-ascii?Q?ED3yq2tt9/UWagzOdl4UkJJvP/xOyNLwasdEzvaZFqIsmTpyLZQANFGV8/PM?=
 =?us-ascii?Q?YZ1hgS+nlEc3CBnUKl2+0M+KR8yjPtre4m76JdiM+fRmIIRJJfKu5ijY4aiB?=
 =?us-ascii?Q?0niwBzckxsy+kf2aXysVQTBRDqfqJIBRn+As5c08cWo1dMLv2pMuIusf6MYH?=
 =?us-ascii?Q?iGynJka8TgWRCxGZZqOOui3mp1xs/2T2dA4Iu84P3XJ0+jUXyGI93Fj31rZ1?=
 =?us-ascii?Q?oUaACwwe6H/MyEtVPOp7IwmWjdcKqyruNRKt3WS8G7QmOBoSV/bocTxieinM?=
 =?us-ascii?Q?qyExTdi4lQsMcwbD/PVk12XukfQhvzEOAxRN1bGyHCL2BMCi8ITSWH70PfY5?=
 =?us-ascii?Q?08yzAZLHbT50H/+PcU/q3kETSnnl7eJ7/TJnVWsXR+zH1IxGam0PShL4rm+u?=
 =?us-ascii?Q?zBO0xoCz0ls1DrBujPzp7alD6bGZHPTQ7WobolAF0HbMYHmicwOK6ofMuaX7?=
 =?us-ascii?Q?zins63d2RkY4SF6sNhrv6b61woYY25hGWE7hfd280zObzS+q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a054f61-83c1-4771-1b1f-08dedb204d16
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 05:34:51.6014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0WANz9Ld37JK1Tma4IQt5GA7Uk5W+uh/nNLUBLZLFZr2rbgp6gyXzv1lLPyEZcm2vX9aI4R8HfUAm7ENwrkeg==
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

Currently the nova-drm stub driver doesn't really interact with a real
device, so it doesn't have any registration data and has no way to call
into nova-core.

To allow for this add a DrmRegData type which will hold a reference to
the NovaCoreApi associated with the auxbus device.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Suggested-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/nova/driver.rs | 16 ++++++++++++++--
 drivers/gpu/drm/nova/file.rs   | 13 ++++++-------
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index 739690bc2db5..3ae719540e4d 100644
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
+    #[allow(dead_code)]
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
index 298c02bacb4b..855b6ffe696f 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -1,11 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use crate::driver::{NovaDevice, NovaDriver};
+use crate::driver::{DrmRegData, NovaDevice, NovaDriver};
 use crate::gem::NovaObject;
 use kernel::{
     alloc::flags::*,
     auxiliary,
-    device::Bound,
     drm::{
         self,
         gem::BaseObject,
@@ -30,12 +29,12 @@ impl File {
     /// IOCTL: get_param: Query GPU / driver metadata.
     pub(crate) fn get_param(
         dev: &NovaDevice<Registered>,
-        _reg_data: &(),
+        _reg_data: &DrmRegData<'_>,
         getparam: &mut uapi::drm_nova_getparam,
         _file: &drm::File<File>,
     ) -> Result<u32> {
-        let adev: &auxiliary::Device<Bound> = dev.as_ref();
-        let pdev: &pci::Device<Bound> = adev.parent().try_into()?;
+        let adev: &auxiliary::Device<_> = dev.as_ref();
+        let pdev: &pci::Device<_> = adev.parent().try_into()?;
 
         let value = match getparam.param as u32 {
             uapi::NOVA_GETPARAM_VRAM_BAR_SIZE => pdev.resource_len(1)?,
@@ -50,7 +49,7 @@ pub(crate) fn get_param(
     /// IOCTL: gem_create: Create a new DRM GEM object.
     pub(crate) fn gem_create(
         dev: &NovaDevice<Registered>,
-        _reg_data: &(),
+        _reg_data: &DrmRegData<'_>,
         req: &mut uapi::drm_nova_gem_create,
         file: &drm::File<File>,
     ) -> Result<u32> {
@@ -64,7 +63,7 @@ pub(crate) fn gem_create(
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

