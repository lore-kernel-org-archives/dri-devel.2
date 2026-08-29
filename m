Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57CDC61DBE
	for <dri-devel@archiver.kernel.org>; Sat, 29 Aug 2026 17:37:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2BD810E161;
	Sat, 29 Aug 2026 17:37:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="KU1tNFhR";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013061.outbound.protection.outlook.com
 [40.93.196.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AA6F10E161
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 17:37:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrGOIGb3BmgDe7CpeGV5nxa9EMhvmzB5QMZ3OPiD8CGvdQW0G5z+kKZpd/9S9JnrxNkkscwnXAtavxUW1bcXO+l3353YOvzwjyToMZRQAkV3GNWd/8gsuptrAHmSG6jN20CGpCaEzJtLxTV9Q7l7VwRHelBIe5VyEv2zUDiRNkV35UbwpL32VKOD7V67rsevhpivHwtV6ONcgM/TCB+89jRUctQkDIA5iDcmyn+YKUikiRB2W/Mk4u1fUrHykyO+IV5y4b8WDnqwrSJjQIut5dO6LODBE/7TQxlR2yCqnXipHXv2aYKQFX79mxcTmRgBCSo5mLxirQGd9jlEEVsMyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSNq/+gsBbKwxVpnGUmImlTj6jYvGjBhWOGgf0o5lNM=;
 b=TKHjonoX94L7aFxomAx8r9ZH8iNIJNXzaABCm7gdxziVdOXBjpCU9maQfqTwNjph2vIyQM4uct+ce0YwOcLmsZFHuIF6LHZKZf0u5zmrBg81DL+asO65WnyHjFT964wdahKTnXREjaNi5gi7cpW1GDQUilpnUhvNkE08R5HKKqts5gLNhLsPdFXWyeEMMN6e1gZ8mQHEIPHEamaHVGfT/t752lSLn0/8bpkKBotzT26yPXVrTCwMKkfcSwb5OXN0JQNfehM0pgNfkvGPd/4GfQBl1efE0/hf1hJzZvOAjY8mrucQzwk/T84VJIqGxtHAJZk6I80DlWFEGh2gu3zJGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSNq/+gsBbKwxVpnGUmImlTj6jYvGjBhWOGgf0o5lNM=;
 b=KU1tNFhRnJ811Te7dk2AbE6OxOt3VLmz1O0ToWbH21rYYr7hYFwL87P5MIe4uyY1aPj5mD9nWwmqT4sJ4gaLlM0UTTYgkBjsbwUzjk1pRV1RHHxnFomz5ZqkQIwywNEgWVfzwqEcvlaE8FYtAdLVDJ8Z1LBblxcWkZIWehMvz6eVkkIWB/Sh2dPpVebDBAmg/lPRtBlLy4LK1zGqD+MTsyyVqLU6t9mKFqg8kgMspugNe0Y0Sxw9l39XjTqU3s0m1nWYe3y8AN7frKTNJ8xeHivXsjuFQisC8+Zw1Swe08C9tHcG5rpZ9+k9kUa6w/fh0ylIe9PZOmYd08csXPL2Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by IA0PR12MB8351.namprd12.prod.outlook.com (2603:10b6:208:40e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Sat, 29 Aug
 2026 17:37:36 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 17:37:36 +0000
Date: Sat, 29 Aug 2026 13:37:34 -0400
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
Subject: Re: [PATCH v8 11/12] rust: id_pool: do not round capacity up to
 BitmapVec::MAX_INLINE_LEN
Message-ID: <apMY3lO6LlEHP1Zr@yury>
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
 <20260827-chid-v8-11-bc74c77d0214@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827-chid-v8-11-bc74c77d0214@nvidia.com>
X-ClientProxiedBy: CH0PR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:610:33::30) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|IA0PR12MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb2258c-da44-41c4-3d17-08df05f4369b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|10070799003|7416014|376014|10067099003|11063799006|4143699003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: y9Sfc+Jok1Um+PJ57Rmwcu1UnJg1Z/NYRVFb+vowEaR+4Ku29qfJgwlAF4itWZNrHoHvGVDby9p1vP328lR+lZmnwNV8DvzgwDcO8DYKUOkITIp/h6+nip+YNaUpUYbXr7/mLFkcxYRsAtr2CWQH1UtcaZ+OkX/Sb7cbjdVZ1v4Ttkb84jGmGvn5U/Wg31TgYFO/Qg3eqxcqLZOvatU55SlRpDv9ag0uKVvT8OeDRydmXN1hZDOdWuLs7HRwOlUE8eOn+A9uWF9KUVwN9J79NbNFk4TArqw9IYM0x5+qrTw339WmUVA6Wz5bnYF7qsNV/o7hwJlDIoCooLhUbCvIJ/2InhK7FpB1GdNKypfC/W3o01S0Mrwh1Y6Bkdqz9Kr+IWz9KXZ2ReoaQ9CQ+zufabm6Lu6zMC+MzcIeiz58sO9KXnJ6wQ0jt2E3lf9hCZ40qfEnBQ4AK/vZwgwfgJs2HrHMdrvudyWoWkU4UQ4Xi2o3PuPII+Rbnc4t9vvOsrjwvLP8ECHbBHR9FU3XJvjofhTwCpb37jkQWxZL2spB+vNp6MzYeV6emzmhvfOToakmZEsRq1a8Ewf2b/1mkiZYSss1MOpvz0oHc5OvMN6+FYcL5Ou4JV+7QkJZsAl0OjmNvIt16y8hmaL4a1TDrYOzOuYVlXT4jiLduWhSDmPiGBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(7416014)(376014)(10067099003)(11063799006)(4143699003)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jNRurTn/AWLvLP0tEDiTGvmHrMkzePX/aSAWJU6TRM8AzIL/aXSufhg65V82?=
 =?us-ascii?Q?fji4c1Nu2ciPa3M7Cd3eri4QvGAKkpD5ysxFg381t2kn0Q8/fT3Iig4fTGs1?=
 =?us-ascii?Q?Z/BQZQ+vRHdUlnTc49PtQuQ7eG4NWrKMp3eRSMGwg/afw5uaIt8k3RkHVwWH?=
 =?us-ascii?Q?rAfnd08rUIhrJAuBQ1kRdVUd2isovm+9rCWaJRHX5gNx02QxFKfUvSQKzaLt?=
 =?us-ascii?Q?i56+ksyBdwSBBJ3LMmdmbpnog9n02DCqpwNVwPmsw8E2mCyzQTJfPNkfk1Iy?=
 =?us-ascii?Q?tBzVIXzmRv5dGYyThvC2KlPy4sGXbl7vKveTegUJgW/EqWBxQy/mmNJiJWO2?=
 =?us-ascii?Q?yckgHcq8HZk7j7rrL2CrFN8bSVdWDTJGqKl0JCMGmtqhanO15vAHQQSpl3Jw?=
 =?us-ascii?Q?Mas3bC2LLGPYdjIvs/7myyPdOOU/SV86w0OD7qKYlPX4ZuyvF4KWq0HXI04m?=
 =?us-ascii?Q?K5pbk4hvhxIQmmCHhQSn//Mh8ti3IyQIf8Xpt1yasPqE2UhqLX/FO6legGlM?=
 =?us-ascii?Q?AEwbVgXv4UWDTa38SwfBjueQMLVcjWv8m311xQWgQzCZUnTujw3HiSyo1hRk?=
 =?us-ascii?Q?sGvKDFRv3aSVPQ+/afG1/ealhHWcCJNe7m02z+Hk9pAPMHBagfq+Rzpw9ClZ?=
 =?us-ascii?Q?0ifQuuR2iS42VzMqunF30MHChIXoP3MCS75vIgyGi4W0WISWy+lYXFc8RDy3?=
 =?us-ascii?Q?DhdkpyoUpE/q1piGWTEdUDNIM5kxkJBYUj9zXfnNcfTGaucv2t8L7cju78Ke?=
 =?us-ascii?Q?1aRYqQYK/15f3p/6Gtrp/dOdp1unUZfE9c417xtcpAgH9AQLrnCnU0u0K1H/?=
 =?us-ascii?Q?QC6WedeiEQszoVCKcKPVHBA+OlTWt3Excnpatj/ku/zjxmbssdJ36TJFJAcN?=
 =?us-ascii?Q?0sQ6TFp1eqpecSAfXmqx+gV4MugOoWvBOZUOWzXTCIACure5GOY+I8mCwD6Z?=
 =?us-ascii?Q?ekmOb4W/vLGrJSlBzqiFWGNVVHPb/HJvFDrgQuVKjiFYI7CiCU70lqM1lCSE?=
 =?us-ascii?Q?QBAfJ2/wQS2ObONF5I+vSE8tOkqaCdPZ+xKvsPidnWdSmxnt/KN7jko9ZXSP?=
 =?us-ascii?Q?eGV9U0EtOd3VIG8ITNnCGZ19zeggx4aEDQvLkfYTCE2+ZlpUND/UGdpZhV4T?=
 =?us-ascii?Q?JCxxVutjsfU+wzke4BDITKVWySjhAxJ4tAfHTj6FxQoTgFjxlS96QZSJyWZC?=
 =?us-ascii?Q?bdzoJ5nNqy8rJfMG8MM3ZZwO2rPnBCqJJtj3yu3zI+SygVcbbolekc8xKWxi?=
 =?us-ascii?Q?6kvosOg7vBMiIfrFStHUP6KavaEEzoXRYkif1SzVjSwE1uYKM4km5VDINiGO?=
 =?us-ascii?Q?Gukc+vHHgLnVTeuRwPGiz3IOrhnybp0Tzl1pgvefn0cWjHV6CGLDjNisWkZQ?=
 =?us-ascii?Q?A9VQPu2l3Edh4qBEo7QZx6dytZR+8TPugwwM7Qag7ifdXYSWMvfgABBpk4Du?=
 =?us-ascii?Q?wbAEOhkotfnSyH2fMU+2feGWsGdzQ7W6Kto0LwIdT2o0sw5VUVridUQlMXtA?=
 =?us-ascii?Q?FKFbuOTWMkHqwXwNN3zj1W2hYxRfzfSiF8mPFFy8dOlvzKiyU7kegT+MwJ3V?=
 =?us-ascii?Q?Ik1WwVBu6D4SrIL+fJygjvu0IhE4iqRrE/6lQaqikX4QYhYNf85WIn09kcIP?=
 =?us-ascii?Q?H1/vjQrTMHubk9naD6MdgEwlu+8FEHljrIbAN28pGP8O+IYDODVLiikVhsOX?=
 =?us-ascii?Q?XOBFh6ZhP9YorP1T4W1P/vpm36CXMV5n8drryXNDUmMIUZZBKzVZc8P9ZDWQ?=
 =?us-ascii?Q?X+3ZnOg1JRKroaeiAauMRHPqI8tCgcGD2fDYoP4ubem3koiFgE22fjZy1gAD?=
X-MS-Exchange-AntiSpam-MessageData-1: DIeW0T0tOxyMcw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb2258c-da44-41c4-3d17-08df05f4369b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 17:37:36.0907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CW9076Gbfikbrg1Joj6ZlNu5QatVYPyR47u+277HzTpzLmIt1MiMIX6dDys3zc3lHMxKv1PcCLXg+b+aLKie8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8351
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

On Thu, Aug 27, 2026 at 04:28:39PM +0900, Eliot Courtney wrote:
> Current code in IdPool::with_capacity rounds the capacity up to
> BitmapVec::MAX_INLINE_LEN, but BitmapVec::new works fine with values
> smaller than this and still uses an inline representation. Remove this
> behaviour.
> 
> This allows specifying a real capacity of 0, which was not previously
> possible. This breaks `grow_request` in this case, so change it to grow
> to at least `BitmapVec::MAX_INLINE_LEN`, mirroring the capacity floor in
> `shrink_request`.

It wasn't possible previously for a reason: allocating 0-bit bitmap is
something questionable.
 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  rust/kernel/id_pool.rs | 38 ++++++++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
> index 06a4c71c4c6c..4f329249df9d 100644
> --- a/rust/kernel/id_pool.rs
> +++ b/rust/kernel/id_pool.rs
> @@ -112,13 +112,8 @@ pub fn new() -> Self {
>      }
>  
>      /// Constructs a new [`IdPool`] with space for a specific number of bits.
> -    ///
> -    /// A capacity below [`MAX_INLINE_LEN`] is adjusted to [`MAX_INLINE_LEN`].
> -    ///
> -    /// [`MAX_INLINE_LEN`]: BitmapVec::MAX_INLINE_LEN
>      #[inline]
>      pub fn with_capacity(num_ids: usize, flags: Flags) -> Result<Self, AllocError> {
> -        let num_ids = usize::max(num_ids, BitmapVec::MAX_INLINE_LEN);
>          let map = BitmapVec::new(num_ids, flags)?;
>          Ok(Self { map })
>      }
> @@ -152,6 +147,13 @@ pub fn capacity(&self) -> usize {
>      /// let resizer = alloc_request.realloc(GFP_KERNEL)?;
>      /// pool.shrink(resizer);
>      /// assert_eq!(pool.capacity(), BitmapVec::MAX_INLINE_LEN);
> +    ///
> +    /// // A pool at the `MAX_INLINE_LEN` floor cannot shrink further.
> +    /// assert!(pool.shrink_request().is_none());
> +    ///
> +    /// // Neither can a pool with a capacity below `MAX_INLINE_LEN`.
> +    /// let small = IdPool::with_capacity(8, GFP_KERNEL)?;
> +    /// assert!(small.shrink_request().is_none());
>      /// # Ok::<(), AllocError>(())
>      /// ```
>      #[inline]
> @@ -198,12 +200,36 @@ pub fn shrink(&mut self, mut resizer: PoolResizer) {
>  
>      /// Returns a [`ReallocRequest`] for growing this [`IdPool`], if possible.
>      ///
> +    /// Grows to at least [`MAX_INLINE_LEN`].
>      /// The capacity of an [`IdPool`] cannot be grown above [`MAX_LEN`].
>      ///
> +    /// [`MAX_INLINE_LEN`]: BitmapVec::MAX_INLINE_LEN
>      /// [`MAX_LEN`]: BitmapVec::MAX_LEN
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::{
> +    ///     alloc::AllocError,
> +    ///     bitmap::BitmapVec,
> +    ///     id_pool::IdPool, //
> +    /// };
> +    ///
> +    /// // Grow goes to at least BitmapVec::MAX_INLINE_LEN.
> +    /// let mut pool = IdPool::with_capacity(0, GFP_KERNEL)?;

Please don't add explicit examples for creating ID pools with 0
capacity. It's a factual error, and should not be explicitly expressed
in documentation.

Also, it looks like your 0-bit bitmamp would trigger bitmap assertion:

 IdPool::find_unused_id(0)
   -> Bitmap::next_zero_bit()
     -> assert!(start < self.len())
       -> assert!(0 < 0)
         -> panic if CONFIG_RUST_BITMAP_HARDENED=y

I like your version because it allows to create an arbitrary capacity
for ID pool, i.e. 4 bits. Right now one can explicitly create ID pool
for 4 IDs, and allocate up to MAX_INLINE_LEN from it.

But 0-bit ID pools must be prohibited.

> +    /// let resizer = pool.grow_request().ok_or(AllocError)?.realloc(GFP_KERNEL)?;
> +    /// pool.grow(resizer);
> +    /// assert_eq!(pool.capacity(), BitmapVec::MAX_INLINE_LEN);
> +    ///
> +    /// // Grow doubles if at least BitmapVec::MAX_INLINE_LEN.
> +    /// let resizer = pool.grow_request().ok_or(AllocError)?.realloc(GFP_KERNEL)?;
> +    /// pool.grow(resizer);
> +    /// assert_eq!(pool.capacity(), 2 * BitmapVec::MAX_INLINE_LEN);
> +    /// # Ok::<(), AllocError>(())
> +    /// ```
>      #[inline]
>      pub fn grow_request(&self) -> Option<ReallocRequest> {
> -        let num_ids = self.capacity() * 2;
> +        let num_ids = usize::max(BitmapVec::MAX_INLINE_LEN, self.capacity() * 2);
>          if num_ids > BitmapVec::MAX_LEN {
>              return None;
>          }
> 
> -- 
> 2.55.0
