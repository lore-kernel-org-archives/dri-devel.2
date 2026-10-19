Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCA5CCF2D5
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 04:30:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7766A10E402;
	Mon, 19 Oct 2026 04:29:58 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013011.outbound.protection.outlook.com
 [40.107.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FB6E10E402
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 04:29:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvvVEz2b6TanloBM3LQBKBLZeC90gIjYwtDzy+p+7U/tczGy583c+1rfQnMDCjWrZEk5PdH72isXWGzhFlcYBXRQXblsEIomv4aURVIg1IAEJBXWHSEFmBwQ5zs9MA6h4Y/k/QADcdOkDc9hXsMkGmIRmOFDp6nsMheK/RynO42adYv33P6Jnqe1Xzg9tZXyIp4lFPRknj0MJ840b8acJFpy9DpYIiHbzTobjWSM5T4stB7FTw9mKwF4Cpep23/LJ9y2xB9ypGkV34l5PVV80x7p5vdrVCUmtGzbnSeEEzZwvtR1U5QUDkzywcS+VBO7dV/JPgqbUW6W+fAFC1p3iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eh2lMnvfaT3reE3C4/q66tF8506EPFTNcMnpbixCd/M=;
 b=zGWCEB0gnOGTR8QcNxCh76V32FTpMZ5GHi23HnDqtVurfeRUeQMUvdJRt5kNaO6Tj20kXTgcPt6kbvjUl9MSVPbcu3LSO11TO9UZXzAS0hKeQ4QsiEEV3Cb4L9g1LJfD2/EXiGH8DNYuJzF+DcyrPRqqVX6H4DWfqhB7zOdf+N0OFPcrsr4IJjVevwiWDPHf2VeCFDVSqLz0kh0skV/HOjf8I/oxFTvjW3u7Tz3D+QLDB5PDGdw5L+w8vzbnl/b/pkmf+9XfqBjKmoo6FvhaWeAyeh97EBLV7T8xGZyTvR18UPQqWcqep746SUcjkOO83/9b7rWQMOFhJcS8nLjf1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eh2lMnvfaT3reE3C4/q66tF8506EPFTNcMnpbixCd/M=;
 b=LfmdbVB+lQdAiIkv9SoZJvEqg1NppHaUh0rqWz8ihqtPCK+j9IA0ipw8Ix7Rx0bpw4pPqfZK5km0yxVjTl+Kr5fYGkyCdVoomoF3yVbVBQaAgNunT43Z4spghiHq5p2jXCvmN2F5XXZhNu9KfBFjjKwzc9dBRTwccnqB8CdR3aIdG0KeSwOVryCbNDqpLTulO10OJSl6/HsQ9eHk7haJHaDT0KzzK0Mfr2wJDbIt0xMGFKb3ZelZ/RT8q7O98Yo8PmvGpWNr1t4nOXFFh9UDKjPcYx4i9x419MzSpugvSHvDg0RlALVIf3dgK58Fa0J33OneNdPVdBpl+AVBCsQHpg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 04:29:41 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 04:29:41 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 19 Oct 2026 13:29:27 +0900
Subject: [PATCH v10 2/3] rust: id_pool: do not round capacity up to
 BitmapVec::MAX_INLINE_LEN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-chid-v10-2-67de9180b4ed@nvidia.com>
References: <20261019-chid-v10-0-67de9180b4ed@nvidia.com>
In-Reply-To: <20261019-chid-v10-0-67de9180b4ed@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::8) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH7PR12MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec53bc7-5183-48bd-4206-08df2d9997b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|1800799024|23010399003|366016|18002099003|10067099003|22082099003|921020|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ecWHRHAklfI/7/QuvOihYqxkDsKPrjO1cXvdP1FI9Uk8O6401kDv10oF/zkeCkjh0jIASkIDJwAuXIN7m44pnKmw/Z+cJ7ZQ/cqyFSqF8CLZQsbJ4TW4H2xcTQce2hd/2zz/r+KdgqCRQwCfpCr4bH70sJ4Rjgv98D1g0IDqDBKsBxblwNq47bf+1ux8Q/0P48gtLnXCLpqSIyBbRuuqTFfQV7jFQibLbsAAhqtD+B8VwBUVlhAsaaqPSNSZEnPuJMzfRhvbCzWRh71QL05wPQvOA92ujIOoBLY6u9oj4RwOJManrTYV/I3HaBNZuIRkGWWK+3DJHX7nox/rw6ehLyJR3kzLiJBfvLUrBK6oXrp9HiYYXSD9rXMAwRiumFLw3J+O+IAVY3dl2jMK6eWwmhEy/74FKdfFJhiZEJgZjUSxpqJAHgDfZVchKK2mB+KyiPBrVNEzpCbAeWXallMKEoMBDXW8KiN9OoPe6FELgGmuxX97cHdPJSXp6Pgfg2P1Cw5mCv5Cwi2mahhNFn7pOTlL75OKTJKnp1d7CvfrBGgMBwN0EfzY13QTyhlh6i1q209oWWl26unt7eYmvv+LItuKJSdqkgaDlWzSw8TmGo3HZiI2YpisjsH89zaDwcxNcwf1p+KMUW1mVVDkXcZNHx89Mt2xoSOa99TMWXqFbZ55aVckKIUMN0l36/6oamOA2e54SzZQVIF/HwB0EDQlmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(23010399003)(366016)(18002099003)(10067099003)(22082099003)(921020)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3NrcnVjN2kyTTVGZ2hZSnVjM1BqR3paaFVRU2oxa1lqdXRCTW5rdXgzWFUx?=
 =?utf-8?B?SGNsS3dpaEhjSzJqQW9vaHBSY25xNitHY3R3M25yciszRjNXc25CSHVuNVRP?=
 =?utf-8?B?cnpqZ3ovaDJ2WHNYUkJzeFgvN1ZEdSs1MEVCMWxJd29ZT3VTZ0xvTWpaSUZ2?=
 =?utf-8?B?RUVyNkNHa1k1OVRYd3gvWkVsSnFKUjdBdldRZGhZQjZ4Vyt4V3g5aUFXdTh6?=
 =?utf-8?B?RWt2WCtGOENXRW9XZnFaa21PZXVYWklNeUFuS0pwdU5HTTZ0bVFiaVVabXJn?=
 =?utf-8?B?Z1dvcFFUajludXBNQ2Q4cXNyWWpqb3BBUCsyR3NKVTI0cE9wY1YrbEIwbU91?=
 =?utf-8?B?aGFOc2prU2tHOS94YXpOOWw5TGlaR1hBekV4Y3NiRUV1cXduSExsbFVFN0dn?=
 =?utf-8?B?Y2t0SFBva1Bjd0VSZ0srMHQxaTM4dThUcEFkR1F0eUFJWVM1WG4yemdJei9Z?=
 =?utf-8?B?WkdSMUlON3h2dUhndVk2QzdaNUtOcEdsQ0s2Yk94c2Y5SWNtRWJHVlZkcFEr?=
 =?utf-8?B?WHBsM1lLSjkyNWltekMvZG12NDJhWWVMV0g0Um5IdmR5OVEvSGxNWGVtanlS?=
 =?utf-8?B?eTZCNzdpdGtDQXFRelVVcW9qZjcyVVpTaktjaHg1ZGEwR3NhM3BMU3VSYTEx?=
 =?utf-8?B?M29aenQwTytEdVhwVVllMW1tVzhRcVltSVNnRzdUUmcvdGQ5TXo1WllSWEY5?=
 =?utf-8?B?TlBRNWNROWtFSFB2V0dSem1tT3BETEdneXpVOFl2N1UwZ2pFUzRIYVpIdXRE?=
 =?utf-8?B?ck9mWGp0NGVzU3NaM1ZEUnNCWTRPSVVTQWhGWGllUFVwYzllVDB4NjZJRXlk?=
 =?utf-8?B?SzZucmpLUlp6eTBTeUJIc1poT0tOSkZCc1ZnbW1PdElrQ0ZJZ3hxMDBpaGI3?=
 =?utf-8?B?bGhrbUFndk5XUFhEVzR5ZkxibTlqQ2hFZDhmRDBvTC8wdDI0WDhkSXFuNGxB?=
 =?utf-8?B?V3E1WDBNYWNkUVBQU05PYUZNL0YrSTBuck1HMm12TzlyYVc4Nnk4QjFoZkhn?=
 =?utf-8?B?RWF1dkdkbmdiMWxHaTRTYXlwNlhYOXpwZFNnVmpxdWM5cjVXWUVWcEtKL3o1?=
 =?utf-8?B?NE4xZUl5Si9DTlVkOEViZHVOeU5XckJSa0dsMkRoTFZyODhxWnRUUWxHeGJV?=
 =?utf-8?B?d0lLY2dDcmtGelBBRHpaSlFHdFlIRXlZYTA5a0NWdnZ4YWcxczF4S0NKbGxz?=
 =?utf-8?B?eldKUWFOL3hVSW5kS3B2OE1UZTZyQnM3STB3VjNmblY4YjczQUxCRE0vU0JK?=
 =?utf-8?B?dzRtK2FMeHlLN3dud0s5ZlAwTEdHMG8rb2NWRTNnSUxGNkNobWFRMzVQRlJm?=
 =?utf-8?B?YU13UWR1QS9FTk9IN0piQVhPSUI2QnJZR0FubkR4cjNrZUxwQ2p1alloN2Vp?=
 =?utf-8?B?NmpkZ2hsWjV5YUM2Q0NHYlpKNDVNMmprMkhvbFlwSEhtTzR1TENqYVIxMTNR?=
 =?utf-8?B?WGhNY0Q0ejZ0R2VzSWo5STExZjkzL0kyOUhxL3hNTitMcjFoVVh3WitFODlD?=
 =?utf-8?B?M1I0Q0tFVWVuSUFPUDZPZVhaZU5DUjhkVWhqTWNuL21DdVpITGpmWlZmTEZt?=
 =?utf-8?B?aGw0Szh0bm5TYWcybTVHVFg1RnNId3g3VjdsVDNWOU9PS3pCeW1ldGFYQmdJ?=
 =?utf-8?B?R3ppSTRGS1g2eVZWa0dIdEM1TDdLcHJEdlBBcWZjdTFVazlIS0w0aWd5bjF3?=
 =?utf-8?B?UXNjaWdWNW1raDVjZnhFTk1CaW81ZmFzREVNWWJsQzg0Q2E4SlNDNDJQV2Zn?=
 =?utf-8?B?Z0hMVzZENmhJR1VkMG0xODBwdlFhZzZXeno4SWJjTlFOaVJJbTZYcnBZOVhM?=
 =?utf-8?B?aVJMRWpza2g0K0xDc2FKOHZYZmdLVnhxUHBqVWR3MVc5dmVpYmZUV1F5WDlE?=
 =?utf-8?B?QmdmK2dndmIzTEhGZ2UrWWRMcm05cVhNZUFqMEhHcElSVWliNXF4WGpWcWs1?=
 =?utf-8?B?MmlJUmFRR3RwUTQ3bEJ3bVBNU3R6Rm9nQTFha29PemExMURDM25qUi9IUmNh?=
 =?utf-8?B?L2VkaUhBTmw3Z1Y5Q3MxcWpmeGZIZGZISWRCS0dNNUhkd1NUaWl3bTFuOTM4?=
 =?utf-8?B?bUZwYVI1TW1uNjFxdnFtcExPWlVMNkdMcnZIRzl3YXJTSi92bWdiSDl4WUJR?=
 =?utf-8?B?bVlkc1RScWdPY1lxRGNCaVRqRUx1amI1NjVOQ0dwSXl6MkJwUFRZSVJLTFMy?=
 =?utf-8?B?TUZMYjd1QmhDMHE4QlQ3Y1doa0xpcEtIelpJby8yNnJiTkJJakQ4aklCQnQv?=
 =?utf-8?B?VXYwb01YbGttekFvSkg2dlR6WlhNeDdJY21rUEtBbnJnODRReklQU2Z3SC9D?=
 =?utf-8?B?WFIvM3VLajhSYlZ6cFhQREh3MGZ4MmpDd3NPdjVYY0F0VjZXSnpwckRKdEds?=
 =?utf-8?Q?Jwr0M14dvZ2mDxmhXn+h9Cfa6GeS1h9WPp83DfJyputHH?=
X-MS-Exchange-AntiSpam-MessageData-1: YrpKU/6AUsZ9gg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec53bc7-5183-48bd-4206-08df2d9997b6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 04:29:40.9639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egFikYdQqDG2iGXBX4o2Fg1PyKfxmOIZOuVUcNDOcwZQdgQm1uqyG84UWK0imy+QXF6Q0R14mXa4abJIpw9P5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7794
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

Current code in IdPool::with_capacity rounds the capacity up to
BitmapVec::MAX_INLINE_LEN, but BitmapVec::new works fine with values
smaller than this and still uses an inline representation. Remove this
behaviour.

This allows specifying a real capacity of 0, which was not previously
possible. This breaks `grow_request` in this case, so change it to grow
to at least `BitmapVec::MAX_INLINE_LEN`, mirroring the capacity floor in
`shrink_request`.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/id_pool.rs | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
index 06a4c71c4c6c..a6d69df02805 100644
--- a/rust/kernel/id_pool.rs
+++ b/rust/kernel/id_pool.rs
@@ -112,13 +112,8 @@ pub fn new() -> Self {
     }
 
     /// Constructs a new [`IdPool`] with space for a specific number of bits.
-    ///
-    /// A capacity below [`MAX_INLINE_LEN`] is adjusted to [`MAX_INLINE_LEN`].
-    ///
-    /// [`MAX_INLINE_LEN`]: BitmapVec::MAX_INLINE_LEN
     #[inline]
     pub fn with_capacity(num_ids: usize, flags: Flags) -> Result<Self, AllocError> {
-        let num_ids = usize::max(num_ids, BitmapVec::MAX_INLINE_LEN);
         let map = BitmapVec::new(num_ids, flags)?;
         Ok(Self { map })
     }
@@ -152,6 +147,13 @@ pub fn capacity(&self) -> usize {
     /// let resizer = alloc_request.realloc(GFP_KERNEL)?;
     /// pool.shrink(resizer);
     /// assert_eq!(pool.capacity(), BitmapVec::MAX_INLINE_LEN);
+    ///
+    /// // A pool at the `MAX_INLINE_LEN` floor cannot shrink further.
+    /// assert!(pool.shrink_request().is_none());
+    ///
+    /// // Neither can a pool with a capacity below `MAX_INLINE_LEN`.
+    /// let small = IdPool::with_capacity(8, GFP_KERNEL)?;
+    /// assert!(small.shrink_request().is_none());
     /// # Ok::<(), AllocError>(())
     /// ```
     #[inline]
@@ -198,12 +200,36 @@ pub fn shrink(&mut self, mut resizer: PoolResizer) {
 
     /// Returns a [`ReallocRequest`] for growing this [`IdPool`], if possible.
     ///
+    /// Grows to at least [`MAX_INLINE_LEN`].
     /// The capacity of an [`IdPool`] cannot be grown above [`MAX_LEN`].
     ///
+    /// [`MAX_INLINE_LEN`]: BitmapVec::MAX_INLINE_LEN
     /// [`MAX_LEN`]: BitmapVec::MAX_LEN
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::{
+    ///     alloc::AllocError,
+    ///     bitmap::BitmapVec,
+    ///     id_pool::IdPool, //
+    /// };
+    ///
+    /// // Grow goes to at least BitmapVec::MAX_INLINE_LEN.
+    /// let mut pool = IdPool::with_capacity(1, GFP_KERNEL)?;
+    /// let resizer = pool.grow_request().ok_or(AllocError)?.realloc(GFP_KERNEL)?;
+    /// pool.grow(resizer);
+    /// assert_eq!(pool.capacity(), BitmapVec::MAX_INLINE_LEN);
+    ///
+    /// // Grow doubles if at least BitmapVec::MAX_INLINE_LEN.
+    /// let resizer = pool.grow_request().ok_or(AllocError)?.realloc(GFP_KERNEL)?;
+    /// pool.grow(resizer);
+    /// assert_eq!(pool.capacity(), 2 * BitmapVec::MAX_INLINE_LEN);
+    /// # Ok::<(), AllocError>(())
+    /// ```
     #[inline]
     pub fn grow_request(&self) -> Option<ReallocRequest> {
-        let num_ids = self.capacity() * 2;
+        let num_ids = usize::max(BitmapVec::MAX_INLINE_LEN, self.capacity() * 2);
         if num_ids > BitmapVec::MAX_LEN {
             return None;
         }

-- 
2.56.0

