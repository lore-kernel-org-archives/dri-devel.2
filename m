Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19DBC61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 03:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BE6910E455;
	Fri, 28 Aug 2026 03:36:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="BwqTGTbI";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A14FB10E44B
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 03:36:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjPvIazv8HVwxpseNYl+ZnLVhYrdyohOGjYcBAMsE3TlyAmIfglL5YcYXRSnE2rilqrYtumLq/0UA9O1hAxL75dbAD6+EzCIIRJJs8yCa7JuNAEULbzG8mkAlNLrlQuJMHnvFuInwD83XfMXql5HuIX6+GGtW/JqorC0gzdj2K9VURQo8E09ojWOT9MYvqmXG+tp01+xpisZAhY+Qx1rlvGuKWbudKbXnrofd/0f1NAN47NdCRnI/AFx/ZVGZng/RkEcf4eGt6ytLfv7zvd9q7gDhgIEs76y9lxP3tK7h6PfL3IoUybrbQUSH4bVpBqOXN0l54XliD8910FuKhIBIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xk1I+2BYJc/FOpL1J9e88Rjwpus1GltDuLvYGhqGb/A=;
 b=K1EO95X8InkvgX5fg+DCSUq0SUfM7/xi50juQ2Yvsad4ujJzU+Renc2FiqqGgEJTyAVtsORgSxGmCubuEHgOtOn3w/dQT7IxO9C5nSMjPiK8SS3O5yrGxc5hYGKaTMWbOvv74q0FkG2e3vbZCbXZChEjZ2lyOHZroQnSaUPid3Cy6VvfX+b5sKJur6fPMW7S2QIpLqIsu/nNuKp+4tSBbdI5REiGU/mjxE8Y8iP0mZO7u4F6ZoLwTJeR7rGXjGY/WVgbNnmz4vzdHdWO5BQga9OolW0qPSnFBWYKcCQOYbl9TSqvC6jneePLuOlYmMclaxVKkoozmnhMlIN9QeS/iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xk1I+2BYJc/FOpL1J9e88Rjwpus1GltDuLvYGhqGb/A=;
 b=BwqTGTbImnmpaVHs8LhyQGSI01eOf7BKUIYDtprIHqqs4iUr9zrZhwQpeELcIK7a5K35Ai28pl31RtEZ/GJYSIo2zm1s4XcGcgViR/TBELUFPeaT4Tq/4ycK1AY3lepZK/uOlbfcnL2MFjj/jYVQvzznl1HNLSpLPOym9dJHeKhFDsMQfe/qH0zmKwChOEAYJttkgIeDptsbs/MwSL1BOExoMQQGA1rmDBNmvkG1mS2IKVPpI944fmWGsISC7UlR8271/GeWcRNXKmacmrlFg8wY9Lkul3H6VfIkS9QvG8FhmLh33UfSIm7E196cvv6q/8zjKNuXX+9I7TQsjwcUEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 28 Aug
 2026 03:36:02 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 03:36:00 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu <nova-gpu@lists.linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>,
 M Henning <mhenning@darkrefraction.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH v5 02/11] drm: nova: Add DRM registration data
Date: Fri, 28 Aug 2026 13:35:22 +1000
Message-ID: <20260828033531.1117754-3-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260828033531.1117754-1-apopple@nvidia.com>
References: <20260828033531.1117754-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0127.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:209::20) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|SA1PR12MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7c3166-e2b1-4462-c3c8-08df04b57a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|23010399003|6133799003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gpPLkF159egaqoQBiwUWl7iHEIP5kSfk95k3XUJQ1emlHvYHZ+yxaQ31HpYkTenhes2/JRPZM4rgZHkxQFwupBjx4VEebFMEtjnuudTO5GC1d5L2UcOxgpMZ5D01oJfXL2v6pmyw6aFg+2mgyxrziAp9u/Xz2VGL9qrkyqFhMqi+6ZxeZVXJPkVcVr4c0w7HYPuL53cN45avox6lxCCrrrfHqrBsjoHS01MBRxFP4T7WWruhUyNXNTUr4cLTlaXqdozSOzWguF2hpQTbS/4gcdj7eDwQ1+sslsP+tM6gisdFtPehZ3loOsXLfT6QuhJ2J/CVQ9lSmPkiBhcNtuBRMk/HvAGwYOYMcnD6GdY6aq8QOQWjsQR7LrUoTXomilURELHiftpnN8Umj2fyutqnVUehQi6K6t82wgcWgdO4JFH0U9GPNyWk+ijxngpAL2ozhuJhSQmxy+IwWP4hYHj7caqtqCglc2LX2Pgs3PRfzRd6l9vd82JvYSSQNfHqu+IwXL4r/6ypGbK5GXAt2Ns4fzCD7KrW5ydu1q4oWZnFiVKg7voA3LNlGavl8n+dXieyiJZ6c6cmiNuxLuTgZUNiLRnmbRfoHBX9qTYNDugZSgGdyVfb2+VssrImecvTas8eUJOVpVxm1tJCaYrqXtHR6X12MbzyElhxwdLtN32A1yM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(6133799003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BuRJcrNzfkhr7QzvhPtMBLCBO1Suk573G9wkIVt9ZcjS1hSEHuMXGiSdIDp7?=
 =?us-ascii?Q?N8pwasiRXxUR1dLmc68Eey+ICnAV1yBn2gNXWjgFCKa93ikI/AD0SZYm/jmE?=
 =?us-ascii?Q?3LIczC7+wMUGO4XGG8oIYjLJmgnG8i4UOz8AkRcJOVk+Hiu25y8NVLEf71BJ?=
 =?us-ascii?Q?wg23+Wc55PTVEHvk7qDs+Pk4QkD8dr27uxWMxHyXvslTDqDnEUYbMxmuf0ps?=
 =?us-ascii?Q?U6aLbFqBdb8mb9HHmIi8YtE4EVDC6oCKkxfs6ZlFhyqdoI1YJ1K0Tvie3ut3?=
 =?us-ascii?Q?e0jG5oJwdV3YN/eUrCPGQ3nVoXhSCbOGf0d8pA8QytDKEUZAHsXDhNkhKxij?=
 =?us-ascii?Q?yEfZ+1WZ9BICmKFy6oXxMxYLfRm8Ib1538JdY7GF133ZBH6DwmrOtTLmUkWg?=
 =?us-ascii?Q?M/q2luhozlPrxzUbB5pMsRbPoF+6P35VzreNRQrasw1C/WVO4SFBDfGiBt2g?=
 =?us-ascii?Q?wc1S/RV2U+O+bp9BbEvWsITcZdieQdO8GL5J9YLWT8WAFMf6HNREozzCjIkS?=
 =?us-ascii?Q?1BRWPEl5rJ8WZlq8drpgymIjt1IDnlXJxMua7Gy754m5pnE4xiY5tXuKUhX/?=
 =?us-ascii?Q?tARpEra5WJcGLmyTuzwn5yXaP5/uLS46/LZDdwkf3okdPnIc4N4WE4PhG0NG?=
 =?us-ascii?Q?VtYF+2y9EQkhivz/3503Yq79JpSl1ubHcyImXNdRBJ+EebRMLNnBYfvhxbhD?=
 =?us-ascii?Q?5GZcTpkVuoR0NITsy/myyPINzsJ5A86ZHvkY3o1XjAzIaQ5wqRgV7uZR8SbB?=
 =?us-ascii?Q?sqv9IEPaIN3rR8U5YbSjdtwCLc/zWioacyAjf+rItzMtIvbu7vfhzvDcZbv7?=
 =?us-ascii?Q?AlGUnf92mO7k9ler1KA9p3HIQ6wX4eX6OpcsaUb5PEseLJL4F2BMZhkPjAmz?=
 =?us-ascii?Q?Qfm6kZDD9YYIXEktjazJsxP+ell7ASMUrh4udVgTvfXotP3cGOLrhjAhju4L?=
 =?us-ascii?Q?zz7OeYD4o9ZJav7mvEWCN37DRzEep89EommAM9TXBoX59nEC7VQTNIWfFbxH?=
 =?us-ascii?Q?kyBoumJC6uSCzk9ygWhhOtw7T0hLav8wdI0nKKOi5H9xjiPgT/Ux760g0U+E?=
 =?us-ascii?Q?j080pf3YM0IvhogXD+Gi/Jx0Y29jhs2dDvBTO964HUs48KAE0FS6GhO7GMOC?=
 =?us-ascii?Q?q9hbwBscPf93vftpwkxikFF8EmbYfrKeT4tVefEscv3HjzPKJsFbCDUIzJ03?=
 =?us-ascii?Q?lXpvXEqUO4YocJQ8dXgVP8VlJqRc8uVGJJgs9AMCdVVHUUjPY3S11fSIhK89?=
 =?us-ascii?Q?BD3tyDFz3kcCz40A0toERD4xgzElPa9RsLx2TKzqrUv+DIXEUoiXUjtlK04W?=
 =?us-ascii?Q?+RDoZfsouc7YUImLul5u1ksgUwdEyPnxuzUeP599bzHulBsEO9D9HAoi9Dm9?=
 =?us-ascii?Q?KGiMtcCRi1GRasGcsVOuL0WnipGR4b4rT5MMC33DWYro+4LW2L4rmz02dZnY?=
 =?us-ascii?Q?NWyZMMKyCHmHpjKrtjr1HnJhNrLn2CFSUeSraZvjk7gtMjWz23uM0PQuOEyv?=
 =?us-ascii?Q?fNIZdDIqdb6odpitW2IEZS0Ft4ehSjNSnpKHdmniRl66bcUOzbw6nn5KYSNc?=
 =?us-ascii?Q?fQDbpcOU3oWvnIIX2ZmFg9Eho7g4AXVILnUL6wtOYOe0nlYT/oYgbZ1KstNV?=
 =?us-ascii?Q?AEArYCxm3bmw1gtJoTJn+3tZXq55Tu/wIqyxyiWAMwuI/RzbVYaG+xD0TOkn?=
 =?us-ascii?Q?VRWjO177ZJPeEZBI1+lM3DqdzBAerw2RDudtZxxCgpE1IvOAH4I3F7jdItY4?=
 =?us-ascii?Q?JtC6ey+Lig=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7c3166-e2b1-4462-c3c8-08df04b57a89
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 03:36:00.2525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyzDIjQVai9UKFHOYyh7OWLbVaGaorT77Lro1nZtzMU3uWnMA9TtdSngdGQBOP/1RJHqDrkDMM6rMSq1/EjJ2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6919
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

