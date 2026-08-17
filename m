Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B29C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6231910E7CC;
	Mon, 17 Aug 2026 12:59:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DUefOhoQ";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D41410E7C5
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:59:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1/E+CoVVV+4vHavB7kSNjiX+VJqIzqamQrifRb1t4DhijAJ15VIX8MqpCXhDlobfl1bN+jW+Vy4IX+TnUgUYFYKwwkvLCZj6n5PN8MRNCpQ0QIOzshuqORme2r22wQQ7W+KIvRIp7rihpiq+KhidAmmdXX7c+eaddW8tpAkYoaJ2gNj+kObaKS7CpJSa256+BiNIm0AwwSaX/B5JIEHQ+zxszveZe8OIYlmWj9+yGen3/03UkNDOZgAy+RgH3WkAcesYW6J/erODULdhaCu9uDwf7MA0wMTX0VBorukFNCCDYhWjg5o/bOQOn1rsZcc2h5CvJfhvfaavKk93dw48w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dmgzgs//qoGkCsXTx8uYv+k2DmRFJqaBIKrbMYo4mg=;
 b=H71Xr+J00VeGzDydaNMQX2cgIlozgd3TQECHbqvf5j5ln5GJtHKNYj4PLa42FdhSamZ78RVAkT5t79y9itqHm8ZLGQLZ9tjSgxCcizwycWF1/JO7g8RITJYlgv5DPChO2Ro9sA9kxg+2ksQITrc9xpHnQKvrazXC1JJJ0w84bs8FLpY86t3MEKX0GbiK0xUKQH+ycOHSrJJg1VlMxmBkh2NNm5u3gtidyEO06pHWl+NlEgwUYyDqLwnKjhseHg8b+HjxycaPJBXMqJwrINL3J7aa0Ox+a1ICWMO8ZYFL9gHfLrDhCldTNhBp1xelp18+RGc96D6Vma1DIMrLMDbA9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dmgzgs//qoGkCsXTx8uYv+k2DmRFJqaBIKrbMYo4mg=;
 b=DUefOhoQXGBXNynTAqAfqxOG+bJDg4qaXZRdx4uAy4KkvxZIKv7FoZeIK4MTjbGZBitNMKwI+5tjbKaADj0eP2JO6QqNSLZ4nCoVWLf86wiFM0b5sHdVXV8IcU8T1P93D4JNwPVNcu6edF8P413b8b0rGIT04TzcfKyQmq3ivBEb8W9gpZOz4b9HPET8Y2TSrqkHrM9Os/rjxb6c3bpMdcGAKt/5EQ2ijQ//AS3GkowsVGrDP9apBUsqT5HG5Sq/r3K/Y/8A4eqr9QA0ng6IF85qEzT2erb17xMbVeteCsXCl1I8NaBwm+4y4zDSBXlvNQ0yuNLyPgEPbFiL3i9z0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH7PR12MB6833.namprd12.prod.outlook.com (2603:10b6:510:1af::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Mon, 17 Aug
 2026 12:59:11 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 12:59:11 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 17 Aug 2026 21:56:37 +0900
Subject: [PATCH 2/6] gpu: nova-core: add NVKV encoder
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-b4-nvkv-v1-2-b84db5e84b67@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0045.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::19) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH7PR12MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: ed692529-0cc3-4d4e-3a6e-08defc5f554e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|7416014|10070799003|18002099003|921020|22082099003|56012099006|10067099003|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: r07FUjZd5t3GLUIz/XBMif4NS04FA56L64nf9ML1+7Ef5auDm9RKY4rXO2XM9jrlyfLyWPHWyjhXHgz1YwpRUbR0uL77CKppntwbJYRs+/MIDOO4xxu43Fs9lKU9jbBSHZo7sIJEr3d4pTrYXCMeIaAKuRktCw71rZbtJQxCcNddWsDJMeC4wOt+0MfUQzi8MQsw+N/NqghhP4MPPCgcBnKzv/koXdfnfDTrpXrgReNg2sFyU4i3V5lK42HFZwte1q/M+JaX6TDjrVFmick8xmIhldESdyCY3OCm+Bf/RmCmDsY04Ha8SthUbZ4kzDHIHx/G6Schx0tG+qFqb5/X/TBu/UV57pArHplMO38evzNZQzoYhBY7rLtww+z3yKd2ETYk/67yq5Q6hGvdWWsAP07YgLlkW9acG1ZhicJnJ66CsQDkm9BlL/zrtc992uJS9jl3C/k22OetYonBfAHn8iHHbkDT+CNntKnQ5sLKjM9OGx022+Z93kJ2CE+hd3Dj9QsNfemZTXYYnQq+0a1ogqQxoMybzAEQodipN/c55tWO0CkCYwOdacOFqkV3fLX/JmC32hh9nOA8KXjNOy3hiUdITPap/4Je25ErJb6KVYU8fB3uao1d4btm5dp815CaZYAfLvNj8Qd95ssoLc8RHWkHh8M4SkOMXoyKRgdgKJ0I2/a1g2by876beuSswDORW/OjZ/JbvR2ECwRk/8YTcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(7416014)(10070799003)(18002099003)(921020)(22082099003)(56012099006)(10067099003)(11063799006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHhhTStpeFpseUZNcTkyYml2QUp3cnZ2NHlaeGJrNEZmMGRXc1lueFhvOUpP?=
 =?utf-8?B?V0FpRVNoYlVDV1VaKzFOMUtlRm1iMkFXaVdCR1JtNlJtVDhYNHRVL0c5MDNv?=
 =?utf-8?B?OEViZzgyQk81Y0JLQy9HMDZkZ1F5eW82cUxLdXRRQU5xenJtdWdTV0FwMHpj?=
 =?utf-8?B?a1JkamszS3FZcG41VHR1WFUycDl0R2U1QXNJaXBrR0lsZ2RCZW15eEhSdHh5?=
 =?utf-8?B?cTR0cDJ5aUFzR3Y5a3RLQm0yR0R5TlZBRmNvQW5NUkVPeXNQUWx3K0Nkb2xu?=
 =?utf-8?B?b1d5WEpyemEvaTJHNEp0Vmw1RlNHRit0S1kyRzRVMHdmaXN5empaNXJNUXBB?=
 =?utf-8?B?blU3WDRoYmRWSzkvb1o3U2pkKzZ6cDlGV2VySW5mdHVmZlV2N3Mza0JWeGsx?=
 =?utf-8?B?d0dIczdwNnd5OEZtYUhPUTZLSDVKeERhb3dqRTVkK2lRZ0c3VXFScmRxNlpr?=
 =?utf-8?B?WGFvS2V4R2dSUk94MEgyVXd6Mi90TE5PUUR5Z3hqWVViS2pvMW8zbHNxV0tu?=
 =?utf-8?B?eVBSaC9qMzdVYlFSTlp2enNHSHVmUzhwaUpEQXFvUWN6U3A3RXV6L0ZRbmt4?=
 =?utf-8?B?YWl6QWhyTVdzdkhLNkkxQkl0QXBlSkNWcHhRaEpXVldBY1FYUkR4bXdkQ2tw?=
 =?utf-8?B?bG5xYXVtZnhjSExqVHlvN0hJSWZIbGxRL25kTmVSSWpTaDE4a3RBdEkwLzZi?=
 =?utf-8?B?T2pwamg0ZFIva3BBdUZLa0ZqMDZseVRoaGEwSk8rS2o3cjJRQ05jaFVQZXhV?=
 =?utf-8?B?NWhuN0JaK2ZEcUs3UUQvQzlWWFpuaFQ3amQ1K1plWmxtaytTT1p6b1JVdFhs?=
 =?utf-8?B?M1VPNXdlNS9BbE5IZ2tIYXJlbThydkNFeE1TYkY0NE1lR2JHN0lzazVEa29P?=
 =?utf-8?B?YUZyQ210ZXgxL01hMGYzRmFjL3NSNEhtbERGaEFCdVpRaU9Fc3lwUmFHdC9i?=
 =?utf-8?B?VllucVlhYVdEUmNEV0xXeXVmcXJ4OWpSQ2xET0RlVjBNOUcxZzBFOHR5emJJ?=
 =?utf-8?B?VTlFK2MwYytMNGZoT1k4cFplYXY5QXpmL3l4dG1ZcjlPZVFRUkgybjJtRjhK?=
 =?utf-8?B?K1BWak1tOG1WQy9jVURrUFBWZFF1aDh6ZytJU2RJOU5IMFQzNGZqbEF3clBK?=
 =?utf-8?B?M1lCM0NQVDRDVE1UOHJwMmdsZTc2TW92c1NvT2xmL0hiZ0FudDVqK3dUWklr?=
 =?utf-8?B?d3RNVXRab3AyaURFVDNINjdqbG5icjBJUWxUalgxZndnQ2NVaWM0WTh3Wkw1?=
 =?utf-8?B?Yk1qNEtLdThZQVBnWERiclF2TVZ6a095aGtzTkJHaGprRTlTREtMb0lXNmMr?=
 =?utf-8?B?QWxaVXZzR243NlNsOWhTZXVqalo3SmFmejlHaFovVUNWczBRMUpUMCt0cy9J?=
 =?utf-8?B?eEV4Z05CS0NmbzJ6d1Jyd2Z5ejA5N0hQTHFyOGNCUGhlUlJBNFpoRkFxbHVz?=
 =?utf-8?B?U2tGVUZwRUxHbXFjTXY2VWVkV1lqcFpMa3E1ZGRMeTFqYllwZDYzNWsvRXhm?=
 =?utf-8?B?eHV4SVF0ZUNwclYvYUhjdzRhbDczVkF2YWhHb3FtUjhINEZOdG5CMi9QRk5s?=
 =?utf-8?B?VnBRby9lRmdhRUZTKzNGdHZYTFlVVmVSUW1HTTJsZGhmUmI5Q0RXdTJCemVx?=
 =?utf-8?B?NXZicnNTRUpVazUzdlVKaE1OSjJpWjhYZ0cxZVpKaHQ1bUc1WHV2ZVo4ZEN5?=
 =?utf-8?B?SC9naXR4L25WTllONGRPQjhFeHJRRTJkVzh4SlN2bGt2MDZnSzhSN2FKTnRv?=
 =?utf-8?B?ckxPYTAyRzRaWjUvZEszd3ZTTG5aNTRjSy9Qd05pVVFrSXN4VWxoSWNlNVRK?=
 =?utf-8?B?aG1aSk5uQjdYNlloWFlRT3JVUURmTWxxdVlYbXFuSkRaL2lxWTZicnp0bHp2?=
 =?utf-8?B?RXZDdUZMNnpuSlhwd0NMSVBmNFZrc2ZFYndwa2RUQytkLytVVUlRNHV5N1Zx?=
 =?utf-8?B?aE4zMVJNcStWNHQ3Q0EvSjZXNTR2WS9tdXRyZlo2RDVvQjhsYkwxVTczOVdX?=
 =?utf-8?B?ZStkS3c5Nm1xb1BibmM4TjNzR2srTTlUUFFMQ3NBTTc4dDBvSVdkMkluS1d0?=
 =?utf-8?B?L281bllrR2I5ZVNlREtxNlRpVEEwdXhLNnJtYzNlaFVTdElIOWt2cXlHMlBL?=
 =?utf-8?B?U2hUWVhVYXM2S2dxaHFvVlE1YmN2bGUzdSthSGlWOGdTVms1OVNPSkk2aS9s?=
 =?utf-8?B?ZnZFUWhyVTRhY1JoKzBuMWN0ZnBHUzlXaytzWk1mZERRYVJ1TGZEM2Vkd0I1?=
 =?utf-8?B?cDlnb242YmorZ1h2bklqdVVaRkYzRWhiTG9NczhPQm9uTU16QmRJUWRPbDdk?=
 =?utf-8?B?TlVVUHhONnVaK3pHQ1BBT3FJYmRsS3BEU3RJM1NBbHI1SUhGbU40TmMvRXls?=
 =?utf-8?Q?9UmErxzx5gKhJxZD8GUvu8VdWH8cyJmmBKRxXGaniyoMG?=
X-MS-Exchange-AntiSpam-MessageData-1: GZ/4WeCelu5YXA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed692529-0cc3-4d4e-3a6e-08defc5f554e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 12:59:11.7480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCSiRropxhEVA2/9sEqVc/kkfFzVaL5gVobRgtlAaKhGuokZw/mAMxojyjZLllNMlCUskFUfVawf5k22Wvb2lg==
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
 drivers/gpu/nova-core/gsp/nvkv.rs        |  79 ++++++++++
 drivers/gpu/nova-core/gsp/nvkv/encode.rs | 245 +++++++++++++++++++++++++++++++
 3 files changed, 325 insertions(+)

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
index 000000000000..b908f66e760d
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/nvkv.rs
@@ -0,0 +1,79 @@
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
+use kernel::{
+    bitfield,
+    num::Bounded,
+    prelude::*, //
+};
+
+mod encode;
+pub(crate) use encode::*;
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
index 000000000000..6da81a371651
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/nvkv/encode.rs
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+#![cfg_attr(not(CONFIG_KUNIT), expect(dead_code))]
+
+use kernel::prelude::*;
+
+use super::{
+    Index,
+    KeyId,
+    Op,
+    Opcode, //
+};
+
+/// An encoder for an NVKV stream.
+pub(crate) struct Encoder {
+    backing: KVVec<u64>,
+}
+
+impl Encoder {
+    /// Creates an empty encoder.
+    pub(crate) fn new() -> Self {
+        Self {
+            backing: KVVec::new(),
+        }
+    }
+
+    /// Appends `bytes` to the stream, padded to a multiple of 8 bytes.
+    fn push_bytes_with_padding(&mut self, bytes: &[u8]) -> Result {
+        let num_entries = bytes.len().div_ceil(size_of::<u64>());
+        self.backing.reserve(num_entries, GFP_KERNEL)?;
+
+        let spare = self.backing.spare_capacity_mut();
+        let dst = spare.as_mut_ptr().cast::<u8>();
+
+        // SAFETY: At least `bytes.len()` bytes of space are guaranteed since `num_entries`
+        // worth of space was just reserved.
+        unsafe { core::ptr::copy_nonoverlapping(bytes.as_ptr(), dst, bytes.len()) };
+
+        let padding = num_entries * size_of::<u64>() - bytes.len();
+        if padding > 0 {
+            // SAFETY: At least `num_entries * size_of::<u64>()` bytes of space are guaranteed.
+            unsafe { core::ptr::write_bytes(dst.add(bytes.len()), 0, padding) };
+        }
+
+        // SAFETY: These bytes were just initialized and every bit pattern is valid for `u64`.
+        unsafe { self.backing.inc_len(num_entries) };
+
+        Ok(())
+    }
+
+    /// Returns the encoded data.
+    #[must_use = "encoded data must be consumed"]
+    pub(crate) fn finish(self) -> KVVec<u64> {
+        self.backing
+    }
+
+    #[inline(always)]
+    fn encode_op(&mut self, op: Op) -> Result {
+        self.backing.push(op.into_raw(), GFP_KERNEL)?;
+        Ok(())
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
+        )?;
+        Ok(())
+    }
+
+    /// Encodes a 64-bit value as a single-element SEQ64 pair.
+    #[inline(always)]
+    pub(crate) fn encode_u64(&mut self, key: KeyId, index: Index, value: u64) -> Result {
+        // TODO: Consider automatically merging sequential keys.
+        const KEY_COUNT: u32 = 1;
+        self.backing.reserve(2, GFP_KERNEL)?;
+        self.encode_op(
+            Op::zeroed()
+                .with_key(key)
+                .with_index(index)
+                .with_opcode(Opcode::Seq64)
+                .with_value(KEY_COUNT),
+        )?;
+        self.backing.push_within_capacity(value)?;
+        Ok(())
+    }
+
+    /// Encodes a byte array as an ARRAY8 pair, zero-padded to a multiple of 8 bytes.
+    #[inline(always)]
+    pub(crate) fn encode_array8(&mut self, key: KeyId, index: Index, array: &[u8]) -> Result {
+        let value_count = u32::try_from(array.len()).map_err(|_| EMSGSIZE)?;
+        let num_entries = array.len().div_ceil(size_of::<u64>());
+        self.backing.reserve(num_entries + 1, GFP_KERNEL)?;
+        self.encode_op(
+            Op::zeroed()
+                .with_key(key)
+                .with_index(index)
+                .with_opcode(Opcode::Array8)
+                .with_value(value_count),
+        )?;
+        self.push_bytes_with_padding(array.as_bytes())?;
+        Ok(())
+    }
+
+    /// Encodes a 32-bit array as an ARRAY32 pair, zero-padded to a multiple of 8 bytes.
+    #[inline(always)]
+    pub(crate) fn encode_array32(&mut self, key: KeyId, index: Index, array: &[u32]) -> Result {
+        let value_count = u32::try_from(array.len()).map_err(|_| EMSGSIZE)?;
+        let num_entries = array.len().div_ceil(2);
+        self.backing.reserve(num_entries + 1, GFP_KERNEL)?;
+        self.encode_op(
+            Op::zeroed()
+                .with_key(key)
+                .with_index(index)
+                .with_opcode(Opcode::Array32)
+                .with_value(value_count),
+        )?;
+        self.push_bytes_with_padding(array.as_bytes())?;
+        Ok(())
+    }
+
+    /// Encodes a 64-bit array as an ARRAY64 pair.
+    #[inline(always)]
+    pub(crate) fn encode_array64(&mut self, key: KeyId, index: Index, array: &[u64]) -> Result {
+        let value_count = u32::try_from(array.len()).map_err(|_| EMSGSIZE)?;
+        self.backing.reserve(array.len() + 1, GFP_KERNEL)?;
+        self.encode_op(
+            Op::zeroed()
+                .with_key(key)
+                .with_index(index)
+                .with_opcode(Opcode::Array64)
+                .with_value(value_count),
+        )?;
+        self.push_bytes_with_padding(array.as_bytes())?;
+        Ok(())
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

