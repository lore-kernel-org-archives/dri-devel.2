Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38139C5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9872910E696;
	Mon, 17 Aug 2026 07:05:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="uKB3Njib";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012006.outbound.protection.outlook.com
 [40.93.195.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA4CE10E694
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:05:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxTlGOsbVXNUrow/6E7qFkfU7nyrct/hkw7ZrWhG/6P5n9OZba/zMH9kc1a24FzwbRDRaz7dKopBnWe3pUvYCZQI+iBlJOcXDeyBUFwVfbvkQiJ8b4CHyofW3bV8oSscFaSNnk7+AgwMWENwfPL28uQEyt6Eq9plgHVCQPK6ULzOgqql0DHvS0WeFelZntQWIa0KGDaBRBxCdJ3l5SZUDJjKTs/JCZUbzO2eDnYz+572VWPbDgEtgx3861Bw7b0agL2B3CISxe93kx+yHvff3xni9mqsge87GTw+MC1DET+Y6xyqsb27s0d5Vv2R8hjzAMDZHcKefhbTCauGw6sVew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRrfU10uFdhU74EfoODMzyyExyogg0nIZWr59NPHj3o=;
 b=wQCbJ3WvMIe1V0Nv0HFU7OW8pxkSS/TrrcMCSiTergHgFFcKJXBPZ5xRco0BnBE+1tH6xaqXGkaoYTCX05sJicCpdhkC7IyspP98PESzoYkjEAtukYvLAWR9Bxt6nL4YIvR/WOn9qjN6f7T5k4ZOURAHgS9CTtUR7oFNzghX6Bqxbm3Yt1exeechnKctn6pApBJJVwuamf/DspZLHNFceZeGE5M2EojnQTrfAKAl2l2lKiL4MCe+n8FMpPaR9Wtuo+4EYpUVG8kKVdMCIjs83fEYSItv0k+0uW3TKBv5LKufL7vv5dfefzNeL94W+GqaxyPFlLBbKDBmsA7w592AMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRrfU10uFdhU74EfoODMzyyExyogg0nIZWr59NPHj3o=;
 b=uKB3NjibP05RAvCROJI2o/WQLG+egqvaz2XWPlC3aMudwTA8GMy7Z9KcTsvB0jjkn9YIPcV7Lsz0HuwCQn+g2TpVU2GmqoQ1tdXYUfTnbkiejKSF2E94m6IKmnRpDusUZknlIwMaRuQmtE4IcJAuX+DPX0W8zIU815sWSJRoi/lwqsJ7w/JN9TKjC36e3n+kN8tbK6xXfwwTQMdVjFX/5jeMsrjkcIWrj7bprcdUPlkmb4oqUP3IsN4EuPtvdC5+MHBic7DcGRHsolP4m38URTqcI0MHdpXj5f1bHK99uT+4GaT7gBuaOdH/2hvxYA6Wvaghm/fn8nirE2NAUSCjrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Mon, 17 Aug
 2026 07:04:58 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 07:04:58 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 17 Aug 2026 16:04:23 +0900
Subject: [PATCH v7 09/10] gpu: nova-core: add ChannelIdPool
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-chid-v7-9-a5872e64d8f4@nvidia.com>
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
In-Reply-To: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
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
X-ClientProxiedBy: TY6P301CA0032.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3ba::12) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: 600a560a-277e-4a52-460c-08defc2dd937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|366016|10070799003|376014|921020|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4Mfsodv0jFxWKfC7oQSSk3OYoZRvaz6hJ8XeQlm70QWLGjfqujibtxH+hWSsIVIHhdK/UZwXSUGiJ8XlUTZRkRP+ZAMxx9PSLt4l4IJcw5MuIVs93/B47oQJstctaBl8eb4vlcw0IG7MMJIzcxt3Tn1MIM2o4DpC6PP8zaBFYUxghdlum/bBDiSrLB3iABfpuNrbZfdabIUKgO8w1qzb8oNopwgjzhw7BF2rq9alz6RTi26IEiwshHihWHpxCcqr766XbJOpiYPTqhjhAxqD+ybPa99EUvkMN9elT6HLxATPq1tPxSi/V/sRo+mg669HuBRW/azuHmibGXkhX7FWJhW79iOghfx+RolFMyAk8PHaTJ4O62NZpo9aVI80Wt7/t9Z4UWHMCUt39Gy1vT+BbnLsfr2UlE0snhlLmqtlnjMofdhfBiaCwy+PweBz/XgF8yVmLUmloQQya1hqWMaJIWJaEase8/N+tmgBTqynPwnxPyvN41KPQXu0p6n9YB1s/hltlnXz5KXSZhEWZJBSGY8b6ChNl/kCsbj4ecOFp74ozGCOyrfQChSdAniDzpXBVD6v5y4XUwU6xM/syMiiSglPIAPdjtBLDN7Pt30fZAKlWbmTL3CaLszVSiCPsqygCts95KhVo6rlcAj9LwHzh+sUAkclVsuOA2h4dqb/75Z+9dY5ABYl8I7A3v1eihxZDBp8I38zeccMENbc+e7SzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(10070799003)(376014)(921020)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0JDRVZaQVhDa1dkUXpvMGwxRWJkeXU3eFJRemJQSFJFMTFncEcySXorSzIz?=
 =?utf-8?B?VlRiNlhVOGpJdW9ubDY5TmE0ai9aUS95YW82Uml3YVJ4RWJqVHFCcEsxbFYr?=
 =?utf-8?B?bzNwNC9VV3ZnazlGWTNIZndUYm5ZdXVwQjFYcndqTys5OW5MYld1V0JKNlJC?=
 =?utf-8?B?ZTZTSXNpcjcxZktpZVY4WHhVRHRKQ0xGcmRadGQvaDNFQ2RFbHFxVjY0WFFT?=
 =?utf-8?B?elZmSFVXdE01SmVlZWZ5eEF6cktYZklMUzBoQ0RweWlveDIwbG5WRU1ZdzZH?=
 =?utf-8?B?b1BlZHNqOGFFeFJrSGVmdEVlZUg1b0JpTHRhaFFyblFBYnMwbGRGUStrSXpK?=
 =?utf-8?B?YXE0cmFlRXlMZVkyZ2t6dXJVRWozU09QQjFQdWJsUmtkVGpSdDBTdExKMEJE?=
 =?utf-8?B?dEh3UUY0WW50LzZpOGpxUTFJTHFPb2Y1YnErQ0wxdkxiamZIRzBQNlFLcFZq?=
 =?utf-8?B?N0ZBM1l3bGpFU0xGU0lkREx1V0xWd3N3Z0p5bVhEWkx3SjE5V3loVW55SUt0?=
 =?utf-8?B?dXNLSXlrQjVlUm9UY0ZtRFdIdXNFZUVyNWNCNmhlZ3FOK29RN201MjIrMTNR?=
 =?utf-8?B?d3lUdVNBZ0JvM0oxYkhUTlFQVmhkaUNHRXBRd2hPd29GOHJsZnM4Q1hKYmow?=
 =?utf-8?B?b3U3dUF4Y3pBdHM2Rjl5QU9FUEhmVjJieUVYemEralNMN1J3dGo5YTc2Y3Vy?=
 =?utf-8?B?Z1poczVVdHVQN3RNcnhrdXFtSy90MHdnSGxaRmtlRy95S0FVU0tDZ1dTK1Zk?=
 =?utf-8?B?L1hZeXBTTDdGMGJCSllLYWM4V05mdWJ4SzAxRktUUVowdENjdFRYRVlnZHla?=
 =?utf-8?B?aGc3MDJRV0RQYmNFM0c3UzdQQUVJV09mTFVacnpzN09TOUdzTGNzYWVxa015?=
 =?utf-8?B?RWtSOEJxd243THJOTTJtR0U3b0N5aUFFR1FoazdtQmxzSFM5T3B0R1hjcnZS?=
 =?utf-8?B?c3J3UG5rckZYSHRNZGZEMGVtSFBKNjVQakRTazZ3NDFGeVR2TmNHNUtTaWcx?=
 =?utf-8?B?dzlJWXkyYnlFcUlyaEtrRUNqNmlieGM2dXhPZFZDZC83V1dOb1hkY3h3SmJ4?=
 =?utf-8?B?RlFPbWpVNjg1dmdvWC9LR3NubklaN3JrMFU2dXhrQzRzc05rcGsyZDkyR3hL?=
 =?utf-8?B?LzR4NWZWTDVXMHd3c1RLUzBnMm9lekw3K0RGKzNUbVB6U1IxL3FLTTRlK3BI?=
 =?utf-8?B?ZTkvYUpENkpQdTZDUG5aYzY5Tk1zaHFtbEc4UFNwMmxrYkxoMk16NmhKd3pr?=
 =?utf-8?B?aVFVcFBseWYwekN6NXgxd2ZtYnhpVzlsVUxoNGFqZE1rMG5PRDEwWUNPTlNH?=
 =?utf-8?B?Y1pPNnpLdjlEMkE2aHh0U2FPbFR6bWVTRU1zR2pUZkp1ekVabkRtQndpSTF0?=
 =?utf-8?B?SjlIOHJRRGdTSWorUXhjRHArUWhZMkQ3WE5KRzVFRTBqWmxFaHZhSjdEdmZF?=
 =?utf-8?B?Nm9yTmVlYkloMDhLb1hKWUxqMnViT3BCZVZZQ3RFVWprZnRuSmNhRStrakVx?=
 =?utf-8?B?Ymh4bUtPSU12YUdaNG03emVQUmtjNDhva05VS05UUnpORGtyWXRoNFprSk9r?=
 =?utf-8?B?RVlsWnU5Nk13UkVTcHpxOWdZYVFCTHFpSDZrd24xNVkvVllrNVNCd2JTM2th?=
 =?utf-8?B?NE5YSlRjZkY1elR1TzBoZktJSVhNNDFuQ3J2VTc0VzlJYkZsM0Q0WkZZazNo?=
 =?utf-8?B?MkFyTEFtKzVYQ28rYktkMk00VnBkcU9NN0h0TTJvQmthMWxHSG9HZVlrZlFV?=
 =?utf-8?B?cUZsdTJ3WWkrNHoxMXVwelNmTjQ4WnZhMWJMU1lTeG5pYTBMS3BlWnNKMTl4?=
 =?utf-8?B?OGp1RTRia3JzVFlVMWprYi9sQlBCRmo5UGF6Q0I2WEZZMVJycUZ0ZExEeFIx?=
 =?utf-8?B?MmVuWUpQTloyMU9VYTFpVElKU2dzOXRPbEN1U1JEQlh4UFkzalFiZTVpSWdh?=
 =?utf-8?B?SEZ2TlU4THFXSVJYdDhFSnVkOHFSa21NZjY1Sit6bWpyYXE0MU5mZ0Y4UjJV?=
 =?utf-8?B?eXFSRGZBN0J3cjR1aUhuZHNpTzN6QkFGc1k4d3hoYm82Z09FNS9tRGMzZm4v?=
 =?utf-8?B?Y3lRUk9IOEhTNTZ3QUhNUCtwaGRaNTFHNVovS2xvQ1RlSnp1RGVHWmh4dlE2?=
 =?utf-8?B?cUcwUUVNSnlkR09ueWZzQS94Nm1pbzZGY1RRM29lV2ZLdkVCTk1xQ0dRS2pi?=
 =?utf-8?B?TVF2U1UxVFdkdy93UnovSFFqZDMvVmhkNm5sbWVMRXU2amxPQUxZbDVvbTky?=
 =?utf-8?B?ZmFqZkNKWFprMjVncDhNZ2VWRlBlV3ZRZHN3UVUzRjRvMm44MVBLYW9lcSt4?=
 =?utf-8?B?dnQ2bXBHTkwwZDJTbDArQWFnbXJ4SWJpWmliNUxyYy9ZaWMxL3pWaUh4NnJI?=
 =?utf-8?Q?L9sz5ku1lcSEIjTOLeJT9fWZffiWWbfn5bJJ5nitJWzxo?=
X-MS-Exchange-AntiSpam-MessageData-1: T0yxmYwHMipyLg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 600a560a-277e-4a52-460c-08defc2dd937
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 07:04:58.2129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udwNYrNoLz2qCHJpijaxsdgsiiAhF/BbYuiwejF5oMw/N6rKMzctiRhzqYxvzr28uzC/W9AhER65HddM8a3S/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732
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
 drivers/gpu/nova-core/gpu/channel.rs | 201 +++++++++++++++++++++++++++++++++++
 2 files changed, 203 insertions(+)

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
index 000000000000..029fd843bfe3
--- /dev/null
+++ b/drivers/gpu/nova-core/gpu/channel.rs
@@ -0,0 +1,201 @@
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
+            inner <- new_mutex!(IdPool::with_capacity(num_chids, GFP_KERNEL)?),
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
+    use kernel::{
+        nz,
+        sizes::SizeConstants, //
+    };
+
+    #[test]
+    fn chid_reservation() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(nz!(2048)), GFP_KERNEL)?;
+
+        let first = pool.reserve_ids(nz!(48), Alignment::SZ_1)?;
+        assert_eq!(0, first.start);
+        assert_eq!(48, first.len());
+        assert_eq!(48, first.end);
+
+        let second = pool.reserve_ids(nz!(48), Alignment::SZ_1)?;
+        assert!(first.end <= second.start || second.end <= first.start);
+
+        let first_start = first.start;
+        drop(first);
+        assert_eq!(
+            first_start,
+            pool.reserve_ids(nz!(48), Alignment::SZ_1)?.start
+        );
+        Ok(())
+    }
+
+    #[test]
+    fn chid_reservation_drop() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(nz!(8)), GFP_KERNEL)?;
+
+        let a = pool.reserve_ids(nz!(3), Alignment::SZ_1)?;
+        let b = pool.reserve_ids(nz!(3), Alignment::SZ_1)?;
+        let c = pool.reserve_ids(nz!(2), Alignment::SZ_1)?;
+        assert_eq!(0, a.start);
+        assert_eq!(3, b.start);
+        assert_eq!(6, c.start);
+
+        drop(b);
+
+        // Only have space for 3 IDs right now.
+        assert_eq!(
+            Err(ENOSPC),
+            pool.reserve_ids(nz!(4), Alignment::SZ_1).map(|_| ())
+        );
+        let b = pool.reserve_ids(nz!(3), Alignment::SZ_1)?;
+        assert_eq!(3, b.start);
+
+        drop(a);
+        drop(c);
+        drop(b);
+
+        // Everything was dropped so the pool should be empty.
+        assert_eq!(0, pool.reserve_ids(nz!(8), Alignment::SZ_1)?.start);
+        Ok(())
+    }
+
+    #[test]
+    fn chid_bounded_by_num_chids() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(nz!(4)), GFP_KERNEL)?;
+
+        {
+            let a = pool.reserve_ids(nz!(1), Alignment::SZ_1)?;
+            let b = pool.reserve_ids(nz!(1), Alignment::SZ_1)?;
+            let c = pool.reserve_ids(nz!(1), Alignment::SZ_1)?;
+            let d = pool.reserve_ids(nz!(1), Alignment::SZ_1)?;
+            assert_eq!(0, a.start);
+            assert_eq!(1, b.start);
+            assert_eq!(2, c.start);
+            assert_eq!(3, d.start);
+            assert_eq!(
+                Err(ENOSPC),
+                pool.reserve_ids(nz!(1), Alignment::SZ_1).map(|_| ())
+            );
+        }
+
+        assert_eq!(0, pool.reserve_ids(nz!(4), Alignment::SZ_1)?.start);
+        assert_eq!(
+            Err(ENOSPC),
+            pool.reserve_ids(nz!(5), Alignment::SZ_1).map(|_| ())
+        );
+
+        let head = pool.reserve_ids(nz!(3), Alignment::SZ_1)?;
+        assert_eq!(0, head.start);
+        assert_eq!(
+            Err(ENOSPC),
+            pool.reserve_ids(nz!(2), Alignment::SZ_1).map(|_| ())
+        );
+        assert_eq!(3, pool.reserve_ids(nz!(1), Alignment::SZ_1)?.start);
+        Ok(())
+    }
+
+    #[test]
+    fn chid_reservation_aligned() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(nz!(16)), GFP_KERNEL)?;
+
+        // Alloc 0 so the first fit for the next area is unaligned.
+        let pad = pool.reserve_ids(nz!(1), Alignment::SZ_1)?;
+        assert_eq!(0, pad.start);
+
+        let a = pool.reserve_ids(nz!(4), Alignment::SZ_4)?;
+        assert_eq!(4, a.start);
+
+        // The area skipped over by the aligned allocation should still be available.
+        let b = pool.reserve_ids(nz!(1), Alignment::SZ_1)?;
+        assert_eq!(1, b.start);
+
+        let c = pool.reserve_ids(nz!(8), Alignment::SZ_8)?;
+        assert_eq!(8, c.start);
+
+        // Only 2 IDs left.
+        assert_eq!(
+            Err(ENOSPC),
+            pool.reserve_ids(nz!(4), Alignment::SZ_4).map(|_| ())
+        );
+        assert_eq!(
+            Err(ENOSPC),
+            pool.reserve_ids(nz!(1), Alignment::SZ_32).map(|_| ())
+        );
+
+        assert_eq!(2, pool.reserve_ids(nz!(2), Alignment::SZ_1)?.start);
+        Ok(())
+    }
+}

-- 
2.55.0

