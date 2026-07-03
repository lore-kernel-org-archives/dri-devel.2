Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E271C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 06:45:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 364C710E584;
	Fri,  3 Jul 2026 06:45:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="hndXrGlP";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012017.outbound.protection.outlook.com [52.101.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62A8D10E584
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 06:45:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTtHkhvgHEVx9fji+Blj0tM/6CrV4EV3YydCw3lNPITmCiY22TZ2sDLEnizWSFEzLAncHohAJHy0V5W8iCKoi2gWnrwZJSXKY6g9j7D+gEebxezBSRU15eCWjrT8TBcSu6dFufWCBftUNgmmCAeWxawb0ijN/sHgrs2PdEXx3MkhRfcpDdl1v5InBFOIWKaeg7xmh5xMaTWX3rKgB2ETU03zK+8ciUr3VtYg9reMnJHbH/3cN6KY4p/rnC+mZ5Bpn9gn+OubWkobrHi7XqJZ5y2SP4qDpUvmWGu4o/bWYJb+endSHmfUIB7jd7O59vuxNjrtnuN+2xUB1vl1KHizPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKikBrf3wJkoJxXlv4DTFJCluL7Yx/nhtUwNXaG04zU=;
 b=Ji3U6ECZX0BZlhpyOR1dGv+1VQgc89x2of5RHKN8qStvHqEbn1znLJM1aSEC0K+Zzrp9bBZAM4hzLUGamX/tiI5Op1+3awjxIdI/waw34S9ipaySOYvLOVhaTnIz3EFuPfD0ek3adn34O5UtJ13L5/VRleckSHH/mTwbMTPp0DZz+b/B/oV0MT3mlHxAbdrLO2Au+n40LWezydr5mfJfB3HGeYruCCcLYuJII8hiCNqGVsoqOqgR6pLLVqJYTHXc5WLNtv5HwGsDxj6l5z7U1v3dQTR9Mqg6RA8DGHG43IQCXHudG9XmgVnetI8zQ6akrbOWAJ7EoijXmCs37ROadQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKikBrf3wJkoJxXlv4DTFJCluL7Yx/nhtUwNXaG04zU=;
 b=hndXrGlPqOGEX+KRlL6mpjSa13f3qMSIo4Z7cHymFBPAtkimY2zUb9LM+ljtNJokYWjRrIMLwKKaAGbkH1kv3eVUBN1BnvTPx9b++DQ0/sxlnOJOzDy+k8SmZuN8apvAWeTyLaEUh16E/Jqwu1up3uVLIvMIc10Q052QwsYg8DLaqIsdzPofAzLi4utyyuDliXufL43QJdVtIS3SqNjq1Gakrd9lzU+9HLHawffaRJFzyJmFnwwPYkJZvzFBo8U5/cVGGez0KiBtLBnrLoUiIdwCQ01YTWKeIDS63nSrOi4bU8+FxjE0IsYTw48/4JkgWyBvkh68X/NMmZbHnOTgfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 06:45:42 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 06:45:42 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu@lists.linux.dev
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [RFC 1/3] gpu: nova-core: Add auxiliary bus registration data to
 nova-core
Date: Fri,  3 Jul 2026 16:45:24 +1000
Message-ID: <20260703064526.3630668-2-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703064526.3630668-1-apopple@nvidia.com>
References: <20260703064526.3630668-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY8P282CA0010.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:29b::29) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SA1PR12MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: 5226693f-0769-4d0f-4ca6-08ded8ceb3cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|11062099010|18002099003|22082099003|7136999003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: JyEP2d5MIhbvrgeDZzvkuHe6hUzK2ULh3T6YRRC9z7SxfHTPKavwuPr28BNeQwKlg3pCom9EK/s4b2PVbI0CuT9ApMLGtVbPTZnC03WpSILfHufOW+YZ2FVxPyt4woIbP9Sy+ZSBUtwWB/bWStUQfwozRnhX2woTTf9Tb+AlEqxouY0QNgUlzugE9cYkEU6ipf1p1XctEj3uik3p8f2surSoWy9R6NpraQg+lhW7ovQB/YPUMdTpIQDytP5C0d0tCOPNyBSd8sJ1leabhzz+gPDJa9Ss9NyJfiSrtXn0ru99bvaO/m2KNU+HjBoT1Ufj4+YW9UHoxM3jqXgnbKGjJxu5rBOPuQweoN5FzWjmg13Q0Rk14P5hY5qu1Fezg0r9x8Q3pSTfyyd/Lvn7MGZXDrHkZxW8/6F+wM0o7VieSw1NNzfGlFRkol8y4nE4jn53Eftjo4TyKpN60oJQ/1hhpD6SJ+mWRcBrYlBhF1+dTfkfrJr/qqzCFTFTQmoEiKlb17q7ksqgGECYkzBvnuB5k1qgCRU/x6CX43YIkngKVyYhaUSjzdoJ+FnNDlk60/Y7WWSKAGlurxDgIqn1G3fn97zthQHIoTaz7uB5rr5hVEhySE4HRmx64m/82W+vXFkwOzbNjCsq+RsrOcT3hN89JZzFQr8dTiqsN0Q+ZYWm+4U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(11062099010)(18002099003)(22082099003)(7136999003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZJKxZdBe8eKl/sKgfWBWrjd96IXoKx50XvIqHFncQZJlQMe/ZwEtUL6NMBEk?=
 =?us-ascii?Q?xnZsE6cM11WhJkcvjOEhIAl7xuvALxfUUH21mLb8pquViyytQzZ0CreLs+Ja?=
 =?us-ascii?Q?McDym26NNPvYIOzWYyEC9S2wunxhAjxYV3UHwV0inPorM0J24KgZYaqie7MU?=
 =?us-ascii?Q?tyzuy10GPhZbZmXga+bhFvxdB9rRlAuMfc/jsSexhR9KEALQj2ssDibgDGUh?=
 =?us-ascii?Q?tIH/X3nvJ5y6JybJhaNp8OIZUJ7cKBjCYgypjNkZBzrLJWs7ZSuk44Vqchse?=
 =?us-ascii?Q?CJwalT2Q78M6qhqLWGUOZ7GJnbvsXsTu4fJ0E9AFa/b0+qiBhRpI7R1sIWGm?=
 =?us-ascii?Q?1kAbXy+T90oJJZ9IMRzqJbWhZp3+HsZLJSIH/lPva+z9OwYsmFjeUkybTleD?=
 =?us-ascii?Q?lo7xo/exL7zIihEc9g8hf6YOajClCOSxL3S0Ag3hy1Fd8/gGNmhtMofaUg72?=
 =?us-ascii?Q?CCjreWzMi9//hPNvId8zdEpZN2bJn7bihkIpkjEJ2pqV1jMgA6succddHk/f?=
 =?us-ascii?Q?0Inm/6pGrGnHa18bqU37L2RKme7xuvOWX8+rpU/ChYcuGEBE5yvJhZt5invN?=
 =?us-ascii?Q?2tknqr34cdp5JaStHNTgNEqPjgI9iTTJ0uf8pzUuPXVWaoMth08h1bY+FBub?=
 =?us-ascii?Q?wlCdSy4nuhEPAsiPpuk+Rbm1xF5lJAcRPiFQRGF0ACLmGjl4zDTmMwR5xJkj?=
 =?us-ascii?Q?GuG4+PMgadbmHNzYuWfu74rVk5LulanO6tw/DWVXyN0aTSDnKH53g2VcBuK2?=
 =?us-ascii?Q?L26iC9xHEaMf+lcEJjgKVY9q8QIIPkuiLhSslEChR3RvV6ua1TuYnJcrnccr?=
 =?us-ascii?Q?nLv1V+QmXofBs/YLoWWQbzzF/m/bQ43xU6OcUOSaH0XkZknprM3NkMfu9OAR?=
 =?us-ascii?Q?hQAA6cRPP0QEuaf3RO9lWoSBFUCyzwORCs4gXZurbYXfOFrPLsKv7PK+Od2g?=
 =?us-ascii?Q?mB9Ca9Y2DBXSm+QOLqNhjviwdJUr4TQyrNwfJ9vvjXyXHkxGrkyZtcKhsKd1?=
 =?us-ascii?Q?taDiqH/PhEzc52RkLsQPJtAo1tPnf3LKem+L1L94Hl1gc3F5LNBF8jFQvzd7?=
 =?us-ascii?Q?tXs5ZrwRoyIMWmk9YW9MRKb6yWYrh4q1bilYZDFWrlie0H9Iv0zfdTV74sXf?=
 =?us-ascii?Q?WioDwNjyYJRXlSlm9ZfzRrUaWN/Whz4Xwz04eZaNRw82xmwAvJf/Oq2xAMN1?=
 =?us-ascii?Q?qYkHty4uls9MnDHAusznLfLS9RwltNU2K2rxCHb6PPIM0EBQvG0oxLPN9mdm?=
 =?us-ascii?Q?30uPJ6VIbMsoerAOgzSYELWPXq9mn30y7qc8cvjDW7mbayDS3r55aLKSgPya?=
 =?us-ascii?Q?iZmVNKVG7sswKeLWtgJCd50ELYUYBiSgJ9MrWVKVjTVdmG6lycRGbqMcGs04?=
 =?us-ascii?Q?sdOr7sDu/UB8mGQLPXkz203OAk4tWQuLRcv0tsi4We7XxnUKqpZjufvgQD4k?=
 =?us-ascii?Q?82CaJIjqYbg2NdDTzNCkdarH6FOxzTJMLrl5UQpzsf6BxzOvC4UN0zlw2Oc1?=
 =?us-ascii?Q?DI7VgkmTbptRYLIboVvVVcAOmdC954UmEmtHWBDbxFgSPeNJF0oqD6gyI53p?=
 =?us-ascii?Q?vrKYoLONndQ6fjifikIboislhEBRsx4xNa0eKeqawtXAKxzf6WAx5qbPHNm9?=
 =?us-ascii?Q?ifchBSr5q/XOlnkfC9KOU+Rk4hatljENF5HwUiIOZL3mVMJFeIPk3mRGBAi7?=
 =?us-ascii?Q?n0kbis+83O3ovIYanmQXl1QB05Hbka+3Zey2Dhcy3UT4yBLO6UqaQhQ4x2TU?=
 =?us-ascii?Q?9GK5MVNwDg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5226693f-0769-4d0f-4ca6-08ded8ceb3cd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 06:45:42.6647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBb7fkR+pdwoZtiusLaX6gh0nX7zYSf3BDAQOQAVsnACyjkBhmYax0246+LuM1i69w10OmWIS0HDAacOFxmt1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5637
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
which will bind to it via auxiliary bus devices. To access methods on
the nova-core GPU add an AuxData module and type which will implement
the required methods and hold a reference to the associated GPU.

Create an instance of this type when registering the GPU on the auxbus
for use as the auxbus registration data.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 drivers/gpu/nova-core/auxdata.rs   | 12 ++++++++
 drivers/gpu/nova-core/driver.rs    | 45 ++++++++++++++++++++++--------
 drivers/gpu/nova-core/gsp/hal.rs   |  2 +-
 drivers/gpu/nova-core/nova_core.rs |  1 +
 4 files changed, 47 insertions(+), 13 deletions(-)
 create mode 100644 drivers/gpu/nova-core/auxdata.rs

diff --git a/drivers/gpu/nova-core/auxdata.rs b/drivers/gpu/nova-core/auxdata.rs
new file mode 100644
index 000000000000..266b5ce4ee89
--- /dev/null
+++ b/drivers/gpu/nova-core/auxdata.rs
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Nova-core auxbus data. Contains all the methods used by the auxbus drivers
+//! to interact with nova-core.
+
+use crate::gpu::Gpu;
+
+/// Auxiliary bus registration data. Used by the auxbus drivers to call methods on
+/// the GPU.
+pub struct AuxData<'bound> {
+    pub(crate) _gpu: &'bound Gpu<'bound>,
+}
diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 5738d4ac521b..ad232ca11833 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -18,6 +18,7 @@
     types::ForLt,
 };
 
+use crate::auxdata::AuxData;
 use crate::gpu::Gpu;
 
 /// Counter for generating unique auxiliary device IDs.
@@ -25,11 +26,14 @@
 
 #[pin_data]
 pub(crate) struct NovaCore<'bound> {
+    // Fields are dropped in declaration order: unregister the auxiliary
+    // device before dropping `gpu`, and drop `gpu` before `bar` because `Gpu`
+    // borrows `bar`.
+    #[allow(clippy::type_complexity)]
+    _reg: auxiliary::Registration<'bound, ForLt!(AuxData<'_>)>,
     #[pin]
     pub(crate) gpu: Gpu<'bound>,
     bar: pci::Bar<'bound, BAR0_SIZE>,
-    #[allow(clippy::type_complexity)]
-    _reg: auxiliary::Registration<'bound, ForLt!(())>,
 }
 
 pub(crate) struct NovaCoreDriver;
@@ -78,7 +82,7 @@ fn probe<'bound>(
             pdev.enable_device_mem()?;
             pdev.set_master();
 
-            Ok(try_pin_init!(NovaCore {
+            Ok(try_pin_init!(&this in NovaCore {
                 bar: pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core/bar0")?,
                 // TODO: Use `&bar` self-referential pin-init syntax once available.
                 //
@@ -86,15 +90,32 @@ fn probe<'bound>(
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
+                // SAFETY:
+                // - `NovaCore` is dropped when the device is unbound; i.e.
+                //   `mem::forget()` is never called on it.
+                // - `gpu` is initialized above, lives at a pinned stable
+                //   address, and is dropped after `_reg` (struct field drop
+                //   order).
+                _reg: unsafe {
+                    auxiliary::Registration::new_with_lt(
+                        pdev.as_ref(),
+                        c"nova-drm",
+                        // TODO[XARR]: Use XArray or perhaps IDA for proper ID allocation/recycling.
+                        // For now, use a simple atomic counter that never recycles IDs.
+                        AUXILIARY_ID_COUNTER.fetch_add(1, Relaxed),
+                        crate::MODULE_NAME,
+                        AuxData {
+                            // TODO: Use `&gpu` self-referential pin-init syntax once available.
+                            //
+                            // SAFETY: `this.gpu` is initialized before this expression is evaluated
+                            // (`try_pin_init!()` initializes fields in declaration order), lives at
+                            // a pinned stable address, and is dropped after `_reg` (struct field
+                            // drop order).
+                            _gpu: &*core::ptr::from_ref(&this.as_ref().gpu),
+                        },
+                    )?
+                },
             }))
         })
     }
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index d3e47ef206de..06647b2b7894 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -36,7 +36,7 @@
 /// The GSP unload code might run in a situation where we cannot load firmware dynamically (e.g.
 /// because we are in shutdown and the file system is not accessible anymore). Thus, the firmware
 /// required for unloading is prepared at load time, and stored here until it needs to be run.
-pub(super) trait UnloadBundle: Send {
+pub(super) trait UnloadBundle: Send + Sync {
     /// Performs the steps required to properly reset the GSP after it has been stopped.
     fn run(
         &self,
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 735b8e17c6b6..e463f315635f 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -13,6 +13,7 @@
 #[macro_use]
 mod bitfield;
 
+pub mod auxdata;
 mod driver;
 mod falcon;
 mod fb;
-- 
2.54.0

