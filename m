Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B7BCCA46C
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 04:30:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9AF110E77D;
	Mon, 19 Oct 2026 04:30:03 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013011.outbound.protection.outlook.com
 [40.107.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61A5310E77D
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 04:29:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upsZ45PzX9+0zuXLduDPcnJM31mtqKmoJ7ZFgwhL4pZYSdZrdpkCzCy25Trh/WbwY+Fz/FdyD3bD/+LwQH7apJZZ3T18eYjoi9iEmF208WehtNCucwnD5JHy/9bkZTC1OoOSNkLbPdjQ+AjkwAU/8PQ0kxZ3QAK5JV1Q1ejGTZhvNlcsShiha1P92M8Wjgem09AY/cNW/I4+35IC8mS6h0dVx1wQ0Vj9g2JMxK8iOBUysD5CfsHKe84Jy2NFWYpVXAtxEwky0tvWlr3VHYOBVmVqNqw4HOeaDE1+mI/99GZQcp5tMf5LXwkjBqs1ZhbS7GX6opUaHU2pAxLJWMFMPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULbxjlnqc32NPPeINw3s3eOievDUW68GpVVsoapWQHA=;
 b=wArt21dLBF9YUeai6yqHdKerGcJQPwCLLnUDc1EJGTp4BkCV3zJcQM1gC68DFEakFEO1aeirz3bysM5ctKK8fzL6LTQ0OaWpKHDaDTt0KyToeZU/ICS+7OYTbhhnTzYK11ZXLSBT739PBlyrrnF2YOSt+yF3+ccsdXF1o1o+uklC7B0q7+VfcjPEwMj+VmUsfgl44JRTvwO4gLr7uQsqQWypXlaW8cmj+o5r1SMWoHnGObCFpRvNFCMg5iVkvv8ti2UduE0kUrWiv5JpRNKqlbMNTxXws59EuTeNmejAoR3k/Dq6VJyckbEg/F4ExDnqU5+smwYYt9uDfXiAdwFPkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULbxjlnqc32NPPeINw3s3eOievDUW68GpVVsoapWQHA=;
 b=MfSHOdkHnNSoBwSHliW1W8pS4U+grvYBMEy/5NOJu1GdCnKNHjC2kM/6BbTwZ0V5m8f0fGC02hXlFcDTsYGEHpJMzjGJdHJmNCJqmy2lp6ffbRWIskfEd5sOyZyLyEA71+0qqAYHfi7sHOli7R0uZMbbSbgQ9k+JyA3V066HCzUazdDD37EncE4ywiRVaMnmpgu890nH5sZXcEr+08RL3sUw/H+ErR5JdkdBtDWfs60MaDuCCK+NfwBmkLazDqKQDp7I3ujcifZYmYK2gmQfrqKDk9WzBI/l8CGCf69DxWzemc760BveE0Ji4zPyy878ZNkGfvbQO8VAuTvUCkJIGg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 04:29:44 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 04:29:44 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 19 Oct 2026 13:29:28 +0900
Subject: [PATCH v10 3/3] gpu: nova-core: add ChannelIdPool
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-chid-v10-3-67de9180b4ed@nvidia.com>
References: <20261019-chid-v10-0-67de9180b4ed@nvidia.com>
In-Reply-To: <20261019-chid-v10-0-67de9180b4ed@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0116.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::19) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH7PR12MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: e39eac65-a0ca-4d72-fcb9-08df2d999a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|1800799024|23010399003|366016|18002099003|10067099003|22082099003|921020|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Ew4LpC0ET/OaPtpb8dCZhBfvrdrNOB00HaVYTx9qlrzGSA5RZjqvYgHWO8jhvmqsAnwZO4Jo959OBPDP4Bzf/HsLI84QTwg8uiYlgjVV6jOnCKKueGhlIAJTsl7Pk/POBtBiuN078f6auzw5yikjolQMPOLZ8rrDLo6mqy69WA/kVYiLskQgxW3khfjTJFvqv6l9vZt0fCURmu4jBWYcdYTrBZbis3C6HgSvFR0WXiVJnUfYpe6FI1LbCGVYV5bEW39tD4zQ9KJNsbOOQEZ98UNpgjmCCYIynTCJvxacYjah5g3Mldw4hy1az1v/5fsaddGC4v8mc1FZ/PRO3hetwOQi9M9c++1xriKjeZewJF1aZVGwsaj+NbyhP0nTruvlIktTIk2oEoaIKsr+aoP8L6nyq9K8/VBA7Fllx8SsfGBFu3bRlA9hlIfWvOqLW+G6Ntt9ybSbFwJjvv38cSsR/2X5JAgjSVmDFf189wWbheVEUVFlIbt8o+NpwGhbENLsKUL6Mxn/9JtS8/7XEgTyx0NGO5d+DFvwAvWYY3rFqDNTV51N5lnSi9NQykFxVhiEbuNJQW9upfYud4f2cJpPOcUHrupgL051q6XkzDGwT1gboEtINtW245P37NnMe8rASfWJM7vWUnAyHG6AEyYeS97yvFCiFrJOBdhNFmDIv+NR1eue9n7xBEf7RYRn8ddhdHpvv4HAOQTo7/cMnWyUuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(23010399003)(366016)(18002099003)(10067099003)(22082099003)(921020)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmlITDhKdmM1WThFUjY3ZXcweUU5OHFwSmlVdG14RHZMT0kxdmdlOExGTnJi?=
 =?utf-8?B?L21xK2drWi9zV3NsQ0xLanZMVHB5T09keGZDWkwzWlhzOHdUSzVNQjloMXdq?=
 =?utf-8?B?UHRMYnYwcGRQSlVvU2NjTGNlbzdIalJELzQ0YS8wcVgzME1IRUt0UFBoNXdI?=
 =?utf-8?B?MUJjaVZYaUM2WmNhc29nTzFCd0o2NXFOTW5ZTEhoSlErcGtyODk2bzZFZEF0?=
 =?utf-8?B?VUUxWW1zQlNycjVkVUplZitiSzAwVnlTRGpBeWVES2lBeUhzN3owTUlhK0F5?=
 =?utf-8?B?ZURDdGdjY3BEemo4QnVOQ0Y4NFVaN0YzR1VXT0c1Z3dzRlFvZU4xZFk1SEY0?=
 =?utf-8?B?RW5xL2tGUGhNN3VONWs1OFdlNDQzSTZQODY4ZDNkYzA0dDhHVXpXNElOYmZz?=
 =?utf-8?B?ejRlQ00yYVYyQnFLQk9ERzlCWS9ldnpOUWJjNU8wSmhjUWtnMlI0bkZyT25T?=
 =?utf-8?B?dnBXamdGWXRKUWdNMGc3RVFLZU0rUTV0TUM3ZVRQcVROVDZlOUxSSUdrY1hu?=
 =?utf-8?B?cFkzTm1EbG9zaEYrY2Z2STdFYUVYbFFQV0RpNmZmYmtaandWQi91TmZVTDVo?=
 =?utf-8?B?amYrR0hwUnBzV2IxMlRtcmcwTk0rVVU0TDlsNkVHdElPZE53ZFJBd1hnSzR1?=
 =?utf-8?B?QnFlM3piYmlVY0JpcEUxUWNVeEk2MWNXZGZSU0IwaGJSME1lL3ErbUhDYU04?=
 =?utf-8?B?VDY4SmE4OVV3MHdUVW1zMy9YQVhvTDdTSG5rek5kSHRLZEh3eXhVbWhuQmhv?=
 =?utf-8?B?ZUsza1pjQ0dpZGo5WklzVVhtWDV2OGluMXhrcmZGRUdlMXRYb2hvM0cwVW54?=
 =?utf-8?B?QURsa3ppSngxeDFBNTZzZlNVeWhjd0M5REIxWVZkYThVUHp3alA0ZUE2M0lZ?=
 =?utf-8?B?RGZzZ3RSZ0drY1dkODRocXRJY00weU83QStWZEY2bjR1M2paSFo4Y2pBYTc3?=
 =?utf-8?B?a1RNTlB5TFozdlRrZitBTC9RbmE3OGhPb2xTSzkxdG81amVnbS9pNlQ1N0pr?=
 =?utf-8?B?cjdKM1RCTzA3dzJwa0RMVEZTN096cTZwZVBqZ1BKUnZMRm5vZHM5SmRVbGo1?=
 =?utf-8?B?Q3Bwajh6Znh3QXdyYUZqMUV2QkRNQjI1QldRTVF2cUJkUjRkeXZmZ08yT3BV?=
 =?utf-8?B?ZVhiVGFxZ2w4d1dudkVHZGoyc2M1Qm5OWExMOVFSQW04azlXdEVNT3JWSTFn?=
 =?utf-8?B?cCt2c0JqTitjb3J4ZXFJRUFsemZGdEQyQ0pIWmxnRDlTRmFxTTFPQVRQVXRI?=
 =?utf-8?B?Rmk1K0JJNGIydXgrRG03TUN0ZmgrM25IbFQrek41LzNNZTlMUFJ1a1ppaHNm?=
 =?utf-8?B?ait0WWNCZVpFalJDWmprdUIwK2p6V0ppNFNDbkhsZWFDMndBUm9Ya0hLRS9J?=
 =?utf-8?B?UytvcU1UenhKRjF1aHppSC8vaSs1QXJ1ZWU2QUlMOVd6QW1JU2RSN2VBM3p2?=
 =?utf-8?B?QWV4RXk5Z2VxNkdWZndLT1o1cnMzNi96bGhhTjFzdTVaSnB2UmtoN3pDV2Nx?=
 =?utf-8?B?Ujk4T2lPekFucDdwYk9kN3RHYXFCeXhUVUl4Nzcyc0Vlc3gwblFrVE1Fb1Rm?=
 =?utf-8?B?Sk90cXBsN2hpbmtYL1RzNjJCVWlkZTNFNUY2WnBqTTU3WmExN201N21tMCtW?=
 =?utf-8?B?RFdodUdaWlBEQXNVVU9MRG9lK3IwYVp1VFpyUjFldDE4K2xITmdoRHNLbHRi?=
 =?utf-8?B?WFRYclB5WEZBb3hjZnFvYTJmV3RMRHJoa0pYT3F5ODNkTTE3cjYwM1JFRzdU?=
 =?utf-8?B?UnQxeGhxV1lxRzJ5cDJ5YzlNS2UwUUhjSGRnYStWWXNBd1FqU2JZeFc0cUVX?=
 =?utf-8?B?SXcyQk1xbGdlcTZQcnUxQW91UkdrYzlSdUxOMUV3cGtFVjR2REpHeCtjN2lD?=
 =?utf-8?B?b1oyTjgyenc4ejZXaDRuQkhsYUQ1SGRxVGpMcHVnUXBza2dSaFpMZHpRVGF5?=
 =?utf-8?B?YUFicjNqZnVmWUcwam5CdUppY0twamw4SmFXdVBvQ0NMWXZ6T2JIejVBcWtO?=
 =?utf-8?B?MG40UEQ1QmFsREFDdkxMcUhmOFZWYzF3NDBwUEFZQVNWdFJGTVFpQk95alBo?=
 =?utf-8?B?RkVpblRxT0dRb3VLSFJpbFliZ05KdWd4b3FPVnJPRVBEODBweWw2S0RuMm5s?=
 =?utf-8?B?d2w3Q3Vacmc2bStkc1BvbEYwODJrTEFnR1VmM2c5akRtQjF0TFpET1VDVG5v?=
 =?utf-8?B?YUEvR2lOZlk1d0Q5N2dnUkdLVFB2ajhkSWs5d0NYbzhjRzZlUnBjUFlyYTR6?=
 =?utf-8?B?QXlJdzlCTFFodWhzdGpBNnN3NFZ1TnVzNVAxdHF5OXp0TnF6aXJRZ2lSbUtN?=
 =?utf-8?B?TG1DcWpUbVdFQUUwRHZObUlTeWRmK2diQTJMTzF1ZmliTzRjK2xMUzl2SUcr?=
 =?utf-8?Q?7bM0pJEUCAEg5Gmy1tgYT0WQvghnQjYGvFtbK3ytozYUB?=
X-MS-Exchange-AntiSpam-MessageData-1: W8MRcSoaxP4EuQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e39eac65-a0ca-4d72-fcb9-08df2d999a06
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 04:29:44.8387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +H3rP4mBcLIc0+V/Mbim8sTXEDS5+slCKHg51qbnkDXXaeDdb8J/2dktoyZUHxwh/GYPAQLtzkD8KH0eZJuG0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7794
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
 drivers/gpu/nova-core/gpu/channel.rs | 198 +++++++++++++++++++++++++++++++++++
 2 files changed, 200 insertions(+)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 9a91cff01e78..c8ffb427e2d8 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -53,6 +53,8 @@
     vgpu::VgpuManager, //
 };
 
+#[cfg_attr(not(CONFIG_KUNIT = "y"), expect(dead_code))]
+mod channel;
 mod hal;
 mod regs;
 
diff --git a/drivers/gpu/nova-core/gpu/channel.rs b/drivers/gpu/nova-core/gpu/channel.rs
new file mode 100644
index 000000000000..485efaba059d
--- /dev/null
+++ b/drivers/gpu/nova-core/gpu/channel.rs
@@ -0,0 +1,198 @@
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
+}
+
+impl ChannelIdPool {
+    /// Creates a pool managing `num_chids` channel IDs.
+    pub(crate) fn new(num_chids: NonZero<usize>) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            inner <- new_mutex!(IdPool::with_capacity(num_chids.get(), GFP_KERNEL)?),
+        })
+    }
+
+    /// Reserves a contiguous area of `count` channel IDs starting at a multiple of `align`,
+    /// returning a guard that releases the area on drop.
+    pub(crate) fn reserve_ids(
+        &self,
+        count: NonZero<usize>,
+        align: Alignment,
+    ) -> Result<ChannelIdReservation<'_>> {
+        let mut ids = self.inner.lock();
+        let range = ids.reserve_ids(0, count, align).ok_or(ENOSPC)?;
+        Ok(ChannelIdReservation { pool: self, range })
+    }
+}
+
+/// A reserved contiguous area of channel IDs.
+///
+/// Releases the whole area back to its [`ChannelIdPool`] when dropped. Releasing locks a
+/// sleeping [`Mutex`], so the area must be dropped in a context that is allowed to sleep.
+#[must_use = "the channel ID reservation is released immediately when unused"]
+pub(crate) struct ChannelIdReservation<'a> {
+    pool: &'a ChannelIdPool,
+    range: Range<usize>,
+}
+
+impl Drop for ChannelIdReservation<'_> {
+    fn drop(&mut self) {
+        self.pool.inner.lock().release_ids(&self.range);
+    }
+}
+
+impl Deref for ChannelIdReservation<'_> {
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
+    use kernel::sizes::SizeConstants;
+
+    #[test]
+    fn chid_reservation() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(cv!(2048)), GFP_KERNEL)?;
+
+        let first = pool.reserve_ids(cv!(48), Alignment::SZ_1)?;
+        assert_eq!(0, first.start);
+        assert_eq!(48, first.len());
+        assert_eq!(48, first.end);
+
+        let second = pool.reserve_ids(cv!(48), Alignment::SZ_1)?;
+        assert!(first.end <= second.start || second.end <= first.start);
+
+        let first_start = first.start;
+        drop(first);
+        assert_eq!(
+            first_start,
+            pool.reserve_ids(cv!(48), Alignment::SZ_1)?.start
+        );
+        Ok(())
+    }
+
+    #[test]
+    fn chid_reservation_drop() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(cv!(8)), GFP_KERNEL)?;
+
+        let a = pool.reserve_ids(cv!(3), Alignment::SZ_1)?;
+        let b = pool.reserve_ids(cv!(3), Alignment::SZ_1)?;
+        let c = pool.reserve_ids(cv!(2), Alignment::SZ_1)?;
+        assert_eq!(0, a.start);
+        assert_eq!(3, b.start);
+        assert_eq!(6, c.start);
+
+        drop(b);
+
+        // Only have space for 3 IDs right now.
+        assert_eq!(
+            Err(ENOSPC),
+            pool.reserve_ids(cv!(4), Alignment::SZ_1).map(|_| ())
+        );
+        let b = pool.reserve_ids(cv!(3), Alignment::SZ_1)?;
+        assert_eq!(3, b.start);
+
+        drop(a);
+        drop(c);
+        drop(b);
+
+        // Everything was dropped so the pool should be empty.
+        assert_eq!(0, pool.reserve_ids(cv!(8), Alignment::SZ_1)?.start);
+        Ok(())
+    }
+
+    #[test]
+    fn chid_bounded_by_num_chids() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(cv!(4)), GFP_KERNEL)?;
+
+        {
+            let a = pool.reserve_ids(cv!(1), Alignment::SZ_1)?;
+            let b = pool.reserve_ids(cv!(1), Alignment::SZ_1)?;
+            let c = pool.reserve_ids(cv!(1), Alignment::SZ_1)?;
+            let d = pool.reserve_ids(cv!(1), Alignment::SZ_1)?;
+            assert_eq!(0, a.start);
+            assert_eq!(1, b.start);
+            assert_eq!(2, c.start);
+            assert_eq!(3, d.start);
+            assert_eq!(
+                Err(ENOSPC),
+                pool.reserve_ids(cv!(1), Alignment::SZ_1).map(|_| ())
+            );
+        }
+
+        assert_eq!(0, pool.reserve_ids(cv!(4), Alignment::SZ_1)?.start);
+        assert_eq!(
+            Err(ENOSPC),
+            pool.reserve_ids(cv!(5), Alignment::SZ_1).map(|_| ())
+        );
+
+        let head = pool.reserve_ids(cv!(3), Alignment::SZ_1)?;
+        assert_eq!(0, head.start);
+        assert_eq!(
+            Err(ENOSPC),
+            pool.reserve_ids(cv!(2), Alignment::SZ_1).map(|_| ())
+        );
+        assert_eq!(3, pool.reserve_ids(cv!(1), Alignment::SZ_1)?.start);
+        Ok(())
+    }
+
+    #[test]
+    fn chid_reservation_aligned() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(cv!(16)), GFP_KERNEL)?;
+
+        // Alloc 0 so the first fit for the next area is unaligned.
+        let pad = pool.reserve_ids(cv!(1), Alignment::SZ_1)?;
+        assert_eq!(0, pad.start);
+
+        let a = pool.reserve_ids(cv!(4), Alignment::SZ_4)?;
+        assert_eq!(4, a.start);
+
+        // The area skipped over by the aligned allocation should still be available.
+        let b = pool.reserve_ids(cv!(1), Alignment::SZ_1)?;
+        assert_eq!(1, b.start);
+
+        let c = pool.reserve_ids(cv!(8), Alignment::SZ_8)?;
+        assert_eq!(8, c.start);
+
+        // Only 2 IDs left.
+        assert_eq!(
+            Err(ENOSPC),
+            pool.reserve_ids(cv!(4), Alignment::SZ_4).map(|_| ())
+        );
+        assert_eq!(
+            Err(ENOSPC),
+            pool.reserve_ids(cv!(1), Alignment::SZ_32).map(|_| ())
+        );
+
+        assert_eq!(2, pool.reserve_ids(cv!(2), Alignment::SZ_1)?.start);
+        Ok(())
+    }
+}

-- 
2.56.0

