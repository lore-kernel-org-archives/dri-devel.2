Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CE8C5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E29C810E68B;
	Mon, 17 Aug 2026 07:04:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z4ZJeJfG";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012014.outbound.protection.outlook.com
 [40.93.195.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19B0610E68B
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:04:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFPObseoqZzj/4s9m7C/yjtKZsSIrcI6chubBBixRBIYCE7vSuc0NVzhJRNQUzXurVfDwL3cJZ3bOH8ONLha8OOzAWsQyeG8NLeUvaWWcnKJlEunV3bCqtUDVZKo/flPShwhsrVhAQHm4TwA2yHO0p94K9aDjhT8K2V5wGahlTiGcOr3EuffNLOu6fOPg25Eh/yiLtf62NSdP77FYSei4dASUtnk19ZJ7gufvDagWWaEBUOljm1ClDNeU5fFxnmQH9BrA6E8OawC5NRkpqmmFMQwx8ChjTc3pvYT94vc9iAzW7d1jQ67AnTMsX2ZiEEj2RuXJbYNqaZzum87Z64nVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/hbGluvA6FIbbZhR3ITHLLK4f2I/yjNyv3zyhb11S4=;
 b=otHcrNb9Tc/DqllQ6oHAaSg5dFSGloAF2cwahA1YtfKTkQNxXHY/4WsI+c1PM46LJEjdQ+FlCR4l99KdEGSVk40N3dxLYFZI0f1307w4WAoyqZjEqKABlCjaIFt1eqnAGLLk84BhOqb4RixbC68FEcs2JQ5huxiuzlY8bw9mXKcwSUrZsK3WVp3N6dt6UffiPSi4AILrPfkiMDqNQGm/V9podAp48IYiAA7s5kwUHwzDZON0/wrdS+StryoyOpYF9kSk+0jD8udPh5UyAy6kk1n61efvZAApnl3ByT01pBbupU2wsH4U1pXauHp2nwwtwjDjdWP1BGFy59/AZ5PzIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/hbGluvA6FIbbZhR3ITHLLK4f2I/yjNyv3zyhb11S4=;
 b=Z4ZJeJfGN7A7f7uDeH/CNThZ9FsswOY701xKKYR9RBPlf8fxYCskLzotE8oeU266q//S+3t8T6tUzKTY4sV6q6QPC7Y9lNXEjIba7gNXrC8UFFrwQYHPO8+9WpwIWRwdt7pcq417h6ypep5rqGGCSy93L6ojd37rD+zJKnfplP0muRQpa7mS9fw/n/jByPOMCMN+KSGW4KXTea+qva2wyoHQ5znlhNSr+ne0T2jdKZO3Hv9foVrvSXeHJVpUskNvMQRcs4sC53b/eX5SBahqg8SQ/4Lr//CI31TqX91J2uroCP9PUZKixJoUtIlRGEkqwk31ZrBBiQFJElw+EDzQPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Mon, 17 Aug
 2026 07:04:29 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 07:04:29 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 17 Aug 2026 16:04:16 +0900
Subject: [PATCH v7 02/10] rust: bitmap: restrict bitmap length to at most
 i32::MAX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-chid-v7-2-a5872e64d8f4@nvidia.com>
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
 Eliot Courtney <ecourtney@nvidia.com>, Yury Norov <ynorov@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P286CA0077.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::6) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ddcd23-409f-45a6-6567-08defc2dc811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|366016|10070799003|376014|921020|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iZRi52uE1OzppmsU48kjTVrLMTE2S4ynpPHYhCjJj0D2inbb/EPVwkYTYijwz/ICrpHdtl0tpZbwrvt2Tpyf8nyUP30rmCvfiGJRJHu5PS/s5vB8DEFjpQAC5qcwSLSsLKboa04WAMLJjitIAMvbGpflRaZiGNoABSG8Vzc9YNKDgRTaRRmpDj7WwFrrR+cPAUZXm02it2rV8FKjCzF0BD43/f1UPjSieak4bIWetYf/+zm0Ho271DzQ8i7qhXAiTW6/JurHtip1IAN/CmZeoDgDC2oIE4VQa4ySrU6sMAbaKV1/z0LG3g8Y/9dlC+5QwxFLQ5gWq3FU3AKvrYQj0PpKdjgvsUYl20G5LgsEpn1GRpG3mdjNbiNsArULKmd9LyQsUKLzZr2Z0HEQQiRQd6RC4njsEacGggfa8oXpZijzDuax+kVzBS2aOcvap2Pd83iLjRbtMw6Xdx9AWQ7XS5yOP+v/vGEWaR8pVQP7BSJlQIxuKVZiSf/vPPOX0x1i6dytVaAtpWTXX2VdrnvR1PEts74HIozuXJLGSVRmP6LKNCTyrEppX9v7V0+65FN+AlhvCFGZh+vfZ0Y79Ws6x2LirGwdG4LXzu604DWid5ugN38HzwckKYCIGROKWP/1U9XjXqetSeVIAYYRECb/4RNv2dtOPEvH97SVihc8kfzzQvV+6v/p4A2k2RjQWJC6/UwIdkOGbRpUpFsm8AJ5Rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(10070799003)(376014)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0tqUzNkR1RBYXppd24xM2hhak1SZVZXNjhtK1lqQ0xSaEVlSE84Z0J0cFkz?=
 =?utf-8?B?cXFXRmc0TytiV2hVVmhURkhxbjhwWlJZNjhnQXdvaHBDLytKeXRyc09FOUZB?=
 =?utf-8?B?WjZONlF0M29pM2ExMU4zWXhNZENNZFFmZmcyWEdpN0xMb1RhSHJGTUxqdXBN?=
 =?utf-8?B?TFVTLzdJcVlXcWlJbzNiTGhoaDkyT1c1NjFjODQ3Y3BOTitFengwTlhjbWIw?=
 =?utf-8?B?enlUKy9RZjZJaFBpS1FuWXZCMWVheUtnOFlMRzFMZmg2UVdYKzhXR3Uwdzdj?=
 =?utf-8?B?ckovdDRlTWNVVElPUWN4RUdVNXI5NzZxN0dNTys4R2FLWjZ3OTRVbDdJd0FQ?=
 =?utf-8?B?S2ZZTkN4bDA2YUdSYkFSK1lnSnhGbmdRZ3psa3hpdGNBN29xT2t3TkRpK0NG?=
 =?utf-8?B?ZzZnS2RNOG9Xc2ZaRFBqYnBjbmtoeVVOUzBJSm9HK0gybFllZVo1d1JZK1U4?=
 =?utf-8?B?Skd0eHAvbEdBLzIwOEUrY0xVdEx3TlJhN21XQmhsaWZMQmhVakZTWVk1eXRq?=
 =?utf-8?B?WFh3dmsyQkc2WjhEY3RBMXhRMW52YWJaWDdWOEhGWlhGQzQvZnJqWitmWTZs?=
 =?utf-8?B?cWZCZ1pCR2FsalcvdTh4R1QzellMeHZvOXFRZ1dwNzI1cVdGdlA2ZlhEcE1v?=
 =?utf-8?B?VWloeHNzSDh4Tkc4cFZRL2t6ZnhZV3I4UFdyRVpNZ3hoYTdsUFc2Q0tTSTZw?=
 =?utf-8?B?RU9aYVM2blJJOXRSd2txamIrOG1uV1pjUjd5U0lkQisvTjlFbVVaMWZvWS8v?=
 =?utf-8?B?bnNUbnpuZkg3b1hiMUxhNEU4Mjlsblh1WW92WVlNS1laM2g5OFk4SlIySDIv?=
 =?utf-8?B?eUNTVTNNeGQ3RCtmY2JPUExYVC84Uk9XWXB0UUZFK0d4RlNzbUpHelVqOW9R?=
 =?utf-8?B?eGwyaTQwZ2U2ak9FNVpTN09jTkJzRnBkNnk3Q2ZkS0V5amxESUJGaEdIdjJr?=
 =?utf-8?B?RnlUNVUzSzV0emphSitFRENyYTNBVE5iVUI1WUVWUHBrcTdWQ3poWTNBYmJp?=
 =?utf-8?B?SS9kaTNLdWwyVWpSWXhINHBHZHlMMEhaM0l6MzBESEZ4dGFnaHJ1b0JYZ2xr?=
 =?utf-8?B?bFkxak95MStPVllneGJNRSt4b0xwZU9oWlBkUDA2bWt2eVlTQmtleDRIUmZW?=
 =?utf-8?B?ZzltazNEK3l0ZGhXbXFDNlNlcXFmTEEyTHRXL2JkU1ZEcHkwNmo3TVNSbkR4?=
 =?utf-8?B?OUVWUGtSaUgwbDB4ajFLdHlsZ0RMT0JvUTNZcHdSNkJUdXZBWS9pcHdzSmUw?=
 =?utf-8?B?aGlIY1ZEUTJ2bEJkZ1RnN0VlWTN5WFR5VzRHcEhiSENXc3IyUUNQQVpYeXVx?=
 =?utf-8?B?azVWQU9KTnNVWVE0MzdqM21sU3hsWnVJY0NoUzg0NDdodi9OQUcyVE4zQUpF?=
 =?utf-8?B?VThNUEFsczM4OW5WZEJtaC92dGs1cU5nV0h0WGRhUFVlcmw4MTJ5TzNlK0JS?=
 =?utf-8?B?cmZhLzlFbHgwMFk1THVNbEcvVVdpN053UFhEYUI1NmliSDUrUVljSktmNzlH?=
 =?utf-8?B?QnBvSWY3T0NRNml4SkJHR0FFekMwV3ZMbXM4SDc1UmV5YS9mTmNxbmRRZzBC?=
 =?utf-8?B?dkRsTXl6ZzgvbkR2cTAxYTA3ZzBtNStIWDI0T3MvREtpcE1Eb0s2cmx3dHdV?=
 =?utf-8?B?RHlpYlB6UThSaUZHd1RpNDIyZVdDNGJicFg5V0Z5R25kcGtETDF0ZjNnbmxt?=
 =?utf-8?B?aFZhZWU0amdIWFErcHVlL2R6b3dtdEZVdXAxQzQzZXlyc205WDV1R2pIR0p4?=
 =?utf-8?B?dThGUVBkZzhnTUNUVGRlcnNZTTNhci8rODlhRi9ISW9UdXdvQ29vRUVVOEZw?=
 =?utf-8?B?bDBzNXlFMHZjYldaUUoxay9qOUNFdjBzYW1kd1hXL0VFSDVjT2hqVUNGTW5N?=
 =?utf-8?B?b1cwTXFaK1QxeXZmd1VzQldNL1VscE0wYWpmYUVuR1M3dkR0anNQOGJUNUVu?=
 =?utf-8?B?WmM2aGFsWmFCdzJScUpWcytkVEF0WWkvQ283aktjT2NUU1Buak5kMmh3c1pj?=
 =?utf-8?B?ZFQzMGw3V1k4M011VjNFYXZORDE3U1dPYzVMRk1tSlVyRkNHcUlGVUIyTjhM?=
 =?utf-8?B?bHQwRzVVY24xSkRqL2k2S2pxQjNNNmxUa2Ewdkk5a253SHl3bE5jVlNGb2lZ?=
 =?utf-8?B?dlU0QmJiQ25iU0ZNTkZUeFFQUDZHcjd0RVh4ZGs5bW9XSGwrQTluSU9GR0JG?=
 =?utf-8?B?Z0xIeWIvUnF0ejhHVHNKQ25WSThiQmVrVWY1NWg3b0hhbEgxbXlnMTlCQUM1?=
 =?utf-8?B?Wkx0T2ZEakRqRWtoT2p1K3RhTXczeG41Wmd5S2RPVUhIcFFWMjRmbllzRi9Z?=
 =?utf-8?B?UFVYS1dsR3JKSHhSNE1UekpjT0xNenVhWDR0bTd4b1NUc2pqMFZwNDg4Sm5V?=
 =?utf-8?Q?Yr/r2j3RmEVHW65PNT70Amh2qMmO0OVmwlX5kdJ9I7cQ9?=
X-MS-Exchange-AntiSpam-MessageData-1: o496V0oMOwWCnw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ddcd23-409f-45a6-6567-08defc2dc811
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 07:04:29.4624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcKDufNJQ15nTR0JHd0La731vbh6eHaE+Byj/0IhYqvFueTqRTdZRsTLYrA9Y24dgSuH7Si3GB4rBfjjyXXBNA==
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

It is currently possible to construct a non-`BitmapVec` backed
`Bitmap` using `Bitmap::from_raw` that is larger than `i32::MAX`, and
it is not part of the unsafe requirements. Restricting all bitmaps
(even non-`BitmapVec` backed ones) to a maximum size of `i32::MAX`
simplifies a few things and matches `BitmapVec::MAX_LEN`.

Add that requirement to the unsafe requirements on `Bitmap::from_raw`
and `Bitmap::from_raw_mut`, and to the invariants on `Bitmap`.

This also fixes u32 casts truncating in `copy_and_extend`, which could
otherwise lead to OOB writes.

Fixes: 11eca92a2cae ("rust: add bitmap API.")
Link: https://lore.kernel.org/DKG0U8RLO7LZ.2I1AIH0S38PAP@nvidia.com
Reviewed-by: Yury Norov <ynorov@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/bitmap.rs | 68 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 21 deletions(-)

diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index a43bfe0ec3dc..fdcfc0409773 100644
--- a/rust/kernel/bitmap.rs
+++ b/rust/kernel/bitmap.rs
@@ -17,24 +17,57 @@
 /// # Invariants
 ///
 /// Must reference a `[c_ulong]` long enough to fit `data.len()` bits.
+/// Must not be longer than `i32::MAX` bits.
 #[cfg_attr(CONFIG_64BIT, repr(align(8)))]
 #[cfg_attr(not(CONFIG_64BIT), repr(align(4)))]
 pub struct Bitmap {
     data: [()],
 }
 
+macro_rules! bitmap_assert {
+    ($cond:expr, $($arg:tt)+) => {
+        #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
+        assert!($cond, $($arg)*);
+    }
+}
+
+macro_rules! bitmap_assert_return {
+    ($cond:expr, $($arg:tt)+) => {
+        #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
+        assert!($cond, $($arg)*);
+
+        #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
+        if !($cond) {
+            pr_err!($($arg)*);
+            return
+        }
+    }
+}
+
 impl Bitmap {
     /// Borrows a C bitmap.
     ///
+    /// # Panics
+    ///
+    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `nbits` exceeds `i32::MAX`.
+    ///
     /// # Safety
     ///
     /// * `ptr` holds a non-null address of an initialized array of `unsigned long`
     ///   that is large enough to hold `nbits` bits.
+    /// * `nbits` must not exceed `i32::MAX`.
     /// * the array must not be freed for the lifetime of this [`Bitmap`]
     /// * concurrent access only happens through atomic operations
     pub unsafe fn from_raw<'a>(ptr: *const usize, nbits: usize) -> &'a Bitmap {
+        bitmap_assert!(
+            nbits <= i32::MAX as usize,
+            "`nbits` must be <= {}, was {}",
+            i32::MAX,
+            nbits
+        );
         let data: *const [()] = core::ptr::slice_from_raw_parts(ptr.cast(), nbits);
         // INVARIANT: `data` references an initialized array that can hold `nbits` bits.
+        // INVARIANT: the caller guarantees that `nbits` does not exceed `i32::MAX`.
         // SAFETY:
         // The caller guarantees that `data` (derived from `ptr` and `nbits`)
         // points to a valid, initialized, and appropriately sized memory region
@@ -51,15 +84,27 @@ pub unsafe fn from_raw<'a>(ptr: *const usize, nbits: usize) -> &'a Bitmap {
 
     /// Borrows a C bitmap exclusively.
     ///
+    /// # Panics
+    ///
+    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `nbits` exceeds `i32::MAX`.
+    ///
     /// # Safety
     ///
     /// * `ptr` holds a non-null address of an initialized array of `unsigned long`
     ///   that is large enough to hold `nbits` bits.
+    /// * `nbits` must not exceed `i32::MAX`.
     /// * the array must not be freed for the lifetime of this [`Bitmap`]
     /// * no concurrent access may happen.
     pub unsafe fn from_raw_mut<'a>(ptr: *mut usize, nbits: usize) -> &'a mut Bitmap {
+        bitmap_assert!(
+            nbits <= i32::MAX as usize,
+            "`nbits` must be <= {}, was {}",
+            i32::MAX,
+            nbits
+        );
         let data: *mut [()] = core::ptr::slice_from_raw_parts_mut(ptr.cast(), nbits);
         // INVARIANT: `data` references an initialized array that can hold `nbits` bits.
+        // INVARIANT: the caller guarantees that `nbits` does not exceed `i32::MAX`.
         // SAFETY:
         // The caller guarantees that `data` (derived from `ptr` and `nbits`)
         // points to a valid, initialized, and appropriately sized memory region
@@ -96,26 +141,6 @@ union BitmapRepr {
     ptr: NonNull<usize>,
 }
 
-macro_rules! bitmap_assert {
-    ($cond:expr, $($arg:tt)+) => {
-        #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
-        assert!($cond, $($arg)*);
-    }
-}
-
-macro_rules! bitmap_assert_return {
-    ($cond:expr, $($arg:tt)+) => {
-        #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
-        assert!($cond, $($arg)*);
-
-        #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
-        if !($cond) {
-            pr_err!($($arg)*);
-            return
-        }
-    }
-}
-
 /// Represents an owned bitmap.
 ///
 /// Wraps underlying C bitmap API. See [`Bitmap`] for available
@@ -415,7 +440,8 @@ pub fn clear_bit_atomic(&self, index: usize) {
     #[inline]
     pub fn copy_and_extend(&mut self, src: &Bitmap) {
         let len = core::cmp::min(src.len(), self.len());
-        // SAFETY: access to `self` and `src` is within bounds.
+        // SAFETY: access to `self` and `src` is within bounds. Both lengths fit in `u32`
+        // because a `Bitmap` is at most `i32::MAX` bits, so the casts are lossless.
         unsafe {
             bindings::bitmap_copy_and_extend(
                 self.as_mut_ptr(),

-- 
2.55.0

