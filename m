Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D669E606A32D
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DNfh+2eQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3464810FDFA;
	Wed, 11 Nov 2026 20:47:37 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010021.outbound.protection.outlook.com [52.101.56.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13E8B10E460
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 20:47:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0SKenQf4mcffcGhdHMDL/VLQVyzfOIMk58t52TIEfaGzuLgmDm4DMTnnjTwg9/87QVJFdYgWFlGLZul2bieNWiuPdesVPGdsjKbBycTmlTgxAwHjJ+GfPDQPPc0syRaYqcn/0W6dRIKpwLwiX9h0Wxbt3XepUuEvjkfYkQCpXmUdFdSbu0igZCw1G/It9dBH2LvQWJlFD8OpqTDxg/14rx2KfiTQj1lKzmg/GcqJggxlrr/DfJYW9WS/P+8obajcNdVP5NvJ8DYhR/634hLq+vgzvPK64OZ3pXgqqPbsMGwPrjpym2AA3rYL1rHqiLwuqDnR6jM97Yc/drob3gZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Na6ndTZniISHVBzl5iqz5UYWXSzKlLO7N99KsHmGVKE=;
 b=JcH6fVdgxp8hEqlKuGKc54mX6TWhIKD0x/kes5RsztzpWI1InrJd+FEraHaQrUxsZfet3iz8CfqpC3/GbzZg+cEKx1VELb/MsqCxHHKbXbEuycLbGLQ/hwaKOgX3iPHqM32/LyoGa6AnIx+WxJAxNDO6UXa3QRqrys/rDsOkmeJGNppuCjmXrEe7mRkA1yMTQnB5ndMH4p0hliZM326yTV9MUblCQ6cyhRFdA4SihWcfN8pZ7oPj3INmvDdtTgFVnhng1NDA/eUMKvS+jSw1DEqvFUjF3+yFkL4s+SGYg7rX96c6QoOzGqsMuH89MQnRb1QlHUyHPnyWR/Zxa04JKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Na6ndTZniISHVBzl5iqz5UYWXSzKlLO7N99KsHmGVKE=;
 b=DNfh+2eQ3jfXwIBkOdpH7X+IyYp312I23wCpx+UuL3VzzB5M0MebFlX1VD6sUCs0lIY6moSNMfw1Iz1XhX8IN3Hmr/t/+UHj0N1sA6N/bRc2sb4/To7rwllBb8Ref4n0htbhnqYCuQovvrXNXtIHrZ7lnKph77G6/0pMddaDiPTZKYM0qZspzvG12TpIZXQvzanOYyYMUpCirQGmPnFCHGLYq2Q0H4qgrnUc+K4xeU9HAf6Rk9E2hnH5LUIJ/PyWXt20SMNRdd6c583XzdBdEu3tqvgaGaxNDNbIRCxoSZVREK9+qS6D+YP8egu0H+kIeAKB2AnpSkdtDnweXHkEuA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by PH0PR12MB8128.namprd12.prod.outlook.com (2603:10b6:510:294::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 20:47:25 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 20:47:25 +0000
Date: Wed, 11 Nov 2026 15:47:23 -0500
From: Yury Norov <ynorov@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Eliot Courtney <ecourtney@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 Burak Emir <burak.emir@gmail.com>,
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
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
Message-ID: <avTUWznKqpgUI5M-@yury>
References: <20261109-chid-v11-0-082aa9bf5a91@nvidia.com>
 <20261109-chid-v11-4-082aa9bf5a91@nvidia.com>
 <avNXkJjOoTzUu-1r@yury> <DMRW81BTJRI1.6KL933YC1FM8@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMRW81BTJRI1.6KL933YC1FM8@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0701.namprd03.prod.outlook.com
 (2603:10b6:408:ef::16) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|PH0PR12MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 682bc37a-4822-4c60-85d1-08df4034fdbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|10070799003|376014|23010399003|4143699003|261009223027099003|261021121427099003|11063799006|261021135927099003|261022105027099003|261026140227099003|261026121527099003|56012099006|261021123027099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: L4CRZQxTueq66H32Y4+dtXgIRTEcdD0PLiJM+kisaNtT7r8mCFmQ66qIAPYMfwMSZoLM/2UO+Odh1r+RSqoNCTyJ8NsztY9yftAhgUbWSyrWvYfrimDf3QbSD1EN79MYnWAMsDoXk2FPPVUuMHIPGZi5DfCTuvOA3qmyapSfYE00dixwglMe8sOUi4Pm3XyDTbMCM5Xi1GH4HQquakvmolevEnpAbCtGQJbaDTJoHLOzcSnYe6vXuYG3AgQz/QEZFdNqtUE+G98n+RFH1NNtnWYW6e28E84aLUR7go09fDW7iqGwXJz9udBH+JW31Pt5P5GoKPngIDIsUukz1NdMHSq3FN73k2jYZZ3X7QAgS4QC0F6alXT/AljCds/VmMPHxeSrEhNyV+nhui1g7h2/nEn8sbRdwMv8w1fMyfGLz0kqYxEvJ2ELpxTIvMAHUdyiDEeIwBS6xyGUqXq9OQY3S5O58L37rsg7AkKPGYyP28aPiSq7QR1r10cOT9iKlQB0BZCw2W4ywQC+AGZwewecMbpyM3zuS8EtZKi04aaoOXARw/Ap5KeVWXBe4dJEZnQd6OIWPzH7kfnMEH4O4//F0NLFUeG4DEKUkGHNjbKxBM+YcvSGT9LPwgFTMnqM1h+gD4Jkf6GoFaN8mAnQVUcVEtYSDAQbGilX2xMc64nwBM4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(10070799003)(376014)(23010399003)(4143699003)(261009223027099003)(261021121427099003)(11063799006)(261021135927099003)(261022105027099003)(261026140227099003)(261026121527099003)(56012099006)(261021123027099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C3+L5vU8mzVoM7J7QXhopWKn0t7A7BODtl+N0GH5vC9ol8QycV8pSLPh9bvy?=
 =?us-ascii?Q?r5A0ahow08/teY4WqFGvNlqWTBCDWLxfFUDGRSAa8FfgNFIncX9eV5sxlbNV?=
 =?us-ascii?Q?DFMCx5txWiqu8SqYVWb8oP4vLiJikkeBuH9E79eCIzJQd+IMLwp7YyIOhUJ4?=
 =?us-ascii?Q?26bAEvaCYU9VHsYSLfZdQ6kyWjlEbShkiRFybzLw5KmcBpXTistST7NthKvY?=
 =?us-ascii?Q?eXUrCIMPvnl3LpNL8N4kFk+9m5CBzuAWuadSiOnaWUP/F82HXH4yn9wWMtRc?=
 =?us-ascii?Q?+RPyIl3It8CQS168sbDbJWfS7vIfjO/dbTqco2W024eENe6enqf9KHGoAMH8?=
 =?us-ascii?Q?ChJeVauSOwPTon/irT3qwzTgaDdxz69jZptygwh4vX5xQ5xwDCgTYdnsaw5J?=
 =?us-ascii?Q?lpU9PU0WRWbpEdPvqEpB3G8l4PLjn9bveVPlt81VJk6aSEikBItPOS5pUqIH?=
 =?us-ascii?Q?hX8ReFkpUG/sjXrTY/PSAZ7IGAZNJML+TKtbWa4bfF6LMDcuYRvgv5kLn4oI?=
 =?us-ascii?Q?XsAaj+FoJ7H+i+BM8eGBL81V0Dx45sYlqAbEq/hkML2Nd/hF5YO50M8jOwH8?=
 =?us-ascii?Q?qFsloWjsmvxiC4xtAkMl5kBf19AN0jeQNXrt1jJyWZJySVXI856MXuC9kvG7?=
 =?us-ascii?Q?rap6oqJOZDo8Z8LwPjLs/C7Z5Zxz3qC7+Up33A8yYvoWUMxmBofq1fij2ypu?=
 =?us-ascii?Q?X/Vj4XKz1kJSH1zlZukjEgQt9ml5bgqsMsnsqDpWBpyY0hTyCsI8goqDJ9Qw?=
 =?us-ascii?Q?SdjqshC3tCblY2BBcnf6/IqpwVLFs/jJFf9R8VnSCUNI/uuz366T83GranT0?=
 =?us-ascii?Q?WBTNwuiFXWIWSpFR+xeGxSZRlVecPEbneTnGQ5Uq4rWS8RIdxFBKNaathzxv?=
 =?us-ascii?Q?YpSN65Uxb9Rn57r+t/oPboctPTyV7diz8FiQ/Uky8A5BcKkZctEoyGIgfHSj?=
 =?us-ascii?Q?WQEGLRsW1fmPif4MGVh0EaKb+zf0UI4Y9QaUImex3LIYmql99Ee5Ux4SxGtW?=
 =?us-ascii?Q?rAQQ/QLMj7P8n7Bqgt/B95JvAelQpY8RU8BiTTBlJ9MVhVBX7ZJt6oFRD9Wn?=
 =?us-ascii?Q?jxaTJue/qIrDcRSbfc1PMUdWANjx4SFk/2dMx2F9GDStz41qmhKgfmpwwtbg?=
 =?us-ascii?Q?eWNkVMFHHthKCqksjKcfrF9pdlwPYTeDDGwARh5qbHk7Cuy4GC4byEncT48P?=
 =?us-ascii?Q?hj1fRFD5vfnTXrQeeNXEQLrcJjctcdH2VHVRDbrDa3bfHZvCiP5T85Q4/LJL?=
 =?us-ascii?Q?tt282sMh3mtsgZm+IN6CuB5QIZhqDD2JmmG8hoW0pp4JjtgGoT5AC0SqROCA?=
 =?us-ascii?Q?kiBO5CftHtC++/8LAv55zfI08T8uHGao3VPuv+rIF0SXZbLZPTHduW9UdOsD?=
 =?us-ascii?Q?WURji0/Byg373ZERP+P4tpClqfCn8RDtBiU9mOomTv0EnH7VAyGmpD0K6j2l?=
 =?us-ascii?Q?18VS7vBzv3f6Tq1VqWzd1kf/wjp/HpsM+lnN4QRxUO/ZuKDlhTPPngtB0KEY?=
 =?us-ascii?Q?G9bQdVge3b/mbTFq7AC7P9EhdIh3GPSVB96gi5AW5ZvHhZtT3RbgZTY7se1I?=
 =?us-ascii?Q?cPXvrs0DKUIr4NBkBj8HdbbiclUqX8Fu5wUnUQQpVhP8maNlDRLzk8bTzunK?=
 =?us-ascii?Q?O8A075QQZY5eAl3GOSN1i2k+cz4xA2ANsKdXL1l872zV0zMEQ/73dhP7GU9t?=
 =?us-ascii?Q?e3qzHHhIJTdW0RdcuUgiFz0mvItk8zym31qXYEGyCG+YRxngHWU6HATFznUH?=
 =?us-ascii?Q?U52GWPzPpBwpR/XniwJNkNHwuV+bqsuvzvWAIgUHujMUt3/TQcGy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 682bc37a-4822-4c60-85d1-08df4034fdbe
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 20:47:25.1076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjx/e3/47YoyrhOI3spNGyVGDnDMK7aNQSjOj3GLz4RWj1V49ZIUWRJbk0ZJbraohfW8f9z2/LRrEwYk5adY3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8128
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

On Wed, Nov 11, 2026 at 07:44:19AM +0900, Alexandre Courbot wrote:
> On Wed Nov 11, 2026 at 2:42 AM JST, Yury Norov wrote:
> > On Mon, Nov 09, 2026 at 05:32:52PM +0900, Eliot Courtney wrote:
> >> Current code in IdPool::with_capacity rounds the capacity up to
> >> BitmapVec::MAX_INLINE_LEN, but BitmapVec::new works fine with values
> >> smaller than this and still uses an inline representation. Remove this
> >> behaviour.
> >> 
> >> This allows specifying a real capacity of 0, which was not previously
> >> possible.
> >
> > How real capacity 0 became possible? Did we eventually find a use case
> > for it? If not, it should not be possible, and the implementation
> > should not explicitly handle that case.
> >
> >> This breaks `grow_request` in this case, so change it to grow
> >> to at least `BitmapVec::MAX_INLINE_LEN`, mirroring the capacity floor in
> >> `shrink_request`.
> >
> > Not the grow_request only, I believe. I recall the discussion about
> > panic on most operations on a 0-bit pool.
> 
> You have panics on most operations of a pool of any size if accessed out
> of bounds. Zero size is not special.
> 
> >  
> >> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> >> Reviewed-by: Burak Emir <burak.emir@gmail.com>
> >> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> >> ---
> >>  rust/kernel/id_pool.rs | 38 ++++++++++++++++++++++++++++++++------
> >>  1 file changed, 32 insertions(+), 6 deletions(-)
> >> 
> >> diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
> >> index 92eeb7caa243..f77bd90325ff 100644
> >> --- a/rust/kernel/id_pool.rs
> >> +++ b/rust/kernel/id_pool.rs
> >> @@ -112,13 +112,8 @@ pub fn new() -> Self {
> >>      }
> >>  
> >>      /// Constructs a new [`IdPool`] with space for a specific number of bits.
> >> -    ///
> >> -    /// A capacity below [`MAX_INLINE_LEN`] is adjusted to [`MAX_INLINE_LEN`].
> >> -    ///
> >> -    /// [`MAX_INLINE_LEN`]: BitmapVec::MAX_INLINE_LEN
> >>      #[inline]
> >>      pub fn with_capacity(num_ids: usize, flags: Flags) -> Result<Self, AllocError> {
> >> -        let num_ids = usize::max(num_ids, BitmapVec::MAX_INLINE_LEN);
> >>          let map = BitmapVec::new(num_ids, flags)?;
> >>          Ok(Self { map })
> >>      }
> >> @@ -152,6 +147,13 @@ pub fn capacity(&self) -> usize {
> >>      /// let resizer = alloc_request.realloc(GFP_KERNEL)?;
> >>      /// pool.shrink(resizer);
> >>      /// assert_eq!(pool.capacity(), BitmapVec::MAX_INLINE_LEN);
> >> +    ///
> >> +    /// // A pool at the `MAX_INLINE_LEN` floor cannot shrink further.
> >> +    /// assert!(pool.shrink_request().is_none());
> >> +    ///
> >> +    /// // Neither can a pool with a capacity below `MAX_INLINE_LEN`.
> >> +    /// let small = IdPool::with_capacity(8, GFP_KERNEL)?;
> >> +    /// assert!(small.shrink_request().is_none());
> >>      /// # Ok::<(), AllocError>(())
> >>      /// ```
> >>      #[inline]
> >> @@ -198,12 +200,36 @@ pub fn shrink(&mut self, mut resizer: PoolResizer) {
> >>  
> >>      /// Returns a [`ReallocRequest`] for growing this [`IdPool`], if possible.
> >>      ///
> >> +    /// Grows to at least [`MAX_INLINE_LEN`].
> >>      /// The capacity of an [`IdPool`] cannot be grown above [`MAX_LEN`].
> >>      ///
> >> +    /// [`MAX_INLINE_LEN`]: BitmapVec::MAX_INLINE_LEN
> >>      /// [`MAX_LEN`]: BitmapVec::MAX_LEN
> >> +    ///
> >> +    /// # Examples
> >> +    ///
> >> +    /// ```
> >> +    /// use kernel::{
> >> +    ///     alloc::AllocError,
> >> +    ///     bitmap::BitmapVec,
> >> +    ///     id_pool::IdPool, //
> >> +    /// };
> >> +    ///
> >> +    /// // Grow goes to at least BitmapVec::MAX_INLINE_LEN.
> >> +    /// let mut pool = IdPool::with_capacity(1, GFP_KERNEL)?;
> >> +    /// let resizer = pool.grow_request().ok_or(AllocError)?.realloc(GFP_KERNEL)?;
> >> +    /// pool.grow(resizer);
> >> +    /// assert_eq!(pool.capacity(), BitmapVec::MAX_INLINE_LEN);
> >> +    ///
> >> +    /// // Grow doubles if at least BitmapVec::MAX_INLINE_LEN.
> >> +    /// let resizer = pool.grow_request().ok_or(AllocError)?.realloc(GFP_KERNEL)?;
> >> +    /// pool.grow(resizer);
> >> +    /// assert_eq!(pool.capacity(), 2 * BitmapVec::MAX_INLINE_LEN);
> >> +    /// # Ok::<(), AllocError>(())
> >> +    /// ```
> >>      #[inline]
> >>      pub fn grow_request(&self) -> Option<ReallocRequest> {
> >> -        let num_ids = self.capacity() * 2;
> >> +        let num_ids = usize::max(BitmapVec::MAX_INLINE_LEN, self.capacity() * 2);
> >
> > You only need this max(...) thing to fix the behavior of 0-len bitmap.
> > We don't have any users with the request to support them. Please don't
> > add any extra code to handle unwanted and unsupported cases.
> 
> No, this code is a side-effect of the pool not being rounded up to
> `MAX_INLINE_LEN` (note how the `max` moved from `with_capacity). It
> would still be there even if we did not support zero-size.

The commit message says exactly opposite:

  This allows specifying a real capacity of 0, which was not previously
  possible.

Eliot, can you reword please? We don't have a single use-case for
0-sized bitmap, nor in C, neither in rust. If your code handles such
a bitmap correctly to some extend, it's purely accidentally, and
nobody should rely on it.
 
> Forbidding zero-sized pools would actually require *more* code in this
> patch to enforce that rule, and would not allow us to remove any in
> exchange afaict.

I trust you here. Maybe declaring nbits in the allocation API as
NonZero would help - IDK... I just want to make sure we're not
bloating the implementation for unneeded and confusing functionality.

Thanks,
Yury
