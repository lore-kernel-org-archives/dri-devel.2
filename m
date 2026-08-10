Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1443C5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D079110E88B;
	Mon, 10 Aug 2026 13:58:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="RyCQJ5oG";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58CBD10E883
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 13:58:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8uX3HAqtA+6OijM3S4D3JV0wsC+W9hLn9dRadQZhHLEr00lLOuZeUQzI1aBh2oll6qWTIhdC6pbUgRxJW1nB0evjNa/uuzTk7Il6zAi45CV0bA3S/0i/a0WdKgvy61RvO0SmQYajsv+wAnUTHYqJC5tUUNFyR3Sx/TZ09FUZpt/gLcerUG8MLIqLUXMxxq/cBgsvri26DuHU6EDtZ4NyiW+zC11RMkDhczez9qMD44CwfQR4p/1VtS6ezaFzcfF+5XCosQRtqPVEMUq+uk8kxSHzI5fgyHVTZR7f610qeUAneekgO6vmR/eXrLrLBQXP6Ntl3F319s0fdLXRA0ZOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjFn8WncNZcNiijYDQqDtx8Sb1nRpzpUXQEdStempho=;
 b=isw4oO5q9xBqcnuqm6T9XY8Vs5xrQx3CqvvqJ3eB/+bpfuZChJ4l2mWklg8cFKVgm3t3HTF31hOMWybVtrvXFAb8Bso/CSI29GDCvlh1v2h7tLc5pVKF167ucFz5oi8MMbjg7AggRp7yK3c9sQ2EqW/UX1UFxUSTti+UWxUfU+qW4fNQkbcXiMI56olzN/uNztjMV365UjNZCotIITeGVdTcY+wVg5RSNJ1fw+CBc+yc5mwZMiGEWseOpYBJxGDAppYr9No714WU4EWdGQzDUHXp4PjmZPVXTi/xIIXgQTWekPCsFNVUsAqSRSgDQgHFeppBCj9daU7JkEDP8NQN3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjFn8WncNZcNiijYDQqDtx8Sb1nRpzpUXQEdStempho=;
 b=RyCQJ5oG0x2IImyTReX1izgdtvGR8UKGpy9yx+huxLWDnAvj3bW0Yz/u7SSNleIyt/Bg/nMdb7iE6vQABRp/1AJ4p2PzoJA4d4QDMJNPbGXZUCQYjJeNwmWdOZcEbWhsj9qQRKJoZrQTzch4ARDhQXRTt/IA0YrUTbxSDBKbN/95kZh+iNldxSptf/ODWRXkMOFIpUd8rsa5Q24X0uoNM/20UtpIH/dRUrD7kKIzFyqWM7vYYONDcV2GnuPuL1nvyKk9GmGRXtTpvohF0oQ8uE5mieIE8m7H7b8n73j9xwfFgtoUII1k3PAeWfURKF+3UOUVaqjhSto8QVEBfSPi7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:58:02 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 13:58:02 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 10 Aug 2026 22:55:28 +0900
Subject: [PATCH v2 06/12] gpu: nova-core: mm: Add PRAMIN window registers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-pramin-split-v2-6-65a00b3c7309@nvidia.com>
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
X-ClientProxiedBy: TYWPR01CA0022.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::9) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 5acf872f-c3b9-46a8-0a60-08def6e764a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|10070799003|22082099003|18002099003|11063799006|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: LN+H3esgxFDdrFpuTx3MSnjIzJPM9Fvkucd6Et+3jpU6RgtLzPVZBCBHFCS2RbvItsYMiNDAM351e5jJYlVHSZ3v++2AthziQUM8hRbz5Efp2CjMO0087lXEIU7B9ZcuF3+fixV8r6hyt2WLOqbnkj45i8+HFqjEqOCuDbf7EbWvK5KoeZNWkH7Z+Fn4DOvB/wgwVQVDkedFYIuRBEqM0WqPcIdRN55LLJe7qCMehcwhy8oJsLtEgn5nC1BHSo5nyRvBYrV2YSTJIXwBWaDYklFTOs55kqekMrahwsFqdaswSsynvHI/8Wf49zCoN1rnnAebhC5L02sKaokvuxxPQ5TnW3rqTjZT/Xt72X6r/XuzMwlhY23++h/pubxQ4/9Yu9BtOE6rCQW4nPjyAoQuw8wUijhzLYXBATPP9Q+el4WUKg4BOwQFQO7cOFEa1GmIUFWHgC9Oo/YhJ9FQgkB4hVX/3cZRoRFdgVlhr5zJd6uT2Nc2b6Flip1sSA/4k2xR1ucsgz5cMlDYr53ma2CwGhYCfrsaf6yxwZ6LK7+2EKy7PD17I5pODYzSsB8ZkmxosifBPu+CgyIW0D7TdQonBZWpTSJP2hwxpG6WN7XjCC7bHHFo/zB4Qd0oskWs442NzWm+eI/rCznTP2yuFTJyAGQMDXla8JYHxFFnGsIhItfi7HW1Re64r/l+GpdQf0HZN3vaCWtjT4t4kVOkQIY9dA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(10070799003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHlJNGpHRXk1YUc2K29Xb2pZakM0bGVXV2V5TE5WOXhzdUx2RlEvTHd5NVlJ?=
 =?utf-8?B?c003QktVQ0ErZ0IyTUZmdnVKOHFBOW9WbFc4K2lZb2k5a3ppTmdDd2xRYmQv?=
 =?utf-8?B?WXlIdE50WXNDYkdLYkhEM25vVjgySnA5MHRSQ29YSEhJQzErWURjSW53VjI5?=
 =?utf-8?B?MjJrZHJaSzRWbTJQbzR5UjhmVkYrQUtDVzhTQmY2WjZJazU0dUZsWjNRZ1lj?=
 =?utf-8?B?Z2FmY1pDQS9xbmd3RHdOVlB3dVBHdGJPYjlBMEV0VjJUS3p1NjBiZENiZHZv?=
 =?utf-8?B?eXRzSWNzZlZxRVZjSGo1OGZtRCtRamlYQlBzdGg1bllkaG4xVEllTjhIMzJD?=
 =?utf-8?B?UXJSM1hpYXk3YnZFRDRQNW1UdEFIbDBNaWVyWk04cFNjR1E2eU9RM2dsL1lK?=
 =?utf-8?B?QUhneEI1dWRBNmV2eWVZZ2ZWbFBDeTRFelZEK0ZjbUI1VE9acXJYNDk3aDgw?=
 =?utf-8?B?UUV6aVgwc0NmSmJsSnE3bFpBR05nOThUeFNEL2I0amEwdWlEcytzOHk1K1hQ?=
 =?utf-8?B?NW9ualB6UGk0eExDaU5hSkt4Q3MrS3FwWU5LRUtCYkhmR1EybzhwLzR4Q1hz?=
 =?utf-8?B?ZmU3enJzYk5aMFQyNmN3Tm43YXUrNEF5ZEdwQm9vY1cwcXdEdUZoTUVoTXIz?=
 =?utf-8?B?eCtqMU5ZSGI2aHhxSFQ2UVF2MmE4aFExd2txVTJKSHhHbFJvT2JNVmNPSHpa?=
 =?utf-8?B?T0tvSUY0Y0dxcG1yblU2eTcxN3kxK1hBVWxERFlVbHh0WUVtWWduNDR0V3Mx?=
 =?utf-8?B?TldtVTB5bGIwWTJyS0x6TUVsa0g0c0lHRWJ5MVBZalg2YmM0THlMcWRQeTdC?=
 =?utf-8?B?Q21SUmlMVXhLMHRQNmdsYVBkdUNuc1c5eDVpbk1PLzQwWWdML0RwS2wwR2xl?=
 =?utf-8?B?MWh1SEE3Nkl4Q3ArQXRPSk5wSEJSVzBEU2JyZmpkZVJOSndGek13akI0K1B3?=
 =?utf-8?B?M3BRbytQN2tua0xnVW5NZWJOaWNZUFBkbkZLbGIvQVVpUHJiUTRBY2o5eXVa?=
 =?utf-8?B?TEs2d2NjeEczeWI0SERwdmV5MmY3em9wTG9FZzRuTjBTeDFwSklqTWV3SHNP?=
 =?utf-8?B?U3UzVXNRRXczbW5zYVFKeEZVV2dsYkM2bHI2QUNXNUYwMnp6cngySDg1bzVx?=
 =?utf-8?B?eTh2aHdQbVRLVXJJUDNFVm1rNWFOWE9FNnNlSm5BWUdFdDR0c1plOGJNOHdH?=
 =?utf-8?B?c2dyYU1RQ2RZdjdaMWQ0cmNEVXlwWCtFbjI5K3BWd3N4Z2tuM3NDdkZBWDRu?=
 =?utf-8?B?bVVxVGNaQ1VHZlJYcnpFam83RGJQTFVJZVBVdys3RGFWbTlSR3dRMHhNOURC?=
 =?utf-8?B?b0w1WFJ4MGtrM2llT2NsTVYxMHhFeUZ2djlBWEY1emdnSUV0YTY1Y29kU05z?=
 =?utf-8?B?aGtsMGM1QUFYRk5zL1FwcFZhVHhYRjhhMFZsN3lqWlQrWVQrYW01U29Gc0tJ?=
 =?utf-8?B?cTY0YjJra2FSQ2RjQmJMbW1yTUE0dU1hWTNuZzBCWUJpaFk5ck1lN2lzSUZO?=
 =?utf-8?B?dXpUNzdxMDhaT2xEaU1mdENPQlVjZzVScllhSFhadnNWdVBhSHpGRDVPRGhT?=
 =?utf-8?B?L09pMXYxOGdvTTJ4bCtWckZhbjR2M3RDZDhKK3dHNHI0WklTcEJXTVNDUVRI?=
 =?utf-8?B?aWRIdVNWdW5ZL0xGVFZFaUJMZHVLdjJKbjM3UmcyQUVHQ043MnkyRlN1OWJq?=
 =?utf-8?B?S0VSZGNUQlJtWnVNR2RhZitvcXVnbUN6SUhwcXNkcEljajg2STI4VzA0Y2cz?=
 =?utf-8?B?empRY2lwMW4wU2U5QW5Eb0lIRGdxb3Y4aWZJVG0zWDZZNW9VWFFicjdaK0N1?=
 =?utf-8?B?VjhsdE9iV3EyazVyUVI1c2JHc3FVZDB0ZzhsSW51UlRERm8rQWlycWFQQVBQ?=
 =?utf-8?B?ZzdHMUMvQXk5YTFqY1VUS3NuVUhXbnVqUjQ1OE5YbFhaZjUvdm5KYzJHWDFU?=
 =?utf-8?B?dEdZQWxnWWI0QzRiN2c0cWVZVkZlNnIwOXNWM3ZHd1lodUc3RUkyNjQ4TWhz?=
 =?utf-8?B?T091ak9kS3QwdFRDVDBsTS9wRkF5MXE0U2drdjU5alpaSVJrM2hDeElENTdz?=
 =?utf-8?B?bFhCZXJjdTNrUE9yRzJTSmtyZmY1RG5nb0FmWFM0ek4zd25raWUzTEpyTUtK?=
 =?utf-8?B?WmNYQkZxRnNscC9kN213TjF0YVE5MmROYndVTUNUUkJVOVkwRFBtR21WNGl5?=
 =?utf-8?B?cFczSGpVOGczcW53RzZCcUhTTS94aWVydUYvRi9FcC9GMW9YTzgyNzZrQWE4?=
 =?utf-8?B?cGtXYkdxTExTY05iaGRrRUlxcDR2b2t4eUFWNS9hWG1ieXlCSXVqUGdaRm40?=
 =?utf-8?B?R0xRdE9PNWhEM2Ira1Jsa3BmS3preWxobElrT2dyTGI3blBsOExjdlFyYkhS?=
 =?utf-8?Q?OafvFTj4CUsG99P21DdtS+GZbGiB9CX/aqBVp/MzUVEwr?=
X-MS-Exchange-AntiSpam-MessageData-1: 7ehwTTTTWcFiBQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5acf872f-c3b9-46a8-0a60-08def6e764a1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:58:02.1496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GA0nn4T+kXanpi0ybFlyLNK55yjqCIc3GIQgSN5T0kxq3RVxBAVr/J0Ci6wVhzXxZ4ETZVfFw2VVmjlKQfEDow==
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

