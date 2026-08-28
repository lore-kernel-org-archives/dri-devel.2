Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C91C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 03:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ACE210E445;
	Fri, 28 Aug 2026 03:36:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="JknJYtDq";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010070.outbound.protection.outlook.com [52.101.61.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E28A010E445
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 03:35:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idFVtp/EFEuSXZ9ErKG4Eg7NJtjMQ4jFxnPiG3ceRFPyNSt7xCjXUh1Desln9/O3w+tYFezfjTK0wIkqQVJu42p2mjWwCT3HztimMC1j+Z9OuaNnYt+1VNqaeaF0hFA7zl2DKJXoN2wDnujVcCMXzC5HMPpk9jfO9xOhYhzfnO33TLA0M6gmsgXoSgm0fHrMUjuxmem04wwZjSbVs/m5ByDxrxWwyyWSqb9bsJLVLaVh4tWTXcdv9BCTFEA5qYei6EJL6xchaMqwQvX994o/8C1vnn1kbwKmKDtcQb2MLJf/jQkvgSxym5laWwnU1WoDf+FXVcGjNK+9+/seBXn8tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNWwGi3Etzb+213OpGf8Y2g1AEt5AKZaDKQ6Chs600A=;
 b=Zr2SRedQ6w7XdyPZEW03DzSvofoLfDj+kz1tNHTinzefdsn2wNLHhr1gtEFCYI0s5xxGzSZ/iKKyskO7y6QlOoWkHIsicctf6EZzDv6Fbh8ewFbnN6Leb4zI82H8mw7xQyClsn6kLUTTGOrfjxUt/8pjsjHEE7ahFDRpEl/+KS3OGdRr6bO7VeFVKU9YbmYCjvQ8hPFF0tecKXJ9qSQIAGI+WQDXX7yDsOWkt9GXJFauH3smJaKEAmqYfNa9/oOTKUuGAVjdqDfW0h9acBWqZEW1vD0mdKol5nrklUytHJ9WDl2KD6BDJXiZFt6YpLajlW5gUQeXeZgci00ubwe+cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNWwGi3Etzb+213OpGf8Y2g1AEt5AKZaDKQ6Chs600A=;
 b=JknJYtDqUS8WBtgdFBB/jNiTA85p9d4k+S2s7+8rC765DhGPBvmrwXSt598fGiUH99qdLz9F2ioFbvOq3nVICGcA3WBsupqbWhcM55BC1gSaE4uYYly9axkl/TFL0jsebUCLi4CXoOMEkrAVJMCenKtOXyXtUdvKYKTLSMgMPN18yeZ1r8VhOIzLZ4bFAvBKANdTppLiwteCm+ppXwOkskyTBXmwEAXtWrYPEEkLfkmA5UtDfzk+h4SKMV9uq/+rK7W03NxIJo38axl+WSW6NlDfrS7wGhVUwTxaPwMCd+pUZtbMNLI5xdmXxRkFZPDU/r7WtIiDoX2Coq0cHmXDDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 28 Aug
 2026 03:35:55 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 03:35:54 +0000
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
Subject: [PATCH v5 01/11] gpu: nova-core: Add public driver API to nova-core
Date: Fri, 28 Aug 2026 13:35:21 +1000
Message-ID: <20260828033531.1117754-2-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260828033531.1117754-1-apopple@nvidia.com>
References: <20260828033531.1117754-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0116.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20b::11) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|SA1PR12MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 42514222-5dbe-416d-475d-08df04b57756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|23010399003|6133799003|7136999003|11063799006|56012099006|10067099003|11062099010|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yQKbuWMPzxlxH5yqGwEmMgsdxAykm5JOKiya5dQuBZ0SF3FxMWjFL1nCAYESwGk4XMLMWafisykyCsMtDQGHtMR6HISRfttmBR47eX4+T5LnbpPbob/GL2YMKYPHKd9pfZ7opcIwiIRplISZs3yaNSrA4n5gFyxWh75k39k1p3TrD7c7LxR1tPrrsuCmoOurkgLj4FQPY98rlNFRJt8yz3paIYLtGRkvDudm9dM+cGS6HOiG15v2pfXY33snriHaGYocFdXYlT2mU67k3ORLneJiGO6yDEiD3wt0ekbR/Kea+t3ytFaZXj1Sp782EsueN7CTDzOrv3jRvKcaPcpYwjHiRjHw1Jt3HX2YRk774qNMi43dBhccicc4S9v946ABE7fgDiH/sjQ1DfJ5/3ncmZjV7BsgQ8MkYvWmF5nvR8J6O9AwTUdycHz+ZtvTB7i5XbNXxaqC7qoVwMfr54rVgufFpcuHSwJ35aMmvSYQQJ4MF8tyRtK8XeLV2mUa5K0RIC95EaZij5YiV6BHfKbnAss+AmzwDwoLbDKmYnZvXeNMkwZwC1/AwuvQ819k0wutxd2HIVtauEfTH2D47ynPk6GcaZHDuc4tFuKSGghf0AV7rod5GOaVkp54ebY2LVTczX/pAiCzLxg0CnHe+rblyeD/2j0ojXJyJNHYsvVSNTw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(6133799003)(7136999003)(11063799006)(56012099006)(10067099003)(11062099010)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SgFSeeshLP0TNa+TnERDJ9jOLPN/ioGTAEe1d076su84UhC2AdubxspmZPtw?=
 =?us-ascii?Q?QYoVgFQPZaeoDHF5IT/9rzO/vLa7tyWLgvm72i+A+3NvcXP5//z6nffcOq0r?=
 =?us-ascii?Q?0lyf0H++cm6NtKwc3FIxgJGutLF0WGxjDAiOYvrgakMfbvwXisIE6AO03bTH?=
 =?us-ascii?Q?04N3o5I+T2LLj+xTcoWTw3EPSh74uF7KpYp6gLsbg6JwLo98DELaVOTyDaH4?=
 =?us-ascii?Q?Eexm6yDMyCAkrEPin2UNOsHi2X4484oZ+AMLmPv2iw1dXSh50bvoAaACIEpj?=
 =?us-ascii?Q?w7PQgKvaNbbGFwJM7ltU9ncL5Ycp8iE/nIBbn8XtkzgsWbV1bj07xs9TAzM8?=
 =?us-ascii?Q?oDMMe0ohj/lu7e5K1J110+Ms7NpGxEWh2uu7CxmaAfqjqPh0kMbzGkbpIRvG?=
 =?us-ascii?Q?iqIogxkV5XvUSMGk7KTzO9RDdFHuRRAxO3S0d+gTajkplbPAP9W0IbG3cejR?=
 =?us-ascii?Q?Dp6/TDWXoRqa3RKbwmlIHB1BemcXVSybSjBS5nOsONxJmFLLoeI9370jZsSK?=
 =?us-ascii?Q?kgm/tZKvHsNh3DOE1a6IBydvMDVePkgoB0vNlH0nbUMpR4FNnAqPuAJdXMcK?=
 =?us-ascii?Q?DDzIr1DWZShs0jrH8LziKci8BFKH6rCeMlsBugWaC8CbRIaJnYT3dwE6umJL?=
 =?us-ascii?Q?WmtdiLQNxCjKfW/6VMarnC+giKrMEj2yAxqF/ywUzfS4n5BbKdoG4Q5DW1jb?=
 =?us-ascii?Q?7WTDE40cfTM8jGxTuKXI5kGoJWL27gATttr+Ia8eF2s50JdNGds/Pxaw2nhn?=
 =?us-ascii?Q?a5Kf0xl73FGEpwVQhu/LnctOYcEqJyghyKRuF2jx8wYyI2JtQpFqfccfE3D0?=
 =?us-ascii?Q?iHxxJDuVOGQ40B9klwVJxIWt3Xq5m9QuVzS1cRsy428+r4/n36ULuhVSd5Da?=
 =?us-ascii?Q?p1nSKej5vlLgunHFP0UPpP3NZWHPg2m4totyYNBrTS5jISL384r7FsyNffkc?=
 =?us-ascii?Q?p/GKr1sKOeV/gMagx6KuDPS6b1pGYG0mjKveCzBFa5hNJsfMiT+LV2EO5qkA?=
 =?us-ascii?Q?s91EE0ZrZom4sux0DVE/m3W0xNJrr6bg5iQ5NeCfegdxxhL22G8A/UnkWwWP?=
 =?us-ascii?Q?s8086A2cR3eYoeki/WV/eY2wigOJB8mX9tPpDmvgmK4B6FBtmjKmz8QJbpGq?=
 =?us-ascii?Q?WM8mOlF5RPBmGB0B2HnERkn15rwfOvOKnsRKs8YFqhF5GPFycdukJBMJg09M?=
 =?us-ascii?Q?Xf78382v0bm+v/+M83r7cgOxoByRSjmw6SYWGTzDl2/Rq8UF3VKfzOO00f8X?=
 =?us-ascii?Q?SvKMTpqBwitYVYEuxKPqCHJSq3YyLHGCphNOF5bqCNI4DXYviTUkaygB4b2Z?=
 =?us-ascii?Q?U9z1Vmtof9k6OlfTaI5RneWDRz9UJDvlhBAohFURRS9Hk25fM82j40h2mm+R?=
 =?us-ascii?Q?S4J07x52pfXsOdk+xelrDIw5AGRo4GH/0U3k8fguESd/I44agshQtsA7Ru12?=
 =?us-ascii?Q?7bg5eQsB8jsNEFp0A9DJGzLftLoBj3J5gaV2wmaPYqaHDXvTDN8s5+qipPw0?=
 =?us-ascii?Q?oQsKUNxNjPB426X+ZH9vE0bG9LqVE5nVcQQsVkrPx9zW6/CGGpjlCUY09Qj0?=
 =?us-ascii?Q?R/dUioTNLplL0Bln1LdbmRRpA4SWUIrOykjx3jsDYrka26L8KnksxeL8UnSr?=
 =?us-ascii?Q?o61jBhVwW3iRSRhYpDQJvDfCohnLuYD8s3Km8tSUvnPMFi9Lwq3o9OKcWxu7?=
 =?us-ascii?Q?piJ6aXh6plQbrY7dWcmP2MsbjjQTWn7IRS7WWeLFxx2wL2kUIBz+r6hqtKsq?=
 =?us-ascii?Q?4Y/IjuYrlA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42514222-5dbe-416d-475d-08df04b57756
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 03:35:54.8747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KsVK2viHdlSHQ4hmvchchr0LmUG+7FdzgnwrcYB0QXMFNfhXmgG/j+Xa24O/jWyaz1LUDWZUxsekS/u81Zc2bA==
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

Nova core will be used to export core functionality to other drivers
which will bind to it via auxiliary bus devices. Add a NovaCoreApi type
which drivers can use to call nova-core methods.

Auxiliary bus drivers can obtain a handle to call nova-core methods on
a particular GPU using NovaCoreApi::of(). This takes a reference to a
bound auxiliary bus device and returns a handle to NovaCoreApi.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

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
 drivers/gpu/nova-core/api.rs       | 29 +++++++++++++++++++
 drivers/gpu/nova-core/driver.rs    | 46 +++++++++++++++++++++---------
 drivers/gpu/nova-core/gsp/hal.rs   |  2 +-
 drivers/gpu/nova-core/nova_core.rs |  1 +
 4 files changed, 64 insertions(+), 14 deletions(-)
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
index 48380ac15f68..078a3371a7d6 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -18,18 +18,21 @@
     types::CovariantForLt,
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
+    _reg: auxiliary::Registration<'bound, CovariantForLt!(NovaCoreApi<'_>)>,
     #[pin]
     pub(crate) gpu: Gpu<'bound>,
     bar: pci::Bar<'bound, BAR0_SIZE>,
-    #[allow(clippy::type_complexity)]
-    _reg: auxiliary::Registration<'bound, CovariantForLt!(())>,
 }
 
 pub(crate) struct NovaCoreDriver;
@@ -83,18 +86,35 @@ fn probe<'bound>(
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

