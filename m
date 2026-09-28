Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1192BC9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:44:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F305110E8C5;
	Mon, 28 Sep 2026 08:43:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="pImOQnUC";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011037.outbound.protection.outlook.com [52.101.52.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5FC110E865
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:43:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4Ke9PPRalbYjWOiDufhmk5Ov8/6hsuVFmSFVrPYDHxgjXHY1TqSFeG6ZR0R08ZYF4ueHDjqU8UuvD331Vt4qpmyxx6Nl/mnGpBbFTnBLmlS6TJhML8aXxNuDnWxFAFcXG5B6UizdRU0c6sLg8R+OpMKF+s3xr6mgUnVtVIA5cv+bSUMs4tIscPYtNsbAkutwGLo7mo0fnoXW6F+Fb5Kit7BAm5lxcy2mXkCYylfOIgfIR4rsX1MdGzqof1PCYcUe2l+IUpIT+5a2REmBc/OAPI+H4PkQ4Yd5/emb/eKiC5Qf36B2kngugvpztrk0/Su5sJQmIaMkQXVXdzshqXjfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJXPfWZO2tnS6TioG9/H0fswKfkJWTXZb/a1ChqVc1s=;
 b=FLA0TdcuAsxc94c9ZhALJ1hJL6JOO7FySZqCkSO+/J9NLMtti0eQ7r2CdEQmVgu5Z403Xwv546YuYRYNAFMNWf9BBS3LIvlmjvhX8e1aEcQidKUZA4eWqVEGihr2saEf7QA7cA6+9njLCGZfUsS9x9hJF6wf8IEUVRjSerbBbkbJROzcbzk+JqS6x5HB1/JN+DyB5ZyblgRnptr4F/RQunHAdDbvcsAPWTfWX9OZUfoYSynxeT3+p72HBsXbpVmO+G31lLbyEzjC+f+Cr1dhZA9QA/zeTUqdupqymr7xLL6ZJ2byPFiryOzjPo+NPdqbaPTh/1dTRD6fYAd/eOvCQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJXPfWZO2tnS6TioG9/H0fswKfkJWTXZb/a1ChqVc1s=;
 b=pImOQnUCVLzcxfpqCw1/3ihv7gDzCuR+aZlXpTuab/BBALJOrtXl3TLrbuluDOuo3/eIV/C44G0jKS3EJMBjHPJ6Qu42AcXQkK+ARooZoI0p2DEJ6KnHSLkiiIVIHpLCJPVSbDEsy2ntmXYr+gFkbO81abjLLgcmsE6a1o+ga1zwKafV+jQf7ag9JPXqYeZBmRMrPVIr+L3WL1aJArbgBt7IS148mLgwxm9G+Xxav5vB6SRrMOFgTLr85P/cWqjAY0bmLp59KWSdLZljbBPhwvdb3pdtp5Kk5pFLFjrm4yMASBBWBIkLthJf23azbzi4pADCNoPG4EDaf6MjC5MxZg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Mon, 28 Sep 2026 08:43:17 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 08:43:16 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 28 Sep 2026 17:42:44 +0900
Subject: [PATCH v3 5/8] gpu: nova-core: add NVKV decoder
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-b4-nvkv-v3-5-f04504c262c2@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0050.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::19) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CY8PR12MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c64b694-5e68-4614-6757-08df1d3c8a71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|376014|1800799024|366016|10067099003|56012099006|5023799004|11063799006|921020|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: c8eCo+2T8SvpInwjyMPna0FV4z8a/J76BoWd9kTHWLHNzt3fyF32Y9/z/t7EEfalMNNrlfU5eY3NdQ7eZkvqJY+qH/oS9xT8wfbGNKGp/bq5TSbm084PTGtQU4VNeKD2s3es0KVSsebjGQWmxuSLvB+L5g3Kh11bkJBrmeAN6uVMauxpWZ9W/fAAiu4lwntPFzxlx0qQW4Q9BY2ImaL54Aio012kb7G5Alpqln45smb164riVAqOPD3afnto/ktmB6Ku36ABvITVsSacxazaVIYoeTyDhKq0mjl/5Ri3yfREsiqAWbSf7VArBkvt1qMgn4l+wsy9LXrs5d/pRKwq4VCdfXBzrjbBWCubk939gdZObNQmn/rP2IulLX+pgkGeRuru3qEsqCg50b+z0GIC+eHjAB75rvauM9AVFJ/36coLOb5FhQAnWD/d9y/6nzMQ/TtBPE6rQKFseQJhbp6yWPDFw2zid8T10uo2pMFTYxWJin3faYv0+xk0bWSc9ivTk6Cgqp+ctEiG6u67G0vtroBrPjq7VjGYiiRmCkbPjJO4bmdKGCICzTtCon3SBMpShM1l14jwGmz9/hZfQrSbkwmTYOOSoBdX2H9PiOOKYI+45H/El5yrIuf0OscG0wgK4Ja6uQgzlywsq3RQAyI8OBK8kLYr4jkAw9cfgXT1fcKDK1xs3Toe87WRrcVFowSLPDHze8oZ+LugywJP30FeVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(5023799004)(11063799006)(921020)(3023799007)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WElGV0xKZUpPTk9aTjlEV3Z1T3lkeWlidU81bVZYOFFoYWN6WVB3RlBtZFk0?=
 =?utf-8?B?NkRRMVMzZitmZHQwWGNzYjVKOUJmU0lVZ0k1VUxyNWdWak1yT2FpcVpGODUw?=
 =?utf-8?B?YTRJSkRka3puejZsRFdkeDVtaC9VVllrWWJTd3Nla01MRlh6akJmcE5PcnpZ?=
 =?utf-8?B?VVdUa2hRV0c1dlh1QjlUMnZyWUtteVhPOC9wWTFvZHZmVGkwSUxYRW9hdUZY?=
 =?utf-8?B?K3N2Y2MvQUVMdTRqNzdBdGcxMklZSUtmSlMvTk1YaytObytha1NwcU41SkVq?=
 =?utf-8?B?Zk44bTlCdGhQb3NvdnZqTDk5ajIxbzJZWlhKZUxBNmg0ckp0ZGpWTXN0TmlP?=
 =?utf-8?B?cCt5a25GYi9qUU9ieW9JOThUZXJidjdybHpQYWJpam5DcGJVUDQ1bU1GcVgr?=
 =?utf-8?B?RmNnbVF4NWYrbG9Yb042NklPRDVudUY5Qzcxd0VoRFJqQTNYOERLNEdYTWdW?=
 =?utf-8?B?RmdoS081UDlPS0l1KytoVWlVa29pdVJoZ2NTSXFQd2c3RmVUYXZmN2pPVy9J?=
 =?utf-8?B?NXhrVlpFbHRqVVMvWXMzN0RUZ3VmVkxYdGQra2pjUE5aWmlockFNR0FPQWcr?=
 =?utf-8?B?Tm4rSGNVanNNbDhaR1MwTjR6WGNwcVVTeFFTSEU0QlRSYnlqQzBnSmNORHFG?=
 =?utf-8?B?WjI3b1cxek9IV0ZiNXZoSXYxWGRaK2tGcXhFeTV6WmhRNjY3eVFDMElkVkkr?=
 =?utf-8?B?dHp6ZmZVRlBQUndQOUNHVitnaXV1dmFiTEV1ZHo1cVl5WEtXQXlvTlVlcjhq?=
 =?utf-8?B?bzBvR28zK09uMm90cWZmSTArUmlSQUZieWZncDlENDlzaEF2QWx5YnNsNXdr?=
 =?utf-8?B?REdvcmhURTRYMmxIdHRCMXR2TU9GUWF3WXd5UEZFTVZURUJzWmpTRzlWUENz?=
 =?utf-8?B?RFduWE1lTEZmSHlUalF2TkxtY20xYjRITllYbmhCeUFiMDR0YXUrSVlPRkpk?=
 =?utf-8?B?dmUrdWwxMGRFTURXMU01RkhGakxWU2hpS2tRZ0FLT0ZRNWQvR2srVmptWkw3?=
 =?utf-8?B?K2hGbHJxVDdwRVNla0VTMDlidjZ4dTVsMzV2K2o4Y3UzNEhXV0FmaDNPdzc2?=
 =?utf-8?B?dU96SHJvSGl3YzNQOWZDZW1VZG1BTmZ3RTBFVk5lL21IUEFNT3lIemttc1hN?=
 =?utf-8?B?cEZLWjJoMHIyTFZzOEY0ZlZRNzM4SEMxRzkyUGIxNzBOQ1Rob1A5NGUyWDJa?=
 =?utf-8?B?RzYvQ0diWE5ZakRvbHpQZkRZVFl3ZVRXdHphb3BtbzdYRVE2UjdVR3ljUEs1?=
 =?utf-8?B?MTdoRmwvcDU5ZEdCTXZpaGY5ZGhmd2pYdmdLd28wSVpyTnVwUjZhSHM5a1JH?=
 =?utf-8?B?NmsyL2trL3lzN285NWR6WEMvN2JYZEQ3ak45OXlNOWdYVEVjZllXTVZnVDNE?=
 =?utf-8?B?MXhTTXdCQ2dyRUE0SnBodmNEK0Y5NWIyaEFkYVh3V3NUU3hrZnAxNWd6QS92?=
 =?utf-8?B?RTIzdUFEL3hGYlhPd25Cc0RydVZ3VnNwbm1kQnMxb3lGVGdwT0J5V2dZQXRZ?=
 =?utf-8?B?ODBYL29oelRSZ3llOVhvZ25XR3c4Qi9oS0s2OVVWWks0QUszRzlFYVBpekZK?=
 =?utf-8?B?N2E2Vy9ISmk5REpwenVkdHQ0eWl5Q0NqUGVnVzZjNVpBOHFNay9TOTdQNTJW?=
 =?utf-8?B?SlJ4M0cydFBEQ2ZCcXJ2clRrS2RUMVR1U1U2VmVxRUo4SjlzTGVMaHVkZGw5?=
 =?utf-8?B?aEVqcnZsek9NODlKUkJVcWdZV3dYN0FMOVV6d3BiOStETmJUUWF6a1pSL1Yx?=
 =?utf-8?B?NVU2MFUyaXNhM2p1SFlzQnI4TTluZlkvVFRYYWFOUnV4N2h0QWdMTE5NZHNG?=
 =?utf-8?B?TWEwdGpjejNkMVdDRnFrNzlNKzdFRHl4MTdYWTVHemY5WVc0T2ZUbXFvWHls?=
 =?utf-8?B?SERrZXUvR0VsaVIyUEdyUlc1MWMxc1RLaGttNXNzdnVuamgvd1ZsSXdReCtI?=
 =?utf-8?B?NXRMWlhESDg3YVRROTl6WnpVMDdrejlyOFhKVXBlaW8yKzFESnh0RHpEQUxp?=
 =?utf-8?B?TGVDb2NNWEJKOFlvOHpFc0RPeVpBVGtkbDhIWWN2RjFrNGtQcWlIMVBFdFZq?=
 =?utf-8?B?UnpkQ3RUT2lDRlRvVit3UUFZZkVBUDRUWG5yaUluYVNueU9rSkZVOStHSExo?=
 =?utf-8?B?NXpCYzJLMFVZbmVrWGYybHpOSUl0VjFSQzZBSUhnaXc1bHFJSkhqVUpaR0lK?=
 =?utf-8?B?QURvYmgzQTlTVG1zaVpxVVF4Vi9Oa0EwTFM1TFF5N1NkcUl5UkkzWHVRRTBj?=
 =?utf-8?B?d0xFUUIvTklYV1E4TVBYUlkzR1ZzMlozZ05ZZnRtZzhNUCtlNmFEcXhyYnNN?=
 =?utf-8?B?ZzQzT0tSWU1Db3ZBb3JyWUdwd2N6MlA1VldtTnpJWlZCc1dmbkN6MWwzbkpp?=
 =?utf-8?Q?24BB9G18cesNV6V0IMdwYBvofhaShBSSWDvJ3thhFI7b5?=
X-MS-Exchange-AntiSpam-MessageData-1: c8j55njV5znM9A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c64b694-5e68-4614-6757-08df1d3c8a71
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 08:43:16.8823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5fb1r/Dn1WO7A/FKLhkXfG+szjKEb8ll2xsKtFo03a7JJKJlmzOQfT08+P5qfxC6tm8Ee8imn3SMBujPhVuuw==
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
 drivers/gpu/nova-core/gsp/nvkv/decode.rs | 487 +++++++++++++++++++++++++++++++
 2 files changed, 490 insertions(+)

diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gsp/nvkv.rs
index 0957dce92f96..10f7a16ffc23 100644
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
index 000000000000..c4c24fe1108e
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
@@ -0,0 +1,487 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+#![cfg_attr(not(CONFIG_KUNIT), expect(dead_code))]
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
+    num, //
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
+    /// Returns an initializer that creates an empty schema in place.
+    ///
+    /// Use [`KBox::init`] for the heap or `stack_pin_init!` for the stack (if sure that the value
+    /// is small enough to fit).
+    fn init() -> impl Init<Self>
+    where
+        Self: Sized;
+
+    /// Returns an initializer that makes the decoded `Target`.
+    ///
+    /// After the returned initializer runs, the schema should be empty again.
+    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_;
+}
+
+/// A visitor that consumes decoded NVKV from a stream.
+///
+/// A schema that doesn't need to borrow data from the stream can implement this for all `'data`
+/// lifetimes, avoiding having to carry the lifetime parameter. A schema that borrows from the
+/// stream directly should implements it for its own lifetime only.
+pub(crate) trait Visit<'data> {
+    /// Visits one decoded pair. Returns `Ok(true)` if the schema consumed it.
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
+        let values = self.take_u64s(count.div_ceil(8))?;
+        values.as_bytes().get(..count).ok_or(EINVAL)
+    }
+
+    /// Takes `count` 32-bit values. If `count` is not a multiple of 2 (`u64` size), bytes are
+    /// discarded up to the next multiple.
+    fn take_u32s(&mut self, count: usize) -> Result<&'a [u32]> {
+        let values = self.take_u64s(count.div_ceil(2))?;
+        <[u32]>::ref_from_prefix_with_elems(values.as_bytes(), count)
+            .map(|(elems, _)| elems)
+            .map_err(|_| EINVAL)
+    }
+
+    /// Takes `count` `u64` values, or fails with `EINVAL` if fewer remain.
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
+        // The output type of the hand written `Schema`. In this case, we can have it also implement
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
+            fn init() -> impl Init<Self> {
+                Self::default()
+            }
+
+            fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
+                Ok(core::mem::take(self))
+            }
+        }
+
+        impl<'d> Visit<'d> for RawSchema {
+            fn visit(&mut self, key: KeyId, index: Index, value: DecoderValue<'d>) -> Result<bool> {
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
+        }
+
+        let mut encoder = Encoder::new();
+        encoder.encode_u32(SCALAR32_KEY, Index::new::<0>(), SCALAR32_VALUE)?;
+        encoder.encode_u64(SCALAR64_KEY, Index::new::<0>(), SCALAR64_VALUE)?;
+        let serialized = encoder.finish();
+
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Error);
+        let mut schema = KBox::init(RawSchema::init(), GFP_KERNEL)?;
+        let decoded = KBox::try_init(decoder.decode(&mut *schema)?, GFP_KERNEL)?;
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
+        let mut schema = KBox::init(RawSchema::init(), GFP_KERNEL)?;
+        assert!(decoder.decode(&mut *schema).is_err());
+
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Ignore);
+        let mut schema = KBox::init(RawSchema::init(), GFP_KERNEL)?;
+        let decoded = KBox::try_init(decoder.decode(&mut *schema)?, GFP_KERNEL)?;
+        assert_eq!(decoded.scalar32, 0);
+
+        Ok(())
+    }
+
+    /// Records each visit as (key, index, value), for tests on hand-built streams.
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
+        let index3 = Index::new::<3>();
+        let data = [
+            // SEQ32 with three values for three consecutive keys, packed two per `u64`.
+            Op::zeroed()
+                .with_key(SEQ32_KEY)
+                .with_opcode(Opcode::Seq32)
+                .with_value(3u32)
+                .into_raw(),
+            0x0000_0002_0000_0001,
+            0x0000_0000_0000_0003,
+            // SEQ64 with two values at a non-zero index.
+            Op::zeroed()
+                .with_key(SEQ64_KEY)
+                .with_index(index3)
+                .with_opcode(Opcode::Seq64)
+                .with_value(2u32)
+                .into_raw(),
+            0x1111_1111_1111_1111,
+            0x2222_2222_2222_2222,
+            // A zero-count sequence has no keys and is skipped, as in NVIDIA's decoder.
+            Op::zeroed()
+                .with_key(EMPTY_SEQ64_KEY)
+                .with_opcode(Opcode::Seq64)
+                .with_value(0u32)
+                .into_raw(),
+            Op::zeroed()
+                .with_key(EMPTY_SEQ32_KEY)
+                .with_opcode(Opcode::Seq32)
+                .with_value(0u32)
+                .into_raw(),
+            // A zero-length array is visited with an empty slice.
+            Op::zeroed()
+                .with_key(EMPTY_ARRAY8_KEY)
+                .with_opcode(Opcode::Array8)
+                .with_value(0u32)
+                .into_raw(),
+            Op::zeroed()
+                .with_key(EMPTY_ARRAY32_KEY)
+                .with_opcode(Opcode::Array32)
+                .with_value(0u32)
+                .into_raw(),
+            Op::zeroed()
+                .with_key(EMPTY_ARRAY64_KEY)
+                .with_opcode(Opcode::Array64)
+                .with_value(0u32)
+                .into_raw(),
+            // Three bytes padded to one `u64`, then three 32-bit values padded to two `u64` values.
+            Op::zeroed()
+                .with_key(ARRAY8_KEY)
+                .with_opcode(Opcode::Array8)
+                .with_value(3u32)
+                .into_raw(),
+            0x0000_0000_00cc_bbaa,
+            Op::zeroed()
+                .with_key(ARRAY32_KEY)
+                .with_opcode(Opcode::Array32)
+                .with_value(3u32)
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
+        let bad_opcode = Op::zeroed().with_key(KEY).into_raw() | (6u64 << 28);
+        let streams: [&[u64]; 6] = [
+            // 100 bytes need 13 `u64` values, only one follows.
+            &[
+                Op::zeroed()
+                    .with_key(KEY)
+                    .with_opcode(Opcode::Array8)
+                    .with_value(100u32)
+                    .into_raw(),
+                0,
+            ],
+            // Two 64-bit values, only one follows.
+            &[
+                Op::zeroed()
+                    .with_key(KEY)
+                    .with_opcode(Opcode::Seq64)
+                    .with_value(2u32)
+                    .into_raw(),
+                0,
+            ],
+            // Three 32-bit values need two `u64` values, only one follows.
+            &[
+                Op::zeroed()
+                    .with_key(KEY)
+                    .with_opcode(Opcode::Array32)
+                    .with_value(3u32)
+                    .into_raw(),
+                0,
+            ],
+            // A value count with no payload.
+            &[Op::zeroed()
+                .with_key(KEY)
+                .with_opcode(Opcode::Seq32)
+                .with_value(1u32)
+                .into_raw()],
+            &[bad_opcode],
+            // Consecutive keys that overflow `KeyId`.
+            &[
+                Op::zeroed()
+                    .with_key(KeyId::MAX)
+                    .with_opcode(Opcode::Seq32)
+                    .with_value(2u32)
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
2.55.0

