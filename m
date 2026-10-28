Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7179606A337
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 02:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=R53rI5SE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D780910F95D;
	Wed, 28 Oct 2026 02:22:01 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64A8810F952
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 02:21:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkgPE97gCfc3hJueLuLdFJHUIgLW5nSFEbS+jniuGP6mOHvQ6ptWiMSvAw4n26pcvJg3jA3pjV5ekCZAA9lAxLbWcVbo9kcqhZv6TX9n6bN7v1iB0pIbm8xeyucIAGlkOCUNaCGXBts9mqtUdQ4Ex2tWrgse6W/9TbO6inWA3hvEQW4eDZuENeHqs1GRRGT77xXk87SPNfgSA1DlHJR7bjWv3wOHBIlJwsuY9OxE3OZVQSAFY9OJGqO288hWZ5yVl86LCoZzbvutp0Foqfm0QfVCbTwX5I4J9mdCCX1vNHM0bBAY/WljE9VCZqDY/CzQht4x1+m4gMhF1hy+NRlmqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIJiwXRzioP/OeSdvygpUVqAIU+ViY45TopPnN0D+EQ=;
 b=v4Ok2yCfZDjUAnA8OC2KJlUp4389dgzVr4bfh8f3gv3QtFqTBGmj+TkrkpGX9eguaUKp8QixFu186dyD8wtRk0wRf0w8PpVLZd2U0q5ySnHj3FHIa2RGuaqzdJm3nJZUoE6DbPOX4tRuXbt+QtdG0wTlXLn4/uUQlXLBrjgm3koSxiEB0us5q9EChQAZNRdC6SZcjQeBg/CHxOXiY9LU784CIycKsftW9RUiopcMCTnebb6dE3bUK/5o/ttNcTK+jjG6Y7tFzCiaZQZ/28SnQYkz26n5q9itunQWZsf1AhoEVdxe7lax2Olra4qYLXEvQa/9k1GLiNeZ5pMm6Cmqmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIJiwXRzioP/OeSdvygpUVqAIU+ViY45TopPnN0D+EQ=;
 b=R53rI5SE/wHxqnIOHgvRgBpPknajpbiRU6bZZuF3dAk9zIVlycKdCjQ4zRDUAVcGt8BEmsF43+kH8TTeGiidVBGA0BclJ7KJ1i6DRiwgGGB7MGX123L5U5qJRdNEsB9HMH2Z6sFePwdYzbjqvhfTU9YXM0ABpCTV80tOYMNBKsjpDxV0MubyS36jG9J897kAYJqMTEtG0CjUZX5YUVSrgweVx1KQ5cVPZl51si3XmFOST0M5y3PdLj6921f2jsyMTcoSHebx6k6R/nRbze4wQyEFo5IQnllf8d4wQzTPLQbZpl8AwrSrO6sPyGNtkUNZCYWrzKM/48rkrROJUC+NRQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Wed, 28 Oct 2026 02:21:44 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0546.016; Wed, 28 Oct 2026
 02:21:44 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 28 Oct 2026 11:21:03 +0900
Subject: [PATCH v5 4/7] gpu: nova-core: add NVKV decoder
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-b4-nvkv-v5-4-ef78909b513e@nvidia.com>
References: <20261028-b4-nvkv-v5-0-ef78909b513e@nvidia.com>
In-Reply-To: <20261028-b4-nvkv-v5-0-ef78909b513e@nvidia.com>
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
X-ClientProxiedBy: TY6PR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:405:3bd::13) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CH2PR12MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ad1eb6-3380-460c-19df-08df349a354d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|10070799003|366016|23010399003|921020|11063799006|5023799004|56012099006|261022113327099003|261009223027099003|261022105027099003|261021135927099003|261022075727099003|261026121527099003|261021121427099003|261026140227099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 7dPYX92ZzQiw1IpQ4laagLsoZhLijvPgmg6pndXGebDom2R8JPnIGEemQIbXaNrWx35gjk3ng9ZzjMp7aSURNYM5TmMMqjvhhuiDfQ7o0C3UDTft0/RomRYb5EP3AkwMQNKlaMWcdDthtCSsw/WXnCe1KvuXlp6fz5OErdXzMC5hBjsGlkewMfKEqc01yz9/zTo6lf5pxi8XL36b3EDCTYiJWHCnEOJ+l8uxUNLXPR4q+/Zy6VvV4xwflfui4HZ2MtJyWoSMfeGkBtncZnu96aH4dOCMWWYGKwBNbNKwsesk1Na1Vr7daTwyvM4ZMR2V/jzIurruUNRx9jO/8n9NxjZwC7UVFh35gJKzYJdDQV2yw0xzj85pmLGWfov2E1oXnip0oYuIBFl3w5B1RWmitjcHN9UaZIdajPMITTfJqGKAT8IIqe2yHCgV/0rwfSiw1agEVqb7GVhBhbQNDTGDhy/CISpKrCChHiXCqYcowZaQLb/ZRs/Of6dYhicdys7epF8cJDnJ1EF+uFliHAG8fuzJwnjw8lJs6Z91VuHeDlDooJqtXFzb6+dCzkUQfokIJlYhq+HzhLxu2x3JshQVjGPxhULQnaz7nIQHxmII29Yzz1Wvg6HSaRTgAquRawNBJIMCYRhwelyf7qRW639wOJmzptA8fwIZzl4ofOUvnebKi4c1D/VXTGlC4qhD83j9G9LeuoPuzdK9GbpH/wJY0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(23010399003)(921020)(11063799006)(5023799004)(56012099006)(261022113327099003)(261009223027099003)(261022105027099003)(261021135927099003)(261022075727099003)(261026121527099003)(261021121427099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjZscEdFZmxFdGtjS2xCNHFhU3pqUUdpQ0JianMvVitZK0dKbmNVSnZiaDU1?=
 =?utf-8?B?LzRBRUdrMTkxRStsVks1Q0xYVlVyT3JBNFoyTnNQcU5OTytVaU1KdjlOZzYz?=
 =?utf-8?B?QmgwTHpQMXNRc2NtL2JFOFE2L3FJMzZjQmxmeUJjQS9xaVdyK0Z5VUpoY3Y1?=
 =?utf-8?B?MmZDRWl2Um9oeGpBWnZDMm9zRVdiQXNsSXRURFJjK1c2WFY4eWRoSFV3OXRR?=
 =?utf-8?B?WnJRWWR5S01idWpZZVFsM1R0TUpQWTFCRTdVcCsrMm1UQm9HU0RoZUY4d201?=
 =?utf-8?B?NE5sbXg4c1VOTHdvUWxRa3VmUS9ob3k2TFVDVHR1WHlLWUdSWjZXd1lkWXkx?=
 =?utf-8?B?RnFSVVFMZld4RVNQSnBTV0YrR1hPM3hXN1NLUndieDVKVlN5Qk1IdU1zMFgy?=
 =?utf-8?B?QzVvMDBWYkhVYmZuMkpWUHV5VkY2Q1Q3U0gzRldmSjVSMHI2ZnlVekhvbU9V?=
 =?utf-8?B?K0dXejdYSDFIZFFPb0VTWFJucUt3L3VuSzNqSEt1ZHdrMFlvMVBXem5PS3Iy?=
 =?utf-8?B?T3BnNjJ6QmhuYXlHWGxvY1dmSW1la3F2bUtuTlpzNmhVbEdmTjJrZlRxVVRZ?=
 =?utf-8?B?clEwdnJhS2s2V3VMR2NyeEdhd3JSa29nTkM0bnc2VDB0czNCSGk4OGRVUHBF?=
 =?utf-8?B?Y0swbzEzZ2orTEFHQzRZNGlMVFF1QjhoN3NtRkZ6UEdvN2wrMkp0M1Q2a0Mr?=
 =?utf-8?B?WkczcUpmaURaQnlHUnphNElqRDBpbVRrS09GWFVlbUhyU2xCUHBZeGdzT3Ew?=
 =?utf-8?B?cFdORVdlbTRTZFlTNG9zeHUwQUJtQW9kbi8xQWRId28wUnlCaW5kaGkyM1N2?=
 =?utf-8?B?aTRqMmphQUZ5eFQ0QW15aFJ4VWZzYndYbWtjR3doaTgwcXl0Vk4vUHJVTE1r?=
 =?utf-8?B?cDgxeGJKdHFtN3Btc24vZkVmNHcxUnNBOXVVakVad0dCUlhHa2JJQ0VLazZJ?=
 =?utf-8?B?N0VMbno2YVZrK25iOFVhMHBpeFNQZzFjeVFLYTJiWmlSSHRhRTBYYWFUUGQ1?=
 =?utf-8?B?dWE2Z1ViTmI5bVJKYTFmWFB3V1BLaWI4WmcxTVE0Ym5RVFpoanl1dXppVllL?=
 =?utf-8?B?K1k3aXdhL2FSRGxUUW9wajJRaE5tamM4YWRKd0tFVVk5VFl3QndPRGY5NytC?=
 =?utf-8?B?WDJVS3hzK0lBMCtqbmMzTWE1Mk5rY2NYWDduaTZXNFJFZTB5OVdSUzloR1hx?=
 =?utf-8?B?WWJDZUZGVjd1VW00QUNtNVR2QWdpTXZ3UHg4b2JEY0FkZ3Fhd0w0U2pFS3Mx?=
 =?utf-8?B?UFRnT3pVbUppUm1tb1Y0VFVDd1VCZjdiYUJGRHdMa1NMRFdTQlkvbkx4a1M1?=
 =?utf-8?B?aWlqTlBaMXZFSStBeFZBQlRsL1VCWjBpMzhGbXh6a1VobVdQL2luanR4RWlu?=
 =?utf-8?B?S2sxK2U1d01kTWxSS1E5Z2ZmYzV2a1JQREFzTFhUZGNFTXVPTG1zMzBJQWpv?=
 =?utf-8?B?cUVkSHRPaytJT2owRFFXeTJpcWlYQ0Vla3lmb0JPaTR0SXVCaVhiQi9qNnRy?=
 =?utf-8?B?bFJmMHptdm40cXYrWEZERTNhdUpRSit3Rkg1bXByalltRy9VdmtzZWx1eUVV?=
 =?utf-8?B?K2dCWEJKZldrRTc3djdvcG5teFIxU3FaNWpiYW8xK2pMd1d2NkVlUTU2UEQr?=
 =?utf-8?B?M2VCMjUyRWN6WWF4K2ZZTjYxNEtzVXhrdFJTY3VBU0RyTHY0d2dhWjhscnhy?=
 =?utf-8?B?QVBreUx2RzIzK2NXZ0dOTGs3T3dKT2lhUUlnTUI1S2RZYWN0MHA3RVlOeG5a?=
 =?utf-8?B?cE5Zell4blM2V0FmTkZ4aWpmci9YdGJ0RWx3MFRFNU1COENBMmw0STRmbGFC?=
 =?utf-8?B?R0wrVkZCc0lkUUw1TzlhUU9Uc2VDWGhrbUtvc3o2SUVkMlZjOEZiR2tGbGJv?=
 =?utf-8?B?L0tBQmlPYmRjelMyQ1lBYkdZVk5HVDFRT3J6TTVjS3JIKy9VYTVGK29FZTZL?=
 =?utf-8?B?M1RqT3RZNzdXV2MrTFhqQ2hYa2g5R2d0WlpqOFhzNDNwZlBSOHNnTGQyclli?=
 =?utf-8?B?THdWekxUamRSMHZBbmxUdnk0VjJma1FnU0kySGdoS0tQTmFjcDlFMXdyVnE3?=
 =?utf-8?B?bFdQUUFjOEpmNFJJMWdGcjFPY2tJdUFrWmQxQVk0akJPVEl6YU1KaC9vVEdp?=
 =?utf-8?B?NkgzM2dWbHFpQ0NKNHVpWVVwREhaZHA1MjgxRXpyWkRPMTZ0YXFpekR4MjM2?=
 =?utf-8?B?YjhaTU9wYisrRTNzOFpWRE1ueGo2clRwTUZMNXVKU1ZpZFNwS2p1dVZETURJ?=
 =?utf-8?B?S3Q2Z2Y0ZjJ0eFFrVzlpY2ZSSVZ4TDVTZ1pzN1RaMGlVeXQxQUFIOWd3YXE3?=
 =?utf-8?B?c1hRRnFqWUdwbGhyYncvU08rVXd2dkhuRGVxamJzQUN1WWdmdmN5THFFOU8v?=
 =?utf-8?Q?n4X1Gpa4I6+Z1mAQpYGy3S199TIpgfda5RXCQc0qc1aWx?=
X-MS-Exchange-AntiSpam-MessageData-1: 6Jj8WfrePEkhHA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ad1eb6-3380-460c-19df-08df349a354d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 02:21:43.5141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CFVSfbBsNgCtPHJXjOqrSx9VY8LyZUXftaj63e2RM1hHNJWqO62IlKxnNYpbL6fNtOv2KtMNnAvZaAE8pbtkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a decoder for NVKV. This is for receiving messages from GSP for
GMCAPI calls. The NVKV format essentially encodes a sequence of function
calls f(key, index, value). This decoder reads an encoded stream and
invokes a type implementing the new `Schema` and `Visit` trait. The
`Visit` trait can either consume the value or not, which is useful for
composing schemas. If a (key, index, value) is not consumed, error out
depending on `UnknownKeyPolicy`. Whether ignoring unknown keys is ok or
not is per each GMCAPI call.

Add kunit tests for the decoder.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/nvkv.rs        |   3 +
 drivers/gpu/nova-core/gsp/nvkv/decode.rs | 503 +++++++++++++++++++++++++++++++
 2 files changed, 506 insertions(+)

diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gsp/nvkv.rs
index f1e63e6c4927..98c5c31c3717 100644
--- a/drivers/gpu/nova-core/gsp/nvkv.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv.rs
@@ -21,6 +21,9 @@
 mod encode;
 pub(crate) use encode::*;
 
+mod decode;
+pub(crate) use decode::*;
+
 /// The identifier of an NVKV key.
 pub(crate) type KeyId = u16;
 
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

