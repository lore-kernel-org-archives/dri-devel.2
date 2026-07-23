Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEF6C531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 09:01:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53D7210E778;
	Thu, 23 Jul 2026 09:01:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q7emB1sC";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010055.outbound.protection.outlook.com
 [40.93.198.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9D4410E778
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 09:01:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOzdAGVcYKGLlsrSak8culzHWOAxT+37/mlv26qgLko5Noxs0AGmsXE182hmQkv2NiaYPv4jrLpux1hrw2h/UGRj2tEpnx2ewxNsi/sdLzQZ44l7Sgh/Ku7U7JdQEl0e8TahrJGWN4qxcHP14GMA9VTK4HMjjf0igCjZc42UgRW0EucL3jcKy6TvO/DJMJQfqXPpDcUtJWJ7l7ktyywmvLyadrJW6S8hDkCC+sE/gfhkLjvrb4QpssziFhnv7rZBHkp8VQuymtBvChxdzFuCOcC60wBwCcg8uBnwRot7Z6J2gbH1+2YncaFXGm7g05d98FG2DE7zdEYFRPfdp/7XxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fC0pQO/Qhj61kXLWX6QAZzDFfLQaEuQTnbgtsLnh/0=;
 b=SwpjvmFzwSbPjaHJsqkIfEypeWcz8VSe1N7MBTH3ult+TDzLEgBA4U+oZ/97Gr+qk0lquvwSRZQ0riULAg7TctytzXBAWGEgorSY5f5LFJkxeGRw6CjcPlgdL3jZemxDUNjA7vHAwO6c4bVjj8auL9L0YvuyhY2cJXgCg7KWbaB4yyw4j6leXirWS8blgI9CB6l4BzEgw9bf3DQvyqxowR5X0HIusbQYxWQujSj1D/ZIKC77jmiop1aYTt81Him2dNJiuJr56u4PrIz9csTkRV4kmEeSFLMRpL7zrQEULmISoqPbU+cFo9tkwlFT/Q/nuSwu0KR3sQSRTIDM4re5tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fC0pQO/Qhj61kXLWX6QAZzDFfLQaEuQTnbgtsLnh/0=;
 b=Q7emB1sCVIJo8seRNLiCiC/3VbL5aH2p9DKUPSOy5hy+nkjWURbUNdAMnGBOZZAPUsqZUHwmRg9Rkazq3JCghi6zUrMCS8v4QPM3+oDjaoSobWMJ8MFKvoPEIUdbd0cxu/ReAtnM1lLbFD5xJ/mgo0dfsBUDNmfHnWwqPElNJTninvNZlAOQGITUWb9hCU83MHUF0yVoIzk20NgwXanlqdb5CtR0hLoCYS40XQNUzWfDnG67cEOPr+AohqNrNzwO1vZ1+sQFLBmx20ejkukjaXK7ZKQGTeWQsrWipn/bQ9Q9YSW3tQ7yQl2rQF1qhh8yVQ44I7EBn0jx0rfqK3IdCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Thu, 23 Jul
 2026 09:01:03 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 09:01:03 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 23 Jul 2026 17:59:12 +0900
Subject: [PATCH v2 3/4] rust: id_pool: add contiguous area allocation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-chid-v2-3-c35e5e9fb3d9@nvidia.com>
References: <20260723-chid-v2-0-c35e5e9fb3d9@nvidia.com>
In-Reply-To: <20260723-chid-v2-0-c35e5e9fb3d9@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0322.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::11) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SA1PR12MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: af4d4e8f-4b80-4feb-d607-08dee898ec43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|10070799003|22082099003|18002099003|10067099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info: GjhbcUR5tWFzaNkOdK09DX5HJS+ZGOwHgfI2Y/K1xyPp3Rm+Biu6VzCb4Slm2RbO9fDGdEZYsgGp5B5Qz8WixX33uFK958eVqocB5S1lCMlKgc2p52cX1/XaC1FuvRhzNPpw09Vv9xlBRwWBYbl8h3GVGk+lRdtfssa+K9OzdPixjtHj5A8grAW587Y11Mk1XU/ztGamRTYA7WeeGxFN2owH8HzqACePEW/EEYz+xGDiOkT4acjUzcqRyqYbcdAwxU2vsjhiU977/0LIW/DJi2AyYUPt740Xk83zTBte3HdnWq9SkCZq+UYESsIWOHRBLgk7GiVCtp5+uVEqtu//JPWs8JD53YhAu/WG+CsJpFrjowObDu00Mj6elBdA38IQimNkephzgS1EePmFdd57iS3iBPqLnTL7I3kS2Yjv42zYCciOnznKLZ+EGkO1v7ffFClofMrqmg/c0/YZL2b0av9PQKJpHFW+TMguVSvY1ntWXReeGx67jQtWCM9VrD784UCsKZACCZVZaKTfTwkv+FydUlxuZxnAS/GeFSNUJ7GtyUTKmy0nW37camM0jOGjO0oi5DMwA/zXnB6/GlX+wHCrHb4aw7xt7qrYMBeDB9eM4T/nfawni/0b9Hvngw5jpJa11pEyZ4pzTGM7RtwEEgB0UFb6AopXjrYvQk+WMbsxJ1AbmP4Kfh9/5HUoxQkWTU+vCPooGrHEW917cfLh+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10070799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZldieERJMEhlK0JlRjNkL0pwSXA1RkphS3FSdzk1YmJFMDZ1eGpJMS8vRHdX?=
 =?utf-8?B?WHo3R3R1U2N2ZmptQnlKanlCVEZkaUFqNGlIK25LTGUvNzV1UlBiU3o4MDl0?=
 =?utf-8?B?NEh2ZWNxWTFxbURQeUx5MU5RenZ3Z3lsZHFLR1grMlBGN1U3c3RHbTJyZURh?=
 =?utf-8?B?VElRRDl6ZldqZlBFM1U2MURiRUErWmpuL2htQmtvUWdUdGtqVlByK0l1N3NX?=
 =?utf-8?B?QVllMFlsTFVlSXJpbTU4ejczSkpCS1Y1VDM4ODNOQUF3RFhtc0Nyb2k3K1VG?=
 =?utf-8?B?QVFuOWV4UWVHdkwrTzJxNDdERWlNN1BSMTQ0bUdMTXhOeHRqdDFFaGlNOWIx?=
 =?utf-8?B?R2ZnQmgraXJtM0xGRndnSlk0VVA1aWlYMDNjSXY3SWgzRHFTbGR6ZjJnMlZK?=
 =?utf-8?B?R3pLY3Vac2NDNUNmdXd4cUVmVktIWXJ0MTRKcE5rd2IrdERMTEM0MnZCTENa?=
 =?utf-8?B?MTcrRmFVZDdWaU92S0hWTEIvMHYxY3hmSnFVOGlwUFlPQkpnWU0yTWVmUnpu?=
 =?utf-8?B?cHdoZ3BPK3JmdnNJS0NpQUxuU0E3ZmdvNTNCYjlpbDMyZGJNMVBwcjIwRnVS?=
 =?utf-8?B?ZFptbFZiSnJtNXY5MXk0SnNsdzZ3ZHp5dDM1K2Z5SVBkNjJoZWNQbFVUQkJv?=
 =?utf-8?B?YSttb29vdDBTalFRV1ZtbkY4RmR5ZFp3QVQ5WFBCdktpd3BOMGRjTCtzK09o?=
 =?utf-8?B?QlZ2d0c3MmJTRDFweGFQNmxMbmd3dUVNSHZCYktINUNCb0Y1d05zTjAvL05w?=
 =?utf-8?B?dWM2c0VIQXp5RDVpUi9sS1Awb01OT0ZJTStDUyt2QnN6YlJ0WU1oc0FSSlFZ?=
 =?utf-8?B?eXFvVkpTVElCQXI2SnlLbzlQeDd6dFZZRW1XSk5IQThPOG44RlRrUmZ2NXpy?=
 =?utf-8?B?WFUvQUl4emtDSFNkRGptcVRVOGdkRHU5TFNJclErS29Md0RnMG9uM2hqbm9t?=
 =?utf-8?B?bnJyRWJPNm80QlRQK3hQTkV3Q0NGa0YxZGFhTFo5U2h4RGRFUDhaREJvWnVk?=
 =?utf-8?B?M1pwcUt2YWY3TklEdHh1eHpqQnBxdStwaUlkem9QbGJTTDBJS2JJQWhHTEtp?=
 =?utf-8?B?RHhyK0ZuVURCWHZrVk50bzRYa1R6NkZ5UTRnL1g1U3FXTElhUGl3TlF2Y1F4?=
 =?utf-8?B?SnhZOGF1VXc4SnY0QktiRVpIMGhUekU2cjFpd3ZlUzZTMGRVcnpxcXZPeno2?=
 =?utf-8?B?Rnl2akNBUHlaZlFnVHlxemVXQTZlZnRnUWEyOEQvWVErRW5nRHV3SHlkVjFm?=
 =?utf-8?B?aEZoaG5HZTcvcWZyakpnOWJSMlZKdUdsZWp1Y3ZFa3ZJM3pCSHpxN2RHS2Zs?=
 =?utf-8?B?VW1nUjRSOXRXamJvTWpXcTdyb0VNcGRXODJhNG5UNExmQTdYQklQaDhrWjIw?=
 =?utf-8?B?YzlVdGRJYnRCWlIva0tUU215T2lKVno1ZW84TFFhK2psTFJkZTJPbVJPOWtP?=
 =?utf-8?B?YWdCVEpCNWJwczdiY1MwQmdGc0hldXdCMlRlWXJEaklFcTcwL1dXVjBwUjla?=
 =?utf-8?B?VVZGVG9mSyswWlorTHFRUFI2NzNWK1hTN2NUbzF1SDBrVVhYMm5wSlc5K2Vi?=
 =?utf-8?B?ZnhDTE83eXN4b2lNeCtybC9VTkZwSk5OOUNwcFpaeUdHVURpbGtzbXkzVFlE?=
 =?utf-8?B?ME1Qc2VSNkIvaUZRY1VzYUJsM00zd1VsL2VKZFVUM3IxZmx6UGRPWGZQNk5o?=
 =?utf-8?B?NFVlWmcxSGVNOXpndll5ZVFSNHV2ek9VbDNCQ2NBb2tzWktHS2daWUMxSmZ4?=
 =?utf-8?B?NVE5S3grZFlvUnlGMjA4YStTaFlmRU9Ic2YrQWRHZSt4Z1Jic2Vta3hTVzJF?=
 =?utf-8?B?VHZkTXJpQVVMMklCM3l6UC9PQ0pFR2pyOEVxUVdRTFRKY0dnTS9MVWYrTW5I?=
 =?utf-8?B?SGZxdFRKTXlTeHEza1ZxeEIwQUVsb3hNaXYxL0xUallkZzdnTzRtbkc1R3Nk?=
 =?utf-8?B?QlFVQmxuWGxKVUQySlhCRWNzSS9pUEtob2wzKzU3ZGVmbWdJUFRDa21Gb0ZE?=
 =?utf-8?B?MzBIN3lxSVArY0RlU1VUU1Y4RHFhODhvcy9paWRmSWZEQTAvMXk0WnN2dHZC?=
 =?utf-8?B?eTdZZnArMTRCVFJETW50NktuRTJCMWI3cXg5UEtsdGxNMElJTEtZUERQcS9a?=
 =?utf-8?B?UWQ2YlJobGhUem9kdUFwaks3Y3Y5WVB5amFYNGtJUkxDRTRURjA2V3hEODUy?=
 =?utf-8?B?RHN4K09kWHpaUlZLU1FRTi9xdjc3YkppdUlNUjgzRzMrelNuV3hLNHRkcWVK?=
 =?utf-8?B?UURRYWdBN3RCYlBQYkNHUjRpK2tJRTJFb2E0bUN3cGs1cC82cGJyRzYyMjVp?=
 =?utf-8?B?SUlZemVCVXYrdk9BMnRrTnBrNk9DQzZyOXRmWkFoTGU5bVQ1RHhORUI2N0tq?=
 =?utf-8?Q?yLg2gO0tsTtrTWD6VlEx88sUvvssbHG5ISb7Gp2PJ8MqI?=
X-MS-Exchange-AntiSpam-MessageData-1: 16pMoAw2zVT6FQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af4d4e8f-4b80-4feb-d607-08dee898ec43
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 09:01:03.0880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: irbRwiQNcYJo3IsEqgxts3h7bmCCTwoZgwPaU3FishKbpVg7Zp2AGzb5s6dYn622a83i0Gqj3Dgsd8fMyiuoyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104
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

Add support for contiguous area allocation. Add a new type,
`UnusedArea`, following the same pattern as `UnusedId`.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/id_pool.rs | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
index 384753fe0e44..b1d05e0429a5 100644
--- a/rust/kernel/id_pool.rs
+++ b/rust/kernel/id_pool.rs
@@ -4,6 +4,11 @@
 
 //! Rust API for an ID pool backed by a [`BitmapVec`].
 
+use core::{
+    num::NonZero,
+    ops::Range, //
+};
+
 use crate::alloc::{AllocError, Flags};
 use crate::bitmap::BitmapVec;
 
@@ -240,6 +245,34 @@ pub fn find_unused_id(&mut self, offset: usize) -> Option<UnusedId<'_>> {
     pub fn release_id(&mut self, id: usize) {
         self.map.clear_bit(id);
     }
+
+    /// Finds a contiguous area of `count` unused IDs at or after `offset`.
+    ///
+    /// `align_mask` must be `0` (no alignment) or one less than a power of two, in which case the
+    /// start of the returned area is a multiple of that power of two.
+    ///
+    /// Returns an [`UnusedArea`] upon success, or [`None`] if no such area could be found.
+    #[inline]
+    #[must_use]
+    pub fn find_unused_area(
+        &mut self,
+        offset: usize,
+        count: NonZero<usize>,
+        align_mask: usize,
+    ) -> Option<UnusedArea<'_>> {
+        let start = self.map.next_zero_area(offset, count.get(), align_mask)?;
+        // INVARIANT: `next_zero_area()` returns None or a start with `start + count <= map.len()`.
+        Some(UnusedArea {
+            range: start..start + count.get(),
+            pool: self,
+        })
+    }
+
+    /// Releases a contiguous area of IDs.
+    #[inline]
+    pub fn release_area(&mut self, range: &Range<usize>) {
+        self.map.clear(range.start, range.len());
+    }
 }
 
 /// Represents an unused id in an [`IdPool`].
@@ -287,6 +320,42 @@ pub fn acquire(self) -> usize {
     }
 }
 
+/// Represents an unused, contiguous area of IDs in an [`IdPool`].
+///
+/// # Invariants
+///
+/// `range.start <= range.end <= pool.map.len()`.
+#[must_use = "the ID range is not reserved unless acquired"]
+pub struct UnusedArea<'pool> {
+    range: Range<usize>,
+    pool: &'pool mut IdPool,
+}
+
+impl<'pool> UnusedArea<'pool> {
+    /// Returns the unused ID range.
+    ///
+    /// Be aware that the area has not yet been acquired in the pool. The
+    /// [`acquire`] method must be called to prevent others from taking it.
+    ///
+    /// [`acquire`]: UnusedArea::acquire()
+    #[inline]
+    #[must_use]
+    pub fn range(&self) -> Range<usize> {
+        self.range.clone()
+    }
+
+    /// Acquires the area.
+    ///
+    /// Returns the now-reserved ID range.
+    #[inline]
+    pub fn acquire(self) -> Range<usize> {
+        let Self { range, pool } = self;
+        // By the type invariants, the range is within bounds.
+        pool.map.set(range.start, range.end - range.start);
+        range
+    }
+}
+
 impl Default for IdPool {
     #[inline]
     fn default() -> Self {

-- 
2.55.0

