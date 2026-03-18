Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8AAFCD0CE
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2F8210E6D4;
	Wed, 18 Mar 2026 08:06:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="grASQdtC";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011024.outbound.protection.outlook.com [52.101.57.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB2C010E71E
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 08:06:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwsskYWKy/NDHYcTJ9eL++aTyKxWOmCKQ/44EeaIpUEaVlfEX+5XAkxsf0Ai7Bx/GAreaoLqPja7Kl2vbR9JK0oEQlN3V1xOF+/k3jDfgxQxqVhN2MoC9axLSuVfnwJelJJTRy4t8MOjCmbs2lENgv/1d4kZrtE1B6VjiZVKYCtnqoyvgspmRJt5n0s1WsafHZTBdrBY/rsCGc0vr3O7ii9CUd/xEG0pIZbze7ojyz9gRGUTEUWY89JABdKBuTnf7wiO5CLWIwM5fzeeGti6mUsXqr7rdTbD2s3hJhnJTF9ZI9XmunXeE0oXb8k71UzDLM6rnEN/kugxX5KOP0aJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwnD3585ya/DzCjFi25dZ7f9azPsIClEYGYPXpsXesA=;
 b=MowzoUcAZJWoaP0EvdkT/tZeMJg0Xos8ggulVkOWzsBCKse1EyACneFBpbZJObaEgqXqJTEfBfgdvOr1FB8A557Dx5pEfiF4Te1Rx9lnB2JyprzVyvmtqosN3HaLP6re6VOs0T/KkUv/wEXU04AIUEGMRwIXrBPqK05F4+wEB4j2JPqXfl6oIhVJruuCbOc4dN/a77MGfN0tLQV/FZ4TjCfsjjPLs/By2/6x7pi4zFeEXpHrhPl7vthisVVJsRN053mSCmYR9ImirMOlAOD8IX6HjbBmOM3qwG8f4HGjieHB75TuF4JJdIjXn+0ii0yBKBgRKXmdkA6xTDwB+1JrJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwnD3585ya/DzCjFi25dZ7f9azPsIClEYGYPXpsXesA=;
 b=grASQdtC2JEXFgEvA+MuIzhGjqmTHhqVkJUpOSj7pVph/EWeNsQYXwU8x5xQ2EC9W+ui7nvqyIjASoTDHFahCbisK7xsPzGwee82axUOnPbVElqNSyXD8P8zNJSPFPFcXKv+W76CrrB1M7KRr01mXQw9WyHQXc9y/tDrU5oxVqnUIz2KjQ/rC0hpsebSlA4SfxwplnnWMm5rNl2sAOiFK1JJpTgSvAcYW8FucuQjTT4c6+0JRBOe5DSuxV1/P9vxXG+ybqg76vzdu8U2HoOum9v20V5mmsW4WXxBVHZlaqTkTjYtrWjCWj01lwZHWJV5DhKLge7a1IyVuvLJa7nMcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 08:06:15 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 08:06:08 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH 0/8] gpu: nova-core: convert registers to use the kernel
 register macro
Date: Wed, 18 Mar 2026 17:05:58 +0900
Message-Id: <20260318-b4-nova-register-v1-0-22a358aa4c63@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBtQS7GuEi36mWw2FmNIEN09a
 fkt3nsgkTAl6KsHhDInPmKBritY9ikGQl6LwSjjVKM9zi3GI08oFDhdJOg65WertbfWQMlOoY3
 vfzmM7/sBP0laUGIAAAA=
X-Change-ID: 20260318-b4-nova-register-6908b5118552
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TY4P301CA0076.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::18) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eacf677-3276-4a47-f955-08de84c53594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|10070799003|366016|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: VKXQulFvpEQuDgM0hH4MS/FjRwo/nA//mw9ZsGyLYIZ49tcBTen6cZldfapEx3QCgBAaUXfDg5jmAkdAf2Zdth5iBZYDcsDwZ/Aq+cfiErAIIDefB6bPro6K3ThEKN7n0gBV1AtlwjlMbxlPIF2cItVS5+N7NJYBprV9kRclf18xMNvqORkjT610GQwwqnVbDwmxnHclsOiAq3LrZk2Yy5h4IAszZYAG+CSm+KJKFw8eTJ3O1W1LwkwEsbqzcJ7KPClHbG/4cIp2x28u7xeQJNsJqbFuWhMYfErUpkO8Et2M1jUn4uYQlJA+LqK7boU+L/pJGHk0ZIp7y7yeEYUr4qE8Ah62nFiz9FRCjc7kBici6Skz1b65MSlH3ZxO6xQmkpOecwzXd0kXFsozaeH6KvkM2nTZYA2c2+aM+kxoUgfYXmMKbcPwoqLhTE4up/no7+eLpyWs8pjXkswPYapR7SnQcoM0BBxViAj/Fg8eiObKhY6DcFLbUHXWYDZo5xZoqtb6VXEOUtALkIk5zYdxcJbyHl3vE7DHsCvb3ZHNXrwQkjtPVhOzyWHP8YwWh+H2AlvMKT7IgtybxkrR+3DqwfCg7FUd+cVUi8nCYKN8yLHc85bYpDIZBAMV9Ops+M+ScQh2rdD2diWtZAM3khwl2MySgG3wTYTLSQnO1yIIEemBUnU4Fh1jJisPCYdKF0wK0hEO4/3AtHmr02F9gKUthV8P2acSiI2ENvqhkyXhRwN9nn/7Bl6CvQrR7EVgsG7LILQM5ehz7BLqNNv5aXsx9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(921020)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eW0vU0FsbzBHZ0FCdUhhK3BoaVVRVFNNSm1sT1ZvbWF4cEJtWEhldnp5TTZz?=
 =?utf-8?B?UzZwTEdNd04raWt4eHJ6RUpXOHBMWjgyTktBaVExYThWOU9hQjVwWjNYck10?=
 =?utf-8?B?eUFrT3VCRlNLT1RaWFh1NkVuYThHTG9QdEZFVGlKNTNXczBiQ1EyRXBGMURV?=
 =?utf-8?B?TkRhYWpYNU10V2pFVlJwaGRwcEp1UXZ4aUdCbVc4WENma3BoeExVeDlZYTFp?=
 =?utf-8?B?VzNHVUx6NkR2OXpIVFJ1NGJqcFU5c2xWK3lKbmJTeENiTVE4QjY0c1JlTG1Z?=
 =?utf-8?B?UlNmSGM1bnlrOWpnMUlIbGZKUktKVitZYmlVenpCUE5yc2QyaExHOFNuZDJY?=
 =?utf-8?B?cGtLNEFIcnZBbmhkT29LYkFyUThQYlc4VUxkcjkwdW5XU3BwVVFORm53Rnly?=
 =?utf-8?B?NWhJb2pWaU9qVURWTUFpbW5ReEE3dmMrZGQ5Tmx1NHkvRVNVTHZOLzlHV0NH?=
 =?utf-8?B?UXUxT2F6Q1FMczZRQ1I1VVkxS3lvd255V2kydUQvVVVQMjBBOC9zNFFVc29V?=
 =?utf-8?B?Nzdtb2xqcXdqVTJVckJVY2xIRHA0b1JNZXpxYmlDcnAxTjIvOGF5YWpZVm01?=
 =?utf-8?B?QldMdUVjS2paRGlnZzY5VWRaMTQybzYxbEd0TmFTQU8yYnpHeXVoQlpiQXZw?=
 =?utf-8?B?aHdqZm5UZ0JWK3dXZUQ0c3pLOGYrby9HQ0N1UjdJR243cEQzc3NicDVNTzNh?=
 =?utf-8?B?ZVllOUlwaG05bzZsdVNFT3d2RFFwNUJIaVlGc3MvM29uTWd6T1BJZjdLbm5M?=
 =?utf-8?B?VEtBNHdwbWhNMUhCUTdmMTlERGR3bDZ1K0RIOTZMUnhpN0ptRTlmRlhMclZu?=
 =?utf-8?B?ZUE1SzdWVEI2b084NDlxdWJHbGpoYWI1S3pZOXpZSUxCOTZSZ2JYa3pNVzQ2?=
 =?utf-8?B?bmIzRVZ1V0Zsd3lHYTA1dnEzNzFaVi96ZzV5TjZxd2V6L2MrSlNLQ1lKWkw3?=
 =?utf-8?B?bUNQTDdZSDN3UzQ0THpKSHFibjFUb2pQOTd6RnRPekZtZ2pRbUVZbC9yckxG?=
 =?utf-8?B?K3BXVlQ5aVlEZ0drcW0ybFNRWjJMei9WL2E1YWhWNUNzQk1WcHlzaWJLQTcr?=
 =?utf-8?B?NlZsWXNRTXBydFo2cDZraGU2QmVXdlhpSGtzMEZoWjRnL1htby9HVVA2Yi9I?=
 =?utf-8?B?bnBxNVdtb0lwZU94MGVaVjJNM3MvS0Zqc0hHNDgxbTdwQTBjNFRQaUFmZTdR?=
 =?utf-8?B?TVIrWHA3TjhTTlpVK3o1ZmtZNUg3VkQwN3BwOGpyTTJZQWJoMVZ6N1pJS1Vv?=
 =?utf-8?B?ZmZubEkvU3BjYkkrNCtWRGk5eVhsTlNjcm1ZOWhXZjhrajNIRkRzcjA4bFp0?=
 =?utf-8?B?ZFArNU4vU2YzZFRHZmtiWmp0MHJ6RE1Pb1JmaXFjMFZNSlFlVXdRaG5wRERK?=
 =?utf-8?B?RUxIS3JyVnVCQW4yOU5BV0xPRW96WlhaQTIvS3o4UVQ4bStDWUpDb2dKVEts?=
 =?utf-8?B?UGRyOHA1SW5vMEkzbkhVTDFLU3hhcEdPYXIzajM1b3JlT2JTeWRxQmdDY3Az?=
 =?utf-8?B?UmVvRy9aL0UxWGxYOHRNaU5BTk5Pa0lkK29RNW9TeWprS0d6SjI1VFo2dmtG?=
 =?utf-8?B?QlRnM3ZPRnZjOTdlZGduUUlBTm1sSWFSUmwwUWRxUU93cXdwUEVxNk5FVVg3?=
 =?utf-8?B?UzhFLytkbCtrUXVxWExzMkpqbWxQL29CdGE5SStBS050cGtNTmFpaDhtcUJY?=
 =?utf-8?B?TjZLYWxuQ0g4cUl2M0RtdFNsVjdjRVlrVWFuZ3pjaGpua1dXTmF3WTFkVWFT?=
 =?utf-8?B?Tm95VW5VazU3eVBFbzBQeXF5aEtHZTF5bDAyQUZNNVRUeU1RYzQ0d2g5cWNl?=
 =?utf-8?B?UXpDdXh6NHFoa0FaMm9hTHdlMW9iVzB0cWRVaFRhSzR1SDNBd2VvTVhTRjI2?=
 =?utf-8?B?QWpVYis0cGNYYVA0eTBTZG9mR0oyaktyQWVhcmVPMS81c3E2UDVuMndSYU8w?=
 =?utf-8?B?eWlKSTYvWDBEVEtrZzFiSWNIckpEclcybkl0UGxGOW1DTjNScXBFS0hUbFpN?=
 =?utf-8?B?QU5ueHVaaVZsOFVUallTWlYxZVA0ZENOZ2tGbWs5OXZKTitocEVBT0Q4U1FO?=
 =?utf-8?B?ejBRbXJyNEcvNUJGQmFSL2dwV21jYzBIbkxhMGpyVDRGSkZZWTFFZ2p3MEE4?=
 =?utf-8?B?M0hwa2FOc282N1dMcTVvRXo1MExjZXZycC9DVnhFRUhJN2FNUHRtVWQ2YTl6?=
 =?utf-8?B?WXNEeUI4SUVqVXVVTXZFK3ovVGF0VndLdURyOSt0Tk1tNG1YL1lSR2VKZzB5?=
 =?utf-8?B?RXdyUmJUWURQdW9BeFQyYkpySm9pbjdvRFozRkgyNkZoRllMZlVJZTA1enZi?=
 =?utf-8?B?UW1DMUdjZ1FPVWRGVHorb2ovM0ZNSVg0YUlvSjkvQUFJeG1wRE9vazJsN25o?=
 =?utf-8?Q?kB836CMiOckYGmIoq4RKPQ1w8VtPZ9xESl8RvixMgwLQv?=
X-MS-Exchange-AntiSpam-MessageData-1: tt3YyPOeLgKYjw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eacf677-3276-4a47-f955-08de84c53594
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 08:06:08.3076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nrmo06VZpyLwkrXZGUwOgqdUIiIMf6vbiShRMhF8LX5ePDyQDDrAVOouhJIotfOzcDP/itbvyeolmhm0DoGO2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197
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

nova-core carried its own helper macro to declare register types. Its
purpose was to be temporary since the beginning, and to serve as a
testbed to develop an equivalent that could be used kernel-wide.

That equivalent has now been merged, so it is time to retire the
nova-core local version.

The kernel register macro has evolved into something significantly
different from the one in nova-core, so it cannot be used as a drop-in
replacement. All declarations and sites using registers need to be
updated. No semantic change should happen as a result.

All the patches in this series could also be squashed into a single one
without altering their reviewability significantly. Actually I am
leaning towards that option since it doesn't make much sense to
partially convert the driver anyway. I'm leaving it in split state for
now in case this drives more people towards review. :)

I hope to be able to merge this quickly so we can rebase in-flight
series to use the updated register syntax.

This series is based on drm-rust-next as of 2026-03-18.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Alexandre Courbot (8):
      gpu: nova-core: convert PMC registers to kernel register macro
      gpu: nova-core: convert PBUS registers to kernel register macro
      gpu: nova-core: convert PFB registers to kernel register macro
      gpu: nova-core: convert GC6 registers to kernel register macro
      gpu: nova-core: convert FUSE registers to kernel register macro
      gpu: nova-core: convert PDISP registers to kernel register macro
      gpu: nova-core: convert falcon registers to kernel register macro
      Documentation: nova: remove register abstraction task

 Documentation/gpu/nova/core/todo.rst               |  76 ---
 drivers/gpu/nova-core/falcon.rs                    | 336 +++++-----
 drivers/gpu/nova-core/falcon/gsp.rs                |  27 +-
 drivers/gpu/nova-core/falcon/hal/ga102.rs          |  73 +-
 drivers/gpu/nova-core/falcon/hal/tu102.rs          |  12 +-
 drivers/gpu/nova-core/falcon/sec2.rs               |  17 +-
 drivers/gpu/nova-core/fb.rs                        |   6 +-
 drivers/gpu/nova-core/fb/hal/ga100.rs              |  37 +-
 drivers/gpu/nova-core/fb/hal/ga102.rs              |   7 +-
 drivers/gpu/nova-core/fb/hal/tu102.rs              |  17 +-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  19 +-
 drivers/gpu/nova-core/gfw.rs                       |  11 +-
 drivers/gpu/nova-core/gpu.rs                       |  37 +-
 drivers/gpu/nova-core/gsp/boot.rs                  |  11 +-
 drivers/gpu/nova-core/gsp/cmdq.rs                  |   9 +-
 drivers/gpu/nova-core/regs.rs                      | 616 +++++++++--------
 drivers/gpu/nova-core/regs/macros.rs               | 739 ---------------------
 17 files changed, 685 insertions(+), 1365 deletions(-)
---
base-commit: d19ab42867ae7c68be84ed957d95712b7934773f
change-id: 20260318-b4-nova-register-6908b5118552

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>

