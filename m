Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B6FCCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:54:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52AAD10EBAE;
	Fri, 16 Oct 2026 01:54:52 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBBF911255B
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 01:54:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlP9L2b7aa+MECxMis79nW6lPCzGzD63czSD/+WRb35+qlFvnUcgU+pNE4EUEXR6GKS4YxlguSUwtZDGLcz8rWyaIb8QGeMEHLxZSDdmyn8HfaIUCWkhkGEocy3Ty9WEvZBByhO05GnfaO+/1WsdQwx/yFDc/VHwSuxg9E7r3LbyuNH77cBsL5qSJm9E+lu7L+3fI4YfpKd83Z4AfoSJ1PnME6FJNMFfXUJY/xlh9PcCv3Is3DaIYZjqlwOtgAZbVg1wcpJoi1gMaPr962Mc1+MkeZn3Rx5v/mBQP9XNmlYwGJkNkvw7Msh78s1ju0D2rPNkCKXFOapt3TKEZRFE4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsK7jyNdLPybFHuy1h1EzHwMy9BEG9Ii+X2HNpiOXCE=;
 b=o1Es1sgU6Ao30zsGAs6Hv4SAE4UFqY8vOZZreheWXD/8mqDBAZ9gJnKy2kDzgT7nuFHjvRIj0IorKTCpZU+zy33WK0tlcLBsI6DUcbuwX7xtO00poM4hUUcPutiNYk9W7DJ73llFagTBRNTYsUXuPDylqcGbKYjZUw/aaHDvq57stJMifBPZUjiJU3x/d3WMHA7FqHWX0U/wWqEwDtxQ5k1+bXX7COScB2489isZT51DCwrxWFUrI1FnJzhMd7mpRHar0oadFUXvQ8jtFMrG1QkZNpXZZx3f4iw2nW9jFicgPPbsR/i5zQk4j6QIneSyhKOAJ/XYKHY4DlCrjdN+ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsK7jyNdLPybFHuy1h1EzHwMy9BEG9Ii+X2HNpiOXCE=;
 b=Hp0oNd04Uk0EISOj9owm+T3xJ+vqBXI8IDebAUkkWl2qOE6xhcMfWmTakhygLitWjkvt7g1XEdZhH2ZYAkrG8n9GqpgW0zcjgrfxUV27s2zlX7v92nx/OXxOeUSKPvQxx3PTglJJXKGolBDJAMWz6gZUYAnoIWP3MBj77T4TkblSs3y+Lgv8LnVnuUJWIG3fRNroO31QGr2TQ7/112jYw89B4xyRblqA1a3qwMVcdqUueJ0NnvDPGZQAg16IS0c/+EsZpd1jvNxZbG9rv1sL4ttBt/OUzQ6NVighSZbzrzOwACuNK6CijQ+GF2aBEcXn+cniL1ERGBoVLHOnx64j2w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA1PR12MB999230.namprd12.prod.outlook.com (2603:10b6:806:4de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 01:54:21 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0496.021; Fri, 16 Oct 2026
 01:54:21 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 16 Oct 2026 10:53:40 +0900
Subject: [PATCH v4 4/7] gpu: nova-core: add NVKV decoder
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-b4-nvkv-v4-4-e8b92b91aa5b@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0148.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::16) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA1PR12MB999230:EE_
X-MS-Office365-Filtering-Correlation-Id: 4861125b-00c6-4153-77e4-08df2b28656a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|23010399003|10070799003|366016|376014|6133799003|18002099003|10067099003|22082099003|3023799007|921020|261009223027099003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: OtBxv0i8Vzp6486cBt3pD85qa2yp2h88xpP2CmRMQ4ZWgSKv9rlCPwdyAq3UVVWA1ABaQPlKoFl5SelzfGPXWSaTubaL2VflLCPhMb/WvnUhOt2RZUiCWo/LHZzyBjL5ZK7IQs++9Hbckoc/jA712SFEi7GGa3cgYWiTp95t8nwZl5sY9UFVl6igVrXEbq10SiBHrm4D0uPjbyxzeU+cwfJWiuDwhxNXmv5uN9UIKz/X1vUX+l3EWYZbJn4ut2nDBCfVVhAStoGn4bigI1991SVmBkvsVAti9OpJDfmPm4Fl33t2YpMIjmjH6/256dzhNRhNcOAHuVaWD61u1tyXwFee9RU/kqPmIi4fbDHdDTnY/2DtZ1xGQV4jdBTo4+8xnHPYfQw8VqsGXjxPz68L8p9CTezV2uSNmYBPV77Qb8+LwzNBUB5ZD8JmKaqxaq9IdOCP3OOCBuJIznuY9IJXs2fT0BdCk+z/iQ5Z/oHHTtLJMV6I/Mb7QRv1g5/r2/KH04i1nGRtMrn14lHFCSbutlDFJmVHyGW1mjAvr9P4CWLnwxIQEerdRTJ1y/R9lpOJ2LQeh+GTkalmAo3ffgqAqxyDl5XNznlp58lX+vhRAMRNO80kFh/rkjknIwF1z2Unr9Zcsq1W+RBocEOMp2euw+/2pLAM4/7wpN3wjrRWc1GdeguakmdrIHRBklxs55AETzvlG7NHzG0HqJiER9cFzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(23010399003)(10070799003)(366016)(376014)(6133799003)(18002099003)(10067099003)(22082099003)(3023799007)(921020)(261009223027099003)(11063799006)(56012099006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGVHQmZHcHBaS2dWb0RTWnpLZ1lOaW9ydGVwaDV4c0I1c2lOMFg0c0plN055?=
 =?utf-8?B?WTZWdm1XVkd6MnpCY3haeE9iV2taN3pOQzc2M2VHME5NMkhSMVlNakI4Sktp?=
 =?utf-8?B?YzB0Q3U2end5V0U4R0ZHVG1FNHYra3lDcHhTcCtBSVB5S01hNWFNTGpQeVhi?=
 =?utf-8?B?U1kzUFdCTHl0RkYxbGw4NkFjRlpBb2RUTHR3ZDE3ci83T1NQb2dDYnc2dklw?=
 =?utf-8?B?L2JOV3NPbXlOWTN1c091RUVDSUU4MTA1VUcrSVE3MkV5WU10SDh4Y29LT2x3?=
 =?utf-8?B?Wnk2aWZyTU5GeXJRanFjRkV0ampSR29pTUVCWlEzeE02RUhZa0djUzJ0LzdQ?=
 =?utf-8?B?aHpYdm9NRzNMSlpvVlo1NGNWQWtkTmhINjl4eW03b09kUTNGWGtNWFgxSjBH?=
 =?utf-8?B?VmlpSWVLMEc3UFRDNThDWXRqOSsxd3EwTGRtMHZSL1QrUUJNTURLNGM2dTcv?=
 =?utf-8?B?dllEWTZGcFNYcFUxT25vV2xNTWw3VUdTdUp3QWYxb3c2YXY0c1dsOXdYOGJY?=
 =?utf-8?B?VVFOcTZYTDBWZm5MNlQyVFF5QTNiVnJVUXY5REVIR2c0UjNjcWlxcG4zckdj?=
 =?utf-8?B?S0xuME5obVc1SmRxRWd3RURZSXFMbTBYYTZDRkNxQ1VmNTZacHY1bFBCdDB4?=
 =?utf-8?B?bGhUR21WQ0ExcGtONDVqYko2SFlNNUVGbWZOZjdWOTNJb2JlYXhBL1Y5WWdN?=
 =?utf-8?B?NXZBakJFb3hJd2V3QkNVOW5QdFZKY2lwcHhjRmdhWUlCV1RTenc3bEhlUEVK?=
 =?utf-8?B?eWtRV2h3SjhpMTZFUmFmWVNTayt2QlVyRjdIMlp5ZDlWY1JobFZLWHo1L0Iz?=
 =?utf-8?B?R2J5QUdqSEF5NFNxeGVPbDJ2cHRvaWVTNlRqc1NIR2UxT05BZ1lCSktVK2dH?=
 =?utf-8?B?aXJyQzQzbGJxZVZ1WVlpYm5RMWJMdy9pckRDcjVwZGdVUFNVRmZISXJWQW02?=
 =?utf-8?B?c3NoVGVlNTNuMWZNU3NPbjNNRk11S1FKQ0NRYXo1QVBZQXNkSGlESjhvWHRM?=
 =?utf-8?B?MDEvOXFQUTR2NEJ5cjlNZU5ZclJNWmlndU1BMTBWOEdJU25oT3c1VGVnaURn?=
 =?utf-8?B?TkVPaWVFb2lFVDh2aTBCbHpKMCtLVG1ZVjYwNFV4SlFrY0J6MW1XMnJrUk5W?=
 =?utf-8?B?Ky96eGFGd0Y0L0E3TXk0R0FiTXNDQ2xKMmM0QmtjZWwrczNBWWIxNk5tdGVi?=
 =?utf-8?B?dGtXRXdVNE12QU04cTNzZ1R0U1h0QVE3SWxzbjF0VS9zN3dOVW42NFFhWVlw?=
 =?utf-8?B?YXFKZjQ1VzhMSk90cTdyZFNzZmVTRE80S0laaGU4RGpiZ21VUlVtWG5Oa2tj?=
 =?utf-8?B?am96cXBsZDZONWF5eEw2SmR3d2xLKy9nWFoyM2tIcllCT0RHdFE5cVFlSDlB?=
 =?utf-8?B?YW0wZG1zMDBpajFNOEprT0tvNkhyTkdkWkhzWVVnK3FTM2JGZmkzUldwN2JQ?=
 =?utf-8?B?aDhIRjAvelg0SDJTT2g3bFAxQlJYd0JrSThydXNLRXB3aG5tLzJSditJaEhQ?=
 =?utf-8?B?MWdmMmlkWmVwZzg2aFFLWkM1QnlpQ3NhQzMrOFVWcFdTWnd6aldSVno0WFhh?=
 =?utf-8?B?czFzT21JWCtGdFJqWFdYMTdQSWlhZ3NvNmJBTFBNQmJzQkppakt4WUNyelg5?=
 =?utf-8?B?ZjRSUmhQK2V2ZVlIbkNSYnN0TElOR21PUHhsbk5ML2p3eXZPQUNRS2M5U2NB?=
 =?utf-8?B?aUUvYzFMVW9Sbk5hNzdnS0REUHh2ZVA2RXUxQTlES0ZET00yZktObnVuWXdL?=
 =?utf-8?B?WUtTeGZYR05JTm9yaXNHbGo0dTlsbGVrQkZXQVNpSGwxakJJZTNOc3A2QmdX?=
 =?utf-8?B?ZU5aWVdHVGcydDgzbnczSlZzZkxaTHlQQ3lza1hDT1k4UjBXT3V5NHNwMVIv?=
 =?utf-8?B?WVg1ZVRLaXJaNlp6ZU9uVXM0YmFHYWUxRk1MZHFvcm5EMjFLZk9UWEVNWkZI?=
 =?utf-8?B?MjVCdGlWZ09RbUxHQWljVElZOTFPWk1INlZOTFU5T0U4N3JFUVQwcFBVdGtv?=
 =?utf-8?B?Snd3WUhiOWZKNGVSNlVkdGRhTDBlTUR5dUduTlJRWENuL01zMDBjbktjdGJt?=
 =?utf-8?B?Y1RWWVRZUzR0Ty9IY0tFbHB3Tngwczk3QnVIL2lxVFhyUnlhWXFkcnZuRWly?=
 =?utf-8?B?R1UyanZBSDNLVEdIc2phQzZRRWpFejlXem1nSENySlIwcUI1bzRKcE1QcXZt?=
 =?utf-8?B?dmMrNm5wdnFKZkttVkVTZ2dkSDZXL0JpT1NEMEZIVDJnSmtUcmVOVlNXLzA3?=
 =?utf-8?B?K1UxWlZDZWJ6b0pCdmpYQXFXTTV2QkNUVXVSWjlvKzAxUUcrMjhuY1R6ZzNV?=
 =?utf-8?B?VWhUWmtWQTlVMUxuMExrUWFzUUxCMCtTeFYyWTNYaENvVEUzUEM1ZTM0d3Z6?=
 =?utf-8?Q?C2XtKxORPOjK0igbkalcSEqxrjbYYwHsbsxB+P7WEcBS+?=
X-MS-Exchange-AntiSpam-MessageData-1: DIWCHCSEJJXolg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4861125b-00c6-4153-77e4-08df2b28656a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 01:54:21.1347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBMJs1U37QTqLp7ycT5lEl/eqHczhG+GNqItIyvMd4hbHhqVXQ16mg9dnYIsO9gzy3OcYOXnNyDMuIoWkZku0A==
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

Add a decoder for NVKV. This is for receiving messages from GSP for
GMCAPI calls. The NVKV format essentially encodes a sequence of function
calls f(key, index, value). This decoder reads an encoded stream and
invokes a type implementing the new `Schema` and `Visit` trait. The
`Visit` trait can either consume the value or not, which is useful for
composing schemas. If a (key, index, value) is not consumed, error out
depending on `UnknownKeyPolicy`. Whether ignoring unknown keys is ok or
not is per each GMCAPI call.

Add kunit tests for the decoder.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/nvkv.rs        |   3 +
 drivers/gpu/nova-core/gsp/nvkv/decode.rs | 503 +++++++++++++++++++++++++++++++
 2 files changed, 506 insertions(+)

diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gsp/nvkv.rs
index 80936f7c53d0..ac4b399fb05c 100644
--- a/drivers/gpu/nova-core/gsp/nvkv.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv.rs
@@ -29,6 +29,9 @@
 mod encode;
 pub(crate) use encode::*;
 
+mod decode;
+pub(crate) use decode::*;
+
 /// The allocator backing [`EncodedStream`].
 type StreamAllocator = KVmalloc;
 
diff --git a/drivers/gpu/nova-core/gsp/nvkv/decode.rs b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
new file mode 100644
index 000000000000..6496fab1c0c6
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
@@ -0,0 +1,503 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+#![cfg_attr(not(CONFIG_KUNIT = "y"), expect(dead_code))]
+
+use kernel::prelude::*;
+
+use crate::{
+    gsp::nvkv::{
+        Index,
+        KeyId,
+        Op,
+        Opcode, //
+    },
+    num::IntoSafeCast, //
+};
+
+/// A decoded NVKV value.
+#[derive(Copy, Clone, Debug, PartialEq, Eq)]
+pub(crate) enum DecoderValue<'a> {
+    Scalar32(u32),
+    Scalar64(u64),
+    Array8(&'a [u8]),
+    Array32(&'a [u32]),
+    Array64(&'a [u64]),
+}
+
+/// Implements [`TryFrom`] from the given [`DecoderValue`] variant to the given type.
+///
+/// [`TryFrom`] is used by the [`Schema`] implementations in this file to convert from the
+/// [`DecoderValue`]s into the types to store. Provide the implementations for basic types here.
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
+/// The state of one NVKV decode operation which produces a target value [`Target`](Schema::Target).
+///
+/// The decoded values are passed to the state through [`Visit`], which is a separate trait so
+/// that only [`Visit`] has the lifetime of the stream as a parameter. Structs whose [`Schema`]
+/// fields don't borrow from the stream then don't need a lifetime parameter.
+pub(crate) trait Schema {
+    type Target;
+
+    /// Returns an initializer that creates an empty schema in place.
+    ///
+    /// Use [`KBox::init`] for the heap or [`stack_pin_init!`](pin_init::stack_pin_init) for the
+    /// stack (if sure that the value is small enough to fit).
+    fn init() -> impl Init<Self>;
+
+    /// Returns an initializer that makes the decoded [`Target`](Schema::Target).
+    ///
+    /// After the returned initializer runs successfully, the schema must be empty again. Taking
+    /// `self` instead of `&mut self` would avoid this contract, but it forces a copy of the schema
+    /// onto the stack.
+    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_;
+}
+
+/// Trait for types that visit the decoded key, index, and value tuple of an NVKV stream.
+///
+/// A schema that doesn't need to borrow data from the stream can implement this for all `'data`
+/// lifetimes, avoiding having to carry the lifetime parameter. A schema that borrows from the
+/// stream directly should implement it for its own lifetime only.
+pub(crate) trait Visit<'data> {
+    /// Visits one decoded tuple. Returns `Ok(true)` if the schema consumed it.
+    fn visit(&mut self, key: KeyId, index: Index, value: DecoderValue<'data>) -> Result<bool>;
+}
+
+/// A read position in an NVKV stream.
+struct Cursor<'a> {
+    data: &'a [u64],
+}
+
+impl<'a> Cursor<'a> {
+    /// Creates a cursor at the start of `data`.
+    fn new(data: &'a [u64]) -> Self {
+        Self { data }
+    }
+
+    /// Returns `true` if no `u64` values remain.
+    fn is_empty(&self) -> bool {
+        self.data.is_empty()
+    }
+
+    /// Takes the next `u64`.
+    fn take_u64(&mut self) -> Result<u64> {
+        // PANIC: `take_u64s(1)` returns exactly one element on success.
+        Ok(self.take_u64s(1)?[0])
+    }
+
+    /// Takes `count` bytes. If `count` is not a multiple of 8 (`u64` size), bytes are discarded up
+    /// to the next multiple.
+    fn take_u8s(&mut self, count: usize) -> Result<&'a [u8]> {
+        let values = self.take_u64s(count.div_ceil(size_of::<u64>()))?;
+        values.as_bytes().get(..count).ok_or(EINVAL)
+    }
+
+    /// Takes `count` 32-bit values. If `count` is not a multiple of 2 (`u32` values per `u64`),
+    /// bytes are discarded up to the next multiple.
+    fn take_u32s(&mut self, count: usize) -> Result<&'a [u32]> {
+        let values = self.take_u64s(count.div_ceil(size_of::<u64>() / size_of::<u32>()))?;
+        <[u32]>::ref_from_prefix_with_elems(values.as_bytes(), count)
+            .map(|(elems, _)| elems)
+            .map_err(|_| EINVAL)
+    }
+
+    /// Takes `count` `u64` values, or fails with [`EINVAL`] if fewer remain.
+    fn take_u64s(&mut self, count: usize) -> Result<&'a [u64]> {
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
+    /// Passes a decoded value to `schema` and applies the [`UnknownKeyPolicy`] if not consumed.
+    fn visit<S: Visit<'a>>(
+        &self,
+        schema: &mut S,
+        key: KeyId,
+        index: Index,
+        value: DecoderValue<'a>,
+    ) -> Result {
+        let consumed = schema.visit(key, index, value)?;
+        if !consumed && self.policy == UnknownKeyPolicy::Error {
+            Err(EINVAL)
+        } else {
+            Ok(())
+        }
+    }
+
+    /// Computes the key to use with a `SEQ` operation, or errors if it doesn't
+    /// make a valid key (overflow).
+    fn seq_key(base: KeyId, offset: usize) -> Result<KeyId> {
+        base.checked_add(KeyId::try_from(offset)?).ok_or(EINVAL)
+    }
+
+    /// Decodes every pair into `schema` and returns the result of [`Schema::finish`].
+    pub(crate) fn decode<'s, S: Schema + Visit<'a>>(
+        &self,
+        schema: &'s mut S,
+    ) -> Result<impl Init<S::Target, Error> + 's> {
+        let mut cursor = Cursor::new(self.data);
+        while !cursor.is_empty() {
+            let op: Op = cursor.take_u64()?.into();
+
+            let key = op.key();
+            let index = op.index();
+            let op_value = op.value();
+            match op.opcode()? {
+                Opcode::Imm32 => {
+                    self.visit(schema, key, index, DecoderValue::Scalar32(op_value))?;
+                }
+                Opcode::Seq32 => {
+                    let values = cursor.take_u32s(op_value.into_safe_cast())?;
+                    for (i, &value) in values.iter().enumerate() {
+                        let key = Self::seq_key(key, i)?;
+                        self.visit(schema, key, index, DecoderValue::Scalar32(value))?;
+                    }
+                }
+                Opcode::Seq64 => {
+                    let values = cursor.take_u64s(op_value.into_safe_cast())?;
+                    for (i, &value) in values.iter().enumerate() {
+                        let key = Self::seq_key(key, i)?;
+                        self.visit(schema, key, index, DecoderValue::Scalar64(value))?;
+                    }
+                }
+                Opcode::Array8 => {
+                    let value = cursor.take_u8s(op_value.into_safe_cast())?;
+                    self.visit(schema, key, index, DecoderValue::Array8(value))?;
+                }
+                Opcode::Array32 => {
+                    let value = cursor.take_u32s(op_value.into_safe_cast())?;
+                    self.visit(schema, key, index, DecoderValue::Array32(value))?;
+                }
+                Opcode::Array64 => {
+                    let value = cursor.take_u64s(op_value.into_safe_cast())?;
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
+    /// Decoding skips values that the schema does not consume.
+    Ignore,
+    /// Decoding fails with [`EINVAL`] on the first value that the schema does not consume.
+    Error,
+}
+
+#[kunit_tests(nova_core_nvkv_decode)]
+mod tests {
+    use super::*;
+
+    use crate::gsp::nvkv::Encoder;
+
+    /// The output type of the hand written [`Schema`].
+    ///
+    /// In this case, we can have it also implement [`Schema`] on itself rather than having a
+    /// separate carrier type, since the [`Schema`] implementation is completely stateless.
+    #[derive(Default)]
+    struct RawSchema {
+        scalar32: u32,
+        scalar64: u64,
+    }
+
+    impl RawSchema {
+        const SCALAR32_KEY: KeyId = 0x1001;
+        const SCALAR64_KEY: KeyId = 0x1002;
+    }
+
+    impl Schema for RawSchema {
+        type Target = Self;
+
+        fn init() -> impl Init<Self> {
+            Self::default()
+        }
+
+        fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
+            Ok(core::mem::take(self))
+        }
+    }
+
+    impl<'d> Visit<'d> for RawSchema {
+        fn visit(&mut self, key: KeyId, index: Index, value: DecoderValue<'d>) -> Result<bool> {
+            if index != Index::new::<0>() {
+                return Err(EINVAL);
+            }
+            match key {
+                Self::SCALAR32_KEY => self.scalar32 = value.try_into()?,
+                Self::SCALAR64_KEY => self.scalar64 = value.try_into()?,
+                _ => return Ok(false),
+            }
+            Ok(true)
+        }
+    }
+
+    // Tests that basic decoding into a manually implemented `Schema` works correctly.
+    #[test]
+    fn decode_raw_schema() -> Result {
+        // Decodes an IMM32 pair and a SEQ64 pair (the encoder emits a u64 as a single-element
+        // SEQ64) with a hand written `Schema`. Keys and value constants chosen to distinguish e.g.
+        // saving the wrong value to the wrong location.
+        const SCALAR32_VALUE: u32 = 0x1111_2222;
+        const SCALAR64_VALUE: u64 = 0x3333_4444_5555_6666;
+
+        let mut encoder = Encoder::new();
+        encoder.encode_u32(RawSchema::SCALAR32_KEY, Index::new::<0>(), SCALAR32_VALUE)?;
+        encoder.encode_u64(RawSchema::SCALAR64_KEY, Index::new::<0>(), SCALAR64_VALUE)?;
+        let serialized = encoder.finish();
+
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Error);
+        let mut schema = KBox::init(RawSchema::init(), GFP_KERNEL)?;
+        let decoded = KBox::try_init(decoder.decode(&mut *schema)?, GFP_KERNEL)?;
+
+        assert_eq!(decoded.scalar32, SCALAR32_VALUE);
+        assert_eq!(decoded.scalar64, SCALAR64_VALUE);
+
+        Ok(())
+    }
+
+    // Tests that an unknown key fails the decode under `UnknownKeyPolicy::Error` and is skipped
+    // under `UnknownKeyPolicy::Ignore`.
+    #[test]
+    fn decode_unknown_key() -> Result {
+        const UNKNOWN_KEY: KeyId = 0x2001;
+
+        let mut encoder = Encoder::new();
+        encoder.encode_u32(UNKNOWN_KEY, Index::new::<0>(), 1)?;
+        let serialized = encoder.finish();
+
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Error);
+        let mut schema = KBox::init(RawSchema::init(), GFP_KERNEL)?;
+        assert!(decoder.decode(&mut *schema).is_err());
+
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Ignore);
+        let mut schema = KBox::init(RawSchema::init(), GFP_KERNEL)?;
+        assert!(decoder.decode(&mut *schema).is_ok());
+
+        Ok(())
+    }
+
+    /// Records each visit as `(key, index, value)`, for tests on hand-built streams.
+    #[derive(Default)]
+    struct Recorder<'d> {
+        visits: KVVec<(KeyId, u64, DecoderValue<'d>)>,
+    }
+
+    impl<'d> Schema for Recorder<'d> {
+        type Target = KVVec<(KeyId, u64, DecoderValue<'d>)>;
+
+        fn init() -> impl Init<Self> {
+            Self::default()
+        }
+
+        fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
+            Ok(core::mem::take(&mut self.visits))
+        }
+    }
+
+    impl<'d> Visit<'d> for Recorder<'d> {
+        fn visit(&mut self, key: KeyId, index: Index, value: DecoderValue<'d>) -> Result<bool> {
+            self.visits.push((key, index.get(), value), GFP_KERNEL)?;
+            Ok(true)
+        }
+    }
+
+    // Tests the decoder on hand-built `u64` values that the encoder does not produce: SEQ32,
+    // multi-value SEQ64, zero counts, a non-zero index and padded arrays.
+    #[test]
+    fn decode_raw_u64s() -> Result {
+        const SEQ32_KEY: KeyId = 0x2000;
+        const SEQ64_KEY: KeyId = 0x2010;
+        const EMPTY_SEQ64_KEY: KeyId = 0x2020;
+        const EMPTY_SEQ32_KEY: KeyId = 0x2021;
+        const EMPTY_ARRAY8_KEY: KeyId = 0x2030;
+        const EMPTY_ARRAY32_KEY: KeyId = 0x2031;
+        const EMPTY_ARRAY64_KEY: KeyId = 0x2032;
+        const ARRAY8_KEY: KeyId = 0x2040;
+        const ARRAY32_KEY: KeyId = 0x2041;
+
+        let data = [
+            // SEQ32 with three values for three consecutive keys, packed two per `u64`.
+            Op::zeroed()
+                .with_key(SEQ32_KEY)
+                .with_opcode(Opcode::Seq32)
+                .with_value(3)
+                .into_raw(),
+            0x0000_0002_0000_0001,
+            0x0000_0000_0000_0003,
+            // SEQ64 with two values at a non-zero index.
+            Op::zeroed()
+                .with_key(SEQ64_KEY)
+                .with_index(Index::new::<3>())
+                .with_opcode(Opcode::Seq64)
+                .with_value(2)
+                .into_raw(),
+            0x1111_1111_1111_1111,
+            0x2222_2222_2222_2222,
+            // A zero-count sequence has no keys and is skipped, as in NVIDIA's decoder.
+            Op::zeroed()
+                .with_key(EMPTY_SEQ64_KEY)
+                .with_opcode(Opcode::Seq64)
+                .with_value(0)
+                .into_raw(),
+            Op::zeroed()
+                .with_key(EMPTY_SEQ32_KEY)
+                .with_opcode(Opcode::Seq32)
+                .with_value(0)
+                .into_raw(),
+            // A zero-length array is visited with an empty slice.
+            Op::zeroed()
+                .with_key(EMPTY_ARRAY8_KEY)
+                .with_opcode(Opcode::Array8)
+                .with_value(0)
+                .into_raw(),
+            Op::zeroed()
+                .with_key(EMPTY_ARRAY32_KEY)
+                .with_opcode(Opcode::Array32)
+                .with_value(0)
+                .into_raw(),
+            Op::zeroed()
+                .with_key(EMPTY_ARRAY64_KEY)
+                .with_opcode(Opcode::Array64)
+                .with_value(0)
+                .into_raw(),
+            // Three bytes padded to one `u64`, then three 32-bit values padded to two `u64` values.
+            Op::zeroed()
+                .with_key(ARRAY8_KEY)
+                .with_opcode(Opcode::Array8)
+                .with_value(3)
+                .into_raw(),
+            0x0000_0000_00cc_bbaa,
+            Op::zeroed()
+                .with_key(ARRAY32_KEY)
+                .with_opcode(Opcode::Array32)
+                .with_value(3)
+                .into_raw(),
+            0x0000_0002_0000_0001,
+            0x0000_0000_0000_0003,
+        ];
+
+        let decoder = Decoder::new(&data, UnknownKeyPolicy::Error);
+        let mut schema = KBox::init(Recorder::init(), GFP_KERNEL)?;
+        let visits = KBox::try_init(decoder.decode(&mut *schema)?, GFP_KERNEL)?;
+
+        assert_eq!(
+            visits.as_slice(),
+            &[
+                (SEQ32_KEY, 0, DecoderValue::Scalar32(1)),
+                (SEQ32_KEY + 1, 0, DecoderValue::Scalar32(2)),
+                (SEQ32_KEY + 2, 0, DecoderValue::Scalar32(3)),
+                (SEQ64_KEY, 3, DecoderValue::Scalar64(0x1111_1111_1111_1111)),
+                (
+                    SEQ64_KEY + 1,
+                    3,
+                    DecoderValue::Scalar64(0x2222_2222_2222_2222)
+                ),
+                (EMPTY_ARRAY8_KEY, 0, DecoderValue::Array8(&[])),
+                (EMPTY_ARRAY32_KEY, 0, DecoderValue::Array32(&[])),
+                (EMPTY_ARRAY64_KEY, 0, DecoderValue::Array64(&[])),
+                (ARRAY8_KEY, 0, DecoderValue::Array8(&[0xaa, 0xbb, 0xcc])),
+                (ARRAY32_KEY, 0, DecoderValue::Array32(&[1, 2, 3])),
+            ]
+        );
+
+        Ok(())
+    }
+
+    // Tests that decoding a malformed stream fails instead of reading past the payload.
+    #[test]
+    fn decode_raw_words_malformed() -> Result {
+        const KEY: KeyId = 0x2100;
+
+        // An `Op` with the reserved opcode 6.
+        let bad_opcode = Op::zeroed().with_key(KEY).into_raw() | (6u64 << Op::OPCODE_SHIFT);
+        let streams: [&[u64]; 6] = [
+            // 100 bytes need 13 `u64` values, only one follows.
+            &[
+                Op::zeroed()
+                    .with_key(KEY)
+                    .with_opcode(Opcode::Array8)
+                    .with_value(100)
+                    .into_raw(),
+                0,
+            ],
+            // Two 64-bit values, only one follows.
+            &[
+                Op::zeroed()
+                    .with_key(KEY)
+                    .with_opcode(Opcode::Seq64)
+                    .with_value(2)
+                    .into_raw(),
+                0,
+            ],
+            // Three 32-bit values need two `u64` values, only one follows.
+            &[
+                Op::zeroed()
+                    .with_key(KEY)
+                    .with_opcode(Opcode::Array32)
+                    .with_value(3)
+                    .into_raw(),
+                0,
+            ],
+            // A value count with no payload.
+            &[Op::zeroed()
+                .with_key(KEY)
+                .with_opcode(Opcode::Seq32)
+                .with_value(1)
+                .into_raw()],
+            &[bad_opcode],
+            // Consecutive keys that overflow `KeyId`.
+            &[
+                Op::zeroed()
+                    .with_key(KeyId::MAX)
+                    .with_opcode(Opcode::Seq32)
+                    .with_value(2)
+                    .into_raw(),
+                0,
+            ],
+        ];
+
+        for stream in streams {
+            let decoder = Decoder::new(stream, UnknownKeyPolicy::Ignore);
+            let mut schema = KBox::init(Recorder::init(), GFP_KERNEL)?;
+            assert!(decoder.decode(&mut *schema).is_err());
+        }
+
+        Ok(())
+    }
+}

-- 
2.56.0

