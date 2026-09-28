Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB87CA5FA1
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:44:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D43FF10E8B3;
	Mon, 28 Sep 2026 08:43:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="hyuMyI2t";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD2CC10E865
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:43:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcjpFjuk1heijbN4YPL440zABJWW+8fUib48hlozXuUEkEF/qrQ9/QcKqPYOlw03SMvZJ/3t26gCvSIq2ZSzKYide8cgDiQwqshiDuYMtyJhasrAyoYKx4J4rD7v9/heQ9JlnsNdC01PdSuzKxtOED5RDpGzYpwl4EjSgCjUdoCpXbz50dJkjfBZIHXVADMY/G1x5J65yafuXiLngc72vrMH2DhvJSpFc7XQyj1VT63wMGtND4nOau7C+LP+awA8lHPPmmpb0HhLl70zPwLx5sKv4qxD3Bu2if5azVLvTm09aHRh1Yxg5rE/jUaA9Bpf3HTLX0b4TY9eiP/ybt5RhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bQZ4Pl+C2/kVysjclV8MULoP6A6723vSBikcamVv9Y=;
 b=aPaYk8koj0EU89ju3BK0ma6Ffn8UiVJk9e3qRj/9D3aZ+TdZEFMFIDe5P9RUuSR7COVrKil9none+/v/zQQd21Ao3P0MWwTLMjZtq4cLOZBNLElKpdi42JvKChq8NU9+P1kdRKxwh0v4RvxFOG6ZftsnT1DrulJvOo7sVptf8TkFOOhq4o0zuF/iVaC7qtVkvK+eewY55BGEeBQ7dd075Hpi+T62FspRpxuGtOQvS+9e/pSAZis/ISiIFH6mEjz/vfEi3knDCS2ckzGjoysgNG2xw1HcLTlxUzhpwWw3S/lMyhhSK6kIEhUIkoCFE8R9Ie0boMMeZc+ygDOp7U0ZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bQZ4Pl+C2/kVysjclV8MULoP6A6723vSBikcamVv9Y=;
 b=hyuMyI2t8lAR7kdFMKs2/rw66/dtFW1XERs9byJ1ZqPm5oWUXhTNufeJ+Fy6+dDBZlOlXm2dL2cFfIwZwNJXLPIuRCckrX74oniFzkzJj4YW+QNjEs5EOWYKCNrr/xShH0OZqq2ozP+7dmiP7d8XBtiGGYFM6ArOL2DHJQbeJk0zFtrK/8/EFEFlYTlvYm0DEsiYnDSuxCX8gQ9yc+HtxB8HgO5jMGFcCGWVBh3ksMN1u5sYjnbuqAJ2BQqpmWyf8D5KsdX2YsyPv8jzXNFyH4WTytWM9A1AhEII8JR+8CfqTi+itz6Pg8/aMO4XxFhlcYP3gBTkNO3kgBHjfdjVqg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Mon, 28 Sep 2026 08:43:13 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 08:43:13 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 28 Sep 2026 17:42:43 +0900
Subject: [PATCH v3 4/8] gpu: nova-core: add NVKV encoder
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-b4-nvkv-v3-4-f04504c262c2@nvidia.com>
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
In-Reply-To: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
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
X-ClientProxiedBy: TY6P301CA0006.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::7) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CY8PR12MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: 0780275d-3497-469e-0dce-08df1d3c880e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|376014|1800799024|366016|10067099003|56012099006|11063799006|921020|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GJS9DGw/zhovl6BQhtcUwhM3qHVPTw3RKiuqKRGdN1aIuC+oqGPoK/NAk2IfKbGx5ExmrkWBZMp0Qbr5l4aI/a83lKo/RtOK4cxE+Th0zYAB3kvYvIc3wfgpemV3RD+UGsNdzbYUxWuLyC0ch4wJjfY8ops2G4OxJ3ji90l5Bp8ToZU7VbKVjUIIlnqKm+FneKvm6fVCGLH6WYB/yeS2JT9m8L2+txsX3imGHA830Eah6fgpsr2RODg16kqtfYXe5P0Ku4GWMLtCA57yPHMP+wyAA0wOyz26H4sqisjq5Drw8xvlDN3gNAFlVqVc7FK2D1hk3qS0fS22jDCibDsetKdolodhmjhLDeQrx0HT/v+Z1zfZJJzQ6o02Pt6xjSk/TY2F7WCG3JOog0aIOMv67udMmCPbtoUO2fheFPjHYL9vXnl+/ErFhxshnQ1oVgkpGQ3gSmbkJsNl5NIdyerqPqFB7cWXePuOPjXfA/qABpFzJVaOMgtOtfPcj7RmSVF3t1zkhqupNSzkXsAPmHcD48fNKP/0BVbyXaNvztdRDSIrmc1ByTlihyt3LMgTcHOYzrbmANjR2MIjMhpBAYl9O/22p/0vyrjF8dBdtnEMIaqMVJxKGxay1eQjXnWB4+JRbxNjy9BzkoVBA+RuwBcMlrrqHblFExS7tsAegQeoYwiX/YDbYfMSG2f7N6MSzud9IUFWAV3VpYarg0mSPyeUOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(921020)(3023799007)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ulpxa3pva0hWTHJwWHZzSUZLOVNCem9ha05PemhQdFFveml4STZQTzRGbkhC?=
 =?utf-8?B?MGx6ZElBYlQ5M0VGN1RKcVFWaGlOTmgrY1JPd1hXbDFIaVh4Nmg2K2lSU01r?=
 =?utf-8?B?SHNrWnB3ZldadGY0b3BheVBHMTZmVXFqK3F2NTN0ZFlrbGFFcXlIRnljbG8w?=
 =?utf-8?B?KzkvSTl6YndWOWJvSWpadDhJQi9sVnVIUGFxazFWK2dLWFNIclhQK1JUamRY?=
 =?utf-8?B?RUZVVzJNUnVJQXRuVXJ0OEd5MXlVeEwrZVlXdkFGWjNDK1NDMEYrV3NIY2lv?=
 =?utf-8?B?dVRSL1ZEY2hsUHpLa1JjTVhnOXZXTWVxRHNEaUI2MmhUeXBMM0tzK2c4WkM5?=
 =?utf-8?B?T3FnU3UrVnFiV0YxR3Z6Nk5DU0pleGJML29oY2VkcTQ0d3l2c09Pd25ZRkI3?=
 =?utf-8?B?OUY3VFNDV0J0UVd3TnlWTkFBd2l1WTNWMG51eUx6cVBDbkFQMENCK0JyYkVo?=
 =?utf-8?B?NGkxWi92WkpKdlM2Q1RFWWdTbTQvMU5reFZWZWYvNENjZ0ZQbFNGMFlMa1Jm?=
 =?utf-8?B?OVZHREtWZDNZY0RGTXE3Z3FnVXVBdXh3RHI0czJpWGJRcGY4cmlFa2Zma3Qz?=
 =?utf-8?B?NnV4a09BQ1JhRnhBZkxIMmtnZ2RudHFoeEhnVnlEdzh0M0NJYWU1VXg5ZllM?=
 =?utf-8?B?Y2Nic0ovcEtYa3IrN0R5b2xGYThkM01HVk1RNFFwdmNCVmVLZjVIUGV4YmNj?=
 =?utf-8?B?b05ETEpRWktLM0pEQU9PY3c1amRQa2ZpMUpMR29McHZlMnFyVXFPYnhLbW5B?=
 =?utf-8?B?OWhCSmdqbjY3OUE4QWpUcnJwTFRqRWo2MEZsUUtTdkpDU1hXU1N6eEpuY2Fl?=
 =?utf-8?B?OHUzQkZ3Qkl6ZlNPQ29CdVV3NW91YU15d0VIV2prU3lpMGxXOWpVamVWQkNT?=
 =?utf-8?B?WEJkL3JZWlJWWWJrTXlEcGkzYXBjRmVUSE1ldXFSbXRHUFA4d0U3TXNXdmQ4?=
 =?utf-8?B?TStZK0lRQTBMTDVVOUo1dU5YQkhqbS95K0dtY01ZelpLbyttcnUzSHptTEZx?=
 =?utf-8?B?cVpjSXlFOGhwOWtveTIvYVN1eWFXTkNNSlkydjB0S1pINjFXY1Vva25HQ283?=
 =?utf-8?B?S21BRXBHcS9keFFSTkZhWFpKdXBZdFpWL3h5eVJhZU90UmNZbU1QQ2FqaVhD?=
 =?utf-8?B?Z2gyRUxPMHE0OEd6ZDlPNjNkdm1uVXhKU29JSWY2UmdRUUt2MkF6bVBHZS8y?=
 =?utf-8?B?WkZKZUlRQVQ2MTVXRW5qQ2JzQitnWnhjZ2hjOEw0UGZKOHFiZ0E3YlNGbG1q?=
 =?utf-8?B?RlNpcjhkTFhNZTFrcXJnK2NiOGk2R0FGb0JRYUlzNm9CN1VUL1dhbEEydkVu?=
 =?utf-8?B?ZjY2bm5uVmpYdFhjZjBrazhneHZaRk9UblgzUFhrZTAyWHN6czIyUTR2bm4z?=
 =?utf-8?B?dk1VajJuUDE0RXllQmN2VkNQNDU0bGRZUVA1dytzR25hZk1XaWE5RWFrMFB3?=
 =?utf-8?B?aHhoVjkyK3A4K3p4NUNDakg5MDdBTHpPTXlVUTkxNm1PbWlTSVFNemRueFFk?=
 =?utf-8?B?NkNqdUtkaUE5K29MS3NCUkRrTVpUMzM4YUpRTEMxZ0J5WkhabVM4eHVRTmFI?=
 =?utf-8?B?SGZzWEdkcC9zcnhPd3VGS2l1dFZDVzYyaE1NQ0hpK0JpOWR4QUtzcGxRQlV5?=
 =?utf-8?B?b25wYmxuSFBtUjFBWEE5RC9hV1kvdWJWRzRXWnp5YnY4OTB5aHMxa2I2Vmhs?=
 =?utf-8?B?UGVDUG1XbVZPUkU0eUptNnF0WFFWb1F4NlE3emdmRENwNTNqNmZ5cHpXQms5?=
 =?utf-8?B?eC9kUW8rN3ZJb1lxUCtNSXdXM3pCL2VFVFZneGlhM1psQlJIM3UrS0RiMncw?=
 =?utf-8?B?MWZ4VGhvWU5qeVVWbENoK2IwSzhsaS9mOGFLWDg1bmdlK0U3SDNkc2JSNWNJ?=
 =?utf-8?B?Z0t5aisrS1cvYUJpTjJ3dVQxK2lXb0drSlMrcVNVTGJmalV0ZldIMjI5UDRr?=
 =?utf-8?B?RGhmOTBNYmI0TjRFV3JxaDBRVmRsalplblBPYS8zT1lOakVKWFRjUHJSejZR?=
 =?utf-8?B?NE1IeFFiT2JGYXk4QWl6aWdVeWZJWVJRNzFmL25YSEhTejQzN1RUOEJQMW5U?=
 =?utf-8?B?MDhzcnBySWF6VUk3QloyWFRjbVZrUHJIRlJNM2R0Szl2dkE3OFkzYkxNSWtw?=
 =?utf-8?B?TFpaTEZUV3FibnhwcGI4WGZ1R0VOQmYvY3BydFBjcExuNGtYOTk0WjF2dndu?=
 =?utf-8?B?T01MY1ljeEZzR0ZLNHQzeWJoaUduVDY5dXF0bkpQR3hlb1ZmaXAxclFyaTZB?=
 =?utf-8?B?MHRaclptQ2QwdjVINy9aWXBGbTAvVGVWVDNPbTBkcHFjRGNjc1JIRmxnMVpa?=
 =?utf-8?B?Z1B2TXpKcGZjUUdBT2ZxcEJVVTFlQ2NOWTVjeXZjWXJ5V1FscDBIYm9VeWdQ?=
 =?utf-8?Q?tGwtJ6pHrYIYLnjrvWBi17IqEbtpdGhttRXr6yh7NmEXJ?=
X-MS-Exchange-AntiSpam-MessageData-1: j9fl+feSpfKNAA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0780275d-3497-469e-0dce-08df1d3c880e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 08:43:13.0092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KubIG4GOZPChFQbP8RnGk/Xlb/rvpb9D9U4uMw2gaJz/N+3sQ2u+L/jd51+STwKtUQguWNpchWXuN9iLJErCdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8065
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

Co-developed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp.rs             |   1 +
 drivers/gpu/nova-core/gsp/nvkv.rs        | 122 ++++++++++++++++++
 drivers/gpu/nova-core/gsp/nvkv/encode.rs | 210 +++++++++++++++++++++++++++++++
 3 files changed, 333 insertions(+)

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 25ea43f1cbe9..7b1bf74464e2 100644
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
index 000000000000..0957dce92f96
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/nvkv.rs
@@ -0,0 +1,122 @@
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
+use crate::bounded_enum;
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
+// The Deref to `&[u64]` relies on this alignment guarantee.
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
+bounded_enum! {
+    /// Describes the format of the following NVKV operation.
+    #[derive(Debug, Copy, Clone, PartialEq, Eq)]
+    #[repr(u8)]
+    enum Opcode with TryFrom<Bounded<u64, 4>> {
+        /// A 32-bit value in the op word.
+        Imm32 = 0,
+        /// 32-bit values for consecutive keys, starting at the op word's key.
+        Seq32 = 1,
+        /// 64-bit values for consecutive keys, starting at the op word's key.
+        Seq64 = 2,
+        /// An array of bytes.
+        Array8 = 3,
+        /// An array of 32-bit elements.
+        Array32 = 4,
+        /// An array of 64-bit elements.
+        Array64 = 5,
+    }
+}
diff --git a/drivers/gpu/nova-core/gsp/nvkv/encode.rs b/drivers/gpu/nova-core/gsp/nvkv/encode.rs
new file mode 100644
index 000000000000..8b66ddb15189
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
+    #[inline]
+    fn encode_op(&mut self, op: Op) -> Result {
+        self.stream.push_u64(op.into_raw())
+    }
+
+    /// Encodes a 32-bit value as an IMM32 pair, with the value in the op word.
+    #[inline]
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
+    #[inline]
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
+    #[inline]
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
+    #[inline]
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
+    #[inline]
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

