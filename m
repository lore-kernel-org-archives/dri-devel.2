Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8B7606A88D
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UUnb5zr5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA8EA1120B0;
	Thu, 12 Nov 2026 12:39:09 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010038.outbound.protection.outlook.com
 [52.101.193.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4EEB10E403
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 12:39:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ul7J/a5AymJfMaf7VvGepm6z5Kkn2lczcgmdjPa87k8pkE3qe9kNULHxeXZ4cU1rienLy+LQaK+aVokYzr/va7YCQuuj307SHDx2/FEQlUaTcyzgamqsMAQsphFk/F7RapaUy/ZEPLJoqvm106lbD3ZFXz4oR5unWlC97ExaR8/ut9VkUD6AcBf4Z3tRFNfKSkP/LC2YZi1rcmKDaXxF2ye+yV9enPgpCpM00g1DoFu7z7kco+QPoY5vzI2r4yqWB6bE46kTFrd+Oz4DsyWDprufqdZia1UosNmEqXR23uLqF2JBHbdCFyiuXXZZ1ffNU/uD2WEJydk7lvRPnE1Ikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNPnymYnORIC15vqHFbXKXXt0kQA4/nJoUBhP55I0Do=;
 b=JjYYrSv0y3rrqgd6tq4eTmjCUce8F0NYMbwHpcX3AchVhOqCbEF1xDB33K8BbhEW3963RGQSkzj/vfuo77txmfwj80g5avJKSHG14SHBkvaxIi3OzSESQ221UHXt6gcHiWfEY+dFv0y9lV3dP/A0ppFyAZ0fg64hLCOl3nSYQlLTncbmxPxfYjgpWPGaksGHrY9CGwkIU1xCTdqpQYowjl4bQkRby9ke1XzwZ6Hp2ZuRXWOj9EBZRWaX1DicLYLmG/h7e9xOLwRoVt5oNI/SF9oIhT1Q31IvMrpYgXeWbkI1C5+z6yj0J5kKUr0f7p4mH52TrGiLGq2M2QXhaEOJmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNPnymYnORIC15vqHFbXKXXt0kQA4/nJoUBhP55I0Do=;
 b=UUnb5zr5JQdxxgQoaBo144mQXdraxQmRhnZF87rK/6TcGG36fyQtVQBpaWSW4n0V/MJZQlWsgeN6boLtiW3jHIvyQ4MVbCA2Arsp9nNj05ND3MvGhAFnByEFqyI16zPwbLmgLBGsann0LcMxHLOfjbqLwnsqKJEe/Uuqd+kZj1mlLfid1KsgYlFcTVKTvzKaT39fKieALtmd72SAq6oOS2V47dyNoTD2syraZm9bsgrlBx/FC5D/2Kg2jGKKuLBtyFxvD6Q0MmdisjouXWCR9ul17U7wPxx2qpDhPnLHeKBPjN3B6fZ0+euZ2dccP3G6f3ohXMWKJc4DyM8BGXv8Vw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA5PPFD911547FB.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 12:38:53 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 12:38:52 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 12 Nov 2026 21:37:13 +0900
Subject: [PATCH v12 2/2] gpu: nova-core: add ChannelIdPool
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-chid-v12-2-49ad43286dad@nvidia.com>
References: <20261112-chid-v12-0-49ad43286dad@nvidia.com>
In-Reply-To: <20261112-chid-v12-0-49ad43286dad@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P286CA0025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::7) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA5PPFD911547FB:EE_
X-MS-Office365-Filtering-Correlation-Id: 87761a31-a67e-4c45-4078-08df40b9e8b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|366016|23010399003|1800799024|56012099006|11063799006|921020|22082099003|18002099003|10067099003|261102123227099003|261022105027099003|261022113327099003|261021121427099003|261022075727099003|261028144727099003|261026140227099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: tvbMYKe8Gj7pkN96PMMw5ofYqHAnT9U+TBB4ESLShR5r6MCF45a4FCAEuS6F2YkIj94RUIzCKxprA9Ydy9fhesXOKoxntWodXInCR0Mrr9UQG5lIw99XdGoJDZWVDFKPLJO9EPXuYMytVHQcs9hZVpTZvZFt08tXfDaIcVYoWxfek2kLrLZp15qNso8ISuPoU7aB8XXYoPyu5yT2qok3cHKVJpnYOpd/sTnpinJAlz4k4xrpmmAZM6YEWenHym5G9YlhZNWo/bcati7jtkohaOPbxxzA56/Kq76o418251l8geVrey3b3/u5t81yWSM1z4tkGp2R+1Dkdq8xpRim0jPP5aSaQgpuxYlScGAEJKU4nymZqiFzm3dKS0Nu1K6+zlGK/As+045YWzVUwGZe5/wgxSJgPR4NXWlgOBmjKRmgvZZpX56hbMGm7ErfQX4FbClIi4t6JIUGf6A0y/4fFnxgBdrM4x+3nYML0gC+LcXxJl2YMlmkje7S6tfa6+aiIS7Ts5wjpuztpcXBZ6WESYEPYh5/+A3wWppf8Ay/qM4Tb1zxlENKa4hRc9SQ/CyNXMCW+TqkY+pg+ikZ5ShdDIywaZ/dF8n2i87a+DHWPbcs5AseJhwaJfCEZbCWmOnR+ke6qK6q0DzX8qRqGeJt5msD4IdGOKrXibrraCpYmxqRu8RrcT/4sP+Kple2WnYBsgJO4m6i7o74N/rKVlhglA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(366016)(23010399003)(1800799024)(56012099006)(11063799006)(921020)(22082099003)(18002099003)(10067099003)(261102123227099003)(261022105027099003)(261022113327099003)(261021121427099003)(261022075727099003)(261028144727099003)(261026140227099003)(261026121527099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDNkOWVOM0tDY0lxVFdkSFhQVG1hOElueUN6RStPRlIyVkxBOVU1TEtmQVdI?=
 =?utf-8?B?dVN3MEJZM0k5dnVsTWNBakhVNiswQkNLZ2hTRHNzMU00Qm5MTkVONlljcjB1?=
 =?utf-8?B?QkJCYTY5U3ZyN0t4QmZSMGUwSUFyVTkwRTRIS0xjM0k0VWgxOEVVdWpySytM?=
 =?utf-8?B?aFlhWWhMWUN3SXhDN0wvUE9keFlMT3hTdDNvQVV1SnBlTFhlYjZaWjdFQTJ5?=
 =?utf-8?B?T3llNlZjQWZoR3Bmd1Y3QlJvalpXVzFJRVplSVBBNDFIaWZ1SmJQL2x1dmJk?=
 =?utf-8?B?c1p5OWRSYjdJWmlUNEtxS0FIY1I5VmtxYk1HZDd6M1RSL3gvaGVFN3dweUVq?=
 =?utf-8?B?a1lvdzQ0U1hlaTNBdk01dDF1VitmM3Z3QTY5L1pHcE5yYXJ2eExBODVPblAv?=
 =?utf-8?B?cnp6MC9OZGVjUlM4NnczZGUxamkxQ3pXdEFnNXZDRzFMQW14NXdGdkJqblF4?=
 =?utf-8?B?MlkxRCtrdjdzeklIb3VSaDc3cmtxVkVwL1ZpdFMvNXlUdnhHY1hVTjVxOEx3?=
 =?utf-8?B?SUZNUU0vMFlMdmxYdUpOZWV0U1RCREIwbjJWTGNnUjRIWGJUSFUxOUVxQm1L?=
 =?utf-8?B?QUExSk5KSmVVc3FWbXQrV3psQnBaVmE5NHRUYmtuaDYxU1BsTFdMSWJqOXdJ?=
 =?utf-8?B?RmRTVU93ZEQ3b1MxU3VtMVEvcUovNTExbnIvRmNjME9veHgxdFBzd014TDFh?=
 =?utf-8?B?Vis3QTQwWDJRVS9iUW5qQmJudWl1d2NocjY4QlF5RVk4T3NMMGFjVTlhUVpQ?=
 =?utf-8?B?YmczZ1dIS0l2V1phRTIzdW5ETXVPNkM3TkwzLzkzK0twdkFYMElJa0d3UW84?=
 =?utf-8?B?ZUhsaGptbmxYbFhYbG5oUXZ0VnJXZjFad3RjT3l3UnlYdE8yeWw5QStoRCtV?=
 =?utf-8?B?ZkNPQVRoWlRmMWlWYVpFRnRIVWVBSjI0T09HaWZsckdQS1duaTRrVjBwUThZ?=
 =?utf-8?B?bkFTVnQ0ZXFHcmE0U0srdFlYMVJhY1F0YTdWZGMzMy96cDdMcnVIRTFSeVdl?=
 =?utf-8?B?ZmJvQ2wxUmRhWDFLUENoa0tjSm4zQTZBVzZEem9OV0h2V3Q1TW9uY3RJY0xn?=
 =?utf-8?B?MjM0eWlhTjduTGNCcjBIWjAyUituem04TTVYY0k3THVqaVh1ejJUd1dRRjZy?=
 =?utf-8?B?bkw2SzNlc3NMUUtTc0dxNmxCdmpmUHJoOTBMYUFVelFaQTl5T1hXZmtseU5X?=
 =?utf-8?B?bGNld201Z0ZzRHRmYkZuMGFRS1J6MWxLYVE4WW5CeEhFbE5FN0RLNDZtMU5L?=
 =?utf-8?B?cmlxSXI2bFkxc2VZNGtRT01xYXQ5MHVad2F6QXY1RVZEUkYzY3VCdkRaWlIx?=
 =?utf-8?B?eXV4QjZyMkxJNW05Uk50cE5WT3JKUzc5S09rSFI4OTJ3VkNhaVBoZHNzUjhp?=
 =?utf-8?B?aVhqM2s5V21OalpJVlB2UWxNV011V0RBNFJ1eG1aT2tnR2M4RTBIYy9QUm1F?=
 =?utf-8?B?MXMwUjc0Y0k3K1BnMS9xSHdhWmdQYTVQaHNlTEtVWmJVTTdocThVNEV2cWtj?=
 =?utf-8?B?VEk0N3NLYVRXMGRaZDBuK25kLzYxZVNUc3lCWHIxMFBSSXdUY09KUWJWa3Q1?=
 =?utf-8?B?S1l4NGMzYjBKNUM4RUZnVWZFYWxPMExSMnFjQUFRMndIVlRzekhIMjlRTXRZ?=
 =?utf-8?B?aFZIR0kwa21PYWorYzFtR3BTVWsvSi9lNHpXYjhheVR5OVNtdExkS2RKdC9D?=
 =?utf-8?B?TWF0cE9aeWc5Lzc0c085dFQ2aks4blB2dWdTbi90bjJrOVB1WW00eXA1empL?=
 =?utf-8?B?SW5NOVhiWE9kOWZMc1d5S3FWSXdBVUpTbEpuR3BiV3VZbFA1L2JjZ0Z2d1lq?=
 =?utf-8?B?RTl3Vk9paWxQYmRQa1MvakVXT0JKamE0WnhXOEJ2RjhuRThSRHNsek9sZEg5?=
 =?utf-8?B?UkNwQk1HK0RocThPNEticDV2ek5zVW1zK09zZ3BlejJDdkNLbTJmNDRVMk4y?=
 =?utf-8?B?TGI1bmNaeHpxdUNjWm01ZElCaHVWVTB2ZVI4MW5jT24zYzJRVTd3U3JmeHIy?=
 =?utf-8?B?clZYM0ZCK0xrdzUyYWtESnRIYUlkT1J4THNiYUp5bTZQNFJOelMvTHJVajht?=
 =?utf-8?B?N01jaDhzbW5pUno2QTZOR3ZGMm9HVmNGcCsvMGlqa29oYVNHSWxGUVIvbFhW?=
 =?utf-8?B?VHR2TmZheGl1eTRDSmhwQVNEZ3VyQlV1bVNuNURyMWVhcm1jV2JxUFJSNDdm?=
 =?utf-8?B?QlJSM04ycENmYytiUzZ1VkZEM1F1S2V2bzNrQWczdXFHZ3k0RHVJSXBGd3RI?=
 =?utf-8?B?T0JVaWx5YTROK1cwejE3OE8wQ2p0TGk4MmNrcFlYMjM5MU9jVzBtK3B6Njdq?=
 =?utf-8?B?THN4N3dDYWo4cEtZQ1IzTlc4ZDA1UmNxMk1hTXBQMWp0NnFxTDdLY2hwUC9B?=
 =?utf-8?Q?i9gTIkKbXuEQ3+Wi4LtWpYW2xfMEDe//Ry84rLZ58M2Fv?=
X-MS-Exchange-AntiSpam-MessageData-1: vVuG+16Jezl6XA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87761a31-a67e-4c45-4078-08df40b9e8b2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 12:38:52.8673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IU6o2fz+LR2Tb+CgCXS8gwXMP4ejcvvTjEGFS+SNpbndCA7bwOso4wyVwzQPKbkuf/UZVHaD/PNJEbBPD5Ntzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFD911547FB
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add `ChannelIdPool` which adds automatic tracking and releasing of
channel IDs on top of `IdPool`. This is necessary for apportioning
ranges of channel IDs to be used in e.g. vGPU.

Channel IDs are allocated as a contiguous sequence with a specific
length and sometimes a specific alignment [1] for vGPU. The ID space is
small (limited to 2048) and allocation is not on a hot path, so a
bitmap-backed `IdPool` is a better fit than IDA/xarray (which allocate a
single ID within a range, not a contiguous sequence) or a maple tree
(where aligned allocation needs an alloc_range()+erase() retry loop that
essentially reimplements bitmap_find_next_zero_area()) [2]. It is
also faster than maple tree [3].

Link: https://lore.kernel.org/all/84bc8bd2-e292-4b84-9580-a1b5df4c5bdc@nvidia.com/ # [1]
Link: https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@nvidia.com/ # [2]
Link: https://lore.kernel.org/all/20260717053241.916441-1-ynorov@nvidia.com/ # [3]
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs         |   2 +
 drivers/gpu/nova-core/gpu/channel.rs | 198 +++++++++++++++++++++++++++++++++++
 2 files changed, 200 insertions(+)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index d185e927233f..90b1d24cdf00 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -53,6 +53,8 @@
     vgpu::VgpuManager, //
 };
 
+#[cfg_attr(not(CONFIG_KUNIT = "y"), expect(dead_code))]
+mod channel;
 mod hal;
 mod regs;
 
diff --git a/drivers/gpu/nova-core/gpu/channel.rs b/drivers/gpu/nova-core/gpu/channel.rs
new file mode 100644
index 000000000000..485efaba059d
--- /dev/null
+++ b/drivers/gpu/nova-core/gpu/channel.rs
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Channel ID allocation.
+
+use core::{
+    num::NonZero,
+    ops::{
+        Deref,
+        Range, //
+    }, //
+};
+
+use kernel::{
+    id_pool::IdPool,
+    prelude::*,
+    ptr::Alignment,
+    sync::{
+        new_mutex,
+        Mutex, //
+    }, //
+};
+
+/// Pool for tracking reservations of channel IDs.
+#[pin_data]
+pub(crate) struct ChannelIdPool {
+    #[pin]
+    inner: Mutex<IdPool>,
+}
+
+impl ChannelIdPool {
+    /// Creates a pool managing `num_chids` channel IDs.
+    pub(crate) fn new(num_chids: NonZero<usize>) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            inner <- new_mutex!(IdPool::with_capacity(num_chids.get(), GFP_KERNEL)?),
+        })
+    }
+
+    /// Reserves a contiguous area of `count` channel IDs starting at a multiple of `align`,
+    /// returning a guard that releases the area on drop.
+    pub(crate) fn reserve_ids(
+        &self,
+        count: NonZero<usize>,
+        align: Alignment,
+    ) -> Result<ChannelIdReservation<'_>> {
+        let mut ids = self.inner.lock();
+        let range = ids.reserve_ids(0, count, align).ok_or(ENOSPC)?;
+        Ok(ChannelIdReservation { pool: self, range })
+    }
+}
+
+/// A reserved contiguous area of channel IDs.
+///
+/// Releases the whole area back to its [`ChannelIdPool`] when dropped. Releasing locks a
+/// sleeping [`Mutex`], so the area must be dropped in a context that is allowed to sleep.
+#[must_use = "the channel ID reservation is released immediately when unused"]
+pub(crate) struct ChannelIdReservation<'a> {
+    pool: &'a ChannelIdPool,
+    range: Range<usize>,
+}
+
+impl Drop for ChannelIdReservation<'_> {
+    fn drop(&mut self) {
+        self.pool.inner.lock().release_ids(&self.range);
+    }
+}
+
+impl Deref for ChannelIdReservation<'_> {
+    type Target = Range<usize>;
+
+    fn deref(&self) -> &Self::Target {
+        &self.range
+    }
+}
+
+#[kunit_tests(nova_core_channel)]
+mod tests {
+    use super::*;
+    use kernel::sizes::SizeConstants;
+
+    #[test]
+    fn chid_reservation() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(cv!(2048)), GFP_KERNEL)?;
+
+        let first = pool.reserve_ids(cv!(48), Alignment::SZ_1)?;
+        assert_eq!(0, first.start);
+        assert_eq!(48, first.len());
+        assert_eq!(48, first.end);
+
+        let second = pool.reserve_ids(cv!(48), Alignment::SZ_1)?;
+        assert!(first.end <= second.start || second.end <= first.start);
+
+        let first_start = first.start;
+        drop(first);
+        assert_eq!(
+            first_start,
+            pool.reserve_ids(cv!(48), Alignment::SZ_1)?.start
+        );
+        Ok(())
+    }
+
+    #[test]
+    fn chid_reservation_drop() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(cv!(8)), GFP_KERNEL)?;
+
+        let a = pool.reserve_ids(cv!(3), Alignment::SZ_1)?;
+        let b = pool.reserve_ids(cv!(3), Alignment::SZ_1)?;
+        let c = pool.reserve_ids(cv!(2), Alignment::SZ_1)?;
+        assert_eq!(0, a.start);
+        assert_eq!(3, b.start);
+        assert_eq!(6, c.start);
+
+        drop(b);
+
+        // Only have space for 3 IDs right now.
+        assert_eq!(
+            Err(ENOSPC),
+            pool.reserve_ids(cv!(4), Alignment::SZ_1).map(|_| ())
+        );
+        let b = pool.reserve_ids(cv!(3), Alignment::SZ_1)?;
+        assert_eq!(3, b.start);
+
+        drop(a);
+        drop(c);
+        drop(b);
+
+        // Everything was dropped so the pool should be empty.
+        assert_eq!(0, pool.reserve_ids(cv!(8), Alignment::SZ_1)?.start);
+        Ok(())
+    }
+
+    #[test]
+    fn chid_bounded_by_num_chids() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(cv!(4)), GFP_KERNEL)?;
+
+        {
+            let a = pool.reserve_ids(cv!(1), Alignment::SZ_1)?;
+            let b = pool.reserve_ids(cv!(1), Alignment::SZ_1)?;
+            let c = pool.reserve_ids(cv!(1), Alignment::SZ_1)?;
+            let d = pool.reserve_ids(cv!(1), Alignment::SZ_1)?;
+            assert_eq!(0, a.start);
+            assert_eq!(1, b.start);
+            assert_eq!(2, c.start);
+            assert_eq!(3, d.start);
+            assert_eq!(
+                Err(ENOSPC),
+                pool.reserve_ids(cv!(1), Alignment::SZ_1).map(|_| ())
+            );
+        }
+
+        assert_eq!(0, pool.reserve_ids(cv!(4), Alignment::SZ_1)?.start);
+        assert_eq!(
+            Err(ENOSPC),
+            pool.reserve_ids(cv!(5), Alignment::SZ_1).map(|_| ())
+        );
+
+        let head = pool.reserve_ids(cv!(3), Alignment::SZ_1)?;
+        assert_eq!(0, head.start);
+        assert_eq!(
+            Err(ENOSPC),
+            pool.reserve_ids(cv!(2), Alignment::SZ_1).map(|_| ())
+        );
+        assert_eq!(3, pool.reserve_ids(cv!(1), Alignment::SZ_1)?.start);
+        Ok(())
+    }
+
+    #[test]
+    fn chid_reservation_aligned() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(cv!(16)), GFP_KERNEL)?;
+
+        // Alloc 0 so the first fit for the next area is unaligned.
+        let pad = pool.reserve_ids(cv!(1), Alignment::SZ_1)?;
+        assert_eq!(0, pad.start);
+
+        let a = pool.reserve_ids(cv!(4), Alignment::SZ_4)?;
+        assert_eq!(4, a.start);
+
+        // The area skipped over by the aligned allocation should still be available.
+        let b = pool.reserve_ids(cv!(1), Alignment::SZ_1)?;
+        assert_eq!(1, b.start);
+
+        let c = pool.reserve_ids(cv!(8), Alignment::SZ_8)?;
+        assert_eq!(8, c.start);
+
+        // Only 2 IDs left.
+        assert_eq!(
+            Err(ENOSPC),
+            pool.reserve_ids(cv!(4), Alignment::SZ_4).map(|_| ())
+        );
+        assert_eq!(
+            Err(ENOSPC),
+            pool.reserve_ids(cv!(1), Alignment::SZ_32).map(|_| ())
+        );
+
+        assert_eq!(2, pool.reserve_ids(cv!(2), Alignment::SZ_1)?.start);
+        Ok(())
+    }
+}

-- 
2.56.0

