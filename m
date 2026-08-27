Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5739CC61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:30:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88E8F10EEC1;
	Thu, 27 Aug 2026 07:30:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="gvs0VHyP";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDBF110EEC5
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 07:30:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rS0VN+ZpxcMFWXCT82CaT0DCfvnp1DYb0jEMkSpKpZa6YPzXgXJzTT9ZQsSAX9KFQaP267cLnKHSSokeAJA2RvOFHw9NuIotalC5z9+/V+F2zGy0EHfEZ54mI+jkACIxSTA/C8uJqunn4dQEBjpdmupCW49pPYWGRWbnU4hYuNMTldEJ5HIDeitZmOSUxm6yciF49m4IFKNgSONxd4Aba9pf3/wiwtHyeLoelTyqQ2gRLDOKAlL3+XIpBO7AmzeEkImoyasnJc1lMxBiLqdH16/xcpuCSw6vAwhm5+r+hPRURgsKEWb/CNPBvAQgLfgzuGWz6HifvdTKZsBL/RtF7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fKWG8O02Uz5mDQ/qYKA1kszylId4ZueHj1l4N6hfl0=;
 b=U5KwvkmpODvs3BcP7SCIHBly+fkE9FP0ckIlVvt2EW0zA1rpfWNuECWDMrX5C17LlCQAvga551QjCi9Uf5A2C7Lkq5P2/Aa0q4qIc2+X4Te1R3lCViRua1cqj7j/86TbHCFIr4o3AUec6uAOlTj5xbtQw5hcHE9SzDhGKODEomt93eX6cipYpx8FwmGCyPau+TMnPxpxz7/TM58a3r3UHp+9tZApdTd86CPyHv5/oSBK6OWR5m+2g3Dm4QuS399jG9kUAQRilFP5DY2XUcs2mGhXd3uAwqyJQrR6K7NlSCVDBwP3fFUkegCnQ7l5s4ld/kdoriubRuoDCJii3nDdIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fKWG8O02Uz5mDQ/qYKA1kszylId4ZueHj1l4N6hfl0=;
 b=gvs0VHyPmc/0xzHwGjiSqFNumvmeeQhujoeGTRDKRhq7v//AA/IHnpG2NBub9wt3OvbEL0K9fF+Wo2J+3usAyouy88Hk+dmrk2nk/hn99c9+inhJ8Bp9ZGNdNF3vAloEIzUQQOLBIrJnPIK7uSNrron2AXtG+O5ReD6tzhJRPTSgovt6QjqeKY/2lmjEuE2OfqE5KsveR1/bV1VeBXX+rybKiGoXOM2cdfOdO4MncGgPoAydshNIwTcZLewna6tKfevQBYg9tGcJzhwT7qjmnT0aCnEF/Aw4lXEhgCaE8EXEgcpk4psS6e78tFM5JsQNu7SBkVjWCv9N5G4LJRM8gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS0PR12MB999081.namprd12.prod.outlook.com (2603:10b6:8:2ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 07:30:21 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 07:30:21 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 16:28:29 +0900
Subject: [PATCH v8 01/12] rust: bitmap: use function-level cfg on kunit
 test
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-chid-v8-1-bc74c77d0214@nvidia.com>
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
 Eliot Courtney <ecourtney@nvidia.com>, Yury Norov <ynorov@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::6) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS0PR12MB999081:EE_
X-MS-Office365-Filtering-Correlation-Id: 211fcf78-a37b-4718-9e39-08df040d0d03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|366016|1800799024|376014|56012099006|10067099003|18002099003|22082099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: RcTX1vf2kOL53qH8NQR+RK+2WUzM5ZjVJU6wtptjlkZzpwiYTYxVyi8587vhbWqFZsvCdXB8/EszP81kgWGaFPiu4z64MRzN09ElGHBeNKFZwLFXny3gNMQUDOG51Nso6nSZtw2172D2MBGDDcdr0MjYuyoz7jjOyUPJuwg2o/5grIAtiw/RhzG/SKySq7uqqZvGNVMEvMMWndyebOz7u8YbnsMXfvw3T3Z46x7TKddaOgwnDWI9UyJFxfwuis7fivb35vOsQtplKPWW90QBLmyEKvDql4ZAPOT7hloWyLVE4VO/P16GYsfCpM6JarTGXPo0QbD2xLxm7cHapzvXxmf40czZ2m34CqatDxi+YXNhbxxJGEu7n0yXtZ4Z/JAq0NgHD8bHjUXwR/A/2gvnT7q0g89gcB+DykCoCGFINmLNP7AD01Pgzy/flN5BeBDxrrxTA3G5qWI2+pcThhVrZ8rKnQnnUQeodB42kQVJ4Ovc1MWkPYGLRKLCjJtAAy+J439AvLLq6j4XOMOSezXhEcaAud/ppyxPKS9F3HUNM961lFL4g9WrhUUCX/iv8Ad+LfEAoBuNVMVj5di5Mks7ZVx9lxU0CUpASSkjyO516zQHIlwyV8DHdkTFImy0AueykFQ/ZZej5BX4b3uM1dyjqkK8/qpPVDmfksGFN1zC2ddAwOxDDR0uD48iGrNT9it6A+fyRsGcKojcYw1lI4j/Vg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(366016)(1800799024)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGljNUU0bFFJODM4N2ZNUDRIQ1YrTlVaZmhGYUdDZ2h3M2hmR29oL280UGVy?=
 =?utf-8?B?YUF5b2szdjBsVVF5ZGFTWjA5N3hmVkRuWmJscko5bmhqNlpXL1dWK1BuTWxX?=
 =?utf-8?B?Vks5UFkvczJNM2FCa01ockFjdjNuZ25TMlh6N1U0blFLbTA5M1lXK214SG16?=
 =?utf-8?B?em5IdTg0WTcxRFJuWnd0L3NxOEVWWVluVlJ0dVA1SitaUmxVUURRQ1NmVlhh?=
 =?utf-8?B?MWhGR0F4aURYK3lTbWI3dExIZmxSWmtlaEx6TjNmNXl2ZDRzVnJVUjBZRmlU?=
 =?utf-8?B?Wk9OMEgzampNTGN4enNlVVEwU0YrbDBDdU1ONG01cmp1WVVMTmJHVExVZXlz?=
 =?utf-8?B?Z29tL3dIWnZUVlZYeFcvTTJzU09YMWdzbmU0U3V1QjRTWFMzQ2s0MmZPWkVS?=
 =?utf-8?B?bUJzbjZwNXZuT1h3ZmFkK2tGWWZSMFFjaExSYVJCYnFGTFRxaHlwOXd5Y3VQ?=
 =?utf-8?B?NXBMWnFaWmgvWlNEK3MxcjJleWpSRGhYVDhZMWs1N2d2clZ1TUxlb01FSDdx?=
 =?utf-8?B?c1BnZU9Mci9jYThmS0R3Y2JWUGlDeVhzeWpLZjQ4RndoRzFXcGJOeWtvb1Z6?=
 =?utf-8?B?WVBEZnVnZmZSSXJzbjU3UEZ4NEtWYXB0YjZVMmR5alV1RGdVOWVmUXpyeXBH?=
 =?utf-8?B?RUpzNFFUVzVldjdvaU9jeUV1ZnhGbU9kRUhPb2xlZmxNak5qQmNXZmVtTHNK?=
 =?utf-8?B?WGtFZHRVeHZ3MWlVcHFMR1cvbExKeUl3Tk5Ea2ZheW81WmM2NTdLQnlTWjk0?=
 =?utf-8?B?K0pDSWRva0oxR1BieGFtSVZ1LzBJWFhRL3FFaGRoemNUajZZUGFxbkxyUzIx?=
 =?utf-8?B?VXk3bCtYNmZYdUU0a0lhbXhkU2ZaaW0wUmkwVmhGaGc0aHMzdnVFNDNQN0pk?=
 =?utf-8?B?U3RWRDFpOW9OSjFtOFhtTnRNNGpHUWRkWmJFaXI3V1hiV2dTTXVhWStJeHo1?=
 =?utf-8?B?S29vS3ROQzBkT09wcXdzT2ltbUs4WnNwamZ3Q3E0WHFHSC9MSDFRajFod1Bh?=
 =?utf-8?B?MDJNckR5alVGSjgvOVhXMk1wb2ZXenNLMUlldG9RMC9hTFBRajN6WG5nbEZL?=
 =?utf-8?B?Um9EVnkxWFc4STY3TjJYTndka1R6T1l5L0dIeGdqMUxHMmZLMlR6RDYyVDlv?=
 =?utf-8?B?NVFIaW9BeWxSUG1YTE52N2NnYjc0aGY5cEczd1Z3dlNMUlNZeE9iQno5U2lr?=
 =?utf-8?B?MkpGZkV6ZEJ4c3dSUHJ1ZU5uRjRYbDErWERDdE8wVTNHYlpnMDhYYUJYaWpS?=
 =?utf-8?B?amtweHlKVzY0SE4rdHBlWFdiOFZ4RXZNRDVhL0lEZEp6Y3R6ZXo3aGJoNktP?=
 =?utf-8?B?QmJTa05HZGZleWEwektjOWlHWVRQUDJnYWVMZWhLMXA5SmlWZkhXVy8yUVQz?=
 =?utf-8?B?RERRTS9nMWZzM0JsWjA1OGp4aUdrVE1ReGR5L0lkd1Iva1JDUmYvVjJBdHBS?=
 =?utf-8?B?cW1pU2x6YnppeC9uVkpjalhYVk5QaThLcXpGMnNTYlFUT2M0QXJ3d2dvN3hM?=
 =?utf-8?B?ajlKSGZmcVRmay9RK2FrdE9aYnp2WlZyZFJ1akd1S3dJUWRrc05hVm4rR1pC?=
 =?utf-8?B?Q3kwZ3QrZmh5NnRBaVAydmYwWFJ3aE5aSjVUWkZjOFE2TFlTL25CTjFvK1Mz?=
 =?utf-8?B?STVabXpNOERkdUhGMTFselpCeVFESjVFQTZha2ZRYzNscXNEeFl2WkxMN3o5?=
 =?utf-8?B?UjhISTlJeWEyYWRQUUNxZ09qZ2ZFR01pbnJsMkxvcFpQT0Fkb2hzb1RXVDRz?=
 =?utf-8?B?VnY5MWJOdm1TcnhYU25NWmlXWTZjQ29JVk1VMEFPeS8zZnRlNUpWbVI5d1oz?=
 =?utf-8?B?VVErZ0ZqVjJGTDV0Q1dyeG9jVkcyUHJsQVRyRHN3d2NuWW1TYWpKQnBQSkFo?=
 =?utf-8?B?ZnJJdGx6MGYvOG10M2x6NkxuNHJDVFVmODBqK1lkUFFYRGdLUW9aanVnK0Rn?=
 =?utf-8?B?TitvM29DS0V3QnN2d3lWaVZZS0ZCbzFwd0tpVzBLRCtQdmdEL29DY2s4d1g1?=
 =?utf-8?B?VWJNRkFURm5zSVlsbk1TdmVHcXArWXlIRUNFOU9VSXBwbUduOHFpR2xXb0VR?=
 =?utf-8?B?aklZYm5ZWlJHbDBEbE9ERUVZam1MSWdBVmQ5RWk4ajE2WHNvejV5STFTOTJu?=
 =?utf-8?B?dXRkS0UzRnZUZEtya0oxS3RpL0p6NjFaTHM5OGR1a0QvQ0tHalplQzdJSWFS?=
 =?utf-8?B?YUdvcTkyNSt6emY2UUhXSUUrTXZoR3FqV2oyU01Yek5QRWdnNTRBMUZTQzZU?=
 =?utf-8?B?RWtkSUI2dU01VWFtazhlZ3NiV0Joa3ZncGVrd2xoejZqOEFaWkNmQmt6Mmx3?=
 =?utf-8?B?MXYwZ0hKaGkxYmtOOUJ3UE45RDN4WG5ESmp4bit1bCtzS0pMSm5PWVQxdmZ5?=
 =?utf-8?Q?O9ir0X50o+2+ttUJg745EDIlpRb3U1jsUH5FUqAJRdWN0?=
X-MS-Exchange-AntiSpam-MessageData-1: kanD7/eQfVbpow==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 211fcf78-a37b-4718-9e39-08df040d0d03
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:30:21.0458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvcIj7rKAC9Yfcc/cXDJWRz5UVqueWbHomPUZlCvXZMpMdgdwDTKMJuRK1dRE8mHBBJZz0kTOxSe8j38MI0UpQ==
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

Since commit c652dc44192d ("rust: kunit: allow `cfg` on `test`s"),
we no longer need this workaround.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Yury Norov <ynorov@nvidia.com>
Reviewed-by: Burak Emir <burak.emir@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
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

