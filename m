Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D299AC531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 09:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FC9A10E54F;
	Thu, 23 Jul 2026 09:01:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="AGIreq46";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11A4210E54F
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 09:01:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6DRtXzAb8W6F7OWKxRjH/6klyu5xZjjsWQ3nHZVzDLVL4T8svgkR5nqvl90Fy+hqV4dxu3gP/IA2DmU2mnYDlIVSgQ5L0F/3tWsqQLA980NI4XfRtbmuTunMBI2/jLoT/o9WqPc7hChNPCkaQSmdlW8VpUjmdwG6GS7KcdoMp5EOdM/92szrHzcmzcxD86vjZJz4dXcv2dlyqrkRpmZULsL4pw8k9yDjvSgX2c3LD5uKgOm8hGnig7nz4wyFvGQApEsslzDa7zBfNit7oUblqHsU+crru9vjkYCwU92NJUhZFvPscjllqTnTaTiwX4qV0fIcJQumjC1tbZFsuunbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7u7dvAPBl2WuKO3iwzYyxwsdySo7yOHzfxH3cCQuXO4=;
 b=EuJnuLM26rKTeuCB/bCuHGJw1bPiTFLbRu/6k7J3vZKVO2e6HozEGIN+2dmIuqUhTv/PjXjF1r9dj28SrtEfm+264+oB9JHdCEmhLeLAOH7Y4+6ksuwbQPEb/AdtA4Xf2PNx4Xto8DUm9qE0MTkoL1920pXUHZ1kZJF6DijdOuBqS/8QgvcuqV0Sbkwj1YfzXszedP5JNaHbnHJ5Zl2a4Aws95fT58FfZj1Kw+ZTuKxQIekM8jxfaj6ZV5yj1SqtVwRJQuZVYzTLTi3WeEkbrqz9PjeV2uBVTiGob6YE3Ceq5ENlKpOCop61N522IWd64EWAxUQu/hXig+ivqdA2VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7u7dvAPBl2WuKO3iwzYyxwsdySo7yOHzfxH3cCQuXO4=;
 b=AGIreq46DcJ8Lo9nI24lViwpA1whgTcPn93OgQKElcfg/1rSTmPkpWMj1F09FmWm7DKoH+HpRnbvBOiYn4B7QJe5tOG8Za4P7bjOpDgDULjFTFf4Bve9sv0NywjodtDLoG+LX9NXJDOWm43AsJni4qQemD/Wu13x/DamSAy6u5iNVK34Tmf5xaLc4RwMViNgLlBTfhTzLOBqOzOM7prj/t0RzkQ9uhApRsJtlFcSwQIpCerzQ0fqKrE854dPMXYUjDrSS9FW2iAPcO0mNqN+kbb392jAQYGELTvVBasQgOwnjjAyESeljuPHe6sSWn56pOCIxGYhaRWCtmSOHq0C7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Thu, 23 Jul
 2026 09:00:55 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 09:00:55 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 23 Jul 2026 17:59:10 +0900
Subject: [PATCH v2 1/4] rust: bitmap: use function-level cfg on kunit test
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-chid-v2-1-c35e5e9fb3d9@nvidia.com>
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
X-ClientProxiedBy: TY4PR01CA0035.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::17) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SA1PR12MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 13554aae-9ab6-4a5c-8ecc-08dee898e780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|10070799003|22082099003|18002099003|10067099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info: wVDDXDy+5v7qykner71RorDa+BQj8iwHodglCCCSZlMzXQMR1aG3gV07f+dduo0bOgrLBEZTldejMFKpiNCadWcbEGvnHZsVf1d+Su162SJwWjV7l9zh68KOWaYj3cvoQzBlcw0fSyLHUx2MvJAGn9HHSVanDt3GodNGpP7rvtH1BRrRd1a5JvoSuKD7X+1MDD1nqlz88OJE+cBwado2Cv3hYusqhLQAWTxPW/0cUM5w+bo4EhIeuwuAC9RScLob7zrq2ixzEbMGvNrdtu1pwun+s1v4smeyydJa085B2J/OMMJrik1/REFzZ1yjDgt75DGyU9gIBCMN8X6BQPZSweNHQQAFbKhq+0tYNogAZ03J82q7mBOG2vVPVQdaYjooiNxn1hQO72rD15wYxh4fi9zA6yD2G5JMbgfq7sM9T2gS6XM+dgvM8+nvAOCqxkHmp7Dhq0TDZq5AyHZa98vcBj34DmqwnJLPHQoya2TEH7LbXeY081bAfsio7PZ0bLH8MSn5oO3/ETGquqgOjV1/JG7OOA0iKV7IVG7wN6UqsPQoLMJKiivP1Pi9hmCnlDq+NG3iIhYD7KEq4KyCrjgK0QXTIRjfzDes4ySc1ztXHy0VkFdQu2da42l0wRV6R+LHJEl/kmPg+UfnB9GdTmjB6z4UEpNRtFwp5hqEuI4vKN6G5ObMRZBpR1lzgTSpGfB4eZcGFySBZq5Fg09F9gkkkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10070799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alBLdlNlZ2MwV2txbjBkaEc0Q3ppd3hEaWVlNE9vVytMUm53UnJ6SnV3TlJC?=
 =?utf-8?B?VFBibWRNN0xneXB2YXV4L2dLOTREM0FJcjNrYkVmT2hqeWZKcFY2QVFnL2to?=
 =?utf-8?B?QTZialRLcitGQUtpRUorTC9OUFptT2hqZE9XTi9ubmZwdCtPZmRMR3l4Q0Nz?=
 =?utf-8?B?NTJKOFpzaE5Vcjk1cExxL3RFZHN0ai9KSTI0U1Zuc2NHblcwZFExNTd3dFln?=
 =?utf-8?B?ZHVPWFErbmxtcWJ6N0FZYzVadE15MEludzZCelk4dEtKK2hOUUlDbkNTTjNx?=
 =?utf-8?B?WlZqaC9nczN4QnkySHhJS0FjemM0ZlFGcnNLRkFtQTV6MmozK2lWeG1mKzJW?=
 =?utf-8?B?eEV0aFBBdWdBd1haazdXNjBxZlUyRkFUMFkxQzJ2eXp2UG9wV3N3UGsvdWJy?=
 =?utf-8?B?MkY0c0M3Q1pUaUQ0b2lZVGlrU2NwaTlNNTVmeVZBZ2pWS1dSOVYxaHFCRGly?=
 =?utf-8?B?VlAzSjE3bUlXcFJ1cGpjQnZ1QVpLZ2xyUjVKS0hkQ3ZpMURNbG1wN1ljYllo?=
 =?utf-8?B?cDA0bE0yUkdUZzNvam1ONmNEQXJKTDVRUm5KT1E0ZXB3R1JoNWNkakNqSEEy?=
 =?utf-8?B?R2FzWFZkRXhFTktyR2ZSckk3V2tXVjM1ZVBydjMvQm9YOUx4UGZ0V1lzbG1Y?=
 =?utf-8?B?bVlaTktYaGZqUkJrN1hXQ04yVHpOWGxsZkZzUDllditNY1hTckltSHpmVzEv?=
 =?utf-8?B?SVFiZzZZNURQMUtkWEZwYmFtN0kyWGdJKzZVZE1ZSHpwNjVsQkR1NXlCN2Rv?=
 =?utf-8?B?QVBXaTBVWWNNNVVOTStyTDRNNzhKZGh5UUxMQVg3MDVYeUY3T1UyL3phMjJo?=
 =?utf-8?B?Z2pHSFhzMWg4ZnJXK0xoVTFDT0VvSm16Q2dkbkdSRFJxRTRJRzVhVVd3SnVv?=
 =?utf-8?B?QTd2MzBNODdaZCtDSHZ1N01jb2FlUU5Ga3F5TnExbWxSVFFUNGVUS1psSCtU?=
 =?utf-8?B?YU9IRjBRaWd2S2ZHVmw0UVllLzl4Y0xUTVl2Ty9Md092Ym9DNmtEYnJVSDlT?=
 =?utf-8?B?Qm0xeXFuT282bFZuMU9XRGwza0JZOGRJQ0tuRU1STmZLZ1NuSTJXWEg5bUZw?=
 =?utf-8?B?VlBqWWZYSjlxL3pMdzZCbU1zdElKU2JBZXhWb2NNUGR2bGczenFUOHM4R0N6?=
 =?utf-8?B?U2xQNnpJYSs5cmRramk5ZWk2OVNCZnZDdTA0VVpXaHVXUUkwdzh1L2VzOTJB?=
 =?utf-8?B?eEpRQXdVTDFwdUxDUDVuRnVGbUZuV1A3KzFmcjIzWkFjN2RzcXZMRktLZmZl?=
 =?utf-8?B?TDh1OUZOVm9GckNqYWFqZkdQY2kxcnA2dDkzWjhjVEovQk9FLzg3akNQamMr?=
 =?utf-8?B?QXdOeVhiSWFEQUgxdXFqYWFCaEpDamM1WEVZN0xtamxrdy9vMS9FQk16T05T?=
 =?utf-8?B?RC9TQkJ0b282dW5kRjI2bEwvQ0FBZXdlYXRxSklSZDNON01EZyttYmpaVzhW?=
 =?utf-8?B?dk1yUUE0bjNFcjdkRGRSTUlMMDdJZnR6UEczK2NlWHpDYWdsTGRoMTdQYVV5?=
 =?utf-8?B?MFNRY0dRS0tGU3puKzcwZkVrVm1aL3VaTEk1VUpybnMzN3VuYnhqMVo1dmhp?=
 =?utf-8?B?L0FQbXZ3U0NqekZWTmdlUE9JN2FhZkRGQXpZRmRnSzB6TE44aGFaZ3IyZEt1?=
 =?utf-8?B?RWlIMitJQjVGSk41MnM3OVdUSkpWWjNJWkFrTllhSW5wVC9uQ3JFMmlzL0ph?=
 =?utf-8?B?SUhkN2FzQjkvdTFvc2pWVTZIOTdPa0RZVmkwbkdDbW8wVE1PTlBCdExPQklM?=
 =?utf-8?B?UmJXY0cwS3BtTTNTVERXNEt0dmNDKzR4bk5iL3ZiVG5rYWVvVFo4aXJxUlpT?=
 =?utf-8?B?b2JnNDhMcnd0U0VQWDBSNUNraFQvRkZHNXc5U0UrN0dsYTVHMUZXdERHTVNw?=
 =?utf-8?B?TkNZVFRxeGpIa1dmRHA1WFFrZlRydzN0T3EyUGxiaStyUWpFVGN6K0tid25D?=
 =?utf-8?B?cHVhVWcrYm85N2xKa2UzTnB0Nk0vSk5OOEl0RlVSaC9OUmxUWTM2VSs1SS9M?=
 =?utf-8?B?R2JGcEhybUlvSTY1TG5menRPbC9UcU5BK05hSmVEMzRLTktFYkhEc2J5cmxr?=
 =?utf-8?B?b2RTditsSnNpcHdoOEltMUhLZ0tvMlhqZEd6dlRlNTVBam1TcGxKR1NVR1Ey?=
 =?utf-8?B?VnhCbGNVUStyM28wVEFOQ2NUWmZVNTI3dTJMenkweWlqeFRXSzZNMFpKbzc3?=
 =?utf-8?B?amd4K3NqRkxiQnFFVjR0Vkx4dWFyM3c0NDdFZ253SXVxOWNzU1IxNVJHSU5I?=
 =?utf-8?B?dnFFZ1VmcnYycE85UkpVUWdwZnd5NWIxNFJJYkhMcG9VRXBkWTJ5bHd6MDZz?=
 =?utf-8?B?Mk9PSGlNcGIwZnlvZnpnMnlDYTJ0bjFMR1RYajV4Q3p1TjlZcnhleU9WZlQw?=
 =?utf-8?Q?mpAC6dfUZmyRiaysvYiMeYcqEapd3vHywN71QXzahxUJ8?=
X-MS-Exchange-AntiSpam-MessageData-1: 5cGqcSgN2B6wkg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13554aae-9ab6-4a5c-8ecc-08dee898e780
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 09:00:55.0845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FkJHknj24ZQ61UwfwH80qFIF+K3LgR7gNrbJRIDejnDyuvVt+xuv3dpxqd1RBtwIZt5aa5nEfwOJ6GT6/BNTtQ==
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

Since commit c652dc44192d ("rust: kunit: allow `cfg` on `test`s"),
we no longer need this workaround.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/bitmap.rs | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index b27e0ec80d64..a43bfe0ec3dc 100644
--- a/rust/kernel/bitmap.rs
+++ b/rust/kernel/bitmap.rs
@@ -572,24 +572,21 @@ fn bitmap_set_clear_find() -> Result<(), AllocError> {
     }
 
     #[test]
+    #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
     fn owned_bitmap_out_of_bounds() -> Result<(), AllocError> {
-        // TODO: Kunit #[test]s do not support `cfg` yet,
-        // so we add it here in the body.
-        #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
-        {
-            let mut b = BitmapVec::new(128, GFP_KERNEL)?;
-            b.set_bit(2048);
-            b.set_bit_atomic(2048);
-            b.clear_bit(2048);
-            b.clear_bit_atomic(2048);
-            assert_eq!(None, b.next_bit(2048));
-            assert_eq!(None, b.next_zero_bit(2048));
-            assert_eq!(None, b.last_bit());
-        }
+        let mut b = BitmapVec::new(128, GFP_KERNEL)?;
+
+        b.set_bit(2048);
+        b.set_bit_atomic(2048);
+        b.clear_bit(2048);
+        b.clear_bit_atomic(2048);
+        assert_eq!(None, b.next_bit(2048));
+        assert_eq!(None, b.next_zero_bit(2048));
+        assert_eq!(None, b.last_bit());
         Ok(())
     }
 
-    // TODO: uncomment once kunit supports [should_panic] and `cfg`.
+    // TODO: uncomment once kunit supports `#[should_panic]`.
     // #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
     // #[test]
     // #[should_panic]

-- 
2.55.0

