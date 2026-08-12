Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB50C5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:18:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3784E10E0FF;
	Wed, 12 Aug 2026 22:18:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="FnZNHQpy";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010019.outbound.protection.outlook.com
 [52.101.193.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E91910E0FF
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 22:18:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKvrhX2kLNLoAgfvdVSFQxdafYFhnP/1tZfhxoLpEb7s+3i7hZA4VSjV+zSCIvfW1L3TSa1hKoNM76bhDclRA0qH82rez2PD8BVSC48THFqMreM2G9dKTGP1+7FJKj0zTv+xh6GCjpuryG/RZI00FtsaCFjW0y7QkFHsOO4uHATvBrO3h3gqGKRE9Ukj8iPW1UJ/wybaZWjBMxThsUZThqVb9DM/LISUNgGmBXAwt256ZAmgldvbad7+6TDGcsNHj1GeaHUF+2RCuiyrYgDpA6mICLfIhGKhxtTFIfm4knvYcDUR9kxu9GEQEebbDdAojeo/RZH2Q/SjTO9rNEgBXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rB27bqgp72E8ROZQt6W6quy2nP4RrJiBqG/aAiETPjE=;
 b=NsMePK5va8s+jaLb+kFbEHs9Z9me7sWVQRrjJ88G/Vixq5O/fowPJ4un5edBUZEEO/DQckVbxFcDtIOD5O7E7vozWVrbxT2yiXLeSRbduKv+RvPGO0gdUDsA9BKfFYyl1XqiU1KGVXPNMkaP2HVFVhXaUdgrTCnHSHEHwJf/xny3f1s4TFjcLf44ujSqYL5/cehpo9za202anbAf0881DWOFvPfvMa1mKrxBtjRRtrJb8NHBW9VzlnZGJYule5M14WgBWO5BO4+9gkFYpMfxOvRNfQoEG4VEN8eLeJm8YJVEqgZqb4Cr4MCaRVIP5OYu+I4301Iysu9FZDc5i1xj6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rB27bqgp72E8ROZQt6W6quy2nP4RrJiBqG/aAiETPjE=;
 b=FnZNHQpytmQvz5Uk6LmHi/wB5ma71LKEp8t468BsYvGwWDcZf0wovMef4PPTS18bvHJSwVKbzSiIft4nbGNvYzNBji7+UYzgir6mkdjITSS22V94ULO0A2GjXS+Qs3qTYis3PdOHRHEGybjJCPhWyC9D5/yiSzHCX1jbnFUnYru1PnAjGxUroEDRai/e40a4ZWDP7ycEoHOH6q9Y+89wv0iDtux8jOu6dirDbAS4D13CFhXQzXXemFlc+1dHAi+b9YgZDYw9aBf0CTUgKAIu+n2ngdmzllZzcysNsDCKbm0AG/9RNWvKc3oLANIIeA5NBQ/bZ5R5WEvFnu9sZ3LtfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CY1PR12MB9651.namprd12.prod.outlook.com (2603:10b6:930:104::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 22:18:22 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 22:18:19 +0000
Date: Wed, 12 Aug 2026 18:18:16 -0400
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
Subject: Re: [PATCH v5 5/5] gpu: nova-core: add ChannelIdPool
Message-ID: <anzxKO0X1OrNRD32@yury>
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-5-6c767770b3f4@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812-chid-v5-5-6c767770b3f4@nvidia.com>
X-ClientProxiedBy: SJ0P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::10) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CY1PR12MB9651:EE_
X-MS-Office365-Filtering-Correlation-Id: 8435371c-b19c-40f9-4600-08def8bf9d4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|10067099003|11063799006|4143699003|56012099006|22082099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: T6vzJW2U6Ub8JLFgEL9Ef23BGiO3LTrSVb3E1L/autICy08vIiskixdugML1ll9w8mmcAO+YxxjqN+0tfWvIwZR7LRSN3QqJqCbnQPA7MiSXv+C69lIsb70H3JFy4xgK6h0F0wQ1pj0IqUP6M0bQLEkbU5ICJ4nXZVKh0ZCf0XaFN0jDqsHl+KOSypMlZJ6sYQTXz5nZOj5mUcnffxdXMkIzgoB5JzjsCuyRzyZuqJ5cquW9yxyv0lmQRdvGvgKRslvGAyHEZ/8yYosOWoclFrNp8QWxGomAAKPpmm0r7/J7mKHIilCAseZNq1MKuiN2IB4SP9HXYGjDnkZRfn0SErzdoDs+jbjUqeBvA9MUo+cVhsVOV7AbH5QWoVxhIJe66bMsb0e21zGSrx0AHhVvyKqnUf9bbDocAFQjYQJJf8ttDv0C3DWPWpxDRI3iToYX990aTgY30GVrH+h0y8TMzDsYYGQ53lbMcTd0ldW7rOn4U7ZMCpgRuVuYaIFXjXbU5qqvmvG2k243njYyvx52Gi+qhNLt7UfoVwEHcZg1gFkq80DE/M6ZPfgwNXHgTPtN5koNIOS4iIyCmAeBxJJ+BRkSgoK5Ohl1Sd7aiNhgGYlOE2md8YgOp5PIUTCq6e5eITpfRCE8onk2SywBK7G8Mb8zt7e8U94zjqsp3/FNQy4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7tcHsimJTBpF/gBlpYWNDOAJKddQ+JuZciSoP9D+JDx/Xoz06dqnLSq06JQX?=
 =?us-ascii?Q?iyI/gIdJHKtK7gOpoOzRqIXzZjfTv9RnGRurDXjb3Szgb7DRVHehvWfgy7ob?=
 =?us-ascii?Q?fZqS+WDKyOGywKxB8aXX/3041V/Bx8EzHo5uy1tXntQu39PsbGra0YgeJOul?=
 =?us-ascii?Q?jPVHNbc40sEoyT6ZIOAyKic0j2Y9vCAjGUOPUtfdgCTlj881t4e9gq282mw8?=
 =?us-ascii?Q?k6DHRy/of8ykWKskt6R8JFdNgxTSVgfpF2vC2WkMMJSaLyt+t+eBNUXOdcaJ?=
 =?us-ascii?Q?I9bBGykS3w9cBFCNcdXeJ15O7S9rQ264A431ZG20jC8ZwVdf2PfTtRGkldpP?=
 =?us-ascii?Q?2ijeoKXOJEKckmdHifLekDiSNsSR8fo1lxRKSNcFm/lkbxeqWz0kIUkfnErB?=
 =?us-ascii?Q?95TAbk9DULi5ADpoxkCnWNUntyzs0ju6gqmdCMUPnLRjzUAXsr9zC2a7qTzI?=
 =?us-ascii?Q?a8vLe2twqhxFAeBmulLyiH8D3rP2WorFxdmqqWSvBtvFM8G2SRdBb8Cb0One?=
 =?us-ascii?Q?4RC2N2Tc0oR0frrWhGZBPZRdPJy3z7CvLGWGSZ94/oRVqWsRrT6DdF95HyyZ?=
 =?us-ascii?Q?SgJwQCThfaMNuDj+Fdsz9P7xrqlIEueF5XeJ6O68Bm0MBe3uEztLdt2Ex85n?=
 =?us-ascii?Q?pytoHTZ+uBBiWtSpa5wqJmL2dgyGGjEf6cVbjzuEQTI+qaIlrE/jgu5bY7jh?=
 =?us-ascii?Q?jcibdO+uei+cJ1YzAXehvYj/q2wx5DXDpb+urY5qrPb4+EjLBZfPhWL0r42I?=
 =?us-ascii?Q?pai3I7XScvoqCd+qYa6Wx4ehrO3pZnQq7F72uBHA/DtO4+UlxqWelU5TFwJb?=
 =?us-ascii?Q?UdId+TjiSnZXoJHLJd8zUXXxraAuPIHi25rbYJLP4ob0jYtvPjcu8BbbAmtI?=
 =?us-ascii?Q?MssA3SiC38+kN6g+RTeoYFVnfJ2E/VxIPHU8/YRgVhe8pF8+nAujM4T5Wa0g?=
 =?us-ascii?Q?iB5AInqNmcjvjp9OTSmbvzO+JUEUdtu0w8cJDKtxON53vYL2dcvoSXuN+kTG?=
 =?us-ascii?Q?tdjOLL+yTzY+fvSuVMkAl3vS8YZ8iEcNP3RpFlC08XCs3IRLZv3GoP5a2bpC?=
 =?us-ascii?Q?7g1VYS+ZWK69lkvwxgEniYNYLlJaY6GwPcAKYQgChpHro05ASo4nxOh2dfig?=
 =?us-ascii?Q?ykHLEKJ8wS19h9zNfldyZ9ALeCcByRTsdsTpSO8j+jyySN/nn+EAxnDPHq9u?=
 =?us-ascii?Q?iwx8KnPhitgKwREhrfoaZvZUFa+X5w2w58JKdP3wuilAkdDtS/7H1LdHLpBm?=
 =?us-ascii?Q?hpDXpInM9jxQKx4G3coPQaEtP0HeDwXWTFV2qFplVy7eMAAXmGy9E3D8yGey?=
 =?us-ascii?Q?q6uT3G1JG5n07TTou2qowup/c748jhbazNP7YKUVVyU5H2VGeEnkMo+9I2UQ?=
 =?us-ascii?Q?TrlTLypWoJ6420UAsrzJjaB+nnJGIoFMch5rXWIMa8fn+MJRCaV+EnBC0jl+?=
 =?us-ascii?Q?EnusK3J0ht2rTqt8nQ4hU5lHALuBBfpkl90/BqrbqMch+xOk7IP3kdaIZt2E?=
 =?us-ascii?Q?6RMHrOpEm87WEMUsk3JpvmtAFk17KgN/QLa+yLVzzBrMy+URVUz47dYtYawT?=
 =?us-ascii?Q?QlVjn/8kQ0yQZnBmOBnzynbUQReZ5O/AqUYTo5ohH19+6P1hunpJqVV19zuH?=
 =?us-ascii?Q?R9u29eRBPBYG3zOvdASB9mo/jc4kTD228vg0oAcN6w7li0zBzOjDJmPTfiLQ?=
 =?us-ascii?Q?FauzgqBq84x0r+DES0w3cNJDkp1/5kPOV+2okrIyVyJgyBDgPxU/cfeXtOb4?=
 =?us-ascii?Q?kd83YHoXWg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8435371c-b19c-40f9-4600-08def8bf9d4b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 22:18:19.6811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aoVOVFPSYCPKSBVkAT4rOp+6kdll0KIoG19FQc+J4EsSLPuZ9s8n6zWnAz+zfc4vsyS2yG3Zj+eSbDoKg/s5RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9651
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

On Wed, Aug 12, 2026 at 05:51:25PM +0900, Eliot Courtney wrote:
> Add `ChannelIdPool` which adds automatic tracking and releasing of
> channel IDs on top of `IdPool`. This is necessary for apportioning
> ranges of channel IDs to be used in e.g. vGPU.
> 
> Channel IDs are allocated as a contiguous sequence with a specific
> length and sometimes a specific alignment [1] for vGPU. The ID space is
> small (limited to 2048) and allocation is not on a hot path, so a
> bitmap-backed `IdPool` is a better fit than IDA/xarray (which allocate a
> single ID within a range, not a contiguous sequence) or a maple tree
> (where aligned allocation needs an alloc_range()+erase() retry loop that
> essentially reimplements bitmap_find_next_zero_area()) [2]. It is
> also faster than maple tree [3].
> 
> Link: https://lore.kernel.org/all/84bc8bd2-e292-4b84-9580-a1b5df4c5bdc@nvidia.com/ # [1]
> Link: https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@nvidia.com/ # [2]
> Link: https://lore.kernel.org/all/20260717053241.916441-1-ynorov@nvidia.com/ # [3]
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/gpu.rs         |   2 +
>  drivers/gpu/nova-core/gpu/channel.rs | 180 +++++++++++++++++++++++++++++++++++
>  2 files changed, 182 insertions(+)
> 
> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index 42a4cd7971fa..66ea697a89f8 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -33,6 +33,8 @@
>      vgpu::VgpuManager, //
>  };
>  
> +#[cfg_attr(not(CONFIG_KUNIT = "y"), expect(dead_code))]
> +mod channel;
>  mod hal;
>  
>  macro_rules! define_chipset {
> diff --git a/drivers/gpu/nova-core/gpu/channel.rs b/drivers/gpu/nova-core/gpu/channel.rs
> new file mode 100644
> index 000000000000..b755d2184aee
> --- /dev/null
> +++ b/drivers/gpu/nova-core/gpu/channel.rs
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> +
> +//! Channel ID allocation.
> +
> +use core::{
> +    num::NonZero,
> +    ops::{
> +        Deref,
> +        Range, //
> +    }, //
> +};
> +
> +use kernel::{
> +    id_pool::IdPool,
> +    prelude::*,
> +    ptr::Alignment,
> +    sync::{
> +        new_mutex,
> +        Mutex, //
> +    }, //
> +};
> +
> +/// Pool for tracking reservations of channel IDs.
> +#[pin_data]
> +pub(crate) struct ChannelIdPool {
> +    #[pin]
> +    inner: Mutex<IdPool>,
> +    num_chids: usize,
> +}
> +
> +impl ChannelIdPool {
> +    /// Creates a pool managing `num_chids` channel IDs.
> +    pub(crate) fn new(num_chids: usize) -> impl PinInit<Self, Error> {
> +        try_pin_init!(Self {
> +            inner <- new_mutex!(IdPool::with_capacity(num_chids, GFP_KERNEL)?),
> +            num_chids,
> +        })
> +    }
> +
> +    /// Reserves a contiguous area of `count` channel IDs starting at a multiple of `align`,
> +    /// returning a guard that releases the area on drop.
> +    pub(crate) fn alloc_area(
> +        &self,
> +        count: NonZero<usize>,

OK, here you use NonZero. Please do that in the lowest layer.

> +        align: Alignment,
> +    ) -> Result<ChannelIdArea<'_>> {
> +        let mut ids = self.inner.lock();
> +        let area = ids.find_unused_area(0, count, align).ok_or(ENOSPC)?;
> +
> +        // If the pool is small, the backing bitmap may be rounded up to a larger size.

Not sure I understand this language. Your ID pool is a fixed-size. Or
do you mean something else?

> +        if area.range().end > self.num_chids {
> +            return Err(ENOSPC);
> +        }
> +        Ok(ChannelIdArea {
> +            pool: self,
> +            range: area.acquire(),
> +        })
> +    }
> +}
> +
> +/// A reserved contiguous area of channel IDs.
> +///
> +/// Releases the whole area back to its [`ChannelIdPool`] when dropped. Releasing locks a
> +/// sleeping [`Mutex`], so the area must be dropped in a context that is allowed to sleep.
> +#[must_use = "the channel ID area is released immediately when unused"]
> +pub(crate) struct ChannelIdArea<'a> {
> +    pool: &'a ChannelIdPool,
> +    range: Range<usize>,
> +}
> +
> +impl Drop for ChannelIdArea<'_> {
> +    fn drop(&mut self) {
> +        self.pool.inner.lock().release_area(&self.range);
> +    }
> +}
> +
> +impl Deref for ChannelIdArea<'_> {
> +    type Target = Range<usize>;
> +
> +    fn deref(&self) -> &Self::Target {
> +        &self.range
> +    }
> +}
> +
> +#[kunit_tests(nova_core_channel)]
> +mod tests {
> +    use super::*;
> +
> +    const fn nz<const N: usize>() -> NonZero<usize> {
> +        const { NonZero::new(N).unwrap() }
> +    }
> +
> +    #[test]
> +    fn chid_area() -> Result {
> +        let pool = KBox::pin_init(ChannelIdPool::new(2048), GFP_KERNEL)?;
> +        let unaligned = Alignment::new::<1>();
> +
> +        let first = pool.alloc_area(nz::<48>(), unaligned)?;
> +        assert_eq!(0, first.start);
> +        assert_eq!(48, first.len());
> +        assert_eq!(48, first.end);
> +
> +        let second = pool.alloc_area(nz::<48>(), unaligned)?;
> +        assert!(first.end <= second.start || second.end <= first.start);
> +
> +        let first_start = first.start;
> +        drop(first);

You test the drop() only once. Can you add more tests? At least, make
sure that 2 allocs followed by 2 drops ends up with an empty pool.

> +        assert_eq!(first_start, pool.alloc_area(nz::<48>(), unaligned)?.start);
> +        Ok(())
> +    }
> +
> +    #[test]
> +    fn chid_bounded_by_num_chids() -> Result {
> +        let pool = KBox::pin_init(ChannelIdPool::new(4), GFP_KERNEL)?;
> +        let unaligned = Alignment::new::<1>();
> +
> +        {
> +            let a = pool.alloc_area(nz::<1>(), unaligned)?;
> +            let b = pool.alloc_area(nz::<1>(), unaligned)?;
> +            let c = pool.alloc_area(nz::<1>(), unaligned)?;
> +            let d = pool.alloc_area(nz::<1>(), unaligned)?;

OK, here your alloc_area() means the find + alloc, and it returns
a Range - not area.

To me it looks like the intermediate UnusedArea layer is excessive.
If you just do find + alloc in this pool.alloc_area(), you seemingly
don't need the UnusedArea.

Can you try without it, please?

> +            assert_eq!(0, a.start);
> +            assert_eq!(1, b.start);
> +            assert_eq!(2, c.start);
> +            assert_eq!(3, d.start);
> +            assert_eq!(
> +                Err(ENOSPC),
> +                pool.alloc_area(nz::<1>(), unaligned).map(|_| ())
> +            );
> +        }
> +
> +        assert_eq!(0, pool.alloc_area(nz::<4>(), unaligned)?.start);
> +        assert_eq!(
> +            Err(ENOSPC),
> +            pool.alloc_area(nz::<5>(), unaligned).map(|_| ())
> +        );
> +
> +        let head = pool.alloc_area(nz::<3>(), unaligned)?;
> +        assert_eq!(0, head.start);
> +        assert_eq!(
> +            Err(ENOSPC),
> +            pool.alloc_area(nz::<2>(), unaligned).map(|_| ())
> +        );
> +        assert_eq!(3, pool.alloc_area(nz::<1>(), unaligned)?.start);
> +        Ok(())
> +    }
> +
> +    #[test]
> +    fn chid_area_aligned() -> Result {
> +        let pool = KBox::pin_init(ChannelIdPool::new(16), GFP_KERNEL)?;
> +        let unaligned = Alignment::new::<1>();
> +        let align4 = Alignment::new::<4>();
> +
> +        // Alloc 0 so the first fit for the next area is unaligned.
> +        let pad = pool.alloc_area(nz::<1>(), unaligned)?;
> +        assert_eq!(0, pad.start);
> +
> +        let a = pool.alloc_area(nz::<4>(), align4)?;
> +        assert_eq!(4, a.start);
> +
> +        // The area skipped over by the aligned allocation should still be available.
> +        let b = pool.alloc_area(nz::<1>(), unaligned)?;
> +        assert_eq!(1, b.start);
> +
> +        let c = pool.alloc_area(nz::<8>(), Alignment::new::<8>())?;

Is it possible to make it somehow simpler:

           let c = pool.alloc_area(8, 8)?;

All the parameters checking must be a part of implementations, not the
interface.

We had a very similar discussion in the bitfields implementation thread,
and many people in CC list of this thread spent quite a long time to find
a way from:

        let color = Rgb::default()
           .set_red(Bounded::<u16, _>::new::<0x10>())
           .set_green(Bounded::<u16, _>::new::<0x1f>())
           .set_blue(Bounded::<u16, _>::new::<0x18>());

 to:


         let color = Rgb::default().
           .set_red(0x10)
           .set_green(0x1f)
           .set_blue(0x18)

Can you do the same here? Please refer:

https://lore.kernel.org/all/aXCZeVqkDrBWr1uq@yury/

> +        assert_eq!(8, c.start);
> +
> +        // Only 2 IDs left.
> +        assert_eq!(Err(ENOSPC), pool.alloc_area(nz::<4>(), align4).map(|_| ()));
> +        assert_eq!(
> +            Err(ENOSPC),
> +            pool.alloc_area(nz::<1>(), Alignment::new::<32>())
> +                .map(|_| ())
> +        );
> +
> +        assert_eq!(2, pool.alloc_area(nz::<2>(), unaligned)?.start);
> +        Ok(())
> +    }
> +}
> 
> -- 
> 2.55.0
