Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46606C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DDDA10E3BE;
	Thu, 27 Aug 2026 08:52:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="NHpEn3YZ";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012000.outbound.protection.outlook.com [52.101.48.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58C5810E3BB
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 08:52:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlB5nylS/w2A4umIPrT+Lcqk8WOoN9LDjJaDxG2nrXH29Ma4t2TM9eyoGjh3M3HiOON7Ub9bIF0dlXTZ2hxu/W8IdVcFHan/Qi34LiJInz5f26Mr8nZu5k/8+uSk5YWnYVC0TxYEX/4YoW6GxDrSxQbo/89sTxeA+ZUniTjz1mC7shiq/givTw1BuNT3eyoYiuVu9ZJuC57nG4dYonbnIqdiULaX4jUglWf51jRhe2PVRro2BQ0J9WNKvAkrSNbJtvZCeAt4t9MlEl3eOdPXmraQU9xTuvMx/32UB8EeKU5bUZm6toD7022SiMCRSojdxdwpda8saziWCsZlvcCZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjFn8WncNZcNiijYDQqDtx8Sb1nRpzpUXQEdStempho=;
 b=sTYIE9b9u56efIOVq+zNJLIoJUtPw21U0UWZY+XWHtUsV96MTWUXulqLSh8tpIvfsLCXBG0DDWcHZS+39BeIcchQY/RgMB5n3akp1C66JkmQMBw/cHeSpQ8qiJtiBF07K22DH533uFSTpPEYS09SqDElML8qt9yoCx/0Joiu2zSFFJAhUGGEKA7Y5GuJ4F9eG8sRSyFQfXhofnEev75SybmTekULkof6ThFigMLU1gcJs39Tp2GLkflglGCmu6y1STOox13wSCLmxUIGoHxb9NPSuIbSMWU5R9QEKNRYPjHAgAH8PoRaEXWEsXcqOLeZHP72f+wRcJha/z1OS/QBOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjFn8WncNZcNiijYDQqDtx8Sb1nRpzpUXQEdStempho=;
 b=NHpEn3YZrKc1KkqVpdbgWMuqoQjkXwZyuWHKMw78/Asvk61h37SMwFf18UzUbAddPsIb8Oa8MFUCTHLSNnjqPjcxUzLvn6I0TR+NrorvU7ak/AvLFKuhquDmkXwnENbO/W7F9wBBNc+U0L2nZlzPmKx1gfuCfgZkRqGMr0uh0LyWayvcC4HyNaHfqfAy+m6YIIdtIXu/o2rl6pJcMua9ma5qqgc3vhbEvGoyluSy4Wk9Rbf0B4y5sBCjfq20kta4pVkrl8NekWF1WhA7nC/QuABsmkiyUo9CU9Bhbfy7dGNOZZTA3txc0A4W0ZL5ouRTul8UUaM44A6LPBPVwwbUPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Thu, 27 Aug
 2026 08:52:17 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 08:52:17 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 17:51:44 +0900
Subject: [PATCH v3 03/10] gpu: nova-core: mm: Add PRAMIN window registers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-pramin-split-v3-3-24b24d7afc52@nvidia.com>
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
 linux-doc@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P286CA0006.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::7) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|BL1PR12MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: 475daea9-f71b-4b75-073a-08df04187f8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|23010399003|1800799024|366016|921020|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nZY9IyMK31ndnwL4b4DTIAPUnY7zTkw5aZrvF0bWCb1dBmovUJV4TqjxOfd1Vn4JejvH5oD84nUV8AIMcWftTtS5XdHHDB+4vsCkwdQn3V3UtBkYjc8mL51Logtuw6lmytgzhNdlf0ckDybJlb4Dvtms8Pu2K2HvODbtnKPEihJxaV5sd0jxgxHvoLt40FE7k/CjvvCpwjxcAmtcdJEHGEE5t5Lyc9+7TMWQr+iN3SZ5SntCI76oIWBAZ6IM6m1Yng+Ryp7NrO/AQycmKtotNKmQIV3esEw3iQg4+Ou6RhZZF+jtN8ISpNoKRXuAo9pnrLPQF05KLf21xuHS3XJps05OkRaGaW507LCU6lB3nn3SajUlZETaI62YYyHJZexDevC7oULF6vnk2ecJVjpmWz50nwov/WCd2odJiPvJjs9SSxMW1c8sQ9bX524VFbM89Xl4CzfgG4NawBm9eu7lGPHn9Yw4s5Q3u0cSgTvB1ocuZ2Yl1n9Jbe8JBF10W0t4jHmJpFJnS8I1PcCeCPluSKbYa22nR7xp9zvpqMMOHJFOlAGvh5jrmUTKMYC9Q+U6II8z6xZXilmbK3XIvhrMKpMvqJ3PDY3lCxQ+8gex4K9eFciwgMUsUZRhFaIGxEjKw+rXYrh14zWXN0ZFlNX8avT55wqzu/cqA96wQnCF/jgC1W19uXIZYJao58bEAMziJcUiK7jFa/6b699lOJhpFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(23010399003)(1800799024)(366016)(921020)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mnk1Z1FqZWFpNlRUSXl5cnBJM0pSdml0d0xMTFljSmZhNzVhYlc5TjNYMkNS?=
 =?utf-8?B?YjdtSUtWWCtTcnUxMFp5S0lKa3BqZzhrSWxPbklCdlNNc011N0U3dzI2a1ds?=
 =?utf-8?B?bnpVWFNoZkg1ZjlZc1dSRk90cjdpNk9XZzF6RUlkb1lPSmhoYnNWRXVYeFUx?=
 =?utf-8?B?dlhFYXBqd0dkSkxQbEhOMGxielhkMjNpM29IdTdVbTdISDg1b2NrYTdGR2Rq?=
 =?utf-8?B?UjIxU1Y1UnFZejlraHQ3NkUwUlo5VFdWVCtZVytTRUFSZTlEVmpYZ3BXdlVC?=
 =?utf-8?B?T0Fmd25aMkRmc2NCN09qTWpOVGxOc292K1NDYk4wbk94ZDBmUHBIR1Y3OTVI?=
 =?utf-8?B?NlM3dWc0ZnZkOGZCaldZdVNJc2ZycW9yd2ZyTStyWjhXMVhSRTg5eUZQQjMx?=
 =?utf-8?B?NitmNDZMQ1VkdlZmTENaMUwwblRQOWhER1h2SE0xN2l4NUpsUTM3cXdLN3hO?=
 =?utf-8?B?WlVTZjJGcmNiemJSV0gvZTY3clRpcmVkbTVYVXNISVRRS1V5ZGV4c2Y0ekRp?=
 =?utf-8?B?Nm1jTXpKSEJZekF6RmtWYkN0YUNzZXd3VzJ6OVdRZ1Q0SjN0ZFB3Q252L1Br?=
 =?utf-8?B?bXVPa1BSblJGaFdXaHhNMU9OYXpwc0tncGNjZlF3RGVwVnNoWk1YM0hPeCtB?=
 =?utf-8?B?c08ycnNJb2JzeXBwbXVRT1BWRFU5cUtTVmVaRC9NWFNGZzlmaGhtdHRZQTgv?=
 =?utf-8?B?bktDWXlNc2IyUDVoLzRVb1ZvbXF4L01mTjNGb0RDd0tQU2QwaEFTK1MvSWtZ?=
 =?utf-8?B?UHpTR0MzOU9yMzJveUJ6WTA2YzRKNWRmeVNyY2tBekN1ZllwN1NjY3FyaFdo?=
 =?utf-8?B?RXBwbmFMaXd2YjhBSVRIbjdsQ3RyNTRNY2RuTU0xbmxtWGI1RWVsWDY1cTZS?=
 =?utf-8?B?NTVXYXMzQVNFUFR1TnNuVVhhcTBGWGpwTFZmU3dJTWwxWFVUVlVESzl6V1R6?=
 =?utf-8?B?b01XU3F5V1ZKWW16d0dBN0NWNXFOdzFaRE83bGtwVis5VGRteUdCL2R6RE9P?=
 =?utf-8?B?aHBYbERYN2RkZDk4a3JLQXpGaGdGeHlQY2VBY3JkT3V6RVRKbXJyUGV6TXFU?=
 =?utf-8?B?M292WUZlVGRiRDhIeUFQK3ExZ3RTZDFvUDhCOFhBM2xhYjF3blhuVEN6Q2dy?=
 =?utf-8?B?aC9seUEySmpVRStMTXlJL2NaTFBmbzVDSkVmVkkvN2R2aGdHWWxkMk42U1VD?=
 =?utf-8?B?b0Ezemt5aThtZHJpalZyNDl4bkZGb3dzU20wTktJSVFPbkZ2NE5NUUcwM0JY?=
 =?utf-8?B?bW1YWHpNemhUenlBdmJzTGd5NEw0ZUhndU5TbnZobWh4MXc0bVZOVkpxSnp5?=
 =?utf-8?B?SnZwY0daRStGaGUzckpaSjdmWC80dmQ0SmpZdWJuRjlwWEVwdDlwTnIybWJi?=
 =?utf-8?B?Mlp3clhseDhTU3JoMkFNenhhRWowUEpXRnBVTGpTbWI3TjRHT1UxYUkyN0ta?=
 =?utf-8?B?UjIrSnpJRVdTQXFucjNPR1ljWWhrRFozZnM0ZHVFdEtTWlRZTndYVEFiWWg2?=
 =?utf-8?B?Wm9ld1MxZkxTSVNuY0l6bDNndDNxKzdZV3k5dko2TVdPSXcxakovN0QzVnFq?=
 =?utf-8?B?V3lMRjRWUVFNaFdwNHdyYzZMYmF0RXdUMzVRakN3Wml4R1B3M3A1ZnE5OXEw?=
 =?utf-8?B?TXRNRjlqRVVtOVowU0VmMy9ocmJRaWtIQTFSK1hMTXh1Y2ZyV3E1eEdDRTZB?=
 =?utf-8?B?QXJEcUwyYWEwaGs2M3FJY2ZIVTlvL1pJaFZ4ZWYrWFZtb1E1UGFHUzYvR1pB?=
 =?utf-8?B?VzZucXZIc1lwSHhydDZ3MW1oemw4MWNkVWh2M3NkZmJiZDVJbW9UT3J5aTBk?=
 =?utf-8?B?UjNvZ2tUTS96Y3VIOXQzWTNkUFk5TDFuQ0N3bHdoejJONDVHbDZxYkwweFBT?=
 =?utf-8?B?R0FtZCtmQithaTk1Y0M1alFvOElpL3FGc3pnck1RYjFUbnpKY3dNdk53bEdI?=
 =?utf-8?B?THlJVnNSL2g0cFY2Qm9vUDZLSmhPVUk3L0RMZmt3TnF3MDU1UUhYanNIUjJy?=
 =?utf-8?B?UWw1Mm5WSDREc0FqME9jN091QXBNNlo1MENXSEhEN3kzSnp6YmU3RDRoWUYr?=
 =?utf-8?B?NkdkSm9nUG9abHgrR2twclpVcm9BYy93Y1dZRGp5RXVlZ1MwS0pVRGxTWFBr?=
 =?utf-8?B?MVhaelFGV1h1REptQVpqTXUxTitUSlRsNHc2dVNiaHRBUjRBdEVZNjY5UEdV?=
 =?utf-8?B?QXdyQjcxOXJCRzh6VWVmTFh0YnFjZ2JISnI1bXAwcytIZjEybjRVdVcwb3Yy?=
 =?utf-8?B?ZHRabjcySzR0UXVoMk8yVEVTWHl5Z2E5TXRNcHY2d0R1K1VGaWhFcGtkeXR2?=
 =?utf-8?B?SnRMbFdMOHdLaEEwTGNNVDVxNDNHaFN1cXVVTDJHcEZaL2hINjZzUXlnNWMr?=
 =?utf-8?Q?FLvZl6Xfsdd6oJf4gLbP66vHQvRtdGuSfa/PtfQ0MX7oM?=
X-MS-Exchange-AntiSpam-MessageData-1: KcOF59+b1Swozg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475daea9-f71b-4b75-073a-08df04187f8d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 08:52:17.6692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKammCErGDSHTcxkT8WhLRNqu8dZV10m7YtjRceogLCgv88hQddN3nhI13xumMkpvX0E7Z63rkCwIgzjr4ccLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729
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

From: Joel Fernandes <joelagnelf@nvidia.com>

PRAMIN apertures are a crucial mechanism for direct CPU read/write to
VRAM. Add the BAR0 window registers that position the PRAMIN aperture
on all supported GPU architectures: Turing, Ampere, Ada (via
`NV_PBUS_BAR0_WINDOW`), Hopper (via `gh100::NV_XAL_EP_BAR0_WINDOW`),
and Blackwell (via `gb100::NV_XAL_EP_BAR0_WINDOW`).

Hopper/Blackwell window-base registers are based on Eliot Courtney's
offlist reference patch.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[ecourtney: split the registers out of the PRAMIN patch into mm/regs.rs]
[ecourtney: drop the register read path]
[ecourtney: reword the message for the split, narrow visibility to mm]
[ecourtney: plain base fields, as the bitfield cast+shift patch is dropped]
[ecourtney: rename the target to VidMem, fix derives, redo the target docs]
[ecourtney: annotate the register base types]
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs      |  2 ++
 drivers/gpu/nova-core/mm/regs.rs | 70 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index f9d80ffbe01d..7d24ad790310 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -19,6 +19,8 @@
     },
 };
 
+mod regs;
+
 /// Physical VRAM address in GPU video memory.
 #[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
 #[repr(transparent)]
diff --git a/drivers/gpu/nova-core/mm/regs.rs b/drivers/gpu/nova-core/mm/regs.rs
new file mode 100644
index 000000000000..82de6dfa4e8b
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/regs.rs
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Registers used by the memory management subsystems: the BAR0 PRAMIN window.
+
+use kernel::io::register;
+
+use crate::{
+    bounded_enum,
+    driver::NovaRegisters, //
+};
+
+// PRAMIN window
+
+bounded_enum! {
+    /// Target memory type for the BAR0 window register.
+    ///
+    /// Only VRAM is needed by the driver. Pre-Hopper window registers also define
+    /// system-memory targets that are unused here; Hopper+ uses a separate register
+    /// without a target field.
+    #[derive(Debug, Copy, Clone)]
+    pub(super) enum Bar0WindowTarget with TryFrom<Bounded<u32, 2>> {
+        /// Video memory (GPU framebuffer memory).
+        VidMem = 0,
+    }
+}
+
+register! {
+    base: NovaRegisters;
+
+    /// BAR0 window control for PRAMIN access.
+    pub(super) NV_PBUS_BAR0_WINDOW(u32) @ 0x00001700 {
+        /// Target memory aperture for the window.
+        25:24   target ?=> Bar0WindowTarget;
+        /// PRAMIN window base bits 39:16.
+        23:0    base;
+    }
+}
+
+pub(super) mod gh100 {
+    use kernel::io::register;
+
+    use crate::driver::NovaRegisters;
+
+    register! {
+        base: NovaRegisters;
+
+        /// Hopper register for PRAMIN window.
+        pub(crate) NV_XAL_EP_BAR0_WINDOW(u32) @ 0x0010fd40 {
+            /// PRAMIN window base bits 37:16.
+            21:0    base;
+        }
+    }
+}
+
+pub(super) mod gb100 {
+    use kernel::io::register;
+
+    use crate::driver::NovaRegisters;
+
+    register! {
+        base: NovaRegisters;
+
+        /// Blackwell GB10x/GB20x register for PRAMIN window.
+        pub(crate) NV_XAL_EP_BAR0_WINDOW(u32) @ 0x0010fd40 {
+            /// PRAMIN window base bits 38:16.
+            22:0    base;
+        }
+    }
+}

-- 
2.55.0

