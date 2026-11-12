Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E58606A887
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=k6QN/UAt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D289E10E609;
	Thu, 12 Nov 2026 12:39:03 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010038.outbound.protection.outlook.com
 [52.101.193.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E44610E403
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 12:38:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8FsU9HTwQhdyI9G3y8yIjhay7Y9CEKG9nrlnFtMZ1C82RlEEQvgoZT77nc911D/hUoncu2a/L8XMe2kh0mUdTTtjM7VGKM7T64hS3z5Tz3QiFQnwmYfWZSQpTmNB5QhqLc4gRp92RPfqGYzqB391BMdbhi3iR3whgkmdftiwuSlmZR6/96Ku9zJ2myZI5AMaSd7ZXspxrYtPCo1Yy9LGWniVcIAIAkyEKSuueN69u/29d7zq9kABoY41+FrGpBb2M10jaewRQg/Xcc4Ru7Cv0G0AiSRgTK+0PPoRoU/iT5DPONfWHsdt+Emt3ppuF2o1piX1wj+Xsqhz7//+Xm0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3W7s0Wfg4IJBxiCowi3Tc1XGOXywF6ZlyxCaNoTq9c=;
 b=cV6/sj0Wym2E7fAjQXuPPHZiGSZuArQlhfk4YZHbO5LeD2uRhmd0xP6LICBFW+zW0pYl7rzv9qM/OwbcGLLvVYy6eFBLP4xsslnFY5vnum2SeuQBiK7DdbkJfsmq+6mNY/FhBy371ssgdG1NJuQ+r89hzDHWz9mSNdJO6sytB7lsSJ82Wz0DgaMRDeThXpf167R9/AuCHVrH14nCBenFcc5IsbRkAEzRs8O/MfinMkSRM9cHjQl3JhVob0m75rMCVB+yo3NPyr64/Yd729wc1m+lSgCNFtYCyaMAAd7/OfQN6dqJw0GGYObMNDT/bRuXN49dZomV4gx5TM6HGWKjJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3W7s0Wfg4IJBxiCowi3Tc1XGOXywF6ZlyxCaNoTq9c=;
 b=k6QN/UAth1FEqwoYKcnpoLZ5xFyDlg/2j9vqJT5LVYuya22rgp0rK0i2Tuz/P3/zUdWJQ+qslXQPVh31PY88Fq0d1x/Ht0fmZnuI6/KeTQKcAGH/nFSL6xx74xhnUHF6xCehSSAL21boBHwedt9Oqgz1s70rbVxoT6w+7VmiewtcXr5px03NDYPHz5xODneCUgCAT1573IKC46deIseHgcGxRho1mybuU7gg0QyROeNhvJ+kenQTUncD8OfsH2+3R8EaIHsyCcJuP2vT5fUr9ax9+m8SUOtGsKw9p3R09vIDrbySY2zgAoyQayccg4UIn3byNLTLqvEV4pfgjwF5uA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA5PPFD911547FB.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 12:38:49 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 12:38:49 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 12 Nov 2026 21:37:12 +0900
Subject: [PATCH v12 1/2] rust: id_pool: do not round capacity up to
 BitmapVec::MAX_INLINE_LEN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-chid-v12-1-49ad43286dad@nvidia.com>
References: <20261112-chid-v12-0-49ad43286dad@nvidia.com>
In-Reply-To: <20261112-chid-v12-0-49ad43286dad@nvidia.com>
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
X-ClientProxiedBy: TYCP301CA0090.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::17) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA5PPFD911547FB:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a333725-4951-4976-056a-08df40b9e644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|366016|23010399003|1800799024|56012099006|11063799006|921020|22082099003|18002099003|10067099003|261102123227099003|261022105027099003|261021121427099003|261021123027099003|261028144727099003|261026140227099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: TtyKPwz/i+zYs23sbjnfQPFrBIbE7Ut2TNwRe5ynF4Sqitoc2R8VaGBismusBwdtq4Ao7ggOw5iWoOsmaxrWsNJnVeNQpjIJGCg4+Cps4gwXa7ladE0mLdOSuAo9+Gqybkq3fMRhXR28ZFaMuwlIoBSFTfbJZvaRkUp2XoGGoQImUQJGkqCGX8m8dDjrVCFOw1jbJVsPy4ybM5uWNV3FHTSis/Pg8e/6nYI2S4iueszyqrw4PaxByCyKLq0Ct8I4ek8ZkCnoXO8T2a0ROVkNmd3qDm2cjuD9wfUPAniUZRpp7qI5tFGP1AaFcDXgMfDQHpzBZPa49h4JPX8GrBkQoKC/6MCv/tQ2gqXf9UkmGirerTMGeBUgXiL4qwsqtTrYcRlqAC7lxViRXyzwHnOr7DMa5yYnnavmzYwh6ziVVcSFuo7/aCJBb1WZZgoYYl/6hblw+fQmNuj/O2VZmnwuh/C43V7QuGGdn05Ls+a7MGfd3Zic5OEYNSfBYNwzdDw6gYUz0mS4Wl61tlVbeOtGSJpjffxLieYB9VmUSmFsLGYM2YfosOLDnNJhU0lmeZAGEC111liSMeBXM4ZzJxYJqYDJV0YX/6ywn3Y9q4lPWD4X7Ckpts3l31TtZ19ltE4ti/Zcqo+gBsuO3IUhKicmvQ+jb8PLt4u0sPMs9Qcp29dlS+BLqEXgYMqTH3zbnDay+/NdsOVhvHRWreUHbuFxKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(366016)(23010399003)(1800799024)(56012099006)(11063799006)(921020)(22082099003)(18002099003)(10067099003)(261102123227099003)(261022105027099003)(261021121427099003)(261021123027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnkyMWtVdE1hUlZiUFQxN00xUmNQTFpobGNIOFZxMFhLZlYvNTlTdTFlMTlk?=
 =?utf-8?B?LzA1enRhdkxiU3BUUm9IeTRPeVNwblExbVRxdjZYdktLQ0N0UWJSUnVGVDBl?=
 =?utf-8?B?M1hFL3h0RGo0TmdQZXJpTlFYTDFKTHRFQU5NV1Jsbk5RckorZlVCMURKTVRy?=
 =?utf-8?B?V2k3ZUZrcXBQZ3o0cEEvQVl3ZElqM05PMlFWS01xbVFlVWdsb3dxWVVOVjEx?=
 =?utf-8?B?Yll1cEFQSFJmMWIvd3o3WEYxbjlYTnppWXlEMFpPUDNSQkVSS0hxV1E3c3RW?=
 =?utf-8?B?NE1NY3V5bFpWYTJISEV6Uno1QUkrR200djZFbCs3bFRSMGZlWjZZVjZIMVd3?=
 =?utf-8?B?WjB5WUxmRHhVeHNrWisxQm5hQ3gyNHh4VDc3ZGRyMnhRZGJvSHZoU1VmMitp?=
 =?utf-8?B?TG5SOXpoc0hhSnBtazVKY0NFNS9DbDFDZXAwWitxZlVVNHo2MGhaRXBraFV5?=
 =?utf-8?B?M05kRC9lT2xBMXNTbWJpUkdmcUNJRFE0eldaam1XUnppNGk4TzdiVGlkRmU0?=
 =?utf-8?B?MURlcnZaMVd1NUFFdGQ5K1U2OHhsWFZDSExISHMyMGxjcXpwYi9wekRYL3pq?=
 =?utf-8?B?cWw4NXdKSHFQbXZkSU5XaDgweDl3MXc4MTlKYnFYcTVrbG9oT3I0OENCSDkx?=
 =?utf-8?B?R3BTYnRWbHNKK0dQc3RoWGtONWVJSmoxd0JTajhGUk1FaUVCNWJiV3NnMGNJ?=
 =?utf-8?B?YjdxNFFWTFRxK1hGRUhublA1T0hLblJSMU9UdjNaV1I3TEdCc21sU3g5U2RO?=
 =?utf-8?B?enFSbXVnWW85MWFCN3UyOTZtenNMZHlLTkIrSkdxWGlBc0tIamQraXJLdzlp?=
 =?utf-8?B?YkhqR1lvVjRGRjhFMHlEdGxmdDdLeEJIa0RKc3FHb2R0YjZJcTdnNDRMS1Z3?=
 =?utf-8?B?ek5oSWJiNUR0MzdXK0J1MnptMFpIQ0ZHbnUxUE4vQ0xGWS9IT0ZjTytmVzAr?=
 =?utf-8?B?SUlBY1FVQ0VCQXd3RTFHMWZkT09FMGRQMm9FaUg1cEN6alpScFBJRUNhY2VS?=
 =?utf-8?B?MEM4MlN0eWtFTUF4VlBoblhkZTM0TjJ1VzNuejBCa20yL0tzd0ZIQ0NXVThM?=
 =?utf-8?B?Tkx6aHRoRWNTNzlFaG13ei9wdG1Cbi8zWXgrSThKWXp1eU80RDkwVUZpeHMr?=
 =?utf-8?B?bFZ1TmNZdGdQTS8zWFZuY1dnU1BQc0ZzM1FFeWhhYkJKRmE1aGZVa1I5UGZX?=
 =?utf-8?B?V1JNT0xLNDlXQzVvdUo4bk5uTktYbVZwYVZBVzdQODFpOTNmU3Q4OUtoWVdj?=
 =?utf-8?B?VzFPd3R0T3FTamJGZDIyMU1IS29ZdjBZcmhabTVBVFVpY1pkQlVxZStMaGI2?=
 =?utf-8?B?bXQxNDBvRi9DQmg1RnlFZTBKRUpwYlFMNXJQN2piM0lvdFNQVmFUQXU0Mlg2?=
 =?utf-8?B?N1FITm1yUDdUMU1tcjV3TGVTc1BlbXZsd28va3BISVR1ZWZETnFvenM0cUdK?=
 =?utf-8?B?dWhxTDBoVlJRd09xVWVSdkdhbm9IeDJmY0ovODR5Z041TDN3WjFaNTZIbmxF?=
 =?utf-8?B?dUlSL0hsdXFNM0w2QVlVb205S0VBK0hmelo1WHE0Y3VDZjRWSFJ0MElqN3Az?=
 =?utf-8?B?OHNsUjBxV3REV3lJcTgxV2RZcU5OV3c4NXB2SC9sV1RwZG14QUlKNEUyRndS?=
 =?utf-8?B?c003UThLVU53TXQ2NmpMOENFRmNHR0p4WmpvTWVoS1Nsc2cySkN3TkxBdDNH?=
 =?utf-8?B?TVJNNXJ6VHJ4MFZoN1FKVEorMEh4aC91NDJDaVZqMHE1d0NuajY0TE9jbDV3?=
 =?utf-8?B?MkgvemFwOXFRcFRDUldYWDU5dlE1Q0FOdUpYTUZuT2oxbmEwK2llUHp2cnE0?=
 =?utf-8?B?Z1NoREs3MHNBSlJCUVdLL2s3Yk9qVC96dXRjbmh6TWpCVmFvVjY3TGNyZkJ2?=
 =?utf-8?B?ZWhTeGJSVDRNT256RGNHTTFKVFZlQStreXhGU1EwdGdvUzJMQmxrQ2dLZHBC?=
 =?utf-8?B?OTAvUUVSMnlnV1lSbmYxUkV0ODVVNms4TDV1aTEvNWVyMm1NRjJSdWZkMkhQ?=
 =?utf-8?B?aEprVkM1TVE3cFRKZjBHL01aR1J6Zkd2Rmk3cDR4ZlNybVVCd1FmVVJPVGcx?=
 =?utf-8?B?eWUxUC9oVzVIcmpJTGhZQVE1SzdreWxRNjFQaG8yZmNvVC9ybXd6ZUR3SGxO?=
 =?utf-8?B?Y2RORnoxdk4yM1pVSG5oYTFoMWI1OHI5aTNON1VFSzZIZm41bTZ4cENHZmhm?=
 =?utf-8?B?WVJUTEdxc0h4bjY1MUpuLzdjcFpzSGVHcTgyamd2SXAvNVc0VDFwdVBLRDEw?=
 =?utf-8?B?aEh3V24zRTJ2V0lwcXVQekcxK0dXU3I4WUZhS1R1QlR4M1BURno1MTFHTVJa?=
 =?utf-8?B?QmVob1NnTS90dlUxM3o0RkdWTGJaQk1MSDNKQ3p0aDB6ZWxiYTlsYXExaTg4?=
 =?utf-8?Q?K8Z5D/MYim43EQ+yQU/EuCZrynzaHpowoqauP7mKy7ck4?=
X-MS-Exchange-AntiSpam-MessageData-1: uDzRgYkbCFWmhw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a333725-4951-4976-056a-08df40b9e644
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 12:38:48.8577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51ESB06hwVnlgoFr9k3ve4JtN1XkumFfmxYwwXTIPuWxilQxaLXjKhIqzTdp/TbzxcFjFOazyG22tHVVBU46Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFD911547FB
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Current code in IdPool::with_capacity rounds the capacity up to
BitmapVec::MAX_INLINE_LEN, but BitmapVec::new works fine with values
smaller than this and still uses an inline representation. Remove this
behaviour.

Change `grow_request` to grow to at least `BitmapVec::MAX_INLINE_LEN`
instead, mirroring the capacity floor in `shrink_request`.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Burak Emir <burak.emir@gmail.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/id_pool.rs | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
index 92eeb7caa243..f77bd90325ff 100644
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

