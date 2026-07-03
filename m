Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA83CC43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C9FB10E110;
	Fri,  3 Jul 2026 10:19:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VinCXhn2";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010020.outbound.protection.outlook.com
 [52.101.193.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4C6810F76C
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 10:19:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTsXdZCPBHjPQg/d53f9oJrfs3J+WbC/JeJwOwEWFeF2bB8vmJ8PWwf7jdUj/q+iAJZS8X59OLeCIZCsPB+x25IOsbJliSYPOJQ6oTY1IEJlftaEI6CMIG63g7jrfiEAlqm62uWLtdHbuVBuNS5mO6iTUYDga4K4O76ucDcxY/G7siBEBwgN/hHJf0BhBl7PlgfoSdHD4S2fkS581n2ObkTKnANQdmGMIcFs883ToIrTuHZef9yFESRiSjaOzw1NeAi5xUQecc1Rlc41Tz9IJZpJvgJ/Es+EYYQ/4m//ibQnL0hBwwi23A5tnH1JgwVW9LV7jkoOgOZ2J9MG+qjNAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XP60X6Db/Y7IMFqRkKjv6AQVLZBDZkiuDY4Z3KQaXug=;
 b=fN3O2d8rjdYOWBNi7nsAh1iDFGSRZ4lNO5sGVChejevNQr1Dm6InZ4Br8N+VMhaxt1G1SvWKHP5at51OsGrRAf5chyHTx7FsqEOW32zRK9ME6x66LTobb8hWeGGpaeKUfDPbkIrZcaWlSG7J72nHzoiw3OsRq7gvvufbcFH7P+CQl5JVR33Chn2xOhnTINseD9b7+PdQ+5sq/5Vuz0rYIaxixyhNdA3lU087tQ+9daowmaO3p3GvtvkC+pFETbfFiMGSrzGSOBdC8S+36KUqIS+BYXa0epMLCJDASLgolsUtQr903UWiF9+xhAzMt06J0eFIbznaKf0AjZyrUSpJWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XP60X6Db/Y7IMFqRkKjv6AQVLZBDZkiuDY4Z3KQaXug=;
 b=VinCXhn2zC8JlPw3R56VQ0YLvagYyxu3c/bS9pFiD1I24Qx0PQg8oDu4eQZTxePujmCgntg3VANfzL43xuj6R3YyzRvD3oSOXcKSolyg2S4Jj9INpa+djYHkQquwFhSosKrPAbLLwNvtTkcQeymRqamaIXJmLUVrfoKz7bcwGq7YPAFDPFW+BbSTo5vjU2ztRoXxwyASbH7CpdxYKkhzivkFIbtVyF2TSbBzyNDE6cETBnQriccTvlo4bY4Vr90vgMT18pygHm1JtBOFHDjCcwJqzOHAyYfpPwm7bl/xxCNypKRKvJrRkDGPvVnBv1PLroXXQAJQEvqWBriRIGSkcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 10:19:37 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:19:37 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 03 Jul 2026 19:16:07 +0900
Subject: [PATCH 4/4] gpu: nova-core: add ChannelIdPool
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-chid-v1-4-84fe8259e46e@nvidia.com>
References: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
In-Reply-To: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>, Burak Emir <bqe@google.com>, 
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
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P286CA0053.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::18) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 16953163-5ca6-4405-69fd-08ded8ec95d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|23010399003|7416014|376014|18002099003|22082099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info: F5Hf/4cSmHgreren0aXxj4Ps93o6ARczWdDbDvWpAXVyQKAt3OR0a3RWv+ZkdZZ7grcaCB7rqYCYZWGpB24lB7GjWH105ITRcnSY5HaMLZeXwAMrhKZdEet12dG0DPJ4bHCYibnTGY1BqZAHtFDdcDQJyDxnNKvmUr1EozTBY26KGtpGBJBHyWBY9xZ9BIYqvzd+bdPqL/daavle1N0Mc4ogyIt1TzzayNZ/v60ek6MGZDhgYlOyy01d/s+bHzXeWqcW6XDw7Nb75ujFOoM526XFmGQ4mq8T35mH7Chj7Q+wGc3rF8z9e61H5pFOcKQZjctvpm9lZ3xlYWr6cQ8OYzz71pwwm4J77XSK7KB8UcfcjS5l8g5lTG9R/UVs3pE9W4cQyCG67KttAZsXWq4AaUzZyjVTaBQ/9pfQXGjQgSFnLv9YJN9JcTN2149icQ7BixoUPMQufNhau8U2uiq/+H/0/2aMaMdajcB4VYBUncBisCubQchkbpzvVgIHcROr/D/XbAAekK5TiYfGccy5FQnTposBCHtGNcaRKhScwvkNHJ54B3MW7IoPPrgFfpDq8G87+5umsrLK0/QAZpXxn3XYM3EvBvtDNQiPLkQK6ycyp48nqm4rqLm44kR+ITVqvoOeCxc8E9zw1XMkxuQqyBShlrWEt/xsAnMtOqWKRF7gYUect7fLQYzg4avl4f8d6UP756HHsx8kAnFx2W5lZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(7416014)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFcxUEk4bE14cVhOZG0rYVpwT3lMR1BLVGxhdDMvRlM2UEJJSVZTMXVCM1dM?=
 =?utf-8?B?RWRyTHZEWnNmc2FMejFieGVpR1Q4RmNCckJtMmx6WnFZSEg3KzVBRE9Hb2Jz?=
 =?utf-8?B?ZEZ4U3d2NURXZmJOSW16OHFqMGNYenJ3WWVYQi9zTURjbmxkZ1lJVDR4cTlU?=
 =?utf-8?B?eGpKcjdselJpK3NKeVlTejFLUldRZ2pWYTROZXUvc2NlWHR5a3k3QUdLbXNN?=
 =?utf-8?B?ZVpIWkYwNEdHeFdNdDlTVWt1dkwzZHZEOFRwa0wzWUV0bXEwTlFkYnkrK01Z?=
 =?utf-8?B?dFBaTW92azNYV2t4bFR6OEw0c0taNkxzcVR0dWtGcjhZeDI4QmU2WlFoVERy?=
 =?utf-8?B?eS9vZkp5alhOTUlOeEJxWjFteFJUdmM4ZUJsUjdPS2JoM3ZURmJUdjh4NmpD?=
 =?utf-8?B?Z0FVbFlIRXJxVGNWNmZ4dlFZN0lpODFXY0xrVzc0VjRFWk9EREVNaS9Ielc0?=
 =?utf-8?B?TEJ1YU1qZmJOb2VNSHlvWldrQ0NTM0FGaGpMcUovTUZsNmxKckd4c01uSGFl?=
 =?utf-8?B?MXJvYTBZQUlVNjZsVmQ3bXlOYnh2U0hoK04yb0FaTjBqM2dUc2o5dFdmbGdu?=
 =?utf-8?B?ZEExeFVrL01wRzFhc3ExWUs3Rmd1MUtvZS9sOElnd2RqNWhDWmVTaURzdzVW?=
 =?utf-8?B?SEZXZzhVL2tDaGNZcGhiOXc2VnU4YVBsZEFyUzlHUEQ5T3IwMURBYzJWbzB4?=
 =?utf-8?B?MmN2RlJCVGhRZ1ZXbG90Y0Z0ZFV1UWcvTVBHK29tK3p3YmNvVmsweVpKSWJl?=
 =?utf-8?B?alk4WVh5ZFd6M0p4cVNQNERDYWl1MVVuZDdHQW1wWk93Wnpmdm5vRTYxRnM4?=
 =?utf-8?B?MTFYcUNoMCtzUEQyZisxZytOdWVpeElJbnRPQW9jMEJxRkZFWWpWeTRPZy9m?=
 =?utf-8?B?bEoxbjZhak5jYTN0Vm9sNzBSY1lVSTNlR1hOQ3RLekVmZEtodjJyaHJpeVVO?=
 =?utf-8?B?VVRESkpqczBOelJoOTFQclg3WUJIVE0ybC83SU5oR3VZc2hPVmZIWVZpMlZp?=
 =?utf-8?B?WDNSM1VuTFgwWDF1Z2hUSkt3K3p4N3BOYS8wWHNxOVd2cVFqdEFJamdGdnF2?=
 =?utf-8?B?NUdqVy9CTE50Y1ZiVFRxQm5MbitRaTIzWjNlVjlaVCtIOW8zSWZHdTJWMXZa?=
 =?utf-8?B?Y0hRUEduRkNPRXFqSzNsRHM4Ti9uTi9xanM3TmcxckhUVjB0eWM0YSt1T2xS?=
 =?utf-8?B?VnBWOTd0RzJjdU42ZUNvVUJjV2Q5b2hqaWc5cTM3a0ZMZmZOM2dBNzNZOVNB?=
 =?utf-8?B?TFMrUk8xT2Vaa1lKZUFhK0NxOUxmQnBXL2ZmZ2o3WGl4WWltMXluWkt5Vmgz?=
 =?utf-8?B?VDdRT25yVlcxNXdPTmprY0srMExNL3NkQjFiOHZKRFRPZEhtV2RFZHFCM1Vi?=
 =?utf-8?B?b1B6cUdJc1N4THQyUGh4QmVkZEVJTFJiNkwxVGsrMmlFUENCcDVzZzc4eFFi?=
 =?utf-8?B?SzJsRGdpSnBpbDdLVVpDWEdONjQyY09Wc1V0S29YR21ML0g5K1lpTytpU3hW?=
 =?utf-8?B?bXVJT0VlSldnYmxkY3BXMVZOZ1dpckNaSS9EUzlBVVI0Rm1NeUNORHk4VEty?=
 =?utf-8?B?ZjNKUVlmRHVtSVd4YTJPVjF3akNRRXN4cEdybndWLysrZjRrbE40cVNYckVp?=
 =?utf-8?B?K3JFK2FMV2tyY2ZVQVVWTjNMUkRnWVZLVzVocDZwaEc1M3pwaWxNZ3ByUC9Y?=
 =?utf-8?B?dFFXSXZ5TUR4aWgzSVVtbkxqcG5uWjZ1WVlHM2Nud3dMSGk0d3ZLSUo4REFp?=
 =?utf-8?B?Z2wza0xnbGF2ZkpBdXlFU1Q0dlJYd0NaczhpQStKb2k0RVIvTUg3V0V1ZThB?=
 =?utf-8?B?eEdFZ2lwV1pOSkVIeGFDekVPWG1tdjRGdE5NVjdKUDhmZVNoVG93L2ZsYnJv?=
 =?utf-8?B?d1JCOVAvY1BFNnhUeTB6SVVHbkl0QnNVMU9JVW9oaFcvb1Q1Q3hxYnhlU2dO?=
 =?utf-8?B?TGlYYVIxQlhLS09vSW90WFFDYkcvUDJVcHlKUVMyKzNmRW5HL25XTU9mNG40?=
 =?utf-8?B?TjdRNUxzd0g4akVtaXZrWkFHMXdqYUFKUU9YaEZ2cWZ5VlJzMEc0ZzVoQzBU?=
 =?utf-8?B?b0EybjMzVWx3eTVodXhNZElla2hFOTU1UzRPQlh1VmdyWmlmeW53ZnlrZDR0?=
 =?utf-8?B?c2R5VzB4am9Na3JUemNPZDA5SGdTUThPeWc4OVN4OVdUdloxbEprdDNRZytw?=
 =?utf-8?B?a2dsVnNaTDNkZVU1a0wxZHBnL3FxK2JUUjBvbWNSbDFLQmdlWWhKT3NuTmlU?=
 =?utf-8?B?b2dNRWpsVklUUFRpZWhXakljTEVzVUVrR1dZcGk1TWw4ZWdGb1h6MTRzaEJ0?=
 =?utf-8?B?S0xuM1J0TVRoOVZkLytvK1kzSnBGWG8zbmEyVm5KNExzT1k5WGVFS1UrakdX?=
 =?utf-8?Q?3jGRT2irhP1KkzxKB2X5AA/67ZIFT3zq2V/FKr1oKaddX?=
X-MS-Exchange-AntiSpam-MessageData-1: KQ6wkmPcf/2adw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16953163-5ca6-4405-69fd-08ded8ec95d6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:19:37.3380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3JtsxdOe9eBZASi+/TdHkzc+wFumqLiCt/tkeUjKDww0wnZglH+aVtCQHP2iOLoS3qi9Acy1EO/5+iBJyl5rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326
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

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs         |   2 +
 drivers/gpu/nova-core/gpu/channel.rs | 134 +++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 43c3f4f8df71..0c3b5de7d849 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -31,6 +31,8 @@
     regs,
 };
 
+#[cfg_attr(not(CONFIG_KUNIT = "y"), expect(dead_code))]
+mod channel;
 mod hal;
 
 macro_rules! define_chipset {
diff --git a/drivers/gpu/nova-core/gpu/channel.rs b/drivers/gpu/nova-core/gpu/channel.rs
new file mode 100644
index 000000000000..5d745e4dc080
--- /dev/null
+++ b/drivers/gpu/nova-core/gpu/channel.rs
@@ -0,0 +1,134 @@
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
+    /// Reserves a contiguous area of `count` channel IDs, returning a guard
+    /// that releases the area on drop.
+    pub(crate) fn alloc_area(&self, count: NonZero<usize>) -> Result<ChannelIdArea<'_>> {
+        let mut ids = self.inner.lock();
+        let area = ids.find_unused_area(0, count, 0).ok_or(ENOSPC)?;
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
+    #[test]
+    fn chid_area() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(2048), GFP_KERNEL)?;
+        let area_size = NonZero::new(48).ok_or(EINVAL)?;
+
+        let first = pool.alloc_area(area_size)?;
+        assert_eq!(0, first.start);
+        assert_eq!(area_size.get(), first.len());
+        assert_eq!(area_size.get(), first.end);
+
+        let second = pool.alloc_area(area_size)?;
+        assert!(first.end <= second.start || second.end <= first.start);
+
+        let first_start = first.start;
+        drop(first);
+        assert_eq!(first_start, pool.alloc_area(area_size)?.start);
+        Ok(())
+    }
+
+    #[test]
+    fn chid_bounded_by_num_chids() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(4), GFP_KERNEL)?;
+        let one = NonZero::new(1).ok_or(EINVAL)?;
+        let two = NonZero::new(2).ok_or(EINVAL)?;
+        let three = NonZero::new(3).ok_or(EINVAL)?;
+        let four = NonZero::new(4).ok_or(EINVAL)?;
+        let five = NonZero::new(5).ok_or(EINVAL)?;
+
+        {
+            let a = pool.alloc_area(one)?;
+            let b = pool.alloc_area(one)?;
+            let c = pool.alloc_area(one)?;
+            let d = pool.alloc_area(one)?;
+            assert_eq!(0, a.start);
+            assert_eq!(1, b.start);
+            assert_eq!(2, c.start);
+            assert_eq!(3, d.start);
+            assert_eq!(Err(ENOSPC), pool.alloc_area(one).map(|_| ()));
+        }
+
+        assert_eq!(0, pool.alloc_area(four)?.start);
+        assert_eq!(Err(ENOSPC), pool.alloc_area(five).map(|_| ()));
+
+        let head = pool.alloc_area(three)?;
+        assert_eq!(0, head.start);
+        assert_eq!(Err(ENOSPC), pool.alloc_area(two).map(|_| ()));
+        assert_eq!(3, pool.alloc_area(one)?.start);
+        Ok(())
+    }
+}

-- 
2.54.0

