Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5384BCC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 614E3112563;
	Fri, 16 Oct 2026 01:54:59 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01F4B11254B
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 01:54:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3cN8L3VNaWb+PHvJP/qbeIqujm0UA4O5ubozf3PgYUv/PUH1LtuwKe8P0yapJWVWZU1LB8m2b+RDgHqqAZUIL7Vl2fihpRurSj7QAQc/V88VnFtiEp86juNCJ2fkeqCgdl7+8pDFk2Ejsk6+LxxdVvaVNOjqtEcAqdVIW8eusbb0UZwAkqn3eCinnSHCquvjBhZzmhWHdQR4XV8tM+do4c48wUiPazK1q17xzU3xzsUUE9v00ZsEonIKop1z8syfNLJpmm4d5PMbiZIbZD3jve2HZPC78Ho9I5JizkPpIYuCyWOXbPg7sahns9KR8kitHpeFkL49+XaINYN0+MrYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqv+Z2Z8/kMBQUytSPKQW4JtbQBqmroV2bxJTsl5E1U=;
 b=lP0RH0hxq5u0HNnFOEw1/WRAa+HXdfBw7UtRAfyrubA/mBbRNUsQD88moZcdWdo8lmvs+RqYe4VJfXQcAfar7EmIEUMwJwejpsafXZ/hvE1zysaI8QDlaRvawrN/sgWFRQMparwiqsEhkwu1bodD69yfasn5FdEE0j/XY+fsVQQhg6zxSjGbHA2TPWf6CSLBTZm9g2D+nIfvgtc+weycTJeR0QvXAo95JqWkA4ZyHkBxyVsRBASgKHfQ1Gru2f9Ww303PP2LWRRzdufo5Tm9wamoZBvkM7iBiyU92B6kvlLOeYtwgEiMqu/43VrhzlDCgn4ptyNG2hQmOIPE53vIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqv+Z2Z8/kMBQUytSPKQW4JtbQBqmroV2bxJTsl5E1U=;
 b=d9broD8zmcX12g/ojkLAbzzvCuE8yBwyzYOlLzuiGArMbQkJQQ+JH/QSN5zOuvjjSQDPps6IbaGBDa9z1d6t+1oIHybnXnUrkjJlQ1W0ugxNMPmN4goq52IgYtsOH2NovaGdwE+gbnLDCiyN8vlxNK/1GCx5Whz4KWMeC8MuHBu5ytjkej4fuiZ8cKNY3MqIYNVrILmFuMwELKsFELXegxRv+LPmeWJy79cjGgi1m924iMTneqJLKmNlS/Uvv3QEPCFETvkgh3Y56k5O6DsWrOBSk7FPA7pqWFXcVEOzBO6iZ7jXP6u4AgFPEXpf+Y/r0b2xt/M2+QAxcnePR795vQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA1PR12MB999230.namprd12.prod.outlook.com (2603:10b6:806:4de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 01:54:28 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0496.021; Fri, 16 Oct 2026
 01:54:28 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 16 Oct 2026 10:53:42 +0900
Subject: [PATCH v4 6/7] gpu: nova-core: add NVKV typed decoding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-b4-nvkv-v4-6-e8b92b91aa5b@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0319.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::18) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA1PR12MB999230:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eeb7e13-d4cc-4190-e662-08df2b286964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|23010399003|10070799003|366016|376014|10063799003|18002099003|10067099003|22082099003|3023799007|921020|261009223027099003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: wcwsTD+Q668pegVRRK2S1xKUnOvhQenAdb/2jUk2ih8R37nRd8paTusd3uBGt6EaAtv/760tDp8UqDZ0p0UgFcgJc8R38J0CXnTUib0j0lm65e+mS6NuHWbtxzu21oj0uwBnU6YSVPgiiimvCTqXi2Vx7ooTQM78auM06RAUA+XQQSEcQvL52yyJ6RTys9Qr4nfF4kz6WB8GUewnRQsrzOuY33kH4QxC+h9GD6zBNOLL7IKS95jG0figM+Co+P0oELln5OmR1AvkmZ3Q6ojvPcYq7TfDPAbOalFO3e7+BFxCQLhXzR449nIlfvOOZjHa3/i70IKI7Xe6/UHf7Y4xruv+bnacFDTjkKYsLQnC9U/9KYzuz9h8OpT7ownwbbaXo0mUkQejZVIuzc8S29TyaYUrOkT8le4HqvnyRK+Q13JXB6uRF5gfevullInpSkX2PdVsKTBKEfUfMgLBJqyrVg/5Z4Uwid/1Ib94BoYECaObNpt0y6mxnhlzo4sdN6NNPsjhgc2ptxVikZwHGCIx/fTYnnn69b/pj1K/VyeiEA0Wvizc6APoKGQUCd5JLQranhRHfyY5sJODm9mN1Jj1m1HIjsv+m7PaPfEav87OTiV/OWnIF6QHt+EIo7P18wpqNa5tty/EXFiNc4YuCI6oABzEKOdF9GzIksq7f3v9fAzYbPjnEn1T0yOg2Om24LIJtwHY+vZcZLzR6n4JM3yP+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(23010399003)(10070799003)(366016)(376014)(10063799003)(18002099003)(10067099003)(22082099003)(3023799007)(921020)(261009223027099003)(11063799006)(56012099006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b200WmdQa2tyUjc0SjRVZS9vc3pVOENSeEx1ODJ0NHN5dVArSkxsaTdLUDVQ?=
 =?utf-8?B?aTI0b1pIUTV4dEV0Tzk3MHJQZFZOMkozSnB4T2R3NFA1V2VEMG12Mk91Vk9w?=
 =?utf-8?B?dWRTSmhFbFBEbHVZSi9lYkl6ZGNteFQvV0Z4T01CQms4Z0JRM1owRHc1Tk52?=
 =?utf-8?B?SG5ZR2ZaVHY2Y1Vhbnd1R2JMSFFDcXFCcnN5NGxSWm1tWldnUkJCbWdFZ1Zn?=
 =?utf-8?B?WHUyUGhXSXZoQ0pqU3hpQ3oxRWNNeC85UUdhMnd3dXc2ZnE0d0lBaXZTZ1JC?=
 =?utf-8?B?RUdKc2hsdWlvN21yYnp2NVBwN0F3ekxINDNDQ2lYUWIrTkRNeTNvclBNaEZy?=
 =?utf-8?B?Rnh2TGtOR1BoejRWSjNKWHpSdHFoTEszQ0RyRVZKYWN0bEVOeGtQTnVvTHY3?=
 =?utf-8?B?elU2MVo2eFc0MkFkNHVSYlpYVW5lL1Z4cytiYlhvWTB0MDhJZk1CL0NIWXR0?=
 =?utf-8?B?bE1yTlJUYTk5TjVwNld5bERiQzI2OVdBL1ZwRFRLOWJYMUg1QjRxeVUrYTVB?=
 =?utf-8?B?K2FGamxmRnRRaGw1eTJrN3Y1TGNjVmNMOHRTQmF6NFNEbVVDSUJpUTlBalZG?=
 =?utf-8?B?S2NPa3Z0ZEZMcVBneVBOTHZzWVJ6eDc5MnpyV1lRakhWMjR3RzJiaDlJMGtY?=
 =?utf-8?B?ci9lVnhFRWJ2TGlCMUh4YWxXWFM5dUxJKzdMTWZVdE91RE51elF2VFRoQXM1?=
 =?utf-8?B?QWQ2ZFBDenhYMnNnRkY1NWxHY0ZUUHhvSVlVbFNKOEtrbDJNMjRseGdod0Zn?=
 =?utf-8?B?TVdKei83cU5NYVJSZDZMRzg5QW9ST2pBSnNFWHN4ZVpVOWtMZlMwVkhmZUhJ?=
 =?utf-8?B?bHRwMTdDc3B4b1NreG0wREJtU3VhVWJYbFNSV3hxN25zdDhJVFZXc3JrcHg5?=
 =?utf-8?B?S2JBUkRreHVXeTNDNkpSdzlMaXdZd1lzUUoyd2VYVUYwN3NvY2Z0YjhaODBo?=
 =?utf-8?B?TFNGbzdIQVJ0YXhraWhLN245NDhkQUlsMkVCSXRienV3U0xDSTJHVVZ1aTVX?=
 =?utf-8?B?ckhva3NXOS9GbmNwcUpsd0x5SEdQb0hWWmNuUEJUcUJWRDlBeDBsWmhSZUQr?=
 =?utf-8?B?VXNwdW8xVVQyYmVJMjBsN2lUNEVTYUhiVStibkdhNE1PNUdncHN4cGMxT2tj?=
 =?utf-8?B?ejdIT1FsYnFsZVAwRFE5N0lhSVRycUhGb01TVzlTQ3RPd1dLZHlyQ1pYTytU?=
 =?utf-8?B?c2hDRTFJaDNkVmp4N05FbURJZmU1U1V1VXFsaGl4OCtMM3c0eEFFL2g5UzRV?=
 =?utf-8?B?MFUxL2U3RzJVSmR0SlgxZEQxNnVXMVM2bTlEdldGcURDc2doTlZmSGNNWFZF?=
 =?utf-8?B?RTJkQWlHN0Rrb0k0MU9RcTNpSVgyNjdhUkFvL1NkeXZveXdZOTRRcncxdndh?=
 =?utf-8?B?bEpWL3dodUp5NVJmRmQ2NHplM1M3c29oWFlRWjlHWFQ4M0EwbFZEQUcwMU56?=
 =?utf-8?B?MWZPQ0psWGJlNS9ML2drYXBYbG1scUxONWlLdHhPQlIxeThQQkZtN2dTQy9h?=
 =?utf-8?B?d1NZNTAwOGxuaXNKdno1UVQvYXBjUnlYL0NrQW9lRWY2TmhZb1FKYXhGTzdW?=
 =?utf-8?B?ZVI3dEI3eExwOEpPa3NqU1Ftc25ra1BZRTNETXdrRWM0NGRmbFlRYVJuenlj?=
 =?utf-8?B?a2luK2svQmpleHVwa2cxdDBxQ3NYV0NGcGJYQjJwM2NJWTl3L1B0YVkzNUlP?=
 =?utf-8?B?Nk9GZHdSbVVTenhyU3dVbVRqMEhmd2l3a05STy9XdUpVN01VeEh3RWtGK1Ex?=
 =?utf-8?B?WHFrOU1nWkI1dlBMaEs1OUFvWTRMQ0FVRlM2WGRjb1NnWmtTR3R1bFBSbTdh?=
 =?utf-8?B?WTQrd2RFbXhPVkd0N0FtaStRTXpqRWVMSzk2ZklIdEVpTmJzaUQ2blEyK3l4?=
 =?utf-8?B?VTNvcUlISis5SEVmcS9zNzIvRHhFZ2hTWGMzZkdzRXVORWhaQjZRTDBBck91?=
 =?utf-8?B?YW5LOWxBT3ZPNDNkc2J4WkdYRDFGMGh3MkVyRzNRYUtISmVxYno5YjFya2NE?=
 =?utf-8?B?a0ZJb3pNSktxMG11K0NqYmxwNnZaZFFaeGo2TUJTVGNhWERYWHhIMTBDY3Ft?=
 =?utf-8?B?TlNvOVNac0dGWFQ1RTFuVmJ1MXFqWlBRdlFEOVJmM09HektibGRXOUgvY1M0?=
 =?utf-8?B?dEZoY292TG93ME5xK1prVGlXc1gxVzlMTkNibjdLa2hvbDVOZStQdDBGOENC?=
 =?utf-8?B?RW9YWlh1YUQ1T1BXcGkyZEdkV0gzMVFZNlFJQWZXNmpYbThZR3R6OHJEUDFR?=
 =?utf-8?B?VE5wbFNTMms4VWFqdEpuY2VGZm54U3RjdnR2YzBGQUoyLytkK1E4TVUveVNP?=
 =?utf-8?B?cEk3TFBBTkc5cXlqK1YvbDFZSjN1MTFHZ0w0L2RBeEtXVVRCUjlTVCtEb0pD?=
 =?utf-8?Q?wOqN6MmRVhKpGOACQZ6JqnQNcqYok52S3wSoamYlzNn+J?=
X-MS-Exchange-AntiSpam-MessageData-1: 9HxPKk/uWr5XEg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eeb7e13-d4cc-4190-e662-08df2b286964
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 01:54:27.9368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5JgVT/KyxMU6WCRjnp1l2Qfv+5QwfOv/C3DdDvb6SBq/s6wv3XxzWEAp15bbvwHy/xCOMLlu/MJ98+fGBE4NQ==
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

Similar to the typed encoding layer, add some decoding type machinery.
Add a simple macro `nvkv_decode!` which implements `Schema` for a struct
by composing visit calls to each member. Add some common `Schema` kinds,
such as `Array` which collects an array value into a fixed maximum size
array, and `Required` which fails a decode if the value is not sent.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/nvkv.rs        |  10 +-
 drivers/gpu/nova-core/gsp/nvkv/decode.rs | 708 ++++++++++++++++++++++++++++++-
 2 files changed, 715 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gsp/nvkv.rs
index 153aeb8d08d0..9a4f3e40f811 100644
--- a/drivers/gpu/nova-core/gsp/nvkv.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv.rs
@@ -9,7 +9,7 @@
 //! speaking, the function calls will map to some struct - for example, f(GPU_NAME_STRING_KEY, 0,
 //! b"some gpu") naturally maps to storing a &str with the GPU name.
 
-#![expect(unused_imports)]
+#![cfg_attr(not(CONFIG_KUNIT = "y"), expect(unused_imports))]
 
 use core::{
     marker::PhantomData,
@@ -22,7 +22,8 @@
 use kernel::{
     alloc::{
         allocator::KVmalloc,
-        Allocator, //
+        Allocator,
+        ArrayVec, //
     },
     bitfield,
     num::Bounded,
@@ -154,6 +155,11 @@ pub(crate) fn new(index: Index, value: T) -> Self {
     }
 }
 
+/// A schema field for an array value under the NVKV key `KEY_ID`.
+pub(crate) struct Array<T, const N: usize, const KEY_ID: KeyId> {
+    vec: ArrayVec<T, N>,
+}
+
 bitfield! {
     /// The op word that starts each NVKV operation.
     struct Op(u64) {
diff --git a/drivers/gpu/nova-core/gsp/nvkv/decode.rs b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
index 6496fab1c0c6..43693cb4d31c 100644
--- a/drivers/gpu/nova-core/gsp/nvkv/decode.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
@@ -3,11 +3,25 @@
 
 #![cfg_attr(not(CONFIG_KUNIT = "y"), expect(dead_code))]
 
-use kernel::prelude::*;
+use core::{
+    convert::Infallible,
+    marker::PhantomData, //
+};
+
+use kernel::{
+    alloc::ArrayVec,
+    prelude::*, //
+};
+use pin_init::{
+    init_array_from_fn,
+    stack_try_pin_init, //
+};
 
 use crate::{
     gsp::nvkv::{
+        Array,
         Index,
+        Key,
         KeyId,
         Op,
         Opcode, //
@@ -15,6 +29,445 @@
     num::IntoSafeCast, //
 };
 
+/// Defines a schema struct together with its [`Schema`] and [`Visit`] implementations that decode
+/// into `$target`.
+///
+/// Each member of the struct should implement [`Schema`] and [`Visit`]. For every
+/// `(key, index, value)` triple decoded from the NVKV stream, the generated parent [`Visit`]
+/// implementation will call each member in declaration order with that triple. If a member consumes
+/// that triple, it will stop there. Otherwise it will keep going until all members are tried.
+///
+/// The schema struct holds the state required by the schema implementation to do the decode. It's
+/// recommended to use one of the existing [`Schema`] kinds ([`Required`], [`Optional`],
+/// [`Accumulated`], [`Key`], [`Array`], [`TruncatingArray`], [`Indexed`]) for each member.
+///
+/// Use a lifetime on the schema struct if you want to borrow data directly from the encoded stream,
+/// for example, `Key<&'d [u8], KEY>`.
+///
+/// # Examples
+///
+/// ```
+/// nvkv_decode! {
+///     struct RequestSchema => Request {
+///         id: Required<Key<u32, 0x0001>>,
+///         name: Array<u8, 64, 0x0002>,
+///     }
+/// }
+///
+/// nvkv_decode! {
+///     struct NameSchema<'d> => Name<'d> {
+///         name: Key<&'d [u8], 0x0002>,
+///     }
+/// }
+/// ```
+#[cfg_attr(not(CONFIG_KUNIT = "y"), expect(unused_macros))]
+macro_rules! nvkv_decode {
+    // A schema which doesn't borrow from the stream. The macro uses a generic lifetime for the
+    // [`Visit`] implementation but not for the struct itself. This allows omitting the unused
+    // lifetime on the struct.
+    (
+        $(#[$attr:meta])*
+        $vis:vis struct $name:ident => $target:ty { $($fields:tt)* }
+    ) => {
+        $crate::gsp::nvkv::nvkv_decode!(
+            @impl ['data] [] $(#[$attr])* $vis struct $name => $target { $($fields)* }
+        );
+    };
+    // A schema which borrows from the stream for lifetime `$datalt`. The macro connects the
+    // [`Visit`] lifetime with the struct lifetime.
+    (
+        $(#[$attr:meta])*
+        $vis:vis struct $name:ident<$datalt:lifetime> => $target:ty { $($fields:tt)* }
+    ) => {
+        $crate::gsp::nvkv::nvkv_decode!(
+            @impl [$datalt] [<$datalt>] $(#[$attr])* $vis struct $name => $target { $($fields)* }
+        );
+    };
+    (@impl [$datalt:lifetime] [$($generics:tt)*]
+        $(#[$attr:meta])*
+        $vis:vis struct $name:ident => $target:ty {
+            $(
+                $(#[$field_attr:meta])*
+                $field_vis:vis $field:ident : $ty:ty
+            ),* $(,)?
+        }
+    ) => {
+        $(#[$attr])*
+        $vis struct $name $($generics)* {
+            $(
+                $(#[$field_attr])*
+                $field_vis $field: $ty,
+            )*
+        }
+
+        impl $($generics)* $crate::gsp::nvkv::Schema for $name $($generics)* {
+            type Target = $target;
+
+            fn init() -> impl ::kernel::prelude::Init<Self> {
+                ::pin_init::init!(Self {
+                    $( $field <- <$ty as $crate::gsp::nvkv::Schema>::init(), )*
+                })
+            }
+
+            fn finish(
+                &mut self,
+            ) -> impl ::kernel::prelude::Init<Self::Target, ::kernel::error::Error> + '_ {
+                let Self { $($field,)* } = self;
+                ::kernel::try_init!(Self::Target {
+                    $( $field <- $crate::gsp::nvkv::Schema::finish($field), )*
+                }? ::kernel::error::Error)
+            }
+        }
+
+        impl<$datalt> $crate::gsp::nvkv::Visit<$datalt> for $name $($generics)* {
+            fn visit(
+                &mut self,
+                key: $crate::gsp::nvkv::KeyId,
+                index: $crate::gsp::nvkv::Index,
+                value: $crate::gsp::nvkv::DecoderValue<$datalt>,
+            ) -> ::kernel::error::Result<bool> {
+                // TODO: This performs worst-case O(#fields) visit calls. Consider optimising this
+                // if it becomes a problem.
+                Ok(false
+                    $( || $crate::gsp::nvkv::Visit::visit(&mut self.$field, key, index, value)? )*)
+            }
+        }
+    };
+}
+pub(crate) use nvkv_decode;
+
+impl<T: Default, const KEY_ID: KeyId, As> Schema for Key<T, KEY_ID, As> {
+    type Target = T;
+
+    fn init() -> impl Init<Self> {
+        Self::default()
+    }
+
+    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
+        const_assert!(
+            size_of::<T>() <= 32,
+            "`Key` here would materialize too large a value on the stack"
+        );
+
+        Ok(core::mem::take(&mut self.0))
+    }
+}
+
+impl<'data, T, const KEY_ID: KeyId, As> Visit<'data> for Key<T, KEY_ID, As>
+where
+    As: TryFrom<DecoderValue<'data>, Error = Error>,
+    T: TryFrom<As>,
+    Error: From<<T as TryFrom<As>>::Error>,
+{
+    fn visit(&mut self, key: KeyId, index: Index, value: DecoderValue<'data>) -> Result<bool> {
+        if key != KEY_ID {
+            Ok(false)
+        } else if index != Index::new::<0>() {
+            // Single values being set must be at index 0.
+            Err(EINVAL)
+        } else {
+            // Overwrite and take the latest value here.
+            self.0 = T::try_from(As::try_from(value)?)?;
+            Ok(true)
+        }
+    }
+}
+
+impl<T: Copy, const N: usize, const KEY_ID: KeyId> Schema for Array<T, N, KEY_ID> {
+    type Target = ArrayVec<T, N>;
+
+    fn init() -> impl Init<Self> {
+        init!(Self {
+            vec <- ArrayVec::init_with::<Infallible>(|_| Ok(())),
+        })
+    }
+
+    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
+        ArrayVec::init_with(move |dst| {
+            dst.extend_from_slice(&self.vec)?;
+            self.vec.clear();
+            Ok(())
+        })
+    }
+}
+
+impl<'data, T: Copy + 'data, const N: usize, const KEY_ID: KeyId> Visit<'data>
+    for Array<T, N, KEY_ID>
+where
+    &'data [T]: TryFrom<DecoderValue<'data>, Error = Error>,
+{
+    fn visit(&mut self, key: KeyId, index: Index, value: DecoderValue<'data>) -> Result<bool> {
+        if key != KEY_ID {
+            return Ok(false);
+        }
+        // Require to be at index 0
+        if index != Index::new::<0>() {
+            return Err(EINVAL);
+        }
+        // Reject oversized and take the latest value.
+        self.vec.clear();
+        self.vec.extend_from_slice(value.try_into()?)?;
+        Ok(true)
+    }
+}
+
+/// A schema field for an array value under the NVKV key `KEY_ID` that keeps at most `N` elements.
+///
+/// Unlike [`Array`], a longer value is truncated to its first `N` elements instead of failing the
+/// decode.
+pub(crate) struct TruncatingArray<T, const N: usize, const KEY_ID: KeyId> {
+    vec: ArrayVec<T, N>,
+}
+
+impl<T: Copy, const N: usize, const KEY_ID: KeyId> Schema for TruncatingArray<T, N, KEY_ID> {
+    type Target = ArrayVec<T, N>;
+
+    fn init() -> impl Init<Self> {
+        init!(Self {
+            vec <- ArrayVec::init_with::<Infallible>(|_| Ok(())),
+        })
+    }
+
+    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
+        ArrayVec::init_with(move |dst| {
+            dst.extend_from_slice(&self.vec)?;
+            self.vec.clear();
+            Ok(())
+        })
+    }
+}
+
+impl<'data, T: Copy + 'data, const N: usize, const KEY_ID: KeyId> Visit<'data>
+    for TruncatingArray<T, N, KEY_ID>
+where
+    &'data [T]: TryFrom<DecoderValue<'data>, Error = Error>,
+{
+    fn visit(&mut self, key: KeyId, index: Index, value: DecoderValue<'data>) -> Result<bool> {
+        if key != KEY_ID {
+            return Ok(false);
+        }
+        // Arrays must be at index 0.
+        if index != Index::new::<0>() {
+            return Err(EINVAL);
+        }
+        let elems: &[T] = value.try_into()?;
+        // Take the latest value, keeping its first `N` elements.
+        self.vec.clear();
+        self.vec
+            .extend_from_slice(elems.get(..N).unwrap_or(elems))?;
+        Ok(true)
+    }
+}
+
+/// A schema field that marks a child [`Schema`] as required.
+///
+/// `finish` fails with [`EINVAL`] if the child consumed no value.
+pub(crate) struct Required<S> {
+    inner: S,
+    parsed: bool,
+}
+
+impl<S: Schema> Schema for Required<S> {
+    type Target = S::Target;
+
+    fn init() -> impl Init<Self> {
+        init!(Self {
+            inner <- S::init(),
+            parsed: false,
+        })
+    }
+
+    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
+        let parsed = core::mem::take(&mut self.parsed);
+        self.inner
+            .finish()
+            .chain(move |_| if parsed { Ok(()) } else { Err(EINVAL) })
+    }
+}
+
+impl<'data, S: Visit<'data>> Visit<'data> for Required<S> {
+    fn visit(&mut self, key: KeyId, index: Index, value: DecoderValue<'data>) -> Result<bool> {
+        let consumed = self.inner.visit(key, index, value)?;
+        self.parsed |= consumed;
+        Ok(consumed)
+    }
+}
+
+/// A schema field which marks a child [`Schema`] as optional.
+pub(crate) struct Optional<S> {
+    inner: S,
+    parsed: bool,
+}
+
+impl<S: Schema> Schema for Optional<S>
+where
+    S::Target: Default + Unpin,
+{
+    type Target = Option<S::Target>;
+
+    fn init() -> impl Init<Self> {
+        init!(Self {
+            inner <- S::init(),
+            parsed: false,
+        })
+    }
+
+    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
+        const_assert!(
+            size_of::<Self::Target>() <= 512,
+            "`Optional` here would materialize too large a value on the stack"
+        );
+
+        if !core::mem::take(&mut self.parsed) {
+            return Ok(None);
+        }
+        stack_try_pin_init!(let value: S::Target =? self.inner.finish());
+        Ok(Some(core::mem::take(value.get_mut())))
+    }
+}
+
+impl<'data, S: Visit<'data>> Visit<'data> for Optional<S> {
+    fn visit(&mut self, key: KeyId, index: Index, value: DecoderValue<'data>) -> Result<bool> {
+        let consumed = self.inner.visit(key, index, value)?;
+        self.parsed |= consumed;
+        Ok(consumed)
+    }
+}
+
+/// Expects objects specified sequentially with index starting from zero.
+///
+/// This stores two [`Schema`]s which are initially empty. A [`Schema`] is expected to be complete
+/// when we get the next index.
+pub(crate) struct Accumulated<S: Schema> {
+    // Tracks the current index (starting from 0). When this advances, the schema `current` must be
+    // finished.
+    current_index: Index,
+
+    // The current `Schema` being constructed now.
+    current: S,
+
+    // Tracks empty schemas (one that has never consumed a key via `visit`), so we don't call
+    // `finish` on them.
+    current_started: bool,
+
+    // The next `Schema` to be constructed. This is required because we must consume a key intended
+    // for this Schema from the next index to know we can try calling `finish` on `current`.
+    next: S,
+
+    // The set of results generated by the completed schemas so far.
+    accumulated: KVVec<S::Target>,
+}
+
+impl<S: Schema> Schema for Accumulated<S> {
+    type Target = KVVec<S::Target>;
+
+    fn init() -> impl Init<Self> {
+        init!(Self {
+            current_index: Index::new::<0>(),
+            current <- S::init(),
+            current_started: false,
+            next <- S::init(),
+            accumulated: KVVec::new(),
+        })
+    }
+
+    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
+        if self.current_started {
+            self.accumulated
+                .try_push_init(self.current.finish(), GFP_KERNEL)?;
+            self.current_started = false;
+        }
+        self.current_index = Index::new::<0>();
+        Ok(core::mem::take(&mut self.accumulated))
+    }
+}
+
+impl<'data, S: Schema + Visit<'data>> Visit<'data> for Accumulated<S> {
+    fn visit(&mut self, key: KeyId, index: Index, value: DecoderValue<'data>) -> Result<bool> {
+        if index != self.current_index {
+            if !self.next.visit(key, Index::new::<0>(), value)? {
+                // Unrelated key to us.
+                return Ok(false);
+            }
+
+            // Require that objects at index k have all their keys sent before the k + 1 th object
+            // can be completed. Require that objects are sent contiguously in order from index 0.
+            if !self.current_started || index != self.current_index + 1 {
+                return Err(EINVAL);
+            }
+
+            // The current value must be finished. Push it and swap in `next`.
+            self.accumulated
+                .try_push_init(self.current.finish(), GFP_KERNEL)?;
+            core::mem::swap(&mut self.current, &mut self.next);
+            self.current_started = true;
+            self.current_index = index;
+            Ok(true)
+        } else {
+            let consumed = self.current.visit(key, Index::new::<0>(), value)?;
+            self.current_started |= consumed;
+            Ok(consumed)
+        }
+    }
+}
+
+/// A schema field that scatters indexed values into an array of `N` slots.
+///
+/// Values are decoded from the encoded stream using the type `As`, but then converted into `T` with
+/// [`From`], like the `As` parameter of [`Key`].
+pub(crate) struct Indexed<T, const N: usize, const KEY_ID: KeyId, As = T> {
+    slots: [T; N],
+    _as: PhantomData<As>,
+}
+
+/// Copies `elems`, converted to `T`, into `slots` at `start`.
+///
+/// Fails with [`EINVAL`] if the window does not fit in `slots`.
+fn scatter_window<T: From<As>, As: Copy>(slots: &mut [T], start: usize, elems: &[As]) -> Result {
+    let end = start.checked_add(elems.len()).ok_or(EINVAL)?;
+    // Reject indices outside of the declared array size.
+    let dst = slots.get_mut(start..end).ok_or(EINVAL)?;
+    for (d, &e) in dst.iter_mut().zip(elems) {
+        *d = T::from(e);
+    }
+    Ok(())
+}
+
+impl<T: Default, const N: usize, const KEY_ID: KeyId, As> Schema for Indexed<T, N, KEY_ID, As> {
+    type Target = [T; N];
+
+    fn init() -> impl Init<Self> {
+        init!(Self {
+            slots <- init_array_from_fn(|_| T::default()),
+            _as: PhantomData,
+        })
+    }
+
+    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
+        init_array_from_fn(|i| Ok::<_, Error>(core::mem::take(&mut self.slots[i])))
+    }
+}
+
+impl<'data, T, const N: usize, const KEY_ID: KeyId, As> Visit<'data> for Indexed<T, N, KEY_ID, As>
+where
+    T: From<As>,
+    As: Copy + TryFrom<DecoderValue<'data>, Error = Error> + 'data,
+    &'data [As]: TryFrom<DecoderValue<'data>, Error = Error>,
+{
+    fn visit(&mut self, key: KeyId, index: Index, value: DecoderValue<'data>) -> Result<bool> {
+        if key != KEY_ID {
+            return Ok(false);
+        }
+        let start = index.cast::<usize>().get();
+        // Accept both scalar vs scattered array setting for flexibility.
+        match <&[As]>::try_from(value) {
+            Ok(elems) => scatter_window(&mut self.slots, start, elems)?,
+            Err(_) => scatter_window(&mut self.slots, start, &[As::try_from(value)?])?,
+        }
+        Ok(true)
+    }
+}
+
 /// A decoded NVKV value.
 #[derive(Copy, Clone, Debug, PartialEq, Eq)]
 pub(crate) enum DecoderValue<'a> {
@@ -312,6 +765,133 @@ fn decode_unknown_key() -> Result {
         Ok(())
     }
 
+    // Tests that decoding via the `nvkv_decode!` macro works correctly.
+    #[test]
+    fn decode_typed_struct() -> Result {
+        const SCALAR32_KEY: KeyId = 0x1234;
+        const SCALAR64_KEY: KeyId = 0x1235;
+        const ARRAY8_KEY: KeyId = 0x1236;
+        const ARRAY32_KEY: KeyId = 0x1237;
+        const ARRAY64_KEY: KeyId = 0x1238;
+        const OPT_PRESENT_KEY: KeyId = 0x1239;
+        const OPT_ABSENT_KEY: KeyId = 0x123a;
+        const OPT_ARRAY_KEY: KeyId = 0x123b;
+        const TRUNCATED_KEY: KeyId = 0x123c;
+        const CONVERTED_KEY: KeyId = 0x123d;
+        const X_KEY: KeyId = 0x0100;
+        const Y_KEY: KeyId = 0x0101;
+        const SLOT_KEY: KeyId = 0x0200;
+
+        const SCALAR32_VALUE: u32 = 0x89ab_cdef;
+        const SCALAR64_VALUE: u64 = 0x0123_4567_89ab_cdef;
+        const ARRAY8_VALUE: &[u8] = &[0x12, 0x34, 0x56];
+        const ARRAY32_VALUE: &[u32] = &[0x0123_4567, 0x89ab_cdef];
+        const ARRAY64_VALUE: &[u64] = &[0x0123_4567_89ab_cdef, 0xfedc_ba98_7654_3210];
+        const OPT_PRESENT_VALUE: u32 = 0x55;
+        const OPT_ARRAY_VALUE: &[u8] = &[0x77, 0x88];
+        const TRUNCATED_VALUE: &[u8] = &[0x9a, 0xbc, 0xde];
+        const CONVERTED_VALUE: u32 = 0x66;
+
+        // A value that is decoded from the `u32` it converts from.
+        #[derive(Default)]
+        struct Converted(u32);
+
+        impl From<u32> for Converted {
+            fn from(value: u32) -> Self {
+                Self(value)
+            }
+        }
+
+        nvkv_decode! {
+            struct PairSchema => Pair {
+                x: Required<Key<u32, X_KEY>>,
+                y: Required<Key<u32, Y_KEY>>,
+            }
+        }
+
+        struct Pair {
+            x: u32,
+            y: u32,
+        }
+
+        nvkv_decode! {
+            struct TestSchema => TestDecodable {
+                scalar32: Required<Key<u32, SCALAR32_KEY>>,
+                scalar64: Required<Key<u64, SCALAR64_KEY>>,
+                array8: Array<u8, 64, ARRAY8_KEY>,
+                array32: Array<u32, 64, ARRAY32_KEY>,
+                array64: Array<u64, 32, ARRAY64_KEY>,
+                opt_present: Optional<Key<u32, OPT_PRESENT_KEY>>,
+                opt_absent: Optional<Key<u32, OPT_ABSENT_KEY>>,
+                opt_array: Optional<Array<u8, 4, OPT_ARRAY_KEY>>,
+                truncated: TruncatingArray<u8, 2, TRUNCATED_KEY>,
+                converted: Key<Converted, CONVERTED_KEY, u32>,
+                pairs: Accumulated<PairSchema>,
+                slots: Indexed<u32, 4, SLOT_KEY>,
+            }
+        }
+
+        struct TestDecodable {
+            scalar32: u32,
+            scalar64: u64,
+            array8: ArrayVec<u8, 64>,
+            array32: ArrayVec<u32, 64>,
+            array64: ArrayVec<u64, 32>,
+            opt_present: Option<u32>,
+            opt_absent: Option<u32>,
+            opt_array: Option<ArrayVec<u8, 4>>,
+            truncated: ArrayVec<u8, 2>,
+            converted: Converted,
+            pairs: KVVec<Pair>,
+            slots: [u32; 4],
+        }
+
+        let index0 = Index::new::<0>();
+        let index1 = Index::new::<1>();
+        let index2 = Index::new::<2>();
+        let mut encoder = Encoder::new();
+        encoder.encode_u32(SCALAR32_KEY, index0, SCALAR32_VALUE)?;
+        encoder.encode_u64(SCALAR64_KEY, index0, SCALAR64_VALUE)?;
+        encoder.encode_array8(ARRAY8_KEY, index0, ARRAY8_VALUE)?;
+        encoder.encode_array32(ARRAY32_KEY, index0, ARRAY32_VALUE)?;
+        encoder.encode_array64(ARRAY64_KEY, index0, ARRAY64_VALUE)?;
+        encoder.encode_u32(OPT_PRESENT_KEY, index0, OPT_PRESENT_VALUE)?;
+        encoder.encode_array8(OPT_ARRAY_KEY, index0, OPT_ARRAY_VALUE)?;
+        encoder.encode_array8(TRUNCATED_KEY, index0, TRUNCATED_VALUE)?;
+        encoder.encode_u32(CONVERTED_KEY, index0, CONVERTED_VALUE)?;
+        encoder.encode_u32(X_KEY, index0, 1)?;
+        encoder.encode_u32(Y_KEY, index0, 2)?;
+        encoder.encode_u32(SLOT_KEY, index1, 20)?;
+        encoder.encode_u32(X_KEY, index1, 3)?;
+        encoder.encode_u32(Y_KEY, index1, 4)?;
+        encoder.encode_u32(SLOT_KEY, index0, 10)?;
+        encoder.encode_array32(SLOT_KEY, index2, &[30, 40])?;
+        let serialized = encoder.finish();
+
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Error);
+        let mut schema = KBox::init(TestSchema::init(), GFP_KERNEL)?;
+        let decoded = KBox::try_init(decoder.decode(&mut *schema)?, GFP_KERNEL)?;
+
+        assert_eq!(decoded.scalar32, SCALAR32_VALUE);
+        assert_eq!(decoded.scalar64, SCALAR64_VALUE);
+        assert_eq!(*decoded.array8, *ARRAY8_VALUE);
+        assert_eq!(*decoded.array32, *ARRAY32_VALUE);
+        assert_eq!(*decoded.array64, *ARRAY64_VALUE);
+        assert_eq!(decoded.opt_present, Some(OPT_PRESENT_VALUE));
+        assert_eq!(decoded.opt_absent, None);
+        assert_eq!(decoded.opt_array.as_deref(), Some(OPT_ARRAY_VALUE));
+        assert_eq!(*decoded.truncated, TRUNCATED_VALUE[..2]);
+        assert_eq!(decoded.converted.0, CONVERTED_VALUE);
+        assert_eq!(decoded.pairs.len(), 2);
+        assert_eq!(decoded.pairs[0].x, 1);
+        assert_eq!(decoded.pairs[0].y, 2);
+        assert_eq!(decoded.pairs[1].x, 3);
+        assert_eq!(decoded.pairs[1].y, 4);
+        assert_eq!(decoded.slots, [10, 20, 30, 40]);
+
+        Ok(())
+    }
+
     /// Records each visit as `(key, index, value)`, for tests on hand-built streams.
     #[derive(Default)]
     struct Recorder<'d> {
@@ -500,4 +1080,130 @@ fn decode_raw_words_malformed() -> Result {
 
         Ok(())
     }
+
+    // Tests the error paths of the schema kinds.
+    #[test]
+    fn decode_typed_struct_errors() -> Result {
+        const VALUE_KEY: KeyId = 0x2200;
+        const SLOT_KEY: KeyId = 0x2201;
+        const BLOB_KEY: KeyId = 0x2202;
+        const X_KEY: KeyId = 0x2203;
+        const Y_KEY: KeyId = 0x2204;
+
+        let index0 = Index::new::<0>();
+        let index1 = Index::new::<1>();
+        let index2 = Index::new::<2>();
+
+        nvkv_decode! {
+            struct ValueSchema => Value {
+                value: Key<u32, VALUE_KEY>,
+            }
+        }
+
+        struct Value {
+            value: u32,
+        }
+
+        // A single value at a non-zero index.
+        let mut encoder = Encoder::new();
+        encoder.encode_u32(VALUE_KEY, index1, 1)?;
+        let serialized = encoder.finish();
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Error);
+        let mut schema = KBox::init(ValueSchema::init(), GFP_KERNEL)?;
+        assert!(decoder.decode(&mut *schema).is_err());
+
+        // A 64-bit value for a 32-bit key.
+        let mut encoder = Encoder::new();
+        encoder.encode_u64(VALUE_KEY, index0, 1)?;
+        let serialized = encoder.finish();
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Error);
+        let mut schema = KBox::init(ValueSchema::init(), GFP_KERNEL)?;
+        assert!(decoder.decode(&mut *schema).is_err());
+
+        nvkv_decode! {
+            struct SlotsSchema => Slots {
+                slots: Indexed<u32, 2, SLOT_KEY>,
+            }
+        }
+
+        struct Slots {
+            slots: [u32; 2],
+        }
+
+        // An index past the declared slots.
+        let mut encoder = Encoder::new();
+        encoder.encode_u32(SLOT_KEY, index2, 1)?;
+        let serialized = encoder.finish();
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Error);
+        let mut schema = KBox::init(SlotsSchema::init(), GFP_KERNEL)?;
+        assert!(decoder.decode(&mut *schema).is_err());
+
+        nvkv_decode! {
+            struct BlobSchema => Blob {
+                blob: Array<u8, 4, BLOB_KEY>,
+            }
+        }
+
+        struct Blob {
+            blob: ArrayVec<u8, 4>,
+        }
+
+        // An array longer than the declared capacity.
+        let mut encoder = Encoder::new();
+        encoder.encode_array8(BLOB_KEY, index0, &[0; 5])?;
+        let serialized = encoder.finish();
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Error);
+        let mut schema = KBox::init(BlobSchema::init(), GFP_KERNEL)?;
+        assert!(decoder.decode(&mut *schema).is_err());
+
+        nvkv_decode! {
+            struct PairSchema => Pair {
+                x: Required<Key<u32, X_KEY>>,
+                y: Required<Key<u32, Y_KEY>>,
+            }
+        }
+
+        struct Pair {
+            x: u32,
+            y: u32,
+        }
+
+        // Required keys that are missing are an error.
+        let mut encoder = Encoder::new();
+        encoder.encode_u32(X_KEY, index0, 1)?;
+        let serialized = encoder.finish();
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Error);
+        let mut schema = KBox::init(PairSchema::init(), GFP_KERNEL)?;
+        let init = decoder.decode(&mut *schema)?;
+        assert!(KBox::try_init(init, GFP_KERNEL).is_err());
+
+        nvkv_decode! {
+            struct PairsSchema => Pairs {
+                pairs: Accumulated<PairSchema>,
+            }
+        }
+
+        struct Pairs {
+            pairs: KVVec<Pair>,
+        }
+
+        // Accumulated objects must start at index 0.
+        let mut encoder = Encoder::new();
+        encoder.encode_u32(X_KEY, index1, 1)?;
+        let serialized = encoder.finish();
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Error);
+        let mut schema = KBox::init(PairsSchema::init(), GFP_KERNEL)?;
+        assert!(decoder.decode(&mut *schema).is_err());
+
+        // Accumulated objects must be complete before the next one starts.
+        let mut encoder = Encoder::new();
+        encoder.encode_u32(X_KEY, index0, 1)?;
+        encoder.encode_u32(X_KEY, index1, 2)?;
+        let serialized = encoder.finish();
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Error);
+        let mut schema = KBox::init(PairsSchema::init(), GFP_KERNEL)?;
+        assert!(decoder.decode(&mut *schema).is_err());
+
+        Ok(())
+    }
 }

-- 
2.56.0

