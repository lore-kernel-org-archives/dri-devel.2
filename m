Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D2AC5AD55
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 05:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C79310E284;
	Tue, 11 Aug 2026 05:07:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bx7tLMlq";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013002.outbound.protection.outlook.com
 [40.93.196.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BAE810E284
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 05:07:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOeMC1vBBknPYgWQvQXcxTmMFbDqHQRxh0/hKllLN+FAb4s0lfwtpO8pyo89861lEHue1epFOwd0upUhMqF36slqieJrnnH3xPGaprxqGItVn1DaB9EsTU+btIgm/xb1Fc2vRyXxcvFoLNyDm1ocSRNtAfh6VMdNX3O97bQtIB//h0o6tStk2a0GKfEqwraKqV71i1sTg3ArJqRUJgECtThTg4OwGDJJqOFIFPSq3pPvB/JdrLqD6cKdL5eEGoUnVjcXyi8NcndTMkifeu7MCeyRNjJNRzks7GA7sBEEcK2pxBxycvTk30RnskzB66l3erANZ5YOnS6wIJBOXAZwbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xk1I+2BYJc/FOpL1J9e88Rjwpus1GltDuLvYGhqGb/A=;
 b=JsQNU0BKziA271p2X6oELfmKIo6LQl49UTodzT6p2YsrveIlzTyH+H2nnQaJg4aTynD/U5ZV7bXYwFsUYiUTqeOv3pVz/AR5fxDMz6QlNO9g2+Tqp4DAatv6RoZm5pzvkfeS7KqPWkFd45EexIEJrg+jp3ne6VdPYw+sIYeOREBfFBzFRo6gq/usjymU5y42oI3HTMkovQNGM2BHGZKYIDzsrZZqiAq9a9bUQAO9MV7iznTldWy3zA2Ty4/ln6AxxrLfnqnEfBNE8s0QKXKHAzoqL4h61TSJNyYbNrCwNxUXU68E1W/+FmsYyrY5dBGGzHBhLpLtmrYk3nSw0wxD8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xk1I+2BYJc/FOpL1J9e88Rjwpus1GltDuLvYGhqGb/A=;
 b=Bx7tLMlq332f+DOR92mKYQcP+wcTw8bhVexS6Je2DT7PNhXs5LpTIt26JUsY4dRHuyepBThtHC1g6j4EPVVS6pblIE/coDHzJsoXzuJrylyrhiop78DnyBy2G/c655lHzLSyPg3yQjVLn3f+rqLsT1rqpArF1m8QhDw1EvHNfkBrVk3Eyz5CYMAno9CZcFTUYfMNkp7cpGuioX+aslHIgMRO+IuYcPiN/4iYq/DE28OhhnxU0I5Fdny4alBFAwHhBGagBmq/zKp00AWau/p6ubPWS7ot7mwQSgjYHFKo+0C94qgY59t2VVPC1Fn1Z94tv18nKnLieiYbh3IluKzY/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 05:07:20 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 05:07:20 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu <nova-gpu@lists.linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v4 2/7] drm: nova: Add DRM registration data
Date: Tue, 11 Aug 2026 15:06:52 +1000
Message-ID: <20260811050657.646799-3-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811050657.646799-1-apopple@nvidia.com>
References: <20260811050657.646799-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0109.ausprd01.prod.outlook.com
 (2603:10c6:10:246::17) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 7802e557-2763-4ea0-dbf8-08def7666c00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8/b1daOyCUWFp5WV3vt785WB15Q2lnd9etJguzJbwTj3Ie0OASRlndA/oi3Jc7KwnYE78L27yTQ2Us1JxTDlU2krueBsUEU3ErEvVqLa9X3skYZ4NR5vIOLdUVO8tYUBwkVlbwxFrbsG5TG4BG4EktxACFdaguw0XpKzi/pPDoWF/dZZ36BmUQTAJJWYz36l7X+QZebHfXLJomXtQA3YY0igrsDiw/KF/f7YmNAppNxel3VgocNgDjKT4BuDC9yaef4liRBLsEluM+O/Qn9qgdOOjVqRr8CkMEv4p+8tdZOrxXpQoowGfCGBp2+hdXvudzJch2ZqIi9hgbXJvRW+aD1ib2+1LpPWm0sb8IIF/z0ihqmq8KTd+lAqUm8HcIRuat6jSVPCsbcgpzYh5bJ/I7/5NvFwbdVEM1uTR0hsbmjJzM9DDve5xiffsDWMfHcsLpuvFhViFVIqXsNea4E1pcld0ZC6SYQn2ZqqXcncaY7UhJk1HrqsZh5grBvdDmNsbiYj11bFi+3QxVEiUMWh8ESnaBktF81MYTMKm7YWoaPzP0o5Hib/Vv6manKee+oEHMhoOce8nxW3dgcxdf+Jf9vcCx6ixU86C9cZljPxdWEahgd4Q8IoOgCqVn6+LdZVy10WVVEM4E+fO69ZcixB7O7Rg/ZVu7U/PkbOPyWNPy4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZE7EpXklSfI0bJ3AQo5W1RbCdosTU+rrEFJSVOGiycT7PsoE5w7g08QON1Db?=
 =?us-ascii?Q?lKCt93ssU0ZPfsYM+7oi1xvMo1tNibesktVXXXfhatDz65ZlbOS2iujIJzP5?=
 =?us-ascii?Q?DKxjV+9/Y92fdliA9SabJrIEMPqfmg6HI04tD2sXcRTClkLTJfzY9Ux+c7gP?=
 =?us-ascii?Q?Y4NjNie4GtxiEZz4MXwqrSnonz4TVjCn1/NLMuN7BPwdXEoyZ6WEE9Y2qR52?=
 =?us-ascii?Q?XPg8nuo6mspyAlJK5n6Ean4omIMVkdqFQh3a6rwpH8CxR9HhX79RUl+A16d1?=
 =?us-ascii?Q?TVmQMI2e0oI05Yh796oALCe+Ca7cB3Ou4YLoTEUwtwHnWsDEIwMV0dzykpIA?=
 =?us-ascii?Q?HXku6xOdBoszvCku21K7759088omS+sdKEXF5FoO+54xUu0InAKrgYf6DDQq?=
 =?us-ascii?Q?UDZLWaBnmaCLc1+i1Iy2PY8ZSPgK0c8KhOv0RCxUztm4apqWLvhTRYHlqKYa?=
 =?us-ascii?Q?/Z2dpQtMKpbFv3m+QxWOzZbtOpjfnJlxf7eQpqf7DeeJO7WpVGhMbuV1lUpK?=
 =?us-ascii?Q?EA/DskK1MFF/ceOJZTfvdXb6xTrQtOxQSTez/lZZ9PCwyhnTUTsvWthYhjRB?=
 =?us-ascii?Q?4QXuVPH7FqghiVkK9tj2Fn2CxaT+HYTJyBxJ5yprZXoHdIic/BiKRfNEMETU?=
 =?us-ascii?Q?hH4cp6A5mrhVKUSC40iMIZDPlM2hhzQwBEZSE0sPz87510y7yt62k+XFG9Sj?=
 =?us-ascii?Q?Zl//5JZ9eAqo1vjRhCFG4r3Uk1xa7ORtRZli6bBsqcplv2sDeQOilyXlfpQB?=
 =?us-ascii?Q?qWeaqJvIB6pQS64Qpl7hhTKTgtTvNq3ymBr+obELSV9NWMXMjKylIJOXPs/h?=
 =?us-ascii?Q?1UbzpHicQM9nZzo2EkVhl36Xmw9gRzgn1p+ICL5q3SC/hyTeNTvVkDP4eRI2?=
 =?us-ascii?Q?wPH/O3saOEnGXHPXJnT6bTIJb5v+yKosc3haY0sWtf3ETfxKltqMXeBsl9XY?=
 =?us-ascii?Q?MNrIOQ+Iit0dNh8OWRyQVvyqS1j4Zbgl2gYr4113i+Gw2dcXJVDIcDo2gVWf?=
 =?us-ascii?Q?b8MPay76MjgMoUcvFaanfKz4ADDe4az8hwT5hJBMjQAnIZM7ZaP+p+Q9UI/w?=
 =?us-ascii?Q?bgIMlKMjntSCPWLvPYO/9MAkY0hHtRtX7oLcNysGS3F69PZaOaXYUcPY92Bm?=
 =?us-ascii?Q?XStHnPrxV8vc0aECMnUbOCYAUuhL8ASwlHR8DP4Jsg3CRS2vv6OhFjt8jLjI?=
 =?us-ascii?Q?E9SnwYDsRSi8H1jvEPRi3wc+et5bP5iCAvRoJFwKSN4adrahIgi3xyIs6Bzw?=
 =?us-ascii?Q?lA3j88PzxmNCGfiKIJvHvFR9FaZYSO4XQBWo5kef1OIDLyMBG1PYR734KA6c?=
 =?us-ascii?Q?Mo5Gm4d8/V4885cE/bdyXXmygZynIvl+6Yrn+DvswRemkzzzb2jH5vPD2jyh?=
 =?us-ascii?Q?lIMRT59JdIT8RiBwLceatC6V5uoaUoYtRrwYwk+puY0BjrxY4R+RGDKvcnn4?=
 =?us-ascii?Q?JUDfYflIc4+kun3iEE102Om/i0XnQt7k6Lq2b8FnsBDynHyMTtMfzbnv6VcO?=
 =?us-ascii?Q?m2vtrPADwcpE+lcJ7KvwdTY5Gam+utzASYYRp0RUz5oyxQN3l42/qvBfbPnG?=
 =?us-ascii?Q?zrzagxUZaAtJBUq+YQ9rq9C6WelTviBd84cclC7erlmls0QweKH3Dew4VJwP?=
 =?us-ascii?Q?YYVtpHbGS3q3cf2oX6qwcETCxq2oFSCI9Ai0wAX5ciPX/V4f2y23h0QcbJ9I?=
 =?us-ascii?Q?WIHe8w0tjY1o7ANMMX/DbcYKD/RpBkDEIhMYKKFGJLa5V3C6aZ+biAQqhnN6?=
 =?us-ascii?Q?X/I2UhvD2g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7802e557-2763-4ea0-dbf8-08def7666c00
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 05:07:20.5535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MoQ1dgLG6RmRp36tATrh0PGgVu6xTz6F9yyLQ1uTQBrnyFbFhmOMEEyZ/DfevJuW9WpNqdgw2wgA0jP3pVPybQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088
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

