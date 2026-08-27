Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC22C61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:23:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ABDE10F094;
	Thu, 27 Aug 2026 14:23:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="gf2nQRAS";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012062.outbound.protection.outlook.com [40.107.209.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95CC110F096
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 14:23:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXlOVtiZpr120fHvqFMCOLo9KZPNbE2y2K0NmZ79og5n0MauIGY/o7tEgWLOAj140FRL7zebZRGhX03rAJ1ZjY+yjp/gPGKzkDfGLRwYcAs6ZKuyqZaS5A2/dtG4uQImTezrBpxhy+p7alQUUoqVWgk/3/nsb5Meqo05uGbX/v0Eg4sCKfAp+HAjUmrZnX+Ivs/ZVQRtRZFWIBnCbLoJ7PUxmEMsg4OaAgfcojNx07wis1w8GwcAriedchc7s84+nlyQKpldzf8vnEAKAkJCW5s/3qdvJ4JpKZ7Hch6pfM/sYpBu/56Av8LPuEBN0XzGQ7/ZtNf2fra13N7P/2550Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZG3Aek4OeMBPrJoALjOWknMykq/G1v4c/nZG/KaiTo=;
 b=XRjG/Au/ofHsTdtx5vqDR3OIYx0E1MgYicm+DakN/fVY8k1DWjIf1n4kse1wRn0HAuxK8GgqSqvbOy7ApH56Us2wibMSRIvhQm67PR8o0lw+YKxEowSDYMPT3f+tZpB3REQaK+GPK1F7lx+puNNnRrScTm5DF81uiXlhRXSMSh8HMyG0IIo2N2uJE04QfOfgf8tmxKrnDrRHqgVOa1PES6xAJec8MKdQxY93/aPrfdo071I17tTt31hkgJUVfOu2n76k9FXlNpLGYDQoIXHpPgqZkpnINngmI8BWdAc7sTUYSqJr45LlZ96eSzm6YyLZJRsMG0rrjM0R+R0PLxSwZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZG3Aek4OeMBPrJoALjOWknMykq/G1v4c/nZG/KaiTo=;
 b=gf2nQRASln/4r2/4mGtegnMDrHCpCYEmStu1B5sAcnVWSeVYwu1r7Cvjb3ZkEAnC2dMfSEGS/cr4m3P5q474lKJ7NNiAnacCPzGJ658kuwrrvc82snBHA5QfekOBdd46Y2sfAs7N/m1Z6rQA1GMZBLrThzoYOYGh5YJwKFkfyLQtGtjwvRdPzGE0IUDauBe1a27L6pvCsB25JRiaZlor2tZYyWRbagqkCKlAszI6BFsOAEtcPL3ozdglQKNSFOdXx0A8MigiGRXxeLABR+DpQ4C2/8hyb8n5UD9Z0601AvUGnVcDY0NCmAMn5vfb/3+pd8pGDp1r62Twi67nZobtJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.10; Thu, 27 Aug 2026 14:23:02 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:23:02 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 23:12:53 +0900
Subject: [PATCH v2 4/8] gpu: nova-core: add NVKV encoder
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-b4-nvkv-v2-4-0de9d5c8658c@nvidia.com>
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
In-Reply-To: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
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
X-ClientProxiedBy: TYCP301CA0020.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::13) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 3083706c-9002-4b23-69c0-08df0446b3b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|10070799003|1800799024|366016|18002099003|22082099003|3023799007|6133799003|11063799006|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: qK0XnUzhNAOIL2nqOV49UBzdpsM2iGJxOVz5WbBclCzPTQKBeqgYZa4d3e3BbkxRBpfc0DDCDNP3tzazzGk5KOkHJmExL9csnMrO3djod1aP9bgYvG4Drp1KGcf8/znZtozf+tF7jTESeXNfuikLTsu94JQ0+hXU7m3Zx5aho+cmXaGHQFvj1eqIpCd6/op3K1T/lXt5lQMLbqMQxDB2M83Oyff5yx9Lj+ab6HNohPI1IJ6vt4Fs3xQ+vgDHQp0pe7AiZOnbAFX3HLoR0QMGVRw/61BfyoxRllE0dHTATcKF7bae5CrvusPdk49gyZTxQWQ/a3HE5QZ61qPmyF09xaUNYuvoazpS5+ozN6lVuTwKfi8nBW69/Kq0yd6s5XAT8pfWaUEIoKFA1kdvLZRO/1RIgjz4fQ8APJmu19P4O3XbQ/SpiyLCa9LTdx5071ZWnzVheSr8yy60BmMLgqWTVX3yXmiXVei4vt0Cb66KbEDhNCa0jT0AWoeXcTPQrkyryW53koVGpnMVPM4K4tYFtcm3DtLIFgD+PEPkyUEepMaXHb2eHsB+ayozA4nh9m9b7wk8sNmjvetIEIRbMKl/3RE+rXv4dwSyxjeYvpT2RY90DfPIsqgSOaiDLpaUqb2weY3V6/cL/GGRPYib9nZRZJwSHyRI1OE30tiASxhJtM6Dk/jZptr+v5MfSUoDQY0uqwV7IzUAhJseDl3KMSalyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(10070799003)(1800799024)(366016)(18002099003)(22082099003)(3023799007)(6133799003)(11063799006)(56012099006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmF4OWxvWFVQcStnYnEyLzFSMUtJbXhjeE1DU3NkWExDSDdTQWtPOFlJSlNP?=
 =?utf-8?B?SXg3K2dGenFMbmRmV0YyS1JlamEzL3p0c1NSd1c3bURibURYaFJ1VktHSXpl?=
 =?utf-8?B?NmxoaE15TEdUUjVncTRmZm9KRlZNY21zeEVoVEkvY3JCWFg1bzIzK2huV1lB?=
 =?utf-8?B?TzU0NTRmckpOSWdHdUVCa2pTV05TU2dDRFgvUHdPV2trRzIzRnFkVkQrNU5F?=
 =?utf-8?B?V1FXZkxod2o4NGs2VmFDUXZocE0zOFNFTG9HeVRxc1ZzMm9Od2txVkZJU2ZH?=
 =?utf-8?B?dVIvQU5scTNORWRZUlRpRUNDMVZHQnB5RlBMbEFBQXRwanh5TWkyMkFuaWNU?=
 =?utf-8?B?RjkvWVVPVFJMWXdDN0Yva2hBK2s0ZldFakVsRUx1ZkpUV2VDZWgrdXpsWUs0?=
 =?utf-8?B?RWpveHVjQnlTZnVDbWUxYUhiNUZTSlI4RFZDTlk5ajdLYVJ2YVVrRTZDeWJI?=
 =?utf-8?B?YWc4WkZ5UVlxUHlWRm53UHBNWXY4UnRhUGVkdXQvNUNqNDE4N29ieGMxWEJi?=
 =?utf-8?B?TlgvVVBIVUIwZys3ZnMzejMwQmdKcjRDc21lODBhSXg2cVlPeVRqdEpoNXp2?=
 =?utf-8?B?RytqemhIcWVpQXNwS0xtTEk0NVM2WUFPQnNLdGVudXFScDNXY2dFQzY5TkN5?=
 =?utf-8?B?UlRUNlZrRGViZ1B1OFd0T1Y1VGQvTmRsTS8zbUdCQmM2aFFHSEo2QjFiS3M0?=
 =?utf-8?B?TS8ySTZqeHMvWHJ6dDRiZXFNeXdRTis2amY5cTBYVC9SUHJWeXFuMTJNcU82?=
 =?utf-8?B?Q040UkZMTkp1M0Fta0M3Q1BoRk1zbjJIVXpkdlpaczI0SkprR3dSdjJHTFkw?=
 =?utf-8?B?Z0JtMzRNODdDcThwaXVlbkRtYmUrcDFhd0JYOFJvOWkvRTlVUmNWekdZb3U0?=
 =?utf-8?B?NEVzcGtNbDZkbGM1eGR4ck5MRVBDbDE5U3cyNU1oN3A3b2FCVy92cHd3YWFl?=
 =?utf-8?B?VnpLay94NStkRlBVYkhFeWRaMlBjNXNLaUt4bXhEQUhvMkVMTmRVRTVWTXgw?=
 =?utf-8?B?Vjg4T2s0VzFQeXM1bkRmalFpcVgvazdNL1dpbHVkZVlzWHh5VlpvUi9PNU11?=
 =?utf-8?B?bXA5SDZEMmEzY3FiRE02VUxvZVVmUDl3OVZtMzRleHlWQWI5ZXhST0kxSXps?=
 =?utf-8?B?RnZPUVJXYnI3c1RFNG9rc0sxaFdDZ1J0R3RFaG9LM1pkRFEvNFF3MjU3blF6?=
 =?utf-8?B?Ylc1cVFPRTQ0MzNMYVNOaHlxSHRTcXdnZEFtMEZJV2VxMEJzdGxVY2N0dVVK?=
 =?utf-8?B?bXYvNTl3WTc5WFB6Zk5uRzI1czBlMmRETjEwY2ZoWW42cUdFZ3dveER1VFJx?=
 =?utf-8?B?YUNhSjVsVmxQYUJGNnZ1REJNVW9raFBBNDRuNDdGN05naUkyME5saC9pTFJG?=
 =?utf-8?B?UEhrS3dDOWUyYU9oVGRFR3Jlb3lSVEhwTmxqZzhNVEhFZE41OUZ0V21UazhL?=
 =?utf-8?B?U0NWS2xYRUFnRlBWeG54Y0dXeWd4YTJPZWI1TTluTmV2S2ZRS3hmbkFpTkV0?=
 =?utf-8?B?Q1RjV3dTY0pxcGZOTFdTakdHNVFvR1VNdHpVSEdyVytXMjNYYzFRNXZCZXg5?=
 =?utf-8?B?dWplQ2RIYTFpWkhiOHRuY09hVXZFbGVSOVo5aVlFamtsbnhDbUtOdkt1ZE40?=
 =?utf-8?B?dUEyRm1WdmVqYTBJRTBaZHRvbXhLdzNtMWVzNVFzdGg0cXdaVU9QL1VyUHho?=
 =?utf-8?B?Sk4vckx1d0Y1N3lBNXdJNTVZbzVQd0FvS2NDWjJZWWd3eVNubnl4MkJxRzJn?=
 =?utf-8?B?cFp0eHRjd1B5RVZFaXV2enJXOXc0V3M5clIyQjR1eC9hdFBCYzJkRHJubTl0?=
 =?utf-8?B?U1U1WGU1Y0ZIempLM1FHQ2tORUdoMmV0U2xnaExVNmtqNTRwb0t3Ykw3M2hX?=
 =?utf-8?B?VlVOak1EZm11SUFQN2w1NUNVUXp1TkhUOUZhUG5rcmdEOGZuZWtVT3lNZmdr?=
 =?utf-8?B?NXV6dmthOFlwYnZHOURCbjZWNVp2cUdsdFF2M3o4QlVQMXpYNnVITVlSWmtB?=
 =?utf-8?B?T0l3WnA1Q01qMXQ3Z0FVejNrbEE4VG9Icy9rbkFjNk9RVXZBMCtpcEVHTGdI?=
 =?utf-8?B?NldJSjgwL0VhQVliTXBmL1V2ZWRBRHp1UTNyaHBCQTBBRmFLakhubHBIZklJ?=
 =?utf-8?B?aDRZTFFEUzdSN21Ta0taRjllb05DZWdSbVRReDNMN1dGMDZsZHFhRHJrNkV1?=
 =?utf-8?B?N2M4ZmFCSlhWQjd4T05aVkRxdVh6U04rWmtLdzhna0cxb2NCUVhmWGJTd2pz?=
 =?utf-8?B?ZGRDVm05cjFYRmJ5eDQzMHZKRTFNaktxbXFIOEdJVHdRVXFIalhUQzNQOUQr?=
 =?utf-8?B?dGczWk5hR2hyNTlOSmVEeVFobGozUnZOZVY4dXM3VlNQOGhPekUycVFFenor?=
 =?utf-8?Q?Ogl0gJ3BwPvmzc9YDefbPkzkFBLoWZQ0dcoqweX4W4Tnk?=
X-MS-Exchange-AntiSpam-MessageData-1: lg4KfVxLw1tR+g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3083706c-9002-4b23-69c0-08df0446b3b3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:23:02.0591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDkipz4npBNLYKtYlHafefA01pFcozjXAmN65m+naiIeaom2Kb69KnIRrQtw/kbo+r2nai27xtt6AykFx4V7MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930
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

Add an encoder for NVKV, which is the wire format for GMCAPI. The
encoded stream is a sequence of 64-bit values. The first 64-bit value
encodes an op word which describes the function of the next N values.

Essentially, the format encodes a sequence of calls to some function
f(key, index, value), where value is a [u8], u32, u64, [u32], or a
[u64]. The key is a u16 and the index is a 12 bit integer. The
interpretation of these function calls is per GMCAPI.

Add tests for the wire encoding for each primitive.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp.rs             |   1 +
 drivers/gpu/nova-core/gsp/nvkv.rs        | 142 +++++++++++++++++++++
 drivers/gpu/nova-core/gsp/nvkv/encode.rs | 210 +++++++++++++++++++++++++++++++
 3 files changed, 353 insertions(+)

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 13f361406a6c..84dfe07ae6ba 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -24,6 +24,7 @@
 pub(crate) mod cmdq;
 pub(crate) mod commands;
 mod fw;
+mod nvkv;
 mod regs;
 mod sequencer;
 
diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gsp/nvkv.rs
new file mode 100644
index 000000000000..a8e16687a134
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/nvkv.rs
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Codec for NVKV, the binary key-value format of GMCAPI.
+//!
+//! Essentially, the format encodes a sequence of calls to some function f(key, index, value),
+//! where value is a [u8], u32, u64, [u32], or a [u64]. The key is a u16 and the index is a 12 bit
+//! integer. The interpretation of these function calls is per GMCAPI. Generally speaking, the
+//! function calls will map to some struct - for example, f(GPU_NAME_STRING_KEY, 0, b"some gpu")
+//! naturally maps to storing a &str with the GPU name.
+
+#![expect(unused_imports)]
+
+use core::ops::Deref;
+
+use kernel::{
+    alloc::{
+        allocator::KVmalloc,
+        Allocator, //
+    },
+    bitfield,
+    num::Bounded,
+    prelude::*, //
+};
+use zerocopy::Immutable;
+
+mod encode;
+pub(crate) use encode::*;
+
+/// The allocator backing [`EncodedStream`].
+type StreamAllocator = KVmalloc;
+
+/// An encoded NVKV byte stream.
+///
+/// # Invariants
+///
+/// The byte length is always a multiple of `size_of::<u64>()`.
+pub(crate) struct EncodedStream(Vec<u8, StreamAllocator>);
+
+impl EncodedStream {
+    /// Creates an empty stream.
+    fn new() -> Self {
+        // INVARIANT: An empty stream's byte length is 0, a multiple of `size_of::<u64>()`.
+        Self(Vec::new())
+    }
+
+    /// Appends a single `u64` to the stream.
+    fn push_u64(&mut self, value: u64) -> Result {
+        // INVARIANT: Appending `size_of::<u64>()` bytes keeps the byte length a multiple of
+        // `size_of::<u64>()`.
+        Ok(self.0.extend_from_slice(&value.to_ne_bytes(), GFP_KERNEL)?)
+    }
+
+    /// Appends `data` as bytes to the stream, zero-padded to a `u64` boundary.
+    fn extend_with_padding<T: IntoBytes + Immutable + ?Sized>(&mut self, data: &T) -> Result {
+        let bytes = data.as_bytes();
+        let padded = bytes.len().next_multiple_of(size_of::<u64>());
+        // Reserve so that a failed allocation can't leave the invariant violated.
+        self.0.reserve(padded, GFP_KERNEL)?;
+        self.0.extend_from_slice(bytes, GFP_KERNEL)?;
+        // INVARIANT: The padding ensures the total length remains a multiple of
+        // `size_of::<u64>()`.
+        Ok(self.0.extend_with(padded - bytes.len(), 0u8, GFP_KERNEL)?)
+    }
+}
+
+// The Deref to &[u64] relies on this alignment guarantee.
+static_assert!(align_of::<u64>() <= StreamAllocator::MIN_ALIGN);
+
+impl Deref for EncodedStream {
+    type Target = [u64];
+
+    fn deref(&self) -> &Self::Target {
+        // An empty `Vec`'s pointer isn't necessarily aligned by `StreamAllocator::MIN_ALIGN`.
+        if self.0.is_empty() {
+            return &[];
+        }
+
+        // PANIC: By the type invariants the byte length is a multiple of `size_of::<u64>()`, and
+        // the backing buffer of a non-empty vector has at least `u64` alignment per
+        // `StreamAllocator`'s minimum alignment.
+        <[u64]>::ref_from_bytes(&self.0).expect("EncodedStream invariant violated")
+    }
+}
+
+/// The identifier of an NVKV key.
+pub(crate) type KeyId = u16;
+
+/// The index of an NVKV value.
+pub(crate) type Index = Bounded<u64, 12>;
+
+bitfield! {
+    /// The op word that starts each NVKV operation.
+    struct Op(u64) {
+        15:0 key;
+        27:16 index => Index;
+        31:28 opcode ?=> Opcode;
+        63:32 value;
+    }
+}
+
+/// Describes the format of the following NVKV operation.
+#[derive(Debug, Copy, Clone, PartialEq, Eq)]
+#[repr(u8)]
+enum Opcode {
+    /// A 32-bit value in the op word.
+    Imm32 = 0,
+    /// 32-bit values for consecutive keys, starting at the op word's key.
+    Seq32 = 1,
+    /// 64-bit values for consecutive keys, starting at the op word's key.
+    Seq64 = 2,
+    /// An array of bytes.
+    Array8 = 3,
+    /// An array of 32-bit elements.
+    Array32 = 4,
+    /// An array of 64-bit elements.
+    Array64 = 5,
+}
+
+// TODO[FPRI]: This is a temporary solution to be replaced with the corresponding derive macros once
+// they land.
+impl TryFrom<Bounded<u64, 4>> for Opcode {
+    type Error = Error;
+
+    fn try_from(value: Bounded<u64, 4>) -> Result<Self> {
+        match value.get() {
+            0 => Ok(Self::Imm32),
+            1 => Ok(Self::Seq32),
+            2 => Ok(Self::Seq64),
+            3 => Ok(Self::Array8),
+            4 => Ok(Self::Array32),
+            5 => Ok(Self::Array64),
+            _ => Err(EINVAL),
+        }
+    }
+}
+
+impl From<Opcode> for Bounded<u64, 4> {
+    fn from(value: Opcode) -> Self {
+        Bounded::from_expr(value as u64)
+    }
+}
diff --git a/drivers/gpu/nova-core/gsp/nvkv/encode.rs b/drivers/gpu/nova-core/gsp/nvkv/encode.rs
new file mode 100644
index 000000000000..6c1a9cbd90e8
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/nvkv/encode.rs
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+#![cfg_attr(not(CONFIG_KUNIT), expect(dead_code))]
+
+use kernel::prelude::*;
+
+use super::{
+    EncodedStream,
+    Index,
+    KeyId,
+    Op,
+    Opcode, //
+};
+
+/// An encoder for an NVKV stream.
+pub(crate) struct Encoder {
+    stream: EncodedStream,
+}
+
+impl Encoder {
+    /// Creates an empty encoder.
+    pub(crate) fn new() -> Self {
+        Self {
+            stream: EncodedStream::new(),
+        }
+    }
+
+    /// Returns the encoded data.
+    #[must_use = "encoded stream must be consumed"]
+    pub(crate) fn finish(self) -> EncodedStream {
+        self.stream
+    }
+
+    #[inline(always)]
+    fn encode_op(&mut self, op: Op) -> Result {
+        self.stream.push_u64(op.into_raw())
+    }
+
+    /// Encodes a 32-bit value as an IMM32 pair, with the value in the op word.
+    #[inline(always)]
+    pub(crate) fn encode_u32(&mut self, key: KeyId, index: Index, value: u32) -> Result {
+        // TODO: Consider automatically merging sequential keys.
+        self.encode_op(
+            Op::zeroed()
+                .with_key(key)
+                .with_index(index)
+                .with_opcode(Opcode::Imm32)
+                .with_value(value),
+        )
+    }
+
+    /// Encodes a 64-bit value as a single-element SEQ64 pair.
+    #[inline(always)]
+    pub(crate) fn encode_u64(&mut self, key: KeyId, index: Index, value: u64) -> Result {
+        // TODO: Consider automatically merging sequential keys.
+        const KEY_COUNT: u32 = 1;
+        self.encode_op(
+            Op::zeroed()
+                .with_key(key)
+                .with_index(index)
+                .with_opcode(Opcode::Seq64)
+                .with_value(KEY_COUNT),
+        )?;
+        self.stream.push_u64(value)
+    }
+
+    /// Encodes a byte array as an ARRAY8 pair, zero-padded to a multiple of 8 bytes.
+    #[inline(always)]
+    pub(crate) fn encode_array8(&mut self, key: KeyId, index: Index, array: &[u8]) -> Result {
+        let value_count = u32::try_from(array.len()).map_err(|_| EMSGSIZE)?;
+        self.encode_op(
+            Op::zeroed()
+                .with_key(key)
+                .with_index(index)
+                .with_opcode(Opcode::Array8)
+                .with_value(value_count),
+        )?;
+        self.stream.extend_with_padding(array)
+    }
+
+    /// Encodes a 32-bit array as an ARRAY32 pair, zero-padded to a multiple of 8 bytes.
+    #[inline(always)]
+    pub(crate) fn encode_array32(&mut self, key: KeyId, index: Index, array: &[u32]) -> Result {
+        let value_count = u32::try_from(array.len()).map_err(|_| EMSGSIZE)?;
+        self.encode_op(
+            Op::zeroed()
+                .with_key(key)
+                .with_index(index)
+                .with_opcode(Opcode::Array32)
+                .with_value(value_count),
+        )?;
+        self.stream.extend_with_padding(array)
+    }
+
+    /// Encodes a 64-bit array as an ARRAY64 pair.
+    #[inline(always)]
+    pub(crate) fn encode_array64(&mut self, key: KeyId, index: Index, array: &[u64]) -> Result {
+        let value_count = u32::try_from(array.len()).map_err(|_| EMSGSIZE)?;
+        self.encode_op(
+            Op::zeroed()
+                .with_key(key)
+                .with_index(index)
+                .with_opcode(Opcode::Array64)
+                .with_value(value_count),
+        )?;
+        self.stream.extend_with_padding(array)
+    }
+}
+
+#[kunit_tests(nova_core_nvkv_encode)]
+mod tests {
+    use super::*;
+
+    // Tests that each kind of value is encoded to NVKV wire format properly.
+    #[test]
+    fn encode_all_value_kinds() -> Result {
+        // All keys, indexes, and values are distinct but arbitrary values to make it easier for the
+        // test to catch bugs in the encoded output.
+        const U32_KEY: KeyId = 0x1001;
+        const U64_KEY: KeyId = 0x1002;
+        const ARRAY8_KEY: KeyId = 0x1003;
+        const ARRAY32_KEY: KeyId = 0x1004;
+        const ARRAY64_KEY: KeyId = 0x1005;
+
+        const U32_VALUE: u32 = 0x1111_2222;
+        const U64_VALUE: u64 = 0x3333_4444_5555_6666;
+        const ARRAY8_VALUE: &[u8] = &[0xaa, 0xbb, 0xcc];
+        const ARRAY32_VALUE: &[u32] = &[0xbbbb_cccc, 0xdddd_eeee];
+        const ARRAY64_VALUE: &[u64] = &[0x0123_4567_89ab_cdef, 0xfedc_ba98_7654_3210];
+
+        let mut encoder = Encoder::new();
+        encoder.encode_u32(U32_KEY, Index::new::<0>(), U32_VALUE)?;
+        encoder.encode_u64(U64_KEY, Index::new::<1>(), U64_VALUE)?;
+        encoder.encode_array8(ARRAY8_KEY, Index::new::<2>(), ARRAY8_VALUE)?;
+        encoder.encode_array32(ARRAY32_KEY, Index::new::<3>(), ARRAY32_VALUE)?;
+        encoder.encode_array64(ARRAY64_KEY, Index::new::<4>(), ARRAY64_VALUE)?;
+
+        let encoded = encoder.finish();
+        assert_eq!(encoded.len(), 10);
+
+        // IMM32 has its value in the op word.
+        assert_eq!(
+            encoded[0],
+            Op::zeroed()
+                .with_key(U32_KEY)
+                .with_index(Index::new::<0>())
+                .with_opcode(Opcode::Imm32)
+                .with_value(U32_VALUE)
+                .into_raw()
+        );
+
+        // The SEQ64 op word followed by the value.
+        assert_eq!(
+            encoded[1],
+            Op::zeroed()
+                .with_key(U64_KEY)
+                .with_index(Index::new::<1>())
+                .with_opcode(Opcode::Seq64)
+                .with_value(1u32)
+                .into_raw()
+        );
+        assert_eq!(encoded[2], U64_VALUE);
+
+        // The ARRAY8 op word has the byte count. The bytes follow, padded out to a whole word.
+        assert_eq!(
+            encoded[3],
+            Op::zeroed()
+                .with_key(ARRAY8_KEY)
+                .with_index(Index::new::<2>())
+                .with_opcode(Opcode::Array8)
+                .with_value(3u32)
+                .into_raw()
+        );
+        assert_eq!(
+            encoded[4],
+            u64::from_le_bytes([0xaa, 0xbb, 0xcc, 0, 0, 0, 0, 0])
+        );
+
+        // The ARRAY32 op word has the element count. The two elements follow in little endian.
+        assert_eq!(
+            encoded[5],
+            Op::zeroed()
+                .with_key(ARRAY32_KEY)
+                .with_index(Index::new::<3>())
+                .with_opcode(Opcode::Array32)
+                .with_value(2u32)
+                .into_raw()
+        );
+        assert_eq!(
+            encoded[6],
+            u64::from(ARRAY32_VALUE[1]) << 32 | u64::from(ARRAY32_VALUE[0])
+        );
+
+        // The ARRAY64 op word has the element count with the two elements after.
+        assert_eq!(
+            encoded[7],
+            Op::zeroed()
+                .with_key(ARRAY64_KEY)
+                .with_index(Index::new::<4>())
+                .with_opcode(Opcode::Array64)
+                .with_value(2u32)
+                .into_raw()
+        );
+        assert_eq!(encoded[8], ARRAY64_VALUE[0]);
+        assert_eq!(encoded[9], ARRAY64_VALUE[1]);
+
+        Ok(())
+    }
+}

-- 
2.55.0

