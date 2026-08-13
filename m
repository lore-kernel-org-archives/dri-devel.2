Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4359EC5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5532F10F1C2;
	Thu, 13 Aug 2026 07:34:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="GrOiMcyA";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011016.outbound.protection.outlook.com [40.107.208.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D421210F1C0
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:34:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFA7u7dqLR5VhNJaSoZ1nmSzh8fExaW03HeH0QsynKcceXXKAtOClLgkvqPitMFTXKELSl5yiIj1lMFAtUNfCG7NyWLFz09asUV8lchnZ1LUw/ZpnwcV12jYLmwEFl05JYY6e/vz3Z+93vUsLkMbOFI365Zzay/IPKE/LJSt2P3l+VFaWWwAa+ru2fYwtx4IwbU/pr93a3+mLmcRgnoYiwYXD76zezutXaKzi2lDKZOIjTm5ft8bv9wUlxdv0QkCb/DQLu1Eh0z4PxBa0ga8LS/usJNgXi3RP7ylWHjytepbCT7iI2UCmcKdzzXN6cVZIcEf3+6DdDBTDz2aspIhlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/hbGluvA6FIbbZhR3ITHLLK4f2I/yjNyv3zyhb11S4=;
 b=jADpDDt3gjuounmvvquaHpJsb+ljrgLOQ1LyYsZlkPin9p+BoDfbVZKx+QaHcLMQzYTZx5g8SSLloLGzfJGrrU1QMIkZMjM7wZ7U4Kuh0a1rLEyQo9ZQ71CGRjjSgaR032zYXf7whwvRK+fV7rUZJJ2MU2nQsWBgY3zEVNX1eCSr79tn7dWK9+6Le1rfRPyjGIZE40kwlY96I5pM4UbfDvsKs1knDESpC9KMZdmz7Ycg5Vxm5KOPsICTHSxtgKNYp72RxwYj8LRBtKJ6z8FL1qpiI/7ZC+ApOfrwJDTzGC2jFrdaeVGlWBxRZZghS+C8jULNYlazC+xapEFhmIecCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/hbGluvA6FIbbZhR3ITHLLK4f2I/yjNyv3zyhb11S4=;
 b=GrOiMcyAJD6w0TMLS0hDIOW8xEi1ONQ/S/o+oAz782HAToBQOhMYuUlyE8Q3gJWdEJeShItXzjyBuDJHB3Dz0NVgWl8cZZ2dS6iswgdjURZUdYKV9s1mQ77RaFCKfyka31nsCcBgGwYv0H9Zzn3lpkDp+DHsQ7QBlFDkErRY6Jc71JP5J/+1v/fLVjB5eml0bpMghs20GJwSz2RrDmDmMHcpsEG3p6ZzCCE7VSW1aDfsn3HXF8d4Q6DK1XOTc8uEUxmADxXhchQ6M0O3JEdkde3tyxGIZSZkvOVORGEryRnDVHGagblW3AWJkZFQcXxjl8j1bmYet4ldO7QGFs+Xaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SAVPR12MB999144.namprd12.prod.outlook.com (2603:10b6:806:4e6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 07:34:44 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 07:34:44 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 13 Aug 2026 16:34:26 +0900
Subject: [PATCH v6 2/7] rust: bitmap: restrict bitmap length to at most
 i32::MAX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-chid-v6-2-160be5dfb5bd@nvidia.com>
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
 Eliot Courtney <ecourtney@nvidia.com>, Yury Norov <ynorov@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP301CA0021.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::18) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SAVPR12MB999144:EE_
X-MS-Office365-Filtering-Correlation-Id: 7821bc75-65c1-4ab9-5b7a-08def90d581f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|10070799003|366016|1800799024|921020|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: AcEr8G4bbIoHqAdzOybUJzNwFIl74woDiDarU2L874d70D47yKeRt94x+gKmhyqnXkLeCsJabH8eP+CnjTW94A7HpEVuSM0tGUgXsQcHg9slW1CChfE7wlGUJF0lwFUBaJq2e++i0wkeiwLY/JU/EAxyt6VNMXmRQXfohnktGGwOqAP71UZvWqzsCfPzD31nj3GNeeTIzfZnPAUD71jRn6dA/fLn0h5ZLzdtbjNsntO1o3o5ovIeAdpDKSj9Q0cPZ/PP1PchLh0liH/l4InPYt/DDBfh/SzW2PiqZ//RxlZrW392zKFzjH7Z8+TjfyByTYepjvSQfcZ0Luil+5tMNVilE7jjGG++FNa+2w7OqwoY790oAyfhVWJDcfu+jTL2VqXvrbQPS2isxsfPKSi+DwoNJIYzmu6E8C3ZF+loidH3uVmZk0/WgbC9BQ/VRWpwQkc0rmS6xMHDNpvY+IbvdeGTbkeBZEG8b4/tZvZBVcDLwhyy7VaavXn8t6NgJCdVipefyJusj1FqeEf3HxbSf7QEwlvO2ctlgh0uhyxjrQPQXhzDLSdhY5Z7WWpIWBdYJ0A1hd5kDUsstjGFFGzfjT6lIPQKvB12vFoNszCXupjKmKNNqlEw7sbRz8VllfWfsWOsDLsiSKCKgyyV12pEidoZy1VhICT0QlShmf9U4HX+j4JPNvaeuU5d1n664v4cOESGrKY/jcoL0FOsehn8Dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(366016)(1800799024)(921020)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eW5GRCtzMzlBZXdOZXZEaFlPN0cwYjVvVk96blNZRjVGUXR5NWQrQkU0OU41?=
 =?utf-8?B?M1JrZTFQY0NyZmJkbGFPaDAyQUxmMVRwZVBQRHRhdXdCT1gvTDMrU0hGN1J3?=
 =?utf-8?B?T1FGLzh1c29SczcrR2xIRWhMcXR0SGhsdXN4T1BOWGdkcG92T3EzSTR1U3BN?=
 =?utf-8?B?OVlYWTRIcnJzMjVJTm9QSmpvTEo1bERxTlluY3JzVlZBTmkyYklLT0ZDY3Mx?=
 =?utf-8?B?aThUMXR0VlJDSFRBK0NldU9tSWdKeUVFazNZWTVFMFUxajVjOXlUVHJ2YjVl?=
 =?utf-8?B?bGlSMVZ5d0tqajVVaThCYWJwZC9lL2g4WG9UeDFNMkJ6QTdjeTJpWnh5bnI0?=
 =?utf-8?B?aHYydkhoSkZNUmhEczJ1SjRvSmJFZFZtTTJzQUY0dnhodjNicUxoRm5HYkJi?=
 =?utf-8?B?SHJQdUFPbUtITG04OWtKU2ExOUF0eTQ1YVd2eWVlNy9yWGdvU043aVdNMmFU?=
 =?utf-8?B?Z01rR1p0MnVxbjVWVWQzcmJQb2FjckY0VnFJSGJISUJhQXJpeDlHNzF2eVVO?=
 =?utf-8?B?aFk4Z2lLVDV6MDdrU2VHT3BFMGVVVys3QmE0NDVsWVdwNi9OT2toRHVJc0hn?=
 =?utf-8?B?ZE1landWdEc2L0RqTWdnNEl4aW1oOVJ2ODlzU2UwbEgwVSsyc0tFOFRqYWpp?=
 =?utf-8?B?K3JqbnRXcDV1eXozdzdleVBPdS9lZHJnYlBScC9CUVdWWllibU1DdUVoV0Fi?=
 =?utf-8?B?dmVSNnQ0QnE5M09SVUM2SWFXemdXV3hrUUVneWxqeEZLNVZnR3lqVU5ETEN1?=
 =?utf-8?B?TWxDNkJxVlRwbDY3eElUZy9TT0tkamtxUUV3YVpJK2VjRW1QOS82SDhxSWlI?=
 =?utf-8?B?QUNhOUNTRXF5MDZSSms4b0Y0dlJSVjVQRGxLVVM5TmhJZGVuenBVV3ZvanZH?=
 =?utf-8?B?ajVMZUx6LzREZUlpaWtydXREUEVKVFU5THZ5OWVWR211RjB4RGY4Y1FhYU5w?=
 =?utf-8?B?OTZETUdKQkVUUWV4RUhsYU5IajB6b0tyZ0lqT2U1czJqOTFtbjhpNm9qNXd0?=
 =?utf-8?B?S0twN0FiMXlSbHVUZ1dnSUhab1J1T0VxL0RIT2JBQ3JBM0Q0cTZkanhsQk5L?=
 =?utf-8?B?V0F3TUVzdFhWZ1NnRG5jN2YzeG82UmlDeFFaaC9qaEhPOGFsemVIa1Q5UEFD?=
 =?utf-8?B?OEpaSUVPMnZMNi9CZUg0dG1NNjNqd1JJTnk4dm5XWUNVTkIxRFdwcGg4aFpT?=
 =?utf-8?B?VmhCeUp2SldTSmI4S1dNUUNaSmpRYnNzaEdqeWxpQVlMcEcweUV3OGhFcTJX?=
 =?utf-8?B?c2UzUFBkdDJMa3dnbE0ycmdlcytrSmUrd1BWYURkdkVyakRhbDZLKzZqbFVn?=
 =?utf-8?B?Ym5zTzF5eFdpUy9wQ1p3b0tlT0xvaWszSWZCdmQvTDdCNWhsbGszdEgxU1hz?=
 =?utf-8?B?dzJJQWRkYWhhTWdlWEdwNWlBMWdRQ3RhMXBFY2tLSUhJUWpvRStwb1FiL09u?=
 =?utf-8?B?THhIK1BTSHlmSWhmcWUrUzk1cWlvSVBKK1lUc1QwZG5HZ1FDTFRQSHZOZE1n?=
 =?utf-8?B?UFhaR1NybTZMVEQ1eVFFSlNIanpWZDRNaUdCR29xa3NHQmpaQkRPMkZ3Zkdk?=
 =?utf-8?B?Y01qbEc3Y1Ztd3g2WU5obTFndW81QzB5RnZuWjhYT1RaSGFBR0x2UGVGemlI?=
 =?utf-8?B?NHJLWCtvY1J3aE9vNnQwUEt1WXFCQzJmcW1Sa0V0NWhuU1M4ZC9IakpxUmdR?=
 =?utf-8?B?ZW90MXV3SHdaQ3lRQWxDRXM2MHlUWExMS0hXZVRCU2lHUWpBQkRuWHRhcjNG?=
 =?utf-8?B?UEI2alJsMC9QdVNpaWxKNCt0NXlSLzRyRWNYbjdCdWcxM05GWDhBRkxqNExF?=
 =?utf-8?B?dFRCTnY0cWExcE5JSXVOY1dadFo1M1JOVEVoTTdLYWJIUm9XNXhzdG5BSjZ1?=
 =?utf-8?B?bmsxRlpySW9zckZGbkZrYTNWWVo5UGZpL1NMRVEwaFdUa3p0aldUZ2RJM3dr?=
 =?utf-8?B?dG90TVA1QnI0QmU1QWJ1UGNlR3JIeDd3c04yemdmY2FFMmlyWUo3eVFOL1Q3?=
 =?utf-8?B?b1FLZEpXcU14NVZ1MHR5TGJuK1JlMmRPd0FBTXgwZ2R6MUxTeWNQTWUrSkgr?=
 =?utf-8?B?R1M2K3RvVE1xcWxaeDFKTU92dm9CejdVK3RPK0hXRmpGN2xpQWdWUldLalZH?=
 =?utf-8?B?V2JwQ29OMlJ1R08yd1pTRVZSRVY1dGNhZDJWRXVUamVRbGRWLzlYczhCbUh3?=
 =?utf-8?B?aUJBc2psM3lWcTNQNnhDdVJWeWsybFM4M1hxU0tjL1RQNmJjQk52Z2huSlgx?=
 =?utf-8?B?U0tFTUhZMTR5RDRxVE1EUmNQYnFUYmp4NlB5andrTWhVUVlnaUd2S1FZTEVD?=
 =?utf-8?B?QlZuak9CQ2o2M0UwUm9xeGo3NzZHdVliTGRxSTFZSHZDSlVxVkZWdVQ0SlI2?=
 =?utf-8?Q?9wcj3minCbLn6tvBNMKr0vQJ0giWekoPHvCLl2ogFFlzl?=
X-MS-Exchange-AntiSpam-MessageData-1: aSU/RkCXJ0akzQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7821bc75-65c1-4ab9-5b7a-08def90d581f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 07:34:44.2463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrvgWKovrLPTG0r5ZkqK9AU3z+CEFGfFeTZVSa5i9bmN6O0gW2XzKwohxyT1xdy/h97t/awDytMFKoI9TQevPA==
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

