Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BE2C4453E
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 06:31:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9025E10E534;
	Thu, 23 Jul 2026 06:31:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Az9RuBkc";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A48410E534
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 06:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luOIPu2eWV7IButXNLgtUfO33ALyExk5zLhBjC2v2RDEGZkrhXHep4RMO/DiwJG3uXSxV0Z95zuB9XOVV06TtwpkljNMzga4vKTIXFyOMMK3ovEk0V9irZ5x//92IHJIKqLVFTVoLW+YUWY+/V6hBjS+l/9HIIQ1UEVc+n3hLX/MNyqthFbgEs+NJXN32rDm+ULlzRpYaG3zYsRwFzakiV+iJdqFdBt45nZlSxIKkkYY7sm7f5j/Qxnarqz7PcEnTInfY5xVN+fRNfUHgNUuk96ebf4oUUqH0c3pt2kpE1X5uA6BaESdYms+cK3PLHtdP/ywwL42IkNAzASp/R4xlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xk1I+2BYJc/FOpL1J9e88Rjwpus1GltDuLvYGhqGb/A=;
 b=GarJZq5sMniZQMH1N2hZfYhzegzUjgOR/RdOxcnQoBM1Cp2f3E5D1h10x9XVY6vCxwRKX+YE/2rVL+6f0s8E8Z3tpRX2uWK0JRO1J/roJqV44LeEy9/YHXfIlY55j69ciEJpf71RosP7AK1nxhBu9LWBhATy297ebKEgqCuue3swcZXC5yFP/IYrqGKwo6dDLDCdatTynJfHKroSbgpq4OsyBWwujqVX9WzB3HKMd5lfTgJ5qnfWCeMKZ9kx0ZDUt4M7tucwWXRmU6dRUl6e13hk3uo7C8zDQt3rWOylRophrbmgA+hqGGgNyjheuuErizeKc1bhydIBUqsNviN0GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xk1I+2BYJc/FOpL1J9e88Rjwpus1GltDuLvYGhqGb/A=;
 b=Az9RuBkcRgyGloi5gBgAbd5InKZyltyJOCwQIC7OEDMzRtBaXilZ34e9Dl6LsrtQqd0kleF+PU2Q5fnT2Q4SeXHIVtzVSbja0pksi/TZjSYAAOHJq+zQ5YxTKH0GoKBF7CR6K6OkjEgAPKf5fftQhLMGhi5c2L/NOnK76FzQHXLiHVy/T29VKn6EO+D37YKODXQ24nQ37TBb8OuYmz+6cFG1YileL61VPYDRqtyhNMj2g3+tZCzwSGYH3n4AEpsd9Q3YtQlhThT90rYrxEe/Rc8vAI+vneGyjkJjScgPdkczMUz4b+5pbZgoYtuaXkUfttit06cjESUw4i3c8c1tLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH1PPF0316D269B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::604)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 06:31:07 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 06:31:07 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu@lists.linux.dev
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v3 2/7] drm: nova: Add DRM registration data
Date: Thu, 23 Jul 2026 16:30:40 +1000
Message-ID: <20260723063046.1265791-3-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723063046.1265791-1-apopple@nvidia.com>
References: <20260723063046.1265791-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY4P282CA0007.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::17) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH1PPF0316D269B:EE_
X-MS-Office365-Filtering-Correlation-Id: 1912a118-18c1-4644-66ac-08dee883fa83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DTfwsvTymx3EW9Sha/jiJk+47gz3RQLNDtPXuASqDEG8uspDBUIr0oK64L0Yt0xRn2AbzURm0YkyFjLc836JqbVYhs0MS1Ou2dB3OEKOikflXSvFxqxNmvZ590iUU3UZk9TlSozoz8NXIiOLOCkiOIYk+z3kkLn+5HlhoSjMpDzm9kEudx5Pd2LOXEwSylzltNHW3/wqfQM2AkSOtLUirOLcCTZPn6vhjPmtShh2X7uOSrna3U5h6NeWLzqENOI84VDH4fRyk/Zss9I7/lizERT/cQq4zbzC442MKLIitlippQkkFcJ03anuA/gyOnsLJQUW9f5pRQGCvi2vJQkoECBHYl6CQZcPRWKtUxy7ROvZFcOUZn1Ijb9qIZsFsuJTnbJc+QSyh3Jg1otyk26JooBBAfA1eMx1OdxN++NRNDouwklt7lG/vReJ2URHsro2bkgFvaeAV5dQrGroreXLTtSSn8tn3OBVE1aGn83kglqJzzwJ6/NabFFOF5kxsJDGVQKoQG5mcYUzN0upVU1KkY8pgD4dpKATNfQ8e19jl2hoJ7VPF3Y/E+Lf1IsK1y4u3fnZos4RVyMy735uTgLoZhY9FpN8lix4mF8tZPSteQrlk7VyrKAkLBQicmeTuYywy2TLkWZOLhR3g9+cxT/GjwcSsdgiYbdlHIup1qWBfBs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EggJ9hQ+M2hGlQt/VS5+koLASvpfeGg4JBK49OaxmKxrPS3u5GuTtVceVqVH?=
 =?us-ascii?Q?SmAQViMqS7kMyE/xE70Vb2nKCMIsiGUVxIocvcKG6v8uHM1J4s05LF6Pfv48?=
 =?us-ascii?Q?V4nR2CbMKytqZC1cVuuG+dMTeJ3kX+J16VRAHfQZnHGhDTQ22VrjS7DB4FOU?=
 =?us-ascii?Q?ERosFztLum9RDyMraOYyHnqgIhSjAm7aTXZIj+jva5FPbDfREVbSNr4T/gws?=
 =?us-ascii?Q?+aGKbLJZjevf1tXayex9wEYKoElukuP3Sakf2wHEueNOPcsDX8A41U4aY4DI?=
 =?us-ascii?Q?eub7/uT/VDP26I1tVSjmoABtJ9SKCjpK3fV23mrMpolFvuFuiSlqjNApZ6u1?=
 =?us-ascii?Q?+a3k8X2grZYzYVR2cXYiZ3lUinKQ9HpLV7WleuIV3Sdj0CnEpbn1rrcOyEPs?=
 =?us-ascii?Q?XIWMKQFFFmpSLR3mHoSmkHj5TfzFA1o2dlvbe2fbuG913c3asGI3CNrOg3u+?=
 =?us-ascii?Q?XciEs/cLk3eBs/+XJYLzhzRVVv6zBRXfmEvjld9yQ2o6PFBI1vMu91bF9DgI?=
 =?us-ascii?Q?zRK7RzV0Tw2QT4P1FWZitryiOZyh7YsmUTuod9kMdjYOWgTkWcY0QxaEKPNR?=
 =?us-ascii?Q?0wCH2tgI0me/mArZKUulRnRTXb+Rr9FQHx4WeN88BqW5aJZesyU2XtuPU/YD?=
 =?us-ascii?Q?hQzfdNROpXFz89xe8qfcMk7TCor9W2jPWloQzroKubNn7y4wRNmESRQTYtu5?=
 =?us-ascii?Q?xXpAAKUIMzkEIMi8NZtFpZgWFv4JPXEeI83Mds7RzIIn9qIWjffRT+6w/yrW?=
 =?us-ascii?Q?F5eFDg/hFL25OqyHs53AdrDPXxJkZ3OMV/4omIX3cr1eEU0JLauK/Sj65pca?=
 =?us-ascii?Q?kEa9sQq0dvml/jqgiupgTatqgCEbQRVrWunGkWBYGsAh0KimCNMBTvzuf6gT?=
 =?us-ascii?Q?cri34835Jv1z0+QU664LSrrnP1QzO5W9Z+SCQsJg6MnTal2VomG7WUiurMlw?=
 =?us-ascii?Q?T+Hq2Eak6Gk9AeUZ1dtwU959OpfIUMAf/XjC25nE/Asble+QxBrI3/7dD1F1?=
 =?us-ascii?Q?imbP8hPkRr76YySUCUzxL8D3KHVfuIna3BZYdqs9nepS450D3slwV7/JyOK/?=
 =?us-ascii?Q?WMHr5ZpoC8Uh/IZgsPs5+J2Js0M0q5w6E8s2FMfaDS3kcT/zNCnkn7+Sg9NZ?=
 =?us-ascii?Q?Gu+iTkwo4xIz4vfyWcjzmIndnDm/r8SzXS/IAsd4Q004Yq+feh6GP9PlRg1A?=
 =?us-ascii?Q?99a84NpfOFTxq2YYhrgM1ZTzny/KZsWVQrarOYRe45s6hmRfeK+YZR4l0NU9?=
 =?us-ascii?Q?DsbsgrCLfYemdgfpojsoH1dlXlVRGkOnae/Adm3AJq2FMRJt8dYIBjVUQiV7?=
 =?us-ascii?Q?vo69lGUIhfatYoxhRQUsXeT6oe2wZGViOAmJVuVEhr4PZbvggM7M2kO03BMU?=
 =?us-ascii?Q?DVHYa0/o7pwVTnpxgnOLj8k4ZuCaB6umRjYifL8cPWOikohHaw3lR83vQyX2?=
 =?us-ascii?Q?sqigEivxE8QWh8hUMVfAg87GhIM+iWVLm08kjnc+VYmx6PZBCVIvr2DBg2fe?=
 =?us-ascii?Q?ekkxES/KfoYo6/b1rHRJo9x+cFo2JOkzH4Z3uVN6aLX8x2rvsxoFm7725fqy?=
 =?us-ascii?Q?9m8CZsj9C8tkwgLvpasG9nnOIZ51DqCIhQm6bmosFEdGg5sEvms2miB9NkdA?=
 =?us-ascii?Q?truXeEtQf1WgPrY0MdmogVY6m4+7IQ/e1juTo1vWxl6Z15fIvkIcDHALCuzk?=
 =?us-ascii?Q?3hqBcMrwKmJ38aRXGrPsy434y++hrVbPUuZ+bCfnQBmsG8bxUdHbEIa1Mphh?=
 =?us-ascii?Q?ncVTUXxRow=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1912a118-18c1-4644-66ac-08dee883fa83
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 06:31:07.7404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkUm0JiGrtJ2jFxc0ppG+vvGFLExvIZgnHqQbB2TowNimm3Fokp4CWb8gRHj8bmBMEBl86Al2lHqaEMS5uDbyg==
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

Currently the nova-drm stub driver doesn't really interact with a real
device, so it doesn't have any registration data and has no way to call
into nova-core.

To allow for this add a DrmRegData type which will hold a reference to
the NovaCoreApi associated with the auxbus device.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Suggested-by: Danilo Krummrich <dakr@kernel.org>

---

Changes from v2:

 - Add newline in crate import

Changes from v1:

 - Drop unrelated device::Bound removal.
 - Switch exisiting import to vertical style.
 - s/allow(dead_code)/expect(unused)/
---
 drivers/gpu/drm/nova/driver.rs | 17 +++++++++++++++--
 drivers/gpu/drm/nova/file.rs   | 12 ++++++++----
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index 739690bc2db5..632137d1c6d7 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
+use core::pin::Pin;
+
 use kernel::{
     auxiliary,
     device::{
@@ -18,6 +20,8 @@
 use crate::file::File;
 use crate::gem::NovaObject;
 
+use nova_core::api::NovaCoreApi;
+
 pub(crate) struct NovaDriver;
 
 pub(crate) struct Nova<'bound> {
@@ -26,6 +30,12 @@ pub(crate) struct Nova<'bound> {
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
 
@@ -60,9 +70,12 @@ fn probe<'bound>(
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
@@ -74,7 +87,7 @@ fn probe<'bound>(
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

