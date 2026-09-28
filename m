Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04374C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50D6310E8D3;
	Mon, 28 Sep 2026 08:45:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="YgXSH4t+";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010006.outbound.protection.outlook.com
 [40.93.198.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F223610E8D6
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:43:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzbuxHd3l9y6uK/zoG96Hp2/qnRMVoZJNFS5HsJDCGH6phbggo0ThjULwt6verZ7/dJShDVtej3A+cMaMHpoIyV8lJRynpU0odOTJlZvoPctM7LS/ApyxOm9pTj/EX1AlMh0UqQ+6KIZ3O8ZjfKS79enXddkgCGn8O/8g5eltU0gtVR//CBHiBBvQCo84ZqjaXjOoU+YEy+PEWt+cJsz8MUo1kvKfJT9H+tvOtquPbT+sWtwMYutkgKsw+KUR0BycssbR0MPG4osQseIqcY774ivodkUIggXecZYycLs3nT96PdzfWECcGfY+O2fhxNLNUSa0FrwdRJDgCmj+hvG3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPvWgihL7fEhHo5k3POKQuKPjUBzSdgtOP/AJiVJhTk=;
 b=vF9cOYBhJMoY70iGWH1ujZXqZYXQwkcahKJMh9e7rY6eWQB0Di6pQ1V2kBSk9MM42If2Iz+d6fAxrBlVl3Rv4XiBpcu9RErHIQQR8fpu0WovL6awkfAP7CsIxionTPzje3hTCqI8wzPugfNgyX0mo824wex7fR/vcExu9D+wyZcVDMWJIxPLq6gSvVPt04S1eyfLqqcQTxoTAXW3Ip8P9m4VXIBN9+YoH+eHDM6O//AHNRDGb3PbZ3z8I7fo1LGR+DMwhQBJ8JaSf3zR6794eELb4EAexn9eu+Rp9W9XFe47B/l0M830cQaLDF9/EauYvMvvqhftF1fofuMHqdbjLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPvWgihL7fEhHo5k3POKQuKPjUBzSdgtOP/AJiVJhTk=;
 b=YgXSH4t+8Oca/byemLyP2fIDC5dB34WbWFcJGQLZGjG8YbgrvEFkP3yW9L1QfjjBDtG4GV+A36CzkWKGoITEX9Usl4EWC5Q5OmJWH/Gw5KEEj0Ed03B2VQFSIJpFvvJSkigJr0lm1XWATmExW0Vk9/rJImQj3/7FMJpHFHQxJrWwSEcumAh8jnB8ZlEdopjSGULDWtSGHECelYEKlqXLUfEPHXHbflsTgQXnG4ALtRvTOke/9LeZnAZM+oLm6g+UPaffVMLhV78oldDzAu3+he4w0OnJp8rxXUfnvsBalRtpLMlISQipAIhKtEStQrj6HQpApfOnWvIVvzqjwaLoEQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Mon, 28 Sep 2026 08:43:23 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 08:43:23 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 28 Sep 2026 17:42:46 +0900
Subject: [PATCH v3 7/8] gpu: nova-core: add NVKV typed decoding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-b4-nvkv-v3-7-f04504c262c2@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0364.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::8) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CY8PR12MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: f56bfd0a-5db4-4978-9c50-08df1d3c8e60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|376014|1800799024|366016|10067099003|56012099006|5023799004|11063799006|921020|3023799007|10063799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sNYnZBWB3NU6vck3YukWzPErPrddlSYjzWusn1pq5JO+ZZUyr0tSNK52I9b8xVjVxK+T9sLpZBe2FykxrL3IdqhBIlMaVi8EsWWVFRjyvGEF6vjfazi6zQR466QRyCGI4PtCVrjH9ySearCcYUKdgaF2J6LC/dwWRlmIlkI/751+fmihciLHxU75RiFKRnPTkcmwXRurTp+5ZNVD8Em7kx3kpv4y49pUat6rXQl5NmboWHtzWOqp7JQa+isOZdcOnFeQ+0pr4PIRh/cuE3kTyWMC2eahili/t8QbwuV9S59Y93RFAWXT3qjFJ+jyLSXwifd+zTWnCZIs751wZnS9cF4nyt7SYo/fdr/oCIbHw026dDjUTl9fLKtQLMg+279Go/mAeN1Kqqj6N0mQJRA2BWv/nK6G0kddusvsMTdSaT3P3gTUo++6o2iji98CDNYV8PV9ZXq92LPQjLPVyD6NqVMcW5ktS7HmyTsXCZXHps/AgjQ9YZqfao7qrZYZy2UrqTURw3Cy+B6DTMCg3PTWZhA7RLpShhVYwLjyhK6ZF9t28YIEzdeAJajk4nb4NNHhZ14jXV5eQByKYDJSHZy2SD7Nas6OZpiNT8FXhwTsbmfaMZa+8N+9zVFZNprlKjW034bDzy5PKp+6bZhGcTzi2IkDtLYcXp36QHq6j7iwJcWGRrZDfug9sZW0hoaXjT78Sa9nIlRGT9acMkWryMn3kQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(5023799004)(11063799006)(921020)(3023799007)(10063799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDZET0tPZGJnbkMyaEoyazVnUXJ0RkJmOFg0RElkM1JJaGhSN2d1WEV4QlBt?=
 =?utf-8?B?VE5xa1F4TGZxOWNnMmNTYkJ0ckJONFpDaWpFaVY2c2VuYWFPNFJha3ZHRG51?=
 =?utf-8?B?QjlOcG01Y2VjQ3o1MEpGRjBtaTY5Q1YrL2NNbjBTdSs4MUtsSW1rcEY1WGJV?=
 =?utf-8?B?WEludWFicTNzVDdkMXg0WHJyZ1Y2REoyWVE5d25ucnc1TGVreEFLUTBrS3Rj?=
 =?utf-8?B?bHV0NHo0M3h2KzNVeitPVm8yUXMxWCtMZXU2QUJIdTVyc3ZydksxSWpRWVda?=
 =?utf-8?B?L01qNm5CeW0rQlBuK3U2K2VXcW4zQWZyREhqZHIxUTI1dFVRVWRLNzNjM282?=
 =?utf-8?B?bDdjUThRalpJODltRmcyeCtEaTdMbjlabWlVVHpVbmJ2ek1OL1NFWU8rWFhS?=
 =?utf-8?B?QUpYa3VxV2pkeHJ6RmRYOFlEdEtyUE5EVGgzK2ZQN1F1b1liYUx5YVN6cGk2?=
 =?utf-8?B?Q2hDdUMvY1VFeDBBZzZodEdHT3hFNk1FNGROcUtQRVhTeThUb29iMjZZV2du?=
 =?utf-8?B?cHovbWlwbGlZY3hNTmNTRVAxVlQwTDhqRjNua252REJkS2tobFdtWm9TYkpr?=
 =?utf-8?B?cmlUYytjWHRyQ09rMUN5dk1LcVNwclpXL256OEpkK3E2L2RtU09LTk9FNW0v?=
 =?utf-8?B?bTNEbHgvTDc0djBtaGwzVlFPOXpOZ05KMXNERFBBYWIvcUFpTDJZd1QxTlpq?=
 =?utf-8?B?WEV6eWFiVmJvRi96VVIzTU0yQWlzYWJqVzR0YXc2MjV5VkVLL21oWmpOSnlG?=
 =?utf-8?B?aDVHVEhoTzVseFpJU0hEZjhlenBwa3RiR3lpdmUwM3FEc1FEdGp6cWFRQnJZ?=
 =?utf-8?B?OWN0emJoMzArOVJSQXptaElIOVJJRzNzREZsTTBieUZiQngyeWJ1ekFhMmgy?=
 =?utf-8?B?RmJtbUJYNGlsSUZDSnJJOVdpa1BrWkNTMFA4eW0vemZITGlCMlB4VEUzTFlK?=
 =?utf-8?B?SmpwZGNsRUlBRTlFeDV3S3pPTWFFSlV6MHQ5bWtvMUVOU3QrM1FBcVRiZ3R4?=
 =?utf-8?B?VFNsYXZDdTJCeXVJSmIvUVV4N3NUbE41T0c2czlQalQrVVlUVVltMmp3YW5X?=
 =?utf-8?B?VDRvdWxTRHM1V0ljaGtKdi93OU55b2NVWHM3NEVKczBoaGlVRGI5TVJpNmpE?=
 =?utf-8?B?SmJRQzNtMmQ4RzFJaDJ4SFU4WUhDNjh4aXA0UUYrMllldkkrRmRxeWt5aVRV?=
 =?utf-8?B?eldBRkY2Uy9sUDRCVmdGei9KM29OMXJMenF0b2RlNTRQRVhUVWp5cFZQZnBP?=
 =?utf-8?B?NDNrUUVzdnl0cEF2cG5qV1c4YnJ6UU9sNnhUK1ZJSi9hOGtWU0p0L0dDU2Fk?=
 =?utf-8?B?NTlscERMSUxFbU9SN2lEVU5LcXdDWFlXL1NIRG5OSUZzcm5QTmZDT2g3T0ps?=
 =?utf-8?B?ZUxuY0lvWmYxMDU1b0FjbWJyZmkzd3VZTXlOc1ZqcVBCc2ZyK3BKSHFUakFa?=
 =?utf-8?B?bW1CcGJiY0FvNnhBQ2FraGZ3RGo4aGw1Z05xRXh1NWdUdlJ0bjdpMm9XN1Vq?=
 =?utf-8?B?dzFyeDJEaGxDU2Vob0k2U2l3WnU5M1RvR1VIc1dOcmFkaHZMaWZKaW9XeUN5?=
 =?utf-8?B?OGJDbjJNbllQRXM0ejNQWDNtTlhUZ09MU3E0S2ZhekJqQzFYbUI2QWc5SnVx?=
 =?utf-8?B?eGE0VzRjK1dxMXpEbFpHb1psb2d2K3gvK2NsaFN1Q0RqdUJBK0Y4bkQyWDk1?=
 =?utf-8?B?b2NxOHdzYXVwMklWdVJzS0JHMlpkNE5ocU9EVlRWSHdqNmdoYVdpMWhURDRT?=
 =?utf-8?B?bmVwWHp5YW5INmFNQVpmcGxEUEpucEp5TGdUWG1HUDZLYU94ck9hNTdFQU5P?=
 =?utf-8?B?V2M4VURnUFpHMWxjWmFzR3EwdmU4eGQrZVdiU1BuRVRrdHNVNlRqZjZvNFFN?=
 =?utf-8?B?U3JERnRFbkNPN3dINVo2L1U5YUFXSFRrck13RTllaDFERXhKTWlrcEFSdGRn?=
 =?utf-8?B?VGU2Nkt4Mng0b3lzQnZPUzMreFRGZTlJYWVFbmxpNUFKMWNBckVOWkFhME9B?=
 =?utf-8?B?aHBNU2VqNWNFYUNtVW0xT2I1bVhkTEl0NXlMb0RrcS9tbjcyL2lWYVhCdk1l?=
 =?utf-8?B?c01LNjhoNHB2eVlRYzJJa2FyWTdmeVZrY2ZBUTB2L0RGUUlTcEJ2ZDFKQXFu?=
 =?utf-8?B?eHBielVPc01rUzU5WFZoZzlkVytabzIvekpsNkNKZ3RnUmF3aUtUWG56R0ZT?=
 =?utf-8?B?MksyakNvTm9qc2RrZDlnSUhQWWNRaGx5OWFEVFd2aURWbmdtZjdrMldIRER2?=
 =?utf-8?B?NTBIVWdRMHFsZVVHc0JQeDhRSnlUb0w2V1laNGNEU3c5RTgvcjZqc2hxK0ZM?=
 =?utf-8?B?YTYrSXN3TXpURW81dEpLNUZmVE1paU5qRkc2U2YzRWFWQ2pxaWFWY3kza2R0?=
 =?utf-8?Q?FCsgW1n0DPWymJAb4LsUdY8yKYOWXRKb21+U36J+IsA1O?=
X-MS-Exchange-AntiSpam-MessageData-1: 1MUAkrmJikU2WA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f56bfd0a-5db4-4978-9c50-08df1d3c8e60
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 08:43:23.6202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/uWwwNABmqQjyv/kfMHxUIIZ4mEoVwK1zmD9B2fqXUOo61OoqRYpmkR2V+x6fwtriu88snhJZvUjsIbq1VoSA==
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

Similar to the typed encoding layer, add some decoding type machinery.
Add a simple macro `nvkv_decode!` which implements `Schema` for a struct
by composing visit calls to each member. Add some common `Schema` kinds,
such as `Array` which collects an array value into a fixed maximum size
array, and `Required` which fails a decode if the value is not sent.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/nvkv.rs        |  11 +-
 drivers/gpu/nova-core/gsp/nvkv/decode.rs | 622 ++++++++++++++++++++++++++++++-
 2 files changed, 628 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gsp/nvkv.rs
index 7ac3a459a98b..5791df07a7fa 100644
--- a/drivers/gpu/nova-core/gsp/nvkv.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv.rs
@@ -9,7 +9,7 @@
 //! function calls will map to some struct - for example, f(GPU_NAME_STRING_KEY, 0, b"some gpu")
 //! naturally maps to storing a &str with the GPU name.
 
-#![expect(unused_imports)]
+#![cfg_attr(not(CONFIG_KUNIT), expect(unused_imports))]
 #![cfg_attr(not(CONFIG_KUNIT), expect(unused_macros))]
 
 use core::{
@@ -23,7 +23,8 @@
 use kernel::{
     alloc::{
         allocator::KVmalloc,
-        Allocator, //
+        Allocator,
+        ArrayVec, //
     },
     bitfield,
     num::Bounded,
@@ -148,6 +149,12 @@ fn default() -> Self {
     }
 }
 
+/// A schema field for an array value under the NVKV key `KEY_ID`.
+#[repr(transparent)]
+pub(crate) struct Array<T: Default + Copy, const N: usize, const KEY_ID: KeyId> {
+    vec: ArrayVec<T, N>,
+}
+
 bitfield! {
     /// The op word that starts each NVKV operation.
     struct Op(u64) {
diff --git a/drivers/gpu/nova-core/gsp/nvkv/decode.rs b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
index c4c24fe1108e..24dad31296cb 100644
--- a/drivers/gpu/nova-core/gsp/nvkv/decode.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
@@ -3,11 +3,22 @@
 
 #![cfg_attr(not(CONFIG_KUNIT), expect(dead_code))]
 
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
+use pin_init::init_array_from_fn;
 
 use crate::{
     gsp::nvkv::{
+        Array,
         Index,
+        Key,
         KeyId,
         Op,
         Opcode, //
@@ -15,6 +26,353 @@
     num, //
 };
 
+/// Defines a schema struct together with its [`Schema`] and [`Visit`] implementations that decode
+/// into `$target`.
+///
+/// Each member of the struct should implement [`Schema`] and [`Visit`]. For every (key, index,
+/// value) triple decoded from the NVKV stream, the generated parent `Visit` implementation will
+/// call each member in declaration order with that triple. If a member consumes that triple, it
+/// will stop there. Otherwise it will keep going until all members are tried.
+///
+/// The schema struct holds the state required by the schema implementation to do the decode. It's
+/// recommended to use one of the existing Schema kinds (`Required`, `Accumulated`, `Key`, `Array`,
+/// `Indexed`) for each member.
+///
+/// Use a lifetime on the schema struct if you want to borrow data directly from the encoded stream,
+/// for example, `Key<&'d [u8], KEY>`.
+///
+/// # Examples
+///
+/// ```
+/// nvkv_decode! {
+///     struct RequestSchema => Request {
+///         id: Required<u32, 0x0001>,
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
+macro_rules! nvkv_decode {
+    // A schema which doesn't borrow from the stream. The macro uses a generic lifetime for the
+    // [`Visit`] implementation but not for the struct itself. This allows omitting the unused
+    // lifetime on the struct.
+    (
+        $(#[$attr:meta])*
+        $vis:vis struct $name:ident => $target:ty { $($fields:tt)* }
+    ) => {
+        nvkv_decode!(
+            @impl ['data] [] $(#[$attr])* $vis struct $name => $target { $($fields)* }
+        );
+    };
+    // A schema which borrows from the stream for lifetime `$datalt`. The macro connects the
+    // [`Visit`] lifetime with the struct lifetime.
+    (
+        $(#[$attr:meta])*
+        $vis:vis struct $name:ident<$datalt:lifetime> => $target:ty { $($fields:tt)* }
+    ) => {
+        nvkv_decode!(
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
+            #[inline]
+            fn init() -> impl ::kernel::prelude::Init<Self> {
+                ::pin_init::init!(Self {
+                    $( $field <- <$ty as $crate::gsp::nvkv::Schema>::init(), )*
+                })
+            }
+
+            #[inline]
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
+
+impl<T: Default, const KEY_ID: KeyId> Schema for Key<T, KEY_ID> {
+    type Target = T;
+
+    #[inline]
+    fn init() -> impl Init<Self> {
+        Self::default()
+    }
+
+    #[inline]
+    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
+        Ok(core::mem::take(&mut self.0))
+    }
+}
+
+impl<'data, T: TryFrom<DecoderValue<'data>, Error = Error>, const KEY_ID: KeyId> Visit<'data>
+    for Key<T, KEY_ID>
+{
+    #[inline]
+    fn visit(&mut self, key: KeyId, index: Index, value: DecoderValue<'data>) -> Result<bool> {
+        if key != KEY_ID {
+            Ok(false)
+        } else if index != Index::new::<0>() {
+            // Single values being set must be at index 0.
+            Err(EINVAL)
+        } else {
+            // Overwrite and take the latest value here.
+            self.0 = value.try_into()?;
+            Ok(true)
+        }
+    }
+}
+
+impl<T: Default + Copy, const N: usize, const KEY_ID: KeyId> Schema for Array<T, N, KEY_ID> {
+    type Target = ArrayVec<T, N>;
+
+    #[inline]
+    fn init() -> impl Init<Self> {
+        init!(Self {
+            vec <- ArrayVec::init_with::<Infallible>(|_| Ok(())),
+        })
+    }
+
+    #[inline]
+    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
+        ArrayVec::init_with(move |dst| {
+            dst.extend_from_slice(&self.vec)?;
+            self.vec.clear();
+            Ok(())
+        })
+    }
+}
+
+impl<'data, T: Default + Copy + 'data, const N: usize, const KEY_ID: KeyId> Visit<'data>
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
+/// A schema field for a key that must be present.
+///
+/// `finish` fails with `EINVAL` if no value arrived for the key.
+#[repr(transparent)]
+pub(crate) struct Required<T, const KEY_ID: KeyId>(Key<Option<T>, KEY_ID>);
+
+impl<T, const KEY_ID: KeyId> Schema for Required<T, KEY_ID> {
+    type Target = T;
+
+    #[inline]
+    fn init() -> impl Init<Self> {
+        Self(None.into())
+    }
+
+    #[inline]
+    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
+        (self.0).0.take().ok_or(EINVAL)
+    }
+}
+
+impl<'data, T: TryFrom<DecoderValue<'data>, Error = Error>, const KEY_ID: KeyId> Visit<'data>
+    for Required<T, KEY_ID>
+{
+    #[inline]
+    fn visit(&mut self, key: KeyId, index: Index, value: DecoderValue<'data>) -> Result<bool> {
+        self.0.visit(key, index, value)
+    }
+}
+
+/// Expects objects specified sequentially with index starting from zero.
+///
+/// This stores two `Schema`s which are initially empty. A `Schema` is expected to be complete when
+/// we get the next index.
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
+    #[inline]
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
+    #[inline]
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
+#[repr(transparent)]
+pub(crate) struct Indexed<T, const N: usize, const KEY_ID: KeyId, As = T> {
+    slots: [T; N],
+    _as: PhantomData<As>,
+}
+
+/// Copies `elems`, converted to `T`, into `slots` at `start`.
+///
+/// Fails with `EINVAL` if the window does not fit in `slots`.
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
+    #[inline]
+    fn init() -> impl Init<Self> {
+        init!(Self {
+            slots <- init_array_from_fn(|_| T::default()),
+            _as: PhantomData,
+        })
+    }
+
+    #[inline]
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
@@ -51,7 +409,16 @@ fn try_from(value: DecoderValue<'a>) -> Result<Self> {
 impl_try_from_decoder_value!(&'a [u32], Array32);
 impl_try_from_decoder_value!(&'a [u64], Array64);
 
-/// A visitor that consumes decoded NVKV and produces a `Target`.
+/// Lets `Key<Option<T>, KEY_ID>` accept whatever `Key<T, KEY_ID>` accepts.
+impl<'a, T: TryFrom<DecoderValue<'a>, Error = Error>> TryFrom<DecoderValue<'a>> for Option<T> {
+    type Error = Error;
+
+    fn try_from(value: DecoderValue<'a>) -> Result<Self> {
+        T::try_from(value).map(Some)
+    }
+}
+
+/// The state of one NVKV decode operation which produces a target value `Target`.
 pub(crate) trait Schema {
     type Target;
 
@@ -65,7 +432,12 @@ fn init() -> impl Init<Self>
 
     /// Returns an initializer that makes the decoded `Target`.
     ///
-    /// After the returned initializer runs, the schema should be empty again.
+    /// After the returned initializer runs successfully, the schema must be empty again. For
+    /// example, this is required by [`Accumulated`] which finishes one object and then decodes the
+    /// next one with the same schema. Implementations generated by `nvkv_decode!` meet this
+    /// requirement. If the initializer fails, the `Schema` can be in a valid but non-fresh state.
+    /// Taking `self` instead of `&mut self` would avoid this contract, but it forces a copy of the
+    /// schema onto the stack.
     fn finish(&mut self) -> impl Init<Self::Target, Error> + '_;
 }
 
@@ -295,6 +667,133 @@ fn visit(&mut self, key: KeyId, index: Index, value: DecoderValue<'d>) -> Result
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
+
+        nvkv_decode! {
+            struct PairSchema => Pair {
+                x: Required<u32, X_KEY>,
+                y: Required<u32, Y_KEY>,
+            }
+        }
+
+        struct Pair {
+            x: u32,
+            y: u32,
+        }
+
+        nvkv_decode! {
+            struct TestSchema => TestDecodeable {
+                scalar32: Required<u32, SCALAR32_KEY>,
+                scalar64: Required<u64, SCALAR64_KEY>,
+                array8: Array<u8, 64, ARRAY8_KEY>,
+                array32: Array<u32, 64, ARRAY32_KEY>,
+                array64: Array<u64, 32, ARRAY64_KEY>,
+                opt_present: Key<Option<u32>, OPT_PRESENT_KEY>,
+                opt_absent: Key<Option<u32>, OPT_ABSENT_KEY>,
+                pairs: Accumulated<PairSchema>,
+                slots: Indexed<u32, 4, SLOT_KEY>,
+            }
+        }
+
+        struct TestDecodeable {
+            scalar32: u32,
+            scalar64: u64,
+            array8: ArrayVec<u8, 64>,
+            array32: ArrayVec<u32, 64>,
+            array64: ArrayVec<u64, 32>,
+            opt_present: Option<u32>,
+            opt_absent: Option<u32>,
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
+    // Tests that a schema too large for the stack decodes on the heap.
+    #[test]
+    fn decode_large_schema_on_heap() -> Result {
+        const BLOB_KEY: KeyId = 0x1400;
+        const BLOB_VALUE: &[u8] = &[0xab; 100];
+
+        nvkv_decode! {
+            struct BigSchema => BigDecodeable {
+                blob: Array<u8, 2048, BLOB_KEY>,
+            }
+        }
+
+        struct BigDecodeable {
+            blob: ArrayVec<u8, 2048>,
+        }
+
+        let mut encoder = Encoder::new();
+        encoder.encode_array8(BLOB_KEY, Index::new::<0>(), BLOB_VALUE)?;
+        let serialized = encoder.finish();
+
+        let mut schema = KBox::init(BigSchema::init(), GFP_KERNEL)?;
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Error);
+        let decoded = KBox::try_init(decoder.decode(&mut *schema)?, GFP_KERNEL)?;
+
+        assert_eq!(*decoded.blob, *BLOB_VALUE);
+        Ok(())
+    }
+
     /// Records each visit as (key, index, value), for tests on hand-built streams.
     #[derive(Default)]
     struct Recorder<'d> {
@@ -484,4 +983,121 @@ fn decode_raw_words_malformed() -> Result {
 
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
+                x: Required<u32, X_KEY>,
+                y: Required<u32, Y_KEY>,
+            }
+        }
+
+        struct Pair {
+            x: u32,
+            y: u32,
+        }
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
2.55.0

