Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99329C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A58DF10F1C5;
	Thu, 13 Aug 2026 07:36:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="GpTszNPo";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013013.outbound.protection.outlook.com
 [40.93.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B515F10F1AC
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:36:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDR0ZYs9S0jQ1OXxMJOJ2uyYvoQQ9IvLx8ceTdwXL289u/cYw2mMNLvmbf87ftkLntksJMPL1FzKSGcaKzTU8cmiapSEyrhg1AGJ7HrldujKJG0kk33vuy01ewAivfb+T45N25q66VqykwYcivEh1VPaXhqrcU/YKk1Uu0RaDER/bYSr9LDZyvtHLJTu4ji0Biv39aKC4uafMUadZHl+HVNRWJt2go4FVpWS7+HOz686468aAspZz4Y7nPmkByKvqUU9vdQiCQ1dwX29h6E6ftVwq19146L0h7yhpP/ev4DrAeIKc8NSRkwKNjw8/jxwIGN6Lj7JkcqIOYBeNaapUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToVjYB7RCOIpG7q0sFm1Z4GISa3V9OMm23IEhEltW8I=;
 b=reWhDdS/3EufPIxHRH3OCBCOD+jFHgGjs6wa5hVp/3Wmr9BeFKXHCO5IWfJ77XfYxn0SNqbxof9p8whlkTG8lnN1L3MRK3exb613T861OF90La4VVnpXsvktQrbEgIN1RVcg0AhwjRLsQiAz4lfWkAgEZ4QL8DQZj2xRo/9XSHgp27xBfKrct705e3AtUokRDP0u/TI0AVNMPvcmSNPyx8BlZRyAHelmp0ktePJmZfim/6Qpnw+Nig5B3CiCdBoh7rF+U7xuMBGFLUglcr75pgTSSatUpVQa0QgwOqEMvkXsDNAsconSvqEJpyN3+Odw1mKlMpEX2m5sLSRfswDd5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToVjYB7RCOIpG7q0sFm1Z4GISa3V9OMm23IEhEltW8I=;
 b=GpTszNPorZhLrZKN6ZVQmoEmNT4RJZppZchb84oKHAi0pEZK38q96pBZjtqcO3yUn4yARKldV0P1DZSywOWB+qbFUxgDr3p+t2LHVNfYlL74ehvpAsVWuZLz2zzDZidXzTYuHUBUGfMhCAUVFesmppuPNJgOJHc18e0HTL5K4GK0nAexEjMWuX3/76qdsPsO67HAFw6e6JA5jFWaCBD32xlpFokbYsHyBayt3uYulFbwHj1oRYsiXnwdwkU993JJKX3N6xE1Uh31ygyspw4163P3l6ylJIi4AgA05IrDb6hQFZcfDjvMbx6bj1PJaK7OMvMwGSrX1R9NFbSNMLw/NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SAVPR12MB999144.namprd12.prod.outlook.com (2603:10b6:806:4e6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 07:34:55 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 07:34:55 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 13 Aug 2026 16:34:29 +0900
Subject: [PATCH v6 5/7] rust: id_pool: take a NonZero capacity in with_capacity
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-chid-v6-5-160be5dfb5bd@nvidia.com>
References: <20260813-chid-v6-0-160be5dfb5bd@nvidia.com>
In-Reply-To: <20260813-chid-v6-0-160be5dfb5bd@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0171.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::6) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SAVPR12MB999144:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cc16fc8-eefa-4306-f6c8-08def90d5ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|10070799003|366016|1800799024|921020|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8iUT6QDkfsPXUHVJBxCCMnYiBdZhZO2ml63NG6WUVvkim4rUZYTJcnKaODBJ07Xo16TzijWzXlTbRfcARsaat+h+hhExkb1G+pe7lXC78wvQ67dGhKPXniQ631JgA23/lbl0aikpjrug7jjw5ppbmEV9GtG7zVhc0nI48KjgDt96hwuCc9bF2rFsuJ8ywstnrn0wR8r1YhgIPqO9ALNNC51M/Sh3rX+PZICTFtkzDKfTGrdd/6LVbQCE0ciOt20J1RbC42sC039+VrE5ZlFhWZuhsfIlrmL8xHQCVVwhKanKZImgnbucsm6zHGp+SzYy2eYgVRjrx8XgAz5wkISQbRmcJbxOIx1VqoyLgV/CTvgpC+yCZTqeTbgmCYdsTWSwIeJMEsJzCZ6AjddMMu4jTpFMSpVdWQ9OT8b2Kso7a2K7oLGyXY9r53m4+vOulfbANLbn5Kb0B2di2qZ4Bv9JEUkrzkljSo4FtLRvpcjPI2LzL32gBaCVCHg0MvESp226ZPeXkxT0u8NWn8+QWCQAXT0uRiGxyYsXrVFyET4Lz7Ht7x2fxg9+82sOCvpze+Hyi9xlkKmf++vQAdg7ycLa4Xjz+abdmIxscfv4KGI3HdTVU96spN6osNEHDWOMGme068hwbAWuye5hivm5h5wzxfjL547HKako4rBXkCJC5NxfXAdKFk3DJ507x7e7N9rtEezUN+oxGwqJtX34/Kz7ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(366016)(1800799024)(921020)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXNxdXpQdXZ2SlU3Nld3UlNUUnc2cTZjWW1mVHRKN0MyRGI4MHlPSURWSWEr?=
 =?utf-8?B?ZjFub1haWVlWcGwvT0ZaTi94b0IxNnVKMS8zSzVTKzNBRVo4NDNBVFFHWFFa?=
 =?utf-8?B?R1FhOVhGY0JLZHlWeXREenZrQ2dVU29Sdk1qNVFJTmk3ZXFKUDNTQXVzNDJE?=
 =?utf-8?B?cUMzNGs2UWlHMnVtWDBKd05wK3BKWEp4VzFMOHc4eDcxa24vTVJCeUN0S1R5?=
 =?utf-8?B?bEVNM2o1NXMxYzlrLzlpRElCQ1FndTlrblRRQWZ5SkVkazJGVkdpbm5la3do?=
 =?utf-8?B?NTY1LzNpMlM3Q201WFMxeU5IYlovK1MzaWFCOHhGMXJ2Sno1Q3VLRkNseDhk?=
 =?utf-8?B?VloyeWwxQW9ha2YwUk95Q3BmS3JCUXRoUXJibGo4ZnV0VlhsNXRoSnp0eEV1?=
 =?utf-8?B?L1hzaXlQSDZpZHFHZzYzZ09SMGlubGlRT2VzamsyTlRwanhBQjRobS8wK0I3?=
 =?utf-8?B?RTRPRWw5UlBsV1lkTFQzdmM4RTN6YTBRVHpOakc5R3pXUzNyOEt0MmJrd0xC?=
 =?utf-8?B?UzVQSi9DbXJkMkhjcmxCcFJEWFdPWllMcmt0aTlMT0VkRUpEQTNUeFJ0MmYv?=
 =?utf-8?B?TzNDc0dOeldtRnRJMmwvYmxQbjNxK3dRUVZPZ2FKTWdFZUM5TDNKUDJpaXJy?=
 =?utf-8?B?dlVMek9LN2JBbmdINVg4QjJnOU5sZ1BqZ21HN0U2enEvNU80TXE5K0ozSWlu?=
 =?utf-8?B?OWlISHRNbmRQOEdUL3JPSjB1L3NqeFEwRXVSVmkrUmxicFBETzBoYWdrbDcz?=
 =?utf-8?B?RnpPR2NMS3dNekFjQUtaRFhlUEdMYVVRc0Q2WktwcGQra1hXcjF4M3FwTFBE?=
 =?utf-8?B?TkN4a0FlSVlKOW94di85eDNEbWh5NGM5eHlkWTZUckV5WjAyejZ1Q0tRUmlY?=
 =?utf-8?B?SlZSV1l1dEY0UERCREFZeVdydTNkRzNRWVNXRnlyeGNjS2hZYkVVMHRmb2Qw?=
 =?utf-8?B?N092N0tSbFMzN1IzNDBXMStUb0JvTG9qRjBON05EamU2YnNFM0xxdGNjQWR3?=
 =?utf-8?B?TUtTV3o5NmJjSGh2WkpuaVZyRmNxUWhuUkNvZlJEalFqMVM4TTNsVEZEQnJD?=
 =?utf-8?B?cS9WUFllZk1Ga3VqYTVuRTFJRXlKMi9qa0Q0b1NoMlZKT0tEWWlhaTc4NktO?=
 =?utf-8?B?c2tUM1ZMK2dZNWxsN0FaY2lCZFpFRjFIZ1kzcHJKVHZySitiN0ZCS1JrbjR4?=
 =?utf-8?B?VXVjOWxCK2tlbW10R09EZDBwRGpMWjlCQnFyZnBlUFJjSFVYNHBGRDN5VUh0?=
 =?utf-8?B?b2pMbUJNMGc3Z29XT0VlUUszWGJnUVNLTC9RUEFkT0k4T25kY1cwRzRCSHlP?=
 =?utf-8?B?UkFDbi9KaDVXbFBEYTQweWk0bjhBT28vV0x5QWFacjYvdVQ4SWE2Mm1vcUV0?=
 =?utf-8?B?MFRIZWpqZEE2Q2V5ZnExUzZiQmxoK1BnMmdQK29peWxvZWRIeGJjUWZwRmtv?=
 =?utf-8?B?WXpQbGRyMUJLell1cWozWjhIcDVPOU9TZzQwcTMxWEJjK1hPbnl5YW8weHVi?=
 =?utf-8?B?cnNiUElkY0FSN0d4bXcrTzQ5c3kzc1B4S2FuS2dXemRYUENUbFNqRVlsa1hI?=
 =?utf-8?B?LzN2WEpIbS9UY1V2R2dpemp3V0JFNTBid3EvN2QzckxlUkNoTHdUejB6OWda?=
 =?utf-8?B?bnROelFMRGlGVmpwN2JtVnFKR3dIcjduZWkrRmFLTnd3L282bTlwVFd4bnlM?=
 =?utf-8?B?c2NKQ0IrbzJYRjhWUkZjMHh6TmI1WlE2VUdIcXVGRVZBcTM0ZFFNUmVwek85?=
 =?utf-8?B?UCt1b2NPcjAvRG8rNDBrcEtNOVBjcGVwamtwb1ZNWVVsSjI2QXg2ZUJsSTlK?=
 =?utf-8?B?bDJnRlgvdVl0TmlCMjU1aWE2K2kwUDFKdk15TTJLZjRsckd6YTNaMHVrOGNQ?=
 =?utf-8?B?aVRtZHlhWGk5clpVeTU0SlhEa1VOL3doTWNXaVZEdTFNQlRrVTFWUmUzVGRo?=
 =?utf-8?B?SlB0U3VOWWNkVWxPa2R5QWY1OFd5Qm9jVDB5TlBnUWxkZmQ2YlZkMkcrR1Jt?=
 =?utf-8?B?Q1QzbElPeE9lVkcvV3lXb0VGbVZNLzE0aFdtb1dWSVJmNzd2VTR2aTJsTHlj?=
 =?utf-8?B?OVJHaHRKNEU4NjZxUmtxUVpsaHNWWE9Nc2JWU1FhaUUzZEt1dFdhdEYwZ25U?=
 =?utf-8?B?WTVTc3U4T1lLSW5HKy9TQk5RK1lZbE9uN2JBNkJMenc4dWlwbDdNWVRKWWpR?=
 =?utf-8?B?d1FDMUV3QkthRUtIOTlITlpIMFNQdFoyazJPc3FVMk16RnYyMDZyUktsc0Uw?=
 =?utf-8?B?UzFBZDNyckc5K05GalhjR25MbUhPT1ZHNFk0ZEkyaUFzQURTdWtRZWVZR3J5?=
 =?utf-8?B?QUNlWmFRdTl1bVNFeWk1NDFYenk4Sm9BRWlhZ3l3UWdlR3cvV25IZnBYNkVn?=
 =?utf-8?Q?PEVGFxRVk0XYkYR1YdVjazaAMqe6HV0eXBLGgRwGJdzCz?=
X-MS-Exchange-AntiSpam-MessageData-1: sn7jdCpW0hbKLg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc16fc8-eefa-4306-f6c8-08def90d5ee5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 07:34:55.6095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AcGuwQDA5aUK+y3DTogoa+Rf8UdrLqCNnXdt4C7FTtd16pzTPa3D+jnm73XKPNkjY6tlBmhPwBZYbbsMvSdJEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999144
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

There is no good reason to allocate an IdPool with zero capacity.
Reflect this in IdPool::with_capacity.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/id_pool.rs | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
index a4a2ff417fe8..1423a5fbca69 100644
--- a/rust/kernel/id_pool.rs
+++ b/rust/kernel/id_pool.rs
@@ -29,10 +29,11 @@
 /// Basic usage
 ///
 /// ```
+/// use core::num::NonZero;
 /// use kernel::alloc::AllocError;
 /// use kernel::id_pool::{IdPool, UnusedId};
 ///
-/// let mut pool = IdPool::with_capacity(64, GFP_KERNEL)?;
+/// let mut pool = IdPool::with_capacity(NonZero::new(64).unwrap(), GFP_KERNEL)?;
 /// for i in 0..64 {
 ///     assert_eq!(i, pool.find_unused_id(i).ok_or(ENOSPC)?.acquire());
 /// }
@@ -117,8 +118,8 @@ pub fn new() -> Self {
     ///
     /// [`MAX_INLINE_LEN`]: BitmapVec::MAX_INLINE_LEN
     #[inline]
-    pub fn with_capacity(num_ids: usize, flags: Flags) -> Result<Self, AllocError> {
-        let num_ids = usize::max(num_ids, BitmapVec::MAX_INLINE_LEN);
+    pub fn with_capacity(num_ids: NonZero<usize>, flags: Flags) -> Result<Self, AllocError> {
+        let num_ids = usize::max(num_ids.get(), BitmapVec::MAX_INLINE_LEN);
         let map = BitmapVec::new(num_ids, flags)?;
         Ok(Self { map })
     }
@@ -138,6 +139,7 @@ pub fn capacity(&self) -> usize {
     /// # Examples
     ///
     /// ```
+    /// use core::num::NonZero;
     /// use kernel::{
     ///     alloc::AllocError,
     ///     bitmap::BitmapVec,
@@ -147,7 +149,7 @@ pub fn capacity(&self) -> usize {
     ///     },
     /// };
     ///
-    /// let mut pool = IdPool::with_capacity(1024, GFP_KERNEL)?;
+    /// let mut pool = IdPool::with_capacity(NonZero::new(1024).unwrap(), GFP_KERNEL)?;
     /// let alloc_request = pool.shrink_request().ok_or(AllocError)?;
     /// let resizer = alloc_request.realloc(GFP_KERNEL)?;
     /// pool.shrink(resizer);

-- 
2.55.0

