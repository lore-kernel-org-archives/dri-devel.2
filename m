Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314C5CC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:54:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F7F3112550;
	Fri, 16 Oct 2026 01:54:46 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A407A112550
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 01:54:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L19Xz3qKMHA6StL4vKDbsZ8AjbQ3xfQaCBHV/3RmXzfz+/nx4r28sipBjcWZgIbnQ8EMoewAt6InIFw/RNISq1vUVxCqROzbUE+0FVn7+kSHTw/W5Ld1B6aWU/HkHsABBmKqW6TVH1HoiN8X2UXNM4Hxz02ixQm+LJaOMi9pBdidilgaxWavVfLMfjBkKMfwRjOLhxvCUievZYJCpCkpJzHKV7mplDmPzuaCwZk1yZzD3xJWkAlPLLks9CaCR0KtUY09Um90j2yXj5e/vuLJKi6yII2qpc/mD1GrOUa+jCa9tNJAkDYQJM9zf6+GHVIAc7W3lxu4mF7bf6YTYKF9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GptYfDxZ9tMN8CVvrC86Kjorz6cX6tLHe0XFbbx8xE=;
 b=pY5cc5CydMIOdvtXVcvpuiHI8j0xwWvGvjE7dQjXzDKhF2iVtB9PvHwSE5xu/XO5nTF4yuEWKxO14hAJrAfVhcl/ts5tvifB29Dm+9y23+d8rzHZOsAYPNgvvWsOZhEo0jjgSzBVIhpyeThy0Iya9shiMJCC9s3g3vfv6ckJysXQIIEkh5Kxz+gBfNt27Hl3DolaURepir2tChZ6qvf6ulQrDKubnAjfSc7Jtmj2zGupt1qyWO+a5lHlsecV7ba2rEpikK56tb8ii1kVq1UmDcvrmb7M+1+VOtfM5hqQcLCXIGWqxdCgCXHN9p9JNJx1vJcapGyYiyEiijYyfPlS7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GptYfDxZ9tMN8CVvrC86Kjorz6cX6tLHe0XFbbx8xE=;
 b=nRFcgJuTdb8EFPXxIlQphTu/7zhkNIn6H5Bkr4HkhUUrRVlPcov4sLIWWccixsmyp9d7N0Uo6RxEwm4ERJN6r5jrfawzv1QK19wrUA8i22IG0lAUASUnCEHS/0bQ+WlenT4I2yGKNLFOXmIG1Dqg2ENrmtkrW1E+Ga1k4c1lpkWwI6NepdAt0Xez70GybWprhm0wqMOJWNkdHZSsc4n097VXJ9H/fC6/MlVWurXN5ehhb5nPeH57WW8dPEBEf0kOo1KrjGxTkYo7ZXFiGkUprbbKRw76x/PWMU6+ncPZG3gTcbNN3ZxCIRkY+c1pyuUA8cvBgXoFbsVVVBQ0OV5R8w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA1PR12MB999230.namprd12.prod.outlook.com (2603:10b6:806:4de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 01:54:17 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0496.021; Fri, 16 Oct 2026
 01:54:17 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 16 Oct 2026 10:53:39 +0900
Subject: [PATCH v4 3/7] gpu: nova-core: add NVKV encoder
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-b4-nvkv-v4-3-e8b92b91aa5b@nvidia.com>
References: <20261016-b4-nvkv-v4-0-e8b92b91aa5b@nvidia.com>
In-Reply-To: <20261016-b4-nvkv-v4-0-e8b92b91aa5b@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0063.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::12) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA1PR12MB999230:EE_
X-MS-Office365-Filtering-Correlation-Id: ed47c79c-f5ad-4294-ea44-08df2b28636a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|23010399003|10070799003|366016|376014|6133799003|18002099003|10067099003|22082099003|3023799007|921020|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 5Bm8MXaNWIObOl0N1mqVMbsEZWRM/LR0V0b3xsvTb49iuXu5a42g1ZgNk00r4ruz0pQYNAbKYVOOUv4wrdUkMeyXTmjEoxi7esXH+lf900bI7GlhbwzhvJnPqPSu9+ScEmSJp/4pVBHLKBaSbvuY2kIGpbjTmiwL09f2HGaW1gDWOhlefgyl7qvk+V5i7m6si3ToQli+ezpDaiY4g7tLpTkEodMp99ECjsIyQs1473chk5/k1qxQDx2OEgYnKOD45nOOtTL5ohtXat3tjl5Io8J8zfGpAiAPbh5jFgsBEi9j8QqIJHsflZzKvGNsaWjMM/31JtI0v0SRxF94LxQ5dVEvxFFsaUNVCNYxz3qMG6Y/pIunu/m+y266bvvA3ss399vjULX+THXgaflLvGiGn4zjiWOuxqr4gKEMbrwR591v/o56vMiEigqgEm79bGZRVgKFF8STT7GhgAWOHz1EfsW4o8kUMnj+xn+YFwW5uLArRN5iuj4/Lg/196U7811bJ7IAlpuIb2PjD5JbP2YmvsGKX8QCcjJBfjv7893JPtqQ7/oCMPctvJcGRT1LxlXadIvZpJ0U/tMIBKWJSpmYlxkFdW9FT2S1SIQx0dz6Bb6dHedO8yXrPaiGvk6V1AoW/39dipCVUsT+SGbZ6OlNW/6jLDPVz4s9UkO/P0fXRCRvq0ZV/yJ5+ns4Qa1WKkMNxVkdtVGxFHQ9RlmUDoTtcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(23010399003)(10070799003)(366016)(376014)(6133799003)(18002099003)(10067099003)(22082099003)(3023799007)(921020)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmVLNlI0OG9FTkhucW11dVNiNW5qaFByVXZjbXhaQnRwNkg2Y3FtbEJDLzBC?=
 =?utf-8?B?R3NWaXhLVDBOdGNFdk9jdWhHYnNwTDVYRVU4dGpSY1o3a2dmclpoTEFsMkd4?=
 =?utf-8?B?VEZRdWpJZmFrTHYzcGhOUGV2L05Cajg4eThSNTFrazNNRXVLempEakd0VnJx?=
 =?utf-8?B?TlFJVVFOYVB4WUNZNVZ5dnl0ditPOGNZK05uWDViMWtzVkY5d1hjMnkvUkVl?=
 =?utf-8?B?RTE4SUtCRVJWVnM1Nnc5N1pKeHNXeFo5SDJvTW5HUWg2aE5lYjlJT3d4YWlH?=
 =?utf-8?B?dVo3TERCMjlVR2piM0tFM2dxd0l3RGdHUnk1WUhlT3lCQ2JwRXlnNmxVTTNm?=
 =?utf-8?B?QWRKaVhuWEd6eXRDNnBlWUd5WDFWWTFqNGRzbmlqRXlLNngya2YwQmdRYmpB?=
 =?utf-8?B?WFJWZ2pYUzZsdkZvMENUOW9sT3l0K3VuYUUzSC9VWEVMTm5rMFJSK1hwZ21t?=
 =?utf-8?B?RnJSM1RVY2cxR21USzV2MDlKQW9PNHFHdWdFRUNJcHZMNXlWUVg1UzhENTBR?=
 =?utf-8?B?TktLU25vb2xXY2paR3hvL1BTTHBCTm0vcHAvalNBeHlqY0ttdFEwdEVzblly?=
 =?utf-8?B?T0g3QXRkVzZmb3VsQVVhWW1BZnNzVlVoTjNGdUowM1NZNlpLaGxYYVd2WDky?=
 =?utf-8?B?TXFNQ0ZKT2FZYndWZXZabmtXaUI1ZXVwMW9nYnVueE9EWE9yOUZMYmZmMHVY?=
 =?utf-8?B?dEFnUHRVUU5NZ05ROE14aXg3VGwrM0FML1lucitmL0d6VURBL2NPQjl1eE9Q?=
 =?utf-8?B?bXBnQzBzUzgrTW1aT1VVcjFnRjRBellMelMzN1QvZTVVVHhkTnZmZXBKL2t2?=
 =?utf-8?B?czdxeUQ1Y09KVnVCbDBMaTd1cUNyWVJVMEtHdzI4SnQwNEZHa0xBL04zRGJ0?=
 =?utf-8?B?LzZlaFZ5UFVWR3FGb1FqR3FiTXhnR0Jiai9XZnhiWUtoLzdqUGM1bDUwNEN2?=
 =?utf-8?B?T3pzcmt3c3FIOVRib3FNY1lBRlRDTTltK1BwUVVWdEFmVk5mYzZmREZyaVVP?=
 =?utf-8?B?c3h0T3JJNytrQ3ZtK1BiaEU3eFUvaU5rN051MXV2OWduNlRxbVBBVVAyMzhD?=
 =?utf-8?B?eFlGQmNINVo1b3diSmd5dXFHNUtYNnd5NlhvV1Y5eXVJQ25FY0hLaEUvL1Jo?=
 =?utf-8?B?TDdXOUxCem80dnVxYzBGWktPaFY3a2NicmVWOG1DQm8rU2k0NEpQZm8yMDJD?=
 =?utf-8?B?cmFWYjRUbXU0S0huc1BQTnhRcnVTWUFYWVAzaUF6c1dWVnVKczJuVFpGNys5?=
 =?utf-8?B?OWk4Ris3SzJtMXhJMXFQWXdzMjhLY2FVdWc4d1RlRTRvS1JTTGp3SFVFU2E1?=
 =?utf-8?B?Zk9GUkgzczJ2NGVDeDZrUmMxZG1QRTJSdm91TmVNQ1Y1QTRjREU0MituNmdH?=
 =?utf-8?B?N0pvcktzcUp1azJZZXBJb2gwWm8vQ1ZGd3BGM0x2YkYvMmE5UmhVeExDNnF1?=
 =?utf-8?B?THdPVmx1Uno4LzhjK2FQcFlaTUVOVktJQmdaVXV2enp0VXQ2aGMyNjRMTjIz?=
 =?utf-8?B?YWNLVFZ2NXo0Sy91c0hQT2E0c01XTFl5QnhCQUtlZG95Zks4MjZlTlc5Z0dD?=
 =?utf-8?B?dUIrei9RSTFaV3JVNDVOQ2haTUEyVHNabkNLZS95amcrZEtVbDJxdmxZcXdD?=
 =?utf-8?B?Qi96UXZhU2p2UkRMQW4wRGhESjVsZk9Zei9pSm9GcnlxV3IrQUpRTEp6ZjI0?=
 =?utf-8?B?a1hNMlEwSWZhWStYMGw2OG5QR2JxNDhORjBDS0cyQms5cEQ5SHdhcEpwQTVB?=
 =?utf-8?B?NGZ6dk5rWE1rRFRERWVaTGNPdm1WbGxWQXc5OU1ERGlnazFDRUl6c3M2dEZi?=
 =?utf-8?B?alFadURDbUZMenZ1MCtVT2E4WExxNVo4WXIxbVZwQ2crM1RoRzVjZTVXZDAx?=
 =?utf-8?B?ZEdkbDFGNkNCVTdvWjN2TDRiRUZpZUtNdDdDdDgwa1ZyTFlsVXRnV3BEVzdR?=
 =?utf-8?B?QW1IT0twV3dudVRkL1NQQlJlcnF2VWhoZmwwZ01nd1dOajQyUzhKdEtKMHYw?=
 =?utf-8?B?ZkdidE1IUVBrM0QzbENVMHFkalRRRW5ISENERmdwUi9kcWlRRDMvQUtWZFI2?=
 =?utf-8?B?ak9ORkJFejU2S3lJMVc0ZWw5dTA2U2pQZG1LVWN3UG0wVHl3UUtTd2ZWeklT?=
 =?utf-8?B?ZWhEK0VrZDRoL0hpRUZHYjZ6TzFiMlprbXpHUEZpM2JRVXQyWHdWbTNkRXh1?=
 =?utf-8?B?SGJ2N1hoMUJjL1duSy8yQ25OZElXeTJmaHVqcSszZ2t1aG1HUmRwSHMzZG9Z?=
 =?utf-8?B?YzQySWUxR0hONUxXaUVYNzEvVEhXRFBuSnVqU3l2dlo3NWxlS3MwN1V1Wm8w?=
 =?utf-8?B?ZjhjRFVhYlFOcDJXZ1dnTVU2WHlpeXFyelNvOUlzME1xR2NFUXNZUVhMUmV2?=
 =?utf-8?Q?UDvyz2bVEP8UXm5HFZmhWmj/q6aZE7mQMKMGlxDLhOwXl?=
X-MS-Exchange-AntiSpam-MessageData-1: qxTjaxS9lqXasA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed47c79c-f5ad-4294-ea44-08df2b28636a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 01:54:17.7770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozdcMraOO5qicYoc41VyIvxuPxmfiz3pvCyiw8hP/u2iiZ+8lXw5fsY0Uv9mb8rFQJtZxQgr8PgSiYiH5XQIQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999230
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
 drivers/gpu/nova-core/gsp/nvkv/encode.rs | 204 +++++++++++++++++++++++++++++++
 3 files changed, 327 insertions(+)

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index dda58095f40b..a4a6bf7e2df7 100644
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
index 000000000000..80936f7c53d0
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/nvkv.rs
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Codec for NVKV, the binary key-value format of GMCAPI.
+//!
+//! Essentially, the format encodes a sequence of calls to some function f(key, index, value),
+//! where value is a `[u8]`, `u32`, `u64`, `[u32]`, or a `[u64]`. The key is a `u16` and the index
+//! is a 12 bit integer. The interpretation of these function calls is per GMCAPI. Generally
+//! speaking, the function calls will map to some struct - for example, f(GPU_NAME_STRING_KEY, 0,
+//! b"some gpu") naturally maps to storing a &str with the GPU name.
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
+// The `Deref` to `&[u64]` relies on this alignment guarantee.
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
+        15:0 key => KeyId;
+        27:16 index => Index;
+        31:28 opcode ?=> Opcode;
+        63:32 value => u32;
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
index 000000000000..4585e4d5bcd5
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/nvkv/encode.rs
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+#![cfg_attr(not(CONFIG_KUNIT = "y"), expect(dead_code))]
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
+    fn encode_op(&mut self, op: Op) -> Result {
+        self.stream.push_u64(op.into_raw())
+    }
+
+    /// Encodes a 32-bit value as an IMM32 pair, with the value in the op word.
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
+                .with_value(1)
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
+                .with_value(3)
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
+                .with_value(2)
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
+                .with_value(2)
+                .into_raw()
+        );
+        assert_eq!(encoded[8], ARRAY64_VALUE[0]);
+        assert_eq!(encoded[9], ARRAY64_VALUE[1]);
+
+        Ok(())
+    }
+}

-- 
2.56.0

