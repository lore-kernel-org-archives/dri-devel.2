Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D2FC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 05:34:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4044B10E740;
	Mon,  6 Jul 2026 05:34:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="G39AoaPQ";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012066.outbound.protection.outlook.com
 [40.93.195.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5066810E740
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 05:34:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLCUI1KUnJyQ9mJosC5qaNWPP+HoG2551k+kQEyOiOM7U//eO2u0tj5eGL2UI/uAly3iwHXYp1qbtMPG8Y9psxK0TYZmmfKOIHVCWWR3uRUq4HlhyX2AtcSeufbCVoFuS3S+o95ff8/sfiv+ffwSROtu3OrQNsmZkLEcoXyNeqMffTdiceyJtTclqwkNFlHXQYYgqGsR5QXbHYYd1R8Dr9mCHYudLRINRm7HXVh79ogZvSAhFWnSppZMlMVWgm2W8OY3xfqSnJhWI63J3My5Z7ZtVhNn+F2TYdwsM+JlJXN4sytr1F5FPl77lRx36EVmmu9Hi03f8OI3uD/HPBV9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vaz/E3f8yNvLw7q17uWn7a0kRPJ0HMM6R5S0A7kCNBY=;
 b=aFtZ98/hy53YC2HOuBp1/bpg5A8LuBzIKTZgrMGl+lyJruAvNvTl5eeSOLBQAVHnI7E9xSCqESDy87xtkPL8Gs/JT4WOFtOBdWAGGc7O7uyRjovCpEnQXA/jTQ6O4Gn356P+CTqTV6jdB/X3dO2Pa7dzqkGhedzl5tz4sRvhhG6UWJQxkwV52Q10O9mbkpw5eUXaxMdt2Av4m9fYDOVZbInEXc+GB7KRL0fH8b+dQUADCPtwu0H45SIO/mzCK75HbkW0hmQrwzcKCY3vRnWL2WlAoWR2fzEcCM0QIBiKh5IiPZaZ6GZN4+oLNPbM0OYkl1EDbwN0lbhM5wVJYSC68Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vaz/E3f8yNvLw7q17uWn7a0kRPJ0HMM6R5S0A7kCNBY=;
 b=G39AoaPQ7CRXTJzSNsPpcnNQJzdiBRFgZHU2Yh598NIFGfgUP3yyObcqKouIHStl7ccKjXvW/zKzuI1F7RZh3BOyLXKKEvnva+PRo/DmKrdYjDsBH4MP/V6fltK7PZhCCww/IqkJOWpXgSnEw/rCVL6rERouA3i1W6N16FOwExN1iLqiiZsCMNkpnV5xKrdDkpxOGbSAQZuQUUv5R2tSix0bh9FOJ9mcGkwDQn1Rio+zo0YGuM2pCiEvc535nzzwJRFBYPecKsyCZ2sH2kSG6BsMAR7dWDwlNglusv2bLWB9og886LDhbu6n1//LUGMDwxHrb51NuI88PjlLakRwzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Mon, 6 Jul 2026 05:34:39 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 05:34:39 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu@lists.linux.dev
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH 1/4] gpu: nova-core: Add public driver API to nova-core
Date: Mon,  6 Jul 2026 15:34:09 +1000
Message-ID: <20260706053413.154135-2-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706053413.154135-1-apopple@nvidia.com>
References: <20260706053413.154135-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0010.ausprd01.prod.outlook.com
 (2603:10c6:10:1fa::19) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: f0505f55-eb57-4ded-3b50-08dedb20460d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7136999003|22082099003|18002099003|11062099010|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 1gpOCQa1vFpUSxkQt7CA3OAxg6vvKvXcxKzZ9w9Y28lAHecZ8wF0B/9x6RTVhr2yjjY2Jdu7SPOpGNh/8OQNcIRy/62HaYQ1nMNmIqaTIo6wHdHsTxgaXoZ88uTPhpcnWlV3iYSjFeqWKsSxDkRtHsS510YKlCivFEIfhMl4DcFmXS3voW3U2+pwpKsCxJBVJxmaUqRyqkwLLx3MRT1NbrH9IZJGsCi57+wVLk8WeLP6RPPQDo8Vmseb40UNqp9LjcfLuMnXR8CRXiy/PF/EeyNg1I/RzAs7sTNzBJzYq3qRJqcW6r84FY/CscEuI/ZxtEvBo6qPC1K/NO2zljoXoveC3zNajsHBg45UeQOYYSNuGuNc8OQKK5M6Pp7eXWgcWcP8pwAvkprVkA0MJHndQozTC7vo9N9z9v1usT/jIY2Y/8jwsyU/YwbaX1Hg1g7bXUqqoOc60M6i0LcAArXM/z7gNJCE4ANJGh4r6J2wbTAl6suTTJEBMhl7269pEthPW79kqL/E5N7tEir6YARiLhczG8GvdjMVZRKTCkx8BgnWFRXGzB2Cn9R8ViPE9mMhrNC9DLMV0PTDwN65hVuN3E0FlWOcc7ykeDlSZnI5LWBCCggWEt9gDJLPA84AGW6eryZ0op2KlfQlnfJVLMURTAVZHwkiAwIRky8moDuiH2c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7136999003)(22082099003)(18002099003)(11062099010)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CxUhmSlX92iEsOgI6As6WLzDeNVhj9Sa5YYjjEl3lm1FPe59fQJ32UkOWpB6?=
 =?us-ascii?Q?soUuc4mE5F236XeFEO9+VAZJeQud6HTQEjV/9XBudxwH7aN8rXnvZdtIUKSb?=
 =?us-ascii?Q?C6yUhX3NCafsLzXKCz0LPBpS+Flj+6CNSUA7i2voXJb7vLHqwaSzaBPJSFG/?=
 =?us-ascii?Q?5wg2jVZrHZwl7vwbbS4bQS/ADFW38V9ljmD5GW+VjYJgJmA9qgufGXdokImt?=
 =?us-ascii?Q?lazW9g7nKGA/Ouji8S4eWUtfktBFZ9LUi8pLAOy4vJ10BfKn5lAEGiU1nBZq?=
 =?us-ascii?Q?10+m4lTVcmq0vL8fQf43b6m+ri4bkRnCEWIpTvhrMB5pGdLhhxu83oFKSAjY?=
 =?us-ascii?Q?IuhYVF+TrKF6Au/7C9IzyqfWNhz4ym/S5VWDE0moC8jbt7vAtkfZ3rDNS4yx?=
 =?us-ascii?Q?F/880P+/5ZbQpKjXuVlyK9EILiNyHOL4yAkVlwZGIV1og8oARpmMm7BkHCC8?=
 =?us-ascii?Q?VXz9nHri0GI8UikvZq9SkLSVlrpua8kf1rrxQHPfRen036vwBgPQigG8eF8J?=
 =?us-ascii?Q?izDTlBQHBD2/nLERxEpqTJJOw3a/ZYQErq+1wvJIIt0J60MWmbsQVMoGlzXS?=
 =?us-ascii?Q?t7uFhCHyGnNCQ+n6eIgmHdEFhnObSzDRGHB0We0vzy5qVVYECuaxtgBC49Rk?=
 =?us-ascii?Q?k5TrmN6HDtPEwecCFQVlgWpxV6+7x4lsjT49lN8l9+2st9oSVboCyJRPnfrh?=
 =?us-ascii?Q?OvtcMEwfbxSFq+KRvZqwGxlivezqWwePZ+66XzCy4w7qRVQ8jrsJYhFaUyQS?=
 =?us-ascii?Q?n7dW4rvxZXo7GeMq3D7QVaINwgme9PgqswOXq8X7dyTUYc9y/ZwtbAf1CkoH?=
 =?us-ascii?Q?S7+LY4LSV6XHLf9OLBDMnTOqMSc34wXYAZ2HN2VcyICIjuqv7phDjjDFZwab?=
 =?us-ascii?Q?H8iC3SH9jYYm+lX+JsAsVmRfsYlrqyITLvsXtrSiwfKz5npRgEWjz/NbZk0/?=
 =?us-ascii?Q?+zvjFj4E5hPTq3J+wJuPkT/t5d/r2e88lzOfwEhm+s7ji9cHYTa7BMwXp3Bm?=
 =?us-ascii?Q?eOVuOa5Md5lsJZn0DELlg82P5dT1aboiTuORIat1Jb8mLFRRfjYWV/9wHGqw?=
 =?us-ascii?Q?qUq0CLJszA2JCdIvoP5UCXjaWDSmcXewe/+GuZus1fdBlbtCCKg4IYxP0fzQ?=
 =?us-ascii?Q?sToCNnfqDAJPEUDy/1maItCkSWovRJM4+asmpTa5FSIs/goXbzfaQAslS+z7?=
 =?us-ascii?Q?45k1mvWDoMfYnbSbkUP3b9yZV1fVvLNpXeZ8ua+GTNoDfLiGGQdVfJJe/UK1?=
 =?us-ascii?Q?nx//MR1rjKXH6BuHfxxV6/AGUwYmgHy93UwdMaBo6EZY0G1UQhuUffPb4oJ+?=
 =?us-ascii?Q?Eez+B3ZY/Ue6BYWz5w/PC89D6cAFhNIZMU7eG738VwjpDwfI3VWBkh/wJJRR?=
 =?us-ascii?Q?oYt+NayOaiD5cdBbJwpSsImShf2v+eTq9huA4wS+X050J9UeVgXXxFRFMopg?=
 =?us-ascii?Q?mbzalaLSHuMrbAftJ5Bm4WXCeGMnwo4BeQeGzgPWIgo81aV6OQn3j7hMYQQ5?=
 =?us-ascii?Q?bsiBT3BoKFVNz3VW3lrPdi12h1ygfQI6qjWijWU0DBP4MV0gn7mmSxdHqXIN?=
 =?us-ascii?Q?0K5F44EesVLOB1JU4srNEYT7DhGjfVQT7hzcEJV+/nOkyG69/4X0UIzIzJfu?=
 =?us-ascii?Q?yYDBJSFkEVZ/8/enOmZsUayD2RCsrhfYA3/JUX3lFhQwoxVLWAWEpZHEZGdu?=
 =?us-ascii?Q?IrKRnAsE1+69pecXIiCnGuhXUaveNIXbO3xhtifmVlL4ygCZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0505f55-eb57-4ded-3b50-08dedb20460d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 05:34:39.7555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VBAtTvRzCdDdZX+DHPkxGOHmg8rywQO19OPQ0JCjtKFtqOCqG5zb3OK1GhtJGDTQ+2+XGuQHEHUKghU0I0+0Ig==
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

Nova core will be used to export core functionality to other drivers
which will bind to it via auxiliary bus devices. Add a NovaCoreApi type
which drivers can use to call nova-core methods.

Auxiliary bus drivers can obtain a handle to call nova-core methods on
a particular GPU using NovaCoreApi::of(). This takes a reference to a
bound auxiliary bus device and returns a handle to NovaCoreApi.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 drivers/gpu/nova-core/api.rs       | 29 +++++++++++++++++++
 drivers/gpu/nova-core/driver.rs    | 45 ++++++++++++++++++++++--------
 drivers/gpu/nova-core/gsp/hal.rs   |  2 +-
 drivers/gpu/nova-core/nova_core.rs |  1 +
 4 files changed, 65 insertions(+), 12 deletions(-)
 create mode 100644 drivers/gpu/nova-core/api.rs

diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
new file mode 100644
index 000000000000..68ba8bda800a
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
+    #[allow(dead_code)]
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
index 48380ac15f68..c3c2acd72368 100644
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
@@ -86,15 +90,34 @@ fn probe<'bound>(
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
+                        NovaCoreApi {
+                            // TODO: Use `&gpu` self-referential pin-init syntax once available.
+                            //
+                            // SAFETY: `gpu` is initialized before this expression is evaluated
+                            // (`try_pin_init!()` initializes fields in declaration order), lives at
+                            // a pinned stable address, and is dropped after `_reg` (struct field
+                            // drop order).
+                            gpu: Pin::new_unchecked(
+                                &*core::ptr::from_ref(gpu.as_ref().get_ref()),
+                            ),
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
index 735b8e17c6b6..2d48d16a6ee8 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -13,6 +13,7 @@
 #[macro_use]
 mod bitfield;
 
+pub mod api;
 mod driver;
 mod falcon;
 mod fb;
-- 
2.54.0

