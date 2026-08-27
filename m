Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F82C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97E7D10E3B2;
	Thu, 27 Aug 2026 08:52:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="rNe7ePsn";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013025.outbound.protection.outlook.com
 [40.107.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 870AF10EF1E
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 08:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjPTJZj9Z0Ef63yQyGjz76AX49RxPIri4ZbrDSHqEiQ0dAhXxOPSfRMtzYEoEZKmxZTUpRzK5aPunwS/U1QG6ACoWSGuPWh+FTsPqoaKILFfvecykH5ZG0NXf/aW7Lft0rUqnFTcy9zjcbwrzZKNMbEcFaTERh+gfQT0sSayA63VkOzs26wzTfowAGrx7f8ysfElaKBd0/UuqFMjMtYfUDowsaOM9sBcZD4Ry8Hu2jl60iI/1mEhGBDmGDGHBS7r6R87H/KYfsZfRNfEt7VOQ4eNCz/3M7r+zIHOj2hezlY/hJTo0ssRj1nB+A6cEGHIlbsokFKnSYQZwr49+ykxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gigmGCIOVqvxs2914t+WF719FvdRl53yUroWkDzyx70=;
 b=SfKHjwxDfkPqF7b+ItjJGBnXaTQr9WYkOhOUjKpc5H/jgQJDxsyfAHdn1COmPkBuisah1KkjhLq52YuCT3Mk4iWTqRRt3nNC2RSLuRdaJJUJfP33COl507IrQYtzATDORzQGJ3I26Tx1LE6SuN4uh3XDouyjUKzOrdjiiJDhjzuT/qFJX2OgbOOS143JV5eQI2A01XM9TAG9SAhWBdw5NmWHMiGXk/0T51LxALV4imexhlmVIn0Jlm1sfpGHrQSqwUuLWSej9SEGgTc2F+9/BuuiqZ4ei+WSluV8ztLnXEaDNYaf3trgsyNeJwqNGitnB4a1U34hFLWeWo2ocj29Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gigmGCIOVqvxs2914t+WF719FvdRl53yUroWkDzyx70=;
 b=rNe7ePsnp+A9vgafVRev9aN3hCBcK3dLKA6thTNW4USDvFqkWU+LeGyb5xyBxdGCnSFfHi2OddWYDonTo1bhpcSKQ+QxtLyJcIFN8+24WOPmsUIdkkN6Zhgw336wTTL+ZxjENChwDrIB29lsOId1skInl/7vNrnHZ/vevQ+/2w5jcEEAR48eUUU2FCrcf+uKyW0ecHWTOMOpQHC4fTOlwAMZOdwDsFJG6yVTgZFXvyc1MFJ6IOp+H3qYOmL+BvO7VRSw5k53L6I8T5h/ipbCLL9BEst0oY4Zdzdqnw8cZsT9I497AGzOSjJG4kX5iR/NgNHDSywOxya8pqcyu/xxVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 08:52:41 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 08:52:41 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 17:51:50 +0900
Subject: [PATCH v3 09/10] gpu: nova-core: Add self-test assertion macros
 and config option
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-pramin-split-v3-9-24b24d7afc52@nvidia.com>
References: <20260827-pramin-split-v3-0-24b24d7afc52@nvidia.com>
In-Reply-To: <20260827-pramin-split-v3-0-24b24d7afc52@nvidia.com>
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
X-ClientProxiedBy: DU2PR04CA0030.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::35) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|IA1PR12MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: d78f838e-20b4-48dd-dc6b-08df04188d3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|10070799003|10067099003|56012099006|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: hWEBwvVrEBgQl5nPYM5iK0PPJgX9UF7LuQVDyz0I6mMcd40gNSv8Y7xmjB+aYAzu/LrOREJxL03jAfOu0PhgRAH+NI1migPqxtWjPx72zjB9+kmY63bW8ewA6+kVHtg12WA3JY45cctAhBA7ba5NLXTYFspZkjpL/Wqih8c4cdE//w3TLBWlWHDlPYhryx0wj8/r3DZDndSV0k8B1LWmNi6LK6MyKyjNLFV2x2zxCUALmniz+ZacM3t2Z0PZChS4qEpjZl9J05/MTccjTEOhRB466Vczjql8ciQ331MxzxX4Xl/3D0kpQsxfADcrT7D8GcVufIIczAby7YFNkuK8rQiK0j6c2RX00lqM2g+09VIZnITyUHSw2xWNXYAyyNZv9c/q823Bu4q0igzCdKGfTFc1nfKPEaXVXaziPj5LzPr4/cR7vOd7c1Z+VJEtVYlr+tnpd37/Ha2hRk9QJvQTXpqcxo0jl461U8Xdn9JyZ/3JxqCQMQ1Xp2eFiGIExY/tvstuj6vKguRgiCr/nV7WH5poUXSGehRY8pN3InYvD9p5YDc6XNwsig/uTY9a2TsJvm693bCxvI1yi5Y3BF2DyOjIJZDxWM+iS3eiHsC9utI3MZCgIikWEwD+mKv7AbFA1V8Bej/O6CaqdpezYSwI4uatbj1FTmcc1Z+Iy5jvhykN6O9FFMzrfS9ekQ/yVskjdNvfuy7Zeqf3ts4LJorGLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10070799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clNGbkNCNkI2WDhGOGt4OWFObTZtbFBYZHlYNFQ0TWJUNnFnY1lrNnJ5TzU5?=
 =?utf-8?B?SmtseWpOajY0ZEg0VElMOGRwWmNEU3VDalhWbWF5N20zZlRTb0U0dXZBNllV?=
 =?utf-8?B?a3pMWnNOT3dSekRLRTc5VFlyajdiNzFZa2NTVzRHZEZBdmczTm5Lb0owSlhp?=
 =?utf-8?B?eEljaGJkczlaN0xDcENQckhTYWtmeTRWRzBVWTBvclJwK1lsMnJCTlhUOTZo?=
 =?utf-8?B?enk0elp5NEJKeXNnZ2gvSVlrWi8vQ0dWNVJmTHprL3JQRGZFSlJUSjlJNUdm?=
 =?utf-8?B?UTUraWRwTGxoY2g0UzBNM2JZOHUxZVlBODNYSGtKdURlZjRLVS9IVXB4WS9N?=
 =?utf-8?B?SmJGQUhUekhFRXZIamorS3NqcGFxTVF5a0FpS0NwbUlIaCtSblJiSUJjb21Z?=
 =?utf-8?B?Sk11OE5WRzJjdXA4U09qclp2UFkxZHRNaFgyelE1NmhKeTJHZFY1dzBxblpM?=
 =?utf-8?B?dldNcnExRFB3MjZZQzdNcHAzNDlHOWZTZ2pPZXBsbGk5RVloaG9CYzZCREtI?=
 =?utf-8?B?Q2JLaktrTE5FSVlka3B1WkovWk9uYlN4dGJKVmtRNS8zSkcyK0k0NVlpUk9K?=
 =?utf-8?B?TEx3Y01EWklDU1lOZUx2RkttZWY1ZWo4Q3JWMUd1QjVaSlFNUFFPQWJxL3oz?=
 =?utf-8?B?d2gzZmtSZDhYUDZxWnVtNHVNTnJaRjJrV0p5cytGZTlnTklrZVlETzBxNi9r?=
 =?utf-8?B?TlJiYW1VdmdvVERFeEZXbUVxS2NwbU8zZHFHTTJic1M5Y290UXdtQm9xa1hK?=
 =?utf-8?B?M3pSaUVRSXdOblhRL1B2c2pORFUveGkvQXNsMTFmZTE1TlVvemNEODM0emg5?=
 =?utf-8?B?emxnWStWeXRtOVhvb25QcHBieTd0UVR1WG1wWlRZY0Nmbi8yWW44dG9Sb1ZP?=
 =?utf-8?B?WFZNbU1xU2RwZkJiNXFoQmpFQWtnTG5IS0tlSTZtQ2wyMlhQVXkxRUV0dG9V?=
 =?utf-8?B?c0ZtbWF6T0d3elBqVnd1cGhuQ09XbkdrUU9hdVQ0ZEVDWEFnNk9LTDdKSDhQ?=
 =?utf-8?B?bmkrL0FJQU9qdHM3ZG5KOEdDZi9WRVpHK0V0d2w1Rnl3QzRBRlQ5WTBFTnAy?=
 =?utf-8?B?aFord2g4d096YmN1SVJoRUJCeTFqbGt5OHIvL1IvakFmN3VlcFpmdWVFRGt6?=
 =?utf-8?B?cVJaY3JGUXZOMzdVMmJlMmJjRnJQV3N3WlQ3NXZNNlF4bTBPS3dwUUJFVDdR?=
 =?utf-8?B?bmhPZFUzRUlzL1FmMmkvYW5lZVJBOGNGd0lqcXQ1VTB4dWZRZG1vWWhGV3pn?=
 =?utf-8?B?bVc0SmpHNUNacHZSQlRRTnZsT21mSktXYXBmZXoyN1c3V2txd1k3OVNuZGk1?=
 =?utf-8?B?RFp2eE5RZ0NCR0x2TFpYSWJZa0V6RVZZNUNoZ0NDNmlDWFJWdzJCdWRiRDcr?=
 =?utf-8?B?S1RseWx5U0lycUx2V3lyZzcxaDkwMENNODl4ZkJFdWpvc01NSklsRmtidExY?=
 =?utf-8?B?V1FOU1lvZ1Q1Y25QV0I2dUlkM1laUWh2RHhvcjdBcVAzK0hlcnJWMHRKaE56?=
 =?utf-8?B?a2pzV0hKU1ZLdHNTWFVjWDV1NFlMdFVmNVR2RGE3RzQwYjZuOFhJc1BacFZ0?=
 =?utf-8?B?ZUkrTjlPdjNZYXZXQllXZ0U5K3FsTkJJRi85TnFRdTE0V2tmZU9qa044Nmsr?=
 =?utf-8?B?bkVCR3RhWTNrb09zM212bWxWVHc1QkczVTc0MHNtbDk2aGNld203ZkZwSXF5?=
 =?utf-8?B?Rml4NWZFaFdxQ0lzclAyelBZQVdaT21LN21XOHM1bnJ2RjRSK1BzQnBybW1x?=
 =?utf-8?B?QlFkVHBQUXExOURRNjQ2bGQva0J4UVErWTUyeWFsVWczRnQzTTREKzdlQXZ3?=
 =?utf-8?B?U2tYcFpTbjNWcDJIVVc2OXlTU3pYMG1kc3E1MHJHdytqSG5LWExSQXBoVEY4?=
 =?utf-8?B?YmhVUHMyaWZVWTMvbFdCai9qbDdJRm51YnJYa0pPTStZZURFTFE4VSszR0Fl?=
 =?utf-8?B?Q0t1NEFyNVhhWlpZb0FzTmYzNy9zcklUdFpWMExGUVhJTzlsQmZ3NjZMYjJN?=
 =?utf-8?B?N1FIN2dKVkhZaTRvTTArcWNiVkVmNzd1akkzbG9wWms3U3FUM1VqMGEzYTVY?=
 =?utf-8?B?MjZpTm5UcFZMMDdyak9xMnlWR0lUSkV3VzBJelNqS0dIUUdTZld4NGc4RGZa?=
 =?utf-8?B?U1IxL0Rqd2d4UE8raTVXOHRHMW9CcWR6VElaQkw1cGFEajUvd2xzem5aR2Ni?=
 =?utf-8?B?K2h5UXA4UncxcW1xVTJKYy8vS0U1VU9ZaHJPQTRPb2NNclFJb3F4ZGN1UFJ1?=
 =?utf-8?B?bGk3eE02VUFhVFg2Si9ndEFGTTRLSHJCSTQySTZpNFJ0dFRLY3F0QlNvL0R1?=
 =?utf-8?B?ZERJY3ZlZDI0Y1ZGUFFjUUZoU1lKSS85QnpENXJVNUdFZ0lFRUxKb0ZpM05j?=
 =?utf-8?Q?giedprs+lgCGMqVN48w0JKvm6StebKs6cXP3U7iuOsDJL?=
X-MS-Exchange-AntiSpam-MessageData-1: errjycldW8Q5xQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d78f838e-20b4-48dd-dc6b-08df04188d3e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 08:52:40.6303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cIOIMD8pM6QW5o+x4/W7mdomvZsYrR2RRGBR8WVPBq962WCd3r7GRPkk58YwRbhhVB0R1lfoF+W/LdNVzaUrxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7663
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

