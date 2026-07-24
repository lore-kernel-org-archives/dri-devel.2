Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 275F9C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E77210F40A;
	Fri, 24 Jul 2026 15:06:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="mkKmBNT7";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010028.outbound.protection.outlook.com
 [40.93.198.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E1E10F40A
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 15:06:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cA/mgKAJl3ys5fyKcFLT4LZrlnmvwQoaM0PqCPqJVZf1qXsDHTKfmCWVR6x3BYmVjQ3peeRIO1h+70NTOVh7IqesZLJEyBm0QHkBSpvmXnAaWN332BzYgDTvTiiUsXyh9y+vns8nZh9n3jJ6T1TKXUbxxn4BwAtVTewgcQ+CNU5PPSpTtY4E/29MAWkruKi8VEaRCfX3LGO+9cucUgMA5fqRaAf1aS8tCFwOUYO4+IOTdqcFEobJsM25LF/vy+JZnJE6HHV9T6u04Rr7zlDWi1JgE/e/U6273ICr9Tzz8jI+fYT5arkKwFISwz9DBVaNPvq1ZvCTYvs0hPJFRSDt/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRUzmwtr1xNeWMpFmb3pkqNhD7toJKwCZYBloHDSSyE=;
 b=iceNAeo/GODOK4jAXXEp4myt4615RiNIntt3VE2UXmY/Gf044cd27QrYCiMW+B6iNf+ssrFAEX7IFms98Ye4UqJsX/UnU3yXRf/z4EIINRzZvT16UM4GEvkphaUmN3313YgrrSn+LpecqLAluwDEk354SBIIxr0uwyEOW8itovsESRqLLUgQ0BSFbmYSjpAuNuS++QnpeshYTdMCUPBhpmYL9j1YHHvVgbpbv5XMRNKs5dF44vZCk+Iz537R6VabZgXZ3mtJXcA0nIkNGzP7R6QjbC7uFh5H7K6n+KMoor242eSSoFOvBAYbaOBJTymNZNahceunls7V63QIXcA6Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRUzmwtr1xNeWMpFmb3pkqNhD7toJKwCZYBloHDSSyE=;
 b=mkKmBNT722whqVL9QsStrcnM/u+K7IwNsmFUMMsI5E7ydrT0//yFI3Qey5xmZaOxBvmsnh1FonJsoWjIz+QlrWus13VRq2tyZeinBs8MB+gZNjQjrnLCBrz1jdstDq5bulk9V9rFNsXTR5qWCW2OzcZJ5yHjHAoJRKW2a6OG4+hj1KhSjQ46Es4lrlhPoVxa1e96+IYmqSz8Jw4G3Jfgc/4Ua9VVs0YpjOfUWIiQ+gu6KvyJvJ9dlhknxxpGX1A3R0rcrR51iMG0hyzUbJdCP12mtSENx4boR70L5u2pgwDJwiIwd0rB3Fe9nZ78OLOGD5kTm1NW4eK0aVHLyE79og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by MN0PR12MB6150.namprd12.prod.outlook.com (2603:10b6:208:3c6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 15:06:15 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 15:06:15 +0000
Date: Fri, 24 Jul 2026 11:06:13 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>,
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 0/4] rust: Add support for reserving of ranges of IDs
Message-ID: <amN_ZfhoV9eF03Jr@yury>
References: <20260723-chid-v2-0-c35e5e9fb3d9@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723-chid-v2-0-c35e5e9fb3d9@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0725.namprd03.prod.outlook.com
 (2603:10b6:408:110::10) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|MN0PR12MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: e817a4c7-193e-4204-4463-08dee9951b19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: M1E9ivkTpTT7BBDp42YIj/7jGd5o5qv2c4rFl2E+WtDIsv0vEGdT7PGPnOGhQqxGxOYG+dd616cA+f0i9mvm/0Yuk5WYYLsEoDQKSL6Xl0sFqeEvXW/JKFa8aY13DBhn6711AhhhjJCXijQJycAZJtayF6v4E1sy2kyPvD+a6OLLp8AeA1hPYziQk8dQYBbU2JAwv6zZnVTaKNHcOy08PyihMww4wRD1ZkG0y+1s+hlF82ot/YKPw+ucnYaF7/AHGkpalyDxmvxzCflBvly75t2gur7LmrkbEgVgCEwjdfS63H/UsawpUj51kgqpG/SeiAstVkvktntSCw7G3914SbxrTqD4sKah9lvdo/IhHqOTu1rq3kYd1Z2/oGdYvHUwINfe5RpYrFCDyTI5mLaoa3t47wCh5XXfrn9ajaUv8Xu1Leqa4gcp0AELMFa/tBo5Zw+ErZbWWmm54XVKBRM2bTdJ4ilI2cBad2U2597WfGLOTKCTLUUouRfPI7uKx/c989AqU3msTfu7A5tOk4Rk7TR7CkM4R1ckjLuv/kzNAQrpG9+khmB1QllNB9ZVNquNYJiHSM/TPdO+rorjowM/q3qmJ6hOoVG/LJF0J+Oni51L8bPgve13+K75wD0RR6x7w2RMOuBiMk80RDPsGw9jaUPWAnrDf3/qeogR6mTd/nw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZL53NH3Oz7MyMatgbA6Hq3wfxreo4NjNNUBUl5wERIOqwiXx/EIXwF62ozEt?=
 =?us-ascii?Q?RnOUmpd8s9srjtJGVr1ZxSf+mBuOdZnCM9EvNTNdokqZHbs1qGni7kJZCW1f?=
 =?us-ascii?Q?MYZ8a4O8b8bKNtla/gQgi1xFWOQ/k4ClzAfHtisc/sb78zh9Kj4iiqZ56CFY?=
 =?us-ascii?Q?OM3UDw7KZnTIOoKMVMAtv3Q+Tf1DD/HarbJf//8sfTZIxRFlTff1hvLQKJKP?=
 =?us-ascii?Q?MAtqCgPKic2MbhcN2bmvNgyQerZIDwUvHwrt4YsjbTNwlgrByCS5CnGyJcqV?=
 =?us-ascii?Q?VOMBjHcRXGjpW0KS0pmSfcviawCcuo8gTE2fOl3EYAgZUMefjVm12/k0l4IU?=
 =?us-ascii?Q?cEOkLUxKW2brPFl5pYKH8IfdLRLgsIS9G2RnmrcZ2QU6zS7Y4bNiEk+f22VG?=
 =?us-ascii?Q?FxMfDeWbw3vfZGxlEQ9q0cO2jU2uTf/yuUuLHUpIy+0+h/+2KlejpfhtBIp4?=
 =?us-ascii?Q?RWLx4qT3+5f7RSuQwOr8iK4Hu4/szalDiuxCvuR+J8YIezIJ7XIksP3v25EP?=
 =?us-ascii?Q?pxz3JmzsKiq5TexY99z/Iz/LtFUVbF0Tt+1dahzzxlK7v6dNIqU775d/Dlj3?=
 =?us-ascii?Q?1o7kDgsWWJBAOe2rTCJZuXNggtD8GysYNvP59Mt4sgN60C4+hn/plQ4pQY/W?=
 =?us-ascii?Q?uImLsROFFFrNGObTl+dAM6MSDNLd8eA+Gm0/qxBbLfT2jiDzpkQIYb1XhnUD?=
 =?us-ascii?Q?n3hV8ZIloT32JrwHutaNVWUGpthDmvEBV/XjYDGYu+GXL1AUc3NKfOhUy8qO?=
 =?us-ascii?Q?uAI9dCHrMAiOASGNGVE5OY0K5JKkPrhqOSxm1N9Gi3tUlVbAeRG1qC8tnXwS?=
 =?us-ascii?Q?r0wXceYRnIy2p8twkmEBWlYh9kkq9RXbc2tZloZ/+0XbAdZpAitFic0/JPz6?=
 =?us-ascii?Q?O1tHaQNHZYvdRsCxfYztD8frUdq3pKiw2fddOvyD8aAOXMZ1r9+1MyofwzBA?=
 =?us-ascii?Q?1vR+1+lfGnJ5PBUP3KYwj6Am7ag8hVQugNoLwsrzfi2IVtC+agAZRnCL2rYX?=
 =?us-ascii?Q?K685rUWbD1e34m7/wgp91DsQLmkMRHM6VLjgmxNT4bGbw7bz7Uun554vAxoq?=
 =?us-ascii?Q?pHWJGgvV8G+R+sLMLEdGO4Dgl4UnoCoF4A5eIIQzSWzlmSCmWuxFy3oanHbc?=
 =?us-ascii?Q?thOOYCgT7fmzp1VOIVKBO96HmgADcULDSPgGp8WUdRVqnioYO8OA5IiQnN3k?=
 =?us-ascii?Q?axDoFHcEXuWfijoN+KXcUWO0FXJcEXX91PPNnK+CJlmdtSBVooFXq6jNhJey?=
 =?us-ascii?Q?tXzfKheTKuvz2ifDtCalMODdJc9iBeolWXoNLHCLH+Fr4OwGdj7maDDgPS2v?=
 =?us-ascii?Q?dzUhKCx7ZDeN5uWdR8CF5xyQ71I6kg6XstVM9v932lxEACPFqg0S77wDWr9e?=
 =?us-ascii?Q?W+rvN3JBpyLDNT6vq3Z94h2wkKi+8KoZ/EIQdM7359S9OaJrNbDCOVwqQQ22?=
 =?us-ascii?Q?RGXGluQpi28GF1PloqpdwWShxh19cCuR4vvW7WdoUELNkKP89gLZl0m4bop8?=
 =?us-ascii?Q?qitaljy+9GbUJWuJEHKhtlmMirbfYq7B89ByHeF405eOl8lvhpXDOBT6IrS8?=
 =?us-ascii?Q?nDUrZs80itPdL16fD/F7kd0KLNa7Y0/kdCeWmWipdDb3PFL4AAcd8Odezes6?=
 =?us-ascii?Q?qRJSoD2NK2OPW9XzIGxjTXEeXRob9t0fLCjgJbyLCwyp+bJcx+f4gZTKslET?=
 =?us-ascii?Q?1XjLS7BlsvMZn3yX0uf0KFcs0vL1HVUjlDye1J89a6+J3hGg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e817a4c7-193e-4204-4463-08dee9951b19
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 15:06:15.0641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kn61DkIoI5AwmZRaoe4TtYKGM4kcN8AAZfNv/Pb9mboGh4teM3VtIvRjjimxGe//BYhioXRzQ+LRdtWeVqdMLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6150
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

On Thu, Jul 23, 2026 at 05:59:09PM +0900, Eliot Courtney wrote:
> Add support for reserving of ranges of IDs, with a usage in nova-core
> for channel IDs. This entails adding bindings for the C bitmap
> API for ranges of bits, then users of that in `IdPool`, and finally a
> user of `IdPool` in nova-core, `ChannelIdPool`.
> 
> Channel ID tracking is needed for allotting ranges of channel IDs to
> vGPU guests, and later for regular host channel ID reservation.
> nova-core needs allocation of a contiguous sequence of IDs with a
> specific length and sometimes a specific alignment [1].
> 
> About the tradeoffs between different data structures:
> - IDA/xarray do not support allocating a contiguous sequence of IDs
>   (ida_alloc_range() allocates a single ID within a range, not a contiguous
>   sequence).
> - A maple tree works, but is not as good a fit. The ID space is small
>   (limited to 2048) and aligned allocation needs an alloc_range()+erase() retry
>   loop (plus a Mutex around it, or new mas_empty_area() bindings) that
>   essentially reimplements bitmap_find_next_zero_area(). See the maple tree
>   version at [2]. For 2048 IDs a bitmap is also considerably faster and smaller
>   [3].
> - The bitmap API natively supports aligned contiguous area allocation
>   (bitmap_find_next_zero_area()).
> 
> This is based on drm-rust-next.
> 
> [1]: https://lore.kernel.org/all/84bc8bd2-e292-4b84-9580-a1b5df4c5bdc@nvidia.com/
> [2]: https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@nvidia.com/
> [3]: https://lore.kernel.org/all/20260717053241.916441-1-ynorov@nvidia.com/

If you refer my test, I'd like to make sure you've reviewed it and
tested in your environment. Please send the appropriate tags.

Also, would you like to add it to your series? I can to move it myself,
but I can defer it to you if you prefer.

Thanks,
Yury
 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
> Changes in v2:
> - Collected Alice's Reviewed-by on patch 1.
> - Address Yury's comments w.r.t. using __bitmap_set etc directly.
> - Address Yury's comments w.r.t. following the C names
> - Additionally check for an overflow case that causes a hang
> - Added more info to cover letter + patch 4 w.r.t. channel ID allottment
>   requirements
> - Add align parameter to ChannelIdPool::alloc_area() plus an aligned
>   allocation test
> - Add missing INVARIANT comment when constructing UnusedArea
> - Link to v1:
>   https://patch.msgid.link/20260703-chid-v1-0-84fe8259e46e@nvidia.com
> 
> ---
> Eliot Courtney (4):
>       rust: bitmap: use function-level cfg on kunit test
>       rust: bitmap: add contiguous area operations
>       rust: id_pool: add contiguous area allocation
>       gpu: nova-core: add ChannelIdPool
> 
>  drivers/gpu/nova-core/gpu.rs         |   2 +
>  drivers/gpu/nova-core/gpu/channel.rs | 182 ++++++++++++++++++++++++++
>  rust/kernel/bitmap.rs                | 242 +++++++++++++++++++++++++++++++++--
>  rust/kernel/id_pool.rs               |  69 ++++++++++
>  4 files changed, 481 insertions(+), 14 deletions(-)
> ---
> base-commit: 71d4e7233f235871b13553e504e591ace6b54373
> change-id: 20260608-chid-18fa943c6d6c
> 
> Best regards,
> --  
> Eliot Courtney <ecourtney@nvidia.com>
