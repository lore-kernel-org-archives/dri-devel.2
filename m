Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A1BCA5FAB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 05:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B9E610F181;
	Wed, 30 Sep 2026 05:05:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="IzWJp0c2";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012061.outbound.protection.outlook.com
 [40.107.200.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3DEA10F181
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 05:05:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PeWKRqRq411Ce3cREzpBy7mkbSAz5y/cIYbHAdCiGWskxwmaM6hQVmwi9bcGoVx76tYYlmBSFnuR5VDR/8kmuNlP7Gv84nTMZEuJk+wtt5ALsOgHfqvIZP8Kv8vCPLf4+YSmg7ZyYjFZzsLBTF3e+YXoHnWdchcGTcfz8RiubxlhWNF5tS3ZP42YpukS08mzOpDhIQSHmvU8aDZLqwAX1IzkrrB1Eah84EPudW0TcGDk525M3Dpv+4+u2BjoxC2Za90STOTGOb5eBe3mseirbHOOpnolNYp8inZVNNSqOCEBX8N1CUp0zfto7dENmOVtvN6P3vDdN0ftM8NdV9a2zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jw5cIa5GjyGy24dW1l87AJVmW3oyf3PVvrtB+QRL7Ug=;
 b=nE5vyoAUnzuz0shHw6FG76JvX1u2d/hRxTmPfFtlS9xO1pNFUvZA4ub/DvR01u40kE0BX307HQJCK9wi0No1wdLdUY+f01bxsnqulCTaSGsLWramGxcNZCXy7Ay/QxECCY4spd76TM7Q9hxbr+YA/hsRjgYk6If38ba+6QJ1w6K07ZiC8FsV2tFv9sgJhGotf9oJE3WwMF3l0V8QJKzQq0uKQmw3tuPAg9hHwIgteZmzJB38NHuApBvWIybnTR5Gx4nQOue++GoU/c9T7ICNxrxGCVi0bbU+amIKkglJjCXXAM2dgduXNBimAcRSPg/kG2/Cq2k934eExNJ0uyX6Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jw5cIa5GjyGy24dW1l87AJVmW3oyf3PVvrtB+QRL7Ug=;
 b=IzWJp0c255zz4uUCCQh/qnwrYlMNdZz3eTcedmyAGuhlyC0crpFIhvz2coEZZSnXm8J9WKLpOjhxEANZNQkDNoJTggD2EBMJwUtSc0+WBNx/wGbtBX51as3Tdfe910g08ZW5CuMQhSKIaZwOcK6J/VyPFhN0yVFFn6UFChNEdAJidSrGAeSGk1cjOeuV74uaf3Los52jQkBq00IQODEhXup1rkwtevgkjDBoOkfFtUzZ4/aLmwAGJ6k0Yf3ipUprOBiNIzzqIs/hYK5OJEpDOltvTaB8aE0kD0AybhFO6KnxAZ3Hjoq1+xIWA27+3nuJoXWug4LUPjtmVGXmYEKAZA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CH4PR12MB026689.namprd12.prod.outlook.com (2603:10b6:610:506::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 05:05:24 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0451.026; Wed, 30 Sep 2026
 05:05:24 +0000
Date: Wed, 30 Sep 2026 01:05:22 -0400
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
Subject: Re: [PATCH v9 8/9] rust: id_pool: do not round capacity up to
 BitmapVec::MAX_INLINE_LEN
Message-ID: <aryYkkB9j14xnWo3@yury>
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
 <20260930-chid-v9-8-0d6cca376cff@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-chid-v9-8-0d6cca376cff@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0210.namprd03.prod.outlook.com
 (2603:10b6:408:f9::35) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CH4PR12MB026689:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e753d1-c5a4-423d-1acc-08df1eb06f3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZOQ4uOCx5vLHv91xem2jhcKQnF1lGfqCkhQgGiu6aImI7EPhpMPabbUL3lOvcOQweansDEFHb4K8LQZpteTwCkYpAOrqNGJcMvYX3jIGT1ZDCDI7lmvoGVNuPgIuYmd7oan/GmG1KyJLke9VO/B5EkOHzQWilC1HF5gcZXmHLCo1xUPARqn1FSo1dWSOR0PoWsno0RlBNFxmEFnF87MDfhTG5mOg9kKSR8VXixeOQEP88r2DjMnrzpEkNg0gioqvZY/LBEBcy3Lc3iZ30WKMboaBsB7KuWPeQEwlCbDbDjYs5evrTtpjlx5lhBWjQ07lcCCon5aOhp12JMPMSKV2KeUltekWmI94OCRztYvGOIUqROReSC2Zsa6BDjhlspkK3I7PqN5DN9hvmSCcpIf87fTtoqOrKLUvZwfiuD6oiTnsorNMIPIpr4BAdrDOmPw+KSwD5rX17GNUIAQdNTPfOtgSkuB/8lLQ/CzW7qS6kUTtxXy0ilY1bxJjRcDPLBsFX3THNBWLklQrstZJQmx2M5rfA1paMq0Hi/4atuBLSlG6MFn1Ccab8L5zG9rywMYJ1TZ1+CMbIrnPwu1JpJuCskhY6R2valcHwb+TnBfGLK+fzV8n3YbYWN1X+bPH1MsqTs4f4KTEbm8qDD8KewuB0M1Qz36is5gRV/ZF0Si4iIc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7J56jB3l7h+fMOIhn+obrpvTeLobS0hVmHsq3PVr3GTyrebbPa/3Qw8sM4KF?=
 =?us-ascii?Q?3hkt5HD/cBpt3fL3KwXlb1im3U2crtpgl7QjnIZaJ75WSE0V3ElG++FCMG3J?=
 =?us-ascii?Q?Xzk3y4n8I9Dla+b2eEyt+140FxcnMVZeDqmOHWtiB0yz9j4mWkwVlnkhQLO0?=
 =?us-ascii?Q?WgfnRK6MNEfk29VsaMCi9CVIwQtkmtya5o4V53vf8/PuynFdJxqAoKKgl62h?=
 =?us-ascii?Q?1induOwn9nwmD6GPjgJJwcsnLSBJ06R+wdGGzuTLPGy4D1O4xaKzyxu8MJWv?=
 =?us-ascii?Q?NKNBn4POc/980+eNl2ZwqvZ4KHa1ZtMPk/ouwXyr419EYJ2Xl8mS9+0P0OIt?=
 =?us-ascii?Q?vM+MVyifp9lwiomkUatHwwZqq/O6zipFw1tidUlXZ53rtpDlYq8rtFJVBRIy?=
 =?us-ascii?Q?nKeavcv/8JxUKuppxeDhk89ZKAtWFTb+U4jSrRx9jZ7kS/ckB+33/5wj+ZMx?=
 =?us-ascii?Q?Hr/V/Z/7P1Sf93UeAzQAqqGyafkQ3yEo4ikbiQNu7tLcGFHrOQDMt8zGVI/E?=
 =?us-ascii?Q?zdhEMcnRJydnNyV74a+3W27+gppInyuOaxX34Ibg62mN8ljuaCBY9OcQeDuG?=
 =?us-ascii?Q?jBoRTk7EuA3gyxflAw0zriGvxp6UIBck7kq4pyVVepgvmJAN4otwj3gbQCaA?=
 =?us-ascii?Q?wpBPfii+gAuXVrkGo/QLcRYeqkG7iEZsPWmnX12j5+DRmOFGxNWFRAWlCl9J?=
 =?us-ascii?Q?/Fub8DLgQSry2/8s3qEKLucWMN2LFwmMznHVNakYnuoXciTx9NRYa1VxzH0H?=
 =?us-ascii?Q?cbEGdgB6KnlG+zVQTIDxzoK+Y94VOrGxVbUVx26WlEbQr3wcmVKqbyF+vb7Z?=
 =?us-ascii?Q?0VLEVCMX54nbr4YTtykEaRuByzx9Mt37xLpTwFhSqjzhYvtY6aTEALn9cApO?=
 =?us-ascii?Q?MIUcmWWEdPDWnG14XgTiqGcH+EGwQCHluFxWOV2jmkXuEwZmoOtDpB27P5G5?=
 =?us-ascii?Q?OAYn8wirJ7fnmCnXyit1KwWQOEhQ7L02ld9QsQezdwcL+z5B1o5Cq1oeWBtd?=
 =?us-ascii?Q?7sDXa/a2rczKgodnIZ7dhkx7FQEnCStQclIkzSbufeLWlvnp8db9sTKQVGve?=
 =?us-ascii?Q?46AKH+aexelxp1zl7eycHLTVso1AsfpSqVoIIkD9D2nHo7WWX4idQRaEcb/9?=
 =?us-ascii?Q?J0lvxwIYlrhHyDe6KspGARu3kGgecxuokH6lTYe6MXi4gwjbDuVgpyNFK0B8?=
 =?us-ascii?Q?HQgalA+PVlSUwpRgU/vLFribg6Xfaea/3YXtyo3GkIbsx4hhTEiiL5qnWsQ6?=
 =?us-ascii?Q?j6kHQcWYf/v2ucS3ozvz3iTZK5+4PTVOu4BMFmqVodbC608N/qst56tWMwSP?=
 =?us-ascii?Q?Xosh29jMq+gJIPMBstTfkpNrkcxqhCF0pfXjlqO7O3mNni5kaIHLQ6AneUgA?=
 =?us-ascii?Q?TFwW1TmsyLxVpiOcMypugvZ/018oj+rxp5fxwxLO4FaB8kB01Zy6gVNIg9Lf?=
 =?us-ascii?Q?YA6cQM/sbKGgo88wLXaq/ON3kug3T0cDTxVf4oIsJyrCH4Z+WrF19B55YtCw?=
 =?us-ascii?Q?S5P0LC/R18zfNNl7ANX3CgCGfF14WxloV4V3/FZc8bzBs2JsOigtiaFKsNrw?=
 =?us-ascii?Q?qqo/HDvQ40JzNucz/ZI9mIcz7NodxowXxwlJ4tKDtraKb+SM/BW8VY4vURqj?=
 =?us-ascii?Q?bHqXS0JXF6wV/n/yynQEGHinfVShjLw9ZyKbnLqU3wFLdQoq+CuNcBCrzoxN?=
 =?us-ascii?Q?Tih2crblNRtk+dOPkQahhA2gomFAIAyB7Cxz+FZfMrslMbPg+YymJBjuYYiT?=
 =?us-ascii?Q?AGVj1xUQHQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e753d1-c5a4-423d-1acc-08df1eb06f3f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 05:05:24.1170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJ+gSg9m+XU5lYB3F8rcQ7ITNVeri3V5BHyEDOpXoTGbhZoHCX9IDJnd8TSI5WhWmkXMlVOKWMkGtIHVtg7Ncg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB026689
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

On Wed, Sep 30, 2026 at 11:42:57AM +0900, Eliot Courtney wrote:
> Current code in IdPool::with_capacity rounds the capacity up to
> BitmapVec::MAX_INLINE_LEN, but BitmapVec::new works fine with values
> smaller than this and still uses an inline representation. Remove this
> behaviour.
> 
> This allows specifying a real capacity of 0, which was not previously
> possible. This breaks `grow_request` in this case, so change it to grow
> to at least `BitmapVec::MAX_INLINE_LEN`, mirroring the capacity floor in
> `shrink_request`.
> 
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

Allocating a pool with 0-bit capacity is wrong. Please don't put it
in the examples. I recall I pointed that this object would panic the
kernel if, for example, you call pool.next_zero_bit(0) immediately
after this. Sorry, but NAK.

This .with_capacity() should take num_ids: NonZero, after all...


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
