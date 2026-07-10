Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96810C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3A7310E1AD;
	Fri, 10 Jul 2026 13:52:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="X3ABIvnx";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012054.outbound.protection.outlook.com [52.101.53.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF92810E1AD
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 13:52:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9WlxfiroOJetqf0fmgYPWlTj7H4MyvpOKWWm+t4/FHWxQ339YwNU+UWFihVHze4GnYMA7Xl1cqttwcpAl8q5sfmvnwATo/EcCdSLx2fAAZAvr+N77Vw+K3RKPxDRnWmPALsT+RmDN/sDnNhna6560oDAttwpbibU1tkY0nNNi+92FnRy3C9UPFnV3hIay8CEEC7m/zOET5eK5LIXaX2Q/HIynKQj+dKS/oZD2deNv9fCDxkG/OS179JH1oYI4Hy8DjDOYR8ab/v3xuvu9HBhHHUZAykPF9cI9Mdq9zUK8laKQP7umOtqEzZxp017Z/EPYDXLRhwyUN4yocQEekEjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmdwYTwXMmaqHEKJMZg9YzkFqD3t3gpkXz/nlWnUN58=;
 b=VOPOh1B3QGn5JQYrY9LCLPdNp/JepB6TDu8aeL7V1ErWoN7YtDcgfzzfDlbGL+LpQ8cFsP15aII0PvM1xBBA8O8ROU1aQkdz0gQalPKIvVAKRdTnQ6LFOSUidEjTGb+M69InXJp6V3B93bKkvU913ng0TgK6wIQPSRDK9TDUnNp8g8Td5lptXWi6AcUHnOnViUIFizm0bcu9cm7x26c7dTbI1/VxpLpuwcHu/TYEx531TMaGC9PsJpNJgMU4YZsh3HgdiLwdgDQj2MGcqkCyJnY/1vnI1eVbd42gEX5JE5TLfQF10hv+KN0uu1MVOlxZkstHWKtdcgCMP1hmpp66LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmdwYTwXMmaqHEKJMZg9YzkFqD3t3gpkXz/nlWnUN58=;
 b=X3ABIvnxPm/2qPPAEk+vnG4h+vfTVASKRNHhqHhwt5t5yXJVFEIhGG6L7bkkjc6Mdsxy1bNGnUhUCC8R1lCM0RrMNJ/gft+b6YRvwjz+ADlKOqvYO6wCCGP+g+pqYQT0f+KMpi+z8qmLAlfS/ehNrxFwBlkYHzXPBBfMIgaE4cHg/iW85veccjCwe3sx4qqlHiWPGmRsgIwFr1umiIcIk9u/ok1qE5JP7UuzcH/4n5aSoRXXKQFtW5ZEArwC6sW0nmutXLmPKbh+7TKsAN/2ll0pQNNz/TpSUuy4XYuDIFxTTmj9ShcQFcNn3eew5LRqFTLKCRgbkEUTd47GHxb3pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MW4PR12MB6804.namprd12.prod.outlook.com (2603:10b6:303:20d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 10 Jul
 2026 13:52:49 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 13:52:49 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 10 Jul 2026 22:42:02 +0900
Subject: [PATCH] gpu: nova-core: add ChannelIdPool
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-chid-maple-v1-1-4ee869055268@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSw5AMBRA0a00b6xJ/SpsRQyqfXji07SIROxdM
 TyDey/w6Ag9VOwChwd5WpeAOGKgB7X0yMkEQyISKQpRcj2Q4bOyE/LUyFLmeYZCpRAC67Cj85v
 VzW+/tyPq7T3AfT/Ju/avbgAAAA==
X-Change-ID: 20260709-chid-maple-3d696554e0a3
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: Greg KH <gregkh@linuxfoundation.org>, Burak Emir <bqe@google.com>, 
 Yury Norov <yury.norov@gmail.com>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0099.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::7) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MW4PR12MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 533a0bb2-2f37-47d3-ba4b-08dede8a874d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|10070799003|23010399003|11063799006|56012099006|921020|18002099003;
X-Microsoft-Antispam-Message-Info: ixe6uafKq76QjoOBouJ34towtCelYRjC12vjtzeGYDoOAhVHaHZsFrKjzeJPKr+Ai4+azR3or2E/SM6vHgh7GM66Uyv93v8Wuh/QxSyDKrZ3YpdJg7bxIvcSt8MDWpPv/EkBiCtc7HiKTZ5mJMQoVHjMKWCOD3ospdKMy/vZ/LT78jI5axHcsTd4uLkExphwRrLlVJnzXumNMhd4MUXxXSuth3GPXfFza5NVxpUlyzwxuLxlFu0jp/KLJfxGRPZFy5oI+iv2SEceD/MUNGqIlp05kH+Y+FD1uIbcNgfypJUUMxSGS0aOwGB7mM7B++DLzvH19KPXRAXOrQjZ5qaROAmfDntVYADazP921O114+//8uOhMlrW7N92E8e4zR77jnHcPKheeungBiDz8U22Qwu8QwpACFluTv252mlMp+ScWUzCCZk04Y2kgncqd5IxhkI+GJrPdkSbQzzkXqy9obCvbJaMfPMHv3ipG3cAiIF0Lx9AnZpwb0tnAIScg7HN1qgWzWVqg4pgdPgLsKQXRwGMd3a8PZcq69OCXV+j8HHYk53jlEhq5nr4pAmrTgQTUmNzXp6b220b7zsCD8bDbUHI2qnoQx4bG8jzNKHg0VuqHI/P+Lm5GPp3To7dOUXX9E3vqJPbOOMyEBUgrF53CXLspn/KzMzqKwl5MKRSDyTF9R1VDFoVe/D2OduGoKvOVstX9GsnofgXsXwMTtI01w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(10070799003)(23010399003)(11063799006)(56012099006)(921020)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmgrbHYxMTBZN3kxZ0J4QUcvZlFZclRxdXpjN0NWbXpheEtTUUJ5K0dTYXk2?=
 =?utf-8?B?U2tmWjdnampKVmJ6Q1laSFRrZzUySXNTL05ycWROSUpsY21Rdnl3QndpTzlB?=
 =?utf-8?B?Q3JERDlFV3ZRTWRzeDFxRUZmRG9tNnB5NGY4SHlvS01qNytwTXBBT3hucDRk?=
 =?utf-8?B?WXE5L0ZGVi9EVUUyUmdwRndjL2YyS3VhZlNTQzgwZ0dpdUpMcDBvMjhRRnk0?=
 =?utf-8?B?QnNOMHhFTFgxVUtieEcxTWZweGdzTGtrcERhK0laQjhIY01DYWhkYml5R2hx?=
 =?utf-8?B?ZisraFVYL1Y4LzY3QU5BQXhoeUI0NTVJamtkRmczYld1RlJIckZ0eEtUQlJU?=
 =?utf-8?B?TFkrVE9jdmlJTXVlTGJTaitLOWw4QU5ybVF1Wk85ekhaWUtmZ1ZRWUdHN1hx?=
 =?utf-8?B?dXhKUmhpUFRtcEEwd1F1WFZmNkJONERDZnFWQzhDUWp6a1RsTTZBbHkwRnFv?=
 =?utf-8?B?b3hOZmMvYXV6QXhlbVMrY250QVZHTWp5M1dOdlNmMzdYOU9Dc2NhblZvWHBq?=
 =?utf-8?B?NUZoUjhtR0d3bFhuVXZnSVlpSkxvcHpwUHhRaEx5dWthb2Nma2tkYS9pTVdQ?=
 =?utf-8?B?U3NaTFFtV2FQYXZWb0xWSVlTcEh6RTNsUU8vZThEdE1CdkZLcEMwekFDN203?=
 =?utf-8?B?YVgxdG5nMVlXMzFGOW4zbU00ZDFYQVFRR1BSWUtjblBpT1U0TVYzakhlTnkz?=
 =?utf-8?B?aWgvREFocWQ5SDBxVDcwRWhCUHJGRlFjZzJMbTVDTkRXV3ZQMUVHbEw3QkRB?=
 =?utf-8?B?NVFDTXczK1JmVHJDNmIwZ1pJUU8zQjRxdXNSVGFRdk8vSmltL3kzU1RlM3d5?=
 =?utf-8?B?bmlSbzQ3blI2c3JzelRxQ1l4QXNraUNwM1dMTEFON2dzVWNlUjlZMWpUaWpr?=
 =?utf-8?B?OHhsNzhxNm9LckZuL2QydUlJU0lianBvSnhqcUdvamVIZzRvSzZTNUJRUXdQ?=
 =?utf-8?B?a3BUSVZCK1kwZFRuUHdpMG9EcWVCYUNCdHBkRjlQTHBpN1RIYm5VMDg3N280?=
 =?utf-8?B?S0VaUjZsUEFBdGRNd3d0aHRFbEJ3UEMzbXhzcWdPSmt3R2NBbFZ0Z1crd3dU?=
 =?utf-8?B?VXM2dU9SRzErZHkybDZZdkt0WUhkWS9UeWI0Y1hCM0RoaUFwQ05FT2p6OWFY?=
 =?utf-8?B?K2hJV1V6WXVoTGhnRW5sVWwwQmYvZ25oMzIyZUhMUnoyZ3VUV2ZPUVVVeXd2?=
 =?utf-8?B?VHFlL0ljekRzckVZZkFIaUk3MGJpaW1OY1NKWVpXOVNrdWcxY0dpVjJyVjBV?=
 =?utf-8?B?TktTZEJNVFM3MzgrZG9yWmZRMXdXdklpQUUwUVQvemxlWnRydFN2S2Z4OEhy?=
 =?utf-8?B?cElZZXc4N1Zjd2dZSnQ0QTVrOVZWd0RiczFUc08xOWljVHdYeEM4bUZwZHNz?=
 =?utf-8?B?NGs0cEZCNXJxUTRyVytJTnE3QmFiUnRaT1ZWbTM4TlQraWJtcHNYbFhWMlNI?=
 =?utf-8?B?VTRTR2p1L01ReEx2NXlZR0FIK29rUUlNbDhxOFZuRXJWRndXaFBzck1DSTh3?=
 =?utf-8?B?QVlHNmJZUS83OVJna3psUmJrTVh2ZHpzVkhBMFBlMGZUSVdvczhlbDl3M3ph?=
 =?utf-8?B?enhEWG9YRnFSYTAwb0N1VDBuOHd1M2V6ZUNuNnlxNi9qb0hBT2kwTXpYY0pD?=
 =?utf-8?B?bWF3L2x4QjZncW5zamRZM3AzQkZGczErMktYbVVoN3JacVAzckhpOWRBYktl?=
 =?utf-8?B?TXBYYm40aUs0UGM5NEZ1SkRPditXcWdLUENheS9UVjg3TURvQnJFeWJjYWc0?=
 =?utf-8?B?aGFKdnN4UUFvYUZEa0dJRjVIT1cxZjc3cWxsUjBVdGh3ZnFMeGJuU2ZRT0lE?=
 =?utf-8?B?NlBuWThnazQxcXNFcS9DaFhzdDZQTGowMlVxUEJyZ3NoNld6ZzNEUnJzWVNo?=
 =?utf-8?B?NG5ZNDNZbzBHeWg0cVdISUNWaGR5Vkt2b0hobWxMTkdsRkRUWEhsWWNJbVd3?=
 =?utf-8?B?NmMyMUFtaCtqWHpCTXFMMzJ3ZkVBT3JoRUVqdlZzV09nNHd4K2o4ZHlIeWdw?=
 =?utf-8?B?MkxWem1iZWx4NHhqc29BV3Z1eCtLaExoUjFMa1p4VnJFSHdWaWxGZC85ZjU2?=
 =?utf-8?B?VVk5OGNjcG5ydDNpUXlCWlNIbmZNUEZjTWh1bkN0eWFkQi9sK2toYk5GNU1C?=
 =?utf-8?B?eFE0YXpMS1VtRTgzZEdTVGxkYU1xTEpzZ0FpdTlPVnU0TGlIRE82RlArYmlO?=
 =?utf-8?B?bmlYTjJzQzEybzF6ODUzTzI2dUxHRWM1VW9GUFM4VWZiSWxxUjlKT1h2R2ht?=
 =?utf-8?B?YkFKZm5tbkd1dWpGVEw2cHVEbVF2TXBWTlRYZFpyWkRIMmlmUndkL3ZTdEJM?=
 =?utf-8?B?cW5QRUd1N3Rtc1hzZTJiZ3JVeTZVWkp2Wm5DMjNZL3BONmlOTmRoL0FLUzBN?=
 =?utf-8?Q?rRxuagVdAH4JpcC5mn2tazMo/5kryb90TdhvQBXsfjcNT?=
X-MS-Exchange-AntiSpam-MessageData-1: bTTJeib6LxkxQA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533a0bb2-2f37-47d3-ba4b-08dede8a874d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 13:52:49.3438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzrPARpv7onB+vn6ZLQP0WiFLa8AuN/C8BtiBeimx3xG4+PQxD2KbZhYARL+bVT9Whw64qAZsZ467T/nGZmVuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6804
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

Add `ChannelIdPool` which does allocation of channel IDs on top of a
maple tree. This is necessary for allotting ranges of channel IDs to be
used in e.g. vGPU and also later for allocating single channel IDs for
the host.

Pre-blackwell needs to allocate channel IDs with a particular alignment.
For this case, loop on `MapleTreeAlloc::alloc_range` while aligning up.
For unaligned cases, this always terminates on the first iteration.
Use a Mutex to ensure that the multi step insert-check-erase can't race.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Add tracking of channel ID allocations, needed for allotting ranges of
channel IDs for vGPU guests and also (later) for regular host channel ID
reservation. Allocating channel IDs is not on a hot path (absolute peak
~100 per second, on average < 1 per second).

For pre-blackwell we need to be able to allocate a range of channel IDs
with a particular alignment. The approach I took here is to wrap
MapleTreeAlloc in a Mutex and loop on regular `alloc_range` lookups. An
alternative would be adding rust bindings for maple tree
`mas_empty_area` and doing a try+restart kind of thing.
---
 drivers/gpu/nova-core/gpu.rs         |   2 +
 drivers/gpu/nova-core/gpu/channel.rs | 174 +++++++++++++++++++++++++++++++++++
 2 files changed, 176 insertions(+)

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
index 000000000000..1f6299aa9f58
--- /dev/null
+++ b/drivers/gpu/nova-core/gpu/channel.rs
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Channel related code.
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
+    maple_tree::MapleTreeAlloc,
+    prelude::*,
+    ptr::{
+        Alignable,
+        Alignment, //
+    },
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
+    inner: Mutex<MapleTreeAlloc<()>>,
+    num_chids: usize,
+}
+
+impl ChannelIdPool {
+    /// Creates a pool managing `num_chids` channel IDs.
+    pub(crate) fn new(num_chids: usize) -> impl PinInit<Self> {
+        pin_init!(Self {
+            inner <- new_mutex!(MapleTreeAlloc::new()),
+            num_chids,
+        })
+    }
+
+    /// Reserves a contiguous area of `count` channel IDs starting at a multiple of `align`.
+    /// Returns a guard that releases the area on drop.
+    pub(crate) fn alloc_area(
+        &self,
+        count: NonZero<usize>,
+        align: Alignment,
+    ) -> Result<ChannelIdArea<'_>> {
+        // Hold the lock over the whole loop so the release and retry below cannot race with another
+        // allocation.
+        let tree = self.inner.lock();
+        let mut base = 0;
+        while base < self.num_chids {
+            let start = tree.alloc_range(count.get(), (), base..self.num_chids, GFP_KERNEL)?;
+            let aligned = start.align_up(align);
+
+            if aligned == Some(start) {
+                return Ok(ChannelIdArea {
+                    pool: self,
+                    range: start..start + count.get(),
+                });
+            }
+
+            // Release the unaligned area and retry from the next aligned channel ID.
+            tree.erase(start);
+            base = aligned.ok_or(EBUSY)?;
+        }
+        Err(EBUSY)
+    }
+}
+
+/// A reserved contiguous area of channel IDs.
+///
+/// Releases the whole area back to its [`ChannelIdPool`] when dropped. Releasing locks a sleeping
+/// [`Mutex`] and may allocate memory with `GFP_KERNEL`, so the area must be dropped in a context
+/// that is allowed to do so.
+#[must_use = "the channel ID area is released immediately when unused"]
+pub(crate) struct ChannelIdArea<'a> {
+    pool: &'a ChannelIdPool,
+    range: Range<usize>,
+}
+
+impl Drop for ChannelIdArea<'_> {
+    fn drop(&mut self) {
+        self.pool.inner.lock().erase(self.range.start);
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
+    const fn nz(count: usize) -> NonZero<usize> {
+        NonZero::new(count).unwrap()
+    }
+
+    #[test]
+    fn chid_area() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(2048), GFP_KERNEL)?;
+        let unaligned = Alignment::new::<1>();
+
+        let first = pool.alloc_area(nz(48), unaligned)?;
+        let second = pool.alloc_area(nz(48), unaligned)?;
+        assert_eq!(0, first.start);
+        assert_eq!(48, second.start);
+
+        drop(first);
+        let third = pool.alloc_area(nz(48), unaligned)?;
+        assert_eq!(0, third.start);
+        assert_eq!(96, pool.alloc_area(nz(48), unaligned)?.start);
+        Ok(())
+    }
+
+    #[test]
+    fn chid_bounded_by_num_chids() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(4), GFP_KERNEL)?;
+        let unaligned = Alignment::new::<1>();
+
+        assert_eq!(0, pool.alloc_area(nz(4), unaligned)?.start);
+
+        // An area larger than the pool is rejected by the maple tree itself.
+        assert_eq!(Some(EINVAL), pool.alloc_area(nz(5), unaligned).err());
+
+        let a = pool.alloc_area(nz(3), unaligned)?;
+        assert_eq!(0, a.start);
+        assert_eq!(Some(EBUSY), pool.alloc_area(nz(2), unaligned).err());
+
+        let b = pool.alloc_area(nz(1), unaligned)?;
+        assert_eq!(3, b.start);
+        assert_eq!(Some(EBUSY), pool.alloc_area(nz(1), unaligned).err());
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
+        let pad = pool.alloc_area(nz(1), unaligned)?;
+        assert_eq!(0, pad.start);
+
+        let a = pool.alloc_area(nz(4), align4)?;
+        assert_eq!(4, a.start);
+
+        // The area skipped over by the aligned allocation should still be available.
+        let b = pool.alloc_area(nz(1), unaligned)?;
+        assert_eq!(1, b.start);
+
+        let c = pool.alloc_area(nz(8), Alignment::new::<8>())?;
+        assert_eq!(8, c.start);
+
+        // Only 2 IDs left.
+        assert_eq!(Some(EBUSY), pool.alloc_area(nz(4), align4).err());
+        assert_eq!(
+            Some(EBUSY),
+            pool.alloc_area(nz(1), Alignment::new::<32>()).err()
+        );
+
+        assert_eq!(2, pool.alloc_area(nz(2), unaligned)?.start);
+        Ok(())
+    }
+}

---
base-commit: 78900738d981c97aad929e33620340d0d9bcfc82
change-id: 20260709-chid-maple-3d696554e0a3

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

