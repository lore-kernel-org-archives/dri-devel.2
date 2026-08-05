Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3831C55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 05:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D279F10ECDE;
	Wed,  5 Aug 2026 05:46:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="LF6d/4nH";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 666CB10ECDB
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 05:45:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVDSy/rKjRlj5l+RVjoQjNJHfWrd+e/PnVe6O1o4YoRZYzFsPLXc0tAGb9asDsUJb7mYj/SF0mRXMSNZbYAuEehU2yRgY8gIPzza9t0GClmLu1FGoGiPgN4pyTLICIIVMR4tiw0gInXSPNlW0a5IbW1E6rmb1wVhINXSuGa7nl1GF0kY1Pvlc8CA7B+OiI3Hf/HSUIxuHOAgliNGnXB8nLmQ5PvDvU+BOWpvrGxUOPu1X0MR0pWADHan155Af74dFcJ+jg2REqtE4axBu+YTA8J8/hH9Nl2mW2luYurVf7kvedTK5heZIrOk4I22ruKaPnsRJD9qFZXaZ8iERJIoSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gigmGCIOVqvxs2914t+WF719FvdRl53yUroWkDzyx70=;
 b=ucm/fxGRZu2oj6CJ/0Tx7DtkERTKwUCKmlmD2dBTyiF7hbv3hEV16AH9hddgShkrKxdTNvIOqtya3ch8ujBOQoLNRheMSBpIqwj77UrtpjFZO7kFvpwSL2mEHDeRbYTWJ5+DgQm3k8lbqTuotEFDnxTxD4RQNZ4l6KM37rrBri+3cLWF0LNjm6GU9EqdbiHZJ88bPMuH8gfdYImU/p6mLQE+iJhWnmAD4gPYzYjUkdis1c9zR0rOKlVZ4QlfPviBJPsmI/akHkneNzbZHncJlAjw7QQKt9nEzXDgTz82xrgt37JcgMYvydJZBOYomi2p8tKQa2s6elQtGCGtf8XfgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gigmGCIOVqvxs2914t+WF719FvdRl53yUroWkDzyx70=;
 b=LF6d/4nHMBuYHlLwDsN/U5GunXzr6B0ymWeS43e1I+JkEQtPHBfgB10kEFOIv5/NGp4BFbdIBi3pRi6/QABaz5guQ9vBg3p/5HMwCpO+tEL9BIHKlQt89DDOYj0xoOjGHqfcieU8egEqzn/wbYRsN4BnNhwXqYj9SkbB11MeH1NlPDueYwdkbCaY6tgPRhaaYkoUyXMTC7RPZsQv7dd0hg5w5CGzhBxo2IUxlj/kUCg6BjWh8n4eS2KxVh36uH/k2YJQkViQoi0NhoACDcbvSvpgbuRq5E7Ke8mMWZY8jmHlFJh9dmvYxTIwo+AQoQ1BDqAfVjUoX+QF/lw/SFZMYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 05:45:55 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 05:45:55 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 05 Aug 2026 14:44:58 +0900
Subject: [PATCH 11/12] gpu: nova-core: Add self-test assertion macros and
 config option
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pramin-split-v1-11-ff3e84a75dac@nvidia.com>
References: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
In-Reply-To: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Yury Norov <yury.norov@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P301CA0090.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::12) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a30a6ff-2f16-48b8-e40d-08def2b4d138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|7416014|1800799024|10070799003|10067099003|11063799006|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pO2HVmQKYiCwMYeCDmEMHp2OIpxQpUxUjV9hpnry2iHhIeA4wUnaCtiGmHFC7ZXg2WfjjCl4jfMg6iFFIt7DFCO52Ke2+Zxv9KeC5pdprud8QnWXYHOyK8hDHpQ1LuerPidtguzbGl2drBd6em+vwlPX8qqBf/ocdQ09quehTObJdRWxTNk8C2bH4990hPCqDIVoDMtU2W9UmCvHElOCdjwv0pXvdKEs6jA9+bPQslYemp3YEXqDXS6G0MF/zol5MVMnA4EN7xDeD7oiD4nmwAk5NLEKOPYMj2Ei2WDI3+DIFwXFo8rob+q4T3kmp6ggJc7ArSl8OgupnW0OHsYsY2TWuz+GhLvXvIcikiQ4MOsTi7nI4rt0HWeh+TUCoQ+TcD6+G3A+8Tz5RtxNWhQtdiQdxSeCw2/eatGpM+Q3f0eNMQkUr1h/KZkLMVLkfjwGiszKw+NK6QEQ/TfgFqC4blOZqMIM3eKIye9eCgXvxfWFD4fSMvNvJhLB+6UazOyXT/oR5FCntD97w943cFhdoZvnf4DE89bkWrfQ3GzeFmrEkfWdN9QFVUsWfTMAEhI75NpPrdNvBiFOGJ58iE8Z+lOu0j6qK+8c9nO/FSWemF1TgnJlcTZPZGibT2NezWeXhtpQsPnfr9DGqiqp3TsRT8Qj7TlYeLjOY8cnmJmP2eEefyY+nYcP4d1s/zgbBC93tEXIrNT+FTkf399jLh0ItQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10070799003)(10067099003)(11063799006)(56012099006)(921020)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDZFRWFYS1oxNXh5cE5vN2JOMTRTTXdxOUhvMml5Z1NQRmFBcVd5NnpQY1FH?=
 =?utf-8?B?TWVqQS9oZlkwckZSS1ErdHVwOStiK0pKajI0RG9jMUF6RWh6VUkydkVQb2dC?=
 =?utf-8?B?MEt4eTZMaVRUZk5STmFUVmtDWnI1VzRCN2JzdGM4WDZILzRGZm5JdDJUM0Jt?=
 =?utf-8?B?NTIvdi9mNDdXTUpIVnlScFZ3YlVRMVZZNExaRGU4eFUwNi9JOEFiYytPaU0x?=
 =?utf-8?B?UVNMdlNmS0swalBmZVY3Y1MrVXBnQ1hBMTVGTlN6d2xQSWhpNmx6RDR1cnhw?=
 =?utf-8?B?VjFBV2lUbVpnY2NOcXhCQ0ZDenFtekRTTWUvZjhYRDFheFBKcGk1TUduRFdj?=
 =?utf-8?B?OWF5amVNZTljZkdFUjVuckJ1NkNmVWlWZS9wM3A0VTBiZUhmSFpCZk44b3RX?=
 =?utf-8?B?MDBwNldyeE44MEVjWEVENldBbG9uazFObEJMNHB0U2piRDVLWTgvWDU2Kzl6?=
 =?utf-8?B?QUdhbkMzeWNFTFlWTFlvTVdHdldRWklWWU5EZVNFbGJSVXpaWnIxdE1FQnoz?=
 =?utf-8?B?RjJMQ1lQdklrQ3dTb3BIbmNCRFBwMzRhNTVYMThWb0syNktQUFZGeUEwV0ZD?=
 =?utf-8?B?dGdUSU1uWlUxNmw4VFpOMXZydzJZQlcvOEpURUx2RURPYTRyZFU2L0drYXg1?=
 =?utf-8?B?WlU3SElRR2JIOTl2VktuL2VUaTlaZDFvY2ZnUUpLNWxhNnZwbkdEdzZVVmx6?=
 =?utf-8?B?TnNPbVdlOXNiZEt2R1JJSDl3VGNlclB4YSt5QjdkcUdZVkd0SkJqSitsZzlm?=
 =?utf-8?B?UW9JQ0NlTHgveC90d2RtSjY4ZDA0NlFwbzJORWk4RTQvVVg0YUlwNkg3U3Nl?=
 =?utf-8?B?UmNnTkcrRDVWYjNrVkVBWjhZaXU5TnlpYTlSSHliYmJ2T2hlK2pYNXdraVQv?=
 =?utf-8?B?aGdOc0F6cWYzaDVEbzlNcWdXNmM2YmNITVhJT1JXdko5Tnlsb2c4WmlWcEox?=
 =?utf-8?B?VjI5c0FSWUZhbHFOMTk4MEZpcHJqVHQwcmNWTVFVVHZscEN2d0VRUXQ0ZU5t?=
 =?utf-8?B?Z1V2ak9reDJUN2Izd1NxZlkwc0pYTHR3YkFzaTladnNrUlc4WnJ2YkYzNVRL?=
 =?utf-8?B?QWp1cGNXRHFLNkxzdnNoNkZ0cWFyZWp6V0JYVHBEV0dZS2pCRmd5V29xelJU?=
 =?utf-8?B?eXFveGlWM2ljS2lNaTBnSFpKVjloVVF5MFRpUEIvcE9PbHROVWlIQ0lXeG5q?=
 =?utf-8?B?ZklnS0ZLckVPMEVSSktIN1IrVE5OdFFaUkFnMTZWdW5seGlSYmhydVhFY3h2?=
 =?utf-8?B?cVVVYkJOd2FqSzNwdVlNeXlpUUJTcFRwNVMzTThVTXcrQ0xzZ1h2bHBrNjJs?=
 =?utf-8?B?eWdWZ3VEVFVjVE05L3lpd3U5aGd2cjJhdWZuVmJqUWM4R1VnRkUxVUI5SUlT?=
 =?utf-8?B?Yk5KWmZ3WXFpdGdxUWhOUzkxNUtNeDFCWTUvZXVsQ0Q4bWZIblpjQkFtaFRM?=
 =?utf-8?B?RVZTNDV3VXoyVDVzdzg3enpONVFOU3AwODFlRGFyQ21QVFlnOXd4bWJnc0JT?=
 =?utf-8?B?TFgyNGptUmN5bHJkWUdXRVFHcFFDUGdpc1dEVFJrN1hpd1paMVhzTEFpaHRK?=
 =?utf-8?B?eUQ3NXcwdkI5cFloWmc3eWFDV2t0dGFiOW8xSzFKZDhIcXZ2cmR5dkZOSDVq?=
 =?utf-8?B?ejBFRENhQmNKcTZtRUdSZGhpblY5azZrbzVyUjZ3S0krN2NYa3lUU1lXbWk1?=
 =?utf-8?B?VHhoNmV0eERZTWVPeUlLb0pYY2pGT2tNMWd5TXRSTlprQ3o0UFBKd1huQXVk?=
 =?utf-8?B?eDVoUEs4NVFoRWlIcHVxL2k0OXo0VHZKYWlVMTVuaTdmREg3SFNuMVNnZzNU?=
 =?utf-8?B?N1pBbmJxb2ZiTUtidUo4ZCs2Q2I5UUtYaitpS2F0dHlNWmtnajFpU2V3SnRG?=
 =?utf-8?B?THd5Q2RWcEZmS25tbGdkUGY3TXpIb0lxd1RMcU5TNjIzVTdHZ3Q4UmNVZThR?=
 =?utf-8?B?UEp0elc0WVNnekZhWGxzdHNINjFFY2JQbGtVbzBxc1U4a0dxSVVabkJTTXFi?=
 =?utf-8?B?NnIvbUJwN2xXdmtUOEtjaGV5MjZmWnVOVXNmWkZBR1RXUkl1UlJnL2pKQ29L?=
 =?utf-8?B?V1o5Y0ZzRFNhOVVGRlhra3JaeHhzdUpXQmU5MVRtZ0FTbkNYZ0oyQ1BhUU1k?=
 =?utf-8?B?NlhFNlpudDhMTGZHbDdyTnBkeGZGM3NGUFpRaTQ5Q3dSQncwZkpmWE9SVHdu?=
 =?utf-8?B?dFZCYkxnREViRER0eHIxTUVOQXRWN1VSQytiZ3BOcnhDNlo1czNMbHlMTExp?=
 =?utf-8?B?MlR1eXltakdEUElTM0JGTE9GbkdaM0pSVVI0Y28vcUVzNDdyWUY2eGp2SEV5?=
 =?utf-8?B?UnJEdEJMTUk0M3cvU0M5WEpyNHMybkJGczAzMUxxWTkvYVZJV1hkZ1JGSUlz?=
 =?utf-8?Q?AY44PKr0GP40d+/Oaq/K/+LHYCWH5yFiUrDUdG2IWeHS9?=
X-MS-Exchange-AntiSpam-MessageData-1: yMtYfKfkTezP8w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a30a6ff-2f16-48b8-e40d-08def2b4d138
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 05:45:55.2311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVOGNvV5PSQ8nYlanZ/q/2oOuJlt+CMdnBXBIefPI/YJYhW27IL/4eSqN+IGbV49u+Pit2IiA654MqsM8UYo6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989
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

