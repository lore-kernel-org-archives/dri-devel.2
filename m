Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305E060A2634
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 17:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eAv5ciT8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8992C10E1A7;
	Tue, 10 Nov 2026 17:42:55 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012049.outbound.protection.outlook.com
 [40.107.200.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45DFE10E1A7
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 17:42:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6JPYAw85bjeE0ol0yj0Je1bHEKo4EtcHiik+kwUB1jbHb1IZBvv3uamxbrK/Wu/adt6Vhbvw1tQd1BD0OYTDmCLzTFcIbgYAgtRY+44gbRLMN09rkHIgqpLXkf7w8lqyQ0QQm6M4eh0FTUiLCFOIH0KX8EvtIf6BZCenilZ5ZmGZAqOkksMqRsHevgCNtU90a1ciIHfk7h+cXa0Doeo80AM1v3r2bBwV80kOk6TFxN6oYLgoPrxWknXC+nUuLq6WSEYQU0DE5Opfr4EkZGII/om7IrxVMpsmpQb6Us9l2k4NvgpxlrsD3BaDJyKFKfylrgbAc005Qmb1r+AJxaaNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ua/hyOt0QmKSRbaCjTGTZjvDr/jVP6WQyEboyZ0z05I=;
 b=wfGosz4pNOb9wBtHvvhrEVKiovNLdL9Fl3QfyASTL3s5UlrNjP5y+8BNGtAHKOAxIBI/v8HFwF/PuUJjMphz4OCQPGUb9ytDGS6k3Fq7cjHCASd8vsoYdAGgsDBUZFhBLlK7Vzz1/96Tbolvwh1W+U91mbFyCO0/lynw9QbRpx1bwLkvLo3gl4bIR3x67oVJ8isez8ba9JTjzprJaxQoQ0y4zib5n3DkkgMsOaUtpwpt59ssikrGkZDT84xxDAl7YMt0SJzEliXUV9nnIH+eUCllvuO3cU9iBajnEG0za3W6IJSjyaeUx9jz6/K0jC1kcVAJM11OJD+7HTjG5yrnCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ua/hyOt0QmKSRbaCjTGTZjvDr/jVP6WQyEboyZ0z05I=;
 b=eAv5ciT8K5JGaIaFmkYLrYip0+6WKZ/Ty2k26WNK58ZcvI3Q74wo0bJZT5/cWGu+ki7ZmennM+EnioRyOAImgA5X0hNJRC+AwZJSHgoVzGfxQgnI5CLXMhP30oZPoqKpfyCJlgHKUuQiDc0z5N3LanBAvUopare7t/uZ0z8A3wJtQvHPypW1f8JFV9R3KPerXJ4AqZ6732nbdP8HeYQOZ9K9z+CBaLxft76ZQHirnEDnIPRGG/LiR5Z43piWtr4zOoBoRvHmU8axdA57q2ZIR0ayWWKFQoRTdzDq4tscbwChEyrmZ597HHAp+mng6lKCG/39TiYV4tH/fu6z2Zn/Pw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by MW5PR12MB5683.namprd12.prod.outlook.com (2603:10b6:303:1a0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 17:42:42 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 17:42:42 +0000
Date: Tue, 10 Nov 2026 12:42:40 -0500
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
Subject: Re: [PATCH v11 4/5] rust: id_pool: do not round capacity up to
 BitmapVec::MAX_INLINE_LEN
Message-ID: <avNXkJjOoTzUu-1r@yury>
References: <20261109-chid-v11-0-082aa9bf5a91@nvidia.com>
 <20261109-chid-v11-4-082aa9bf5a91@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109-chid-v11-4-082aa9bf5a91@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0887.namprd03.prod.outlook.com
 (2603:10b6:408:13c::22) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|MW5PR12MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c05c00c-fda2-4507-239f-08df3f520566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|23010399003|366016|1800799024|261102123227099003|11063799006|4143699003|261021121427099003|261021123027099003|261021135927099003|261026140227099003|261022105027099003|261026121527099003|261009223027099003|56012099006|261028144727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Fzs9Ik34rLunTU0sFsco1XSW/WYNe25MtlsLE6LbCTjVY9dggU+gkXadty9nFW/A6R4v+CTDAAfDW6AX1k2KNXg32wlz4Qfd388vk7aDQdlDIq0rTZ8TpPb5YVrt1xsJabNlfxru94SwWR2kS7NwGCIwxCc6Nr48hdr4JzmWG/ohEXOIc/CCt1Yyw8L1ucyB5r453HI/SdNPtIHiRXNkvauErt2DUfQiT3Sjx1Vz1FrRPtNW26d4tRLWsAwqWyml52uECDZCU7aVQpk/vF3U4KG0DnI/tjigmJTvOxUTPRF4dw4WqLV1p3ULKzFSwy1xP7WsxQ933NhLTXFp1OkZLGJ3QmjtGD51gd+bdYErEtNXReXVw/HK2eA+M8Z7EimdNpRU3mCL0T6aS/ixeny/EGTHBQI5hgmCfi8yfAUITeww5cfrXO+V7imcIRa9/4VNVux/zgQPQSaDgB1beU3V87k1qXy/tC0HPvRvhDypfQwx+OXX6P5v2EHriQW4pxUr4GmAZr2yhEgVAwdzFujG9/2b0VCqOkWP/5f2nP5dPPUhzZdLcRiH3MdZkSPuTs9TEmVHcViiNQ5G9TXdopzZ8BJtTM2LYUp4QCo6sIeg9tIHtF6+fMMCQ9nm8oc4zZCDKtDTzItUsi74Fz2LkbOE0eP/U23qiHSlkj3rgn43VTc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(23010399003)(366016)(1800799024)(261102123227099003)(11063799006)(4143699003)(261021121427099003)(261021123027099003)(261021135927099003)(261026140227099003)(261022105027099003)(261026121527099003)(261009223027099003)(56012099006)(261028144727099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zDN3b5HJ2gjxlhcgAPtbz6lWYH6a/ZzsZazUF13uyQZNRt+upoI/VONJb8ht?=
 =?us-ascii?Q?jckP4TD5E/g6SAawQ8Iji3qCPw+uccl/1i7pkilJWzWMjTgf8LSRJRUTNm6n?=
 =?us-ascii?Q?NTlNwahExvhjIJQeTXueCac5YQGWASK26nMzKQZCtBweOBev3SmGjSOwL+lT?=
 =?us-ascii?Q?Kp45DpvbPO39iIQ565zAYP0GlMedSTZ34fh4/60bEPSbUvo52gzi4JqJc0NO?=
 =?us-ascii?Q?Lm4QOY7EhyU8IWsG2zJatE8hWzYIMe98DYM5fTTw9sDJp2pPiibKZHBfHGds?=
 =?us-ascii?Q?F4eRhtrfGDcZK8n6R8ocmgB1xzcb9QfMlfX1UEIFdbJ6Ql5b0RPLIrxlywzO?=
 =?us-ascii?Q?8hURHtR0Zra6wRmIeMdn36zZYs2kkUsJxxh0AEjHDAh0D4YDmflvIIXrScK6?=
 =?us-ascii?Q?12zjD/UJs4hYZbACSPCEDHZL3m2Bm7GgguEexth6NL0grBN6UFzahY8JO1xE?=
 =?us-ascii?Q?1Xo6FEhFdkzvBxvFwHVwZlah/IeVpIyi0QA29petAbkUkXQ9ayK/s39HqiiD?=
 =?us-ascii?Q?fFwjA3HJqfgSMHPr39E6xFr5ju4gNGBPyftNU0rLO633+ibTELQXj/1gSL8g?=
 =?us-ascii?Q?XtfCFjca8VYKy3/NOSl3OigXhqyYkZrNnfITort0i6Sd7kFgiSxiJldXUvRe?=
 =?us-ascii?Q?Tx6BnaWGbUVZ30Q2aH3/Tuqp+RrLQuiG9Ah8nEP/V1GLlkYNsSMdfhiD0X84?=
 =?us-ascii?Q?bPgynyvJgjAFTEB3K9c+SIot4w3UR2rjQEuCJgg1VvE41qQOybkmV4gpYIAw?=
 =?us-ascii?Q?Yxh4a0ZvdgEy/D0ZUe6VFBTvHSqZvzZpkZRbRiP03eskzsc34LKo1hzK/Zau?=
 =?us-ascii?Q?PAzvhlzEiNqjJ7O1+Ij2hyU5EcXxZfp+Lnv8+vNG5liSNHE2KQFtTqo+ctI6?=
 =?us-ascii?Q?FF/jnQr+1sEOuLMpCXdWqZadk//IbFcFShV+zf9I92/BSfVbGAh7Zm4pqArI?=
 =?us-ascii?Q?Cj3q4lMy7/FvzvihAkqx18yQdfxOxg+CodmEnWe52UxyT1PrEyX75XUUj+k9?=
 =?us-ascii?Q?kpR8LyqaMleR8FzqOIujzYRdC6g9UwF5fJmqmkSX4bLVe1PHsigKT2dZV2yI?=
 =?us-ascii?Q?8xbeHdHykAqoh2gpatPSB6mgwuwlkqE+lf3d6wjlZbGwQID0eQDXZ1OXL5Zr?=
 =?us-ascii?Q?/ienbG4MCvoYgVZiZTZ+3zav5hASFf/EBYpdkHgtUaehzCZXwzYsXaWZUSSh?=
 =?us-ascii?Q?iMAoqXfaYQhYM6rN0WEA4o7HMXZSN+9Xur0nIxTb8/Ete8B/Jd5YEKOmsxZB?=
 =?us-ascii?Q?myCNcpVDZv1pDFI4bpUURDc3c9khqI9JAieIG19rIys6XZ1DNuOZMGk78o9o?=
 =?us-ascii?Q?tjoBolrwHzs23NdJn6hmppFLEOb/0Sdu2nedF0LVjq1myhce6d0Ptn5bTmKP?=
 =?us-ascii?Q?/eQX7N01udA5hmvBpuMiIHVn3HFeeEQRoBwwhv2t/CJDHQ4G9Yc7Axq0Qo6y?=
 =?us-ascii?Q?S0+R02D2z9pKm/2zU0ls4DUay6XdkJl/AM/PTjKHGcHb/N3J6J6PMHqrvKIz?=
 =?us-ascii?Q?8Ege9UIkd+T/tbkytx4/X6T4GZUBruQOkksYEbt60QMGOaOC4ql7C8SvD9jO?=
 =?us-ascii?Q?NghFSUOPQlgVqVkerF4nVgeo00JmCgRhdJ2e2LR2CUyzqNmAKKWZ5YQZXvxM?=
 =?us-ascii?Q?SakLoxBSUO0/XBy6GgJlw1fvtSK+/Y5oEwXa2IlZ5HMF5C5HjA+BZwRAD4cw?=
 =?us-ascii?Q?/1Bmmo0N3fp2TLS54QScRHQC22cnRtPog6II2+czRc35hLS8OFvRw4agJ/5b?=
 =?us-ascii?Q?D61bQXaIZzFjxriH9kmcQcCbbAJEOBG/Oa/dNigBVp8ngy+1BB6S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c05c00c-fda2-4507-239f-08df3f520566
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 17:42:42.2473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XqoH9kf5M5N41uS9+sy4oHh0TC4NSk1yKnMbxwCZtSRDoRwidf0Xyc6XuWR9VCJE/gFWKCn7aImOeEIrcPTC5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5683
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 05:32:52PM +0900, Eliot Courtney wrote:
> Current code in IdPool::with_capacity rounds the capacity up to
> BitmapVec::MAX_INLINE_LEN, but BitmapVec::new works fine with values
> smaller than this and still uses an inline representation. Remove this
> behaviour.
> 
> This allows specifying a real capacity of 0, which was not previously
> possible.

How real capacity 0 became possible? Did we eventually find a use case
for it? If not, it should not be possible, and the implementation
should not explicitly handle that case.

> This breaks `grow_request` in this case, so change it to grow
> to at least `BitmapVec::MAX_INLINE_LEN`, mirroring the capacity floor in
> `shrink_request`.

Not the grow_request only, I believe. I recall the discussion about
panic on most operations on a 0-bit pool.
 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Burak Emir <burak.emir@gmail.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  rust/kernel/id_pool.rs | 38 ++++++++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
> index 92eeb7caa243..f77bd90325ff 100644
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
> +    /// let mut pool = IdPool::with_capacity(1, GFP_KERNEL)?;
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

You only need this max(...) thing to fix the behavior of 0-len bitmap.
We don't have any users with the request to support them. Please don't
add any extra code to handle unwanted and unsupported cases.

Thanks,
Yury

>          if num_ids > BitmapVec::MAX_LEN {
>              return None;
>          }
> 
> -- 
> 2.56.0
> 
