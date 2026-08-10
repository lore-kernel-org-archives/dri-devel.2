Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5A6C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 08:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 843BE10E724;
	Mon, 10 Aug 2026 08:36:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="p0dCm9X1";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012035.outbound.protection.outlook.com
 [40.107.200.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A554510E724
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 08:36:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txh42d0BQM+NuNd4hbGnBen9s1fFvs5J1vxgGCtJ2wX60ane2y4w0i/PhCcyiKIGK6KN4qn/PV4382/BGu/omGO+Y3Pshbj0eTzcnA4NCjaBqzbZ1oCy4I7Om1auPbbxgehCJXw+nrWMTWuYnC5dSasVd9Toonn87kPCbHVl5XbZLD1zJ6pudp6jgUDYy/ga1xvRu8I0qJHAfJx23UoE/cSSa6mY1SZAiPQRMy8OS8ur8d6xz3zful9XYjRrX57edP30HsKj1qeKCc7Q4kXba5w3o5JaXnDJpDS9tLOVMtYyxBfbMJt5XzNjc4UdzN1hj9Bb6awCBoMr55P6OwIpsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYYa87mvZyrUbfsj52KaS35BAILXm/I/ciOxRXaZQOs=;
 b=YycZd9YFfxcPi1f1T0n2GpYYGLrjTHSqDln6bGRalyKlnj8j79AmKh0QNTIv9F6EkNOew0zsOnrL2Cn3K7DhXdJRnCYHMgxreyx2eISZWIaHWe3ZXtAZC5hFm0RNhzWf78tX3duwz4ha1kMBTAR5QZgbSHMfA63zwMdqsmGWEuOXkcHddEKnl/gYOdqIvYX8h98iKjJ/QEau6N3tblesy4wOUYUU+mofmYH4PGAabZ37NI0QgSj07A1dWKKLu8fFB9dSqfkOHJEznrAEb0mc795s3s0uXctLfDiHtJKqPzVvztJ+mqBjfuPuca7jI4Va4vhkaNlWU5UZxWkygQXOcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYYa87mvZyrUbfsj52KaS35BAILXm/I/ciOxRXaZQOs=;
 b=p0dCm9X1os+VRuqyReqO67cIEYzJhvJ67enNxRuXCYC0PYqUcOE0CdVmPu/lm5+pKOB9ZB1LgLmNiqxZuZCEogaCfljDdUXM500UyKpxeYCPb/CtrWWktnCBu3r/dCb49b+dzF+GeRNePOPizEgU9tZFRkOAUi/a2FyuVoxm4HFGgbyQ9xXT7baBMfnyPxQjqv1aKLn/du52wCOhLssegzhQ7DsX/nABQ1Dpl57fEffgyuLb9MhGyxZPJhncpV6wPG0//noNqdRfMow6sgchYSk4VrK3KNDzRWU5OF6syABeeBZHXL/qS8ONtfnSVjAxE2stloSRiul5yk+y2TpuWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY5PR12MB6036.namprd12.prod.outlook.com (2603:10b6:930:2c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 08:35:58 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 08:35:57 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 10 Aug 2026 17:34:13 +0900
Subject: [PATCH v4 5/5] gpu: nova-core: add ChannelIdPool
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-chid-v4-5-c9f206fdcb97@nvidia.com>
References: <20260810-chid-v4-0-c9f206fdcb97@nvidia.com>
In-Reply-To: <20260810-chid-v4-0-c9f206fdcb97@nvidia.com>
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
X-ClientProxiedBy: TYCP301CA0055.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::6) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY5PR12MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: 00e886ef-4fad-47d7-b2e7-08def6ba6680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|10070799003|366016|18002099003|22082099003|11063799006|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: FBBe3P8NGneQbJoOEUxL9FY5Or5Ur+USjGiwdArFsl9r7kKeUuntMjC9X65vWcndLnAjLntKPCNmQWzgmzIeO9bmzuE/E1O5aWxOpu42koeFznWDifrF7rLAQWrpCsbkVXDSALo3H6o2GwhN94/+2XCPIqleV9lz/gdWHGUHlvFuiL5K+krPhvgB7Uc1Ei0DPFYBAlvAEPwBWPpQ0FpzDqbnF87hUWjsDa/MXL9wzCY6O68x3rd2XgGn9UUgR0PwZdpvbchzsBYl1F7zDelVuvYjQixQTpZymcQEQeiAYij/H/uweqLl4Td9qH4zCIAE80T0/k2I1LHEy+gf3pjmtCxzh+iWoe/CBK/10ScAM0Y9AQ/Gr5r6WNOWhbRJJubhntSoEcrNLtShnkskA6GyjwRHvH62uFqN2J7lfyvnGHo3aMPIcAzzu8inJYI1QHyd7jMatcMiZhYlr37usKyKUbPE/pqWRJGT6HyGyC13GJiuG2Qx7ovdCBtzxU81z2ftiEiMmv8NkQdquyIYQrwtf9Y+L4AGQV1wx0Hg79Q8eP4UpDnvQnelyBgGIGUknyVLzN5h+g6fE9rHiWMRLCBW+06iFGwK5Tvu5Ae/xP66J/AmrD8mHNnNy7L+SAefbeNqvmkkkcjYV2cjNDKYsFt4+RI6bXy5WvK52gPg2IOHKXR7ER+gc3YAtHsrykudXLccE90ycy0QV0v7PBq3XIDbMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(10070799003)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TytDRFRjQU4wL0UwNWJPbFpObnpnNEdFQ0p0M2N6SCtoZnFjZ3FtekNGV1A3?=
 =?utf-8?B?RmNpaUVZT3RBcUZEclVJdWpEWHNvUDdKZmtMZ1IyZjBxRTNPcFZVWk5TNXBw?=
 =?utf-8?B?R0J2NUtFd1p5TzFtUHdEQnVMVFlHRlBHWnk0MEJKeVhEUm5ZOUY2L2xQY3NW?=
 =?utf-8?B?KzVzTmhMaER6NEpZdVZUbTJpWHIrcTFmenZmd0hZRFR4VG54bFBYOHFnQnND?=
 =?utf-8?B?UGMzS0Y1aEI3TDBCUWlJU2dxNytyOWVyeC8vRy9QRGVUam0rOUJSOE81aWps?=
 =?utf-8?B?anUwMUtQRURoUTZKUStMNnNKRVY0bm1jSHBuNG96cmNyQjRmTHM2WHprQzls?=
 =?utf-8?B?TmszSVlUUVAvTjg2RUgyTUlObUpTc25ydEtqM0VwNVRKdlVEM0xlYWxObXBh?=
 =?utf-8?B?ODlTSkdJRVMvbGk1WWhodTJtcG9IdUVTeU5KM3hML2kweUJpM0tScGNFa0tD?=
 =?utf-8?B?T0JVTDBWUG1DWTQ1RWZRMHZGMFRnTlNNalRONVRremdHMm8xWGZzSWdiVjNh?=
 =?utf-8?B?OUJaaGdPRUhvbytiWlZwWjl6SXJpYnh0OG1ZNE9KbkR3eFYzaEFTaDc2dHBh?=
 =?utf-8?B?NlRsblM4SFFxUG96T2RTTXZCQy9sUDVIUTNsQXlNZ3F4MVJrK2dGVjFBdFRx?=
 =?utf-8?B?ckdsdXl1c2lSeWEzS2xaTzlka3hFalE2ZXd6aWMwSUw4ZnVmVzRYOEwvT1NI?=
 =?utf-8?B?NUdRQnc2bjJEZFpkNVFGeVMvYm9GeXk4R1pyWWk2dEtrQUNZak5pa1ppRVkw?=
 =?utf-8?B?a1RLekk4NWlCV0x5UzdIRUlyc1U5REhoRzNvNFU0aGFNRUZ6UU5SQWFhUkNv?=
 =?utf-8?B?R2dLU05FcjNoK20vKzBjR25VZG52UUwrRm5vTVV6em1kUnoxUGV6ZUxOa3RS?=
 =?utf-8?B?WHdBQktNTXR0WjNSR2Z0eXZBWmlSYjIrVDVSWG9ISlpxWkZyaTRVcjV2Y3hZ?=
 =?utf-8?B?STY0dGU3RWwzWFp0WDRwWE8vRHYwNVl1R0RXVEQvMTFkZ052S2VXL2cyZ0V2?=
 =?utf-8?B?UVUxN2hmQlg5V29SM2YyTDNNcTJCMXVHbEtSZy9wd2Q4Y0psZWtpeDVZZ2hj?=
 =?utf-8?B?UDdsa1RpWXU0TFE5b25zeGEvcjFEOVVFa2d1K2dBalJNKy9MVEtUNVlVTDZp?=
 =?utf-8?B?MSt4dTU5b2lNOEVESWRXN2hOVWZlTmZoUXZYZTVuNm5QYUYzNnF1bUdTcktQ?=
 =?utf-8?B?TVJTL1hYN3M0WFlKSGVpMnRKMmZlMko2Q09hNi9QVUFBMER6aVhNMGhqOEdu?=
 =?utf-8?B?aXRHcnhlbjdvM3FLZFMyeVg5ckhiSlk5dE54NlYxUk9VcTJ3c0NQTWdxN3Ni?=
 =?utf-8?B?YVFvbkpGeGQ1bXVXNXZvdFRyZUJxeUxQYXhjTENacUJtM29RSEhTRnFaQmdV?=
 =?utf-8?B?VWF2VzMxYlBsZVd0Y25JaWFSTGN3NzUzVzFHSG42R1VwVnhBdUJLSndYSTZs?=
 =?utf-8?B?bXBBNWY2RnRTUHFLUjF5cGJPbmZ3b3p1M3BBZnkyUlFzRkx0QXVRRUtiemFm?=
 =?utf-8?B?bU9mZW5xMk52dVludEVic0J0c28rMzBoRnh6TDBsWmcwNzkzQUwzQzdmUjZW?=
 =?utf-8?B?Tmlwa0p5dCt4czdPbjhoMmFpNE40TDB6ck01cjZ3ZkRkZG9uN25UcFloSU9x?=
 =?utf-8?B?S2lRQXVTdTVwVmdVQnV5MG5aMnAzWGdxbStheFdQWHB1cGRWOUlpdGx5QlZz?=
 =?utf-8?B?RmovdUNGbFBhL090b2tsWC9FeHA0MHZ6MGdnYkE3YWlpVmJMVU9za3dYaGND?=
 =?utf-8?B?RmhJRVVUYXJBYlhXNFN6WUw5RkFHVWRIOFFZdlRUclpSNWhIK2FmbGlGbXBU?=
 =?utf-8?B?WGljVlF2VWs0K2ViRkFiMkFUQkpqQk5FSkNMS3k3VDQyVk5EWHFUSkQzNDBo?=
 =?utf-8?B?S0dEdGwxYTRJeXFLQUxvakRqSzhhWUx6d0EyUXJGbXRid3U3UTd4bUNBWGdT?=
 =?utf-8?B?MXg5ZWNMSEJsYko4Ujcrd01xSWJnV1pHMzZiNXZqVFZveldqRVkxSk9lVktJ?=
 =?utf-8?B?TWxTajIyR08vMSt2RlJtaWEzVUdRYmRVYVpXK1dLNUJIaTQvdWo4aGNJYnZn?=
 =?utf-8?B?NTNaSkIrVFlnRXAraGlJTjk1VTVKZXp0ajhId2JpelFEZXIxaTJ3NFRYQ3Vy?=
 =?utf-8?B?d1hxN0R0dmhLUFJPQmFNYk03aStKTE1oK1ZKSWorSzBwenUvVDhQRWNGRmJz?=
 =?utf-8?B?ZzBvMmVQQVpzbkJaWFRyTDViQ3o4QW9zQ29SWGUvZEQrRTJHUFNOd0dSeTVQ?=
 =?utf-8?B?di9vc0gyMjVZUk10RTdlRjgrb1RBbm5rb3FjcDMzejVGQWVyT3BTcHpyd2xJ?=
 =?utf-8?B?Q1lMQUFxN3lOd2lZQW5DU21QL0VPRDVaeWh5UzlLT0o3bHVodEhiRVJPVHQy?=
 =?utf-8?Q?yVc8JWj3zLwPDTtaInr42WGq7DEVrmgoioaORSsn1H5Lr?=
X-MS-Exchange-AntiSpam-MessageData-1: keBzgFUCeyw/hA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e886ef-4fad-47d7-b2e7-08def6ba6680
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 08:35:57.8406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFHXsaKPQgmh2zNv+grJyj1BLfG8gBmya1b0IJ9hI+H+gD52zJBIppd0kXrkFwTQbQY7JicnA6BRLvOORkAy5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6036
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

