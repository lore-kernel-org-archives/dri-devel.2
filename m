Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43015C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B98F10EEE3;
	Thu, 27 Aug 2026 07:31:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="r2TEX6h5";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC21110EED4
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 07:31:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbsQyRZpOzXZgAtkAGzXYbZYnA+vCa8/f+b+Y79PyV2KkUVEURVnDpcPdc95SJ+vRE0i+dx77nNfhpBNAGy9w8Y0Qi8KKd8Pktah37pxyllgCoN/5cKR7cMV05ja4TyKzp2qFcobxTZ8dJLk/LMQI5NBAeK/RJtbdaxKsZzL6u9xib/oSyK/Md0gZWVO6BwOoBMU475UEkSCP19AaAzNRE2hvWC4NEsQ7PWreuW5A6FNPvVc3a+f1boFWY9/T921jrtEylq/tarH4fbI49IVS2r7O6G50L5GNM0ejAJymGgtkhHxvq77IA6wsxAAc8jXCj0XbPPU+f24e1Ryaidq8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GShghB4oH4kGkFqqHFxF8ES1DBSXWhRVIa008filZOQ=;
 b=h+6nBVBgf6kiR79KEY7oOUXK/zDbFZqHUfJg2/Wbs/hyiQRi9rZHkXmqgC2tHFIu1Gezlatdz9s7Fg6ivwnEvHndae9FLnct4tK1aJJq7BVQIWYIzadzy7BopQVRBzDWmFoEyvMY4svbOTaqR32Xp8hPgGIPXb3xN+Spt7vzAvO7/CyZWXA4tB61s/n+hYRieNKQxl/hUA7qEl8dwn/nWDU75Jqd/KiB0eJkTlBer+ZNDJ2qW3ATcljLE5XbZqKwnXAlXG7qb2J/KjTGZJDe52x2EAfL2xscSyGe1et90eVlXZfpU+0aVk78Zwl8K9zYnfWtGiES1SEfwz1PF5sqzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GShghB4oH4kGkFqqHFxF8ES1DBSXWhRVIa008filZOQ=;
 b=r2TEX6h5vlAtv/YEgXDqGfovNpN1K0Sgu1BwUvvatnMXbzEaEo0rfOsdp9fwChoiiZAqbH8USWGohPKKxRD+D0g/K+GSzGhGPi+RwNddq3rX/HT/lR6Sa3DA/ISPN4dUEOZWLGIjlGg1MeeLn9GrH3sVXIv+YX9Hb1SYW47eb7YwGjBlDYGESFG1Dx/kDDRmN9cjAg16r/2B7VU6QM1cMFHHnP3RISAneTSkHVSu0E4DHJzlGkCkX4kbsmheZT6pOjbvSRBxNdtV+NwaImYEqY7VhIviALhsDxPB+UpTfDAahSy0UsKz0DyNHUylaeOVCKxwBA60IVmdBJBIqZNWDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS0PR12MB999081.namprd12.prod.outlook.com (2603:10b6:8:2ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 07:31:01 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 07:31:01 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 16:28:39 +0900
Subject: [PATCH v8 11/12] rust: id_pool: do not round capacity up to
 BitmapVec::MAX_INLINE_LEN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-chid-v8-11-bc74c77d0214@nvidia.com>
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
In-Reply-To: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
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
X-ClientProxiedBy: TYCP301CA0020.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::13) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS0PR12MB999081:EE_
X-MS-Office365-Filtering-Correlation-Id: f47c4f33-0fd0-42da-700e-08df040d24f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|366016|1800799024|376014|56012099006|10067099003|18002099003|22082099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: Nz1KUwXXkBGidn0v8w/8tFaJfn67YTamoi7FbmnMm5C4qjMZUqxifG3vuuQFaQL1eStKiT+XaNW0OeIKJZVipj5blaUbvBsu5D8yFPeinaFLNUDV7drpQW/EP6PtU82/g92ajWq9/LjnKZ9fZRgf/7fzwaLNW7XAs1McmHNKXGGG55b/eYIVzxqF/nl6asDdxHrrdinVrlbErSJINwEw0/XlfHAa11boC+CoUk2tYmeUXXLYv3H53B1c62xVxyLM3akNIRPQ0iIBX+6E9rxSV8X/RsiyQfwbFrdkM3QGPQsbjamhHX7QveiAk/7uTvHBMEwzD0dnLIFaZsGYNRJN1/YtAGPfcbAqdrN3ZhfVHpfLq1Ar3eg81vk9CWZode3vR2RFkUB3cuuGSMKuD9lAmw02lhI4L7RG8eGmAIUAez5d3RceMVAdwDSo4s/2Rgw8E+vChh69IPgOxsjnbvWLi8j5HYLIQfTcpDVkeXQHgO4/B23cYbe/VVOtpltOecfuAPXklAhLk3P/zgEFExiSOa/iJG3MHhf0DA4hBD7Qji/6SXhyHvLfZmJCMGPs6ieaiL0BuRrp9vS7/ptlgZ7vNCKPmZhFijYtLFy78O1mS8FLzyXjoryGtD3ZQZd7hq3Z1iwPwXxA81WE7712ee/InXivfB0YfQjKRoHUv35skUrsFgtysnVBYAFzwxzhaQhzTGv3WrrUDCDIZfb7tItoBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(366016)(1800799024)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXRKeFV5NnhOVjlYT3pCZ2J1eXdrZW0wRzI4dGx6QUpHL2xQUzBXM1M1aC8y?=
 =?utf-8?B?TTJVbHN3emc4YVg0SzROWWRaMFdxS1FjVGhVVXQyWW9OM1dGR2ZnZnE1OW5Y?=
 =?utf-8?B?akRwaEVhQkFMUW9rNE9tbExBclgwdDFQZ1pMZ1c4VkhTV213MzNIbTdHNDBs?=
 =?utf-8?B?SnlQTzdYNWJNZ213UXdPVUoyTDg2bVJRNEZUV0gxekV4TDVEb1gzaityc2NE?=
 =?utf-8?B?T3J5S1g5d3dNUFRwa3NQTE95djQwVUwrVUQyMzIxeVVXbHR5SS80VzY1WU85?=
 =?utf-8?B?ZFhPdnJPbDJVTFErNEMrdFF6dTBFaXNHcnRYY2dta0J1UkFQVUxmK3lQbjYw?=
 =?utf-8?B?c1JXcGgxcGlmaVVGdFFOK1RSQm5URTlJNUx2VVpjOFZCb3VYdi9VdXhBUHVv?=
 =?utf-8?B?ZDJCYkhHS3B0eVdWVkZ5ZHJZU0M2YXYxNjFFK3U5N25Xdi9GOEQ4TUVDRXBR?=
 =?utf-8?B?K2ZwNXh4T01NeHhjNG9SenBNL2hqZWxBVmVsTkJ0VkV5VGJ5OXZGdWJMT1hF?=
 =?utf-8?B?ckVqVFlPam5na05FWnEzZ2plR1BtRXFsLzZxNkNpaks4NWh1WmYraDFEdm9X?=
 =?utf-8?B?ckdaUXFmK2plcEtySXBmcFExZ1hCbXdSMks1R1p3aFY3YStLK3ZYZ3FZSDZz?=
 =?utf-8?B?Q2tqbTJTY0MxN2RhTVgrcjR5VkIvckJVNEp4dmRHRmVTcTk2aTlpRS9VK1pY?=
 =?utf-8?B?a1d1QjlRVzVFaDRTczlzNThCdkJ2ek1QZkpISGQ3djhRejluQUZjK28rVkpr?=
 =?utf-8?B?dnZ1dG1BRUk4NFJUU3BzTnRuY2t2dTJKb2xsNXppZ1JBV244MWZJZ0t4YVcz?=
 =?utf-8?B?Sk54cnNiS1NBMFJpS2Yrc1dqcTgxalFFUkxTRE5FczJYVUVYdzhWUEtHNVVM?=
 =?utf-8?B?MHcwVTFGemlZbHoxVTBKUVBaSWFmckdTWGxGN0dCZ09ocllOSVI0QnRGaC9Q?=
 =?utf-8?B?MGpFYStrbFU3aU1sV3krR0Zxdkw3RHc4Y1BRR2phU0dMY1MvSE5ydzFiNGhG?=
 =?utf-8?B?VVFsSzV2QXowUzJuNlNiU2R5YW90ZW1rRjRLenMxcWxyT1h0YXFpZnp3SGw5?=
 =?utf-8?B?WDlDUDhsUlpFNnBrUlp4S3RqYmM4dEpBMTBRdEZ0bEpqZCtNdmVpdm1NNmJn?=
 =?utf-8?B?NkxDbW1KZFcraFFVWXJ1aE9Ha3R5RXM3Wkk3TGRkbjQ2bnlyRWRtZW1aa3Iv?=
 =?utf-8?B?ejdpc01kQ0tHZ2FsUGFXT2t4Q0lSZmtnejdGcktIbTNUcnNmY0gwZTE2ZGhG?=
 =?utf-8?B?K29qVFU2SFJVNEhITzRLL1lqSjlKUks2Z3JjN1FvN0crMkd1cDNQYnV4c0l0?=
 =?utf-8?B?bXBEOUJjc0VWbjU5eXAydzdmZDlOTGgxekdEcDg5S0VRK1ZqbGF2VVZWdUJ4?=
 =?utf-8?B?VlhWRjlFbzR5UDQ0U3dCZmFZV01qcmlWOGgxbVNsVVFLT05oYi9zNmNTTWNM?=
 =?utf-8?B?VDIxbHlnSENSRlFCaUJZalpWUy9ld21iOEdUQlFPMngzejRHRUNkbmZGZHNZ?=
 =?utf-8?B?NnQ3NzJiUkY5QkxFWWpucjA2Vmx0UmJ3RUpJdVVuNDBkK09mS1ZBck5GSFhS?=
 =?utf-8?B?L1RRZW42ekhUa0UrSndIYmk5QkZaa0tCVFdtcHJRTjhtaGcwbEpjRlhLcDdu?=
 =?utf-8?B?WlA3bE53NTdHTWY2NXk3WEZNaHBjWXhJRGZxQzFrOEg2Zm1MSjNHWHhBeTd2?=
 =?utf-8?B?RmpqYUlqQ2VlVkF1WUthc3p5SFhRTnQ3bU0xMHo4MGt6azlOdzd4N2plSFNn?=
 =?utf-8?B?Q09HaFV5M3hReHRGdlhReVJPbWNQR3VycmRnemllbi9rNmtUeXd6R1JqVnM5?=
 =?utf-8?B?VWFaN3JlTXp3VXFMSklIV0puOUV0MVNMOVZJR0Y2dm5sWXBMSjIrMng0L0R2?=
 =?utf-8?B?c1JkSVJ0VVlLY1ZHU0JCYjhmbWtLZDg5MnFOYzM2aGUyUm1Yd2drK1I4Q2R4?=
 =?utf-8?B?WHZpbXdMNzQvTUM1WDV3dTVEQW1TNUROUy9EbUdiVUtRY08vZHpjbUdUWGR4?=
 =?utf-8?B?V3AyRy9ZTWhWNGkrMTRUZG1WYkxobVl2MmJlTHBZOGN5NUtYcDMzU1JkTXZj?=
 =?utf-8?B?SFFVMFp3YUNSTHEyWEVUYUx5aHRxbkpHUG4rZ3pXaWdJTldWTGk5eXBOUE1V?=
 =?utf-8?B?bHhxakg1eGlrWVlLbGY2OVBwV2EvS29XYzNUeE8zcDN3RzYzcklCZ3F3VExV?=
 =?utf-8?B?YUsyay9uWUdQd2kwMk1kMVZXSU9oWkxUdTVVZFRMNCtINElaU05vSDg1L0Ez?=
 =?utf-8?B?R0RRNWRhekJ4ci9OcEhEYWFDN0ZjSmFPaXZFRkpneUQzMXRIdTJPRVgvVzhq?=
 =?utf-8?B?Z3BiRmNPUGZZZDFzSDFhb3pLemIyZzZmVzg4OFFRaDRVV3FUd1RVRlN4aCtk?=
 =?utf-8?Q?XdWE9wHiXWuhfMS5PYWIVdGiPCcYBCUCMORZSoVu3A67T?=
X-MS-Exchange-AntiSpam-MessageData-1: xwOAYFXHWQZCGw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47c4f33-0fd0-42da-700e-08df040d24f2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:31:01.1993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVmAdNW5+yc1XJTBH4kU8HKngkxa+dmxQsCiIkhmVUKLjtSpuY7IHTjRqHjtiSETtyLT+WeSt0BO3WxHnkPblQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999081
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
index 06a4c71c4c6c..4f329249df9d 100644
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
+    /// let mut pool = IdPool::with_capacity(0, GFP_KERNEL)?;
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
2.55.0

