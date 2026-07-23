Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4B9C531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 06:31:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9004810E532;
	Thu, 23 Jul 2026 06:31:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Llb/Mg25";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C08B910E532
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 06:31:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GcqTMl3LW0PPH5Vu9kQACk+uwO91C4bnVD2To5omzh5A+AQZI2s/6avaWDSbZNEh71GoKVCUfDyXeDYdCCYX6+mSYmMJ6czWmLDDHREto7a+IzYVt0zUsf7KTez8W5hkqjd7WhP2gykeXkwM/VDzCPTx1rANh9Ag5ka3VeuHt0NYQKtG6rxGDqg4jpJiC/Mx3dQoWWLjvVgaw/AJsC4is99PT+5ujrWPG4qDdYST/Vd1FmLziJYgebUUhUdCaJlpMIxDE9AqIHxcfQ/mZjH884oh6RPyiimMPikcb/dR3FS5m6XtHcB8MTDCR8HcglEv8+NRcv8nNMezh/TrkBVXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pK85dY0gD1M9cTizVA3NqfSs3DtmmpADmzchfQDJ49A=;
 b=tI+GQwL0ZvSWlipSy3ZIb3SNdOJGldFNdcBtUSSLRV0hhydOeJwUqa41C9LUeO8hfuqBmvltCUd/RI0Kn+TfrPDEsFm9LOvWzswU6qOqgvMHvg7NmVBnrzNZ7oEZ80ncWQbhBUIFHM1137UHOb/LK8a5DoTLRowcPYpTJT5ZclJAYVCrHHnN1sj3nAoN2Dax+Y2uV5GqrVYBzCJqH37dTXXoL4uNG2ueIIoT7pPdXcBmHOvlUy5TA8kt2Bj9ERPr1Y+wbJkEHIUJqLTe4zYOI4Fh2eGwGXKDkk2R4nG/BgK9G0B3FxmnR+FU67gRgIZK07Aq/Ln6W3LSBNWK87F6Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pK85dY0gD1M9cTizVA3NqfSs3DtmmpADmzchfQDJ49A=;
 b=Llb/Mg25R7DKqkjV/EUPOqipyndAZj6OlPg9EJUuQWQmD1u77oQUEFTDUtLQjA+R5Ow2JYR40fEjmx2LM2oRQQC71Qd4n+URgHYgOD78c42958ATEPdqmocGkC6p5R2BttrdHMoVeWH9ZAOSSnd2HoL1aaBEqnysc8HiylDDDrhekm2b96CfbL0Anafu8nWJR9wCHg4Xo71yCYcsYeV4nDH5Dj+XueEnPMJQpsmFkP8q1yrjYvJov1LUhngFXYuhwLXoQdbw4CfOfudD0qD63x3nZH8y8gkM1gIwN+ITVu1oSPmJyAfYfxVu9mr3jOzBYA+lUjpnJmMW3auT78h5Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH1PPF0316D269B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::604)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 06:31:02 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 06:31:02 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu@lists.linux.dev
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v3 1/7] gpu: nova-core: Add public driver API to nova-core
Date: Thu, 23 Jul 2026 16:30:39 +1000
Message-ID: <20260723063046.1265791-2-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723063046.1265791-1-apopple@nvidia.com>
References: <20260723063046.1265791-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0173.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:24a::27) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH1PPF0316D269B:EE_
X-MS-Office365-Filtering-Correlation-Id: 06fe1a39-cffd-4b5b-1df9-08dee883f758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|56012099006|11063799006|10067099003|7136999003|11062099010|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: S6OEm7cLdFZ86hNrcTIK2sMj1k/f2jnNGV6Rc5etRwEseXuPjYIs37mLGzP+4XEeUAUInYKavgXtF7VHJioNyXC0fjNi0HnFMQuXfCbuZbVcw89K0iHIQQmugYu9xHHFbTRgo8yzUYdf+OFxQ3LRYeaFlp+lZRsSKeRIdE/9NNCoYRq1sqQAd2D8T6APfPSJJhbOClTVP24NRwCBuLZY06dBvIdRQhVDWQGHwQQr4RK5xICIsCZPXg7Wo8zRRD7jGB7Lh7LHqiZW1CHJyXLhlrXdUjDSAOipIqfoDfxLu3r22JzfmxSqwOfySfTJkUYqueeI8zuFWuTuPvLgoM3sLdvcJ6P3JDFg1HyNGmvyvdCj2GaFDdCDJYpFw3hjXP9DcJHg8dTHOMSgzmoLWy3MdY7z6Oz6KWwXnJwN2dszUkqHEeY3hIgcrWoJwX/+dqYkrD64BIuwRcM/fggjbnifhi4KGKRESmTaRp4JT06ygXRbkgM91RtRsbh9HTakaY6tQnQuM/GO2dG2oL7zuku43ZlrXMAaogyVjhRILa5Jd6Xn/hoTo/4xLWys6bTUWgJ+ojiOncKDUezAo1MRNTY7jK3GRz6zcw3DtKAa4DZjTCB2NXU3cgAQjxNWWo2Oam0VXdwXPPYkD8/C1Hmca5mrTOQw+AZllJsa4PDBw+ipfHk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(56012099006)(11063799006)(10067099003)(7136999003)(11062099010)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XwvFDta2diQ85FtD13xnlXH600yxb6ZNuxdnhxRRbDah0jyaNClpblKXW4+L?=
 =?us-ascii?Q?1JvVXTCb+RT81zvcNlYjJO22D7uBk80zATFBEXC7j4lJBr2NFh4O/mG5nRiT?=
 =?us-ascii?Q?e36ZuHgaOKoxEYDmoKS2OJTjRJ8YXbydhLQ02mHZYifGnBx3yqkZmhSpgmrO?=
 =?us-ascii?Q?rUeIStMWiDq/CqWRG7lrsaLdRXpxqCugwJUnsDnpT/Ei4/HLeZItkS0IQYXa?=
 =?us-ascii?Q?HoQo99UzN2R8xUYWxpSWpfs/4JRIe0Z7GLBTFDgSqDwe5TER0EDrNMMLFnpN?=
 =?us-ascii?Q?Xr/UsLxY+k5lHUeUHqjzUF9NbMPtKTBfaNzvyvyn/PgSbhb2m0vpCmoCx+aO?=
 =?us-ascii?Q?mT1iy1I+Fn5ALglhtwLl4eb85KjlrTE/2kTp2Xwc5dOvh1ZAFDfsI40oz7Rx?=
 =?us-ascii?Q?CnoQgp4y+L28yc4MJS1oVxEijTr2XGpZ3J16reExl6osJ2Q3R+2CicmwPhHi?=
 =?us-ascii?Q?1LTniHdvJIsoNwPMGkcGBKdf/dRbq9/e8xUWRYwtIKtzAx2DCrmOmsEl3Uew?=
 =?us-ascii?Q?Ez1FLoJ8RzwwzoX7IC1lvTiSDkcslAerOmlzaViBwByJS/8kZozyuMGjHNNr?=
 =?us-ascii?Q?UAkThhAhrEj2Exm6WF1yi17cDdwOqHVtNQUAuYW6qIa1qq2HTGrNvXHcamcE?=
 =?us-ascii?Q?qEAfxXTwgFjfnvDKmNOvDDTt4QfoT5ZGQo9NR+88YuxKsMS3CgEnevgkJdZ+?=
 =?us-ascii?Q?RBH+TC+Fypk7FesrYe/MJNYv0VDq3Rk8jDfdJVmpjfUv1rpWVAfM1q/WYCy7?=
 =?us-ascii?Q?dSgLK5CyYcKm5scPQ/AwNPHk0oejKsHZVpDisL9eebOkkldNM3QhzM8dkonG?=
 =?us-ascii?Q?gZ01Cw3cNTkq8hIxaj1oXK4sVLR3eIreXA9/gf+7g59SxxeEGN2M//IX+aeF?=
 =?us-ascii?Q?uX+KGl3G4v2himQIjhEdBRfpnlTig7PU0yOirzAAzERCGZNIC6YgggJuNobK?=
 =?us-ascii?Q?Xsvu8tWK6jHngEaJKY/pxes0eUA7Gu3zLHzojOQibVgKJYQwrnSVN0/H940F?=
 =?us-ascii?Q?uE2IlFAqeK+cEtdL3cBtv9yqUBLG70My1iE55jCuQMAqj4tO954C++aEaOD4?=
 =?us-ascii?Q?JArrFQDNXzsAYCBKGJQkCuPXjqoLL9vijLM3+g8/IWuotQdNl88/zxmQok+i?=
 =?us-ascii?Q?/B7ycu1Srr9+N22FxmeKZbxVjATpn5IEZDo88RbQqtzovzxULt7zZt2jRFrx?=
 =?us-ascii?Q?HYj4SMkb4vd/ya2mBaAxW6Q90rXGDP7X7owxu/SyPk0J8nhkCdgdHdv5STIW?=
 =?us-ascii?Q?7jC7wxeKB1FmJapR0HpbhZ6/d/Oj67xj/BvAUxgtcxQGCaEWIKl4E6EmgxAI?=
 =?us-ascii?Q?VE0S9JZrGxWCnvxpLhU45grraTiI2zjINV2esvOpjga+QOwgw/QAEI/jknyB?=
 =?us-ascii?Q?LGTSPoVDIUXWe5x8gTmbznOAujGcSRvGz1zyRAgGlP4+uIEuL0d8KQCAK7CQ?=
 =?us-ascii?Q?zff525+64+wKvq8PPjNFjpdkUJfjmktitZVZTH7CFsSqQa8mAYXwx6FLtaCH?=
 =?us-ascii?Q?dS5WEDqMHvhXOqr6Btpq5YZRf0k8N7AgWjQsfFKabSO0pWYWcr3txe5Fcvzs?=
 =?us-ascii?Q?qOL787eBbC+tkXXsoV4pmNhzpAMMvu+8t7JZlXkgRn0KgRbr9z1P8QHrjl03?=
 =?us-ascii?Q?eUU9Ir7CRmF7xGQ/SzJEqCxKu8o9UCPsB8w+DiO4od71JfR+p1kJR3ATZtT6?=
 =?us-ascii?Q?lydBZ6BraN8j/vgnJKfPFv1QYw31hRy1BJ/Urs8kL9Lo+bRaA4sKMTMAI+Tq?=
 =?us-ascii?Q?etwBI+yG/w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fe1a39-cffd-4b5b-1df9-08dee883f758
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 06:31:02.3325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qP9HNcYYJO3/Bp+wIQKdQZrF32lgvSj48mmT/1yNr7Xu3bMX//c6HPBSA5JcMNduYxO3ROoq22PZUV7Te1jyw==
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

