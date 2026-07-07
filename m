Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81572C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:34:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C368F10E2BA;
	Tue,  7 Jul 2026 13:34:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="i58El3V+";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9190B10ED0D;
 Tue,  7 Jul 2026 13:34:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B24iGWChsulvmLEXKSUoCUlFsEkZR9ztAgh68tBgqvtsDA+V3IxYgVdMqIZIf8T+f+E54Js528MK07WCIOmppTwKsErIUDjSn6k2YEyByHjC01lhCTWBhwA7TBD1UQ+/kzIVNeFz8LoYYVYZ3wglwQu7geRB9mOYHffKM963IX+fP5GV9eLaa6xBfODGQ99CYe3OCkvqhyGey+4frG2FCnqnQvFzWyVfIotClS3IC/sWp9AmYJHAeGAP6jWDDpI8URWFNa6ghN6OyO7TcLqnsot66RVpdCEXEbdsyc1F5KzXv4GrfpbOcxDAvSkWvPXV2n7qhEuENG2BUO9GQNKV4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79COtMU+maglch0wR3BLh223hndBtiBreumf8njaEdE=;
 b=SEgr1hQi+0lKZf4iUsPYYg7hJ2jdbRkmhzY3EKAn9wdmar4fTetGDkpQZMTsRkj6+szG+GyAE6qvk38d9lj6cc4SFt3RwdA6zF30FPjmKm5An/OUQHxF4mwZiskd9mMDUZQx2I/HFYPakS+YjpmKxG0dm0sQTEWjvc3/4CStK+Ma9kaKzGSmms4K4MUw+prnphje54L6CJttd3TNUF7NuuKcuBvLzCM3SEtl7EMhKYyOQTy3EhdmK8cwybW4EfXLD6z/heU9UBx4Hk0OTxEq+HlBdFFwRyJpXuC2CvgPLD3k8jBNbjgdQ7rOrTR2FXbFaBnmf2j4Y3QgelvFdTXYZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79COtMU+maglch0wR3BLh223hndBtiBreumf8njaEdE=;
 b=i58El3V+zy9UgdOkbjw7m6GJDaK06pFjaPXvHPU8g+iTobaYIYgzO5XBVdYZAHG5Ibxh8bhHCeSVZCkBYC2Wx0DPnaM4s26lNbnIet2wROT2bbb9lbKH+x4sM/A6+TLoo5p6Llbn8pXD89DS/1B9qgMQg7JzWt62RVglpMK4oEPtbzYLPQa4uV1qSmyD+xwm+dCoxCPj+VKUZ+HUzyftyw1WEaoc3aBHmEqI7RHn07NznUblMFVy6zQ/Ohf45PEuHjXWMV7oapJG3e64Y8BFeNxFMFmn/l2GeixciyxBl5aMqLBCN2ZIIaUXCHMPywyGw5vtC+P7OYIKD97ZXKbNjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SN7PR12MB6743.namprd12.prod.outlook.com (2603:10b6:806:26d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 13:34:30 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 13:34:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 22:34:26 +0900
Message-Id: <DJSDMDHQVBAR.SSK7451SWXO5@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v5 03/13] gpu: nova-core: gsp: replace BootUnloadGuard
 with local handlers
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
 <20260707-nova-bootcontext-v5-3-ecad9346387f@nvidia.com>
 <DJS6M2YBO8RS.33T3S32EFHL1Z@nvidia.com>
 <DJSCTKZ97STM.2D8YP8LIVELH2@nvidia.com>
In-Reply-To: <DJSCTKZ97STM.2D8YP8LIVELH2@nvidia.com>
X-ClientProxiedBy: TY4P286CA0095.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::14) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SN7PR12MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e1adb7-2f70-4670-d0e1-08dedc2c7903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|23010399003|376014|7416014|18002099003|22082099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: CDZu9O0+xiyqDy4yr3+g5l6i6ouP80MlOJBmC7tVfzJFg7FJJnYBZo6ImltsXs4NzOqqJghISxogTivGCTPaAAXVa664nmKw7CFOkE08rAXnIW7w8oCTgjBZz5GyPztyuCsTie2ugeULuXnEXo4tPx73/z8bbRyLsj0/yeFXNQiDze7tHTHBUJ0RzCfeM9LtW4/X89WyICE9w7DNTWIU3T83hV5VjWCZDoKmdFJ7LYyzlHBXYCOLyYbHU0wMc9P20tqRQNhAKCNjoGkwClMrjfAUZXPupaFPLfu5Y6pnOqDAE0aeUw8VnGbUS4tqEJsPkKwUa+KuhLCevgsiiF6pG7LS4SuY++7Evjk9WdHl4zMYYLiMzT3gDnRCtbLUqH/A6dnYCprh4x8OHhvMuC+m/bD+E7t+gmWOey7Js3Q9i3eAGeHdMEcCmqmWgcybA+36MQf5yPFP8RljEK/UtS7VfY6ZYWcUVGFjTqUJoXlp7uypNVRPtUJSuA4VeGFyDR9zCrvXr7BNE3S22LxZKaeTdnTX5+VidIboLW5lKQWaW/KWiZrp4rhzSpaGF5AqHs5a+eMNxdiqbLCMyPCiRRS4jf7iuUfy8770N2lB+6lLzZWakZU9kHMc6BtA//OrRKGJyjHnR0iCAmlRrnclgS5DFbv19/IC1N8kd8KipM7v5zk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(376014)(7416014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHlqTUVPRU81UDIrSUhVSWFUMklPUk8zd1NjRWhEWU10RUlNTDZHUGZlMHEz?=
 =?utf-8?B?VDUwbU5OUDRsYnVjcUFlTFBhN2ZxRkExamF2aThiV1Q4K0tBM1FZcnFMSno3?=
 =?utf-8?B?VnFISk40MWErUUZTbFFPSVZhL2NOWTUrdDRjbzMzcElXZEJ0RlFZdkdhWnl3?=
 =?utf-8?B?NXlNNXVPNExIQjNyWHREVnFvdlBGeVBUUGx5TlRXYVhhUm9ma2F5NWJ1K1hs?=
 =?utf-8?B?QTUxL3dSTWRFSnhxUktUNnFuMVV0Zm9oZTAxcVU2VHd0cEJxZGUrZFhwV2d4?=
 =?utf-8?B?SldVaFdxVlFSNHM2K2czYWNDQzcvd21VeHNoQytUT25PblZmVkgzbW0vcFNF?=
 =?utf-8?B?NTJMS3lBS1J5Q0ZuOE50dGR5UGhoRFhPeHlTRU5hVHhQeDFVcVlNQ25PYm16?=
 =?utf-8?B?emZxd1ByMU1PKzZ4NXlpYjhidU5OTnA0R2t0UGN4ck9neDZiejMwbjIzMXJW?=
 =?utf-8?B?dTJHd0ZJVG9MZ1AzYWRmSkFlOG9qSE1ET0VwNkp3b0g4V3RtZHNQUW52WGg3?=
 =?utf-8?B?Z1NqQmx2d0krME15WU5JcUZMTy9RMnU1ZXJCZnNWN3ZmMUw1QjVhbkd0Y3Iz?=
 =?utf-8?B?bHpwSG94NUF2R2FOVlBPVkJ5d0h2b1Fzd2VZL0VCRURldTNBYTBIdi9kNUw3?=
 =?utf-8?B?bjBqUzJLRThxMHFQYU1NT3lvY05YaDh3aGFQQVVKM0NCWkNhQ1Myd3JuQm5F?=
 =?utf-8?B?OG9hTDcram1XcGZlZ1VVVWQ0Q0NhSkRGMWE5WW5kWHl6eVM4TGJrempBbkFs?=
 =?utf-8?B?bVUzL2loU2dDWnJYanRmWkJSR21LRGx6NFh1ZUVWWGFPNTRBaVRaNFhwTUxa?=
 =?utf-8?B?cTRBTUpNOE1oM1UxT2xXUjliMm1xbk0zcFA2bytvSCtuVHVmZjVoMDYxYUxB?=
 =?utf-8?B?NWwrMjV3NXpzWmphSlJtNTd0aGRWR3BGVExjZjRoYU5tT2tONkV3ZnBsUTdF?=
 =?utf-8?B?N0l0Z2RWcDg0RVIxQytWZ2RBUEJXeWE3NUJEOTNWelVKNEJLVzY2Q1YwajlB?=
 =?utf-8?B?NHBwQTBSaHMxRnZ5aFJDQ1BJVk5oYW1ybHNOZ3d1b3c2aE1oQWdrbjRpVkVP?=
 =?utf-8?B?SWtHWG9QNmUwcGhPZE9WTnRZa1B5NEk1Q2ZqUDl3WWtHVUFnMFRyb1c1anR2?=
 =?utf-8?B?bFZjWk5pcUtvdlZMV011QjNrcjFxL0ErRTVHeVhPYVVQci9lS2VsdkNqNVNi?=
 =?utf-8?B?cE1QWHBDeDVtQ1dTK2NzWS9SQzFhWU9FZGJxKzE1ZFJUL2RLK08xS3Z3c1hw?=
 =?utf-8?B?Sjl5QXlBR2NlNFFyZEJiMnpxRlR2YktIc2lsTXU4Q24zTStROU9kWVYzTys4?=
 =?utf-8?B?L3MzVkdCU2ZRUjh4enhKYWxoZERFckYwSDVFN2F2c1cwbXJrZHJ0dEtrbzZY?=
 =?utf-8?B?OEdtYndEdm5EbE5lMGRWMFg3V3BVQWV5VjJwRGNBNjIxdmZXWFZRUEtWNGxJ?=
 =?utf-8?B?WU4waDEyYmh2bEUxYlpmdnRCdTgzK2JZZ1l1THYrZGFCYllFd0lPOHJjVVZ6?=
 =?utf-8?B?U3V0NzV0MjZ5eEowM0FUMWl0elV4R2RDNzVVckZ2SW45SVVhdzF6S3pBTFpJ?=
 =?utf-8?B?N1B2Ym5pZXZYbHlTbGVNdjYrQmtMbS9UbVlpRmYwZUFXYUJTTkdtL0NjT0xK?=
 =?utf-8?B?SCtLa3hZWEpNMDB2cXBWeStvZGhCY21Tc2NmaHFya2lMZkJmQjNNc2ltSjNK?=
 =?utf-8?B?Tkc3YWMra01zZU0wbzFxSVkrYU5DSEVaVVY4UlBEUFRzOEo5TGlRVm5oRURI?=
 =?utf-8?B?c2ZJREZuVlpSbWZpZEZaaFdGQzNWN0swZzI2ZkFVdlY2dUd3YnF2THhjRlNl?=
 =?utf-8?B?MDFjTFZQNFVTTDJOd2tNVng0WWFjalYvOU5JN04vaUFEV1hSQUp2NDhyQUtX?=
 =?utf-8?B?aGZzRkN0bzd6SXB1anlyTHJaVnlhQWpnZE1iUXhGdVBCQVRvT28rYUVwdkNn?=
 =?utf-8?B?N1EwbTZpRHhaKzg0TW1QamM5RitGekxZZzN0cXdXbzlwU2NjbFhCajd6dHp6?=
 =?utf-8?B?bC82VTNoOFc5UDRDZC9QR1M1ODg5Z0FpOVl0VXoxSlEzK2pyTFVuMG83Vjds?=
 =?utf-8?B?dlo1N0hZcW1uUVdMbnhreGdNSEVWbUJjcDVrUG5ZeVNWbU43ODVWVVNXS1E5?=
 =?utf-8?B?alh3cEhRNEpaRExlQUcyTVVkcFlkNDdSNTVjNFJhalZxL2F0aVd0aENiUkFH?=
 =?utf-8?B?d1J6UkZOT3JvRFoxdVdOa0pIRWU4OXM5cnhPQXRxaHBWSGtjNWtiSGNDMEdh?=
 =?utf-8?B?RkNGOTBtZG92K0RtajVrcXloQU9IWDJ4RkY2OGZKWU83QWtpbUxFYUpRWFJy?=
 =?utf-8?B?SnZLc2hKam9YYkxIaDRCazg4Y3VEbFl6WFVLcG1jSUI1amlERExiVFRrYlNp?=
 =?utf-8?Q?vm1y3D7MUNHY/uUMNJLqK8eLUPbGitgh3tfvUWgf6Vw04?=
X-MS-Exchange-AntiSpam-MessageData-1: rbWgQbmmfa01Bg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e1adb7-2f70-4670-d0e1-08dedc2c7903
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:34:30.1522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ty96TfelO8toYRKVd4kwhav4lX5IUoc1D7ucwPz+jF9kqYNZJ78Oc/6wMhlUYxO5rk8PKSUklHTwZZsBqz7fAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6743
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

On Tue Jul 7, 2026 at 9:56 PM JST, Alexandre Courbot wrote:
> On Tue Jul 7, 2026 at 5:04 PM JST, Eliot Courtney wrote:
>> On Tue Jul 7, 2026 at 4:21 PM JST, Alexandre Courbot wrote:
>>> When adding the GSP unload capability, we introduced `BootUnloadGuard`
>>> to automatically call `Gsp::unload` whenever an error occurred during
>>> the boot process, in order to try to reset the GSP to a valid state.
>>>
>>> This approach is not well-suited to the errors that may occur in HALs:
>>> by definition, an error occurring in the HAL means that the GSP is not
>>> booted; yet the first thing that `Gsp::unload` does is queue a shutdown
>>> message to the GSP, which will inevitably result in a timeout when done
>>> from a HAL.
>>>
>>> Furthermore, `BootUnloadGuard` is problematic because it holds
>>> additional references to the boot context, notably the `Falcon`s. These
>>> extra references stand in the way of making some of the `Falcon`'s
>>> methods mutable, since those methods would require exclusive access. As
>>> this behavior is only needed in one place, introducing dedicated types
>>> for it is distracting and unnecessary.
>>>
>>> Thus, remove `BootUnloadGuard` and adopt a two-level error handling
>>> strategy:
>>>
>>> - HALs are free to handle their errors as they see fit (most likely, by
>>>   running their unload bundle if it is ready by the time of the error),
>>> - `Gsp::boot` uses a `ScopeGuard` that runs `Gsp::unload`, since the
>>>   GSP should be up and running by the time `GspHal::boot` has returned.
>>>
>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>> ---
>>>  drivers/gpu/nova-core/gsp/boot.rs      | 67 +++-----------------------=
--------
>>>  drivers/gpu/nova-core/gsp/hal.rs       | 13 +++----
>>>  drivers/gpu/nova-core/gsp/hal/gh100.rs | 31 ++++++++++------
>>>  drivers/gpu/nova-core/gsp/hal/tu102.rs | 23 +++++++-----
>>>  4 files changed, 44 insertions(+), 90 deletions(-)
>>>
>>> diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/=
gsp/boot.rs
>>> index ab0491b57944..536f2e341c01 100644
>>> --- a/drivers/gpu/nova-core/gsp/boot.rs
>>> +++ b/drivers/gpu/nova-core/gsp/boot.rs
>>> @@ -30,66 +30,6 @@
>>>      },
>>>  };
>>> =20
>>> -/// Arguments required to call [`Gsp::unload`](super::Gsp::unload).
>>> -///
>>> -/// Stored as their own type to avoid repeating a long and tedious lis=
t in [`BootUnloadGuard`].
>>> -pub(super) struct BootUnloadArgs<'a> {
>>> -    gsp: &'a super::Gsp,
>>> -    dev: &'a device::Device<device::Bound>,
>>> -    bar: Bar0<'a>,
>>> -    gsp_falcon: &'a Falcon<'a, Gsp>,
>>> -    sec2_falcon: &'a Falcon<'a, Sec2>,
>>> -    unload_bundle: Option<super::UnloadBundle>,
>>> -}
>>> -
>>> -/// Guard that calls [`Gsp::unload`](super::Gsp::unload) with a
>>> -/// [`UnloadBundle`](super::UnloadBundle) when dropped.
>>> -///
>>> -/// Used to ensure the `UnloadBundle` is run during failure paths.
>>> -pub(super) struct BootUnloadGuard<'a> {
>>> -    guard: ScopeGuard<BootUnloadArgs<'a>, fn(BootUnloadArgs<'a>)>,
>>> -}
>>> -
>>> -impl<'a> BootUnloadGuard<'a> {
>>> -    /// Wraps `unload_bundle` into a guard that executes it when dropp=
ed.
>>> -    pub(super) fn new(
>>> -        gsp: &'a super::Gsp,
>>> -        dev: &'a device::Device<device::Bound>,
>>> -        bar: Bar0<'a>,
>>> -        gsp_falcon: &'a Falcon<'a, Gsp>,
>>> -        sec2_falcon: &'a Falcon<'a, Sec2>,
>>> -        unload_bundle: Option<super::UnloadBundle>,
>>> -    ) -> Self {
>>> -        Self {
>>> -            guard: ScopeGuard::new_with_data(
>>> -                BootUnloadArgs {
>>> -                    gsp,
>>> -                    dev,
>>> -                    bar,
>>> -                    gsp_falcon,
>>> -                    sec2_falcon,
>>> -                    unload_bundle,
>>> -                },
>>> -                |args| {
>>> -                    let _ =3D super::Gsp::unload(
>>> -                        args.gsp,
>>> -                        args.dev,
>>> -                        args.bar,
>>> -                        args.gsp_falcon,
>>> -                        args.sec2_falcon,
>>> -                        args.unload_bundle,
>>> -                    );
>>> -                },
>>> -            ),
>>> -        }
>>> -    }
>>> -
>>> -    /// Disarms the guard and returns the [`UnloadBundle`](super::Unlo=
adBundle) it contains.
>>> -    pub(super) fn dismiss(self) -> Option<super::UnloadBundle> {
>>> -        self.guard.dismiss().unload_bundle
>>> -    }
>>> -}
>>> -
>>>  impl super::Gsp {
>>>      /// Attempt to boot the GSP.
>>>      ///
>>> @@ -107,6 +47,7 @@ pub(crate) fn boot(
>>>          let bar =3D ctx.bar;
>>>          let chipset =3D ctx.chipset;
>>>          let gsp_falcon =3D ctx.gsp_falcon;
>>> +        let sec2_falcon =3D ctx.sec2_falcon;
>>>          let dev =3D pdev.as_ref();
>>>          let hal =3D super::hal::gsp_hal(chipset);
>>> =20
>>> @@ -118,7 +59,11 @@ pub(crate) fn boot(
>>>          let wpr_meta =3D Coherent::init(dev, GFP_KERNEL, GspFwWprMeta:=
:new(&gsp_fw, &fb_layout))?;
>>> =20
>>>          // Perform the chipset-specific boot sequence, and retrieve th=
e unload bundle.
>>> -        let unload_guard =3D hal.boot(&self, &ctx, &fb_layout, &wpr_me=
ta)?;
>>> +        let unload_bundle =3D hal.boot(&self, &ctx, &fb_layout, &wpr_m=
eta)?;
>>> +
>>> +        let unload_guard =3D ScopeGuard::new_with_data(unload_bundle, =
|unload_bundle| {
>>> +            let _ =3D self.unload(dev, bar, gsp_falcon, sec2_falcon, u=
nload_bundle);
>>> +        });
>>> =20
>>>          gsp_falcon.write_os_version(gsp_fw.bootloader.app_version);
>>> =20
>>> diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/g=
sp/hal.rs
>>> index d3e47ef206de..851d1f24c137 100644
>>> --- a/drivers/gpu/nova-core/gsp/hal.rs
>>> +++ b/drivers/gpu/nova-core/gsp/hal.rs
>>> @@ -24,7 +24,6 @@
>>>          Chipset, //
>>>      },
>>>      gsp::{
>>> -        boot::BootUnloadGuard,
>>>          Gsp,
>>>          GspBootContext,
>>>          GspFwWprMeta, //
>>> @@ -51,15 +50,15 @@ fn run(
>>>  pub(super) trait GspHal: Send {
>>>      /// Performs the GSP boot process, loading and running the require=
d firmwares as needed.
>>>      ///
>>> -    /// Upon success, returns a guard that runs the GSP unload sequenc=
e if GSP boot does not
>>> -    /// complete.
>>> -    fn boot<'a>(
>>> +    /// Upon success, returns the [`crate::gsp::UnloadBundle`] to use =
with [`Gsp::unload`], if one
>>> +    /// could be created.
>>> +    fn boot(
>>>          &self,
>>> -        gsp: &'a Gsp,
>>> -        ctx: &GspBootContext<'a>,
>>> +        gsp: &Gsp,
>>> +        ctx: &GspBootContext<'_>,
>>>          fb_layout: &FbLayout,
>>>          wpr_meta: &Coherent<GspFwWprMeta>,
>>> -    ) -> Result<BootUnloadGuard<'a>>;
>>> +    ) -> Result<Option<crate::gsp::UnloadBundle>>;
>>> =20
>>>      /// Performs HAL-specific post-GSP boot tasks.
>>>      ///
>>> diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-=
core/gsp/hal/gh100.rs
>>> index 1d06405a32f6..18c889f9f413 100644
>>> --- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
>>> +++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
>>> @@ -23,7 +23,6 @@
>>>          Fsp, //
>>>      },
>>>      gsp::{
>>> -        boot::BootUnloadGuard,
>>>          hal::{
>>>              GspHal,
>>>              UnloadBundle, //
>>> @@ -143,13 +142,13 @@ impl GspHal for Gh100 {
>>>      ///
>>>      /// This path uses FSP to establish a chain of trust and boot GSP-=
FMC. FSP handles
>>>      /// the GSP boot internally - no manual GSP reset/boot is needed.
>>> -    fn boot<'a>(
>>> +    fn boot(
>>>          &self,
>>> -        gsp: &'a Gsp,
>>> -        ctx: &GspBootContext<'a>,
>>> +        gsp: &Gsp,
>>> +        ctx: &GspBootContext<'_>,
>>>          fb_layout: &FbLayout,
>>>          wpr_meta: &Coherent<GspFwWprMeta>,
>>> -    ) -> Result<BootUnloadGuard<'a>> {
>>> +    ) -> Result<Option<crate::gsp::UnloadBundle>> {
>>>          let dev =3D ctx.dev();
>>>          let bar =3D ctx.bar;
>>>          let chipset =3D ctx.chipset;
>>> @@ -160,10 +159,6 @@ fn boot<'a>(
>>>              KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn Unload=
Bundle>
>>>          );
>>> =20
>>> -        // Wrap the unload bundle into a drop guard so it is automatic=
ally run upon failure.
>>> -        let unload_guard =3D
>>> -            BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falco=
n, Some(unload_bundle));
>>> -
>>>          let mut fsp =3D Fsp::wait_secure_boot(dev, bar, chipset)?;
>>> =20
>>>          let args =3D FmcBootArgs::new(
>>> @@ -174,11 +169,23 @@ fn boot<'a>(
>>>              false,
>>>          )?;
>>> =20
>>> -        fsp.boot_fmc(dev, fb_layout, &args)?;
>>> +        // Keep the result as we want to wait for lockdown release eve=
n in case of error, to make
>>> +        // sure `args` is not accessed by the GSP anymore.
>>> +        let fsp_res =3D fsp.boot_fmc(dev, fb_layout, &args);
>>> =20
>>> -        wait_for_gsp_lockdown_release(dev, gsp_falcon, args.boot_param=
s_dma_handle())?;
>>> +        // Wait for GSP-FMC to release the GSP lockdown, indicating th=
at `args` is not accessed
>>> +        // anymore.
>>> +        let lockdown_res =3D
>>> +            wait_for_gsp_lockdown_release(dev, gsp_falcon, args.boot_p=
arams_dma_handle());
>>> =20
>>> -        Ok(unload_guard)
>>> +        match fsp_res.and(lockdown_res) {
>>> +            Ok(()) =3D> Ok(Some(unload_bundle)),
>>> +            Err(e) =3D> {
>>> +                // Wait for the GSP RISC-V core to halt in case of err=
or.
>>> +                let _ =3D unload_bundle.0.run(dev, bar, gsp_falcon, se=
c2_falcon);
>>> +                Err(e)
>>> +            }
>>> +        }
>>
>> IMO we should just ScopeGuard here too (after args creation) to run the
>> unload bundle. It will avoid manual manipulation of results which is
>> error prone (since a ? added later will break things) and also halt
>> happens-after gsp lockdown, so it's a natural sequence point. Also I am
>
> ScopedGuard here is reasonable - do you mean only for running the unload
> bundle, or would you also duplicate the lockdown release there so we can
> avoid using `and`?

I would skip the lockdown release path on the error path since AFAICT in
every case halt happens, we would have also gotten
`wait_for_gsp_lockdown_release` to return if we had executed it. So it
doesn't buy us any additional waiting/sequencing, and we still need to
wait for halt anyway. So concretely I think something like this is
simpler and as robust (conceptually to me it also seems odd to wait for
"gsp lockdown release" when boot has failed):

```
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core=
/gsp/hal/gh100.rs
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@
 use kernel::{
     device,
     dma::Coherent,
     io::poll::read_poll_timeout,
-    time::Delta, //
+    time::Delta,
+    types::ScopeGuard, //
 };
@@
         let args =3D FmcBootArgs::new(
             dev,
             chipset,
             wpr_meta.dma_handle(),
             gsp.libos.dma_handle(),
             false,
         )?;

-        // Keep the result as we want to wait for lockdown release even in=
 case of error, to make
-        // sure `args` is not accessed by the GSP anymore.
-        let fsp_res =3D fsp.boot_fmc(dev, fb_layout, &args);
+        // Wait for the GSP RISC-V core to halt in case of error. We creat=
e this guard after `args`
+        // to make sure that boot args are kept alive until halt, in case =
they are still being
+        // accessed.
+        let unload_guard =3D ScopeGuard::new_with_data(unload_bundle, |unl=
oad_bundle| {
+            let _ =3D unload_bundle.0.run(dev, bar, gsp_falcon, sec2_falco=
n);
+        });
+
+        fsp.boot_fmc(dev, fb_layout, &args)?;

         // Wait for GSP-FMC to release the GSP lockdown, indicating that `=
args` is not accessed
         // anymore.
-        let lockdown_res =3D
-            wait_for_gsp_lockdown_release(dev, gsp_falcon, args.boot_param=
s_dma_handle());
+        wait_for_gsp_lockdown_release(dev, gsp_falcon, args.boot_params_dm=
a_handle())?;

-        match fsp_res.and(lockdown_res) {
-            Ok(()) =3D> Ok(Some(unload_bundle)),
-            Err(e) =3D> {
-                // Wait for the GSP RISC-V core to halt in case of error.
-                let _ =3D unload_bundle.0.run(dev, bar, gsp_falcon, sec2_f=
alcon);
-                Err(e)
-            }
-        }
+        Ok(Some(unload_guard.dismiss()))
     }
 }
```

WDYT?

>
>> not 100% sure but I am not fully convinced that
>> wait_for_gsp_lockdown_release will correctly detect all errors if they
>> occur.
>
> The failure path is a best effort. I don't think we can guarantee
> anything as it doesn't appear to have been designed with recovery in mind=
.

Yeah I agree, what I meant is that I think that I think that the wait
until halt is a better signal that we are definitely done than the
lockdown release one, and it's easier to just only wait for halt in the
error case than to also manipulate results to wait for the lockdown
release path too.

>
>>
>> With ^ change,
>> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
>
> Thanks!

