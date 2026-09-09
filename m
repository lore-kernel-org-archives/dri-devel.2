Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B38EC79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 918D110EEE0;
	Wed,  9 Sep 2026 06:45:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="P6bzWKgn";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012069.outbound.protection.outlook.com [52.101.53.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 161F610EEE0
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 06:45:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqQO1XITeG3pXKG15Ix6xA27d7vnAIRKz+SRbvbZ9C64pTMS6c6RofvNtp+lYq3n2zBQbMi5oyML5SPIBJgamu2uAZW58WI1GtYHUhftep793U1lcWNZUhL4+rl5jN/9CX8kYG33Qw+27k32rLWUZUcUlnTflqDmoBxEsAAH3PfP1K7thm+/Jyz04MZQlCdiTT+foN0aRnS/oracQVdEQS2yoGGPvdB2N4nAtPfKDHSKZHrGUn6DAX+zeZx/FR87dPr+drbnQ1vhreoDyYas9qSTa9kTATxtIfwv2JrB8e2QgqW8Paku3rIhShg3wXx3Dx6pTpNlvde/d+iIdtSqtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4s2N8qZRYwMabMPeIeuCkmoMlV3+WIF05pnizA7wEE=;
 b=fWYb/XZ7VyGJR3r+mEZOMD1DJtzT8RelCXVBz9jdIxqHeWJbD6goiWKDmIxD3O07wz6SO1CaVkt+qe9HoRrgWmFyScObP9QdNEtuvX5sXvrn3uXHKwuWvOz2EZc7qsfBNogrHzbioGEtNybN565+PmxzVNYO0al3Vuc8hH7k4Kr2Cf3kn/8JMYPf1dnuCVxoBbmKtLD/itx8zDFJqkX2xVLGfLWEEBpnue9JmPjdae1Zf3dT6LVBaLRNOFUvz65eaIV+eRJMgVfHJ9sDoR/hX+lywEGK6iQfbuMauWaVqekt/MHQulvG6ez+Xqfkj12rPfXDJoNIG2qFj+m4OxEGPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4s2N8qZRYwMabMPeIeuCkmoMlV3+WIF05pnizA7wEE=;
 b=P6bzWKgnPxhClzo+pQ+m9yiMHNmLSBTVh5BSvTI/Bm6V+x4/qyDLWugFwi4V/ReZNLbQcjqWnzQ+w6K7g63izvRkRMtVJBB4wqCvcpUPjpBEvvtcBXthC0WYyEuhXC42PD+9X/RE4t/c2GzWew4iY5cwZNFjPlTQIMmdlDtSgYHdhbcYJW/DbP3ydIgJIBsAV6wCjJIfNGe/gdq6a6zk1dGdWziB+XgNJUS0Iccpq9fZR3ZqJkRfDdaArTzOPFUv+RB0vlFw5AKnsK7rkkNij5w8pTi6H42RfQLyK3YrK7+N3afW1qCpPs4gBgyShI0UxX4sRskRq/Lx5kfEQ32sDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 06:45:30 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 06:45:30 +0000
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
Subject: [PATCH v6 03/13] drm: nova: Add DRM registration data
Date: Wed,  9 Sep 2026 16:44:56 +1000
Message-ID: <20260909064506.910162-4-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260909064506.910162-1-apopple@nvidia.com>
References: <20260909064506.910162-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0020.ausprd01.prod.outlook.com
 (2603:10c6:10:eb::7) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|IA0PR12MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4d89e8-5c47-477a-b2a3-08df0e3df0bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|1800799024|56012099006|10067099003|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: LmnwNUj/CGJAAdRpJTdE9cBxgScntUMdOMFA57PmNyFtwSesr188NFaVUsPnUg2b2xv7bJJOFqBzayPBQSJ8Thi7LYZG+lN5YjEXljWAZcKAYK1ZpwhhNQLcmPUVqQ2Ef178WhMeCkBYeVBgi8TjEKz9MqJ9TR2DEWBv91fZoY8VERCXKtmt/FVZqvOTjW41IGEpMN5WrsnriTfnl7NhS4L25KeL0GM0FsAzPSljdYkYuaiwEb0sk95zRrZkd0349ZeFYEkb4bYXsHz75SDR2fpK6cmeh1DDFDpK4l+OIJ0NsgevB1xxBqmvg9pFbt97166BwNc8pTShF+VwmpToeOMxBeJsuSXAA4tpMIz9iVaQatOjjg5F+Suu3b4ZwBWzxh0YWg1O/91TjnY1W7E3oQ/LOBTXlvGYYIcmLS3f/+1+xus6+bdrZK2wrE5qmLsNvR2BwLBrwZfVtQUF7zuR8D8nDgyJtpRXV7WhkhvN74xAkkeQZfSK3Rm9iPBIdXkcJOcTPthCCIjVXMLaXjDamgXLR2QKoVRVIyuTOAzaiw4IQcJ7VqMh0naPGWCimGMfUTA8EfctmsJuDr+WnDSVD3Yly1aAptW8B+m47l2KepLRJQ6RpskAI7N7F3zaWVEPV4Oldn+iWWb5isdD1HP0mhVoa7ap88EdZBUwma3Q+S8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uvw8rm4F+aS2tc3RUH78162Skiv+IkQFF/imWy35sZQHa5Qj7b79cBbPhKvi?=
 =?us-ascii?Q?iyHfF5yu2XOt/yrAwsXTnqt10+8D09080Y+GODl93eX5BFMpk/PTamqq3omr?=
 =?us-ascii?Q?hQ7NbwqNJzQFlT9Ox+2rMg/ivDlfRDXR/wYvTxsLEbOJkxdfv8VVgUDn1aCb?=
 =?us-ascii?Q?tN9zk8z69b5OZ3F4OsBN4jkYi3aO1kOoyI+v95g2jDfOaunzKU/Bc0+bxjrO?=
 =?us-ascii?Q?DNp6KPyvJ1KFHJGn9VpwNrZTLsZuCAH5gbM51goHJwR+kCEBswOsPuMW1Z/5?=
 =?us-ascii?Q?MFgCqGoGGSOhPofHlrGwlpWSpeRwZqkX1NL/hTHiz1jHRpvzlRpz0OcFUUs4?=
 =?us-ascii?Q?S44LUok3cnSpS6iwlJcw2U13KumlAQpdeyoCXycylC22LsTH4lItE3n2Lfx7?=
 =?us-ascii?Q?9t3K5p+enQFzSQTVfOoeVIfVqYnVQkk9zPtCbR1829IExOG7XaydNVWj4BQE?=
 =?us-ascii?Q?8YGdkhJpu6EF22HOaWN/YNoVv+D7N4fOb8UDypzHN74xMla1nxqVuXQEBbDQ?=
 =?us-ascii?Q?Ok1Oh92v5Jn+Bml0pWIPkqxoxgAM8B/bEQino0I0D82CpliryPYGgHH1TWtZ?=
 =?us-ascii?Q?P5+2pJiG+Nx7cqi+VIe1hr+fo8m/uO6sm8wTmJgLjU3XgpHHepf6Vhs5rQ8m?=
 =?us-ascii?Q?W2jFypLpFoYbWSQI6jPm6wrfEZnZQGkufjJKRlyaZj3/j+RzjoJO1hGk/m0z?=
 =?us-ascii?Q?jo7QlaUeO0RM4NIBda/UswmLZVJ9pWExU0b8OQmBCG38eT7DjrV+ljR4ROYE?=
 =?us-ascii?Q?oR4vIKuBHkwO2xQ0pMmCwI7sq5ZD843nB3uBM4qi5lU4VCdgAqA7nXGsWpom?=
 =?us-ascii?Q?FmXkMg6PubX6BAKrimqYBnJG9iISA4rnIoDu6lcIYOX46ttF/xMp89ffouQt?=
 =?us-ascii?Q?7fTW+iGHQplIPNbTmzz9SxxFLLJKxJ0oahT5DhcO5Kaxy6dABzvQsCTWyICr?=
 =?us-ascii?Q?24dhEHJhMSil6v51HmZPKxun+wdob+GMbqZVHz9TvN2jEZRNtJUa8/qYNCTM?=
 =?us-ascii?Q?m7MThfP2DFG/h71BshmQbtSLQimZyT3E9cA6qCes6M3B/3D8csuP63gW2Bpa?=
 =?us-ascii?Q?KHyPhs2cAc1ey7AaysoorPEL+rHs9XVA4TLE3FQTeGFH03OaOVn9rA31QUQv?=
 =?us-ascii?Q?IegmsXYRDltvbnUUP5ATc5a+MPL7CaRz6wwUfFUqV4+ngozuQHkwBlZwu/zb?=
 =?us-ascii?Q?7yJqiFEfy9AAo9Vt7XPoz5DIsbrFGCBX9EZda0mSmahGcpZByW/Q4apb9JNu?=
 =?us-ascii?Q?OlgWv6VFwRnYH1fRghpwy4b3GHA3B9IfC75+oCydBr67rV9PB5PuJE1I9U3W?=
 =?us-ascii?Q?+nFyrWaPBlFhjfH2rHysUGu5k2pAgQDa6zkrDi90lXKG8idPOjSZILf8fcnC?=
 =?us-ascii?Q?+Qsg2Kr1QMA2IHpJQm6lUas7R67fWozQvQzrJr4yXWgGmwm7EpCwPa2Aoek7?=
 =?us-ascii?Q?OG7/t21DOFAEmVW28mmMWNmLf0+nPYqFbeUUtKDnYL7cJLBhUvXj0alNk9m9?=
 =?us-ascii?Q?WwB329RtPxdaw2Z6DQOxM/QdfyTwAFo+eEkMHUaeT8zcz1scnoVHiUAJR7wA?=
 =?us-ascii?Q?dBFWukuyAaoJ8S2AcUoSoXagEVxpgBBz0kG+9AJXBZHGmKy1yQAfj3S93VWB?=
 =?us-ascii?Q?oTVJkPB9KylZ0jstj32IZVQlzP5tF4dBkgujJrX/I586zPtitFRK7EZhHS+I?=
 =?us-ascii?Q?88fwNa1XQ6E2dWGzgc/DkaJtNZV5bGitJw/eDkOat2Vo3wZEgq9w37Sb/9ws?=
 =?us-ascii?Q?1hMBvlJWAw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4d89e8-5c47-477a-b2a3-08df0e3df0bf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 06:45:30.7686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LqHqVxHyc8Ui/aVrrGT9AYem6/kWaTNB3ML6wtygXbyNcv0TPVJjdoe3czZ70rFNT2V1f+PAIYze9ssJL5Kz9w==
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

Currently the nova-drm stub driver doesn't really interact with a real
device, so it doesn't have any registration data and has no way to call
into nova-core.

To allow for this add a DrmRegData type which will hold a
NovaCoreApiHandle for the NovaCoreApi associated with the auxbus device.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Suggested-by: Danilo Krummrich <dakr@kernel.org>

---

Changes since v5:

 - Store a NovaCoreApiHandle rather than a reference to NovaCoreApi

Changes from v2:

 - Add newline in crate import

Changes from v1:

 - Drop unrelated device::Bound removal.
 - Switch exisiting import to vertical style.
 - s/allow(dead_code)/expect(unused)/
---
 drivers/gpu/drm/nova/driver.rs | 18 ++++++++++++++++--
 drivers/gpu/drm/nova/file.rs   | 12 ++++++++----
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index 60752bccddc0..52550e694729 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -18,6 +18,11 @@
 use crate::file::File;
 use crate::gem::NovaObject;
 
+use nova_core::api::{
+    NovaCoreApi,
+    NovaCoreApiHandle, //
+};
+
 pub(crate) struct NovaDriver;
 
 pub(crate) struct Nova<'bound> {
@@ -26,6 +31,12 @@ pub(crate) struct Nova<'bound> {
     _reg: drm::Registration<'bound, NovaDriver>,
 }
 
+/// DRM registration data, accessible from ioctl handlers via the registration guard.
+pub(crate) struct DrmRegData<'bound> {
+    #[expect(unused)]
+    pub(crate) api: NovaCoreApiHandle<'bound>,
+}
+
 /// Convienence type alias for the DRM device type for this driver
 pub(crate) type NovaDevice<Ctx = drm::Normal> = drm::Device<NovaDriver, Ctx>;
 
@@ -59,9 +70,12 @@ fn probe<'bound>(
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
@@ -73,7 +87,7 @@ fn probe<'bound>(
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

