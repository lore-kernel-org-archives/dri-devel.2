Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1683AC5AD55
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 05:07:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A4E210E280;
	Tue, 11 Aug 2026 05:07:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XB1tUNkX";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010055.outbound.protection.outlook.com
 [40.93.198.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78D3C10E280
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 05:07:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikwC9nsdblYvdK7S3LmVD0wnayyoHgQ6OOXDi7glMho+V5iyjjZwOaatqcHTp3xB6Gjv8UszHd+LmDy/jXcL/GlA5Mx758/4CP7SBv0Ew5nW2yTZohnBK3qaYm7zMvFtRfuJJ72fzFBd0p7EaHQa5ebatDfFrfIu5SNM/AyL/tacbqzpkn3tHUko0mIhenU6H7H+FOrNP7lMM2X/b7xRQLCXxcHRyNqH2pP+N8Cj8W7Rxk7rNiO56ct32RRBdSa7icHfAK3cgk9xp+FgXpHFuAa6z36Qu22/fkfcF0CJwh7VpIrjfjkqKK1Pn4J4smKBnLDmfnXyafxcVOjH9+yYAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pK85dY0gD1M9cTizVA3NqfSs3DtmmpADmzchfQDJ49A=;
 b=dDP2+ddHqnoidVznoPfN1XYs1Wk3cHJhSQNF1YCc/irzpGOEBovAtoty2tYJ2lTuEL5IPvYu/atzUaeS0N0IWGRiDUGz52A+uNoU9pRasbx8WPoEBjX1DCplNscxqHR5376fqrvQyN0xc50ez9UqHpDKrvRfg4S2sNEnyNN9yfVlTVHqdlj/PO9PwfztsFldiagl0zNh5WokXzzxqj03bzLnslMk1UwzmAVHwADiHiZk1u/bv6JaqSg9P+2Q20PCba8ZQ/YHxtRrZ9bZ30u3hcV8gYqyMpZbj5zpIGrwPh+0aPioXFDmRJIT8nK/hGfr/KcT5kYGTm+iQI796eHhPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pK85dY0gD1M9cTizVA3NqfSs3DtmmpADmzchfQDJ49A=;
 b=XB1tUNkXkB2GZmmCMMykVAalSSfNLOwN9y8+XLvMNXkClRnD8rTvO833ZluWox0wo+0EE3eYHto1Cnjc29XBi9V1TQ1f3he3Jf2ek5TBr7WNui3E7ScthzJ+UfJp/aSjhE/qzeMh9Xj6MWYTJAkg62rlmm0DKGqkF7zl96YjP4wklkRGbG+vMtlr38RVu5rgszvOCNFNbxfpKzuzwLBwhm8g3UgpyJOlsdH+yOyCjRlk0UVnotvprtp3b0N1HFcHASN2aRut/YYQo6bkUQNmmU9QBrRwgSHIE58NhMnK9et60oWwPlX9p5I/uMgNOsC1MBnY6CI5dhP+/PjBAWslrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 05:07:14 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 05:07:14 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu <nova-gpu@lists.linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v4 1/7] gpu: nova-core: Add public driver API to nova-core
Date: Tue, 11 Aug 2026 15:06:51 +1000
Message-ID: <20260811050657.646799-2-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811050657.646799-1-apopple@nvidia.com>
References: <20260811050657.646799-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0017.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::22) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: cc7607bd-cbeb-4ebc-063b-08def7666840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|7136999003|56012099006|11063799006|10067099003|18002099003|22082099003|11062099010;
X-Microsoft-Antispam-Message-Info: EBPZwka8S+V2kmBvKZ/ZqJpQ0j5aXYGFj3VVrwMYBls857el5SS0rCegd/ZZJZEXAOOMTZ1/o06JvZpwPT0VtI1/4y4f9KUxOxxMtmGOLxU79juk9P/oT0p2ciycNvutoTqzh2Urm/36uXo7JtJZbFeojj6AdolHyK4Vu9BH9my7cydfLlM0aQsqMSQHQuLb0OeGYPT2nBU5XYnMXk8gQFKBJ1U6TElNmgJ1EFTqvv/Y3sJtV5UPCrEElDOxBpjAJG5VtFT43Z0uj0jwG22sdwZIq7P5cc73vBFuKVwD1AyILW2KUvwRSz28z5e54d+xP7jtXZsLlufNdYQfRBOJ9a3I3kGlFFVpCYthilLA7U6MBAiw/7CT0zkHTOlQAlXeirRnrClJwPVqY4+b1ap8rwoXdaRWHq/bPz7+a4jy7XTKGwin7MkReW1La1YOd8pY0FMJJ7SQERtJLSuuH0gMvEIt/d7TN5CIlFONV3BQ9oOhM8j5sIe39Fga8DL3XLYYqkHoEdb2weV4baqg48Pwc2WKxQ7fxaVoTc4eMMdoKcZqzvxZ9c87ohvbj2UmFq3EeGQ9zwObhIrkmWLZyZ3MObFkp9aE6v4f+c1cmgxyrk/UEJ3I3jY5FCVqpB7mEEke5VRr/2BMPm+6iqIe83+Reuwm2APHUdOF8aCCyNAxsNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(7136999003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(11062099010);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FBuDJPBljskPouc3CpSrQse73cbjD4l/tZ8qvi+OP36nmhEdedE1UplYyPbq?=
 =?us-ascii?Q?L3kBTshVEabXABjrT1L2RM52QS1rAIEpONPKM3v15+dj2hkJ8WAmqpfe/r3q?=
 =?us-ascii?Q?Bf4FCLtuQP+HbCQNypGACZW4qOdp+3H8q1qgsWXDCRsOTz2fguArRRf6fWoP?=
 =?us-ascii?Q?C31f0H9LC4b3swufjXppRlX9DJmsS78ECMxaQorYUeWaI1Tlscpj5A8Ls1on?=
 =?us-ascii?Q?YHLIFhyK1ppCPFw+wvnLrzoKQhbd+Y9sEV9lo5rzmtPXvaWdXuk9r2hpmETy?=
 =?us-ascii?Q?RBBmWU4010yL0NW6XjOtvaM9vrUx8648YBYR06iQC2EEHyqRO0AoEw+WiUOb?=
 =?us-ascii?Q?LbnlLV/VqwzwDUSOMtoPEDVsMWqopDuqM7abNOWqvwzy9C1wbYhcnIpisXlA?=
 =?us-ascii?Q?mPrSPW0gPxE/lPvZ3meLIXkWLMFQvN3JfJGkkaolWue2KbSfA72cqajMVWP7?=
 =?us-ascii?Q?hXrJRFMGglo5xEXw5wR+UFahGpi7YC6R+CV+BOT5uDdXplVISU/+Ma6sWY5t?=
 =?us-ascii?Q?crVhcQjF+8AoptmQcqRl28u/4RRRB0cxSDtjT6JQsT9NumLKxGvLMXV+9oCi?=
 =?us-ascii?Q?0bimelAhDmV5NolLs1Ur3KX5ILYR7zMOUHGX8Inhg/vLBnDcPMGSJ1xAv0if?=
 =?us-ascii?Q?aZFjmb0/h8xNBoH/dPlmUIoWD7hMm6c+kwWM/Zv53lfs6AmDBluagxcIz02R?=
 =?us-ascii?Q?SooLXZjWjUqyOEP6QUw3a2sEsQc2b94QYHeQMm+zbOSO+0+UEhnvlKU3TsKl?=
 =?us-ascii?Q?kov9uQ+9FuwUyoYJ4UGERcttmOyA4ATBFMeazelk/AwzgFZXnhTSp2eCtujf?=
 =?us-ascii?Q?jIEXO/o66P8AM0ZH8IrRZZgam/s4QG+zmOXSJEaaSJaQdGAvQSUZyPDpb0P6?=
 =?us-ascii?Q?Z4s+K/uXl85n4mhcHcoPzsFNeeoStT+r0as5U2LMFbp20JtgAPpMjLvrM5ro?=
 =?us-ascii?Q?vmbg+fM9Sj+vcRotWQuyGzVodMoYN4hTYde4Ubxdf3Ga3IkRpD5Nc4NUXYdU?=
 =?us-ascii?Q?35QGeI4IrMYm2S3FfMx1V2QC+2Bgtd1Pmz+0d9D4mHWxQ6UTvFuRZgag4aDP?=
 =?us-ascii?Q?we7fPW+8j/g4Y+yPFMXQObQIZZXA//u7drvGXBsdYUV8xT26O/JSlF5mLp/w?=
 =?us-ascii?Q?eiMn9cwuze1u6Ea9NfYBOaxUx8AKXQhuW1hQS9zxDWg0ihaeiE9yFDbs7LVC?=
 =?us-ascii?Q?IAZ94Ej1cf/pG+mZPPuFVgXQ+bSs/CuLSv5i551YCCK2EbOo5rYnuRhJmXtG?=
 =?us-ascii?Q?DWlThAy9j5dWxqyn/ps0grAY0PhH4NGnBhn0I/aC8JLPvZpZ4899JzaqdBuQ?=
 =?us-ascii?Q?hbUnUwmGUX7M6j/GE/lf2J3tBr0YYDMNPTIHkc7D7N2AvVXO0hTAr0mrNmdz?=
 =?us-ascii?Q?4ORGtZAVq3yYy9LdEPmiuE+PQ8vg2LzIxM/Azi3Sm+7abSHrbLHNztTKTc3P?=
 =?us-ascii?Q?l0SweygfSE035rDjUeHwzHgxaIlGcDC3XYTubmGDrKUIqZgViWNL2WFb42fz?=
 =?us-ascii?Q?UXY3FWWeJC801m3dFaCpnr6sOn7GqwWq4uEsl1Rkw1x0ubyD89O2UeZvWfhO?=
 =?us-ascii?Q?1l66AVEVsQ/C4wlUJOUCNd6Zx4SDo/WMYCnKfb0RvlnyTT3LJZdX1rUgKB7S?=
 =?us-ascii?Q?N4kxx+DMRj+wngTSvz45ngwzceQLddq36hVE/tI3FDgIFOtXoKCuJYchsazt?=
 =?us-ascii?Q?1kfuD0993zEbcd6Gu2tjPjLXvWJQf/lwPsoUK1bfPeGB3HMqgXigfBKBDog/?=
 =?us-ascii?Q?4ndqmXOUkQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7607bd-cbeb-4ebc-063b-08def7666840
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 05:07:14.2462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XuuM/Prft0L+894cZHxSvbmrlZlm6CFgPGT8Ioz1V0jpTnthWaWjaxtz+MbtfZu5uhwVJm4Jm09oRa3FhSYWMA==
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

Nova core will be used to export core functionality to other drivers
which will bind to it via auxiliary bus devices. Add a NovaCoreApi type
which drivers can use to call nova-core methods.

Auxiliary bus drivers can obtain a handle to call nova-core methods on
a particular GPU using NovaCoreApi::of(). This takes a reference to a
bound auxiliary bus device and returns a handle to NovaCoreApi.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v2:

 - Add accidentally dropped TODO comment

Changes since v1:

 - Rework unsafe pin-init to make safety comments clearer, suggested
   by Danilo.
 - s/allow(dead_code)/expect(unused)/
---
 drivers/gpu/nova-core/api.rs       | 29 ++++++++++++++++++++
 drivers/gpu/nova-core/driver.rs    | 44 ++++++++++++++++++++++--------
 drivers/gpu/nova-core/gsp/hal.rs   |  2 +-
 drivers/gpu/nova-core/nova_core.rs |  1 +
 4 files changed, 64 insertions(+), 12 deletions(-)
 create mode 100644 drivers/gpu/nova-core/api.rs

diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
new file mode 100644
index 000000000000..610cfc01111e
--- /dev/null
+++ b/drivers/gpu/nova-core/api.rs
@@ -0,0 +1,29 @@
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
+    types::CovariantForLt, //
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
+    pub fn of(adev: &auxiliary::Device<Bound>) -> Result<Pin<&NovaCoreApi<'_>>> {
+        adev.registration_data::<CovariantForLt!(NovaCoreApi<'_>)>()
+    }
+}
diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 48380ac15f68..435aa917d3e7 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -18,6 +18,7 @@
     types::CovariantForLt,
 };
 
+use crate::api::NovaCoreApi;
 use crate::gpu::Gpu;
 
 /// Counter for generating unique auxiliary device IDs.
@@ -25,11 +26,14 @@
 
 #[pin_data]
 pub(crate) struct NovaCore<'bound> {
+    // Fields are dropped in declaration order: unregister the auxiliary
+    // device before dropping `gpu`, and drop `gpu` before `bar` because `Gpu`
+    // borrows `bar`.
+    #[allow(clippy::type_complexity)]
+    _reg: auxiliary::Registration<'bound, CovariantForLt!(NovaCoreApi<'_>)>,
     #[pin]
     pub(crate) gpu: Gpu<'bound>,
     bar: pci::Bar<'bound, BAR0_SIZE>,
-    #[allow(clippy::type_complexity)]
-    _reg: auxiliary::Registration<'bound, CovariantForLt!(())>,
 }
 
 pub(crate) struct NovaCoreDriver;
@@ -86,15 +90,33 @@ fn probe<'bound>(
                 // (`try_pin_init!()` initializes fields in declaration order), lives at a pinned
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
+
+                _reg: {
+                    // TODO: Use `&gpu` self-referential pin-init syntax once available.
+                    //
+                    // SAFETY: `gpu` is initialized before this expression is evaluated
+                    // (`try_pin_init!()` initializes fields in declaration order), lives at
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
index 34b4bb82a999..b59bcaf2042e 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -29,7 +29,7 @@
 /// The GSP unload code might run in a situation where we cannot load firmware dynamically (e.g.
 /// because we are in shutdown and the file system is not accessible anymore). Thus, the firmware
 /// required for unloading is prepared at load time, and stored here until it needs to be run.
-pub(super) trait UnloadBundle: Send {
+pub(super) trait UnloadBundle: Send + Sync {
     /// Performs the steps required to properly reset the GSP after it has been stopped.
     fn run(&self, ctx: &mut GspBootContext<'_, '_>) -> Result;
 }
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index a61406ba5c0b..9463ae038e81 100644
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

