Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AFEC5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ED2310EEFD;
	Wed, 12 Aug 2026 08:52:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bk07PpFX";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011001.outbound.protection.outlook.com [52.101.57.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 346A510EEFD
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 08:52:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpFJ1pNeguWP25BSywFIxg+eY1FWpIuFiVu2ztfN72Rglwi3GAdcMldZXvVgl/yVlUlObTFg2o5FLZ64bS7kd1UBVm+FvP8Zso0aecn4s7Y+FwdGNR1Ad/AK8T1tZn+ePWc1DX7NS6FJi6oZaFmwaIZ3yVBxTq6PXcbPtSDEHwXWMa9U76BlhQ5VcT6Dsi/R7sfbNisSoazCBUEjS8T1tHQNIVkNlqdkKpx7vz3r3pBxJlBeYgvg1cbE14HwMBIiPuppTrpRgxBg/1ZIbM1BF0r2bnURTGnsbXNTxOg7k+A2j/1nMswjDV3HiKhFYv2HYMO4EDje3XSkYtedvxVbSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYYa87mvZyrUbfsj52KaS35BAILXm/I/ciOxRXaZQOs=;
 b=acseGBnZpEQMdDlJYNufBonsPQGRBNMkTYu1MS8ao/nLVsU8qAJEIGFaMImOiLwx96ye2Hye8CEkanXTlylRgIgBGwP2GGvp/W93qVOdKh4IFq53nU+q3iNBCf4ndIaLnJXtNd8rU0RzimGWYomr8JihJoCSOyD4/Chj0d03e+bqC2u7xHG4e3tKiAdGpWkwOKOfzhntXfvEBuvv/O3Lc8hlu931D/kWl/KD3Q9vz7Q/4pZvpI71sDmTwX63iLam7tScQkii5/uCTekXjR7LUe8Yf7JqQzrGlBsmJjK15ySAj9Msd9DNJ1TIEv1wteLdjSx9nL4fmBwIdcxWd4zc7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYYa87mvZyrUbfsj52KaS35BAILXm/I/ciOxRXaZQOs=;
 b=Bk07PpFXbQggKQ7kwtpA86VeQk9xT3Bo3a2c+mDpfTlrYsxVUnyTtuIlEblpnJfEiR6Q35gUNbFvFfSyXxvfKBOscGwP/WlhJj3zzslO5Sz1rNbQaA2DUMPhtYHeQaW8rJ7EEPUiQEKx0U4u/n3YlA9vMaULn16GYf32zxdsgzMVM5r7FwUCVL2epGKmq7WtSKt9dlYf5/vsEqZiWwzNYZni8fnZzTrkh5PZehNRR6YrUFLbKW/cbXMhQbI/6T8pkLI01cW5t64R5oUJHbS7n8o/ujSao+4lOMg8KbaGb8udDHU2G8y+yPo0+gDb+bwLHj1PvaWs57oiCvQ75fXAlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 08:52:04 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 08:52:04 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 12 Aug 2026 17:51:25 +0900
Subject: [PATCH v5 5/5] gpu: nova-core: add ChannelIdPool
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-chid-v5-5-6c767770b3f4@nvidia.com>
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
In-Reply-To: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0360.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::6) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: d1b97548-bd52-4a02-9d39-08def84efb88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|7416014|376014|366016|1800799024|921020|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: EQcL+3TzmH6+8r7aE8lsaj4e93o92YZwauF1f96MOHq9DoPtjep+ty2cOboOa+/+1nGKCR3PAEWc28OpvN/Sxrfq26L5YhXmQgJkQM0GxF5PvjCMYoXKei0M6i1f/41utVtpOP06FMrWFV0pKgdiqPtCEONgScKDjIL9KtaGuaGQ/0KT+Y62jokNXMngxrQfX38q8QX8/va+zatej3+8SjZnykVkYJqBSykA7yKJbrCpmw8VBbM5RjMj+gUgEXVn55lkxqLQVN/MdiBXxOTCRTZO6HkbxkKGqc/MJPC6gxA3UeWgSnbQ5xHCq6ryZCpcQxkDL+pxbhGbDNw0ecOB7ikBVbwB1LNu8hsP+VvD38GV+syc/D0QfdKVOF/wLArV4l/+anHKseqR/yNCPXkvIprThIWYmukveZ77hcSNbBD6hECrYIObVDGt7tFEEwa2mlax6Z6vU57isxy6J4PTtg4aoDM4c/Z+zwCOqSHk4WSn4FNqn2LhQMorW5VluELMvJ5iSodVcELPIjEpw90NUw3YQc4gdDZj59eJXir3q+qFgIYFpD5mjCMmOEgIFgI3Vb7/htyVVsbnzeeC/sJEz5b8geYb1ttBVoIpyq4Wump30JlCEzPWCrJMGpccPX34U9n22ENfGe0lCYN7o04zxkToaq3FfrOMoKO4Wo4j4I0yT9RqjHrwIj7LAkEzXN1bPMIotiSSNQvsPe7ZdWjf/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(7416014)(376014)(366016)(1800799024)(921020)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGtpaS9MVjBFUHJYWGZ6a3R3Z2c2QytyQ0YwRjVobGp0STFveGVJRkV3UFFF?=
 =?utf-8?B?dGJ5SThpYU93dlF6Q2dOaHdzQmRYN3VTemd4QjBXb2MySU1xWktTcDhqeWpl?=
 =?utf-8?B?dUUyUHJVbVRhNERwZmJIWlRkd2Rpbk50MTJOeS9yMXB3djk5QTdzYzJBZVAv?=
 =?utf-8?B?UFpnQUF0V3FlRG1WU245ZDJCc0YyemVqcDJINkpVeE9YZnlhUUxxNFdud00y?=
 =?utf-8?B?MVFsN2pzTWlTb0JZNWdjRGxteHNNN2NzNjZjODhCRkthNGZBRVpZZFhzZDFv?=
 =?utf-8?B?YVBiVzNVcCsrTzk0bHZUNmRoWHhMcTlhSktEZGZXaUxHVDBDRjFKdGcyVjZw?=
 =?utf-8?B?R3hZYTdkT21OcEplT3M5RC9HNTJRWmRYYnJFUXhZNVJZcTl5bzdzYmlwNUxo?=
 =?utf-8?B?M1ZycDB3Uk0xUGxyR2kyMkp0UVgzZkJhUzRuYzhVYUR5MkpIZzlGdXZBakRB?=
 =?utf-8?B?WHVvRC9seG1OOU1Ua0wrUmc1U0R0WmxtS25CTXhaOTBYQlYreXN4WXd4QjA5?=
 =?utf-8?B?UnNuMWY3SFlRVXJWUGREZXFWc2dLUXdNeXdVV2RGaHcvMEZaMm94aVdxM3NK?=
 =?utf-8?B?WTd6WjBncFE5ZU1oVERlcVpudWQzVjVoNjk1MGs2eE1pb3J0KzY3cTh5eVlL?=
 =?utf-8?B?VGkwMkxNVlNYWHowN2dGQzg1RllWWVpOWjdtdWJ0YnZqbWV3alR0K0xTanp4?=
 =?utf-8?B?aWtmMEpxY0h2dlJ2Njk5NUI1a2EyVkVsbzhLK1ZnbEFBd1BWQ1o1cG1udmlt?=
 =?utf-8?B?dGFQOGJxVzd2TmVhNmZNbjZ6NE9FZUhiSExsMnUzb3NKWTNlQ0NwZlVYTWhw?=
 =?utf-8?B?YU5BUWxWZ0J6dXZjOGdPdngwaE9XVHo5RzNQRTl1c2ptdXppcUptbEVDNVFp?=
 =?utf-8?B?TG9YUG8zVkQraDYxeS9xckN1elZOMExxTjI2dStQdENKMW8wNlB0Q3UyVXpv?=
 =?utf-8?B?RGpIamlOK211N01XTi9LYkZaQTcvNnowOEw4Q050RXR4YmJkbXlvblQ3czFv?=
 =?utf-8?B?TjVHV1RJMkxBcHVHTkdmVHF0OFhiRWdVbWl4VnNaMy9RVTFzN1RjT0FVVTRq?=
 =?utf-8?B?TFZOMGJ4Uk4wWGszNFB5bUVGelc4RDQzcWdZM0lBajRtR3hXMjZ1MnRqdEJ5?=
 =?utf-8?B?aDBMaEZjNzVZNXJmU3lqTUF4QkkvQ2RCVHdEclhmWmM2cmZRZ05RSVFJeDB3?=
 =?utf-8?B?U09TdXk5ZDF0OStjWFVGMFZwNG96NmVMMzFFMkoxUFJ5Q0JYcmxpTzRvQlpR?=
 =?utf-8?B?NW1HYmxrd1FZSXZlY2lKQVFWeXVWc2hRaG9hc0dsbVJBTndSd0JCM0ZMUUJH?=
 =?utf-8?B?RkU0bGlRbjBkc1ZmOThKNE5WV1ViWUhmN3Rxcy9UelJwODhxeFlMMFRhV1hS?=
 =?utf-8?B?WnJaN0dTOStyMVd0Vk5xbkpmYlZWNGVoUUNHY2ZXNnlVVElUVmh4blFUMzE2?=
 =?utf-8?B?MW1nVVBxZHJhSHY4NDU1Yk9mUTJWbXU2R1BZZHM1cmxicFdSWlRBWkQ1MVZo?=
 =?utf-8?B?MlFEMkQ4N2c3Yzk5K3ZDZmNiMkF6azlWQ2tzRzNJb2RlVTFCRXJpYmxOb1Vq?=
 =?utf-8?B?SEVPbmhVclJQem5xSlVsS01kWCtPeXgvVi9XallEK0VPN1BoSTNYdWZxdXp2?=
 =?utf-8?B?ZFJGMFdCdDBwQ2RSNURvZUFMdURrK2ZYRDBjWnpiaTlMVkdMNzlUc0JtV2I1?=
 =?utf-8?B?dHJ0YTBUMyt4Q3NhU0V4RDBZM1UzdEtmSEdPR2FDL3ZzUGhRSFZoSUtRa1BW?=
 =?utf-8?B?L1B6SGVkeGpnOVJmNXhRU2NwSWJmYXFmSERINzBMNi81QjlFMFArWVFCYmRV?=
 =?utf-8?B?ZWhyZE9CZnhMY2dWNEUxWUF0dTAxUTkwTjRBZ0RXdTVERjI3QUo5V0xXMXg4?=
 =?utf-8?B?bERjenVTOHRwVlFwQU40aVVSTzNzbVFNNmJkcVQ5NGlqbS9CQWFGQmxmWXE3?=
 =?utf-8?B?RzlsSEZUZ0xBUS9GY2Q1VHRoNG5TdVhLMGR4UjQ5OHRmUXZTeUh6TXU2NWtJ?=
 =?utf-8?B?WEJmVFlad1F2VS9tMVhBRlljK2NXVFpyRVJnUmtrS08xdUJBQUpsajZNRVpJ?=
 =?utf-8?B?TnRVVXlrTGd0ZjJMN1lxVEJJM2VMd1hWK29hODdhamJFWVpEeU5rTEdJN0Ru?=
 =?utf-8?B?OUh4R2wvN3hNdDRkWmVDak81WHBqaTVjczRzaGNWcmlOY2RDUGFXc1hmQUtH?=
 =?utf-8?B?OHJ3OXhqNnU1ZlZyNGtFTXZST1hJZGVtdnVHZlY4MjBqc29WVmZSZ1VGenJB?=
 =?utf-8?B?YTJwbWt3ZWJQRS9hU0NBRHJoeGlxd3NoM2lDNnROd2Z1RGJNYTVobXNXZkIx?=
 =?utf-8?B?alczb1hZb2UxMFhMTkJMczlyeEttSmRGY3lHb3M1WEtXSXB6RC9zdGVYWno1?=
 =?utf-8?Q?H4FQ6cb7B1rPOMFHprJ1/fexl3W+ecvdD+JW8wKSjF5Ir?=
X-MS-Exchange-AntiSpam-MessageData-1: I7tbhtt/z9G0lw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b97548-bd52-4a02-9d39-08def84efb88
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 08:52:04.5593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PpCnDBHd8qhjvHrBjF3lwav8D57IwcZONJ556DJoZQDEIgnZtvSN+YvVMh7v5BZ+9BN0eGd9qML4boeVhMZaRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519
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

