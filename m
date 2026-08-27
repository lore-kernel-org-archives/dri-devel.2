Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3A2C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFAD310F091;
	Thu, 27 Aug 2026 14:23:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="RUV7WSvC";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012062.outbound.protection.outlook.com [40.107.209.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AB1110F094
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 14:23:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4xZE+I84aqHx+w3JARO1wj/CeFirgGr9uK5s0GEuK/hZYvjRS/BqbFhIsok5dZ2tKAfnGEvIaitb8Z5IyCQDDT3fa90gZVNjlrctiy0NL0xidnIjY3lkbDtAJU4RPKC/C2kgAcQxp/xxmGI2bKmk6RbRL9kpqj3FDHI5u3dT6i64YrCxR0g8am6pAYhSD+A16KMIsKLvuBs/OuI2bi0g1OhYY4NLuowNreufNCbjLL05p8gxOGJL5BTZWm5HJe+jhw/S0cwmswVsoFmzaGY4KCkRh/OG2U4GuVlzyr31fhoGKdAORS0HUBt6V5W7Gmam47MrxmFQmIT/H/IxW/meg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmxu7D8kQpavwpbhSPKQWnsdXUN85UFYNs4LJz6u/t0=;
 b=nhr6WE4dOtDrRDYn4pSsfVovD7bH++z/JkzyYsHA98yOXmbatKp2IQ05feJn/jK/4GeYGGYEDbXkEW0wI8sdo1rA6RzArJI7JfQCHvCN8Z+Zt8IfrJSazbOaefII1eK3Kp0y4C/f06ghJuLGQa0jiPuGB3akKXncha88NA1dTxo9hD528j3A7hetRbEjf/pEaFubvnvCRLEa7XahXdwoNaZNgvMzd6Tl6miyl65hSAD1NcnGieACuHOxioejte2dTWT2jTAK3XbEOfCB2nQzM6ueKVeSQbc8/ePLXWbB9CLRGk3oJftZ0lRmuzLpPQwEeFeifFGjpwWzv6BMUzaoVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmxu7D8kQpavwpbhSPKQWnsdXUN85UFYNs4LJz6u/t0=;
 b=RUV7WSvCDVRLrwTPO2SUnSJbxQjokElymCByFxfY+cAIjqrmflHQOxjsJtXJK76Sga1PdhOoD1sMm8p+6HyyzwIjmyS+YRD8Ex7ahPFLPRtp4UEznc3Te3bPYrnrlFi0XD8FGeOedpZ0RRGJVZ3o6HgKIpLL/5UbwrySWjygwQvHoE1Ie/51pGoUIawN+SZQsWbnRMA4nijjcS3CvelXxgAr2ZOLHpxBSWFi411WbbuwFc8xhHneQJBYAvpRc6uJszDi5aXa0Xtj2crjwIMfuax51/t3jdNpZvY5zDwD7YtcwovBqTpV99gGtYLxxEGxmPKdwM+1IbTk2K8fZXoWlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.10; Thu, 27 Aug 2026 14:23:05 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:23:05 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 23:12:54 +0900
Subject: [PATCH v2 5/8] gpu: nova-core: add NVKV decoder
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-b4-nvkv-v2-5-0de9d5c8658c@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0022.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::14) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 95d7b87c-cc2e-4c3e-a4af-08df0446b5ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|10070799003|1800799024|366016|18002099003|22082099003|3023799007|6133799003|5023799004|11063799006|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: hTtYZS9Er0/rmjg6fbaHiyD9MtEF9X0qmwe1FVgwgVLjxodjbJ1w4QC0dsOnoYAcFkeKzdyWLRNHmdx2kUYfd6Y1U+Iudsyzon4k+E8kwPeNbYuxm0kJ0b955mN7hMVee6p+sZU95uBvMkKRhXn+mO7k2Sik7tNMGhQi3l2Jp3+iSX2Xx4XHJ9uS8ockvddcRMCO9/mhy636h75KsUU1jSM+1x9xSjcmQsq9idh5X9SMA1uUuNNxoln0nUb85TKo9O19MgQelSwLixtVkI9ST0Yq58FF4NYgF+qQkKgCgvBpqAkG2g2SZ+J2eyz+dVeok3wS3CV7Wz1OF57ySS6elAgkfezyjuvWPi66hsJfXgTZ27V3qgVvTQxE8e1p83veBFAJCcJSjuwNiV214zNEdLQdHU7evMfHsdqHy6cjtAPvaRcsodIiC65kvoE54xAGiNOc802CxUSkDgwPyG5mZCHEZXuUoAt3w6g+JXupiht9+VwOzj9qPAfkU/rw5Tb+1mIBqSp1QnW30DJLxhNGzqBtFEHkY3YAPFXCd8ImeLae3+AEue3IMNlzmyggY5DQ8VMHsKf2YCkBaGxD3Ni20g2MVwQMGZtr/ScB1KJAwtA554SFVYRiZTN4CKEtwVmqUcENUIaWnZkj+AgOM/MYna/+d4kOquGAjKPSZjYnZLOXy4x2Of2MbeI1FoLDEHqhxhv+COx3iWK4tBnronD9XQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(10070799003)(1800799024)(366016)(18002099003)(22082099003)(3023799007)(6133799003)(5023799004)(11063799006)(56012099006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVhnSlhVV0JLT0VYUUtmdkJnYTNHV1NnbHNtSnZiYXVxL01ndFg1c1p5SUVI?=
 =?utf-8?B?ajgvWW80V1B3cXpqdXJRd2FyUVpvOUlFUm82cG9FU3JOZW5IcXRoV0hlM3FR?=
 =?utf-8?B?WDN4VjBLSkVCdVNtTmZydHd6VFJZL3hWV0drUjN1WnhSVzBWeWRhWTNRUVhV?=
 =?utf-8?B?NmJKSEkzdkhNSTRrZDR5NlE0SHNuRmcrUDFlWUUrSjJJajNqTlZ4VDM1b3NR?=
 =?utf-8?B?N1p5L2JlZHJNZEpObzBseEN5cERlUGYrdmYvWkgyMDFUYnM2Rll1aVFITGpN?=
 =?utf-8?B?VEYyb01MSU93MzBUUC9kRkJLSStQOXZEbitKWkdiQnpaWnhwRWt1UFNSa016?=
 =?utf-8?B?Z2QvOE0rTjFha3F1K3R4bG9tTThPTFEwRUVteGJYVU1rT2hQZy9zeFg2aFY4?=
 =?utf-8?B?MEdiTk16a3ZuY3hNS3k0THk2K1NTaS9wNHI0WjJvcXkySXJDZDR1SW56N2tw?=
 =?utf-8?B?U0RybmVaUnlkaGdLdTVZaUUrQ1FvMnNpVTA1aGJ3d3ZTQkxtbTB4MktnNGtq?=
 =?utf-8?B?emZRVEZKZmg0QngreldhejJmamIyb2RvdlVOc3NNai9jMHo4M21Zd3pWcDJu?=
 =?utf-8?B?S09zcEZlMU0xRlNjYlZtaG9IV2ZKaGxWelpHRFd5b0xoeXV2ZUQzTnNNcmtG?=
 =?utf-8?B?K3ZrNHg2ZzdPOTBxRnBKRmVqVVMzSUN0RjNmZHBFV2FNSVJWQzBSQkRWc0p6?=
 =?utf-8?B?VTRGZnFmK1Z3VU5EUXdEK3NnMWpiNzZBaGxwSHJSTU1FTnFLanMrR1lYNFlC?=
 =?utf-8?B?THVhdDhxTTN3bW44VHQ3cE8rcFBxYmlLd21jRFdiUXZqZlJHMGhEUzVid2FB?=
 =?utf-8?B?L2xIeFBSa2tLSmRYTnVXS3E0Wi9wQnNObENQV2t5ZUdYbXJReVJpV2t4ZVJG?=
 =?utf-8?B?Q1pzWnVIM0pEaUFWN2FKSS9zWERNV00rRU9Jc09qTXVOWGlXTlYzTFhLRm1s?=
 =?utf-8?B?NytUeHV5YWJZSzJ2WFB6NnMydFV3OFB6ZENpWTB3RVA3ZkI3aklkd0dwcjJZ?=
 =?utf-8?B?N2I2UkFBVzlNUmpmeUlKM3VUUXcyN2hvUkZjdVVYVWZKeEtXc05tT3ZIbWxy?=
 =?utf-8?B?SWU0cXNHcFprbGIyUW1kT1JkQ2Z3TWdtb3FrVW1DSUFGeDhleDI4MnpzVysw?=
 =?utf-8?B?amxMZGU2VXdjODA1TXhkU093RUlOb0dKNU8zVmhXY2ZhaFk3Q3dkanhVMm92?=
 =?utf-8?B?UDdRUy9SUStqRGhITjE5WFB4VWtkb0trMll0RTR2MVA0UFhSL0JEdjV3NHRt?=
 =?utf-8?B?T1VQR3dzZGdUeDNScHlZc2NjYlF1TGVDek9GMUNucFZuUlc4dXd6WU5FWS9I?=
 =?utf-8?B?S1I2U3NSSFZxcjNrVkxzSGZGUk55cmpYT1RNek9sb3ZVZEMyNnR6cmViTE9S?=
 =?utf-8?B?NUFEUzRYK1EwS2dlQit3Rm5raXJMS1lZdVZHRHJtbDZTQzNsZ0hpL0JZbzNK?=
 =?utf-8?B?aDA2SXp1bjBkZWpkUVo3SXQramFqV1VhdnZDZ3U1dFlnVVZKOFVwN09aZVA2?=
 =?utf-8?B?eFZmODJPZk9YNmw0b0VpZVRTWnRYbytFN0RoK1dWNUkxMUkvZ1l2Sm5BWGtG?=
 =?utf-8?B?VWlrSnV4UkhCWk16WXZIdHVPNTY3ekZFOWhLdGR3S0tVUC92ZUZPaHd4dkxW?=
 =?utf-8?B?NW5ueXF1SzYyeFhFTEtsMjQ2a0FWU1hDMEhTVTVBY1ZmWE1Ebk0vdEN0V3VV?=
 =?utf-8?B?NmlNdzBJOHBGU3VaTzFMYm1wZG02RVhIZDEvanNJMklwaHUxcHpjOHYydGt5?=
 =?utf-8?B?cmt3cUYxWVpPVDVIWUlwS3BkYmU4SXpkZUhrMEFZeGxPMEh0eXhDMHo2S1hM?=
 =?utf-8?B?WEpFckNqem9vNWtWQndkSnhhUlBDbEh5aGE4TkpzUXA5cVVkSXNHZVB0ck1C?=
 =?utf-8?B?Y1M4UWgzMXVjejRWVkYrZ2lsTnUreG1XRTFPRllmYWFUMmYwVXFyR0NMMHRv?=
 =?utf-8?B?Rm5hQTFUejRFb1lGVkZYMHk5RksxWktTbUlQMkZqVWg4WlkxMFkzUVRmbXRS?=
 =?utf-8?B?Wm9nSG5meDBicDNyU2Y4R1ZHNHJoMFRFWTBMZmx2bmxQdS94M1kwVzBEWjNr?=
 =?utf-8?B?ekJqYWpIR2M4cUZ0dGZWeTdKZzF5RTJBTFBWVVRFMlpJcm5tTHJXTW5SVGpD?=
 =?utf-8?B?S3h3UUdHRWJ3UzYxS1lpYldNOVdEeG1OWFcvNzV2aEJXeVZxNXdvSGkwTWht?=
 =?utf-8?B?YTdER1ZRKy8rY1ZwL2xtRHZnYU4vYmtsT25ZM1JScXhFQS91bmtibTQxZi9D?=
 =?utf-8?B?Z3dqK0FRckkzaGhMQWkxS1F0dDg1dkZEMGRqcFRaRWplaDFkV0JTNVdQckxt?=
 =?utf-8?B?Y3liMm1PZzdUMGxhVDFiUDlyRjNmaEhEVnk3RklFQmFoTC9CYk5NYjloUjJw?=
 =?utf-8?Q?wUa/rj6842JlQpeFC4s4roO4xhr+MNMbRSy0g1LhTWeKl?=
X-MS-Exchange-AntiSpam-MessageData-1: I3cu22TIn17sgg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d7b87c-cc2e-4c3e-a4af-08df0446b5ab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:23:05.4942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2eJeyG+aFIvR9jhUfohLF3da192ti7HpXuNrIcJlljwELCTwDwh9IQj3Wz0TjvW8fVx6XrfXBaEkWiqtBgSYbg==
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
 drivers/gpu/nova-core/gsp/nvkv/decode.rs | 265 +++++++++++++++++++++++++++++++
 2 files changed, 268 insertions(+)

diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gsp/nvkv.rs
index a8e16687a134..cbeee7f376b6 100644
--- a/drivers/gpu/nova-core/gsp/nvkv.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv.rs
@@ -27,6 +27,9 @@
 mod encode;
 pub(crate) use encode::*;
 
+mod decode;
+pub(crate) use decode::*;
+
 /// The allocator backing [`EncodedStream`].
 type StreamAllocator = KVmalloc;
 
diff --git a/drivers/gpu/nova-core/gsp/nvkv/decode.rs b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
new file mode 100644
index 000000000000..ceb97e73e100
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
@@ -0,0 +1,265 @@
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
+    ///
+    /// After the returned initializer runs, the schema should be empty again.
+    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_;
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
+        <[u32]>::ref_from_prefix_with_elems(values.as_bytes(), count)
+            .map(|(elems, _)| elems)
+            .map_err(|_| EINVAL)
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
+    pub(crate) fn decode<'s, S: Schema>(
+        &self,
+        schema: &'s mut S,
+    ) -> Result<impl Init<S::Target, Error> + 's> {
+        let mut cursor = Cursor::new(self.data);
+        while !cursor.is_empty() {
+            let op: Op = cursor.take_u64()?.into();
+
+            let key = op.key().into();
+            let index = op.index();
+            let op_value: u32 = op.value().into();
+            match op.opcode()? {
+                Opcode::Imm32 => {
+                    self.visit(schema, key, index, DecoderValue::Scalar32(op_value))?;
+                }
+                Opcode::Seq32 => {
+                    let values = cursor.take_u32s(num::u32_as_usize(op_value))?;
+                    for (i, &value) in values.iter().enumerate() {
+                        let key = Self::seq_key(key, i)?;
+                        self.visit(schema, key, index, DecoderValue::Scalar32(value))?;
+                    }
+                }
+                Opcode::Seq64 => {
+                    let values = cursor.take_u64s(num::u32_as_usize(op_value))?;
+                    for (i, &value) in values.iter().enumerate() {
+                        let key = Self::seq_key(key, i)?;
+                        self.visit(schema, key, index, DecoderValue::Scalar64(value))?;
+                    }
+                }
+                Opcode::Array8 => {
+                    let value = cursor.take_u8s(num::u32_as_usize(op_value))?;
+                    self.visit(schema, key, index, DecoderValue::Array8(value))?;
+                }
+                Opcode::Array32 => {
+                    let value = cursor.take_u32s(num::u32_as_usize(op_value))?;
+                    self.visit(schema, key, index, DecoderValue::Array32(value))?;
+                }
+                Opcode::Array64 => {
+                    let value = cursor.take_u64s(num::u32_as_usize(op_value))?;
+                    self.visit(schema, key, index, DecoderValue::Array64(value))?;
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
+            fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
+                Ok(core::mem::take(self))
+            }
+        }
+
+        let mut encoder = Encoder::new();
+        encoder.encode_u32(SCALAR32_KEY, Index::new::<0>(), SCALAR32_VALUE)?;
+        encoder.encode_u64(SCALAR64_KEY, Index::new::<0>(), SCALAR64_VALUE)?;
+        let serialized = encoder.finish();
+
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Error);
+        let mut schema = RawSchema::default();
+        let decoded = KBox::try_init(decoder.decode(&mut schema)?, GFP_KERNEL)?;
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
+        assert!(decoder.decode(&mut RawSchema::default()).is_err());
+
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Ignore);
+        let mut schema = RawSchema::default();
+        let decoded = KBox::try_init(decoder.decode(&mut schema)?, GFP_KERNEL)?;
+        assert_eq!(decoded.scalar32, 0);
+
+        Ok(())
+    }
+}

-- 
2.55.0

