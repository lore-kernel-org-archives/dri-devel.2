Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4CEC5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:58:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16CD410E891;
	Mon, 10 Aug 2026 13:58:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="I3mMVzP4";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7C2810E891
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 13:58:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4qz6wAY/iVXNnykEHfTYQ/jtnuSgNeyD94gkTcfuNENGY8QGl4JFI5PcnhP5RmgAU5QCSetlZihqvW/VoyMVKTvVgKsCpSXnjXXMk0MKH4Mat8P/suT9rSettO/qFo8fxc+oC1oKWMOenhg+Uii5OqnhzsfKfLArWQlj1oX472J1iGxLwR/fnNCME8LJeI53zbont4K8ZnPchwiARhgslzCyHQk5Y9FTsoSZAQGEMYInT6SSWSGXK7pK+4LDKdUAwwiFMqDgv/dWuaKRKbCEsynhRSluLKYG3inrJl9p9jJpZJ065qS2A9JEKAyYrTvzoWCejVIdDHs6afu9KE8Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXZzEB1H83FqJAgguKXFF78FGyNwpUhRjgkG9hjDGx8=;
 b=i4WcQEyael+HqTLUvulF5Cwu+8WjMcLvsUUZx3mjHeg9dpcxGB49e/euPp1sdQfWhMGRyFe5c7ckCwTZ/N2xNcyGAiDKvwPvEGNOAXiJ0Ysc1ammvqoWv3M0miLVx6Skh/GhShOXnkVzOP1IEH9fUg9nk0DHPgurGAMJgoTYZj3XtdQV4WZvIDJTNqr2y7R7l4rhU5pRJYleEBsDX6QGurrDfZF3iRVEg4Oefw+aJ0vCxOlcADPI3B8NjJVZIT95go4CJe5QdoNatgiZNB9mBYiakLYiPT8CZtssZPwMjdtRwhraAqHF8hPFm92Jf+nyhRYAU+0BLvHhT/Gx4WyhIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXZzEB1H83FqJAgguKXFF78FGyNwpUhRjgkG9hjDGx8=;
 b=I3mMVzP4a6pDd867+wLUClSL0wemORB4jTvhW8sY3c5RJf9kmuob0AVFf6yKNGwWypVgnqEVY1Cx7TJ55K54mtkG4aJd1fY7RDedHw35hgFc1+2RF4piHzjawvtSEKwK28KnhTfWp8eqID37p6ovlVOZ2TSS9OzT0cFS7swxP65xUAxPD0arGK8JgE5IS+ScwcwbEhRCXNEUOH2twrYZz8jaeEVVqWkO8be2llHc226ebWW7KpV4UvCiRlEwRC43zLH7mmCzOy6VPADzxRw8AwrZhf8P7/z36VbGbxPoXpBICQN7ye/OgziGM3d2wTNwfe71T++Y9O5w1B/qJZ7vzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:58:10 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 13:58:10 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 10 Aug 2026 22:55:30 +0900
Subject: [PATCH v2 08/12] gpu: nova-core: mm: Add support to use PRAMIN
 windows to write to VRAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-pramin-split-v2-8-65a00b3c7309@nvidia.com>
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
 linux-doc@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0095.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::18) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 296b1a21-9cc8-4269-a52a-08def6e769c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|10070799003|22082099003|18002099003|11063799006|56012099006|3023799007|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info: yQbLQsDnjOzEikJdS9kYRsUbXX/+jm5OrY5NlVb0tLj+WArSsNbngEUhDHbina624hgs3R6CS9QcGZ5aEt5JwsU3yvt7rhqrPQG24iW/TEdR0VD8STBV1HkfMcTHmr9mW104ujefR1+3LfW1DqdgKdVyM39edt2kJJ/bNp8SihGf/MIkffcuBEREAWkMy9cHEJnE9Qgs4NYtFLiSWInJzygvg2OjsFZTBBaYgGLnm+4gAPXKii5EvpSzn/mNtLx/lu5bQwd+PNr8K6VtMGrwlMLw8YojqWiMvxZkvoAbZN5DGgeJdheqYVnYrbhKjju6dOg4g/tv77Z+/vH08DRbD1epipkM7VhPd1SDKn4JepdMS/9FrmuBhBZ4wjFhIDJigKEnftAjy3NrkFeQI1yZDMg0pViO0ZwgZTuPb9iurx+PJTbtknRtRAADRnklAVUstICk9n83a9oe3xsNDiwufjI37nIXjXk4sX8eo9wPddg+cb8VzJ1sr8qNqM517xvdWJLVKNTAj2NiwD2KSBPz6b2m5utZcuEc+/lQszIDMUEkzrRSbUps0QkliM0BjMr2DMTz34O3gEng7gHRwoCOaXv/1uvmSZMyg1iH/9eN5NtlCb6XYgsAbpnCbOUkeLlLQsxmWcK852cFfnFWpAAnfuBUDGFXa+1NAYzE6GOwh6Hps7DCjIUUNPjVkZ7UskquWcuDNqgaSU045sGHXyj/0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(10070799003)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007)(6133799003)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0lwRTJBZFlzVktibkpRZk1HZXgyL21pZ3FOT0dTNnVhbnlIQTdHQmpBTVBp?=
 =?utf-8?B?UFBTRTkxcENURzdicHJBUm00VVozRytMbFd0dlNZSzhyTE1jbUJ2NFlTTjhM?=
 =?utf-8?B?NHVoamNGbVA4ZDhJM2cvYXRhVEVvMG1uZVRMZDVZUVlkdkltZmFNaDJtYkkx?=
 =?utf-8?B?eDBpVFUySEF2OTNQcXNzNkxILzN4U1VBdWZvNXIwQTVyVFNoOEdlYkt1ZDVW?=
 =?utf-8?B?ZXhJbGdFMjdkcU5Pc3RtSEFjNldURFJ1Y1NST2lYa0g2MUUrR08vWktMcEFj?=
 =?utf-8?B?K0phMHJCd25pR2hBcDg3WkNBSXBMWVZSYXgvSnFXYm1YdFlRZTduOFVkenEx?=
 =?utf-8?B?VzI0ZDdNWGJvOUxLcFZQT2l0WVdKV25YSkkyLyt6WUE5V3pNQXplZ0l3enVM?=
 =?utf-8?B?aksxZTZLanpFWjJOSFkxN0VoN3ZIZ3pFRXJmZ0o4LzlpOSt4bkMwZ0lTTTV5?=
 =?utf-8?B?Rmh2THZZbUx5TGMrSkZidk1HTVQ4dzE2cnFsdWlON0JDY0lNRnRBWElaVThU?=
 =?utf-8?B?NUN5U1U1cFVEcTlicDdQblhEdjczV2VKZGFFRlJZRVBqa0RWelNtbDNvMVBT?=
 =?utf-8?B?SWc0ZkNwdWloUnQ2RzNYQ1JMWWo1ejRXaXgzNEdzS2NTU3Q0NzJ6a0RxTW5q?=
 =?utf-8?B?RjVZL0VoVGJpYjBaaFAxTXphVHAwcEZTaUJrSEs4RFcyVTdza3dHQjA4N0lB?=
 =?utf-8?B?RXZiazZ2Q0QralZWamRyV1VXTk94RG9QVTdTNG9IeEs5aUwweGUySmxMY0ZW?=
 =?utf-8?B?NTVDcjArQ01sdkJaeWZlc1hSQXZ5Q3JkNU1CK2NBMk9DTm85WDJTb0Z1UmhZ?=
 =?utf-8?B?QUdyeHZrMERHMGlFZzJmVzhUWTdMMDlwWVR5N2dLdkdUSFM4ZXZ6cDlEU1BF?=
 =?utf-8?B?Vm1Mcmc1VVRjWnFOS05KQ1NyakZCblBKaVdQN0JWUDlLOTlkc1UrKytFSTh2?=
 =?utf-8?B?N2JSMisxSFB1NElqL1BVaU5zVkdPd0Frd01pMVM3Q0Z4dGU1STN6UUFuYjJK?=
 =?utf-8?B?YXFYMVZsWW51NG1HOGkvLzRZQWEyWFRzMUZUSm4rRzBZalBBeDVzK3JPTnlz?=
 =?utf-8?B?QmR0SExFY1ZWOFEreG9nSXkrbVpVMG53MDU1TDUySW1lQnlJN1V5Mmx3MFpv?=
 =?utf-8?B?STYyQkNnZG9YejNkQjFEcnJEaS9yOENtWXM4YkhKeUJMZFlLUUV1Rldzdmdi?=
 =?utf-8?B?N3pua3V4UW9OYnpRcUswZTU4TEh6R2d3ZGppWk9MWHNKaE1VNjNQcHBBY2s4?=
 =?utf-8?B?VWg3RDNMeVJVYkEzVmxhRlRMVG11UmNuSTVmc1FhWGxnNHNuZDNBYm9peWRJ?=
 =?utf-8?B?d1JTODN4dm8zZkFXdlpHUTQ2UU84RFJKREpmaTlSVGFQZCtLOWM3QlVnOTN0?=
 =?utf-8?B?c3p6Sld2b3UrZ05hQXNBNDJHWlpyazRDbTFCd0oxUjhWTHFZTFVrLzNVUE5p?=
 =?utf-8?B?Q3g4dkFTeXhlUnNsbmo4L1dhRXo1SEdRN0VseDZpMHhSU0dEQ1pSMHU0SUNS?=
 =?utf-8?B?eUhDeWk2ZUs5MnVOU0pvN0FxUW1qUjIzYW1lemtBZ0JDZjdBM0d3OERiSkpV?=
 =?utf-8?B?Si9MK0hvcGVOejlENEYwbUJUZzFJeDMzejhTbmlyUU02OXcwNzdJMjZUZXYr?=
 =?utf-8?B?SThXRk44TUlmZlMxQUVyTkpqZ0JlakxvODdQUDdmRE5UMC9XNHNiMU9GOW9j?=
 =?utf-8?B?M3o3UzRCRkZjWXZuSWNZdzNUWmMvTmoxcW4wYkg4V2EwQnNRK0I4ajNkTDQr?=
 =?utf-8?B?UlQzZXo0eWhmM0wrVW44Vjd0N05pTS84L2R2Q1FDMVU4dVBqT3RuaG9CaE16?=
 =?utf-8?B?c3R0V045Y2VuVlZySlh5TlZiSGpRVjNlTnptb0xoWEtWVFZxMk43Q080ak9S?=
 =?utf-8?B?OVVPQXlHb1hSbGR1dUpVZ014LzFWYThNdkdrMEJydlI2eis2V05Lck1pTmo3?=
 =?utf-8?B?RStFM3lSd1JDb0hJNTlyN3h5Q2ZvdDRUVmY4OVVSVzd0cFFURDBIdjNQdFRU?=
 =?utf-8?B?bWhpQTN2Y2tVK01XaTloRDdzV2Y2WFlCd3E1REp1aGM3Yy9vbjg0NDcxTFJp?=
 =?utf-8?B?Y2pZN2xFUDBjVjVuQUIxUUV0Y1pBdXdVY1hoRDlvSmEyV0E0eEIvUG9VZ2py?=
 =?utf-8?B?UFBwSzVxV3BCVmlnQ1lSTjRZSjRqNHdZN3B5dWZobmhEMzliTmQrQ1RxN2Fo?=
 =?utf-8?B?WW00YnMyQUloaWhZZjFQWk13UkhiMU5GL0ZQRVJCT1gycXV1U1UzKzRxd2pB?=
 =?utf-8?B?Z3VCUm4reDByMmRZeEp3L1Y4YTJmeWV0Yis0azIvb2NMRUVmd3YwQkg2U1pI?=
 =?utf-8?B?MDlLTWJpRVNKOVJIUG82SDdEUHZTbjdPc3VrUmFqVjM4cy91TVF2UGgxWFNY?=
 =?utf-8?Q?/Oq/hsQ7F+jIG+vTCu+qXsF42XO+av3N1biyap2MKM0lY?=
X-MS-Exchange-AntiSpam-MessageData-1: wU1eB9JqVWT57g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 296b1a21-9cc8-4269-a52a-08def6e769c8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:58:10.8795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhMATUWfjRcc3Ru/KBf8GQybLhAETu2omn6oPIHrChqv/DEcM9qSivxmHKtWDrWsbmYiWazAUQ4qK9uPUm8lLQ==
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

From: Joel Fernandes <joelagnelf@nvidia.com>

PRAMIN apertures are a crucial mechanism for direct CPU read/write to
VRAM. Add a `Pramin` manager whose `window_at()` returns a typed MMIO
view of VRAM through the 1 MiB PRAMIN aperture in BAR0, validating the
view against the VRAM region and repositioning the window as needed for
the accessed address.

A view borrows `Pramin` mutably, so the window cannot move while
the view is in use, and it inserts an ordering point on Drop.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[ecourtney: split the registers and HAL into the two preceding patches]
[ecourtney: rebase w.r.t. Bar0 lifetime changes and register projections]
[ecourtney: drop the window guard and mutex, use &mut self]
[ecourtney: position at init to avoid reads, reposition in window_offset]
[ecourtney: return typed MMIO views instead of read/write accessors]
[ecourtney: insert an ordering read when a view drops]
[ecourtney: declare the window location, drop the doc examples]
[ecourtney: add the copyright header, doc and naming cleanups]
[ecourtney: the pramin module is mm-internal]
Co-developed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs        |   1 +
 drivers/gpu/nova-core/mm/pramin.rs | 178 +++++++++++++++++++++++++++++++++++++
 2 files changed, 179 insertions(+)

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 07dce4ce2473..ef5b1cad56c3 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -20,6 +20,7 @@
 };
 
 mod hal;
+mod pramin;
 mod regs;
 
 /// Physical VRAM address in GPU video memory.
diff --git a/drivers/gpu/nova-core/mm/pramin.rs b/drivers/gpu/nova-core/mm/pramin.rs
new file mode 100644
index 000000000000..20be3fc471ba
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/pramin.rs
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Utilities for accessing VRAM through the PRAMIN window.
+
+use core::ops::Range;
+
+use kernel::{
+    io::{
+        io_project,
+        register,
+        register::OffsetLoc,
+        Io,
+        Mmio, //
+    },
+    prelude::*,
+    ptr::{
+        Alignable,
+        Alignment, //
+    },
+    sizes::{
+        SZ_1M,
+        SZ_64K, //
+    },
+};
+
+use crate::{
+    driver::{
+        Bar0,
+        NovaRegisters, //
+    },
+    gpu::Chipset,
+    mm::{
+        hal::{
+            self,
+            MmHal, //
+        },
+        VramAddress, //
+    },
+    num::IntoSafeCast, //
+};
+
+/// Size of the PRAMIN window (1 MiB).
+const WINDOW_SIZE: usize = SZ_1M;
+
+/// The PRAMIN window, which is a 1 MiB window into VRAM at a fixed BAR0 offset.
+#[derive(FromBytes, IntoBytes)]
+struct PraminWindow([u8; WINDOW_SIZE]);
+
+register! {
+    base: NovaRegisters;
+
+    /// Location of the window inside BAR0.
+    PRAMIN: PraminWindow @ 0x700000;
+}
+
+/// Owner of the PRAMIN window state.
+///
+/// [`Pramin::window_at()`] repositions the window as needed and returns a typed MMIO view into
+/// it, holding the manager borrowed for the lifetime of the view.
+pub(super) struct Pramin<'gpu> {
+    bar: Bar0<'gpu>,
+    hal: &'static dyn MmHal,
+    /// MMIO view of the PRAMIN window in BAR0.
+    window: Mmio<'gpu, PraminWindow>,
+    /// VRAM range to keep the PRAMIN window inside.
+    vram_range: Range<VramAddress>,
+    /// Cached window position.
+    window_range: Range<VramAddress>,
+}
+
+/// Typed view of VRAM through the PRAMIN window.
+///
+/// Inserts an ordering point after previous writes through the window on drop. Views returned
+/// by [`PraminAccess::view()`] cannot outlive this access, so the ordering point covers every
+/// write made through them.
+pub(super) struct PraminAccess<'a, T>
+where
+    T: FromBytes + IntoBytes,
+{
+    view: Mmio<'a, T>,
+}
+
+impl<T> PraminAccess<'_, T>
+where
+    T: FromBytes + IntoBytes,
+{
+    /// Returns the MMIO view of the accessed location.
+    pub(super) fn view(&self) -> Mmio<'_, T> {
+        self.view
+    }
+}
+
+impl<T> Drop for PraminAccess<'_, T>
+where
+    T: FromBytes + IntoBytes,
+{
+    fn drop(&mut self) {
+        // Insert an ordering point after previous writes through this window.
+        self.view.cast::<u8>().read_val();
+    }
+}
+
+impl<'gpu> Pramin<'gpu> {
+    /// Alignment required by the PRAMIN window.
+    const BASE_ALIGN: Alignment = Alignment::new::<SZ_64K>();
+
+    /// Creates the window manager for the given VRAM region.
+    pub(super) fn new(
+        bar: Bar0<'gpu>,
+        chipset: Chipset,
+        vram_range: Range<VramAddress>,
+    ) -> Result<Self> {
+        let hal = hal::mm_hal(chipset);
+        let window = io_project!(bar, build: PRAMIN);
+        let base = vram_range.start.align_down(Self::BASE_ALIGN);
+        let window_range = Self::window_range(base)?;
+        hal.write_pramin_window_base(bar, base)?;
+
+        Ok(Self {
+            bar,
+            hal,
+            window,
+            vram_range,
+            window_range,
+        })
+    }
+
+    /// Returns the VRAM range a window based at `base` exposes.
+    fn window_range(base: VramAddress) -> Result<Range<VramAddress>> {
+        let end = base
+            .checked_add(WINDOW_SIZE.into_safe_cast())
+            .ok_or(EINVAL)?;
+        Ok(base..end)
+    }
+
+    /// Check the window covers `len` bytes at `addr`, moving it if needed.
+    ///
+    /// Returns the window offset at which to perform the access.
+    fn window_offset(&mut self, addr: VramAddress, len: usize) -> Result<usize> {
+        let end = addr.checked_add(len.into_safe_cast()).ok_or(EINVAL)?;
+
+        let inside = |r: &Range<VramAddress>| r.contains(&addr) && end <= r.end;
+        if !inside(&self.vram_range) {
+            return Err(EINVAL);
+        }
+
+        // Reposition the window if the access falls outside it.
+        if !inside(&self.window_range) {
+            let base = addr.align_down(Self::BASE_ALIGN);
+            let window_range = Self::window_range(base)?;
+            if !inside(&window_range) {
+                return Err(EINVAL);
+            }
+            self.hal.write_pramin_window_base(self.bar, base)?;
+            self.window_range = window_range;
+        }
+
+        Ok((addr - self.window_range.start).into_safe_cast())
+    }
+
+    /// Return a typed MMIO view of a `T` at `vram_addr`.
+    ///
+    /// Returns an error if `vram_addr` is not aligned to `T`'s alignment, or if
+    /// a `T` at `vram_addr` does not fit within the VRAM region.
+    pub(super) fn window_at<'a, T>(
+        &'a mut self,
+        vram_addr: VramAddress,
+    ) -> Result<PraminAccess<'a, T>>
+    where
+        T: FromBytes + IntoBytes,
+    {
+        let offset = self.window_offset(vram_addr, size_of::<T>())?;
+        let view = io_project!(self.window, try: OffsetLoc::new(offset));
+
+        Ok(PraminAccess { view })
+    }
+}

-- 
2.55.0

