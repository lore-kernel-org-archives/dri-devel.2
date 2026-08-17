Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291ACC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:59:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 841A710E7C9;
	Mon, 17 Aug 2026 12:59:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="p2PvxBcW";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4846510E7C5
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:59:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8GgprwrPme29+qJ5ksE0qiIsm29JeaG3SuDdJFrcrqNQMQJ1w/LqbMM9GZQ+g9CNfS4TpzOefgrivyIVH8pLSvA40MOjVs55r6GzcJSiLI9VMe1hMfpCDm89xVYA5YizFK875J6zp+udgNFkJJokos/zrRvNr/nC/1+m0KK2Ic2N+uTa42wD5wcRxigR5bDM3Z00Z7PzB/J5GoIiSq/viLwdJ1wezbTVJg3mxkn30C9LzF9ciz6aBjOnScrzTO64aBWZdf1SUq2aofhxH8zRgnHvsBL0m7nmNu92/IHwmBoVJB4dhKBYd9QL+Bg/SLw8sggUKJvfPbipCjTVoYiwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWuzfJc2Ddb58WWGGah14l7Au5HXeV0jV9L2DSjSv4c=;
 b=wTjUZvCCjKypZK504Sb5HQdA1RzcPZYWo5RHTI/AFSlg3uIk9zsrTrHISQ6ZcxNhGjliVhZ8h1sWJdzWSAFegfZzfox35/7K5QAy2YkxmuDinS6Yc71u3QS+rXb8buOGjGEIhov+fBU+doW6Mn/GrkySl5HsxUxaU+aXqbkTl7Z3TaohJvn2gmQHY640zruszzJf7kNryZTSyulTAUdsckK+i1agfhceW4UIcrt3vtv2NbnfLpPiuqv5maLpmqPC9RvmjqU6APaW0cXAt9xooo/Q5DpRts+pQnvFEMs5Ei+7UKPmAJkG0YbZeK+Ei146/1mcpYHe8MhZYJDF/CtCtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWuzfJc2Ddb58WWGGah14l7Au5HXeV0jV9L2DSjSv4c=;
 b=p2PvxBcW/H4C8YQjU79fzNN8oQwvFWwvi2/s4aCfpP7JbiQk7mCSZQLiP97hb0CIrKm+YX5H0Xo4UN9dS0sAb97JjvJdw1fcydk+jtsezW9bwzWqJ9flUaio458GrvzwHueGKMXS+1/47eqmeeHH/APRZUxsVd9eov2i+en4DuacROb5mftf/OcWDB1NbVhNCQ5dAr6Y6G67IB411ZKGZyNchVbrGU6MKOu0Mt65Kl1ybAjxRxHcvCtTrKB/3FaY8j2ohhfMBxcIXbVF4+lXmGa+cwvGsx9X/cEVwdOCgudsnl9IoE/306qQih79WZ/+lslujRQ6TpUBkX8vu1ct9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH7PR12MB6833.namprd12.prod.outlook.com (2603:10b6:510:1af::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Mon, 17 Aug
 2026 12:59:16 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 12:59:16 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 17 Aug 2026 21:56:38 +0900
Subject: [PATCH 3/6] gpu: nova-core: add NVKV decoder
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-b4-nvkv-v1-3-b84db5e84b67@nvidia.com>
References: <20260817-b4-nvkv-v1-0-b84db5e84b67@nvidia.com>
In-Reply-To: <20260817-b4-nvkv-v1-0-b84db5e84b67@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY6P286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b9::11) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH7PR12MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b9aaa7-c581-45dd-4941-08defc5f57d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|7416014|10070799003|18002099003|921020|22082099003|56012099006|10067099003|5023799004|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 31vS6h8Zyv14+nBvzWcGwsgauE3JHbBa7uaJrX1EDeeeXhpruyG5ERxietMjgA4o1ZeE8WQi9aPM/U3tzXCIBO1q/2fSGQxpzU/K6YOAIhKZ43TbC99rAmj8rVW38XxtTXfJ6K5Y0lkfyKdyrQAJqSZVUbkog6oSVxtK6DYc4YcygbLli7XWsuAfvDPce6QMhJFNmEpUYgqrnWd055XdW1+uXMkoimOkGKjszjrTNERf5mya9drQQXHaw615CPIB5E7sZJ43CipWXKGCc+sAEEEMu2lfH6PH95Bdqr7IaPzHyZSRhBADFckaB9tV0B54JJJsMLFF4uQFXmx2q0KDC5gUlKBbNsBIRHEZ7U2qkTHMbv35cjjCehvxB1tlcRKcg9ZuzWDBvfO5R+DYVi3t1X4JuRu2mF7qSPBeIv9Ho419GUyx2W293dauYfTjzRxCygOOGHIZJrpZ529SUt6pgPN6PKI37PzaTdwXvUuVqJVE62iUnvLrcfbMJkBQjfy+/lJ5R/PhjcsufCZ2jHO3MSPsHXE3ZoygpIj1/2YJ6C09emUJEhwtUjJ0JB9xeMVjgjNz9Wr03rxhKyf/Pz8jEwUlvTntBw805RdvrEirmd8ZtQpc/AdRiON3tm5UGDFk5XCh5cecStabEzeTqICz2Swsvc6jb6ssTIBUFBxh8qwCTB9gdVTLsnn0qFyPPtzLdsoArtiyQl2RKoPVRCtx8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(7416014)(10070799003)(18002099003)(921020)(22082099003)(56012099006)(10067099003)(5023799004)(11063799006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M09scGNMNEtFenA0OXRCZkRxRVRCanJlbWY1NUNaTjZhY0gyMXp0Mm94VWo1?=
 =?utf-8?B?TmRuaXFjRDlneHNaTVE4eGpJSS9iVzFCK3dydXF1dXdjVjFOUjFpZ1JCV1R4?=
 =?utf-8?B?S01EZE1WU2ZaL0xQdzFCYVB1R1NHd3hqQjd5T2xXWldFQ2JIcmpmelJYNnhj?=
 =?utf-8?B?TFB3eVlzLzhraEtQNHpTeU5PVk5VS3J5WTJmYVJUVU5XdmZ6eHJMYkhkWnlB?=
 =?utf-8?B?eWJQU0pOYXAvRkxOYjNTeG1IQmZSdDIra3JGSjY2bG0rMmVpbDlQeGo3VlZ6?=
 =?utf-8?B?c21SSExiZnlabUpaVTRodkpMMFp5RUFieDNOZGd4dVNMd0xnejVYbStQbEd4?=
 =?utf-8?B?YWN2OXJUUlU2N00wc2E0OURKSlhEaFkvMCtKN3QxT0V3SCsxSHdHdUo0SzlY?=
 =?utf-8?B?OVBuQ3NoeVNyL254bnlRSFFyVG5naWllQUVaWVNFaHpMWFphUHI5aUdZMHI0?=
 =?utf-8?B?eWNCdHUxQXY0N2NSa0J5d2ZEcEdneXJFS0U1VGVHRVRrMmRLVndQZ3pCVmlB?=
 =?utf-8?B?ZkJNSnExcTlWZk5uUmhvS1Q0UzhaMEtNOTNYT3Y2SkhVRVgwMUZ3ZXRPMkMv?=
 =?utf-8?B?TjBwamUvTHMwYjVpalVNWjFzekpFcWRyUldwTmx1T2wrTDdKQ3BYSzV5eXNW?=
 =?utf-8?B?S0VSUDB5SFJpNHN2N2dkSFNHKzI3RUZuUEMzQ1cyREdzWGQ0VkZHZG41S3BF?=
 =?utf-8?B?anVLMDBVRDV3MWdOT01EbHZCTlBFTXhobWNoazFFb005VE1TZ1llRkJyQy9J?=
 =?utf-8?B?YnBPeGJjNUx6UlJNdG1YMFZncW1HeGNvVUdmNWZ0enFoNkNMNGxEUGl0NUhq?=
 =?utf-8?B?ZFNidkU4aElFalNtckFhdUJGQ084aGg2MEIwaTBRM3UwaTArcFB2Q2Y0WW8w?=
 =?utf-8?B?ZHFpNDFIajk2TDd4NXNoLzUxWExtY0VtTjlrZUZMU1YvVld1aFZERTBMMzJn?=
 =?utf-8?B?UnVKaWFpb1MyaURqNWZoZEVKYkRMNHRxclZkdHUrWVFJZmNuSVFkQmVnamlS?=
 =?utf-8?B?YWhvWkxGY25XSG5KbGljcEIvZDVCZmc3bjVCcUxwdHZWdEpLN0xLZmhhQnM3?=
 =?utf-8?B?N0YwRm1WSVhRTmZLVjBBKy9CZVU4RWw0OFRyS3BFWTkwWTRMNnlkZFUrbXh6?=
 =?utf-8?B?UEc0S3lJdmlPZGx1K0YyS0VuY21DazRjcVJtZkovY3d3N1ZWdFFQMno3Y0lm?=
 =?utf-8?B?UEdKREFZcTM0Uk1UYk0rMU04c0MyVmo3TlExdzdMZXArV201SVA0ejZzZ3Qz?=
 =?utf-8?B?emxrZERKNXlMeEQxT1F5NWVjZFF1YWR2MkxOWm5SaFZ3cklhNkVmM3haRUc5?=
 =?utf-8?B?OFdsMTRWRmNZTWpzbXpXRC9yMUNqL2hHMklZemZIK3g2S2xsVHhHRkQyTFlB?=
 =?utf-8?B?SHc5d1pVQ2pTdVZZbmc2MXdvNVhOMzZ5emx1QzlGcndjVUhNRUp6eC9MaHhs?=
 =?utf-8?B?eUVOVW9iT05ndlBjaUJwQnVQekJhdm5LQWtDMUY0VmcwQ3h2L1E1UUpPeTZl?=
 =?utf-8?B?TDF3Wk1wdTR6bXNBeXRRb3ByZGNjOEpxTmZTdDhCNUZkckVSc01nUXhLRDVS?=
 =?utf-8?B?NFM5Z0xlWGErcXhuL0hyQ3RtOC9yd3R6ZlhRUzN0Q1RLTFhvWThjbHRza0d4?=
 =?utf-8?B?ZUxZb1VFUmRLaUw3TXNGYnRFZDlpSVd2UHZXc3o0bTE3aTVHdHk4dFpiMmdh?=
 =?utf-8?B?L2s2WHlvZmlZQytuRVE0V2tXdGk0ZmdrdnFZVkptREVhak5RZ0dvY29EaVZR?=
 =?utf-8?B?UlNxenlJSGJDTTN0b2RrRWJGNXV6dTVhMDhhSWhEMlA1Vks1TXJ3Wm9hOFZ0?=
 =?utf-8?B?dlF6RzJocFdqYTNyaXNRVTgwK3ovQ2ZZc2dtMnVyMjRMNS82L05mY3NYT1Jm?=
 =?utf-8?B?akxMZGROeEZESzB3MkZndWVqTTJOOFVuOGVUQTh3RHBQZTBSQms0cU04U2Fi?=
 =?utf-8?B?TTFVa0NYdHRWcGhRamZnVVlsV3FHbENlV1R6WGIxU0R1Ymp6eFlaZERtNGR2?=
 =?utf-8?B?eGhyVElxT0VremJrOEU2NE44K0xOVnJ1Mmg1eVNJajRBUVVaWWlibGp1R1ZZ?=
 =?utf-8?B?MkkzOGNjNmZYUUorZU40RFUyK1prMmY0eFVIZkxXOHlKVi9qN1V4OHlsVWxT?=
 =?utf-8?B?MFFoOXFPK0ZyTFpqYUdFUGRzSStHUkJFZG9XUXZ1S2VaQWlxQzZxMUlmRXY1?=
 =?utf-8?B?QmFLSzlreHY3am9IaWswUU16VFB1TldNK0RrVWx6MjNRbmF0UVFmZ0lGeHZJ?=
 =?utf-8?B?SENwRkdRRGhKSlB0dmI5QjNZU2FtWVI2eTlsT1F6NVppNW0wWG9lM1NsbXZU?=
 =?utf-8?B?R0p0ZVZqV29oMStzaFd4UXJUU2JOWlpDMUpMVTNHK1U2ajArY1V2TEtyU3VL?=
 =?utf-8?Q?V1u+93thxCxnoBkuOl/eYNwdaI1G70iltX//Bjw1SSRiw?=
X-MS-Exchange-AntiSpam-MessageData-1: uOWSXwBMIsO0vQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b9aaa7-c581-45dd-4941-08defc5f57d6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 12:59:15.9973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0+rwfZUpOW1bVDaBAx8+7ISJKhdMUa3ZJk9n/qaWtOWNnSIaMOqlwn4Sucp9pvGiyVEOS1H8t7ruMT4D6azMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6833
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

Add a decoder for NVKV. This is for receiving messages from GSP for
GMCAPI calls. The NVKV format essentially encodes a sequence of function
calls f(key, index, value). This decoder reads an encoded stream and
invokes a type implementing the new `Schema` visitor trait. The
`Schema` trait can either consume the value or not, which is useful for
composing Schemas. If a (key, index, value) is not consumed, error out
depending on `UnknownKeyPolicy`. Whether ignoring unknown keys is ok or
not is per each GMCAPI call.

Add kunit tests for the decoder.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/nvkv.rs        |   3 +
 drivers/gpu/nova-core/gsp/nvkv/decode.rs | 258 +++++++++++++++++++++++++++++++
 2 files changed, 261 insertions(+)

diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gsp/nvkv.rs
index b908f66e760d..64d8d0118452 100644
--- a/drivers/gpu/nova-core/gsp/nvkv.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv.rs
@@ -20,6 +20,9 @@
 mod encode;
 pub(crate) use encode::*;
 
+mod decode;
+pub(crate) use decode::*;
+
 /// The identifier of an NVKV key.
 pub(crate) type KeyId = u16;
 
diff --git a/drivers/gpu/nova-core/gsp/nvkv/decode.rs b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
new file mode 100644
index 000000000000..ee8b6ab5a3a4
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+#![cfg_attr(not(CONFIG_KUNIT), expect(dead_code))]
+
+use kernel::prelude::*;
+
+use crate::gsp::nvkv::{
+    Index,
+    KeyId,
+    Op,
+    Opcode, //
+};
+use crate::num;
+
+/// A decoded NVKV value.
+#[derive(Copy, Clone)]
+pub(crate) enum DecoderValue<'a> {
+    Scalar32(u32),
+    Scalar64(u64),
+    Array8(&'a [u8]),
+    Array32(&'a [u32]),
+    Array64(&'a [u64]),
+}
+
+/// Implements `TryFrom` from the given `DecoderValue` variant to the given type.
+///
+/// `TryFrom` is used by the `Schema` implementations in this file to convert from the
+/// `DecoderValue`s into the types to store. Provide the implementations for basic types here.
+macro_rules! impl_try_from_decoder_value {
+    ($ty:ty, $variant:ident) => {
+        impl<'a> TryFrom<DecoderValue<'a>> for $ty {
+            type Error = Error;
+
+            fn try_from(value: DecoderValue<'a>) -> Result<Self> {
+                if let DecoderValue::$variant(v) = value {
+                    Ok(v)
+                } else {
+                    Err(EINVAL)
+                }
+            }
+        }
+    };
+}
+
+impl_try_from_decoder_value!(u32, Scalar32);
+impl_try_from_decoder_value!(u64, Scalar64);
+impl_try_from_decoder_value!(&'a [u8], Array8);
+impl_try_from_decoder_value!(&'a [u32], Array32);
+impl_try_from_decoder_value!(&'a [u64], Array64);
+
+/// A visitor that consumes decoded NVKV and produces a `Target`.
+pub(crate) trait Schema {
+    type Target;
+
+    /// Visits one decoded pair. Returns `Ok(true)` if the schema consumed it.
+    fn visit<'a>(&mut self, key: KeyId, index: Index, value: DecoderValue<'a>) -> Result<bool>;
+
+    /// Returns an initializer that makes the decoded `Target`.
+    fn finish(self) -> impl Init<Self::Target, Error>;
+}
+
+/// A read position in an NVKV stream.
+struct Cursor<'a> {
+    data: &'a [u64],
+}
+
+impl<'a> Cursor<'a> {
+    fn new(data: &'a [u64]) -> Self {
+        Self { data }
+    }
+
+    fn is_empty(&self) -> bool {
+        self.data.is_empty()
+    }
+
+    fn take_u64(&mut self) -> Result<u64> {
+        // PANIC: `take_u64s(1)` returns exactly one element on success.
+        Ok(self.take_u64s(1)?[0])
+    }
+
+    fn take_u8s(&mut self, count: usize) -> Result<&[u8]> {
+        let values = self.take_u64s(count.div_ceil(8))?;
+        values.as_bytes().get(..count).ok_or(EINVAL)
+    }
+
+    fn take_u32s(&mut self, count: usize) -> Result<&[u32]> {
+        let values = self.take_u64s(count.div_ceil(2))?;
+        // SAFETY: `values` is 8 byte aligned and only 4 byte alignment is required. All bit
+        // patterns are valid for `u32`.
+        Ok(unsafe { core::slice::from_raw_parts(values.as_ptr().cast::<u32>(), count) })
+    }
+
+    fn take_u64s(&mut self, count: usize) -> Result<&[u64]> {
+        let (prefix, suffix) = self.data.split_at_checked(count).ok_or(EINVAL)?;
+        self.data = suffix;
+        Ok(prefix)
+    }
+}
+
+/// A decoder for an NVKV stream.
+pub(crate) struct Decoder<'a> {
+    data: &'a [u64],
+    policy: UnknownKeyPolicy,
+}
+
+impl<'a> Decoder<'a> {
+    /// Creates a decoder for `data` that handles unknown keys per `policy`.
+    pub(crate) fn new(data: &'a [u64], policy: UnknownKeyPolicy) -> Self {
+        Self { data, policy }
+    }
+
+    fn visit<S: Schema>(
+        &self,
+        schema: &mut S,
+        key: KeyId,
+        index: Index,
+        value: DecoderValue<'_>,
+    ) -> Result {
+        let consumed = schema.visit(key, index, value)?;
+        if !consumed && self.policy == UnknownKeyPolicy::Error {
+            Err(EINVAL)
+        } else {
+            Ok(())
+        }
+    }
+
+    fn seq_key(base: KeyId, offset: usize) -> Result<KeyId> {
+        base.checked_add(KeyId::try_from(offset)?).ok_or(EINVAL)
+    }
+
+    /// Decodes every pair into `schema` and returns the result of [`Schema::finish`].
+    pub(crate) fn decode<S: Schema>(&self, mut schema: S) -> Result<impl Init<S::Target, Error>> {
+        let mut cursor = Cursor::new(self.data);
+        while !cursor.is_empty() {
+            let op: Op = cursor.take_u64()?.into();
+
+            let key = op.key().into();
+            let index = op.index();
+            let op_value: u32 = op.value().into();
+            match op.opcode()? {
+                Opcode::Imm32 => {
+                    self.visit(&mut schema, key, index, DecoderValue::Scalar32(op_value))?;
+                }
+                Opcode::Seq32 => {
+                    let values = cursor.take_u32s(num::u32_as_usize(op_value))?;
+                    for (i, &value) in values.iter().enumerate() {
+                        let key = Self::seq_key(key, i)?;
+                        self.visit(&mut schema, key, index, DecoderValue::Scalar32(value))?;
+                    }
+                }
+                Opcode::Seq64 => {
+                    let values = cursor.take_u64s(num::u32_as_usize(op_value))?;
+                    for (i, &value) in values.iter().enumerate() {
+                        let key = Self::seq_key(key, i)?;
+                        self.visit(&mut schema, key, index, DecoderValue::Scalar64(value))?;
+                    }
+                }
+                Opcode::Array8 => {
+                    let value = cursor.take_u8s(num::u32_as_usize(op_value))?;
+                    self.visit(&mut schema, key, index, DecoderValue::Array8(value))?;
+                }
+                Opcode::Array32 => {
+                    let value = cursor.take_u32s(num::u32_as_usize(op_value))?;
+                    self.visit(&mut schema, key, index, DecoderValue::Array32(value))?;
+                }
+                Opcode::Array64 => {
+                    let value = cursor.take_u64s(num::u32_as_usize(op_value))?;
+                    self.visit(&mut schema, key, index, DecoderValue::Array64(value))?;
+                }
+            };
+        }
+        Ok(schema.finish())
+    }
+}
+
+/// This is defined per call.
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+pub(crate) enum UnknownKeyPolicy {
+    Ignore,
+    Error,
+}
+
+#[kunit_tests(nova_core_nvkv_decode)]
+mod tests {
+    use super::*;
+
+    use crate::gsp::nvkv::Encoder;
+
+    // Tests that basic decoding into a manually implemented `Schema` works correctly.
+    #[test]
+    fn decode_raw_schema() -> Result {
+        // Decodes an IMM32 pair and a SEQ64 pair (the encoder emits a u64 as a single-element
+        // SEQ64) with a hand written `Schema`. Keys and value constants chosen to distinguish e.g.
+        // saving the wrong value to the wrong location.
+        const SCALAR32_KEY: KeyId = 0x1001;
+        const SCALAR64_KEY: KeyId = 0x1002;
+        const UNKNOWN_KEY: KeyId = 0x2001;
+
+        const SCALAR32_VALUE: u32 = 0x1111_2222;
+        const SCALAR64_VALUE: u64 = 0x3333_4444_5555_6666;
+
+        // The output type of the hand written Schema. In this case, we can have it also implement
+        // `Schema` on itself rather than having a separate carrier type, since the `Schema`
+        // implementation is completely stateless.
+        #[derive(Default)]
+        struct RawSchema {
+            scalar32: u32,
+            scalar64: u64,
+        }
+
+        impl Schema for RawSchema {
+            type Target = Self;
+
+            fn visit(&mut self, key: KeyId, index: Index, value: DecoderValue<'_>) -> Result<bool> {
+                if index != Index::new::<0>() {
+                    return Err(EINVAL);
+                }
+                match key {
+                    SCALAR32_KEY => self.scalar32 = value.try_into()?,
+                    SCALAR64_KEY => self.scalar64 = value.try_into()?,
+                    _ => return Ok(false),
+                }
+                Ok(true)
+            }
+
+            fn finish(self) -> impl Init<Self::Target, Error> {
+                Ok(self)
+            }
+        }
+
+        let mut encoder = Encoder::new();
+        encoder.encode_u32(SCALAR32_KEY, Index::new::<0>(), SCALAR32_VALUE)?;
+        encoder.encode_u64(SCALAR64_KEY, Index::new::<0>(), SCALAR64_VALUE)?;
+        let serialized = encoder.finish();
+
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Error);
+        let decoded = KBox::try_init(decoder.decode(RawSchema::default())?, GFP_KERNEL)?;
+
+        assert_eq!(decoded.scalar32, SCALAR32_VALUE);
+        assert_eq!(decoded.scalar64, SCALAR64_VALUE);
+
+        // An unknown key should fail with under `UnknownKeyPolicy::Error` and be skipped under
+        // `UnknownKeyPolicy::Ignore`.
+        let mut encoder = Encoder::new();
+        encoder.encode_u32(UNKNOWN_KEY, Index::new::<0>(), 1)?;
+
+        let serialized = encoder.finish();
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Error);
+        assert!(decoder.decode(RawSchema::default()).is_err());
+
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Ignore);
+        let decoded = KBox::try_init(decoder.decode(RawSchema::default())?, GFP_KERNEL)?;
+        assert_eq!(decoded.scalar32, 0);
+
+        Ok(())
+    }
+}

-- 
2.55.0

