Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF35CC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:19:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DCDE10F766;
	Fri,  3 Jul 2026 10:19:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="GnFdyaQ0";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011046.outbound.protection.outlook.com
 [40.93.194.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AC0E10F766
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 10:19:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLj/6fzGvZyUmVYTN1LpVvnS4TKFKDCmsWsJ5bZX7X3qKux3fljbqB+e7WwZ6gfRHRGFfMIHfIDzXRDglDYppEeCh+ayUsylsFTwMVMfCIqL8QrCFAS2f2jEJ5X4hRHKvRtIy5j518ftlnx1bUWXBpYk9lFTgZEqJSc6Vx8qmy1NSCNSnMi0LB5aW0Tl7lIEYqws7HA11S6IwJN9NWWTbsz+8se/SRypVMpl/zj/KJ5lSTe/y2ypRs463nivB7y6/0X9WmAB4yA8DhvjrdDu8af1Exi5SNdGrU8dum2mQBEgyV8AaIeiETEDsLGTeBhPvgb7fG8sOrTt2ySfXEC+dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkQ5rXqoqtxnlaqcbr2ino/5hvkP6Bi7+Ixi5Ko8rrY=;
 b=AAfycZioeGo+9oVQlUYrPi53b9klI3cYxXFfrOQ4/oqkDW0AvZZsIDmDgRr4DUbdlhcEDOq3h8M6P+ek9868u96CC02vEp50hmpdgDzcwiVqnIOToPOxQuvmzkf4xZM2F+Z9E4cFpZB9GU3gT9boV3OZ1dZ2eSdK86NatVd8EbrF4hNRIj8h3QToPNGOdmYm7jOcQb9/35a92v2rK+59LLL3CYYAdVTVcyi3lklkG3kg5Yo+7bVryI/jGfuS1fjcvVeBUdXp9zW0EDff1reQmisBJowAWLxcGFg4zdadruS9i9cRFr0Kr9swopgUbLSg/OhwVCBzTORS3I1V75nbUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkQ5rXqoqtxnlaqcbr2ino/5hvkP6Bi7+Ixi5Ko8rrY=;
 b=GnFdyaQ0paWi5g6/poPbsFIxSJXHLdZfjl9ioOoKCRUBpG4+MQfthQW6cnHp5KEzdcQi58l8f4dpMVZHCG5kTG/adpKgrpiXSwYvJ1gX8KRP3+AQgJSu53elsD21kMaUmmAFQw60nERUMDtAThFhS1AGfJWscsAEf7vqzQYXwBvroWB4tVdWUS9nSfmGWhRz1nFsOJBlTNCgeFoC32JLDgZpwkoclpCqeP9UsdoGGZVSK/+f2mb0B9xAkSD+Q69Zpx90rSmL3x0c+NCuaIfSNfUQZq8TJPEPBJWYhQgfFfICSUayvPXK7dQGK2oAAx3k1AOHLTv4FrK2CxBMhsHGJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 10:19:24 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:19:24 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 03 Jul 2026 19:16:04 +0900
Subject: [PATCH 1/4] rust: bitmap: use function-level cfg on kunit test
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-chid-v1-1-84fe8259e46e@nvidia.com>
References: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
In-Reply-To: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>, Burak Emir <bqe@google.com>, 
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
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0178.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::9) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: f33fdc09-20b9-4fe3-607a-08ded8ec8e50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|23010399003|7416014|376014|18002099003|22082099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info: axql83YMuqwSR/8a1Tly0Q3T6Svrqo11rnEmc+k/dCE9FU7tSmRNuIWcvD4UjcTTHULJwnswPTJ4oxoc+3Zh8zprqS7x7YO+vKqLU6xkEcDLt1KaxW+Fk56xAt/GebVgvxZDTiicXfHWSZYvpgFAMo1qxG3sgj4RRlZ7K6eB4pGb3yIij6aU/J5frqwsJKIKrGO4MYyh/AS+8xRugf56Sr/voDYKnay2JI5xyV1GwOemSSabExPm70YgrD2JkyJiWwfmMZTllW7EJv7DP1viCpGOilxvSfmGP/qqDDWKGFjTX/T2V9fiPNHhSslD3tmz9p8x6dIvEPARWsqWRSpyPXjbiU838lwc9zlr5KDEtZ74InEdKsmpFtnVfBg1wDnSPJq+sEx7LJYTrHkzgWtnygOQqmbGONobM/bCZ+jz/v+kIXriGbNMxDqd0GH1SuutAJ4rBVP7DxjYfWC75aQCgBdfw9vtw9THXYthxVt3f4GBdz2myUUH63vkDIFPWX2GP0Af7OgElAqdb2Fl0HU+MuRIZWHdGmVCSDBzWI3Sdz7HPq0TZhDztKuKf+DdkCFk4FuQKEB86P0qpCekSkiqj4QGM/iFqrTDukMOOQTO+0s8PkTa2znTZ0FiIkAfCqZpXhYmZ4n/AFWbGnyEWI09T37mCfTtVNE6qx25ShJtY9IIfKKIupw7MuyB3qXvp+LY/l/Qkq2qlRequPURKzXX8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(7416014)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z09hUWp6eG9xdnI5VFg1QkU5TGRGYmdjcXh2VUd3WkNQZENvbnhYOVpKK2Mx?=
 =?utf-8?B?R1pYT1NBZzcvWjhpcm9ERlM5UnpPUFV0TU1zMXkvNDhqRzRVRU04cmRnWnFO?=
 =?utf-8?B?SXplVVNqMHB6OU11UDBIZzNhUDUyRWNzUWJiRWZ2dDBrYlJtR2tEa1NReTBH?=
 =?utf-8?B?NEFtZEtoS1ZWQ2s1bDVrNzIzOWNOcENLQXVYTU9PZ0R6Y2QzcmZVMVFYV2xC?=
 =?utf-8?B?TmgwTkVCam1aU2xJanBjWmVoQmRLK3MxUnYxZ2Z2SVcxako1SlpqZDFTRkE0?=
 =?utf-8?B?SzBuU2hMa09IU2xVUnIyYzdKMUw4VU12aFcvcks5K0RqQTFSMUJ2amhITGhJ?=
 =?utf-8?B?aVNGaDBucnZDUW1SOFZrM1dRTW5kdzhQOFBPK242Z3poUkVEbEUzaThtR2NU?=
 =?utf-8?B?bHN5YVRidDF4SjdyRmVZS3F4bnpxNkl0VC9YZE5rTmNIYUFuaEJ2T20rTThH?=
 =?utf-8?B?SlRTbEczU2dTVXdQYlY2S0kyZm5KTE5LWUFMdlVDL2I1Wjl0Q1B0YzN1NFhK?=
 =?utf-8?B?N250aTYreldzaEN2L2pyVk9GMDJ3ZDRHRk9hRDFHZ2RtN1pFdFYrVkVQR1pX?=
 =?utf-8?B?ZVNXeEt0clIwaTFQcS9uTFoxeGdwTVBtRXlUWjE0T05yYzFTSExkcDJJK2VO?=
 =?utf-8?B?UVFILzhxTFpXa041Snh6V1BkdHNDU2hHakVpWHNHUkdWai9yZ1FqT01vTmRG?=
 =?utf-8?B?RWxTNFhlcXRieGtzKzNGamprMFlWSVRtNkl4eHR6SnEzdUtMSXlsWERiU0lv?=
 =?utf-8?B?OEU5S1N5WE1vRGdGbTJHWFExR01ROSt4SzhUeFN6dG12eXcvSzYrZ2VEeTF4?=
 =?utf-8?B?MWJzSW9qYkpOK3kvUFROYnhzU2txdllCVVN3TkhYOTV1bmpVbW1Pa0c5Wmk0?=
 =?utf-8?B?QzVtb21lR0FFQWxKQ2dScXZtMVJyMmtSVDQwOUI1UTBBTkhjcS82TXpCQUVH?=
 =?utf-8?B?MndENitpZEFkNFpDU0dMbFp2MmE0ci95eG1FNnh5NXhnbDRCd2J5WnhFbU5l?=
 =?utf-8?B?Mlg0VUlsTFM1RVNRcURkZjYxOUdORkMwVS9jZ2RpeWFPRzZ1Qm5DdmM2dnVV?=
 =?utf-8?B?QTkzN2I3ZUVteGRldUUzVUNTUC9IbWV0d3Y1Rk16ZW5hUVVvdW9zVGJuZURH?=
 =?utf-8?B?cnNTU0RxeTFIRnE1Q0wrL0NESDBjaklEaHJiOUZKMnVZQWd2N0l5aE5EZmxO?=
 =?utf-8?B?T1RERWlDcUh6bVhsckxzbkpWMkt5OTRGSWdwaGIyak1ScWdBVm1NSTUxL0h6?=
 =?utf-8?B?Q3FJeDRQY1QwWGhmajZoYnVic1pXOElJVWIzZUQrMThkT1M4b1VKc09NQm55?=
 =?utf-8?B?OUpjQkJ5WGRKbTg4YlhVYm40N0tQRTAzSWtSRTVQYzRRcG1ZamVQZGMydGpu?=
 =?utf-8?B?UTBpc2N1N1ozeCtKUjlyU3luL2EwUGFlNDk3SXJNYWFwL1hQbExYWEgzWW1N?=
 =?utf-8?B?UllwNzBDbldrNnoraWR5blhHTTBZZFcyN0NzSTVwREpQNldGMHlyUmlPTHZv?=
 =?utf-8?B?QVh0aDlORjEzeTJ0TzFnVWZwU1IyRjExeFV3WjFoMEI2UVZhcWVQWDZyenk5?=
 =?utf-8?B?NFFEZDhsaU1oazlQdWxtaUIxd1F2RC9WeDYxZ2p4dW1YUndaVDVBZ3V1MkFV?=
 =?utf-8?B?SXh3YzNrbzVvQ2d6QkJjYzUxclpNUEEyUTViQ1pZdTNzbXZZay82dnhJNW5i?=
 =?utf-8?B?T2JEeTRLUERVQUoxZTVjQk9La2cwZFdWVC8yVHpIVnhweFh0ZHpRWHdVdVpD?=
 =?utf-8?B?U1gyZzRvODdHWnhqQWNmVEl4MndHbldGWTdjYk9ZWDdJbmcxblhrUEwwQmM5?=
 =?utf-8?B?bGFNOS9rYnZDQUVQZWtwQW5NMXVzbGMvcDRiTC9hY0V4Y2lXTkFOWS9LQXcy?=
 =?utf-8?B?OGRZUjZGdzY0eU1ZQlYzcWVCNGV5bWkvNEUyTFJxK3NydXNDM0pacXVtelJW?=
 =?utf-8?B?bTFtQXI3em95eEpwMVZKODdJQnNtZ3ZZbmVNZVF3ZGliT0dvVWhjQWJJL1JZ?=
 =?utf-8?B?VVFaV3RpbVJDd0xEQ3J5amd2ZXdMeU5OZnhVSm94SmhVNHl5QThMdE4yRmNX?=
 =?utf-8?B?QndxeU5NWjF4Ynp6bXpEeTkxVFZhUkIwSDIxcERJQkE0WFNQMDNsMERyUFk4?=
 =?utf-8?B?ZFFQenBBVmN0RHMzWG1XQTJUaGdDZXhwcTR3SUlURmtxd3doSnpXeHpJTUZz?=
 =?utf-8?B?ZGkyZVZ4YzhhUlZBS2FXVWt6dHp3MHFWZWJwcjRTdUUvQTQ1blNQbWI3azhk?=
 =?utf-8?B?N1EzZk9SR1ZIZDExM1c3blViQXduSGM3UWg3Y2RWcVNwM2srWldMakk0RDFs?=
 =?utf-8?B?WktDYTFnelovNlAzdDhtRyszT1MyQklnTkhQdkR6bWY2dm9ZUTVDUmdiUnZS?=
 =?utf-8?Q?+dmFx2u2tRR8vS7Mxa+zlpwvFITWM0l4CM/7YiHf5b4Cl?=
X-MS-Exchange-AntiSpam-MessageData-1: K1r2W6/OmF9VAw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33fdc09-20b9-4fe3-607a-08ded8ec8e50
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:19:24.7215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLA6nPnom1Tjxaes/MIWrVI/m5/ltBmO6QBkSxe+Z4+C+e/t0Ci0lkeBqoFZnyLNdyol0uW+K0dB08rTJrePGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326
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
2.54.0

