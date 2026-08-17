Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD9EC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70EA210E692;
	Mon, 17 Aug 2026 07:04:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="TQAKUw53";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012059.outbound.protection.outlook.com
 [40.93.195.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC17D10E690
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:04:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4UXEfiYdtF+rRD+JPslcpmkn/DWOZabuzaM9WT8YaDVGnYdRdgJvpjViyYcYZvhiTlHgGEA3fyiBH2hF1jKrlpsT7TS4PdCovK8Rq3KKFK/U5JsG0P+fJh2XGCVtZ/e56BCfF/rzGH1PWZQZQj1rdkAIjCWXC6wUPfoqA15GKeerBJ6eUrcmJL55cqytp+VlPBCwaDpjDRUaZBwi4Jt0nDwA3OQaAw7eERZ3C+OBo9YbjyqhYctdOsDJ7uN8c6xWCs2xctRHnc/wln7AcxhHDTcDjeWZ9HlVfEx+/1C6x+kE2uEAPAqSMUu/ESceiCWdrzATpwRoqyt2iFfrDwOtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfR7BezP17/re4Oxh7ni8OWl9Z7fakpTQqbOTdYH4pM=;
 b=owgca2ztCT8KWU5U+VJq9nAncgtcfF8Vu1a6jWX5zPHKU1ZMJ9b+ygwjYBGlPU2b3qctK59RwsuFQHqZMNRpyqwWTQm/AWiEASjeVVT5iApPeeSQRNcaSXO1gpTtzrBf5xr/s4iUkF37O3Ue8yE1t6ROWZ3lNQFzWzzPTkrkNG5AAc3zmpiLUg85Qa2iSn6f1/HlqQOKSkuAy5ltiRuHMUD2Tx6/oVm+O7DVm5e6/KvZX3ivwsh0RySGgGcJm8pcQ9Vx27TI37kZe5s4Gv2i/QnktjcOsSWoZtHXwnpGNVRWAes7/7UCl1861+wQ+3OR4QmwFSE6aF4+ywCjEeb00A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfR7BezP17/re4Oxh7ni8OWl9Z7fakpTQqbOTdYH4pM=;
 b=TQAKUw53owYYvKxekq5ig1WBVAURsr4bkU/8+kcv+hi51Wm4nPIYWdcYxww0wzhkhzCSGUtgKBheTEsAMVpfUmUROEVGBto8bMmqZMt16ujrenj5qBGwqAHU5/kPI1BPcgBYS9FZ2QIhTp8lfeJT9wf8WXQNJQbpDJfJxg4IWVvVzAKuixrn54DXtOZwXYiLZPRjDAvj/cuJbVFRK7orrPiKcf8PTSKdxtcdKMJJrxBiMJrz/DsXoKJ8yQ52OfXV+PU9XgobnHzAk59mbnGYIJ6l63cNPEnk7/VFNTvrZNe89ibk/Zk5tqUWoRzzWBEoAQIpiWy2qoi7INqdSZDF6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Mon, 17 Aug
 2026 07:04:47 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 07:04:47 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 17 Aug 2026 16:04:20 +0900
Subject: [PATCH v7 06/10] rust: id_pool: take a NonZero capacity in
 with_capacity
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-chid-v7-6-a5872e64d8f4@nvidia.com>
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
In-Reply-To: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0095.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::14) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: bb7a768d-6c0d-4a0f-2fac-08defc2dd2b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|366016|10070799003|376014|921020|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZK8V101U4Km3M9NQ3dHDONxQTEsSAn3m9s/sa+c6CYgPtaTPyyEp94SjHddN3mcka5J7dMrJOUwjyCrQcUPetJqLcsWLlSkoEhj4xg80Sm63LMO9CdP/X+ebNe1dXdl3EgEGUO0exXZfs6+17PCL5+cAUk+dYtGF391Z4TD4TRJAxazvxAwTvUZHYKF18OUs8xI5lWjmZuNLb+Fd4cqZi6BqZnRSjCpw5OWQ2Qvj3z9vUgnBVpjb/j5+ISXBHH7+fzYWE9aHTV1hwvUh+P2JrKtld8lXOIKJm/+asM34GglQ0BY3PfmrKomWZlKqrOMchj26/sZQENNNFfAC9x/8SxqH33/rkaWMl6QQtXW40PZuYkFKp0Smi0ZGfRKSXAANebehfn7NQ4r3SUcbsHXpZKd+AP3KaYTjT/lDlAV1SwdnHJhIlnVdS3AIXjhGUzFxfCzTgTnV/UV9HkoW2tliPG9PvXL4ySftFT+t3sjGAxsUD4wHsx/PZytXp4qgbIwLByqqzCF6XJWO+DE2vQeHxb/KiXrv3QxqdYLc5rc0OS7DOOfyH7Y/veQsymQZz9B+c7h+xGQ63U33HqkMiYYSe7SvQG1xHNnDZ8O8su46dMF5V7WXh2e7k7+vX1liTWyA7IlzDLuWtn2K+88amZiWAd2iZjH7/yi7lMONzLNDCQwCVCpQ/eaHQGYpAQaPmT0WZAkejMSO8afEDb1vKoddCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(10070799003)(376014)(921020)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bStxak81amoxWW9QbXZWUnFEc2IzSllyQ0VmRmdQWkJRUWYvWWtYVWRFaW1w?=
 =?utf-8?B?Z3pRTW9hRWtaOWZ0WXd6NGRocEUzMzJIZ0J3L1JTczlvclFtcXNSVFA3ZXcr?=
 =?utf-8?B?eUN0akpsSm01ZHA0VHRRT084NGdvWEdiVGhwazRtUTdaalZKZzlBVzlFSXBO?=
 =?utf-8?B?U21yYkhwMXNmcDBYM1IyQ2hOTlJPQldwWEVYbVFybVVuT3l0Tm1rNnJ4bXJB?=
 =?utf-8?B?ZTNnbUY4N3Fpc2FzOVV1V1MzMFRON0NMb2xvb3hYKytIL09FZFluaDROaEJh?=
 =?utf-8?B?SEQ1ZmdrUWNvMTdHMGlpRFNndjlLTVdkMGNDNHpZWjdqek1zOEU3ZWt4V3Jq?=
 =?utf-8?B?c0JveW84Sm9yU1BmdFdRQm5ETnh6R1MvbTl4RytpNGl5QlYwWWQ1cVlmNndB?=
 =?utf-8?B?ZnJkNTBDQ1h6OEZiZVRkSnBQZllsUXN1VnluNXJSNThnbDU1ZEVNMDlJTWFt?=
 =?utf-8?B?cnZYa2lLQ09QaDRiUVF6UGpsOWdZTy85ZUhmMmd6WEpHTUIvaFVpMnBLYXla?=
 =?utf-8?B?eG5Fb1Npd1preXgwN21PeUl6dnhDangxVDBqNndEa2hXWDIxUDY2Kzg5aTBX?=
 =?utf-8?B?dnJMcmltZ1FGVHczS0xtdjdJQVhUZWJEOWdWRElhSktmbE1pOTRFOVJFL0lW?=
 =?utf-8?B?L2FiME9VVVdYQldaNmRmTkRqUmVLNnZIZk1GVjhuS3NGT3ovNFFWSWo4RDFZ?=
 =?utf-8?B?ZDNCTDk3MWcvRm45NCtQcEFMZFhscWowOEpMdlptUXRjTWtoeURVK1VJSWtC?=
 =?utf-8?B?azlvRWZZdExGSzhINlRQbWtUWUthOTZxalp5aUxGTnBZcXRTb2FTZXliVzVk?=
 =?utf-8?B?ZEFvNkVNVFBUZnRNbE5BSFplYTczeHptVUI3bkJEdFJUR3lKL0FGYU9QR0tF?=
 =?utf-8?B?dFFnaTllQm54c01OQUdoUHdHL1NFelYvMVd1aUZqREcxRWkxRGZ2am4xczZ6?=
 =?utf-8?B?bVBmSW1GR2RSUjNNakdvQzRFZzJFSnVwZUZueFFVMkNvdVgya0lVRGRsdnpm?=
 =?utf-8?B?Sy9LbWJQMGk2Q3dYUFhnUXRDQ2kxSlNWT2tEQXNNREcydHpSMzBTcytKV2Yx?=
 =?utf-8?B?TDcxVi9HZTE2K3UvNDh4QjFXZVFBRm1nVUc4Z05BVG9yNVl4dUJhNC9wNkYw?=
 =?utf-8?B?TkNkSi9SQ1JPdTZOTEJhY1ZzbldvcmgzSHI2SDMwNWk4NlV3SThOYktGV0Rq?=
 =?utf-8?B?Ymo3K1FNWGJUUzkvdTR4bThTN3B2eWRmQ2crM1poVVRXdy9YOVlWNlRlanVy?=
 =?utf-8?B?NXp0R1duc1NPTGozTXh1eERiOHdjTjArRGkzN2p4dHNrbmZLUEl0UThES2NE?=
 =?utf-8?B?Y3ZVdXhaOHRTU0M2dzJEVjAwUUhWNkJSRmZSMGE2WDIwYnN6WnlWbThMMU9R?=
 =?utf-8?B?NjcrOUtSYjFIYmU2N25PUWx1azdFOW96RXhuOEptSklQdGZZWTY4aDg2TUFG?=
 =?utf-8?B?MVRLOW5RVHhxZDhoZmhuWjU3ZzNSMkUwb1BJaTA4K2dpMW4vU2RWNzNaMjd3?=
 =?utf-8?B?WDA2V3RKTW1DaHovWVdKRFJYblVYVmUvbHp6TUJnRGNoVm1rbVRUZFlTWlFo?=
 =?utf-8?B?ZUxFTG1ZLzgzdFJSZ3hZUWp6RURTWWE2Z2RJSmdLWXJ6bDFWa0h6R3RabEJ2?=
 =?utf-8?B?cmp0MCtqbXRZSVFuK0hua0FJU2xVUHBMRjdwTzdZV1NocUdlcUgwMGgxV3hO?=
 =?utf-8?B?OUFsTzM4Uy9UcnloWVFsQmxBYjJaSlNUdis2N3Rvd1pWdVphOS9mRzNHcGtI?=
 =?utf-8?B?WnNiRmg4K3hSQit5VWR1QncrZXdHbDZxNnFDTkF5ME5aa0tlbGxhcXhhRUVG?=
 =?utf-8?B?YUNGN29tVWhqMjZvOVBZVzlvaytLbklEdUVsUkQ5OW1QRTlNWThKMmc1bzQ4?=
 =?utf-8?B?ZERMaWN6Vy9WOVRwRTJVNkdYbU9ZTXhFb2dVbHFMUzUvekNIQjR1Qy9hbjBN?=
 =?utf-8?B?MEFyM1JNU0tZODFsUkdPQ0JxRVRMNHJoekxrVEpybG9OUTNqMmVTZnBiNGxY?=
 =?utf-8?B?cHVWeVNaaitjcGMvc0FtN20wMm9mT00xNXFPb2l5ZzlaL1N6U0JjQ2M3SGhp?=
 =?utf-8?B?Wk93eTExRWtLVERwRGhpMW40dU1sRTFETms0SThxdTEvaVBrZUcwK2pjZXBv?=
 =?utf-8?B?WUxoOGZhejM0czdBa0Q0Y1F4REFGdTBYOFMyVjJwcHNaV3lEb0tUZHVKY1dI?=
 =?utf-8?B?NDZuc2czWXNDcmU4UHJvZXEzVmxNSmlwWFNpWklHL1ZwOGFMbGIza0grZ3JT?=
 =?utf-8?B?cktqclVmM3pUdnMxVUpJZW11ckY0dUhUa3o5YlZ6TkdtWStXelQ5TWRrME5t?=
 =?utf-8?B?c1I0cnpvWTR0Uk1yTzFJdmtpTnFyUkR1V0FVK25pR0g3SGdRVnA5bTNqblov?=
 =?utf-8?Q?26f+sXfe/l67fsI7d2HAsPfkvQsYchL0d0AkdFdIzZrtj?=
X-MS-Exchange-AntiSpam-MessageData-1: 6/xTXrWnW6vyFw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7a768d-6c0d-4a0f-2fac-08defc2dd2b2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 07:04:47.3000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /6BcTrjevtFgv3BWgBeLZTRWSJ+qya+xsPEOtiROnjBZO6KZS9XHmp8iwmPN5/7FKj/47SYbHYvMrEiwWtWmbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732
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
 rust/kernel/id_pool.rs | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
index 384753fe0e44..9494fde701ee 100644
--- a/rust/kernel/id_pool.rs
+++ b/rust/kernel/id_pool.rs
@@ -23,10 +23,13 @@
 /// Basic usage
 ///
 /// ```
-/// use kernel::alloc::AllocError;
-/// use kernel::id_pool::{IdPool, UnusedId};
+/// use kernel::{
+///     alloc::AllocError,
+///     id_pool::{IdPool, UnusedId},
+///     nz, //
+/// };
 ///
-/// let mut pool = IdPool::with_capacity(64, GFP_KERNEL)?;
+/// let mut pool = IdPool::with_capacity(nz!(64), GFP_KERNEL)?;
 /// for i in 0..64 {
 ///     assert_eq!(i, pool.find_unused_id(i).ok_or(ENOSPC)?.acquire());
 /// }
@@ -111,8 +114,8 @@ pub fn new() -> Self {
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
@@ -139,9 +142,10 @@ pub fn capacity(&self) -> usize {
     ///         IdPool,
     ///         ReallocRequest,
     ///     },
+    ///     nz, //
     /// };
     ///
-    /// let mut pool = IdPool::with_capacity(1024, GFP_KERNEL)?;
+    /// let mut pool = IdPool::with_capacity(nz!(1024), GFP_KERNEL)?;
     /// let alloc_request = pool.shrink_request().ok_or(AllocError)?;
     /// let resizer = alloc_request.realloc(GFP_KERNEL)?;
     /// pool.shrink(resizer);

-- 
2.55.0

