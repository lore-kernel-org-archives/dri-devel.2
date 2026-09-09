Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55253C79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:45:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71D9710EEE3;
	Wed,  9 Sep 2026 06:45:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="LjQAmVI+";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012031.outbound.protection.outlook.com [52.101.53.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9610410EEE0
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 06:45:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gv60KdIOlPXmwP7iWQExPNq6xa2gGpxyHpRZWiMYHQUFssiZXYrakC+Db1h4lKYXoEEeuPYvcyJvdwb/4nlHRid94Dsl6dSQbOOvKoyf1nrDS/M4X3rX+WGsUGWpJg3rjXa8jX4f1uM5vqm9yrrtBkQHtTaBwRAVqZY1YLVq3P8CAw6wWQwLIhG3mzSL0HqxDr5A1i4lz2GjuJ0MwXwFpsl51VD51eoNaDV62Yh/3/hN+CRydBuL523JZgjJ4ypp3aJ8f8nRFfHfMswMSGjNp7CGHPvrlwNonr5f/wK1iTd9iQI6iEnVzqwghtzLhMlx5s8IOV9jwr4Si0qJ1YZo5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTilDGdxIPIhTi+DwuKgrj55gT1h1VDZkS8pN/M7Geg=;
 b=KHgjT5UdKz8X/lwdHJ0xbhIN359NU8xeP2t9csq+z2HMgG62zLmWBCmhAqkPVzjXHk3jh/GEPyw6oiLFeFkLD3CRdEbC0P5MWwdM/5ChRVuOtvugjudA/mHnI7AF+2G2Ey/8SZ4n02gghWXEtI76kytXDqgrYKsLhaD2krQRRmp2LkP+GpTX8e/wtVUx9MsqIfRFcwJBu4LDpPTH526x86BE0QzrWNq+syEmob7gxyAR7+7m26udFvED3UFqh6p3o+9uY91CjWvQWdXseYO07580AbLkVzFt+gAx4+2qcX+uqw7BjmL5Z4unY2U8uT0sfUP2SJZBwMRRhIbPPI7fMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTilDGdxIPIhTi+DwuKgrj55gT1h1VDZkS8pN/M7Geg=;
 b=LjQAmVI+/1VNywh+DYexTDSgX8XTAWKHqDQZbp5g19TGpT72xJqbwr4mccYeMSbOcAC8z9Dzo3Q+eD2MBWex8Jj5TzaeC8lfmgawhMQypcZHn1Skeb5HF8Z7kWbBNfApk82wCUwy+A7AFd6pqHxjeKLAURCYYnx5Xs6stVf07FhowJyCIyEGHQdi/k67OUV0iNZ82CTcTvtKjSlO6ux7PF30oPtmPuSeahjpliz+XleOC2fFjUwE4sevd5kW5UXUr9I1ygQxc2SJpCim/1FCKt1+0MdSOoOn6kSnrTOtBw26XtUc7XER+UthgRRvc9GJ7VyHQ8K4qM6KRIetE6RkEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 06:45:25 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 06:45:25 +0000
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
Subject: [PATCH v6 02/13] gpu: nova-core: Add public driver API to nova-core
Date: Wed,  9 Sep 2026 16:44:55 +1000
Message-ID: <20260909064506.910162-3-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260909064506.910162-1-apopple@nvidia.com>
References: <20260909064506.910162-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0034.ausprd01.prod.outlook.com
 (2603:10c6:10:1f8::19) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|IA0PR12MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 900566af-a2c1-4e5a-45de-08df0e3ded6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|1800799024|56012099006|10067099003|11063799006|6133799003|7136999003|22082099003|18002099003|11062099010;
X-Microsoft-Antispam-Message-Info: 2iNQkB4OitXHn2PGoGtZqjfeVl0rtk0GQrYo0vrLUXK41i7HUPl6FOV5oY8YlFXaYgvauLkBtayZv3XS+r4Q2L8uGGDuaPTLmFoJAxqbu2LQfoQtqCINYWEQ2FOjW4Irt7G0vdSmuv+2IrEorVsYwpAwvKj0O9nKkQwn85HpjMikABCCSGeskziFMtgA1V6hGuvUPSPk5dVioLe/SiCaMkrLLR5K89hKwe903GeCZglQqXw2UztU37qVycNaLI8qmgWj9O7B3Vz/ETFGAHyZdHOYw3I/8X+CaZEW3mCBxE0qbHa2/vlHHdlnEJOfMWbXlDTs2ogTJ4JbqsZ/xV7KVgHWQF71nZh/yN3+BUP8XagshFu5GbUPsnsWRGvWb1poge/eRvcH6KVPHLgHpe0eb81dFYEou+6PPKIUyjc5V1m36pmYfs8SgjUbHgQZ57B1z/kAqyfF1Nb1gqaSOsNk3BwlhQK3Jm55tYF1nLxqHg/N5JwbMItCvMIqQK7U1hZCUofQdAVHPEmk3I+TtZuect3+MyPG0aKTu5GElJITV5jzqxMbSb3tA4zXI18Qj/OC8rchcja3O+dcFO7WZ6VRyqFA2NrgLybl39R6lpBWRDLuuZ9Cp4WyJAgw3jd8tcqpHRoaAbaD9bnFtMTTnkIDxKCt6Q2QDbSAZ7E9JL+xyzI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(6133799003)(7136999003)(22082099003)(18002099003)(11062099010);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LULzq4IzoI2dqUahtKDF9UwytXhejqe759rTND5IaWgMVvEb6RjQiBbGnk4M?=
 =?us-ascii?Q?JeYXVbRh/Rk8Vbs137zTx5ADHeNMyKNClJ8VteLUeE7ZOCGNVZ6FbjPFsrGN?=
 =?us-ascii?Q?aAJetGq0HeYbCN4yB7J6swxFmKNI4QjSXVM4dNQqPYtplpUKtZQpunDCeLJA?=
 =?us-ascii?Q?FyLPr0psFQVc2v4kgdihQ5enmrx2OLk5wKTawjvI6BAGMh3Hm6Qn7GnV6jzm?=
 =?us-ascii?Q?5rpGB4+QMajaMNN6winOi1EpI3bas4MRJSiaJdXg7BojVdMx/w16ZfG9fu1z?=
 =?us-ascii?Q?J1HN9J01tQRPRtAMAfadUTtM1xo7C0AA9Ag94wugAPDEHnJBMGpv4ldjEutJ?=
 =?us-ascii?Q?QBs8ILnu8QIMtHK8cAOasGcv2GiPglFcbTuHvlBhAJOJYKh2Rmvk7OuBWszT?=
 =?us-ascii?Q?5z7T/cWmOBybJdLS2/gefPTgvwVOiEQeP7rMuoRphA9qPjxA5DCygdda5+NA?=
 =?us-ascii?Q?Ly9u/VNkOo1Fyaw953azzerdxnBYbl4W0IOWxLm5CBo03XjiWE01YH0I5ci+?=
 =?us-ascii?Q?aSjShp/EQ07gV/N/mky8XQPyEJ9M1htcHqeJSVX7CxoD79agQS2lwLwphv3B?=
 =?us-ascii?Q?GqHfxKTdNh9OT68HviR5cQ+H9dT/SkG6DOGioz6f/tHKMqCmKufZ/zTWJLpQ?=
 =?us-ascii?Q?pT3l8szrUDBOPFuUHNLPjWw8uTQN/slckZwFtZf9UMasywol9J+nqO0sgOz1?=
 =?us-ascii?Q?Nc8zwW8nMjucMncTfXpKvSOZNLp9CZ+5HvpTrb5rvg7CpTVBBnRfrSDLTKmw?=
 =?us-ascii?Q?2b31TMxDOj8V9ANsetEOwvmARyVmdanqqmjcZlXtGA4M8K1mm/X/p23E5hsX?=
 =?us-ascii?Q?4hYyZZV+SlDT2e0S6X3ALM2OL2hOD/J6c/wd5aJTLhpznUKJs8ZYJ9IQ7v9i?=
 =?us-ascii?Q?h6r7sYg/f0a8PXkdDOFfAVbJVT3/QYsqY3se1YGBIycrftD9JZTyvbGMaIE1?=
 =?us-ascii?Q?r0XrYtdTipt/IourR78oIsejBTqMjNoK6DF9VVPIJPQtfLOXwk/nf9AqrdC6?=
 =?us-ascii?Q?oFbeY3V+kHWat4iKzrhHvcAoprYXiZNAS1j03uoJjo6EohSBK17PHn20VjYP?=
 =?us-ascii?Q?ik51IGv1VY+eSm0hVcmo7VgOroQ72pmP8wAt5gYyREVE70HEzokiw9A/8DOS?=
 =?us-ascii?Q?zM5f6FblUtvUHQlGvGaZC8xzksY6clzUBvNnwzXvbFvKyl6YepuYPbe6gTF7?=
 =?us-ascii?Q?6niBDtX2AlAADhm/bxy5FOlB2JHK/5iJ8YxXlL2XoqNciezZNzE3TzlEhc6J?=
 =?us-ascii?Q?Ami6RM/vtt03mRScjZKssRmLvUkPmrCdp/6ui6L2AV6BzRI2F2moanCgDFBM?=
 =?us-ascii?Q?JimrK+yQ4mWGQUAOfNymgYrnMAQZwjwOVIT7sippNOLqk4C0m0mAxc8EmAIO?=
 =?us-ascii?Q?yWNllxQTKuaYg3ahqKlLGMYOr7DjBcix7w2OeugOwhvWe7+ff3e23jz7tjB/?=
 =?us-ascii?Q?+3GZLoKso89XVCVoKt+GeGwTTW/Wyga394H8IZMy3KMWLdJ5N4QWMwNd8d75?=
 =?us-ascii?Q?rfap6mrnSGw0SWa5lLvt1YkbkXwZYDjq/mAH9PXpaPxj4jFm5Z4jpUaMwKlr?=
 =?us-ascii?Q?2qW3j+r3Cunc0+DnnWU7twLDHE5TYazPXufmegNyr6fY65pqTTfLeehuziI8?=
 =?us-ascii?Q?Kr9mjLzFy58Bq1WwTJKXpsSP4LOzOn9Eai7JEyltS+3arCL4+ujLf2qf+mmD?=
 =?us-ascii?Q?3I72aEGRLgetrCMR8v4kseMZnc8RMIyGrFulO6G1BMBgU37/B9uyYC/bUVpq?=
 =?us-ascii?Q?KnanwZnSXA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900566af-a2c1-4e5a-45de-08df0e3ded6e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 06:45:25.1933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5/esi5s5ZVUfrzFKepD4V9qHGaXOAFgr0mNGkHTEZ/Jhxt8AqDQ3ln81I89cCzq22n5z4pSagVH1/RV5MRdXw==
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

Nova core will be used to export core functionality to other drivers
which will bind to it via auxiliary bus devices. Add a NovaCoreApi type
which drivers can use to call nova-core methods.

Auxiliary bus drivers obtain a NovaCoreApiHandle for a particular GPU
using NovaCoreApi::of(). This takes a reference to a bound auxiliary bus
device and checks that its registration data is a NovaCoreApi. The
NovaCoreApi itself is then accessed by passing a closure to
NovaCoreApiHandle::with().

Closure based access is used because NovaCoreApi cannot be assumed to be
covariant over its lifetime. It references the Gpu, which will carry
locks around types holding device resources, making it invariant.
Covariant sub-fields can still be returned directly from the closure
thanks to the lifetime bound on registration_data_with().

Co-developed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v5:

 - Access NovaCoreApi through a closure based NovaCoreApiHandle using
   ForLt instead of a direct reference via CovariantForLt, as NovaCoreApi
   will not remain covariant. Based on a diff from Danilo.

Changes since v4:

 - Move the `_reg` field declaration, since it must be dropped before
   `gpu` to satisfy the safety requirements of holding a reference to it.

Changes since v2:

 - Add accidentally dropped TODO comment

Changes since v1:

 - Rework unsafe pin-init to make safety comments clearer, suggested
   by Danilo.
 - s/allow(dead_code)/expect(unused)/
---
 drivers/gpu/nova-core/api.rs       | 48 ++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/driver.rs    | 48 +++++++++++++++++++++---------
 drivers/gpu/nova-core/gsp/hal.rs   |  2 +-
 drivers/gpu/nova-core/nova_core.rs |  1 +
 4 files changed, 84 insertions(+), 15 deletions(-)
 create mode 100644 drivers/gpu/nova-core/api.rs

diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
new file mode 100644
index 000000000000..ae023242594e
--- /dev/null
+++ b/drivers/gpu/nova-core/api.rs
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Nova-core auxbus data. Contains all the methods used by the auxbus drivers
+//! to interact with nova-core.
+
+use core::pin::Pin;
+
+use kernel::{
+    auxiliary,
+    device::Bound,
+    prelude::*,
+    types::ForLt, //
+};
+
+use crate::gpu::Gpu;
+
+/// API handle for the auxiliary bus child drivers to interact with nova-core.
+pub struct NovaCoreApi<'bound> {
+    #[expect(unused)]
+    pub(crate) gpu: Pin<&'bound Gpu<'bound>>,
+}
+
+impl NovaCoreApi<'_> {
+    /// Obtain a [`NovaCoreApi`] handle from an auxiliary device registered
+    /// by nova-core.
+    pub fn of(adev: &auxiliary::Device<Bound>) -> Result<NovaCoreApiHandle<'_>> {
+        NovaCoreApiHandle::of(adev)
+    }
+}
+
+/// Expose a handle to nova-core API
+pub struct NovaCoreApiHandle<'a> {
+    adev: &'a auxiliary::Device<Bound>,
+}
+
+impl<'a> NovaCoreApiHandle<'a> {
+    fn of(adev: &'a auxiliary::Device<Bound>) -> Result<Self> {
+        adev.registration_data_with::<ForLt!(NovaCoreApi<'_>), ()>(|_| ())?;
+        Ok(Self { adev })
+    }
+
+    /// Access the [`NovaCoreApi`] through a closure.
+    pub fn with<R>(&self, f: impl for<'b> FnOnce(Pin<&'a NovaCoreApi<'b>>) -> R) -> R {
+        self.adev
+            .registration_data_with::<ForLt!(NovaCoreApi<'_>), R>(f)
+            .expect("TypeId was validated in NovaCoreApiHandle::of()")
+    }
+}
diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index bbd93959e0b2..922068df7707 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -15,21 +15,24 @@
         Atomic,
         Relaxed, //
     },
-    types::CovariantForLt,
+    types::ForLt,
 };
 
-use crate::gpu::Gpu;
+use crate::{
+    api::NovaCoreApi,
+    gpu::Gpu, //
+};
 
 /// Counter for generating unique auxiliary device IDs.
 static AUXILIARY_ID_COUNTER: Atomic<u32> = Atomic::new(0);
 
 #[pin_data]
 pub(crate) struct NovaCore<'bound> {
+    #[allow(clippy::type_complexity)]
+    _reg: auxiliary::Registration<'bound, ForLt!(NovaCoreApi<'_>)>,
     #[pin]
     pub(crate) gpu: Gpu<'bound>,
     bar: pci::Bar<'bound, BAR0_SIZE>,
-    #[allow(clippy::type_complexity)]
-    _reg: auxiliary::Registration<'bound, CovariantForLt!(())>,
 }
 
 pub(crate) struct NovaCoreDriver;
@@ -82,18 +85,35 @@ fn probe<'bound>(
                 // TODO: Use `&bar` self-referential pin-init syntax once available.
                 //
                 // SAFETY: `bar` is initialized before this expression is evaluated
-                // (`try_pin_init!()` initializes fields in declaration order), lives at a pinned
+                // (`try_pin_init!()` initializes fields in initializer order), lives at a pinned
                 // stable address, and is dropped after `gpu` (struct field drop order).
                 gpu <- Gpu::new(pdev, unsafe { &*core::ptr::from_ref(bar) }),
-                _reg: auxiliary::Registration::new(
-                    pdev.as_ref(),
-                    c"nova-drm",
-                    // TODO[XARR]: Use XArray or perhaps IDA for proper ID allocation/recycling. For
-                    // now, use a simple atomic counter that never recycles IDs.
-                    AUXILIARY_ID_COUNTER.fetch_add(1, Relaxed),
-                    crate::MODULE_NAME,
-                    (),
-                )?,
+                _reg: {
+                    // TODO: Use `&gpu` self-referential pin-init syntax once available.
+                    //
+                    // SAFETY: `gpu` is initialized before this expression is evaluated
+                    // (`try_pin_init!()` initializes fields in initializer order), lives at
+                    // a pinned stable address, and is dropped after `_reg` (struct field
+                    // drop order).
+                    let gpu = unsafe {
+                        Pin::new_unchecked(&*core::ptr::from_ref(gpu.as_ref().get_ref()))
+                    };
+
+                    // SAFETY: `NovaCore` is dropped when the device is unbound;
+                    // i.e. `mem::forget()` is never called on it.
+                    unsafe {
+                        auxiliary::Registration::new_with_lt(
+                            pdev.as_ref(),
+                            c"nova-drm",
+                            // TODO[XARR]: Use XArray or perhaps IDA for proper ID
+                            // allocation/recycling. For now, use a simple atomic counter that
+                            // never recycles IDs.
+                            AUXILIARY_ID_COUNTER.fetch_add(1, Relaxed),
+                            crate::MODULE_NAME,
+                            NovaCoreApi { gpu },
+                        )?
+                    }
+                },
             }))
         })
     }
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index 5850fa0fe0e9..0c8670c57bbb 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -24,7 +24,7 @@
 /// The GSP unload code might run in a situation where we cannot load firmware dynamically (e.g.
 /// because we are in shutdown and the file system is not accessible anymore). Thus, the firmware
 /// required for unloading is prepared at load time, and stored here until it needs to be run.
-pub(super) trait UnloadBundle: Send {
+pub(super) trait UnloadBundle: Send + Sync {
     /// Performs the steps required to properly reset the GSP after it has been stopped.
     fn run(&self, ctx: &mut GspBootContext<'_, '_>) -> Result;
 }
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 35a8b1214b0e..503898cee042 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -10,6 +10,7 @@
     InPlaceModule, //
 };
 
+pub mod api;
 mod driver;
 mod falcon;
 mod fb;
-- 
2.54.0

