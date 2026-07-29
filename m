Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07839C54F5C
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 06:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC1AC10EAB1;
	Wed, 29 Jul 2026 06:54:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="iAqF9TWC";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010040.outbound.protection.outlook.com [52.101.56.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51D7610EAAE
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 06:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qy9QRwfCvPVU/DkaDjaxHR7YTSNoThCfPFX0CuTlnJWxa749r2iHU3HnQBGUDC/yew4Z+gfpqrrwZcBMLW8sWXi4l0EXTHsbuvYIfGGgaVL6q9GguIIbyNd/CgnR53Ka/GTtDlvcqT6dFUHRvySwAWGCcLV9C6OKD6W2Q9EElAWjSlikqd3LA36V/8Ts4z5DiuJGhwiKwaVftI0Q0RE5V/5Jaqn/3Fp5LBE4V8xv31WFbOYarkGppg4MBuCu+mmnErmxL3MXCjU2cmLx4wnW5qEc8W2n4QAUIj5XhoROvIHqN08at6J8aepskT4bjjwVtWP7HkniX1bAxipo9JAYLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYYa87mvZyrUbfsj52KaS35BAILXm/I/ciOxRXaZQOs=;
 b=KjY/0dA11ckYCZXKPJlilO4TkQEtTQYYyc05oDga6mDH/p9Nzz3BxtSQhyWca/7j4lK9htTUiRSWrGHIwfq/bIo34rjVW4Kc/xGCZAFSqtxUkrn0Q8yUHvGZIZvyh4n7NuC24PFBhT07C5LyYlRVzFQsb9KLI+ss1YGX1vw1hCBArxVdHrasZwQ1RPF/yiZLm1q/VcGFK1IRNC+014XRgYzbzYMXfHdE3PmmjRcK3PI/VS2QS2HFKYY9/Dq88q90++IMZib3EZ44A7IsFZ+1rVgMA39sTVZ01Xczmj6QJsLdVcLtKCubkGc3F3Ko5rb+8W40scJQ9fCvSB2U+rF1jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYYa87mvZyrUbfsj52KaS35BAILXm/I/ciOxRXaZQOs=;
 b=iAqF9TWC4sBdbuoZDs4aPu34a3MfOflstB7mgyZfmbi14yW6jlKUhqPIer/BUXrZVZb0tVDwhRdmME3ZZfHsz9s1eQN4ZI4Mr2h6WiT9F2iUICqoNKSUiIqvgRnUoqL1s1G0rFq7CGvor6leoP7NqEzJNt9Y+1zM/h3tTbZfsc7UZq8lCbaM5LvvapCfthcqLh8hIbaW4QspscU2mEFPyJ0s2/SEDN3uBF1/rZrvH0KfhVIg+j0oNgOsJFf3b/AutrHTlsbcatWXsb7qSW/uT9QeDRixewW9+8/59NCijHXwi4RXtGEog9Js7wY1U/Xzy6lRz0WVdgVNi27SyakGkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8894.namprd12.prod.outlook.com (2603:10b6:208:483::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 06:54:38 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 06:54:38 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 29 Jul 2026 15:54:15 +0900
Subject: [PATCH v3 4/4] gpu: nova-core: add ChannelIdPool
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-chid-v3-4-20cc08032bbc@nvidia.com>
References: <20260729-chid-v3-0-20cc08032bbc@nvidia.com>
In-Reply-To: <20260729-chid-v3-0-20cc08032bbc@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0175.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::15) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c1ea93-e6b1-4df9-d302-08deed3e41fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|10070799003|376014|23010399003|366016|56012099006|11063799006|10067099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: 4HrFAaJP1lJC4YPyEXlssbeepS0ijuOgd/JFsIAt9vbn9bYmjYUk2KJkCLme2XvbQEzoXL+FjR3oSIsR9GWqZYmzl7RrpZztCkzDZPlPkDrtam+ZFqB2qonnZWIto/DWusSjTMlJ1i0xYjXSYyzEQ/PER8oEjGr+rmEWvJrXIamiRUOHW/AkIPJQD07OVITPlne5imfLq65W89g1a2E+AyT1qiYaLpx6PRXtP3Ie4hBlazfIbYwrfvDFHTcKCiJIVV3YbuCr/VQwU3xYlXRUISnJBrbtQKGtP82q5iHs7bn1kXCBpzaB6Ku1R5K/lLI85VEW123wQASnZAMq7fsh8cVAqur0fPmk6su4nq/iEqr5GI1/5H31GcLTm0OE3+J+VaHiEPkJ+crX2s6E4Zl79R/X4pLyFzzRP5BopRhLcO4OkQmHOF4SXZhG6eQoOMYrOMSKrpKPtNxsrpxgWgP/NBxcIxnPYwg4Pt0cXkFn+p+jvU2sBfSYiIjs6meHXaqcdoMzVGKeqQOheVXFj7yi4Bri7NX0LvLb+AHEKw8S4Ruwh7vLr+k6S4yy9G60hjuOUf/ZR7akdLFZq4yJ4tj7ztlEozX06YnwAKYYL/CuvF03vpjD+BWHHhr/NwAeWxczW6FJ0vqZX3qzpNBB18sx12dGoHNGzZmP4p2foJZetbf8lLDRFhGLcU01azzYN530CzdlmOB/9b9IcYg7qS6r1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(10070799003)(376014)(23010399003)(366016)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVM1bktKTjdLS3N4bHNqcURhbHBHQjltUXlhNi9oSzlPRkQ3VHVvai9pVGlJ?=
 =?utf-8?B?SDQyOFpaMGgyTHdFck9XMWRMOEpXVzdUUFdMZzIraVp0Y2FwTWdRUUZrbXlQ?=
 =?utf-8?B?SEgyTDZXd0Z1emEyTDRwRnRlMk50aVdrMVZtclZZWnI4cG9aNXVUQTZuV004?=
 =?utf-8?B?bFoweDVoUnNhYzNLSUtCeTVDVVRWUi81YkN2UTBYdWVmNVZxblE1c0I3dWpu?=
 =?utf-8?B?UTN5dWs3OEZjZVYxN1VMbURtUHFPTHZMU1hjdnI1MW81UVhUbkQvNTlaRkVC?=
 =?utf-8?B?ZDVBWEVhT3A4Q1kySWtZN2pQNVdIcFphaWNUb1Q0VlZ0VzFlcXZNNktnRWpy?=
 =?utf-8?B?UzNCTzhXek1TVFVOY1ZYa0d2dG5oeTdVNG5Zb3YvektoRUs1NzRYYzhoYTdG?=
 =?utf-8?B?bER4SjI4eU9WeE5NdGloWXA1VjFpSTkrN0dDamt6QlBXV1VxQzdHRDhFVWk2?=
 =?utf-8?B?clo3MFdFazBpNzlhYzJPN1IxM3FXc0pUTzZlV1FTUy9OY0hzc2twamRja2gx?=
 =?utf-8?B?Vk9nN3Rha1pUK0pDejZZM1daT3dTeFhmdkthY01JNWVIOGxYREgrL0ZZNEVu?=
 =?utf-8?B?TFRWVUJYUXF5bWdtQXJDVkQ5WmViVkM2c2k5UmlHenlQa1BWYUFzMFcxOTds?=
 =?utf-8?B?UmdkdmR5Q1RvbGx4Tzl6YTRLUDNISmN1U2xsMlpiZkxBRFY1bm4rdmxEZmZz?=
 =?utf-8?B?dDhCTDh2MDZwY09FK1RTcG9BcGRYZFB4R3I0N3ZUeXpDYUJZUGlSWi9veEg3?=
 =?utf-8?B?SUd3MjQ1a3lCcnFKSmwvd3ZNc3I4djRvbHh1MWd2VlVtRUtUamUzcm9WNWZU?=
 =?utf-8?B?Uko1MjZsZnRSWlB4ZU5KdzBFeWxscG50Y0lPTDFjbTNQMmpOYU5sUzR0ZzQx?=
 =?utf-8?B?blBMZ3gzNDI5RUQ3UE95djM1YlY4VDdkQVZ1azU5ZjV1azByNHNxRUpOanZH?=
 =?utf-8?B?N3B6YW9RdW9CeVE3N2hKVFpSNHN1TWlad3R2dEtoRmZSSTlnZTROMXZrd0dF?=
 =?utf-8?B?WDcvVndjMVQzM2lJSkJFSllGK3padExmc3U4U2dUOXhDNjFpdE9sa3Y5SnRu?=
 =?utf-8?B?YjVmR2sxdGpwbXRsR05keGk2VS9aOFFtOFV4YmpMUGl6YkF1N1BpQnBjNUNS?=
 =?utf-8?B?b3JhRm1Sb0libkh4OXA1dUIwT0dBTzlra0pFM1c1NFNzWDhDMGk2bUJZSHMx?=
 =?utf-8?B?c1FyTldtbFo0b3NUbk1RdXVpQWtlUDFPNC9lVnVpOWxlNU9pT3JaYzhqOHYw?=
 =?utf-8?B?Vk83d3RsNGc3ejkrM0ZmU0paWHE0SFdZeC9WcEFSZk5Pck54cis4ZHVUd0tw?=
 =?utf-8?B?TjdKbm0yS1hOWDZNYm1PZnZvOGxFMythb0pGZmlGQXp6clExTkRyMjBYb3hO?=
 =?utf-8?B?UWlrbFFSa1c5QzliZ0c1UThjMC9PUFRjK0R6YW1idGJDZFhQWkNRVngvTjFH?=
 =?utf-8?B?SU5mSy9jRzM5M1dQOU5vY0tYRXh3ZFNKNjhXV05jMld1QkxiZDNJR0FDenlZ?=
 =?utf-8?B?TGR1YVhxY1FjUUIza2J2dkhLS3BSSlFabVNheXVZY2VDREVwNWUwbzluQm5T?=
 =?utf-8?B?bHpyZzJjRGgyZjd2Q0ZIbkQyakhwOEJDcjh3MlJielhFS1pQSVZBSmlNUk1Q?=
 =?utf-8?B?OVlFZThtdC9HQkZDUHJEajVTc0VITzVLUXRVWjFSNGxTNzJJMktLQlFmNWRU?=
 =?utf-8?B?cURHblVYTHVQazgrSHJnVWJOcHNZV0tJeGxTU2gyTVlsakx1U0tlM3IvYkZu?=
 =?utf-8?B?NWxHRVcyT1dZZC9LWHJvRTBsS1F1SVgvQ1ZaK3B1amNYV1pjQ3pjVVZFMWJl?=
 =?utf-8?B?U2dQa0R2bUJjQ2FDeTJyUXVFMUNFYzNja1JaWGFCdXZJMkwvTFNWNStwSm9C?=
 =?utf-8?B?cFBabk54ZncxTk9rYk9XY0YrOXpDdFZ0ZWlwWXY3S1B6ckF4NUdaaHZZSVQ3?=
 =?utf-8?B?NGhlRUJpc2VvY0hKSEo1ZjVvQzVBRmNXU0UrVmgzdnRrVk9HU0gwcjZSRnAv?=
 =?utf-8?B?MTRza0VxREFaUitBSTVGT2duYm9MQ1NDa0RuelNjL0VNWXUxRmxybDZGOC9z?=
 =?utf-8?B?Z1plYWFhOVdhaGl3L3c3ckFaY3JJOUIxelcraE1BWUl3WS8yMUVvQWZ4a1VN?=
 =?utf-8?B?KzJLbHZSNXBRSERVak0vSjUwQzE1eUdVYXBJQXJtbm54YWNndTZKZUp5bGJQ?=
 =?utf-8?B?UWlWMUZhT0xvZWZmT2dIcGEyS21seU9BNFNmYzZ6R0s4VWtZQUs5RGxRdUJI?=
 =?utf-8?B?ZFVlS3YxZkMrbERjb0gzNGF5ZXdNcjZla0Nuc2tza0VFVU5JOERENVpqajJs?=
 =?utf-8?B?a2NtV2VKNGdMMXFGUlJLdTdZTWpxcE1KWE9TV3FDV0tTQm8wbVRyR0pGYnpS?=
 =?utf-8?Q?R3bn72QIJjBSpD03IagQhN3DnXBEVQtJOS5eD+V+WOKwm?=
X-MS-Exchange-AntiSpam-MessageData-1: ENBBzD+JTxdfnQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c1ea93-e6b1-4df9-d302-08deed3e41fd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 06:54:38.4958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DuziO/T0VI5/pWOYqPJQi1r+AIS4m502mwvGpWwBeia9a8qbswpgCgkmEYtscHCY94hjqcW6nB2GX3RWWUIPrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8894
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

Add `ChannelIdPool` which adds automatic tracking and releasing of
channel IDs on top of `IdPool`. This is necessary for apportioning
ranges of channel IDs to be used in e.g. vGPU.

Channel IDs are allocated as a contiguous sequence with a specific
length and sometimes a specific alignment [1] for vGPU. The ID space is
small (limited to 2048) and allocation is not on a hot path, so a
bitmap-backed `IdPool` is a better fit than IDA/xarray (which allocate a
single ID within a range, not a contiguous sequence) or a maple tree
(where aligned allocation needs an alloc_range()+erase() retry loop that
essentially reimplements bitmap_find_next_zero_area()) [2]. It is
also faster than maple tree [3].

Link: https://lore.kernel.org/all/84bc8bd2-e292-4b84-9580-a1b5df4c5bdc@nvidia.com/ # [1]
Link: https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@nvidia.com/ # [2]
Link: https://lore.kernel.org/all/20260717053241.916441-1-ynorov@nvidia.com/ # [3]
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs         |   2 +
 drivers/gpu/nova-core/gpu/channel.rs | 180 +++++++++++++++++++++++++++++++++++
 2 files changed, 182 insertions(+)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 42a4cd7971fa..66ea697a89f8 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -33,6 +33,8 @@
     vgpu::VgpuManager, //
 };
 
+#[cfg_attr(not(CONFIG_KUNIT = "y"), expect(dead_code))]
+mod channel;
 mod hal;
 
 macro_rules! define_chipset {
diff --git a/drivers/gpu/nova-core/gpu/channel.rs b/drivers/gpu/nova-core/gpu/channel.rs
new file mode 100644
index 000000000000..b755d2184aee
--- /dev/null
+++ b/drivers/gpu/nova-core/gpu/channel.rs
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Channel ID allocation.
+
+use core::{
+    num::NonZero,
+    ops::{
+        Deref,
+        Range, //
+    }, //
+};
+
+use kernel::{
+    id_pool::IdPool,
+    prelude::*,
+    ptr::Alignment,
+    sync::{
+        new_mutex,
+        Mutex, //
+    }, //
+};
+
+/// Pool for tracking reservations of channel IDs.
+#[pin_data]
+pub(crate) struct ChannelIdPool {
+    #[pin]
+    inner: Mutex<IdPool>,
+    num_chids: usize,
+}
+
+impl ChannelIdPool {
+    /// Creates a pool managing `num_chids` channel IDs.
+    pub(crate) fn new(num_chids: usize) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            inner <- new_mutex!(IdPool::with_capacity(num_chids, GFP_KERNEL)?),
+            num_chids,
+        })
+    }
+
+    /// Reserves a contiguous area of `count` channel IDs starting at a multiple of `align`,
+    /// returning a guard that releases the area on drop.
+    pub(crate) fn alloc_area(
+        &self,
+        count: NonZero<usize>,
+        align: Alignment,
+    ) -> Result<ChannelIdArea<'_>> {
+        let mut ids = self.inner.lock();
+        let area = ids.find_unused_area(0, count, align).ok_or(ENOSPC)?;
+
+        // If the pool is small, the backing bitmap may be rounded up to a larger size.
+        if area.range().end > self.num_chids {
+            return Err(ENOSPC);
+        }
+        Ok(ChannelIdArea {
+            pool: self,
+            range: area.acquire(),
+        })
+    }
+}
+
+/// A reserved contiguous area of channel IDs.
+///
+/// Releases the whole area back to its [`ChannelIdPool`] when dropped. Releasing locks a
+/// sleeping [`Mutex`], so the area must be dropped in a context that is allowed to sleep.
+#[must_use = "the channel ID area is released immediately when unused"]
+pub(crate) struct ChannelIdArea<'a> {
+    pool: &'a ChannelIdPool,
+    range: Range<usize>,
+}
+
+impl Drop for ChannelIdArea<'_> {
+    fn drop(&mut self) {
+        self.pool.inner.lock().release_area(&self.range);
+    }
+}
+
+impl Deref for ChannelIdArea<'_> {
+    type Target = Range<usize>;
+
+    fn deref(&self) -> &Self::Target {
+        &self.range
+    }
+}
+
+#[kunit_tests(nova_core_channel)]
+mod tests {
+    use super::*;
+
+    const fn nz<const N: usize>() -> NonZero<usize> {
+        const { NonZero::new(N).unwrap() }
+    }
+
+    #[test]
+    fn chid_area() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(2048), GFP_KERNEL)?;
+        let unaligned = Alignment::new::<1>();
+
+        let first = pool.alloc_area(nz::<48>(), unaligned)?;
+        assert_eq!(0, first.start);
+        assert_eq!(48, first.len());
+        assert_eq!(48, first.end);
+
+        let second = pool.alloc_area(nz::<48>(), unaligned)?;
+        assert!(first.end <= second.start || second.end <= first.start);
+
+        let first_start = first.start;
+        drop(first);
+        assert_eq!(first_start, pool.alloc_area(nz::<48>(), unaligned)?.start);
+        Ok(())
+    }
+
+    #[test]
+    fn chid_bounded_by_num_chids() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(4), GFP_KERNEL)?;
+        let unaligned = Alignment::new::<1>();
+
+        {
+            let a = pool.alloc_area(nz::<1>(), unaligned)?;
+            let b = pool.alloc_area(nz::<1>(), unaligned)?;
+            let c = pool.alloc_area(nz::<1>(), unaligned)?;
+            let d = pool.alloc_area(nz::<1>(), unaligned)?;
+            assert_eq!(0, a.start);
+            assert_eq!(1, b.start);
+            assert_eq!(2, c.start);
+            assert_eq!(3, d.start);
+            assert_eq!(
+                Err(ENOSPC),
+                pool.alloc_area(nz::<1>(), unaligned).map(|_| ())
+            );
+        }
+
+        assert_eq!(0, pool.alloc_area(nz::<4>(), unaligned)?.start);
+        assert_eq!(
+            Err(ENOSPC),
+            pool.alloc_area(nz::<5>(), unaligned).map(|_| ())
+        );
+
+        let head = pool.alloc_area(nz::<3>(), unaligned)?;
+        assert_eq!(0, head.start);
+        assert_eq!(
+            Err(ENOSPC),
+            pool.alloc_area(nz::<2>(), unaligned).map(|_| ())
+        );
+        assert_eq!(3, pool.alloc_area(nz::<1>(), unaligned)?.start);
+        Ok(())
+    }
+
+    #[test]
+    fn chid_area_aligned() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(16), GFP_KERNEL)?;
+        let unaligned = Alignment::new::<1>();
+        let align4 = Alignment::new::<4>();
+
+        // Alloc 0 so the first fit for the next area is unaligned.
+        let pad = pool.alloc_area(nz::<1>(), unaligned)?;
+        assert_eq!(0, pad.start);
+
+        let a = pool.alloc_area(nz::<4>(), align4)?;
+        assert_eq!(4, a.start);
+
+        // The area skipped over by the aligned allocation should still be available.
+        let b = pool.alloc_area(nz::<1>(), unaligned)?;
+        assert_eq!(1, b.start);
+
+        let c = pool.alloc_area(nz::<8>(), Alignment::new::<8>())?;
+        assert_eq!(8, c.start);
+
+        // Only 2 IDs left.
+        assert_eq!(Err(ENOSPC), pool.alloc_area(nz::<4>(), align4).map(|_| ()));
+        assert_eq!(
+            Err(ENOSPC),
+            pool.alloc_area(nz::<1>(), Alignment::new::<32>())
+                .map(|_| ())
+        );
+
+        assert_eq!(2, pool.alloc_area(nz::<2>(), unaligned)?.start);
+        Ok(())
+    }
+}

-- 
2.55.0

