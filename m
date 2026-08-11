Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DEDC5AD55
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 02:20:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ED0510E249;
	Tue, 11 Aug 2026 02:20:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wo9DklOk";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011006.outbound.protection.outlook.com [52.101.62.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5D1310E249
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 02:20:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfyQehFYb00GKGrzy8Of9a0rliqd6Yra++nxgmxcniCDcR1dajG8jSWqO8fEzqI+0OxqUG6tPIsTUtYMRm6lM7NIl4Pu/s88Q2IdWzUmGzKvSDnqJBIMksHY6lMcM/xrsGdkugdAtSxPMc3ijggfIjkb/lhi0IkzFqy2ZbnBXQ97qbj0/p7nrQO/JddtgJClJ4dJ2enRCQJvcCxULZ/5Fi7/UU8bjG6m6J4uzweWV9Fn7wxSyYyPsuJInoyVZ1uJPJVcOP7H4eNT4KtDEeklVNTN6plfvLaehS65VUTnR0b2SOkzuQer/1Q8mF9fT8Xdr/V9M14ifqHbkPBfb7uBBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o31r5jby1J2rGOybn/hGxbpK9ITmy4DU+Qlq1Z0azpg=;
 b=L8B6mjuG2NjrPWpUQM0NJRZGZlSCd+Rhe6QIrZeh66FQziVytO+8sP26X0eqoI+6y8uSk+TWOkXyGcZu0dUEYgjPefpr5xfHPmIKkwGTmQxvL8O/aiTCWdltz9YfIGf7lTbiuuRGQYis8PpRllOiiKppamdolZYQQ4pZkqJKVOwZL2Kb3bgjc5RSY/MzmZSqeCOrr8zq50hUPH4aeWoVggtMo6yWnFjtkhskjWeSLiJajIeE7MnQ0m8ArzyrEoxbhrqq5YYJjdCWVvbiHfm25HNDdyr+TCIcTSirVzLpQFMOqkkjINrev3nBrle2UP55UZCEVwyCNbFLs2FITNeIGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o31r5jby1J2rGOybn/hGxbpK9ITmy4DU+Qlq1Z0azpg=;
 b=Wo9DklOkqwR+NU13H44IvEB7j6PUSMOtKo6tDLTxP5F4HysUJMr184qmuHH/xZFr7InxCCCwBgB8fZuxBf/1Q8SiwQ9ZV/cZ7QSgaQc75PEhYuvyBLO4wtzR6cSCjoqp6RIkGHIaG7BG/3OqUvSfG78dOKHhWo578xtjp7mKO3VkGrVsLQjcILkvdO+xmJh5ciGKHzRs8XPeOagg2GNXulFvKomexkbNMRtP/BXhvLZqwj0obeztB5kf9966seEUt6mdgmC9fqSAiAvTV8zWwvHPboXvXMUo4XkfM739u1d8TWJYvxMKBA5AmoEZeUUpPcsr9G8T22w2tac5+l3tpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 02:20:29 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 02:20:29 +0000
Date: Mon, 10 Aug 2026 22:20:26 -0400
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
Subject: Re: [PATCH v4 2/5] rust: bitmap: restrict bitmap length to at most
 i32::MAX
Message-ID: <anqG6jrrHTBuDis4@yury>
References: <20260810-chid-v4-0-c9f206fdcb97@nvidia.com>
 <20260810-chid-v4-2-c9f206fdcb97@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-chid-v4-2-c9f206fdcb97@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0810.namprd03.prod.outlook.com
 (2603:10b6:408:13f::35) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|MN2PR12MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: a5fe73f2-66fa-4377-fd64-08def74f1cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|6133799003|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GX98B+C2viZDbiLrc223Sn54qBKblxZzy4iOUCr6qRNRLdN4gItk+AMbOxz4b4JPvAxR2qgZ4GzAnESQ4CpQdSdM4VPKMV5YLSHh6R7UBsH2Wc7fCaVSpFCdUWsLmwftGsfu9jJ7llaOXJt5iOmA3flPLDDe6mk+wHHxy+CLpdNZ/2n2J99Nh2WTZ570bmHhXev7ST+yvtyu+tzKFlciAnlsDGqn/XpYR5cL8OJL7bjACUHRv4FVeZxXJIICmQzodbGSXSgMZTbtLh/ks8hibMWhcESiMkb8qMWjfgvYPQSuG1ehQgM2J/wSJZLStTWhtRaM+X+KWGnBIow3ldZ8fsS+QUUa9UcbLb1weLvDY81BU45wZVlsx0qt7ZrO77NglJvKAZq27l6K8exdKMxuJmWWycPzni2ZxHmDz+vjIAPe0UUH/AUK0nHjPdUCCAPTWosTGynyxBHi+IAVnakvX/HoRYlatGtUnfmSLEccKyELt92503J1Ua1OhMk7MtnZDP5IzHkyTaXDKikv8nOF/jCqZDK7R1y9rxwwmBe89NbCQThVQRotjjs9ZS3wW5sTdlhPyoHtmVCAm4M19IcWuSP+52nbI+ma/24YzS46eO4lGEJz8WRY78bydw/suYwYa327eUXRKyE+bjkXYS9H1PPzyKj97z9f8QuYEPOj2QQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(6133799003)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ubpx9nDdSsg9pv/6Xl8Vwv2EAkiiLpgxpY6QH/NgFN5keHzO+PlXKGbLjKge?=
 =?us-ascii?Q?wprTY3VI+DGNz9tY6N0PrkL5214DGrDE3RqiXlN4W1bbUwR0Ga2X9NG+9xqn?=
 =?us-ascii?Q?GVXn/zVVyK4v+R1MEke4ecRMlk1SmnSfDoLW50GGkbOay/VozPjtOT7YUDnx?=
 =?us-ascii?Q?I3jM7POOZcp6GuzcTVhEGmOFE/S1T497R3Uv69IzAB2gLrDIQJzL2UH6qfAI?=
 =?us-ascii?Q?4E+csu6M+n4iV9+FRT30W+E0eMBze7PF6MkIaW2QoOarNn2uVOP7ccrL+8EN?=
 =?us-ascii?Q?7fTX8oh2H7t+YnGVhi1wWY8A0fERAAN64OffSu6ODS04NViWqxqbd2zgOzpv?=
 =?us-ascii?Q?k2oJ3QVgBiB7xzOiylRg7XOflnJBVjNr6lfY0RXdWUgiIUlfY81TTasglRCb?=
 =?us-ascii?Q?t8vx973dpz3p7wW8zb1LtTfOD2SdWV5d7iRpVDMP9wP55ONSZ2zdou1Y8n04?=
 =?us-ascii?Q?VBlokdA7HFAACzxGZgmYnOVbQuTzHdnkvkgNtssTxzvBLgiLF1T2pKbo6BkJ?=
 =?us-ascii?Q?omq7o0TEzlufpQp3mVn0GRQo4U+2oNNTP5XOWtB5ziKMWF3ED4KvBbkquIy/?=
 =?us-ascii?Q?4bB75k0EI8IdvB06VRgapGEPmabLDtJvy+GzCX7bbvNMugmqCH10MnhOvhTb?=
 =?us-ascii?Q?VCC1hC1+gvoAr5Ale+YL5JkZ/GiizxcS9e+2URYmPwj/4CfRl1z8uzetnAFA?=
 =?us-ascii?Q?OzRED+uKcaWAszVBYOWRT0XJeGGU4uz+Cv8gyIEYsXBfmN9UQ1LWOOQxiuwG?=
 =?us-ascii?Q?U2wk1QnRim6zKn9oekijRyd0KNRP78uI/+ieAPj9CSzJlRMRIa0Y8lfuxrzF?=
 =?us-ascii?Q?mZiofL3VT/WzMcHYyh8ndMVgVjXs0EUG7omBnhVCfkmfhG4C0CLRthsoRMU8?=
 =?us-ascii?Q?xBtKe8M/oAsP4Wk/7hCg3CWzQ2qiK5saN8akM+hERUDJh6xWMED/sF1ShVlC?=
 =?us-ascii?Q?eol3jHNBy+z5224J2iepglSb0JMyqlbZBPdrft8Rp8DUa3pa6sX3hcmRkGGM?=
 =?us-ascii?Q?Dr059SYkdmwtHcXwfVKdl0gKzyq8F7XeKR7ZdfwJ9VMscc6ZZjfOCkPVJN00?=
 =?us-ascii?Q?CwLPOppvqoRW11291gyCwhADsMphu1J8XJPpKzG7f4Gh7e9oBbBqyqQ4WcYN?=
 =?us-ascii?Q?8yQrpLJX73XuY1Av2G7A1FHiM6Pu/g3q8MUlF/X7AsbXsN3gxC7b0RXJHnae?=
 =?us-ascii?Q?hlJ719syKHXo1ITogCScHA78BlfDulWtrGtW8w0E8Prv6YkzELbmRg9kMg3Q?=
 =?us-ascii?Q?dEnlb/UqLUFe5hEx5XhvEKlfKj5JDilhnuKIbUN/l4l9Qr+Hnxbam0IIHIyL?=
 =?us-ascii?Q?C/46xe8jIPKTif2vqmf1CQeHRWAshEHjjDXjlgYNMB8aB0Qff9Eb8GjEne8k?=
 =?us-ascii?Q?bVEt05JwfwpWZ8pcCStQUoo8rnlLrTXDm8HJGsAO8vqsYnnOwsfkqNEbQwvt?=
 =?us-ascii?Q?zxyCvVdIB8x8nsuck9TikWNUwLNybh/f4MOMUB7GqwSqfLhobWcyPp4FBb60?=
 =?us-ascii?Q?ct6viW1UyukEJvBGafki8vOLbq8slJQRkPgZr3msSHZofHsug4ji8Vd0EmXj?=
 =?us-ascii?Q?vEjREtb8RptKjRUJgfwb6oGnzbY34rs4IYTFlcgAtZC+rHYTk5+Dui3f6Faw?=
 =?us-ascii?Q?4SVP/4AIqBA41GBFa8gJSq7SQg5vkR+bTL5+eUEQQfcrkTdZir9+zjGQC0OO?=
 =?us-ascii?Q?hK+wx+tQqLbjDVHkqDbJB15875p7M1BefNykqMfKOswJ0SBpW3Ye+2TEY0ou?=
 =?us-ascii?Q?v11m+RrftA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5fe73f2-66fa-4377-fd64-08def74f1cfb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 02:20:29.6625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2KeBwuDueC3/16uQfTc+/0qEd+//dsOcE//Asi7sE+IrEjZoljixHBz1wQnOIzJL6ZBf0MWLj7QpW0lxKDdixQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
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

On Mon, Aug 10, 2026 at 05:34:10PM +0900, Eliot Courtney wrote:
> It is currently possible to construct a non-`BitmapVec` backed
> `Bitmap` using `Bitmap::from_raw` that is larger than `i32::MAX`, and
> it is not part of the unsafe requirements. Restricting all bitmaps
> (even non-`BitmapVec` backed ones) to a maximum size of `i32::MAX`
> simplifies a few things and matches `BitmapVec::MAX_LEN`.
> 
> Add that requirement to the unsafe requirements on `Bitmap::from_raw`
> and `Bitmap::from_raw_mut`, and to the invariants on `Bitmap`.
> 
> This also fixes u32 casts truncating in `copy_and_extend`, which could
> otherwise lead to OOB writes.
> 
> Fixes: 11eca92a2cae ("rust: add bitmap API.")
> Link: https://lore.kernel.org/DKG0U8RLO7LZ.2I1AIH0S38PAP@nvidia.com
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  rust/kernel/bitmap.rs | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> index a43bfe0ec3dc..0d481d761f2a 100644
> --- a/rust/kernel/bitmap.rs
> +++ b/rust/kernel/bitmap.rs
> @@ -17,6 +17,7 @@
>  /// # Invariants
>  ///
>  /// Must reference a `[c_ulong]` long enough to fit `data.len()` bits.
> +/// Must not be longer than `i32::MAX` bits.
>  #[cfg_attr(CONFIG_64BIT, repr(align(8)))]
>  #[cfg_attr(not(CONFIG_64BIT), repr(align(4)))]
>  pub struct Bitmap {
> @@ -30,11 +31,13 @@ impl Bitmap {
>      ///
>      /// * `ptr` holds a non-null address of an initialized array of `unsigned long`
>      ///   that is large enough to hold `nbits` bits.
> +    /// * `nbits` must not exceed `i32::MAX`.
>      /// * the array must not be freed for the lifetime of this [`Bitmap`]
>      /// * concurrent access only happens through atomic operations
>      pub unsafe fn from_raw<'a>(ptr: *const usize, nbits: usize) -> &'a Bitmap {
>          let data: *const [()] = core::ptr::slice_from_raw_parts(ptr.cast(), nbits);
>          // INVARIANT: `data` references an initialized array that can hold `nbits` bits.
> +        // INVARIANT: the caller guarantees that `nbits` does not exceed `i32::MAX`.
>          // SAFETY:
>          // The caller guarantees that `data` (derived from `ptr` and `nbits`)
>          // points to a valid, initialized, and appropriately sized memory region
> @@ -55,11 +58,13 @@ pub unsafe fn from_raw<'a>(ptr: *const usize, nbits: usize) -> &'a Bitmap {
>      ///
>      /// * `ptr` holds a non-null address of an initialized array of `unsigned long`
>      ///   that is large enough to hold `nbits` bits.
> +    /// * `nbits` must not exceed `i32::MAX`.
>      /// * the array must not be freed for the lifetime of this [`Bitmap`]
>      /// * no concurrent access may happen.
>      pub unsafe fn from_raw_mut<'a>(ptr: *mut usize, nbits: usize) -> &'a mut Bitmap {
>          let data: *mut [()] = core::ptr::slice_from_raw_parts_mut(ptr.cast(), nbits);
>          // INVARIANT: `data` references an initialized array that can hold `nbits` bits.
> +        // INVARIANT: the caller guarantees that `nbits` does not exceed `i32::MAX`.

Can you enforce it in code, instead of comments? Maybe under
CONFIG_RUST_BITMAP_HARDENED?

>          // SAFETY:
>          // The caller guarantees that `data` (derived from `ptr` and `nbits`)
>          // points to a valid, initialized, and appropriately sized memory region
> @@ -415,7 +420,8 @@ pub fn clear_bit_atomic(&self, index: usize) {
>      #[inline]
>      pub fn copy_and_extend(&mut self, src: &Bitmap) {
>          let len = core::cmp::min(src.len(), self.len());
> -        // SAFETY: access to `self` and `src` is within bounds.
> +        // SAFETY: access to `self` and `src` is within bounds. Both lengths fit in `u32`
> +        // because a `Bitmap` is at most `i32::MAX` bits, so the casts are lossless.
>          unsafe {
>              bindings::bitmap_copy_and_extend(
>                  self.as_mut_ptr(),
> 
> -- 
> 2.55.0
