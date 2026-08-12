Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF92C5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:51:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0FAD10EEEC;
	Wed, 12 Aug 2026 08:51:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="rccQ12r7";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013051.outbound.protection.outlook.com
 [40.93.196.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85E4110EEEC
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 08:51:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tf+rbSM/fJkmlL0QIlEoBfna0OV8sCznmgsBUS5JznZrFjPEZvWMRTldDm2uiBRo4QfB0rQqSzz1kMEHsgmL6NljZWQsQAWhxAaicDT9LYqRJkJw7HXcBkA24Cxm6m4As5mhHOmTZeqmTAk9bZQ5NWhtYTK32KMMXebgIHqMJp9fVrvmQrtI0VGZSrmR2NKda/JSvKqA/R/C7HU2e+D+EnGRW1gzf8Sp+XHmwGnZd6DG5qmXGUcAajxgbOubEUT5GhnJmgNI08Lz0sMg63TfCzkFJ0Vl/IkdiuAb4tzVYrNxIsos9SPDJWU+ifCqrVELOu8U9QgSaHy9dLakwVO9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7u7dvAPBl2WuKO3iwzYyxwsdySo7yOHzfxH3cCQuXO4=;
 b=irudkK7sfNPXU8LMgA9bCXGwBvZZmsU64JygMEvwuPFcVnexllaJ6i6zu++JQTC9e6zNayNxXkXC71THRlyh72pfinNscUTzETN3hyFLJluPhzRkCihMO2U1nrsN1QwHxXSswfPAUaUlibcYFYSfBf47V1QxR7AdedMlc9alTdUZ2zJ9/AuDRqmrBr6WV9XYXz8tEz17BaE5sKGZ7nlgOUJlg4pL/JBLhzYZfHZ1Xz8Q4TjWOtUH14KZqucAUQ01FcFranNUtBO15S/VmDdzbbYwMk4jETcYpAiKdwfdzpbng09cLKv9rCchVlo05rgd++W8KnsDRw5vBoZvEDAlhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7u7dvAPBl2WuKO3iwzYyxwsdySo7yOHzfxH3cCQuXO4=;
 b=rccQ12r7Br+Zb+oP3MD/X5Jdktov7RHz4sGoAmdjViBBMh3FRE+lEsM16uIaoBXrNRaSjteQVSwJjuoi0FJxcQxX9FGR4MMjekUAG3d4HzZrTmMDfwXbnePGjF4aEX3AyCAHjOAOxtLDyz3ygyG85iy7ccRV2KBdDHFTWNr4E3UBIbmgckiH1bJA0KVOeCCPntodPN5Vov3gTrWN2euRtp826xFXu2JWGwUIxj7qHHsonoil+r2E8ZWWxOMfi0d2J88leswmbcoWGulN/eSPLGigs96l2PjkrOkl4VvRFcac0ah7E47KK22pGbd2Ff8mnAcSNNUgEmRoE2fs+MQVhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 08:51:45 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 08:51:45 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 12 Aug 2026 17:51:21 +0900
Subject: [PATCH v5 1/5] rust: bitmap: use function-level cfg on kunit test
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-chid-v5-1-6c767770b3f4@nvidia.com>
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
In-Reply-To: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
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
X-ClientProxiedBy: TYWP286CA0001.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::12) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a1bd7fe-487f-4fc9-f5a3-08def84eefdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|7416014|376014|366016|1800799024|921020|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zzA4kK88kdjPOBOpkfHzi1UBbekQayW0+0GurPYWK9JoUkSspr02pJC7WR2CMEURXWD2nXAYMX0VCQf/DrPO3FPFQcx/Al56oqY+Qu0DbgDOu2F0OvEM9j+Hwe+UI0d2cWy9LNVxvb94hX2tnYr70YTWu0NtwjfL0l3csvyGHAlSJaY/UnfWHJ8JJ4Ss7B4X6Rh5t0L4a3uJB45WcRbEoA/iYtoL42w/lnViciLL4h0goRYLrRT69duNY66HUSO3C2JXD7VLYgFn48oYbio/kpz+kvs7oFm4J+02vPPtM/u5mrBuzhrETGib1V18qcbCloFiv2gbuJqVW3KO682J/OMR7gFI/V3RneVDyQ/ZStxlYONPvwXwqwLGIBfVnDHMcC4H5iublTUw3a7uiLLt6CP0Jq8qlh0quAMzvxXAUxoumdn/icQxJ8xU4cUMSV8OClPGpS/1faU+GpbQVEfqMKozlj0lHeVnFeyAlJxaqyUbvpYgvWt01728Mz7HYRavFAk53O9g0asNlEjhJ74YXMskoj4YRaQ8e5CoEehAM5RO9yXPhnGkBLS/LMsZTqxxVwZTj/3Un+ftcPBpo8ugKxQ/IFBamh8UMJV11v8f6WVbOzbPWj+gTLA8+rmyANA6TbAS/afFXgP86id3k3xhwhfFRcUOeffZTAtmfavOqogmDze1XmczR6Muz4ki9SPJgnEGWfntXgB6QekgY7NoRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(7416014)(376014)(366016)(1800799024)(921020)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wld2dHZ0VXNZY1VjL0xtbzVpZGNTL3RYMlVyVkNEdzNwK1JIU1Z3UzBFVHNQ?=
 =?utf-8?B?OUVreTdCTmhDdjdiTWVqVnZSdkF1cjZsTXhzYTl5VmV4UXNKV0ZtY25ESFlV?=
 =?utf-8?B?RHJMck1BOEIrQUc3NzFSQktwWE1idkI0TzQ4U2t6MmczZFEzZlkyL1R4RytV?=
 =?utf-8?B?Z2RXVlNKcXdCRDVMSldsMmVVVFIxUmU5aEJxRTVJTkZlNnIwRzZUMFI1bTc2?=
 =?utf-8?B?NXFhUW1LTmR2WFFhSmpMQUQ1SnBCYjdRZDN5MS9VcEJSLzY1OUJrRHk4NE9J?=
 =?utf-8?B?aFpreXZvTy84U2VuRFJHTkdpelZ5MDQ3TU8wRTQ2d3VDb01IK0d2NWZRWnFu?=
 =?utf-8?B?aEVha1ljaFdvMm9wUEV6djA5N3NLRlZ2aS9nSnVjZ2VmZ3F1Ti9LNDQwTmgr?=
 =?utf-8?B?eWdzQjBaUXRiaCs0elFmZTAxOEtWVzJGWENGbjVRaHdGWnFDdTNBU3JCTkhI?=
 =?utf-8?B?Uk1NR1RZZ0RGOXUrM29ycnpFYjVhRlJ2TkFUVlg4SmdSb3VQSVpKRUE2SDRJ?=
 =?utf-8?B?SHp6bnlrWTdyQnMwZTJ0anhnalBsNU5hZHdFSU9TTUljcUdoYUJmMmhXd3ZV?=
 =?utf-8?B?a09Bd0Q2dys3aDNmZXlkWTR3UC9Oa1hoZGFqd05td0dkS0d2ZnBFdmlCUWhI?=
 =?utf-8?B?dHFEdEF5dWU5ZGczTWZITWtYeDYwd1dPRllUUXNoZmVySEc3dFpUbE5jNTZ5?=
 =?utf-8?B?TFFsRytSNHJjUmxJdlY2YmJuYXhqYWM5d1dxQW5WU2NEMmtGTjc2WStvUTFG?=
 =?utf-8?B?R1BNMmloMTdLRXY0eWR4Q2VTU3RDOTFyWlIrcUVwU21JejVzQ0pJTkxjWC9R?=
 =?utf-8?B?bmtPRERBQzFFd1NUSlRtNmVNU25YdjlMOXFTV09JblZtRWp5bktDQjg2blZ6?=
 =?utf-8?B?K1NIY1NTaGJ2bmJYQjE1bktuSU9Ob3Mxa014eUJDTmVJbHliK2VpMjJRVnlZ?=
 =?utf-8?B?czY5RWlLUmczU25JNTQyYXJxYTFkNUtJYXBNbll6U2RqNW54bnJmbFVuSXd0?=
 =?utf-8?B?SWp2ajRRcGU2dlVqZXZUUFJyemoyY3ZBZ1pwKzlvMXRaRW1HMlF3YnVCK3Va?=
 =?utf-8?B?cDFaS2ozeEQ1dktDODFKdzdoeWF2aWlzWmN1NnRHNEFlZTkxVEcyd21MWkV1?=
 =?utf-8?B?eHk4bU5IU3dxUno5K1k3eUdsb3pnZWFtOHU2OGw4NXF3QW5zdndTUDFUSGx0?=
 =?utf-8?B?NkNiOElEaWd0MW5QYnBqaDB3bmhnUUhmdGg3OWZxdGJRMVF2ZUVxeGRMODkr?=
 =?utf-8?B?bGlMaWYwNElwVTFWL1Y4YmMwbHVkUk11SkR2cTRxNjFmOEw1bFg5Wmo2TVRF?=
 =?utf-8?B?WmJpZytCclp6TndEZ1U5STdlVkU3aVV3UTVaNzY1NnlIZ2dQWnk2NWU4NDR1?=
 =?utf-8?B?UXdOeUFwa2dzbE11V0kwQWt5RHU1SFJsUlBYK2FZVWRzWkY1WWFsWVltY2Mw?=
 =?utf-8?B?Q1lqUUtDRk5XRU4rOTJDQ2JVQVIrQ0xKYi9NWGY1K1p5K0wvQkt3VU9ZMU11?=
 =?utf-8?B?S2FTTDhvSm1mUWR1dDNEYXkyUXNPTFFsbFdLM0FrY2l2b0gvMGorMm5CTlBq?=
 =?utf-8?B?WTcxcjRFc0JHZERjdDk4bll2KzBKa2RJUUdtWGFmb21wbjBVQlUyZ1lpR29J?=
 =?utf-8?B?UmhZYjBRQlFDMHlUSzQ2L2tFNDJqQ3BwNTZYZURLK2dPSmhUNnlKaDVjVG41?=
 =?utf-8?B?anNXL0hvY1FXWHdQRTkxejAxbGFBVjVNa1lCYU1BTGFlZGRIcUdKcUc4RUt6?=
 =?utf-8?B?dDFQKy8vUUpJMFdOc09TalJzQjhlYUVCdFNCSW1xYS9VQ0gwSDZqUG10V1NF?=
 =?utf-8?B?M0R2WUNZWWQ2dWMyZTJYQm5xSGVNN2twUnN0VG0yVWxObTBnQlo1OWxSaDdC?=
 =?utf-8?B?WlpFa29NdmxBS3BsTTJXWDNYZjA1SHRWZWpEL0Y3Vk54YVE4MitmK3RoL043?=
 =?utf-8?B?TWNnemF0UTJsLzI1QUwvdEV1ajdJOTJWLzVjV0JWY05ZbkNYVDAxK2NxWlpJ?=
 =?utf-8?B?Smk0Z0RId0V5VkdNb3UzeWM0V1lIRFZZTUFTY2l5VUVWTWI1TUZ3eENZWFJm?=
 =?utf-8?B?cjIwbVdmWUpSa09zNk5tOTM2YTVRa0F3alluMEREVXByaWs0UGxGcGFpcDdr?=
 =?utf-8?B?SGN6ODk3VVRSZjdtamxiNDN2ek12Sk5sRy92YllCSGVNSTBWcGc4eEx6Wk9l?=
 =?utf-8?B?SXc1TExxYmU4LzdKenNzS1lIbU5kb1RBK2tlWnB3alNhZm5JQzR4SUVWWUUz?=
 =?utf-8?B?U3VvSlB5TVpxV1pLL2dtSG1qczMrTGN5UEZXMldueXhUbUkxaVJjWHhUcHJG?=
 =?utf-8?B?UERYTGRhS3k4ZFQxcldJamxiZFBrNlRBSVpzbUM1YmQxVlFqaWpqNEVJd2Vr?=
 =?utf-8?Q?E4N3lDKXpxbOvLmL3czhy58NofwR6TIugwcnSBEUsyXQg?=
X-MS-Exchange-AntiSpam-MessageData-1: e32z8AU+iBQdVA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1bd7fe-487f-4fc9-f5a3-08def84eefdb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 08:51:44.9896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y20eDm641UnVHXXcIAgiqy1/eK9g9BA73dKPI+jgtGrSeMczVwEuSS2Ou4l1xvs9dlo6vUW1MI+3NpgqIoOVKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519
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

