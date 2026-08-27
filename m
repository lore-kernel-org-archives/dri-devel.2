Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBB1C61DC7
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:31:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1900D10EED5;
	Thu, 27 Aug 2026 07:31:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="TJGaM5ds";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03BC110EED1
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 07:31:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMRcme4ShwSDS74qckcbVeWoLY/+tQ9KGPWhhoD8J/XiTze+33ybUko3yb6NiYYFm0a9/ytXptHk40ozDHwkQBRCj5jFMZguKC8fNZLOvUOMoo+UslPjU1a68XkVZNmmbVbZF9QomxdxzfbMYmbC0aspdMh9GQuf5ES1U+9zvggWpaMp+p4XE0O79iq7a2KVFOv0zeMhs1QsJTIFB8eFUgEc1bz+h08oeZYAlz5hvg/mXgl8HYJSYXSUJoUugCf4fLDIeoUz6646cbv3QSL2GqFIAZ/JMBxKy5yCXyF3fnsLmJZqKxXy4ZgwfLbE13vtd9/95PazHxx9TmUAhn1MGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YtbUKc377qG17bT8z4QPM/Yq7iyKZdime++Sy7FNDk=;
 b=rjPyZJ85GmfkcJ2uc2ZgQVZmxRuGeL7dff4GjZ8DEjaGx9ER5zJYaGsNlPWQe/CG3rSIuto0qmULnVexlzx+0ZT7YeP8OWSCI10ZZUlAZ2Yv4rJ67/qbgbkFN39TIlzPOGWm7b8ww6FcpXXzR23A2TclFtZ48dchvQqDdutay25eYbjG/pdeXEcLK+5+7VDvpNliYZypZtE9VShmHvebVfprJQdBIFnC+qNWsLU+B4pNn0lf7rEApRW89fdeJ8PS/AWiYpcIQZJ33qpVtk7kniZijs1jKHaFI4penz9fCZbizOXmRF2qtYHCBxpEaSoZkxV53S1xZGUKwQGZ06LsNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YtbUKc377qG17bT8z4QPM/Yq7iyKZdime++Sy7FNDk=;
 b=TJGaM5dsimXm6V0b5Sg+gLwIkK8vLnuD3e/5Z2uCoV2J1WZSnbby3+3d51kUNUFsAdTwCfSHcF7Mloo8amrW+coHE40zNphNTMOtpwgps3XhZjiT/C0/jK0Lbz82kZIFh8k/XuQYY6lvwe5sEwcd8lGA8DqYwnYAq32F6b1BesPYSzgCHHiqFwqa4sZg9iWtO7lnGlYdwfE1sSsWXoBDh4p27Dc37YahHPdwWpxcku+8ErB2r/qo9cAJNFwuKinJDDcp8ACfrIBLV5BHkYoVK5fl9ZhHXixVU/r6e6i2H/x9CER9dlvt6ZkncueEL4BdRo/h3f2szierIogS7/7+Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS0PR12MB999081.namprd12.prod.outlook.com (2603:10b6:8:2ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 07:30:57 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 07:30:57 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 16:28:38 +0900
Subject: [PATCH v8 10/12] rust: id_pool: add contiguous ID reservation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-chid-v8-10-bc74c77d0214@nvidia.com>
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
X-ClientProxiedBy: TYCP301CA0032.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::15) To IA1PR12MB6411.namprd12.prod.outlook.com
 (2603:10b6:208:388::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS0PR12MB999081:EE_
X-MS-Office365-Filtering-Correlation-Id: 9971b4d9-e63b-4d1a-bb63-08df040d224d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|366016|1800799024|376014|56012099006|10067099003|18002099003|22082099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: zKjzlknimXNUcRo/cQqfySNPEOQnLhkBUKxDpZ8l9DHiwAake3bye+VtE8XvnqubuNQSKsQ/JeUPiKHEXrqShuxzZlO/s+/g3+FmDxdu5orzuTTDg/OXdsnT/5JZ/2G1PKe211yGk2dyobD/y5L0P+BAKarO7S1pQcxJo2yzA/dxtZcp85CI0aX+V+ING92/BW0H8t5Ko3PNpNp/TpPlLKRt9ja14ufF9WHc15/5tbzsSfhQw4fsAxygGcSKclRduKHJKSQdCo4XhFmsDl6fGW5hXrwP+BbfvGwCVJQKl2SUZkhG2NA/lfPC0nBay5Q+FD4NLLxAje1KdCfoJTK5DrgDZ00LAZrClo31ch5KypikdHnrOR0qtNBvrjvpiSamqSzYmLv+XzUKVM10Rc11/2VPpJRCQK2rbra40HT4P+3YfSvy6PKy7JU1sqvNcTnLR3dto7tH2Uq/DEzoVWlc26Klu0xLbtvAZwJPMOoe/MG9ilz4wQwGbI48EgVaS4wHDqJa+gKYR4LAjbr7IJsOMNwqIPEK6qKlsG6O9X0lu5Y9ExBkLdQPfajWK2KPDSs9b8SuY/vW48OHuBG+ZM4kKjYeQtD3rby/EJ/WprUz8b6edLIiwmtzy8r2jKYwUvtpWWLt9mO30qQmTmssL8JJTzYcv5Lnv2nsinL1KYhp/9Ee0X0pJfUt9U6GmAfaINLSxZv+16KffuJhdXXTmwqkCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(366016)(1800799024)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkhwaGNGS0VYcXF5RG5tVHFOT3Y2UG1YTVk0UEU5d1pIeWNLL3ppUCtwNXRx?=
 =?utf-8?B?enduUGJLSWdRYlJ1SkwyczVRSUNLRVFydVpQSCtzWHVLUzNiUmY4SU84NmRK?=
 =?utf-8?B?SDNxRWVRUS9DNW9rSTR0cG1OUW5PMktucE0va3lWbWZMME1MamtTeXlTSjlU?=
 =?utf-8?B?Z09XRnQ3SWVPRzdvZzAwdDEwMnFlcGh4VWZKRUZiVmw4VXFuUFdEMFRjNC9E?=
 =?utf-8?B?Nysvd1pLZ0dna1dXWGF3ZWtpY05IeDltN1BTYmIrblhIejhxbGdtNW9sWnhD?=
 =?utf-8?B?UThjTUE5QnhOejVBRE1sOUpXTHIvRms2YXIyRm40dGtTUnU0Y0tXdWNhN3Z5?=
 =?utf-8?B?bnB1SDFqTkROVXJFQ3NlY2p6WURlT2xZMjY4SUVlcVJneVI3ZVlIZkIxT2Ju?=
 =?utf-8?B?RkpQaUQzTFVoT2VOaEdzQ1FoUUNNZFhKTGFLcUdiZjZQVi94dnFXT0JKUkpS?=
 =?utf-8?B?dDJuaWxEZDFhTk5oQjEyQ2hPclBuY0tPZkt5emI4RkFOY1RFeUErMTZWTkJt?=
 =?utf-8?B?eDBrTldCbGxWUjVzSGx0Ym03b2lMbjhoeDBWYk8ydk1pMXhqN2dHY3NFaE5h?=
 =?utf-8?B?aDEzaHVhQ2d4N0QvTVVQT29YVTJndWlEZ0tFUyt4Y3pXQzFlbDhWNTg5UXhq?=
 =?utf-8?B?TnRKREJrUWpxY0lLSFBuRjQwU1Jac3Znc2JoTTNnbEpKZzIzcEpaUDU4ZE1i?=
 =?utf-8?B?MllTazB2R0lCZ1Rvcy9mM2F3RkNVRlB0NU1ucUJkZFRrOTFjZHhsOTlOV1Jn?=
 =?utf-8?B?VnRrZ00vRVBVaDN2eFlIQUVGWHh4Wi9BclRQQTJhejBQdW1UWGhCRjlSQUNK?=
 =?utf-8?B?T3FveDNQYS9CRDVuc0ZmanRlQ2lOamdWZjAzdHNHY0Y2a01ZRXlGWWZUZnpq?=
 =?utf-8?B?YUdsdnQramlyMWZLeGZSNEIzQ1BKNU4xV2pUZzQyV2NQZ2ZJREN3TEM1UjlV?=
 =?utf-8?B?aUkrWCtCZkpFbE5OLzVPQWxBWUlwYjk2bmVKalNDWFFoSWZPY0J2ZWZuNjB3?=
 =?utf-8?B?VFdBQ2h1UnZnWlJGSUhFMEFINUhQZjVOODYrQXEyMVdCcXRZdmhmZUp3Rm9i?=
 =?utf-8?B?aVVMcklOK2Zkck5mNnRtei9QeFZwQWYxeHJWUWhPUDVZZHBaS3BQVUx4dWZw?=
 =?utf-8?B?bVEydlgzWlliSmJwQ2lDYnhYK2s1NkhMRHN0Ry9OT2M3Nk50M01Wb0pBaDkv?=
 =?utf-8?B?UjYrVW1Eak1PdzU4OHpIYTZPSEhrMDR1VHdBTzgzNS9tR1NWOHZEWjJkZjYv?=
 =?utf-8?B?ZU9PWkNQWHh1aTFMRXV3NmNueTNxSzRKNmVrNXNXa2lyQXQ2ZGJUWksrY3lM?=
 =?utf-8?B?UHVOTHNZY2lCczVvWmowODhlQW5pdE15Y2FMRVRzL2d0Q2VqSGpBOWlWMk9K?=
 =?utf-8?B?VW9kOTdJNG1RQnE1UFlJVitvbzBzdVFQQktXN0ZGbElHQWpYOWZpUFpDRWl1?=
 =?utf-8?B?WDdyWHYyVmQ0bU5Pb2dqdG1XOVRsRWtHVS9MVmQyakJ5K2Y5Nmh6alFQRmxz?=
 =?utf-8?B?VWZmdjBJUm9DdDNpNlZMMXVNR1VMcHFyMnhIc2hWN3dkUTFwUEFRU3NMbHRt?=
 =?utf-8?B?RHdkY1RjK0V0YTFkamZuQ0Nqd1lHdjFmaVlneEIrbGtnM2ZETm5PaE85SDhp?=
 =?utf-8?B?aVNXM1BCTDgvOVZqUy95STgxMmxJYkhZd1MweTBPTGhBQmVmRmc5MlIrRHc1?=
 =?utf-8?B?SWQ5cXQxSzhPcFVNZzVrTEJHL2x3NWtqWlpyMUUyczFzUzN2Z1ZSdEJxMnlT?=
 =?utf-8?B?OW5lRllZVVpLaStBWStOVHNxbjBqenB4dTFWOUdqRmluS2RZem1YN3paRWtz?=
 =?utf-8?B?dHVNY1NOMDYxMm1KbDVHNlYvTmxnR2tweGtNb3NPenlzd281RCtyRkhZU2RE?=
 =?utf-8?B?bDZGMGRJTXJEOHpYV2JXY1VDWURkODB3QnE5c1RQMG03T0MrY3dPSzhNMGds?=
 =?utf-8?B?YTBXUjA3bUxlYklvSWhva3RYVkN2V1h6Y0NZc1FGOFRzc05QN1hTUldqZ0dD?=
 =?utf-8?B?dCt1b1gycDRJUjl2eVFJdHFTWGQ0d1hiZmFkallLMEx2MkRZdXNROG1vTUxC?=
 =?utf-8?B?QmRubE9aWkMxQytsNlpaME9aVU55Z0V4MFdsbXVnYUVvNXBpZzhCdEdEd0Ny?=
 =?utf-8?B?MFk3WmxXbjBuQkZMY2lvUVlqT3dGcDFKalNzT3RmL1o3TjV5cVp3NThVS0Rt?=
 =?utf-8?B?MHNlT1duczQ1K0xyWENBNDNLWUJlY2wrRktsZDc0b0FDanM4M2JJcjN5cUQ5?=
 =?utf-8?B?bERLNDgvK2p2cEhPWEk2QTdtb1Q1ckdoaWhGZDk4bXZmMDEyWTc0T0dMUldO?=
 =?utf-8?B?UC9JV2RkdW5pakRWSTlhK2V3SC9jOTZvUi90MzUvNFkxV3oreGpTd0YzeFVY?=
 =?utf-8?Q?XCueVtD6bTBNcfhDz1pdCNtafRoHGKwmYC/u4GGZVoOma?=
X-MS-Exchange-AntiSpam-MessageData-1: z3Zpr4eKLIXK1A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9971b4d9-e63b-4d1a-bb63-08df040d224d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:30:57.1515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+lQ3U5glP04+qIIpL5NiLGYUfI1mUG6r3mfC5tOUU2I5MbOyFiKXOmv/a+5Rko19rcFAHqOWkLad17ydllGHA==
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

Add `IdPool::reserve_ids` which allocates a contiguous range with the
given offset, count, and alignment.

Reviewed-by: Burak Emir <burak.emir@gmail.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/id_pool.rs | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
index 384753fe0e44..06a4c71c4c6c 100644
--- a/rust/kernel/id_pool.rs
+++ b/rust/kernel/id_pool.rs
@@ -4,8 +4,14 @@
 
 //! Rust API for an ID pool backed by a [`BitmapVec`].
 
+use core::{
+    num::NonZero,
+    ops::Range, //
+};
+
 use crate::alloc::{AllocError, Flags};
 use crate::bitmap::BitmapVec;
+use crate::ptr::Alignment;
 
 /// Represents a dynamic ID pool backed by a [`BitmapVec`].
 ///
@@ -240,6 +246,32 @@ pub fn find_unused_id(&mut self, offset: usize) -> Option<UnusedId<'_>> {
     pub fn release_id(&mut self, id: usize) {
         self.map.clear_bit(id);
     }
+
+    /// Reserves a contiguous area of `count` IDs at or after `offset`.
+    ///
+    /// The start of the returned area is a multiple of `align`.
+    ///
+    /// Returns the reserved range upon success, or [`None`] if no such area could be found.
+    #[inline]
+    #[must_use]
+    pub fn reserve_ids(
+        &mut self,
+        offset: usize,
+        count: NonZero<usize>,
+        align: Alignment,
+    ) -> Option<Range<usize>> {
+        let start = self.map.next_zero_area(offset, count, align)?;
+        self.map.set(start, count);
+        Some(start..start + count.get())
+    }
+
+    /// Releases a contiguous area of IDs.
+    #[inline]
+    pub fn release_ids(&mut self, range: &Range<usize>) {
+        if let Some(nbits) = NonZero::new(range.len()) {
+            self.map.clear(range.start, nbits);
+        }
+    }
 }
 
 /// Represents an unused id in an [`IdPool`].

-- 
2.55.0

