Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE61C5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B15C10E898;
	Mon, 10 Aug 2026 13:58:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Don6a/ox";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DB1B10E896
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 13:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDQAM5+XFlKPt/Yc6X/vykVzK3GA4qWjdAu/c5NkginkyiyJcneNdP0RIaVuhGv6GKpmiYauC8/6NShid1Yux7Y5CBWMm9rBVrmnJyD34D5okfYlDzFtzXELYs+bC15brmx1jNzFKJvf6mccOtsp9cwDsZxcRYbh2dzc7vDBT7vF9Eyihkp3o2lelcwH3KLwtqoC6e49TLDlTWddF0ycgc6KfT0CO6vO5q9tFa3VIGyYb9I3f4Z76hKZZHqF/0ZNw3FaI7HppW03iDq4bX+Sa8qwE70QUliwrRlU89eCKRkpzf2/+HXhu1YqtNLRRxiZDtchn8zvhLrTUZYgvfE+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gigmGCIOVqvxs2914t+WF719FvdRl53yUroWkDzyx70=;
 b=GfxbcJatFg71mpmzJav2kYwYkgtiBapeCSncYtGlo/SVdoeirrM2qKFAkID+V8ErC7W5/DKMVWP1s1oMEp0awDRnm+93MguPXi/Wd8QOPGXhFAkLT+eIMF9wuJOQNOfgFdZgMLNJkVjiY4q9JFx3rG4whDbWVFGjyTHcsRBqsbpZCz9/q7TythurspV7BMde1iFoObQssS2fGHR9SNgB7Ue7DWAF4MiV9xHHDr4A600xdfrFjFQ76PQACBQJThjkRVGLww50dR1iYsDtmyd8580+/2NXXtzTofudDrVm/R/U6ChTF5cVomKZqeAXc47/+1daAXzAxXowRxfoW2TXqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gigmGCIOVqvxs2914t+WF719FvdRl53yUroWkDzyx70=;
 b=Don6a/oxmNv6nha7yZ5fYcnmnINbj5zQ/FiJcVWt7BWwV638TWvqKJyy7fST1flDw23DCu9z9KnVih3EQen3y9DIQfzC5g50NUYReX3Q+WwOwHFEncB8ipjOAQL1vHy0sUJCFHNxwiD7UqVSG7RbQINrq6NLhxHmDOzNizHh8Wzp2E1KQy8uSEQR79XrQyYS0YNdrwRu1+nDim4U0zKRWkbeFSW+B7IS9OVLd5uO6Fjgte9Zuv9K5RysRf7Y+ieTvCV3KLkMaNHbqIrIzX9a6XGjnRSHaXsXgZtcjOUc3g91SzUhPfPbxQlIj/CagYUfuaEV2ShetfgE0ZlvcINKow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:58:22 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 13:58:22 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 10 Aug 2026 22:55:33 +0900
Subject: [PATCH v2 11/12] gpu: nova-core: Add self-test assertion macros
 and config option
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-pramin-split-v2-11-65a00b3c7309@nvidia.com>
References: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
In-Reply-To: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY6P286CA0030.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7::6) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a94a08d-da1c-44bd-883a-08def6e770e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|10070799003|22082099003|18002099003|11063799006|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: L+2wvCYc3KSZuPpir7AmyNg9bowxF/EGQjYNkFzTBmSclzPqp6ObecSzoWX/g0gJCqv9WvVv8DA8NNF/JVIdkxORWPlbUR0drAEd3j2QTvXZsT9Cnia2DbodHyIR/mpUY7fzCvpx9EOxfc5amIFkh9k83uSYy7YfI/ecWndd3zCjpaTtI+6k68EkYcY//Bzg5g6iqUbwTBuMFfk7fTJNjpIzIh4gG8mPDP9Hf44HXhI4cUvuD2zZeekfC1fkbKK4g2HZeok5wWbczTANm0PxzqBHBawIhWskxvlA9KIxunmI470WctPKlVPLv0FsE63M+RonJ7LT+Kk/IHdQEZpgzdL9pHofEgWz80QMD0rwa0I5DrFNd2wqwheVnlArN8XG2ju4wfH1pIGJof0wNh9Ep9s/yPS50/hsEMofw82MUTs+xO4KDzjoirpxIkEBHJTlDNlk/XZC7owJBCQi3BRncUZS2ViZk7v9ruaiDvt+PGd3cHh9QzHtdOGl2vV2xckIihEUEq/kkRhVN9He/yUr/kXH+M28GbhuPKl8ibVMn29msQWKNbQdhlFVdl6C5w/VtjlQCABk8A2MK4AJLXKY7tF6gLnJk3WRk5+Dq63937BCMioY4TDTD0vYpX52gs4j4YlUt369xItG8N9iIcsu6FODXdGIaRNnFBWT1+1XuXysGAS32ramdG4huV4dsasxgdHGZnnI6CRmcc3sFoZBuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(10070799003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTYyVGc3bGl1SDVnNXoxenlFTDd3akNmUG1qN0ZwMDVUMUNBN21mcGlPSitC?=
 =?utf-8?B?ZHJMN1NyYVc5R3pNOWYxK2p0bzlWZUVubFkwdk1KamZXcDBmOHduOWFrZHpa?=
 =?utf-8?B?bGFteGVTKytScy9sSmpEaGtuSmFCMENiVmVkbVFTOGUzYXlpS2N1OFRreGhJ?=
 =?utf-8?B?S0tlNmpWbXl5Q040UkdhZ0xITnh1OXZXWFhQWU9qY3kxU2Y1TDdVcHp5YWVy?=
 =?utf-8?B?OGVTeUp6bVI5OXVpTWo3YVFnaXNvdmdwcG9kNlFac2NLVTVIZjVJbU96bzJ1?=
 =?utf-8?B?M0I0RUh5Y3JkQkhxSmFSNHBrVGI0NkhyQnM1Q3ZSOExlRFFOZll0V1VsZ0o5?=
 =?utf-8?B?V2JKdkRuZld3WTJSZ1BZcmZ5QkpzTlRoaTNmUmNwMmV4eXhCclJlNWR4YXd3?=
 =?utf-8?B?dWpOaWF5dVBxU3NEMGMybitaT1BxblJZZFk5TkVLZURMTElUNVg3QzNLUUpn?=
 =?utf-8?B?eW0zNDd4cUhISWtPZEdodkJqS2FuUjQzUVVETCtYU243MUVTUVkvZ3VmMDd1?=
 =?utf-8?B?ZGMxbTRKcWtQNXRPY2J5bElPYkpLWS9ZMHFOTklrcnJ6UWtsT3Z3SFhNMFEz?=
 =?utf-8?B?amhzMzdIeEU3ems3QVlNTG4yMVU4dWpnVENUZGd5L1dzZDJBWWgvWVBQOFBx?=
 =?utf-8?B?NCtwUDJCNklPR1BaWHpBQ1Z1Vmt3SUVxT0M3V2NYTlJPZnF5ZmE2L1dNVmtN?=
 =?utf-8?B?QVNtN0hXM0JiVHB2R0pOTk9haW4vTElQejJhVGE0NCs1Rm9RNjBGaWQvRklv?=
 =?utf-8?B?cWhmSEhTRDhVdFFUQUhCWk5lS1VYRmpvZWFOcWRpR2lBVGFnTDRmVkpnR013?=
 =?utf-8?B?MmpNTVZaak1wb0xjK1dKY1JzaDBMQTAzaVBnOGpscWpldE9OUzIwQnluRTgw?=
 =?utf-8?B?ZG5vbXYxT2dLZXZVQThjL203d2J5VmlDMy95L290aEJMQ05wMmhSb25IcVBG?=
 =?utf-8?B?M2tweVVrRk9tZXBNOUdnOHpxTTBramdPcCtZdWp6S0p3aXp6NzJnT1BiSyta?=
 =?utf-8?B?RmtTRFl3T0VFM0NzN01sUU9VY3hqMnRPNDFOWlVQU0lpYUJMQnpmSDhsdDdW?=
 =?utf-8?B?alZiUTZKQnVjOWg1T2RTcFBJbHc2WjdXVFNaNklYSnpZSWtlVUUxaS9qNEtB?=
 =?utf-8?B?R241STJneHBBNFg4djJ6d3l5Y3BGeE5tQjVtckRycFMwZ2xabUY1aDdpdnpu?=
 =?utf-8?B?Ky9sRlZ2RXNJSC9DVi9HS3BJQVVoQ2xPQlpORnlZVlRNVGNFWGh5ZlNlQzd0?=
 =?utf-8?B?UkV4aVBnNkdwK0tYV3BEeEEzYWI2TmVDemp3SG5BVE5tSkcvdTV0M0s2VzYx?=
 =?utf-8?B?aFBSYldDdnQ5OW9TaXlvQUhkckpMTW9VSHQ0bXRhYlUyRVhsT09EcDYxMUF1?=
 =?utf-8?B?NWUzOG12NlhOcHRRa0E3UmdpTmxsNlNKRnlEZTRzaDRtbkw0ejRDYUJSVWF1?=
 =?utf-8?B?dVJEMlhmemQ3eFJQNWhmU2pkTHZ0ZE5oQkdvU2VmMm1Oc1Z6WnlNMTdvMmUy?=
 =?utf-8?B?dTd3YkVxUzdVUFlKMnQ3aGZGaWQ3WUdOclcwNURJZG9ObnBTY01idS9DcDhn?=
 =?utf-8?B?M1RHVFZIdkJwakM4WitPMEVWeE9IalJFdmczRCt3YndXQnZiRnlrR0k2Vi9m?=
 =?utf-8?B?RXFWU0h2dVlVMU1Pc0lGcEwwalkyeWRLTGsxSVJGYlVoZ3hBcmRtUVNWLzZ4?=
 =?utf-8?B?ZjdiMCtvT2lONm01VldzRGNZQ0NFV0VqQzZkaUdZRDdvMHVGK3dOMC9SYkVF?=
 =?utf-8?B?anFVcUI5R3REeXNTOE5GeG1SRWhmSFQrdE9NeE80MVEzM1QybHJjVHp5dDQv?=
 =?utf-8?B?NGhVSGc0eDBrQkt5dEJrdlhDUDVsVmlFUmNnMTk2NUQyTEcvSnJ3MURmMWZR?=
 =?utf-8?B?K0hSRVJuYmdKNTk4WUg5cmFjeUUvOXVLZTFncGc0SlVtakxRTzdjS2tob3JW?=
 =?utf-8?B?WUIxd0NYUUVHTHpCUDV4d2tnMXJLN0w3RmZkT2UvdkdQSnpPcXZLRHQwTEZB?=
 =?utf-8?B?UHRCM1lMWjJJdjdFV2VGclNXcFlrb2Z6S3VWdm10RnRxaDI4WllmZHA5ME9U?=
 =?utf-8?B?cFNIWmhTSmZJRkxIbG16bzJOdy91R2lnL0hqUzlxYzRRNUhOYWFkb29ZVXRo?=
 =?utf-8?B?L3VzMDJTK0t0OE1DNS9zNlRKbWRuSTh5U0UzbGFYbUlqbUl6dXRaNzdydk5u?=
 =?utf-8?B?T0FScW15NXRYSWdnSTRTS3pmZk4xUUYwTlFrcVp3SDZUcVBtSEpFZERZMFRx?=
 =?utf-8?B?cEI4SE5aMXoyUHc0dG9PQ0VhTXduOTcvOUNzOFBjbDErT1VzMTU2alJpY1lj?=
 =?utf-8?B?a2RWOVZHWlJSNVA4a0w3VncwL0cwMmFsT3pKYmg3RkFHMWIrY3VHWHRUYXY3?=
 =?utf-8?Q?SwRjOPfW8bcC0hUjNBYJSTI9cfUMktrQEV/Zpwn5yzBph?=
X-MS-Exchange-AntiSpam-MessageData-1: 3dfYtO7AWZMIug==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a94a08d-da1c-44bd-883a-08def6e770e9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:58:22.7252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kq0D+Q8RiBlaNs491GHbOrTU2IEemJVeXBs3o0rhQrZvG03ImkK/8vCULojEecbLicvE2GCudrX92H276Y+WSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8208
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

The existing assert! and assert_eq! macros cause a panic. For self tests
in nova-core, it's inconvenient to cause a panic since these need to be
run on actual hardware. Instead, define similar macros that log an error
then return an Err.

Also add the NOVA_CORE_SELFTESTS Kconfig option that gates the driver
self-tests.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/Kconfig      |  9 ++++++
 drivers/gpu/nova-core/nova_core.rs |  2 ++
 drivers/gpu/nova-core/selftest.rs  | 64 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/drivers/gpu/nova-core/Kconfig b/drivers/gpu/nova-core/Kconfig
index f918f69e0599..cb7f0b00f796 100644
--- a/drivers/gpu/nova-core/Kconfig
+++ b/drivers/gpu/nova-core/Kconfig
@@ -15,3 +15,12 @@ config NOVA_CORE
 	  This driver is work in progress and may not be functional.
 
 	  If M is selected, the module will be called nova-core.
+
+config NOVA_CORE_SELFTESTS
+	bool "Nova Core driver self-tests"
+	depends on NOVA_CORE
+	default n
+	help
+	  Build the driver self-tests and run them when the GPU is probed.
+
+	  If unsure, say N.
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 8f59cfa97017..1133c6ce5c55 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -23,6 +23,8 @@
 mod num;
 mod regs;
 mod sbuffer;
+#[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
+mod selftest;
 mod vbios;
 mod vgpu;
 
diff --git a/drivers/gpu/nova-core/selftest.rs b/drivers/gpu/nova-core/selftest.rs
new file mode 100644
index 000000000000..f5b5965b7e6a
--- /dev/null
+++ b/drivers/gpu/nova-core/selftest.rs
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Assertion macros for driver self-tests.
+//!
+//! Self-tests run against live hardware during probe, so a failed assertion should not panic. These
+//! macros log the failure on the device and fail the enclosing test by returning
+//! [`EIO`](kernel::error::code::EIO) instead.
+
+/// Like [`assert!`], but logs the failure via `dev` and fails the enclosing test instead of
+/// panicking.
+///
+/// As with [`assert!`], a custom message with format arguments can follow the condition.
+#[macro_export]
+macro_rules! selftest_assert {
+    ($dev:expr, $cond:expr $(,)?) => {
+        $crate::selftest_assert!($dev, $cond, "assertion failed: {}", ::core::stringify!($cond))
+    };
+    ($dev:expr, $cond:expr, $($arg:tt)+) => {{
+        if !$cond {
+            ::kernel::dev_err!(
+                $dev,
+                "Selftest: {}:{}: {}\n",
+                ::core::file!(),
+                ::core::line!(),
+                ::kernel::prelude::fmt!($($arg)+)
+            );
+            return Err(::kernel::error::code::EIO);
+        }
+    }};
+}
+
+/// Like [`assert_eq!`], but logs the failure via `dev` and fails the enclosing test instead of
+/// panicking.
+///
+/// As with [`assert_eq!`], a custom message with format arguments can follow the compared values.
+#[macro_export]
+macro_rules! selftest_assert_eq {
+    ($dev:expr, $left:expr, $right:expr $(,)?) => {
+        match (&$left, &$right) {
+            (left, right) => $crate::selftest_assert!(
+                $dev,
+                left == right,
+                "assertion `{} == {}` failed: left {:?}, right {:?}",
+                ::core::stringify!($left),
+                ::core::stringify!($right),
+                left,
+                right
+            ),
+        }
+    };
+    ($dev:expr, $left:expr, $right:expr, $($arg:tt)+) => {
+        match (&$left, &$right) {
+            (left, right) => $crate::selftest_assert!(
+                $dev,
+                left == right,
+                "assertion `left == right` failed: {}: left {:?}, right {:?}",
+                ::kernel::prelude::fmt!($($arg)+),
+                left,
+                right
+            ),
+        }
+    };
+}

-- 
2.55.0

