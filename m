Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD1BC5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:58:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C110C10E883;
	Mon, 10 Aug 2026 13:58:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DteansIj";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010063.outbound.protection.outlook.com
 [40.93.198.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9968210E883
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 13:58:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ka8F+mj0Ai43U6Fk2QGQGo5Dko566jtQNx0lrk1KDlZpaEwPe05EeOPUJnVumlfhYzySYUTcxIGGYqel2EdtyIaXWf8HWlBWaAetlJGRLrF/V9M9mx/1TXPBs2uChB4YfT4/bWpoVKeqGiMsSMg1Tji8xkTxzpv6ns/Hi53BhblN8VpflTMFrAzw0B2dDTnG9KTdEukpNYaxMwHeWh6tqdO0HkXOLZ/7UcZYVAOfhc3OIbxF9gOztOdX3dhq7mq/NPkJf7Cb4KfNBF+z+8NUXn7plSIguQHT/fxLYNfzrbJsYCkbnHovNDgbnreRksPcuImVskqdWqGhWUBU59V/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqfgYyU/GpaAmC3423pZOAtihrlCVfpnwE+RCGpNNVA=;
 b=KGFbL7m4/8Pxwgydv98L4Gh+oGI+J7qyOZhFMEauxkTTbKXJXAsICDa2aKVfaHKlv28SDeIiJTUwv1eiEDKA4N8bKzAGxwpERW7ZxeiiAYxxqs6awledTgLXy+nZxAMX43MtdGQMIZEUZMWqlv48Vh2Ne7AW77JlzE7zD6eTP8SODy69zJ71nN64aUFRNkqXHh3YeLQQPTAkL7zRGHWtWHlvDU0FjhDGzlX+NG7jhOMfxXefdjd1+y1qcGwyA1O7RhuAmQNSHNR0Qwdu9leuezf3pBnv6oJthMfHPhxrdMu0WqcR2W3efzHZ/qvyt3hgi12sWWkmGKHwSsMQAMC/2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqfgYyU/GpaAmC3423pZOAtihrlCVfpnwE+RCGpNNVA=;
 b=DteansIj/IV3cPelVNdbz50mC2n0pFIAdFE6oYLrPjVbHMsmMqu1Cc80seLCi0fpwwwmBy6+D+Pa2htWIQEQFCGJuIA1ZZhiRt2aBWMiXJuRVw+Men7Kr+Y5HjzKNYRPU8DbRklkr8bJhwNCWV3KvY8+UWU8Jm557OdC0hQaYe+CmEBbJhiYuCyYkMlt2gJJs28Rh7UBR8IrbW4pVT3HpH+NsX7sriNkK0HLBXfI6d/88PTv0VLwHrxhGuHO2wgxacLURrz/Rmuxu4pn7KmDpTdtRcE4tRGWmOAxzWqXacVP1Gxf4jjfhSPobdj+GmTVMATRtET2xUR2wbPsSdJusA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:58:06 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 13:58:06 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 10 Aug 2026 22:55:29 +0900
Subject: [PATCH v2 07/12] gpu: nova-core: mm: Add the memory management HAL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-pramin-split-v2-7-65a00b3c7309@nvidia.com>
References: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
In-Reply-To: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0194.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::8) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: d22eb374-18a5-4501-450f-08def6e7670d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|10070799003|22082099003|18002099003|11063799006|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: ThsyqD/BJ5iDSjlwNAJEpBrQMe1YQoE8VLx9SvYMAY2E4kPsuN2zgx0jYSefsAUuls7xRwc3OLPzuuXwGMT6l4o8uALOBfhc1q1gbSE85dLXUJ8cHBkUK8UxOIz9ClPvjmygOry9uKyGGcXgCOO8/amICjqC8gIu2+30WesqbP86RHhDkGg6UJypg6Nd/GWmtRhDilZhdDYqdRegcMSWiFGZRFv4C1X/ke4KFM4MhKoUSA+c60HTareIqc/OXcS5fv5PCvXAKfC8umcvbihsGYdyw3BjBHYD1p7jMv7KmUCh9/AdzNrV0Bzi10sLnIdF9eolj1fp0XL3g24qiEF6/ZeYKIxI2dAdsgguf0XMiYI2XcmlbJBpV0tgFERQBRFcPK3zU4Zbn1LdUVydWq1Ne+TxRWUlgrv4+KHiu1KwDY0IUTJQ4GLTiNtZRbfIPeTcy3JdLd+DI/GpJ7F5zRpUz5y2w0BBlxv85e5chl4ns4DjZ25Wf1sXJXeODLTQjGILa0DyO36k7I+C3OWhkdTS4LUYvQLyTLOfC3QCUtasHt5l4sMULSARuXuvQKKPzYZHaB9h+gfHhTWeQYnH6KrB9tFzFxue7QUruAMj1PAvzQ0rEmfyRsAHRQ8xRkJi1ZI0fGttC4H4Gff/N4gMD9RDEO0IhD0eRp+yTlMBAL6Lat7S3qEOR8P0YqntrzgheiMX/pjoD7Sxe129d/8k5nD7MQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(10070799003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2VtRWFEQU9YdWdpVWxlcC8wTStxclRXMGFwcUZVSFVqU05mRnVkRlZwMmdn?=
 =?utf-8?B?NXhScTE1QlljK2hXaWd0U2l4cWJ3emVoUitETTNMT1ZxcW9lQm9mdnk4S1ds?=
 =?utf-8?B?Snc5anlkQ3A4ZGlRSGNMdnNBTUFkY1BZbllHV0diczlERnpOWVNPWGp0bHk2?=
 =?utf-8?B?QXduZ3NKMXVITmRUWmxwanhjRjdMNDFpL1poTTArUmtqeUhjV3BFK1VRYXA0?=
 =?utf-8?B?OWtoY0M2ZFZWaGtYZ0w3VHNFNGI4WHY1cVFwTk5hRzJwNm9lSW5MTTVVSGl1?=
 =?utf-8?B?UUlQcklBQldKQ2xscUkwbmhLMGUrbm9Cd3dPdFBaSkkxRU54dFdTeVc3bnN1?=
 =?utf-8?B?TGVpTFJPcXJ2VEUrTWV1aERYekxNSTZjR0pBWFVjT3lnS3cvZEJjdkpGQzhG?=
 =?utf-8?B?MEM2TnV1MytwYVBKM2hKT1ZpSDZQOW1Db0M5U0YydUZGYVNyS0pkSHNLMlRu?=
 =?utf-8?B?MXJyMFVwUzZXbTJYOVY2aHptcFhsdytYQ0pzTXJ1RnIxejRvRElNbHJ6MFhs?=
 =?utf-8?B?b0VyeFl1djZySS8rTnE5a1FUaTJpeU9GeGhONTNuZjVMRE1adVN3V1cyRnd0?=
 =?utf-8?B?U0R0RWRPcldORWRPelhGelhhcGw5OEkxbnBKWWkwb3hEODZoOGttSjMyV0V2?=
 =?utf-8?B?amtWd05JU2xhUGk3MzErRDdqNTdUVVQ2b1BrSGNoc3laZnYrMU1aYlNGd1BR?=
 =?utf-8?B?ZWgwdGx5Q05yUHE1VDExampRYVRKREJkQWplTS9ZMmZiRFIyUWpSdGlBQjNk?=
 =?utf-8?B?NEN4V0tMMGdCOTlkQ2xDd1dBNjJudVRIcElYYTg5Ym5RS3Bpa3JRV0xGcTdC?=
 =?utf-8?B?S1p4b3h2NkM2bHNpclU1UnpVWjRLSHllL3RuRk9oNUo0NEMyVTFjbkhjZFNG?=
 =?utf-8?B?OVlwOFNieHFRMjUwcjc4VXVZdWNPN0YwSlJ3eXI2bVJjVVdIWHRIa0hvNFhR?=
 =?utf-8?B?QVFwejhxYTZsQXk2SXhuNjMvVjI5cS84aHV5WERJTVFWUExsSEtIZ2VpdVls?=
 =?utf-8?B?UXFKUFVIRkpTUzk2QUhRaWtQOEVrSDN4YUlsU3FKL0JWbWlCWTdjNFdsME9F?=
 =?utf-8?B?cU9XUHN3bUVKWHlkMHRrVzB6RzkrbXFEdFZGNGd1a2d4Z3NXSDdoWm5WWG5F?=
 =?utf-8?B?ajZZclZnNnE0Qi9aeW8wL0lRZDFZMEJ6dXluaWt0ejBUWmZDd1ZDVWlQd1dR?=
 =?utf-8?B?WUlZNGxJallwb0ZIZ0hEYWdMa0IwV1dZR0pqVkFIeW55THRZUUVXc3Y0dGJR?=
 =?utf-8?B?U29YQloxNHVXd05RTDdvTmRZRVRZK2V6YkdKbGdoaStMdWh0T1V5dGJiaHFk?=
 =?utf-8?B?MjFpWVBVaDZVeXZEZzBYUlErM3BBTFpoMHphRWJhNFFocjdMd3lDVmpuWlZQ?=
 =?utf-8?B?TndWSmVQZTRpWXc2YXhqbk4vR2h0dXdFMHZFQ0pkeGdrTXdWdW8wV0tiMkZj?=
 =?utf-8?B?U2hLdTdlZ1R5b3Qxa3JhOWFKem1Sd3NqSDVmNllZaUllNHBTMkJkYWlod0RG?=
 =?utf-8?B?dUh4cmhaQTd2L3JFYmthbUcwWUdjQWYvTEJXNklLMWduTmdFdlQ2ZUppVDlC?=
 =?utf-8?B?ekNtd01SOEp4L083WmJEMzM4aUpHR3VJOWsxNXovdmIzTHpsRmZUbzlWblEr?=
 =?utf-8?B?aXgrUmxETVFUMFRuRzB6T0xYamxJZ003QkdqdnhxN05DZ3lPT0h1K21zOHo2?=
 =?utf-8?B?UzBwYnRPK09pdnhkSU1ZbWdER2RLWTZNbm1zUGNUWmFzQ09pMkRhNlBEZGVP?=
 =?utf-8?B?M2JhUEN1Z1VZYmhyQTgvNUczaE1MSFc3TXVVdkRZaVR5Z2hQRDZnU2FnNkZ1?=
 =?utf-8?B?RVI5VzhNRzJ1V0J3VXlQQ0s4VStyT1BjSVBrcE9Qc3Z3MUkxa3lhWGlEUnBW?=
 =?utf-8?B?aVhKMlRTZ1c4M2g4NERDa3c1Qmhpb0NRVkpXeDl2bzNCU1EwZGpXcnhEWHpT?=
 =?utf-8?B?enBvTUxRdWNySEEvMUY1SFVnUkMwZFlHdjB2SUR1clBWRmNrbVUvVzNQODU0?=
 =?utf-8?B?Vkc1R2FNSTRSZFE0dTl1ak9XNnRYcHpuNklLcERGN0MzVHYwMFBPRmZvM2w2?=
 =?utf-8?B?RGlTd0Y2OTIzODBkRHhISVcyUkxQVy9BVjRvVTFmZTB5Mkc1SnNzcDBydGx3?=
 =?utf-8?B?Yk9sYVFTWlJhSWF3WWxhS1cxM2RYSzFUVUVKNUNYOTl2YjZvcUVrZlRxSGhj?=
 =?utf-8?B?QU1lL2lSZk94MkYyZ0VKWkJ1UFJBa2NiNXNtdkFHTW1zdjY5Y09iZUJJTktB?=
 =?utf-8?B?ZUgrbXBMalBtZENtQStXM3grVXUvT0k1TUJ1WXE0cnlnV2plTVFmMS82bWwy?=
 =?utf-8?B?SVd5MG9HSnJKNnAzRkMzMkdMaXU2VC9oMlFlUUg5NXJCZnlORnQwcDVweHVp?=
 =?utf-8?Q?mDAW738NyOppipbFEZ6jwQmF+EJ8Vn8kSOl9cCI4O/r+Z?=
X-MS-Exchange-AntiSpam-MessageData-1: EQkJeerFBPC7uA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d22eb374-18a5-4501-450f-08def6e7670d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:58:06.3983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /q7Kg/Htgu543OHadhKT41jfuejcEJnF7vaxmggDf8e4P72xGjY8QFZPkF+ugbwcvXB1NJVHzOfS48YP8vPCPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8208
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

Positioning the PRAMIN window requires writing an architecture-specific
register: `NV_PBUS_BAR0_WINDOW` on Turing, Ampere and Ada, and
`NV_XAL_EP_BAR0_WINDOW` with a different field width on Hopper and on
Blackwell.

A `MmHal` trait with one implementation per hardware family hides the
register choice from the rest of the mm code, matching the layout of
the driver's other HALs.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs           |  1 +
 drivers/gpu/nova-core/mm/hal.rs       | 56 +++++++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/mm/hal/gb100.rs | 35 ++++++++++++++++++++++
 drivers/gpu/nova-core/mm/hal/gh100.rs | 35 ++++++++++++++++++++++
 drivers/gpu/nova-core/mm/hal/tu102.rs | 37 +++++++++++++++++++++++
 5 files changed, 164 insertions(+)

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 7d24ad790310..07dce4ce2473 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -19,6 +19,7 @@
     },
 };
 
+mod hal;
 mod regs;
 
 /// Physical VRAM address in GPU video memory.
diff --git a/drivers/gpu/nova-core/mm/hal.rs b/drivers/gpu/nova-core/mm/hal.rs
new file mode 100644
index 000000000000..e7fd1e38bd38
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/hal.rs
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Memory management HAL.
+
+use kernel::{
+    num::Bounded,
+    prelude::*, //
+};
+
+use crate::{
+    driver::Bar0,
+    gpu::{
+        Architecture,
+        Chipset, //
+    },
+    mm::VramAddress, //
+};
+
+mod gb100;
+mod gh100;
+mod tu102;
+
+/// Trait implemented by per-architecture MM HALs.
+///
+/// `Sync` is required so that the `&'static dyn MmHal` references can be stored in `Send`
+/// structures.
+pub(super) trait MmHal: Sync {
+    /// Positions the PRAMIN window at `base`.
+    ///
+    /// This fails if `base` is not aligned to the 64 KiB window alignment or is too large for
+    /// the receiving register.
+    fn write_pramin_window_base(&self, bar: Bar0<'_>, base: VramAddress) -> Result;
+}
+
+/// Returns the HAL corresponding to `chipset`.
+pub(super) fn mm_hal(chipset: Chipset) -> &'static dyn MmHal {
+    match chipset.arch() {
+        Architecture::Turing | Architecture::Ampere | Architecture::Ada => tu102::TU102_HAL,
+        Architecture::Hopper => gh100::GH100_HAL,
+        Architecture::BlackwellGB10x | Architecture::BlackwellGB20x => gb100::GB100_HAL,
+    }
+}
+
+/// Converts `base` into the value of the window-base register field.
+///
+/// Fails with [`EINVAL`] if `base` is not aligned to the window alignment required by the register
+/// field's shift, or if the shifted value does not fit within `RES` bits.
+fn window_base<const RES: u32>(base: VramAddress) -> Result<Bounded<u64, RES>> {
+    const WINDOW_BASE_SHIFT: u32 = 16;
+
+    Bounded::<u64, 64>::from(base.into_raw())
+        .shr_exact::<WINDOW_BASE_SHIFT, { 64 - WINDOW_BASE_SHIFT }>()
+        .and_then(Bounded::try_shrink)
+        .ok_or(EINVAL)
+}
diff --git a/drivers/gpu/nova-core/mm/hal/gb100.rs b/drivers/gpu/nova-core/mm/hal/gb100.rs
new file mode 100644
index 000000000000..3781e143dea7
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/hal/gb100.rs
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Blackwell GB10x/GB20x memory management HAL.
+
+use kernel::{
+    io::Io,
+    prelude::*, //
+};
+
+use crate::{
+    driver::Bar0,
+    mm::{
+        hal::{
+            window_base,
+            MmHal, //
+        },
+        regs,
+        VramAddress, //
+    },
+};
+
+struct Gb100;
+
+impl MmHal for Gb100 {
+    fn write_pramin_window_base(&self, bar: Bar0<'_>, base: VramAddress) -> Result {
+        bar.write_reg(
+            regs::gb100::NV_XAL_EP_BAR0_WINDOW::zeroed().with_base(window_base(base)?.cast()),
+        );
+        Ok(())
+    }
+}
+
+const GB100: Gb100 = Gb100;
+pub(super) const GB100_HAL: &dyn MmHal = &GB100;
diff --git a/drivers/gpu/nova-core/mm/hal/gh100.rs b/drivers/gpu/nova-core/mm/hal/gh100.rs
new file mode 100644
index 000000000000..8af384db2921
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/hal/gh100.rs
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Hopper memory management HAL.
+
+use kernel::{
+    io::Io,
+    prelude::*, //
+};
+
+use crate::{
+    driver::Bar0,
+    mm::{
+        hal::{
+            window_base,
+            MmHal, //
+        },
+        regs,
+        VramAddress, //
+    },
+};
+
+struct Gh100;
+
+impl MmHal for Gh100 {
+    fn write_pramin_window_base(&self, bar: Bar0<'_>, base: VramAddress) -> Result {
+        bar.write_reg(
+            regs::gh100::NV_XAL_EP_BAR0_WINDOW::zeroed().with_base(window_base(base)?.cast()),
+        );
+        Ok(())
+    }
+}
+
+const GH100: Gh100 = Gh100;
+pub(super) const GH100_HAL: &dyn MmHal = &GH100;
diff --git a/drivers/gpu/nova-core/mm/hal/tu102.rs b/drivers/gpu/nova-core/mm/hal/tu102.rs
new file mode 100644
index 000000000000..e4fe7561223c
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/hal/tu102.rs
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Turing, Ampere and Ada memory management HAL.
+
+use kernel::{
+    io::Io,
+    prelude::*, //
+};
+
+use crate::{
+    driver::Bar0,
+    mm::{
+        hal::{
+            window_base,
+            MmHal, //
+        },
+        regs,
+        VramAddress, //
+    },
+};
+
+struct Tu102;
+
+impl MmHal for Tu102 {
+    fn write_pramin_window_base(&self, bar: Bar0<'_>, base: VramAddress) -> Result {
+        bar.write_reg(
+            regs::NV_PBUS_BAR0_WINDOW::zeroed()
+                .with_target(regs::Bar0WindowTarget::VidMem)
+                .with_base(window_base(base)?.cast()),
+        );
+        Ok(())
+    }
+}
+
+const TU102: Tu102 = Tu102;
+pub(super) const TU102_HAL: &dyn MmHal = &TU102;

-- 
2.55.0

