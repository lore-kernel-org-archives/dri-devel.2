Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C1ACA5FAD
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C56F10F11C;
	Wed, 30 Sep 2026 02:44:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="cQabBvLp";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD7A810F11C
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 02:44:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuXYwbU/WOgZQ+GwVSwEMJBzsUARctFJUFaK8MilxBJPxaLxVU/hbsjt3Wyxcc451h5nptJ/958N6HZbm3E47WYV4/TyFNhpytsFyEiVI6RYYxfk3rXZcpHkVpnjLWNCEj3GRLG6aK4WpSLK3G5rPGKrFcQhXEo9lGuzCuuVD3Yvcf/ky8aLxKgh27sJ5ec+NBMAWCkH9voakMb5vfdtExqegVdE8sUJN4xomxUhSSNZGTbytpvAJ0SHg+SJuVBpZY1a24PsVU9kLqTK508igZMfhKcDyNwfVlSTegoPfiM/SixqsdT0244Zt631pt9lqK20lxocwthCatc8Z7wnEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GShghB4oH4kGkFqqHFxF8ES1DBSXWhRVIa008filZOQ=;
 b=Pv3RFcDxWvO8GsuygqRvMJSIXtCU7Azt7HhNdm4vCbglf6ruYnb24B5vmZQvj9EYUyTg/c9wiGJllI770UTWPvZyvkXIy9nVgq/85LwszkNm63XLiMtK/vORVHW3zddxi8Fmk8ATRqNIINZRawGVfURpBJWuByp1CgzxUdFuZ1Z68p0ZK2plZRRo0Ti0HEZ28URcmbeaiinI2OvhGK2qkM86KJ5MVPudx9Dx/xB3CDwypFeVuuGepdlhO8/mg0o2wsA8n0dQqt0B6MtyiZ/T/HOVp976TYU0lumDnd08OF5dCKjotH+qw40wBlb3wTmBGbpTjSO7WCU7G2sJ6qftRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GShghB4oH4kGkFqqHFxF8ES1DBSXWhRVIa008filZOQ=;
 b=cQabBvLpVc+lLKGbc1Bvwqa6cWv636Ac+69j9rQu7x9kVmgwJEirrXetAKicDpORRlVBxc1VPo25DiOpiorhJnjqCXLmqLuGfD1+AB2hSwdNqVuTJQmqrrVHTrdcl0eWvn6WFG6oLEo2DIOM87G3HT7GAEjwsAjbnFVBD6s+DC4ztLW/vOVlk37BDDmQsR4G7ntdYn1JguA2Kz/XbyEQSF1sWz/yp9GUfzrjWxpUlNDuIkXtPoq5CCgkHj9QUhpVabGdYcKsQfngBrezKG9APFzXKb5QfhZfOSBMJ3da0jDH5EadL4aS6xk14929UsUvqisUHLdYnOa5VwE5vIramA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 BL3PR12MB6523.namprd12.prod.outlook.com (2603:10b6:208:3bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 02:44:51 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 02:44:50 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 30 Sep 2026 11:42:57 +0900
Subject: [PATCH v9 8/9] rust: id_pool: do not round capacity up to
 BitmapVec::MAX_INLINE_LEN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-chid-v9-8-0d6cca376cff@nvidia.com>
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
In-Reply-To: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0063.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::14) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|BL3PR12MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b49c35-ec2a-4147-cc82-08df1e9ccc5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|7416014|376014|1800799024|366016|10067099003|56012099006|921020|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dks3Rtg+Dt4F/Bi3R0n/EydAXaw9u0kMWufjh78CzlfSQCRIMz4tNWACT71ALC1hM+VuHZJJ03WH9iTUzL2S5NFUBCPxYLddya9czZN4wIHviTHk76AKNFDOFFWsHlP8HEtBWuQ1+q6VtILC/8b92et/pGcoLa9oKv0Zt5BsWrw5DruxZwZdVzwBzJe2yCNxDerJ5aOR9gFAIGjlXrM6zC8lvFt55DzFH19taEBDGiPGBY7fpH68y/gHq0lxNIg55Hw+bBPxfnIomlMTYjh+R96vYRDtXQ5/pd6gtzYs+OOw0we8AA3iAQJr5CGKSG30K4kScJM38d+bH/l3V8w/EaNJ2TBn6/DvHU+WcJw+EoX6PN5EatMT8yDMVIdUJdnuM/E+ORMD/qQZbwLLbNpyIZSZtGTdra9lhI0jtD+1vIIV9YIROzL97dD7KT1B3V+xir6BiDv9pDwH/lxoCkqbb00sGUqXJrljMHX7B7SC67JVS6Dh6VZxMFwI1GOB6Fb4+MITOSbHUlTOlAKm6w8Ym3PXj2nUY74BJopa2IeR7Tv1AHn9M81Vti1TjCOkvKM9YX6N/awf961Xgwmfrotv0E9XZUjMUKZlG009qjEy/BYI45+zoEeyR34HaKdHyxtNtnayRof175efTj/23fZdt11HhKSAozp+hWM0Ojx6tRBRzoUmJo1AZ+yx4NKxnbClEYU6LLHm8e0uToDhD39Wow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(921020)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elg2MGZBTW5BY0pHZkQxVEN3R2RwU1MwZDNKcDBTckpyd2k1WnFaZmtDZEw1?=
 =?utf-8?B?ckJEVk95QWRxUVhTZXJiMUFiR09vQ3ppSjZXaUFyQWIwbWx2QmlwUmtBSmV1?=
 =?utf-8?B?ZVI1dGtibjl6eVBvSXlVWWErbDNjbFIyTzlIeGdCWWhCM083Tk9NcEtwTmJw?=
 =?utf-8?B?R3kvc0l0OWZsUXRjRFdVMDVNR08zZGhKL2daQjkxdUMyb1JKZkJWdCtMNmRW?=
 =?utf-8?B?d3gvMURBT25lZkVQUk5wT3NxQkpRSk1GenJtbHRNSGhHbGNCWmt3ZmhoSmJo?=
 =?utf-8?B?WjV5ZjRFamNmV0wzc3hlYWwvTUlKMUZqdjhqWW4zWjF1YWxrMXViQXhFVHhK?=
 =?utf-8?B?TTFjQ2FDVlAzZlFDbW5uMVR0Ni8xdG5QcHBrQXR0OFJ5QUNaN2RscDByM09n?=
 =?utf-8?B?ZnZ3SG90V2I2bDlEMk9Janp6YmVtTjBVQm5NdldjS0FFS0N6eVd5ZzFmWXBs?=
 =?utf-8?B?azRLVld2SzgyU2NhZE12TFY5YTlGbW5TZm1jUTRCb0V2TCt6SUZtQTlQMFQv?=
 =?utf-8?B?NHorMjZVVEFMeEN6L1NrMTBQU2owTEppK1hwdnJFaldGSUV0aGVvR3pISys0?=
 =?utf-8?B?VzNpV2FWQjg1V3lzQzd1L0FuUFl4Um5zcXE0TE5UaXVrdE5pbDZjOHZoMEhw?=
 =?utf-8?B?SU1NUDJ0THRieGxNRkp1UGdHOEU1aEt5LzB6VEJGQnBaYm9hdmJYVjlQYVZ6?=
 =?utf-8?B?ZVdBSmtWS21CUFJNTWU2a3NxYjhRMmdLVG9vYkVhenRMZ1FWUWdVRi8xYmg3?=
 =?utf-8?B?Y0ZXeVp3V2FwR3JzYTV2Zm9OOEhXZVdFTlp0d1JTK3pEVldzQmQ2WTFTbEhJ?=
 =?utf-8?B?K09iUnIrSlQ0aDFCcGd5N1hzd2xaaUlXS1krSmtrajB4MEpveU1PVWJSMVBP?=
 =?utf-8?B?Q0txVzNVQTdCY0RaWTlqa1Y0a2R6VGZBdWhoblRjNmtPTmFVUFZIaVlEd3RR?=
 =?utf-8?B?WFV5M0lVQTFNclJ1TC9aKzRiYjU1MWhDdHZTZi9BV2JVeDVtak1LcGtFaFBB?=
 =?utf-8?B?WDZucnBSS1JEWlRtSG5EVjEvbkdiVnJNUW1mK2RnOEFnb3VHK3JKb0tzSEtt?=
 =?utf-8?B?WXFHSTBMVk94YjhNelAyb2hQWnU2akQ0TEIzMkVQM0J5VHpGOXZoYVhzamU4?=
 =?utf-8?B?YTcxZkhwRnZYNSt0MzVCYzJjTmthelNBczhuU2FBZ0NJeEVuY2phSFZnaCtp?=
 =?utf-8?B?Q3ozdlFFSG5SVElwTXFqY3RJUjFLRWR0SGRLcjNkTEV6Y1V4Q25ZWEw3bTZ3?=
 =?utf-8?B?bnRYZlI5NTBpbEpKa2pGZ2FLY2ZRaGlHVTRtRkFUTkphbjJEMXgrMEdRZzFB?=
 =?utf-8?B?eEZNcGpaaW4xYVNJYW9ZL2ZQWGw0a200WFlwWi9TY3BxaWlwclgwMGZjZHBs?=
 =?utf-8?B?eVJLbjQ4L0xRTkdZTHRPOUNrS0w1Q3VsNHlUSFFGUnBXTXlaTXY4MEtHRmg4?=
 =?utf-8?B?VEkrMHJmR2hSUlFtejVpMytVUjJqL0RQb09BUUduckV4L3FzZllaTjJvckVK?=
 =?utf-8?B?Ni8zdDc3QktnUjNkSjkrM1I4V1NUbGZ2OVhvT3JFWlFQcE05QzloNFJiQUt1?=
 =?utf-8?B?VUsyWnhhSWNJaXp2TDZ6VWZ6azlXMmJmVzRhbGo1QVIvZkprNU5kUWFZRWdq?=
 =?utf-8?B?OW1mUW5COHVWN08wc2xqSEdHeXVGbzhTRzNOMndPRXRja2VLUXY5UHBCNWxX?=
 =?utf-8?B?Wks0UVhoRXRUL1pXb3VUSnFITXUyVmR2TjU3RkFvOWZUaVdKNzVySXRmcGtH?=
 =?utf-8?B?NUJrSGw4WFo2ZTBZbWZPSU91Ym9FYWtFTURqYkl1TUo5MTN5dkw1UEFoNUNT?=
 =?utf-8?B?MHJRenJOSmVPZ1YxcUJIZENMenJ4QW52eThRRnVZVGdHaExXeitZSFRZd29u?=
 =?utf-8?B?enpqRWJiUzBUUUJhUGhYUEhsOTlyZzBkaEhXSWFUbERzYjRtbDRhVkdLdTJ2?=
 =?utf-8?B?RldIQ2JWNml2MUFZV09xOU5pbVBVQkhHK3cyQkEySGU4VGx3QXN3MUIxVjlr?=
 =?utf-8?B?cWZISU1iRFZtc09leGVLczdlMGRURE04YmdnWjZuZENqWktmeXh1ZTEvSFpU?=
 =?utf-8?B?K2tPSzFUR3lDaFY5N3NIVHptcU9kRDNubWQ1TmpwM1YwU2poMTJGSWpRaTRi?=
 =?utf-8?B?dGVrY3E4V2JTMjJiU0FPRERLQjNBNjZPSzVPQTUzeVJnblJpWUFLQkVMNjU4?=
 =?utf-8?B?VjQvVk9BbzJNZndXV01wckU5UDJHQ0VocDFIazYzMEd0NHd2S3Z3L3lFOFBh?=
 =?utf-8?B?SG8wSkpIZjBycXFtT29MR0VXdHAzdVFmVUNUTjRFTkZRbjRFNEtMcXMvYmlL?=
 =?utf-8?B?RE9UUU52Vml5OVRmNDQ1dU1pN285cmRROGNlL0JhMDdoaXRPQVlnRUZFaFhS?=
 =?utf-8?Q?MitGe6crZxNt1pd9rtZGIIPZO8HpEudQatafCyYJEXTKO?=
X-MS-Exchange-AntiSpam-MessageData-1: X/hT8i2NtAnYNg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b49c35-ec2a-4147-cc82-08df1e9ccc5b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 02:44:50.4525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJkx4S/N82geeUQ50pIC1H2NJ5SexVFZv4k4MtD0bZ+o98T0QvG31D0emeo7gH672pKkgiRwTetbolY+vuMp9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6523
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

