Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A0CCD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 154A410E0A8;
	Fri, 19 Jun 2026 13:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="McYYpWuR";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010057.outbound.protection.outlook.com [52.101.56.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4520510E0A8
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 13:42:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFj9akhwY1HwqFPYWIJlP92MgmfLchTOfJFNpY15bJDKv/iyS2dvrVTi42s9b4r5c5NNxVlBejDg9ExybLSqHEZtKQaN+NamuKd3Wi4zX/J2XRl+feVieBqjn/jnp5qPZuhp+n6YOn0fUYPjZZaSLjnMpObH6dId4/ciZ4CUdhsTSe74zenAD7Ci3DAD24QIT53YoSr1pOShQo7OfrzbLJze/7lAX20++wPfhLcKWL59JICzTrbpL5w826nbMWpeqI4KMtmNbBYWT/ENMUfGrTviIKDhPMQbelxBmNjUpjbKHgMfvbpg8HRmLSESEO4n2aqw1n/Ii+prnBPJKpJSTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZrVNDqeNv5R1wj87tkCAqEmQga46BH0qi99uPhTKkY=;
 b=aBUMrhuLzvNiRkwjBhdBhkyglGTUArJzdab1v20BSS5q15Ts7AdqlivoSnT4R500CE8I8PxoFrHclXg//Uq2hne9mSPuXcd95t0pHHTP9Ur7+WfVt1R54srGkfdK8GkHd2eRIsPZo6LliE24tu2TWUJQbqLqSqdW/wSwB9QSidLmSS2YUYxUqEhT1d1hDPStShxWHErjxEx3XqVMoi6mFMP4gHEikrUfHTHHFo1oYQQ0LZrfJV4rxPgA3R34maxFJ74zHAU+HqfYpE/guuEs+xSQNnte28e7+LIOK0bSf3C3Y0E6dX1UVclgB6wYffZoM2TjcDYcecmBTf5Zxv1nAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZrVNDqeNv5R1wj87tkCAqEmQga46BH0qi99uPhTKkY=;
 b=McYYpWuR3/cZd4ClOrane/zP0duuRc8fc7mFiFOcbNG20cNAb5pXqoM6Be+E5j2psQr5d5jCFJPkWQff8HEjgAQZMtnBY6bn4BK0SJZIsLKZtSXDicwNtVfeMt2LN1QlxpstX627C9eIRL7P2J655CPPA3+NzTGbI9Je1QYVKfjiZNEMWx/5HUfsK80S0ObLUJY47iTAdYnXoTnYEtL88OGij1CvE01tBAhGvKemACPJRvfu2rgpnlhb2cPwYH4iC+GHr3FIVOESbGQJaA15jM9VFPnyqAw6/XGXDDYzyF/px70T+kRLYuxmHZ3F5dwsyUAQRs6skJKwIvy2K6+8rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SN7PR12MB7450.namprd12.prod.outlook.com (2603:10b6:806:29a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 13:42:28 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 13:42:28 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH 0/6] gpu: nova-core: consolidate and streamline GSP boot
 process
Date: Fri, 19 Jun 2026 22:42:15 +0900
Message-Id: <20260619-nova-bootcontext-v1-0-45193cd0a2e5@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2Oy27DIBREf8ViXSLABoNX/Y8qCx73tlQytEBQp
 Cj/HuJkOdLMmXMjFUqESrbpRgr0WGNOI/CPifgfm76BxjAyEUwoprihKXdLXc7N59Tg2ujCeFC
 craDRkTH7K4DxeiC/zq9cL+4XfHty3o0C/5fx1V414mwF6vO+x7ZNoKTU66y1ZGoWi8Sw4mJQc
 w8OAwZApaw04YnaoVZ7SG7TW3E97Ggvdqd9powK5gx4iWBQfKYeQ7Sn8UXO9/sDlmsD2f8AAAA
 =
X-Change-ID: 20260619-nova-bootcontext-401d6107e8fb
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P301CA0037.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SN7PR12MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: 004652aa-4016-4aa4-9e54-08dece089a70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|376014|1800799024|366016|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: RLXpYykayyaaDin0akBmB7dIZfGKtbyxxaGHlwTpU244ftc7RbmID6h8obTHaHckVsjduYSrwaHiL2rUODS+PMtjQK7OgUlFG64sY2aB6AUCfMJSaBhj4XWoNGdVdeaXhSngPz1UxSjev4Z+hvd04tMGmQQS2xs2CI3W1ftZXQfOpa9Watfw97tWIy4td2R4fMQ9c4MFpRGX8RnufuZa822P3aw1/AwdHHb9TU56DnvKUcSevk9RcP5VPahcMafI6yVseBRPghuLDtg7NsuZ+bwwTW7JSBsij6ro6tP3Fcmg3SLl3egtnVQrB8dkYzDxjztbIRdtnUbpN1WE0ihNaVwA02UvuTZllQo/bOHVti2swOKjfPfaJS/7UAQjJU+cC98Nqao3JkVxzsqCm/cdUZIx6+avXpuSlnN+8G5XKPioDCDp388yL2GhzEejsaOFCq638lEOU836Xbw/tNQeqeR9d0g+IFgOmBn1ePMjaIWV4MLs0Sa4J40VFkUu2/PiYgQb9JVJFWnnDsaSROdhh4MqpJJMViK7O9YmfPpoSr93mVl9TdAiZauS312jCzvyUae6fFg+2dc4R4OokeAlErz2pgxEsKzjchT+OJ+k7lpl4QcvJsVE1j2uzRMmdf70Q96xC+8HV4Rzh/XEUgs0gJpKdJV/Ak2mwqrQsyGlx78=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(376014)(1800799024)(366016)(11063799006)(56012099006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG15YUFjTmQ5aWc5YithZkRpdWF0M1Y2NUFhRVd2c3o2M3RBcTBKdmttU1lJ?=
 =?utf-8?B?SXZzVllZRm9NeWVPMVdDMWpZQzB1ZExqb2d3dGU5Z0owRXBSamVUNHJFQU1p?=
 =?utf-8?B?Z2syRHArVi9mV1I5ZzBGR1BUeTJSb2pNZHRxdGY2VUxZYnpmaVB3MkE0TzZT?=
 =?utf-8?B?ZnBrOG9vTmt3Tmd5a3ppZi9ESDdUVGtUMnh4RGxWMmRUZ0Q1VURvRUJDN3lL?=
 =?utf-8?B?Q0ltT2NjdDJ6eFhJNFRrSThkaGpYQlhVaHZOM1ZxRFBYNW5NSFFtb28zNUt2?=
 =?utf-8?B?cmRpK1VVQVJmUGNHMnB3WG1hT0VDcm4xNmNwS1k0THJ0dG56ampMTHk0aThz?=
 =?utf-8?B?cTA2NTM5UzdPZUQvQUdaZjVhWHA3Yko2OFV2bFppd1MySlZVdU1JNnVJUExE?=
 =?utf-8?B?OUNiM2NaN0RQditLNWlSYTlGdWEwWktlQTBPQlQzanNrRWVRZk4va0kvNmNG?=
 =?utf-8?B?amtRZExOWmRrWXZyNDZYMlFBbXl4bDVsUHFhMjQ2ajFBMWo3elV6RFpaVC9Y?=
 =?utf-8?B?UXU1RkdwZWwzRTJjamhiME4yeHRaQUlOenIyRzBIZEwwSFRrNkViTDdYR3Iv?=
 =?utf-8?B?cDFEYkMrVTI3ZVVXSjYrVFVlcHo0WXl6NUJhelo4bjVVck1YOEZ3enJaYjk0?=
 =?utf-8?B?cmNUN29CVU9td0pzL01VcUVaSTMyWW1BYjJKSGdUYy9seFZkUitVaDRpRE9v?=
 =?utf-8?B?eXBLQ2hHc1RiVlJhbU1pQVRMcFV6R29VQ0RVQWZ2NWx6bzk3aHduL2ZTWXJH?=
 =?utf-8?B?dFJZcG92eUZmTXZiQ2M3OHV0dlA1OXc5ZHpWV1hZOUtGVURqVUZSWmFFeHNY?=
 =?utf-8?B?UGQ1bWsyY2ZRZGtDa0tQZ1ZhZUtmUXdNalRVM21DaFpTZFk5TjNLRVMvY2Nr?=
 =?utf-8?B?MzU5dGx4ZFNzU09UR3l0VE4xYmZ5TUVtNnFZRmM0QmJJSlltdmRwcjZSbFFV?=
 =?utf-8?B?UHZiTmVWeE9oVk9uTzJ2eEllSCtBRzRYcmdRanZFQTlVc2R3empqS0x5N1JY?=
 =?utf-8?B?bWV3VWVSd0dmVkZVZ2p6NFI4UVY5cnRFS3lUYmxaeUxnK1VNVk9zWlhYZExa?=
 =?utf-8?B?Z0dOQzI0Y0ZSMWVPMUxwaVdBeTVPS2FuSkEvTHBOOGFJTWcwTVRmSWV4VmhQ?=
 =?utf-8?B?V2VwamxiaFVZOThxN2p3cldqMWNrTGFjNEJQRG9hWlJCelZZelJKTUJwK25r?=
 =?utf-8?B?TmNDMmdFWWpJdjJvN3RmSVJuc3IvWWJ4V09vSVFsbENxUHhzZ01sVGdCemZp?=
 =?utf-8?B?b2txeVFITy95a09pdDU1SUpxSlRmejNyK3ArSnJKTXhIN25YamxzWU1vKzR6?=
 =?utf-8?B?Ymx1QXIyWkgxajE0cGx6bXNDcGlBSGNlVXp4K05QNm56ZjNkeU1Gb2J3UDVl?=
 =?utf-8?B?N3NIVHpxbUNETHRzT0ZoTUswdVRHaUdIV1hZdlBKbkxzNmFYdTI4YU1WMGl5?=
 =?utf-8?B?a2xvNjFsRWhhUW9Rc3I1UnJOMS8veHhHcVdacTBHY1FQVGhjSStNU1hsTGNN?=
 =?utf-8?B?YjNHZ0ZXSHhHa3dBTU4vNjRHVDhPYXZ4eU54ZThidjBubTkyQ0kzL0thZ1pU?=
 =?utf-8?B?NTJla1lrZEl6ZGUxRysyRmEvRWl4WXRyd0NqYXlsbmUybk5pdTZ0NnVScVJp?=
 =?utf-8?B?ejR6QldQVXcweEg2VDlPUWpLSnE5djMxU1BvUkV2ZzF6dmF3eFhHaHZPaTln?=
 =?utf-8?B?d2sxU0hqaG5pcTFYeEhQUVZONE95YUFXMVN5dmk4d2h6MmJRL01qSUEwNVBY?=
 =?utf-8?B?cy9nRUJwWFVMSndadUhMaUg2VDNUMnFnRElyNWVwYW01QUh5YnVsZy9Ha3ln?=
 =?utf-8?B?ejd6VGxJVDlNV2l4Vmt5VkUyQ3dWYVBmczR6dG1uYldzQUNsVEI1U2J0dnh5?=
 =?utf-8?B?WWFjVHR6b0NjZ0JXd0oySVYyL3VpZElIME54cG1SMnZoSTl2ekJJdHNkY09H?=
 =?utf-8?B?aGR4aEprZk1XSDFZOEx3VnUycG9CbmZJNEJLYURtQ0JiK2tPUVg4UllBU1lP?=
 =?utf-8?B?OEFnQTR0VlkvaTdPTUZXNHNPU0IvVTVWVUV2VGJ0Z0xaVE15Qk9ldlhzdVpD?=
 =?utf-8?B?b0x4dERRd2RYVmxhWVlMNEJpa0svVHJreFZTMTBIQmQxeXE0aVJsUVRhdzdl?=
 =?utf-8?B?Z3lEVDhJR0pzTHRReUZXcHhQZ2g1dTgyMUxVTS9nNEJZbnZlTklmRHVaYU9h?=
 =?utf-8?B?R2RJUTkyd0syMm9sVGxhdldZN0Yva0k0b0hYNUZHZ3NIS05Va29lL21rQnZp?=
 =?utf-8?B?N0tHSGlnODY5ODZqUkJwZ0puN1lCTWZSMmJVSFdqSDAycllsNHFFamhOKzc3?=
 =?utf-8?B?NThTMGd6VHArSGloYWliYjR6dHUxUzFqUFRDL2lJQjJqU1JOTlZvSjcvOTRJ?=
 =?utf-8?Q?268IcfP6P9mBHjSrCHlQDgsZF9VYmNQxu5qHueuYli2Br?=
X-MS-Exchange-AntiSpam-MessageData-1: 9E+hVN0k8rnfJA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 004652aa-4016-4aa4-9e54-08dece089a70
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:42:28.3249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXkCUdxgYCvj6KyMq0leKy1k7M55Eumq39kTNZHCyIpJ4xsPyPcJjdKjIwMcwo4cz75piClYwyi7FSJCChtyKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7450
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

The recently introduced `GspBootContext` is useful in at least two
other places:

- As a replacement for the sequencer's `GspSequencerParams`,
- As the main parameter of `Gsp::unload`, for symmetry with `Gsp::boot`.

This symmetry can be further exploited to make `Gsp::boot` and
`Gsp::unload` generic over the exact boot context required for the
current chip. Doing so requires some more preliminary work that goes
beyond this series, but this groundwork is needed regardless.

Another cleanup that can be performed as a consequence is the removal of
the `BootUnloadGuard`. This type is cumbersome as it holds extra
references to the boot context, making it difficult to make some of
these references mutable (as we want to do with the `Falcon`s that
should require exclusive access to load and run firmware). Furthermore,
it is only needed a single time in `Gsp::boot`.

By running the boot process in a local closure, we can catch errors and
call `Gsp::unload` on the unload bundle just as efficiently, and with
less code.

Although the final goal is to enable mutable methods on `Falcon`s and
make the GSP boot context generic, these cleanups stand on their own and
remove quite a bit of code, so I am sending them separately.

This series applies on `drm-rust-next`, and requires [1].

[1] https://lore.kernel.org/all/20260617-boot-vram-v3-0-20b9ec5fe9f2@nvidia.com/

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Alexandre Courbot (6):
      gpu: nova-core: gsp: sequencer: use GspBootContext
      gpu: nova-core: gsp: sequencer: do not store sequence into GspSequencer
      gpu: nova-core: gsp: move boot code into local closure
      gpu: nova-core: gsp: replace BootUnloadGuard with local handler
      gpu: nova-core: gsp: move unload bundle error handling to Gsp::boot
      gpu: nova-core: gsp: make unload take GspBootContext

 drivers/gpu/nova-core/gpu.rs           |  19 ++++-
 drivers/gpu/nova-core/gsp/boot.rs      | 140 ++++++++++++---------------------
 drivers/gpu/nova-core/gsp/hal.rs       |  35 ++++-----
 drivers/gpu/nova-core/gsp/hal/gh100.rs |  59 ++++++--------
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 133 ++++++++++++++-----------------
 drivers/gpu/nova-core/gsp/sequencer.rs |  71 +++++++----------
 6 files changed, 191 insertions(+), 266 deletions(-)
---
base-commit: e655873885063245fd7f49f81cebfdfdef66a59d
change-id: 20260619-nova-bootcontext-401d6107e8fb
prerequisite-message-id: 20260617-boot-vram-v3-0-20b9ec5fe9f2@nvidia.com
prerequisite-patch-id: 3b9948cc78c017fd9edcd51e1a65d0aa741a1b8a
prerequisite-patch-id: e5c8ef9f9fde8bf165f8339da1cc55c7f25ee845
prerequisite-patch-id: e6657ea9ed37ee9a195aae6d87d5f28d4ef2378e

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

